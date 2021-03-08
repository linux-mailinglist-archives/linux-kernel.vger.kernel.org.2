Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1948330740
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 06:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbhCHFYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 00:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbhCHFXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 00:23:52 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DFFC061760
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 21:23:51 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bm21so17679135ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 21:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4vk8NjZWUWMSC21zZsC5XhaD9emmq9PjiDCa5A5wz7c=;
        b=dmfnCfqpjw4sbFySyQCvKT/bnV1gdfJE//RwUw+/gEad1qlgdXYzLJo6gW07X7BaWi
         fOhjzy+D1McnNY1FlfUUZ2eVsZX4PMmPnHHnfvK/QcHbludMlyF7P2E7NSHAbcqrf5gm
         aJ9t9GCUBUf7zQgOZPuMx/DcsYpEXNWI2O0bdl6RCMydWb7xFXo4rl9dJRw0Qhj5rYcP
         2LxgpXUh4l+i7nWNKqBaapAousEIDyzh4EFeoGR7B+xkGxD2oRsrUJHseSmx3kgzJrJn
         DP5PrPXZJVUI/wFIKhOVGuOZLzXVvn/Osj8paaq9+KZ4pIoYwDefy+eJcO2VWrZ8JUde
         amxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vk8NjZWUWMSC21zZsC5XhaD9emmq9PjiDCa5A5wz7c=;
        b=n9qllvf4pRJUqgiXpNwMtYFU11b2yEcKWfJIs/M3OH2ukR13GHbhEmI/TcGq/pZmbN
         e4JUbNDdywOmRA4sy7W4Ntuv0X81zNb3kQpBkR8UgwMIcwzbvW+UogC6qWbkrINyr7iJ
         s8hmc0J2X1ghQVjP0achGdYSdaW5FkFXrSKQsH0H59RjvUPVD38yGnpTEhTP/gcfiK0n
         P5XiaZf/015xrZXotJ0Fs8bvCxESN7xBVG4XzMK5Ji2aI9k2yjI96pNnAPTSJZvmovVQ
         lpQccagACfYWn+HFlITi5nVSNWAkHgdQkzt4s/f9Mx/xahmAnSqRqdWABoVTxehWWW+z
         h4IQ==
X-Gm-Message-State: AOAM531MjekYDLt9MLpTZ8K18/Lm9KpCxrVnOprumVIdlIt/mJXjz/Q6
        xOJhsW5R6o41Nco9T16Wh/7vz+d90ITKB5RclrLX9g==
X-Google-Smtp-Source: ABdhPJxP4YeKftw4Lj6ZQkw1k0hTAM+QWLRj2zfFwlL8QUnJAuQwAg2fpXUMBBNPLZZXJqNMxEP+ZhTef3D9nTDkcKU=
X-Received: by 2002:a17:906:1bf2:: with SMTP id t18mr13449685ejg.418.1615181030278;
 Sun, 07 Mar 2021 21:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com>
 <20210208105530.3072869-2-ruansy.fnst@cn.fujitsu.com> <CAPcyv4jqEdPoF5YM+jSYJd74KqRTwbbEum7=moa3=Wyn6UyU9g@mail.gmail.com>
 <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB29207A1C06968705C2FEBACFF4939@OSBPR01MB2920.jpnprd01.prod.outlook.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 7 Mar 2021 21:23:47 -0800
Message-ID: <CAPcyv4iBnWbG0FYw6-K0MaH--rq62s7RY_yoT9rOYWMa94Yakw@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] pagemap: Introduce ->memory_failure()
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "qi.fuli@fujitsu.com" <qi.fuli@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 7, 2021 at 7:38 PM ruansy.fnst@fujitsu.com
<ruansy.fnst@fujitsu.com> wrote:
>
> > On Mon, Feb 8, 2021 at 2:55 AM Shiyang Ruan <ruansy.fnst@cn.fujitsu.com> wrote:
> > >
> > > When memory-failure occurs, we call this function which is implemented
> > > by each kind of devices.  For the fsdax case, pmem device driver
> > > implements it.  Pmem device driver will find out the block device where
> > > the error page locates in, and try to get the filesystem on this block
> > > device.  And finally call filesystem handler to deal with the error.
> > > The filesystem will try to recover the corrupted data if possiable.
> > >
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
> > > ---
> > >  include/linux/memremap.h | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> > > index 79c49e7f5c30..0bcf2b1e20bd 100644
> > > --- a/include/linux/memremap.h
> > > +++ b/include/linux/memremap.h
> > > @@ -87,6 +87,14 @@ struct dev_pagemap_ops {
> > >          * the page back to a CPU accessible page.
> > >          */
> > >         vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> > > +
> > > +       /*
> > > +        * Handle the memory failure happens on one page.  Notify the processes
> > > +        * who are using this page, and try to recover the data on this page
> > > +        * if necessary.
> > > +        */
> > > +       int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
> > > +                             int flags);
> > >  };
> >
> > After the conversation with Dave I don't see the point of this. If
> > there is a memory_failure() on a page, why not just call
> > memory_failure()? That already knows how to find the inode and the
> > filesystem can be notified from there.
>
> We want memory_failure() supports reflinked files.  In this case, we are not
> able to track multiple files from a page(this broken page) because
> page->mapping,page->index can only track one file.  Thus, I introduce this
> ->memory_failure() implemented in pmem driver, to call ->corrupted_range()
> upper level to upper level, and finally find out files who are
> using(mmapping) this page.
>

I know the motivation, but this implementation seems backwards. It's
already the case that memory_failure() looks up the address_space
associated with a mapping. From there I would expect a new 'struct
address_space_operations' op to let the fs handle the case when there
are multiple address_spaces associated with a given file.
