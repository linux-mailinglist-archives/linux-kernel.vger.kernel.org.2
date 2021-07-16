Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFA33CBB9E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhGPSGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:06:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52019 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhGPSGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626458586; x=1657994586;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=y2RHDnQpUZRnEA3WWO5Lc9cWPwpygTvm/jq2Nuugnok=;
  b=v5o3+zCnPlxKFwLIzLMppZZoH9bPVvrC0IQ3ffDJLzVBt3FbmI7ApFVY
   DA2S11kdr+SrOqwN3ioJj8S3A9nUrrqhcdsDvPvUPcvIUYN+iC57pGAEm
   GVNMPqSJqeJRw0hcwPi3j0gv2/GHZa5f/psxYIC2AlgZf1EVKtHqQJZv4
   ZySkH4XBtRJO2f23cITeNPaEuVWUNXLTdlHR1fgpIHmcK0EG6xD4Vxgks
   lcMbDAdvPFFcmaId7XxAw00hjBAHMFXTnxX0jWjsMTlWy4QLyBpXZ7HNS
   rAalp+rp9ZNsy/qdaGQmikVacIj6JLP/opyqaK4fQaVN29hCXbCv5dMKS
   w==;
IronPort-SDR: rtvun+ctdUILoyIcLhCjTjsOK9+bFBK6zn9xGfNRoy+O3kKkxmjlYzQCFln1FAeNVOd6nJee2P
 v+Zx97su2SxuvWUqAOA6+oBZOJBGV17szslERe6RV/sL6DPIiT4g7vjA9cZb3t/9xm87gxH02c
 4vVB/rNKkY1ANDXBHSOEuwApzVwNALSXGBgITVlea+NsO0n/WLjc5twVoilotaiRJyWeTJmJ5h
 tQqmLyKd8ggm9uZpwOgW6ck3K7rPDV4dR5Tlqo+8aVM/m6rvExr3C0JvgsDWYHPKUq75VoBy/L
 X7Fj+/39GzQvPXEu9mKD0qfy
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="136210915"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2021 11:03:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Jul 2021 11:03:05 -0700
Received: from [10.12.72.255] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 16 Jul 2021 11:03:04 -0700
Subject: Re: [PATCH v3 00/24] ARM: at91: pm: add support for sama7g5
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210415105010.569620-1-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <d4de57d1-aafe-9040-50e3-1e3f587c3eae@microchip.com>
Date:   Fri, 16 Jul 2021 20:03:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210415105010.569620-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/04/2021 at 12:49, Claudiu Beznea wrote:
> Hi,
> 
> This series adds PM support for SAMA7G5. The standby, ulp0, ulp1, and
> backup modes are supported.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v3:
> - drop: status = "okay" in patch 16/24
> 
> Changes in v2:
> - keep only the generic sama7_dt in patch 22/24 and adapt patch 23/24
> - collected tags
> 
> Claudiu Beznea (23):
>    ARM: at91: pm: move pm_bu to soc_pm data structure
>    ARM: at91: pm: move the setup of soc_pm.bu->suspended
>    ARM: at91: pm: document at91_soc_pm structure
>    ARM: at91: pm: check for different controllers in at91_pm_modes_init()
>    ARM: at91: pm: do not initialize pdev
>    ARM: at91: pm: use r7 instead of tmp1
>    ARM: at91: pm: avoid push and pop on stack while memory is in
>      self-refersh
>    ARM: at91: pm: s/CONFIG_SOC_SAM9X60/CONFIG_HAVE_AT91_SAM9X60_PLL/g
>    ARM: at91: pm: add support for waiting MCK1..4
>    ARM: at91: sfrbu: add sfrbu registers definitions for sama7g5
>    ARM: at91: ddr: add registers definitions for sama7g5's ddr
>    ARM: at91: pm: add self-refresh support for sama7g5
>    ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes
>    ARM: at91: pm: add support for 2.5V LDO regulator control
>    ARM: at91: pm: wait for ddr power mode off
>    dt-bindings: atmel-sysreg: add bindings for sama7g5
>    ARM: at91: pm: add sama7g5 ddr controller
>    ARM: at91: pm: add sama7g5 ddr phy controller
>    ARM: at91: pm: save ddr phy calibration data to securam
>    ARM: at91: pm: add backup mode support for SAMA7G5
>    ARM: at91: pm: add sama7g5's pmc
>    ARM: at91: pm: add pm support for SAMA7G5
>    ARM: at91: pm: add sama7g5 shdwc
> 
> Eugen Hristev (1):
>    ARM: at91: sama7: introduce sama7 SoC family

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
For the whole series. Thanks Claudiu and Eugen.

Best regards,
   Nicolas


> 
>   .../devicetree/bindings/arm/atmel-sysregs.txt |  14 +-
>   arch/arm/mach-at91/Makefile                   |   1 +
>   arch/arm/mach-at91/generic.h                  |   2 +
>   arch/arm/mach-at91/pm.c                       | 343 ++++++--
>   arch/arm/mach-at91/pm.h                       |   3 +
>   arch/arm/mach-at91/pm_data-offsets.c          |   2 +
>   arch/arm/mach-at91/pm_suspend.S               | 827 +++++++++++++-----
>   arch/arm/mach-at91/sama7.c                    |  33 +
>   include/soc/at91/sama7-ddr.h                  |  80 ++
>   include/soc/at91/sama7-sfrbu.h                |  34 +
>   10 files changed, 1049 insertions(+), 290 deletions(-)
>   create mode 100644 arch/arm/mach-at91/sama7.c
>   create mode 100644 include/soc/at91/sama7-ddr.h
>   create mode 100644 include/soc/at91/sama7-sfrbu.h
> 


-- 
Nicolas Ferre
