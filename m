Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7CD3F6E88
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhHYEp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhHYEpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:45:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11245C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:44:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j187so20203206pfg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DtpgiMDdQDQ42lYOShCZSjozTn71wDq5F2+gG4jR6Mc=;
        b=0lbToYpEYOLQgZ6ilz4YoMIXEGpsubR/kTYlcrt7w3aXRixErfDBdQPwni5NYIPqXx
         MCe4cqP/zZvQDRM6fYqeLweBtHvDmuGBQTbnBTWqE+AVh8zKZiYh6e0GEyBwfqwGmVlv
         T4KUmkPDiBR60QYCYargeeujS9jdlwrd7YnrkLY72EdVE8qv/2yEfoqnhKI4JMXrRx1W
         HaqaU9g+LAj/SWct7VpLCW2Iv55cdmOjr/qPUMYeRTh/l/C5C+WZFdkWihni8dP+Fb2l
         6MKa411jZSwIFHyY9+TsSMZyKsM5dgwiJl9PbEsshPO/kTyqVRxXwW+5YppMQrHPkylw
         gd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DtpgiMDdQDQ42lYOShCZSjozTn71wDq5F2+gG4jR6Mc=;
        b=dywP0pXRHnhpicGM9KArfeuODRa85z6qe8VJCyCsMn9hra7RYiq+qIEqzF2slXdiwO
         kxMCshgkfh1F1RA6bkJ2e/gmDXATtGxfmWPnmimEX5pYamKb+s57vhB1v+MEaoyJGkLL
         0HCQiWapteF4lAQtkNc72zIas0rLXzwXii3hE6uJvNf1/Lv/97l5/JGYMQRtr/Z02FVw
         aBNx1OOyjZrgimrw2fBWAp9Qru3aKpynfwKMM9oBIcj0+25x1wa/LQEMNLxyxeSd8GQ6
         zNaqq1m71tO8edVtX3UPlzRATue4ApS/CsNqrcsfcePPBDgktOdpLa37yFExA0YE/xyM
         rXNQ==
X-Gm-Message-State: AOAM533EKjY07dgIUGi0payY23G7Sa2y94w1jLwclDdwa3OzZOzprkDi
        XE4oVfU2XM3Lz5deC337Eo0rBw==
X-Google-Smtp-Source: ABdhPJxyNMzZYjLDAg06MgzzGBD9gydeKGrikQEhiDcDIRog/SGk6EAyeKQbPoEQpWsk9AVcMwwR8w==
X-Received: by 2002:a65:44c4:: with SMTP id g4mr40319781pgs.254.1629866679411;
        Tue, 24 Aug 2021 21:44:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a1sm19557309pgt.47.2021.08.24.21.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 21:44:38 -0700 (PDT)
Date:   Tue, 24 Aug 2021 21:44:38 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Aug 2021 20:57:42 PDT (-0700)
Subject:     Re: [PATCH v2 1/2] riscv: dts: microchip: Use 'local-mac-address' for emac1
In-Reply-To: <20210804123015.807929-1-bmeng.cn@gmail.com>
CC:     Conor.Dooley@microchip.com, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        geert@linux-m68k.org, bin.meng@windriver.com,
        conor.dooley@microchip.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bmeng.cn@gmail.com
Message-ID: <mhng-8451ce80-2f44-40f0-945c-f2fd13a80bd7@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 05:30:14 PDT (-0700), bmeng.cn@gmail.com wrote:
> From: Bin Meng <bin.meng@windriver.com>
>
> Per the DT spec, 'local-mac-address' is used to specify MAC address
> that was assigned to the network device, while 'mac-address' is used
> to specify the MAC address that was last used by the boot program,
> and shall be used only if the value differs from 'local-mac-address'
> property value.
>
> Signed-off-by: Bin Meng <bin.meng@windriver.com>
> Reviewed-by: conor dooley <conor.dooley@microchip.com>
> ---
>
> (no changes since v1)
>
>  arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> index 0659068b62f7..a9c558366d61 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -317,7 +317,7 @@ emac1: ethernet@20112000 {
>  			reg = <0x0 0x20112000 0x0 0x2000>;
>  			interrupt-parent = <&plic>;
>  			interrupts = <70 71 72 73>;
> -			mac-address = [00 00 00 00 00 00];
> +			local-mac-address = [00 00 00 00 00 00];
>  			clocks = <&clkcfg 5>, <&clkcfg 2>;
>  			status = "disabled";
>  			clock-names = "pclk", "hclk";

Thanks, these are on fixes.
