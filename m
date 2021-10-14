Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0C42D2A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 08:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhJNGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhJNGbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:31:16 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81FCC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:29:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y1so3433380plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 23:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTDonjCiHR5VdjT3SIT3xZlNWorT3RovXMbjVLu/Snw=;
        b=QG8QHDxY/aWCDu/8j+CR8mtArplJ62No6++7x002oKGZWe+9738rpn5kZX9snAEyS3
         Iw1FJkzmWXZRbiHU5CDWuOPK9JsasbQ0DLip8ckjLtSjGi7YnOK4lJ3YYIEe+NpqHdAC
         8eYLmsBIaMwe41WldZlv78xd/JkdyvAXLUM7OK4Rg33kl0iHnM11fbaGDw9iLZiliRF/
         AZnN0y8TtyhIUfWBNaNgnJEocxc/m0+doMTlO1Na3Jl4FDpaQHomOFqFEvisrN/5J2oY
         XAdkCPXWLi4y91Dh4++Pwz/51IYu/5Q3VibTPb+uDvghDKe2GhSn3nSyxdMOcy0sXV8b
         54hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTDonjCiHR5VdjT3SIT3xZlNWorT3RovXMbjVLu/Snw=;
        b=DBMcIwY6bAuwmrv4kIRRKxhvtJAq5B8OPrCAgMrx8vp0uJtmmy43bvcmEyW9y0qQ94
         377kvVnVyk4lMemaa3FqqRIrjU9nQg7RV0hB1UmPngV4E0X2wREFNCu6rt6A9TrCWS6a
         hkYaScK6wjWOkLYoJt5kBhbABXpF4EgeqKVddF8wvJozrgOz3pRSoCDK669Wc7+XFW+w
         8rnVNYQ/ItQCtocALCgZ5vTfVCDHz6P137N14VgPoopiihffCn/ui4sMN4vDME1IdgZp
         nlxD102rVv6E+0xpXbdhs9Qm1ba8Q3uo456fKzkmSFSkW9pBJS+52kYz2PYv3sxNUR+4
         y+6g==
X-Gm-Message-State: AOAM532pZWaaTt/FOSdgNPdwI/5mjuDlYarwT8EBPK+UxeeeR4SSQykN
        bOgZWSb93deBRsv0fkeop0c=
X-Google-Smtp-Source: ABdhPJyJHC9ZQn6PejMGlj1lpeEoIwbCGWozUpW6K8cQoYYPNvq44q33xwZrfxQfJXbrM4yYR/zryw==
X-Received: by 2002:a17:90b:782:: with SMTP id l2mr4280372pjz.190.1634192951373;
        Wed, 13 Oct 2021 23:29:11 -0700 (PDT)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id h4sm1372461pgn.6.2021.10.13.23.29.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Oct 2021 23:29:11 -0700 (PDT)
Date:   Thu, 14 Oct 2021 14:29:05 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com,
        zhangwen@yulong.com
Subject: Re: [PATCH] erofs: remove the fast path of per-CPU buffer
 decompression
Message-ID: <20211014142905.000019cd.zbestahu@gmail.com>
In-Reply-To: <YWfLUEQWSY3xpFJF@B-P7TQMD6M-0146.local>
References: <20211014055756.1549-1-zbestahu@gmail.com>
        <YWfLUEQWSY3xpFJF@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2021 14:16:48 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Thu, Oct 14, 2021 at 01:57:56PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > As Xiang mentioned, such path has no real impact to our current
> > decompression strategy, remove it directly. Also, update the return
> > value of z_erofs_lz4_decompress() to 0 if success to keep consistent
> > with LZMA which will return 0 as well for that case.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  fs/erofs/decompressor.c | 64 +++++++------------------------------------------
> >  1 file changed, 8 insertions(+), 56 deletions(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index a5bc4b1..9905551 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -254,7 +254,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
> >  		DBG_BUGON(1);
> >  		return -EFAULT;
> >  	}
> > -	return ret;
> > +	return ret > 0 ? 0 : ret;  
> 
> How about just updating the else branch of "if (ret != rq->outputsize)"?

Agree.

> 
> >  }
> >  
> >  static struct z_erofs_decompressor decompressors[] = {
> > @@ -268,33 +268,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
> >  	},
> >  };
> >  
> > -static void copy_from_pcpubuf(struct page **out, const char *dst,
> > -			      unsigned short pageofs_out,
> > -			      unsigned int outputsize)
> > -{
> > -	const char *end = dst + outputsize;
> > -	const unsigned int righthalf = PAGE_SIZE - pageofs_out;
> > -	const char *cur = dst - pageofs_out;
> > -
> > -	while (cur < end) {
> > -		struct page *const page = *out++;
> > -
> > -		if (page) {
> > -			char *buf = kmap_atomic(page);
> > -
> > -			if (cur >= dst) {
> > -				memcpy(buf, cur, min_t(uint, PAGE_SIZE,
> > -						       end - cur));
> > -			} else {
> > -				memcpy(buf + pageofs_out, cur + pageofs_out,
> > -				       min_t(uint, righthalf, end - cur));
> > -			}
> > -			kunmap_atomic(buf);
> > -		}
> > -		cur += PAGE_SIZE;
> > -	}
> > -}
> > -
> >  static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
> >  				      struct list_head *pagepool)
> >  {
> > @@ -305,34 +278,13 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
> >  	void *dst;
> >  	int ret;
> >  
> > -	/* two optimized fast paths only for non bigpcluster cases yet */
> > -	if (rq->inputsize <= PAGE_SIZE) {
> > -		if (nrpages_out == 1 && !rq->inplace_io) {
> > -			DBG_BUGON(!*rq->out);
> > -			dst = kmap_atomic(*rq->out);
> > -			dst_maptype = 0;
> > -			goto dstmap_out;
> > -		}
> > -
> > -		/*
> > -		 * For the case of small output size (especially much less
> > -		 * than PAGE_SIZE), memcpy the decompressed data rather than
> > -		 * compressed data is preferred.
> > -		 */
> > -		if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
> > -			dst = erofs_get_pcpubuf(1);
> > -			if (IS_ERR(dst))
> > -				return PTR_ERR(dst);
> > -
> > -			rq->inplace_io = false;
> > -			ret = alg->decompress(rq, dst);
> > -			if (!ret)
> > -				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
> > -						  rq->outputsize);
> > -
> > -			erofs_put_pcpubuf(dst);
> > -			return ret;
> > -		}
> > +	/* one optimized fast path only for non bigpcluster cases yet */
> > +	if (rq->inputsize <= PAGE_SIZE &&
> > +	    nrpages_out == 1 && !rq->inplace_io) {  
> 
> How about rearrange these into one line? (it seems just 80 char).

aha, seems it's. 

v2 will fix them.

Thanks.

> 
> Otherwise looks good to me.
> 
> Thanks,
> Gao Xiang
> 
> > +		DBG_BUGON(!*rq->out);
> > +		dst = kmap_atomic(*rq->out);
> > +		dst_maptype = 0;
> > +		goto dstmap_out;
> >  	}
> >  
> >  	/* general decoding path which can be used for all cases */
> > -- 
> > 1.9.1  

