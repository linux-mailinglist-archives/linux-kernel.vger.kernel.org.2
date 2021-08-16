Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CD53EE07C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 01:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhHPXgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 19:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhHPXgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 19:36:41 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330CDC061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:36:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y6so13115527lje.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 16:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fCbJk159OmyFs2BOwXv6EYcMlLEdtAwxcbo1kGetDyw=;
        b=ENGDL9TqFwLlJjW/yvg6xIwEOusjlLEWOJzXoHvkGjBJ8cTf6WeCdRqpxvVtiRs8Lb
         Vf0mAZdR5TaVVSdGKdl9EvmfhLH5iS5zxK02Qio2axrHbOgTQsNBOi4OF5oM14lky2RD
         62iQQZiT0sUY8T4Qmn2lEoidUL25wJ877S2xuf+TL1T60GrW/hT9IltRKhF0pw/ZYXAy
         /okbFF3kFtfxG4SMeiv9rogFBlOVSez9GbLitbUUeDeARfe6U+vWOyUCfrDf9Mxfd8ep
         bgCVhpzbgRMVCtdJJrM/er46IPhL/3w5MuvB56g2ML91cXD3CZJ5nw+P7hxAHxuJ0xgt
         XHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fCbJk159OmyFs2BOwXv6EYcMlLEdtAwxcbo1kGetDyw=;
        b=MdllZ9HQzRRbLza2X2mknKLmjAorwmfCHk194M/BN9bH/sKEpDPxOCpi4/LBa2Eu+6
         DluONVD1ZoOpdkSqhcevl0GN6jbe3TeiQHgbT7LVoC3gzWm2yPffhGEIpctW9CBethTW
         JH59Aw16wJo3ZH9rr71qCsAh7yOFFAwTtgHc8RPQu2JSbizv1TWm9LsfS/qQi0bfaypT
         G7J1o5+xxoghGz27RF3DxXK4FdxYsgMdKsCg9rcqyvkk9/1/3/ewMOCRo/Rrjqr19reB
         6BgKd6rzlQ0RnErVS1Ojxqu0SlnFiXFwHqCmgGXKzTZPVNGdAP7zcGof4d35cyXxIpMv
         pNQQ==
X-Gm-Message-State: AOAM531b5xA71T4ewgkZ5yfqZU41iy4a8Bs20aWrTeo51fdHVJu1/k3l
        Gf2qR7gi0h9XhLz5T/q08Vc=
X-Google-Smtp-Source: ABdhPJwnA+J9ycFEUTKXpKebD5V9s+E1ACP7bzJvPBoupDD5fjaXYaPOf5ZuV8gwQnmSiXoPpGyLWg==
X-Received: by 2002:a05:651c:3d9:: with SMTP id f25mr562965ljp.334.1629156967491;
        Mon, 16 Aug 2021 16:36:07 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id e7sm45939ljq.9.2021.08.16.16.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 16:36:07 -0700 (PDT)
Date:   Tue, 17 Aug 2021 02:36:05 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] fs/ntfs3: Remove unused variable cnt in
 ntfs_security_init()
Message-ID: <20210816233605.w2csfyhmebicw6k7@kari-VirtualBox>
References: <20210816193041.1164125-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816193041.1164125-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:30:41PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> fs/ntfs3/fsntfs.c:1874:9: warning: variable 'cnt' set but not used
> [-Wunused-but-set-variable]
>         size_t cnt, off;
>                ^
> 1 warning generated.
> 
> It is indeed unused so remove it.
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Looks like it was used for debugging or way before index_find_raw()
needed hint or something. So this should be ok.

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/fsntfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 92140050fb6c..c6599c514acf 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -1871,7 +1871,7 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
>  	struct ATTRIB *attr;
>  	struct ATTR_LIST_ENTRY *le;
>  	u64 sds_size;
> -	size_t cnt, off;
> +	size_t off;
>  	struct NTFS_DE *ne;
>  	struct NTFS_DE_SII *sii_e;
>  	struct ntfs_fnd *fnd_sii = NULL;
> @@ -1946,7 +1946,6 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
>  	sbi->security.next_off =
>  		Quad2Align(sds_size - SecurityDescriptorsBlockSize);
>  
> -	cnt = 0;
>  	off = 0;
>  	ne = NULL;
>  
> @@ -1964,8 +1963,6 @@ int ntfs_security_init(struct ntfs_sb_info *sbi)
>  		next_id = le32_to_cpu(sii_e->sec_id) + 1;
>  		if (next_id >= sbi->security.next_id)
>  			sbi->security.next_id = next_id;
> -
> -		cnt += 1;
>  	}
>  
>  	sbi->security.ni = ni;
> 
> base-commit: 96b18047a7172037ff4206720f4e889670030b41
> -- 
> 2.33.0.rc2
> 
> 
