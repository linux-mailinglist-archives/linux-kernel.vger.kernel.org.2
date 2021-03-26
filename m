Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382CD34AEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhCZTA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:00:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C57C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:00:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t18so3003794pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HNyKIaASUrW7kKOwX98wYKim1aH2PfFTA7jxzM7JquQ=;
        b=siEHzuw2cZyO18WczX6KJ3DFuM1uNXPe0tVU4MHJgsqbkvVj/l3IJ88COYwuAr9Zet
         ndLttyz+ER/8qMr918cMoNUUxj6W4I8r2nv62gX96lLw+D47Vu9ixj92vYvlA24SsDG6
         28p1OwOVSVXtdiw44Vtd3Ag7e5nKWJxJsxQrDvBF1JcdYfeEf6oopJhDClgpE45Bk/nX
         RhTVlX3d/LDEjwkex9/sh1+iJ7atb8kBvn/7G+07FgD+ukJNPKyRDwI5qd7WQmb+oDA5
         W7/6Fb05GZce0F3c/SU3oo9hkAQet07rZ02vr16cext18RhmYKXIDKrXTYho3socVVbm
         2jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HNyKIaASUrW7kKOwX98wYKim1aH2PfFTA7jxzM7JquQ=;
        b=hdGGEtC+YzmMYQfqpkVBCUWKSSBP4EOCoFGUaRxlJbnRRPOdb47JC12mUpnTgjGobJ
         SGRw/45ZXaSf1835KY2+TQ+Pj41kR0YUsLmA61UT/BiCW4gAmyYS7WHekNrILjCpvuM2
         H954AOCZBEVmmMVG6S3xUwyHdRrDFcY1KnsWgg9hygZd66W281TNR3Mx/Ov0tGQ1WP5+
         y5P+Vuxh36Fyp6I74hBpRWKNcAq2AFJseOm8UoHmyJCPrCg3m/JQijYmD6tSKnRSEYTF
         YofHgorDqFCI8dQXgy0S4/Dvj3UZT8yCCEY9X28gWJURZB0IV5fdSku6VY3asYsor/CY
         O4CA==
X-Gm-Message-State: AOAM532zDMVlTMsejE0Hhbts8szwY4jh7RFmoIQI21bpJb650T8WZfuq
        6cZfTCcnxQmFl+nEY1lo2c0=
X-Google-Smtp-Source: ABdhPJx5bAx8gFRXoRKKiFI/wbWsJuqjXD+R5otdeI7H1W+rKLSfbX7ajxQ0DA87Q2TEYN43P9GAOg==
X-Received: by 2002:a17:90b:344c:: with SMTP id lj12mr15399183pjb.208.1616785229100;
        Fri, 26 Mar 2021 12:00:29 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 22sm9327217pjl.31.2021.03.26.12.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Mar 2021 12:00:28 -0700 (PDT)
Subject: Re: [GIT PULL] ARM: SoC fixes for v5.12
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>
References: <CAK8P3a2BTOzDfmH3dHmwm6LYPefFAnGCMPdQOpUbXOukiT0rVw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <597f7c5d-c788-5bc7-bf53-1707fff77e65@gmail.com>
Date:   Fri, 26 Mar 2021 12:00:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2BTOzDfmH3dHmwm6LYPefFAnGCMPdQOpUbXOukiT0rVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/2021 9:02 AM, Arnd Bergmann wrote:
> The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:
> 
>   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-5.12
> 
> for you to fetch changes up to 67335b8d28cd2ee279d6ab3c72856b76411ba48a:
> 
>   Merge tag 'imx-fixes-5.12' of
> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
> arm/fixes (2021-03-18 23:53:47 +0100)
> 
> ----------------------------------------------------------------
> ARM: SoC fixes for v5.12
> 
> Too many fixes have accumulated in the soc tree, so this is a fairly
> large set. As usual, most of the fixes are for devicetree files, but
> there are also notable code changes for imx and omap regressions as
> well as some maintainer file updates.

Arnd, I don't see:

https://lore.kernel.org/linux-arm-kernel/20210217011654.2561426-1-f.fainelli@gmail.com/

despite receiving a message indicating that it was pulled:

Here is the summary with links:
  - [GIT,PULL,1/2] Broadcom late devicetree changes for 5.12
    https://git.kernel.org/soc/soc/c/af6e05f17114
  - [GIT,PULL,2/2] Broadcom late drivers changes for 5.12
    https://git.kernel.org/soc/soc/c/014433756381

the first link does not quite look right to me as it does not contain
the revert.

> 
> imx:
>  - Fix an Ethernet issue on imx6ul-14x14-evk board that is caused by
>    independent PHY reset.
> 
>  - Add missing `dma-coherent` property for LayerScape device trees to fix a
>    kernel BUG report.
> 
>  - Use IRQCHIP_DECLARE for AVIC driver to fix a boot issue on i.MX25 with
>    fw_devlink=on.
> 
>  - Add missing I2C pinctrl entry for imx8mp-phyboard-pollux-rdk board to
>    fix the broken I2C GPIO recovery support.
> 
>  - Add `fsl,use-minimum-ecc` property for imx6ull-myir-mys-6ulx-eval
>    device tree to fix UBI filesystem mount failure.
> 
> at91:
>  - wrong phy address that blocks Ethernet use on boards with sama5d27 SoM1
> 
>  - restrictive pin possibilities for sam9x60
> 
> omap:
>  - Fix ocp interconnect bus access error reporting for omap_l3_noc by
>    setting IRQF_NO_THREAD
> 
>  - Fix changed mmc slot order regression by adding mmc aliases for am335x
> 
>  - Fix dra7 reboot regression caused by invalid pcie reset map
> 
>  - Fix smartreflex init regression caused by dropped legacy data
> 
>  - Fix ti-sysc driver warning on unbind if reset is not deasserted
> 
>  - Fix flakey reset deassert for dra7 iva
> 
> stm32:
>  - MAINTAINER file updates
> 
> broadcom:
>  - brcmstb SoC ID build fix
> 
>  - MAINTAINER file updates
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> ----------------------------------------------------------------
> Arnd Bergmann (4):
>       Merge tag 'arm-soc/for-5.12/drivers-part2' of
> https://github.com/Broadcom/stblinux into arm/fixes
>       Merge tag 'omap-for-v5.12/fixes-rc1-signed' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into
> arm/fixes
>       Merge tag 'at91-fixes-5.12' of
> git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into
> arm/fixes
>       Merge tag 'imx-fixes-5.12' of
> git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into
> arm/fixes
> 
> Claudiu Beznea (1):
>       ARM: dts: at91-sama5d27_som1: fix phy address to 7
> 
> Fabio Estevam (1):
>       ARM: imx6ul-14x14-evk: Do not reset the Ethernet PHYs independently
> 
> Federico Pellegrin (1):
>       ARM: dts: at91: sam9x60: fix mux-mask for PA7 so it can be set
> to A, B and C
> 
> Grygorii Strashko (1):
>       bus: omap_l3_noc: mark l3 irqs as IRQF_NO_THREAD
> 
> Horia Geantă (3):
>       arm64: dts: ls1046a: mark crypto engine dma coherent
>       arm64: dts: ls1043a: mark crypto engine dma coherent
>       arm64: dts: ls1012a: mark crypto engine dma coherent
> 
> Lukas Bulwahn (1):
>       MAINTAINERS: rectify BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER
> 
> Mans Rullgard (1):
>       ARM: dts: am33xx: add aliases for mmc interfaces
> 
> Nicolas Ferre (1):
>       ARM: dts: at91: sam9x60: fix mux-mask to match product's datasheet
> 
> Patrice Chotard (3):
>       MAINTAINERS: Update some st.com email addresses to foss.st.com
>       MAINTAINERS: Remove Vincent Abriou for STM/STI DRM drivers.
>       MAINTAINERS: Add Alain Volmat as STM32 I2C/SMBUS maintainer
> 
> Saravana Kannan (1):
>       ARM: imx: avic: Convert to using IRQCHIP_DECLARE
> 
> Teresa Remmet (1):
>       arm64: dts: imx8mp-phyboard-pollux-rdk: Add missing pinctrl entry
> 
> Tony Lindgren (5):
>       soc: ti: omap-prm: Fix reboot issue with invalid pcie reset map for dra7
>       ARM: OMAP2+: Fix smartreflex init regression after dropping legacy data
>       Merge branch 'fixes-v5.11' into fixes
>       bus: ti-sysc: Fix warning on unbind if reset is not deasserted
>       soc: ti: omap-prm: Fix occasional abort on reset deassert for dra7 iva
> 
> dillon min (1):
>       ARM: dts: imx6ull: fix ubi filesystem mount failed
> 
>  MAINTAINERS                                        | 33 +++++-----
>  arch/arm/boot/dts/am33xx.dtsi                      |  3 +
>  arch/arm/boot/dts/at91-sam9x60ek.dts               |  8 ---
>  arch/arm/boot/dts/at91-sama5d27_som1.dtsi          |  4 +-
>  arch/arm/boot/dts/imx6ul-14x14-evk.dtsi            | 22 +++++--
>  arch/arm/boot/dts/imx6ull-myir-mys-6ulx-eval.dts   |  1 +
>  arch/arm/boot/dts/sam9x60.dtsi                     |  9 +++
>  arch/arm/mach-imx/avic.c                           | 16 ++++-
>  arch/arm/mach-imx/common.h                         |  1 -
>  arch/arm/mach-imx/mach-imx1.c                      | 11 ----
>  arch/arm/mach-imx/mach-imx25.c                     | 12 ----
>  arch/arm/mach-imx/mach-imx27.c                     | 12 ----
>  arch/arm/mach-imx/mach-imx31.c                     |  1 -
>  arch/arm/mach-imx/mach-imx35.c                     |  1 -
>  arch/arm/mach-imx/mm-imx3.c                        | 24 -------
>  arch/arm/mach-omap2/sr_device.c                    | 75 +++++++++++++++++-----
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |  1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |  1 +
>  .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  2 +-
>  .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |  2 +-
>  drivers/bus/omap_l3_noc.c                          |  4 +-
>  drivers/bus/ti-sysc.c                              |  4 +-
>  drivers/soc/ti/omap_prm.c                          |  8 ++-
>  24 files changed, 136 insertions(+), 120 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Florian
