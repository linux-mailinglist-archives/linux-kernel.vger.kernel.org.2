Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B0F407559
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbhIKHAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 03:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhIKHAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 03:00:11 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E94CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:58:59 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id j16so3963112pfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 23:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DUBJU7imupbVf409oJ+vjv9zLbluzIoKndW7p7g+EnU=;
        b=MbK84QsJwW//DlP3+v3lRq0qG4g0GE1ZnU9HNVD7uNBzLvDZ/JZ3Jf4cfpw7sfvM0c
         gJPRBHldojjHF6we5SEvlwPVkwgjhIaD4VsHi0Ykz6vQv61ZIAL6EagWAN6F3x3Gq9vl
         tRn5392NySWjypP0WtmVzdY3QApDfymZp0+5cC3WB422QN5OxVWJvbhIg5hiQ0ClFKw4
         by0r7iCaibKLqWpakny1FubsFicb/u4foXtEitU7J51KlRj0D+fDZaQdqfUjF3ZEBzmi
         pkjVFRAH+bluenKLbafEkDdxawLfUAZDlvYShJ1rSoOKATYKQT1StsRJ4oHDrQfeqpHo
         rcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DUBJU7imupbVf409oJ+vjv9zLbluzIoKndW7p7g+EnU=;
        b=DlcsHWcztLlNKrJsvTvme+jajhzudxazpAkRkTKy//qCKDNGDDo2ds/t/tVC1wLHDd
         /1aiAzrsZN8tDT7rbHJdlM9mZ7LTejGxGR5bUhV/pybp/REAPBuzQEMhC0v8W4IZ3Bab
         X4piZzQcC8wz0cEtaYklNgNR7gy3Ned0eAMql2HKnZ9AU7pvIEB0vbm+IXmZQMkzByGk
         K6iypCD9NQrjWlWg/lNEX1ryZA7ly/JmKAj5WozrQmz20WXImja+SMLOhRtIYJgMxB8i
         zxzsYFRFXrC5N7sv/Cfz6CUFI+TLYbcPiUDyY2EjqvFYs0je/PFdhra/lkC85wg/whKh
         Cq7Q==
X-Gm-Message-State: AOAM5313hTihYdayA/WQf8gzI4gs47qgMB2G+MTYxGVuUra/ZeX6j12O
        1SYJQ0wKQPbEspS5tWE2ZLcW/Q==
X-Google-Smtp-Source: ABdhPJxDzR74LXT6W1FUf1DQWX4/HmJi4yZuHAQtz6Joa2Qqpkd3SW5/ySOVrU/7dVZXOeiXpUaVQg==
X-Received: by 2002:a63:215c:: with SMTP id s28mr1353795pgm.99.1631343538528;
        Fri, 10 Sep 2021 23:58:58 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id n14sm942402pjm.5.2021.09.10.23.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 23:58:57 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:58:57 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Sep 2021 23:58:55 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: dts: microchip: mpfs-icicle: Fix serial console
In-Reply-To: <01b0aaeb50a960e36077669449a854e5d4c18a83.1629983839.git.geert@linux-m68k.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>, bin.meng@windriver.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, bmeng.cn@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert@linux-m68k.org
Message-ID: <mhng-66e34f73-6c8f-47fd-9839-8672fc1df75d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 06:19:39 PDT (-0700), geert@linux-m68k.org wrote:
> Currently, nothing is output on the serial console, unless
> "console=ttyS0,115200n8" or "earlycon" are appended to the kernel
> command line.  Enable automatic console selection using
> chosen/stdout-path by adding a proper alias, and configure the expected
> serial rate.
>
> While at it, add aliases for the other three serial ports, which are
> provided on the same micro-USB connector as the first one.
>
> Fixes: 0fa6107eca4186ad ("RISC-V: Initial DTS for Microchip ICICLE board")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
> v2:
>   - Add Reviewed-by,
>   - Rebase on top of 417166ddec020c4e ("riscv: dts: microchip: Add
>     ethernet0 to the aliases node"), as requested by Bin.
> ---
>  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> index baea7d204639a185..b254c60589a1cc8b 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
> @@ -16,10 +16,14 @@ / {
>
>  	aliases {
>  		ethernet0 = &emac1;
> +		serial0 = &serial0;
> +		serial1 = &serial1;
> +		serial2 = &serial2;
> +		serial3 = &serial3;
>  	};
>
>  	chosen {
> -		stdout-path = &serial0;
> +		stdout-path = "serial0:115200n8";
>  	};
>
>  	cpus {

Thanks, this is on for-next (there's no fixes right now, it's still 5.15 
for me).
