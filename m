Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA03EDD76
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhHPTAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhHPS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:59:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE32C061764;
        Mon, 16 Aug 2021 11:59:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k5so8627164lfu.4;
        Mon, 16 Aug 2021 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YM6cQkex/BdszIWVIBI/jlxIRTThIKtyUZSSLfhpZYg=;
        b=SilIE+EE+21tdcsAkiDvZ68E5Q7rkt+3g4qwJ6kn1c8+JQZFLLb5LJs5e3osrNhg+3
         n0MQPmXf/8qgUf/Z2t7fMDsyD07wPVfTPu6UkVPSwWUapK3L2ay0WiUDsGSWQU+x07ix
         D4pbrtss3Igalz29Emf1vYA9pd10d9ZpVBXV0QPI3uzJTYkT5mNxJrdHe4LUB01n55vG
         qIF7SWVNPlvlOpsxSZonvixaO0OKS+sZE7UovHk1B1o/ggRPpgxteZrm6B2h37IW5X4Y
         QLDim8Aov6Z41w1NA+o7LIVRxAefw31YfBhcDzSrnR8+wDQ1kF0IO8gO1arPHy6/EFyS
         uwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YM6cQkex/BdszIWVIBI/jlxIRTThIKtyUZSSLfhpZYg=;
        b=fhVM4ZOgrI1AEkgbHZzjsbAT7c6y7Lf2QYxfvCpvWVjFq8REQw68rOhuC8q7cyEaK0
         WBR89sCZ2bfkvCXrU0kvff7oRce25t2MNWZXcbzCFmXt5gVgeK1EIVoTyfZ6gZYU1HsY
         BLqcLt10iOiJ4lVK98xxv0d0QQhUioUhCZ9iTjyPGXGD7wgYGDeid/XqBhObzM72wn14
         qcF3yv+rPXDZj5vS2u8MqUg6YvtdvBTQtJmoH1M5WHOy68CBqJm6mEG0Ar8HJbuzW/xG
         0SMdnuoX47vvucydGlS7qmGE318U+0jFqh8fRoeG4hu8tdvlvGfuPLKuqlbj+cEoVIad
         a3ew==
X-Gm-Message-State: AOAM530ta/XCNzTEH3qydlTyESilKyBqHYko8EvElJt+QZL8tQT6b4fO
        OXLuIkCig/4pKodM7DJEXlo=
X-Google-Smtp-Source: ABdhPJyIEA1Zwh2M5vF9Dn6I55g22nzF3NDm+o991XAG1h+4N3aSky/+K3xAlhAQuUmeXvykTMrefQ==
X-Received: by 2002:a19:ee15:: with SMTP id g21mr44747lfb.182.1629140364206;
        Mon, 16 Aug 2021 11:59:24 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id o22sm7269lfr.32.2021.08.16.11.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 11:59:23 -0700 (PDT)
Date:   Mon, 16 Aug 2021 21:59:21 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs/ntfs3: Fix integer overflow in multiplication
Message-ID: <20210816185921.kky77ctvb3dx6lq4@kari-VirtualBox>
References: <20210816163025.81770-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816163025.81770-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 05:30:25PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The multiplication of the u32 data_size with a int is being performed
> using 32 bit arithmetic however the results is being assigned to the
> variable nbits that is a size_t (64 bit) value. Fix a potential
> integer overflow by casting the u32 value to a size_t before the
> multiply to use a size_t sized bit multiply operation.
> 
> Addresses-Coverity: ("Unintentional integer overflow")
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/ntfs3/index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 6aa9540ece47..9386c551e208 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -2012,7 +2012,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		unsigned long pos;
>  		const unsigned long *bm = resident_data(b);
>  
> -		nbits = le32_to_cpu(b->res.data_size) * 8;
> +		nbits = (size_t)le32_to_cpu(b->res.data_size) * 8;

nbits is size_t because we might use b->nres.data_size in this function.
Usually nbits is only u32 in other places and also in those is *8. Those
will also overflow as much as this one. So this does not save our asses
if that kind of situation happend. So basically this does not fix
anything just some static analyzer can find it more easily than other
cases.

I'm still not nacking about it. If some static tool is happy by this
change then that might be good thing so that this will not be addressed
again. I also do not ack this. I did not fully review this so of course
there might be some fundemental problem with these *8 multiplications
but I doubt it.

>  
>  		if (bit >= nbits)
>  			return 0;

