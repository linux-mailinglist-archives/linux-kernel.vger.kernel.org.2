Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2513834CEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbhC2L1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 07:27:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:20435 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhC2L0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 07:26:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617017210; x=1648553210;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SkLgfceD3jGyBvYhKR7Ld4heOTFCvFyo68HJmqDcdb8=;
  b=HdcCDBVsHlarBygmWXy9QB8CdORF12/vIRTO3RTPWx0fqpazJGZY9Iuw
   ztTSmtlhdUDbcToa1RTH6rvF1QUBAf3GU+9E7SR56QOdh6UZehh2LQckW
   J+hXq748TabLuhHQ4y04GRYhhxNW3da5mApvWd8ls9saypjhdSEPzNdXe
   XH9zdN51gp/vsgSneAO1TrbPS2rwKkWk7nase5EHazGiafzUWe6Grst6n
   84Ny6tKnKsJee978/WBfO0cUe30xHlFqnBJAUHpB+QwR+vNTkD0OxxHce
   lfNZjo8ms63BBWe9bAjAY/aBcwkagQfkKgOW8CzYwEhiGdcfEHpCSjiXX
   Q==;
IronPort-SDR: iN4mH5A/7yqlckVYppBxUJkymBVVl/TBd0mt673JovpS80UQNzxauLLQfKNu3xcNv3aKqkkpHx
 aFwkGfc9Jb3g+4ppaz+jWppsXTrynVYHwsAXbhGyKop8R0BE3mn07ylIkO3sJupUih/M8bHuCB
 GVMuj921Bm+tqJ6qWeJYFyJiusMn288fg0Q0Dj9xjeQpdJYqicysJXbSKb4RqKLnsiHPBIa+UK
 yE24EEf8t27qhri7ScITR3ReviYxiYIieuKakQ/i4+taZ3PJ0mXBM3HcQ7CPfvPponXNIFOdmE
 zEw=
X-IronPort-AV: E=Sophos;i="5.81,287,1610434800"; 
   d="scan'208";a="49226472"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2021 04:26:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 04:26:49 -0700
Received: from den-her-m31857h.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 29 Mar 2021 04:26:48 -0700
Message-ID: <f47350cef78ffbb65f7488d50bdb369d30daddef.camel@microchip.com>
Subject: Re: [PATCH v8 0/3] Adding the Sparx5 Switch Reset Driver
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 29 Mar 2021 13:26:47 +0200
In-Reply-To: <20210316090839.3207930-1-steen.hegelund@microchip.com>
References: <20210316090839.3207930-1-steen.hegelund@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

I just wanted to know if there are any outstanding items, or you think 
that the driver is acceptable as it is now?

BR
Steen

On Tue, 2021-03-16 at 10:08 +0100, Steen Hegelund wrote:
> This series provides the Microchip Sparx5 Switch Reset Driver
> 
> The Sparx5 Switch SoC has a number of components that can be reset
> individually, but at least the Switch Core needs to be in a well defined
> state at power on, when any of the Sparx5 drivers starts to access the
> Switch Core, this reset driver is available.
> 
> The reset driver is loaded early via the postcore_initcall interface, and
> will then be available for the other Sparx5 drivers (SGPIO, SwitchDev etc)
> that are loaded next, and the first of them to be loaded can perform the
> one-time Switch Core reset that is needed.
> 
> The driver has protection so that the system busses, DDR controller, PCI-E
> and ARM A53 CPU and a few other subsystems are not touched by the reset.
> 
> Sparx5 will no longer use the existing Ocelot chip reset driver, but use
> this new switch reset driver as it has the reset controller interface that
> allows the first client to perform the reset on behalf of all the Sparx5
> component drivers.
> 
> The Sparx5 Chip Register Model can be browsed at this location:
> https://github.com/microchip-ung/sparx-5_reginfo
> and the datasheet is available here:
> https://ww1.microchip.com/downloads/en/DeviceDoc/SparX-5_Family_L2L3_Enterprise_10G_Ethernet_Switches_Datasheet_00003822B.pdf
> 
> History:
> 
> v7 -> v8 Updated the commit descriptions to explain the change from using
>          the existing Ocelot chip reset driver to use a new switch reset
>          driver.
> 
> v6 -> v7 Use devm_platform_get_and_ioremap_resource to get the IO range.
>          Rebase on v5.12-rc1
> 
> v5 -> v6 Using the existing CPU syscon for reset protection and add a small
>          IO range for the GCB Reset Register.
> 
> v4 -> v5 Changed the two syscons into IO ranges and updated the bindings to
>          reflect this change.
> 
> v3 -> v4 Added commit message descriptions
> 
> v2 -> v3 Removed unused headers
>          Renamed the reset controller dev member.
>          Use regmap_read_poll_timeout instead of polling a function.
>          Used two separate syscon entries in the binding
>          Simplified the syscon error handling.
>          Simplified the devm_reset_controller_register error handling.
>          Moved the contents of the mchp_sparx5_reset_config function into
>          the probe function.
> 
> v1 -> v2 Removed debug prints
>          Changed the error handling to save the error code before jumping.
> 
> Steen Hegelund (3):
>   dt-bindings: reset: microchip sparx5 reset driver bindings
>   reset: mchp: sparx5: add switch reset driver
>   arm64: dts: reset: add microchip sparx5 switch reset driver
> 
>  .../bindings/reset/microchip,rst.yaml         |  58 +++++++
>  arch/arm64/boot/dts/microchip/sparx5.dtsi     |   7 +-
>  drivers/reset/Kconfig                         |   8 +
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-microchip-sparx5.c        | 146 ++++++++++++++++++
>  5 files changed, 218 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
>  create mode 100644 drivers/reset/reset-microchip-sparx5.c
> 


