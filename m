Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC530B447
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 01:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhBBAqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 19:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhBBAqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 19:46:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB917C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 16:45:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z6so18536936wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 16:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=R+DY3ptemdPsgpSAemZqrrEiiEasrjy6FBc1qDbbWrQ=;
        b=ri3TxrY3TBgB5Os1sHmq9qfzzay/vdaPhoxzTjM++5ZA523vrpHMBJrtpD5enoS90v
         CGSfiEkmRgAfhDB4PgVGuENBVoRkwcp4qTrIv1p/4g5e5IW+k0j4NI23/onnkSW7Ua0u
         0sftY/scP6W4XDUs9YzbybR9eD/fS8yCvg1kO7a/T3MJYBiNWSgDYxNdZnuvBFuILfc4
         hvsZd2F10BTIKe+hW6hDLXO2d99UsNAFEjOg+fZnvpgsIYqe8bKW4+x11HOCubGHpIXg
         1aiDfYNrwm7y58ObjSv1gZ7D+GSknx39XPYEHXtgWM8eerR8AATNS1IbF7U1ohefdJXt
         HyeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=R+DY3ptemdPsgpSAemZqrrEiiEasrjy6FBc1qDbbWrQ=;
        b=fWyxF38L6DqVtPR1GrwoJW2Eik60S2k2S2uTSPlu+DLVrBiCuXdKJfdXmJsalg9E9g
         W5Q888JwcZXA4i1x0WUTB+QZlT9Jwa1TvsLs7zhRiEiGX5ZAnU/eh/T4KKeopU02Fq9B
         WwI6ZNJpkHSCqzhXAz23+wJg5r/Z4bOJRpsuvKaHLKzTQaUGkFdEn9eWTyn8D2OaMX3R
         /n461wRgYkl4PQ86Q3I0PFrpsCuCwe+tfLklNAcp71vwi0vrLOOal/85OD5xiUwbQKzx
         7XWQq03OYhHtxJ2eYXCSTwJfvyEAhIQzSXZa9u4/dJqtdveOtcz7EB1sgoQlqsRO2zjV
         eFCA==
X-Gm-Message-State: AOAM532rdzr5F67Eg6ZYPfATDyzicpNw3BRLFmv//vomDaucfVCXxh+0
        lsMblJ0Cshal5Z1tBsJPleFNxQ==
X-Google-Smtp-Source: ABdhPJwxNXQTy/QE3Lo/F9xQFQNUvYrAvLBunGofChogGrJTK4i3z2o53P/m+m42LWzy7JdbSThXzg==
X-Received: by 2002:a5d:60c2:: with SMTP id x2mr21605432wrt.248.1612226733431;
        Mon, 01 Feb 2021 16:45:33 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s23sm849562wmc.35.2021.02.01.16.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 16:45:32 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Artem Lapkin <email2tema@gmail.com>, narmstrong@baylibre.com
Cc:     robh+dt@kernel.org, jbrunet@baylibre.com,
        christianshewitt@gmail.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH] arm64: dts: meson-gx: remove wrong reserved BL31 memory
In-Reply-To: <20210130054022.2020338-1-art@khadas.com>
References: <20210130054022.2020338-1-art@khadas.com>
Date:   Mon, 01 Feb 2021 16:45:30 -0800
Message-ID: <7hy2g7guvp.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Artem Lapkin <email2tema@gmail.com> writes:

> Kernel boot fail on Khadas VIM1 VIM2 (meson GX) boards
> SOLUTION: just remove wrong mem reservation for 0x10000000 0x200000

You don't explain why it's wrong.

This region was added becasue there there are definitely GX devices which
have secure memory in this area, and this patch will break those devices.

>  ## Booting kernel from Legacy Image at 08080000 ...
>    Image Name:   kernel
>    Image Type:   AArch64 Linux Kernel Image (lzma compressed)
>    Data Size:    4657736 Bytes = 4.4 MiB
>    Load Address: 0f080000
>    Entry Point:  0f080000
>    Verifying Checksum ... OK
>  ## Flattened Device Tree blob at 08008000
>    Booting using the fdt blob at 0x8008000
>    Uncompressing Kernel Image
>  ERROR: reserving fdt memory region failed (addr=10000000 size=200000)
>    Loading Device Tree to 000000007bf23000, end 000000007bf2d3ce ... OK

I suspect if you change the load addresses used by u-boot to avoid this
region, you'll be able to boot just fine.

Kevin

>  Starting kernel ...
>
>  bl31 reboot reason: 0xd
>  bl31 reboot reason: 0x0
>  system cmd  1.
>
> Signed-off-by: Artem Lapkin <art@khadas.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index 726b91d3a..71083b89d 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -32,12 +32,6 @@ hwrom_reserved: hwrom@0 {
>  			no-map;
>  		};
>  
> -		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
> -		secmon_reserved: secmon@10000000 {
> -			reg = <0x0 0x10000000 0x0 0x200000>;
> -			no-map;
> -		};
> -
>  		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
>  		secmon_reserved_alt: secmon@5000000 {
>  			reg = <0x0 0x05000000 0x0 0x300000>;
> -- 
> 2.25.1
