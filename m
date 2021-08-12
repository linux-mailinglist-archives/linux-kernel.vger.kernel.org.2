Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B8C3E9F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbhHLHTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhHLHTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:19:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25480C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:18:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b7so6121033plh.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bVBs890c5u5oz2MryX7OZ1h4zgixesuI0BRji18LRrg=;
        b=u7eMUjdjPwPQXq3gIFrxl1G8er1+Y2Lx0FYqO3H+OgBSy9P2xRmFPFju6UOjfaCN2L
         iDv+1BANF3WXQNAKoOOnflqUHL4iJ3xQZpJE3vevBp58tZtmR7ZbzeaTgeJOVZzOnGgy
         uoq8edt5FyeM1TeKedIFmDRtEsh8Of6zAYFfCp/khql4eXd2Dq/ZY9WyZh7iq6cs64Ee
         9iSctiDNW0Y0pyFkKb+CT58B8fQCee+hsTUcXhTy8iCjpw0jqH87J+23zt6QIFe/xkJw
         KJ/XozuwYQZ4RD/nNZx35t0u5jEKXpIKEvuoFmLP6ZbyyGT3iGs+dDIQpBdNDI5QG92w
         41Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bVBs890c5u5oz2MryX7OZ1h4zgixesuI0BRji18LRrg=;
        b=PwnAOUELAbNjzjwa+FuwRPW+G7k++SMG3oiWySUH54tvz4s/Uhzd9zZ+e+Isj3RqXF
         nwiPOY+wA8OxKNQbf0JhT/YfFJj2bQM5kjzKPZRC7C+vPh0DzxvRWUpk1eQ6Osa6tgza
         FoscXkJjruKJfwFGVgy2AvHwJ4J9LrZimy9wgD2RiWZazMx1a5y2RT/rlx6hy2QZESow
         q4NCIHqkuxUNRJL9wH3fjd4OveG3wkyS/wKgQ/7+rWGevR+gaj6dlPaZXDUbA0nkBG21
         sxMII1L5cINXsBeN68Y2Juy9ZSqR1f+XzQkpt6p80bTwllEGGQkH/KWA/cAitrUdB3rV
         /hdQ==
X-Gm-Message-State: AOAM531JjPLXxG+3PE01NFJT+urd/gZLvUSNEncOJJZx7RBYcNlGaBmN
        qX9ApSqWi1MHo883cgLfVHE1eA==
X-Google-Smtp-Source: ABdhPJw0QuQAsmx19Nk18vjri8KXE+GeQaTUIMg9VZ1xbOe4RYWCcjEjKISkAvKBWV6lohHzwfOh9w==
X-Received: by 2002:aa7:9f06:0:b029:3c6:c469:9135 with SMTP id g6-20020aa79f060000b02903c6c4699135mr2826167pfr.27.1628752716609;
        Thu, 12 Aug 2021 00:18:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o1sm2113173pfd.129.2021.08.12.00.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 00:18:35 -0700 (PDT)
Date:   Thu, 12 Aug 2021 00:18:35 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Aug 2021 23:54:16 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: defconfig: enable NLS_CODEPAGE_437, NLS_ISO8859_1
In-Reply-To: <20210726112647.78561-1-xypron.glpk@gmx.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        heinrich.schuchardt@canonical.com,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, kernel@esmil.dk,
        sagar.kadam@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, xypron.glpk@gmx.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     xypron.glpk@gmx.de
Message-ID: <mhng-16eb6b79-280a-46ef-813f-cc2924793d50@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 04:26:47 PDT (-0700), xypron.glpk@gmx.de wrote:
> The EFI system partition uses the FAT file system. Many distributions add
> an entry in /etc/fstab for the ESP. We must ensure that mounting does not
> fail.
>
> The default code page for FAT is 437 (cf. CONFIG_FAT_DEFAULT_CODEPAGE).
> The default IO character set is "iso8859-1" (cf. CONFIG_NLS_ISO8859_1).
>
> So let's enable NLS_CODEPAGE_437 and NLS_ISO8859_1 in defconfig.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 393bf3843e5c..1a3170d5f203 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -110,6 +110,8 @@ CONFIG_NFS_V4_1=y
>  CONFIG_NFS_V4_2=y
>  CONFIG_ROOT_NFS=y
>  CONFIG_9P_FS=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_ISO8859_1=m
>  CONFIG_CRYPTO_USER_API_HASH=y
>  CONFIG_CRYPTO_DEV_VIRTIO=y
>  CONFIG_PRINTK_TIME=y

These both look fine, but I'm getting checkpatch warnings about the 
Signed-off-by address not matching the From address.  Not sure if it's 
just something wrong on my end, but when I send from a different address 
then I want as the Author field I generally end up with a "From: " line 
at the top of my patch.

I know it's a bit pedantic, but IIUC I'm not supposed to take things 
like tihs.  Do you mind re-sending these as patches that are internally 
consistent?
