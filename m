Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0EB363708
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 19:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhDRRi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 13:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhDRRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 13:38:52 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC192C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 10:38:21 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id i16-20020a9d68d00000b0290286edfdfe9eso19837510oto.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 10:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4Uxy/H46ztQJA5yFK5/pTHWRVi7fZP2Q+MrW5rsMwqY=;
        b=Gva1qvx4iFfSYu3tVAAa/nf0Gygn2Z/8jvJycdnWsP853BjMLCiqZbYk193OnUPt7a
         S1Brb3IGQ/eznu5B+yANi72um/2cpBe/KLXGVXV2MPRmygjBNq486GBXhayHE7o9PCMd
         JshnV5VAWeiDC1mO1UDSNAUdJQn0RD8lhwD/IsZ+4durD12wasQazXTHEZgm3X6BR5Ki
         46UInMYZSP9tR2tI2P5Qmk7TcHLUrExeMBJx2/rr/4pvkGSGnzRgKyD13nbzFpwbzrZW
         55FwlzzGhyT8r6L8nx1RTyyVIR6SXSqyhSeN6XN15/LWeQLcZdxkZwE6ekVcL7wp739D
         Z7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4Uxy/H46ztQJA5yFK5/pTHWRVi7fZP2Q+MrW5rsMwqY=;
        b=aCC55k0lf/G1cPixdP4jY0Sc9dNfQLGMmJ2UggeImQvjF/cM674tNsw0hyF2Hnge6B
         udc1q/ZIeUH0dQr9dRkW0y0LwXH8w0RGFMleq8EdlqSh5xNhHABnoTv+ZPUv8ngY1isb
         gZyhlfn/zaQKcistcehug7EeRtMlW9zBDqdLCjiNFb+JNPIDgFaawxEynR1SNKK9pTR5
         14YF5AVScagwxmRstUoD8hm2uP2d6KLahtazlOHTrAbJGQYwswMMfVoBCtWvLm5x4xkB
         2hMGKgZpxDWdkWb3B+UC/Wv2Xo1jwhaYW7ayRoeZIqEJfcw/7ldZsrpYX/cB1kS6+m1Q
         NTCA==
X-Gm-Message-State: AOAM533OQdmBHMrOCIpiSpzsmd9JgdrHP6TnGOXbhMCa20YpwsrTJ3Ng
        XheCBh9KRq7kGcY3/aKC7nDT5w==
X-Google-Smtp-Source: ABdhPJyUlglvgYT5lkSeMHQ7k65T4T9H4d6kPTiZnBydiNyBWmK3DZY+EBeemqwHrg9qf44ksrKyeg==
X-Received: by 2002:a05:6830:4111:: with SMTP id w17mr12028953ott.99.1618767501020;
        Sun, 18 Apr 2021 10:38:21 -0700 (PDT)
Received: from elm (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id n104sm2920071ota.27.2021.04.18.10.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 10:38:20 -0700 (PDT)
Date:   Sun, 18 Apr 2021 12:38:19 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ecryptfs: Fix typo in message
Message-ID: <20210418173819.GE398325@elm>
References: <20210224113059.28445-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224113059.28445-1-s.hauer@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-24 12:30:59, Sascha Hauer wrote:
> ecryptfs_decrypt_page() issues a warning "Error encrypting extent". This
> should be "Error decrypting extent" instead.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks! This looks good. I'll add the following fixes line while
applying:

Fixes: 0216f7f79217 ("eCryptfs: replace encrypt, decrypt, and inode size write")

Tyler

> ---
>  fs/ecryptfs/crypto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
> index a48116aae02c..0fed4ff02f69 100644
> --- a/fs/ecryptfs/crypto.c
> +++ b/fs/ecryptfs/crypto.c
> @@ -535,7 +535,7 @@ int ecryptfs_decrypt_page(struct page *page)
>  		rc = crypt_extent(crypt_stat, page, page,
>  				  extent_offset, DECRYPT);
>  		if (rc) {
> -			printk(KERN_ERR "%s: Error encrypting extent; "
> +			printk(KERN_ERR "%s: Error decrypting extent; "
>  			       "rc = [%d]\n", __func__, rc);
>  			goto out;
>  		}
> -- 
> 2.29.2
> 
