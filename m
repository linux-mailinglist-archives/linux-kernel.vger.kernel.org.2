Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16D63F622C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhHXQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbhHXQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:03:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1682C061757;
        Tue, 24 Aug 2021 09:02:48 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so46584667lfu.5;
        Tue, 24 Aug 2021 09:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=poU6UxSe+vqBcMpX3p5PAXt32In/R0qv0Zl1gWkMej0=;
        b=u48N+5kK/p3O1LusihjD74avPElDU4N3bsljZPgfQZ0p0zH+fHDGLBt1RxRnIeCAaw
         CjqxonXgj/EL8EtOarJIBQg6Fc8xtLCWY7K6oe4pHvCbQx/Gk+Qdp+s2PUsEEijQhqaI
         v6EDsIyuAFHeR22fDLix8Q92iduNYMpyzNiKb+DBg8GgwQmfk3BrqPunz7Zl0RKiwSeM
         SZceBqvuUUWOFoJ+LHKCadWF7dRt2sdpNIiQh/y86BB8L9ADAqGgVzQZJi48nD3ANJK6
         2ehmjqblhq8AAk4IWUfyCndVZMKWXLObW6tK64FCuoqZKVAik1Ll2Afk0U2Wtdac+CuQ
         zfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=poU6UxSe+vqBcMpX3p5PAXt32In/R0qv0Zl1gWkMej0=;
        b=ksQuAgFlZcUaeK82KkmgK4eI2ppnaXj2RFBPKCp+xY3Dkeijr0W6XdnQXaCYE1mvF/
         vNKkc2rOWqD24dX3eReErsBDr+o/C3oTLa6mWyZklkrMt6PxUWxW54DzwwQC76z6B7np
         RMCxTGE6itanVJhLhCONd1a+Q7HNCw2bL7l5dB7N+QZr+meUGPpR9mL6vSH0UONl8HmI
         VMQBCxRV/KBOdwgQTt8Nl8f9PQUmjBovg34cEDnOKyRUpeQW9H0Fg462APUHaQhKturA
         cpX19Zi7XXVORDpbq5sOsREeWmpZwfkkQxd01FTKFqyWvWEfnqHrJMUSb4oAgxCzuRzY
         3uvw==
X-Gm-Message-State: AOAM531dkS9tR+zHVM8xe2+TEbcmn8++WFE8yXAIdFxnY1v/7ADqGs28
        4SSs1csuaJ7EqjnMeIzDRLg=
X-Google-Smtp-Source: ABdhPJwAdruZqs4SZAUqfnw1zEdXAYFJFJPv5dblFrUIB2G03WennhJ9xl9YqYQjF4ZN0VfUNDfZ/Q==
X-Received: by 2002:ac2:5091:: with SMTP id f17mr28576173lfm.42.1629820966958;
        Tue, 24 Aug 2021 09:02:46 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id y5sm1238590ljd.38.2021.08.24.09.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:02:46 -0700 (PDT)
Date:   Tue, 24 Aug 2021 19:02:44 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/ntfs3: add checks for allocation failure
Message-ID: <20210824160244.ruutwl3nq6b5feec@kari-VirtualBox>
References: <20210824115236.GJ31143@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824115236.GJ31143@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 02:52:36PM +0300, Dan Carpenter wrote:
> Add a check for when the kzalloc() in init_rsttbl() fails.  Some of
> the callers checked for NULL and some did not.  I went down the call
> tree and added NULL checks where ever they were missing.
> 
> Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Seems ok. It is not easist file to follow. log_replay is monster and
it should be refactor in some point. I'm certain that many more bugs
will be founded there. Also at least community does not have very good
testing interface for this. 

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/fslog.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
> index 397ba6a956e7..209fe6ddead0 100644
> --- a/fs/ntfs3/fslog.c
> +++ b/fs/ntfs3/fslog.c
> @@ -807,7 +807,11 @@ static inline struct RESTART_TABLE *init_rsttbl(u16 esize, u16 used)
>  	u32 off;
>  	u32 bytes = esize * used + sizeof(struct RESTART_TABLE);
>  	u32 lf = sizeof(struct RESTART_TABLE) + (used - 1) * esize;
> -	struct RESTART_TABLE *t = ntfs_zalloc(bytes);
> +	struct RESTART_TABLE *t;
> +
> +	t = ntfs_zalloc(bytes);
> +	if (!t)
> +		return NULL;
>  
>  	t->size = cpu_to_le16(esize);
>  	t->used = cpu_to_le16(used);
> @@ -831,7 +835,11 @@ static inline struct RESTART_TABLE *extend_rsttbl(struct RESTART_TABLE *tbl,
>  	u16 esize = le16_to_cpu(tbl->size);
>  	__le32 osize = cpu_to_le32(bytes_per_rt(tbl));
>  	u32 used = le16_to_cpu(tbl->used);
> -	struct RESTART_TABLE *rt = init_rsttbl(esize, used + add);
> +	struct RESTART_TABLE *rt;
> +
> +	rt = init_rsttbl(esize, used + add);
> +	if (!rt)
> +		return NULL;
>  
>  	memcpy(rt + 1, tbl + 1, esize * used);
>  
> @@ -864,8 +872,11 @@ static inline void *alloc_rsttbl_idx(struct RESTART_TABLE **tbl)
>  	__le32 *e;
>  	struct RESTART_TABLE *t = *tbl;
>  
> -	if (!t->first_free)
> +	if (!t->first_free) {
>  		*tbl = t = extend_rsttbl(t, 16, ~0u);
> +		if (!t)
> +			return NULL;
> +	}
>  
>  	off = le32_to_cpu(t->first_free);
>  
> @@ -4482,6 +4493,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
>  		}
>  
>  		dp = alloc_rsttbl_idx(&dptbl);
> +		if (!dp) {
> +			err = -ENOMEM;
> +			goto out;
> +		}
>  		dp->target_attr = cpu_to_le32(t16);
>  		dp->transfer_len = cpu_to_le32(t32 << sbi->cluster_bits);
>  		dp->lcns_follow = cpu_to_le32(t32);
> -- 
> 2.20.1
> 
> 
