Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D534466CA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 17:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhKEQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 12:16:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:53175 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhKEQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 12:16:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="255579725"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="255579725"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:07:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="502000107"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 09:07:02 -0700
Date:   Fri, 5 Nov 2021 09:07:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Sterba <dsterba@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: Kmap-related crashes and memory leaks on 32bit arch (5.15+)
Message-ID: <20211105160702.GY3538886@iweiny-DESK2.sc.intel.com>
References: <20211104115001.GU20319@twin.jikos.cz>
 <CAHk-=whYQvExYESEOJoSj4Jy7t+tSZgbCWuNpdwXYh+3zq2itw@mail.gmail.com>
 <CAHk-=whBOXM3mh-QtzK-EQtDEHQLcziAXu07KxU1crUc5jiQUg@mail.gmail.com>
 <CAHk-=whGUxtcL8Z67y4A6_diSmtQdnOq1p_gyBAMzpKD9yk+gw@mail.gmail.com>
 <f3d3dc5d-dcf8-76b7-f383-aed3c942ae49@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d3dc5d-dcf8-76b7-f383-aed3c942ae49@suse.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 08:01:13AM +0800, Qu Wenruo wrote:
> 

[snip]

> 
> 
> BTW, I also thought that part can be suspicious, as it keeps the page mapped
> (unlike all other call sites), thus I tried the following diff, but no
> difference for the leakage:

I just saw this thread and I was wondering why can't kmap_local_page() be used?

I know we are trying to remove highmem from the kernel but the DAX stray write
protection I've been working on depends on the kmap interface to ensure that
DAX pages are properly accessed.[1]  Also there are a couple of new helpers
which could be used instead of the changes below.

I know this does not solve the problem Linus is seeing and DAX is not yet
supported on btrfs but I know there has been some effort to get it working and
things like commit ...

	8c945d32e604 ("btrfs: compression: drop kmap/kunmap from lzo") 

... would break that support.

> 
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index 65cb0766e62d..0648acc48310 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -151,6 +151,7 @@ static int copy_compressed_data_to_page(char
> *compressed_data,
>  	kaddr = kmap(cur_page);
>  	write_compress_length(kaddr + offset_in_page(*cur_out),
>  			      compressed_size);
> +	kunmap(cur_page);
>  	*cur_out += LZO_LEN;
> 
>  	orig_out = *cur_out;
> @@ -160,7 +161,6 @@ static int copy_compressed_data_to_page(char
> *compressed_data,
>  		u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
>  				     orig_out + compressed_size - *cur_out);
> 
> -		kunmap(cur_page);
>  		cur_page = out_pages[*cur_out / PAGE_SIZE];
>  		/* Allocate a new page */
>  		if (!cur_page) {
> @@ -173,6 +173,7 @@ static int copy_compressed_data_to_page(char
> *compressed_data,
> 
>  		memcpy(kaddr + offset_in_page(*cur_out),
>  		       compressed_data + *cur_out - orig_out, copy_len);
> +		kunmap(cur_page);

memcpy_to_page()?

> 
>  		*cur_out += copy_len;
>  	}
> @@ -186,12 +187,15 @@ static int copy_compressed_data_to_page(char
> *compressed_data,
>  		goto out;
> 
>  	/* The remaining size is not enough, pad it with zeros */
> +	cur_page = out_pages[*cur_out / PAGE_SIZE];
> +	ASSERT(cur_page);
> +	kmap(cur_page);
>  	memset(kaddr + offset_in_page(*cur_out), 0,
>  	       sector_bytes_left);
> +	kunmap(cur_page);

memzero_page()?

Just my $0.02 given I've been trying to remove kmap() uses and btrfs remains
one of the big users of kmap().

Thanks,
Ira

[1] https://lore.kernel.org/lkml/20210804043231.2655537-16-ira.weiny@intel.com/

>  	*cur_out += sector_bytes_left;
> 
>  out:
> -	kunmap(cur_page);
>  	return 0;
>  }
> 
> Thanks,
> Qu
> > 
> > In particular, what if "offset_in_page(*cur_out)" is very close to the
> > end of the page?
> > 
> > That write_compress_length() always writes out a word-sized length (ie
> > LZO_LEN bytes), and the above pattern seems to have no model to handle
> > the "oh, this 4-byte write crosses a page boundary"
> > 
> > The other writes in that function seem to do it properly, and you have
> > 
> >          u32 copy_len = min_t(u32, sectorsize - *cur_out % sectorsize,
> >                               orig_out + compressed_size - *cur_out);
> > 
> > so doing the memcpy() of size 'copy_len' should never cross a page
> > boundary as long as sectorsize is a power-of-2 smaller or equal to a
> > page size. But those 4-byte length writes seem like they could be page
> > crossers.
> > 
> > The same situation exists on the reading side, I think.
> > 
> > Maybe there's some reason why the read/write_compress_length() can
> > never cross a page boundary, but it did strike me as odd.
> > 
> >               Linus
> > 
> 
> 
