Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32607360507
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhDOIyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhDOIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:54:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6339C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:54:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k128so12029569wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xngGWKpBnC9vZ7jS+z4hywmOrfd830+QsQrfOwxaUwg=;
        b=wYjDeoPzQUU7L/jtBPZ2lQAZaurtYOOmQLTbUXKLFEINRSx4A2OSfnNd+FbHxhpBIU
         s/ENNyRxLTbPfJFOkLllGHrrYYwvAemxhG6fNT8lr9IoRWKsbB5fy8zqZhbdu5kJefpP
         z6oOfcwlreiA3VhJh4l9VXuDiY1c8GlBiqgJiiUhvGsHkXyQLlbb5fEmT/0dXg0+fgeh
         xYiBxN+T/HXjzLRhahZ4mBc1bXFkEc6/jv5QEiJNfPiW4zLJgNyofm2NlBuXpFlZ0mOo
         NwxAkfgsCe8ehAS3hz5PB//qQXmVFnJVNfMUifIlfaJOVbAUi6tf3TppS/tfOr1Dxk1S
         NlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xngGWKpBnC9vZ7jS+z4hywmOrfd830+QsQrfOwxaUwg=;
        b=TynVOuYf5nz1n7c1NvwfgVDgU6xCLz4pw2XpYTlofpXjiwBg2y/GKgAj/C7p5CTHQk
         oOUoec+P/sOj8alL0jfP805UzcXH/qfc+IMC9z1a0AsUaz2Gt3EZLVDm3yYka5aPXB9C
         GTGsdVpJXZ8g5jJ4nJhLYAcVuLpjEPmbnsVYh0hXVZBW1uKRqKVj5D8oY5hdZGfOqgZ4
         VpxGi2RnaTHbQhJrdXTqjxnaxGXNjXCzN0SlYOi7B8IXzwtzIskH0w6+Z+1toTj5Hm0Y
         KYB88QxFLpGrgszF098dSYeuITOj9HnRCc8Wuh0Aa8bU1myDC+OJIi4xLNI2WUGdGQxg
         UkWg==
X-Gm-Message-State: AOAM533FvDJ5aiuILfzj5fQsMitJ0VtlJSS4tNUzV5uzwQkDh75nz2Lq
        TEuZWgGQykplJmPHPWv2xFjXug==
X-Google-Smtp-Source: ABdhPJz05AxITMprQ0Vv5oqOrG0VoSKnFgBO8qr58kWFQ4NWy+mlxeLwv53smPJvCa5oGg7LpdItbg==
X-Received: by 2002:a05:600c:902:: with SMTP id m2mr1007295wmp.116.1618476859926;
        Thu, 15 Apr 2021 01:54:19 -0700 (PDT)
Received: from [10.1.3.24] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f12sm1916540wrr.61.2021.04.15.01.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:54:19 -0700 (PDT)
Subject: Re: [PATCH v3 2/3] drm: bridge: add it66121 driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Phong LE <ple@baylibre.com>
References: <20210412154648.3719153-1-narmstrong@baylibre.com>
 <20210412154648.3719153-3-narmstrong@baylibre.com>
 <KUSIRQ.I96CDVW7UOIC3@crapouillou.net>
 <1d963840-cb96-399b-7f27-ce3eb9ad6083@baylibre.com>
 <W7EKRQ.9T516HF2PHKR3@crapouillou.net>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <358a526f-4f9e-588b-3a98-a3fd49f15894@baylibre.com>
Date:   Thu, 15 Apr 2021 10:54:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <W7EKRQ.9T516HF2PHKR3@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 19:35, Paul Cercueil wrote:
> Hi Neil,
> 
> Le mer. 14 avril 2021 à 8:17, Neil Armstrong <narmstrong@baylibre.com> a écrit :
>> Hi,
>>
>> Le 13/04/2021 à 22:56, Paul Cercueil a écrit :
>>>  Hi Neil,
>>>
>>>  I get build failures locally:
>>>
>>>  drivers/gpu/drm/bridge/ite-it66121.c: In function ‘it66121_hw_reset’:
>>>  drivers/gpu/drm/bridge/ite-it66121.c:242:2: error: implicit declaration of function ‘gpiod_set_value’ [-Werror=implicit-function-declaration]
>>>  242 | gpiod_set_value(ctx->gpio_reset, 1);
>>>      | ^~~~~~~~~~~~~~~
>>>  drivers/gpu/drm/bridge/ite-it66121.c: In function ‘it66121_probe’:
>>>  drivers/gpu/drm/bridge/ite-it66121.c:1016:16: error: implicit declaration of function ‘FIELD_GET’; did you mean ‘FOLL_GET’? [-Werror=implicit-function-declaration]
>>>  1016 | revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
>>>      | ^~~~~~~~~
>>>      | FOLL_GET
>>>
>>>  Nothing difficult to fix, but the includes should be added nonetheless.
>>
>> Exact, I got the CI build failures, I'll fix these for v4.
>>
>> Were you able to test on your setup ?
>> The v2 always forced DDR mode, with this v3, I also switch to normal 24input mode, but totally untested.
> 
> It triggers a warning:
> 
> [  277.870247] WARNING: CPU: 0 PID: 310 at drivers/gpu/drm/drm_bridge.c:892 drm_atomic_bridge_chain_check+0x304/0x324
> [  277.870290] Modules linked in:
> [  277.870306] CPU: 0 PID: 310 Comm: modetest Tainted: G        W        5.12.0-rc7-opendingux-00121-g828a3020b5d3 #371
> [  277.870322] Stack : 83f62580 80163b58 00000000 00000004 00000000 b1f39d7e 83581a9c 80ab42b0
> [  277.870367]         808a0000 808a0000 835c82f0 808a0dab 80ab42b0 00000001 83581a48 b1f39d7e
> [  277.870412]         00000000 00000000 807e9030 00000000 000000b8 835818fc 00000000 7875676e
> [  277.870456]         3130302d 80abaa43 80abaa9f 672d3132 808a0000 80000000 00000009 0000037c
> [  277.870500]         00000000 00000000 82a2d0f8 83043b80 00000000 fffffffc 00002098 80ab0000
> [  277.870544]         ...
> [  277.870556] Call Trace:
> [  277.870560] [<80109010>] show_stack+0x40/0x128
> [  277.870588] [<80123350>] __warn+0xe0/0x154
> [  277.870608] [<80123428>] warn_slowpath_fmt+0x64/0xb8
> [  277.870625] [<80504e70>] drm_atomic_bridge_chain_check+0x304/0x324
> [  277.870642] [<804e3244>] drm_atomic_helper_check_modeset+0x9f4/0xc58
> [  277.870667] [<804e4338>] drm_atomic_helper_check+0x20/0xa8
> [  277.870685] [<80503644>] drm_atomic_check_only+0x538/0x98c
> [  277.870700] [<80503ab4>] drm_atomic_commit+0x1c/0x70
> [  277.870716] [<8051c3e4>] drm_mode_atomic_ioctl+0x920/0xb44
> [  277.870736] [<804f033c>] drm_ioctl+0x20c/0x3d8
> [  277.870754] [<80283658>] sys_ioctl+0x358/0x860
> [  277.870772] [<801107ec>] syscall_common+0x34/0x58
> 
> [  277.870795] ---[ end trace e973f3b21c63aa1d ]---

Will fix this,

Neil

> 
> That causes my atomic commit to fail, so I can't test it further.
> 
> Cheers,
> -Paul
> 
>> Thanks,
>> Neil
>>
>>>
>>>  Cheers,
>>>  -Paul
>>>
>>>
>>>  Le lun. 12 avril 2021 à 17:46, Neil Armstrong <narmstrong@baylibre.com> a écrit :
>>>>  From: Phong LE <ple@baylibre.com>
>>>>
>>>>  This commit is a simple driver for bridge HMDI it66121.
>>>>  The input format is RBG and there is no color conversion.
>>>>  Audio, HDCP and CEC are not supported yet.
>>>>
>>>>  Signed-off-by: Phong LE <ple@baylibre.com>
>>>>  Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>>  ---
>>>>   drivers/gpu/drm/bridge/Kconfig       |    8 +
>>>>   drivers/gpu/drm/bridge/Makefile      |    1 +
>>>>   drivers/gpu/drm/bridge/ite-it66121.c | 1081 ++++++++++++++++++++++++++
>>>>   3 files changed, 1090 insertions(+)
>>>>   create mode 100644 drivers/gpu/drm/bridge/ite-it66121.c
>>>>
>>>>  diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>>>  index e4110d6ca7b3..6915c38fa459 100644
>>>>  --- a/drivers/gpu/drm/bridge/Kconfig
>>>>  +++ b/drivers/gpu/drm/bridge/Kconfig
>>>>  @@ -74,6 +74,14 @@ config DRM_LONTIUM_LT9611UXC
>>>>         HDMI signals
>>>>         Please say Y if you have such hardware.
>>>>
>>>>  +config DRM_ITE_IT66121
>>>>  +    tristate "ITE IT66121 HDMI bridge"
>>>>  +    depends on OF
>>>>  +    select DRM_KMS_HELPER
>>>>  +    select REGMAP_I2C
>>>>  +    help
>>>>  +      Support for ITE IT66121 HDMI bridge.
>>>>  +
>>>>   config DRM_LVDS_CODEC
>>>>       tristate "Transparent LVDS encoders and decoders support"
>>>>       depends on OF
>>>>  diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
>>>>  index 86e7acc76f8d..4f725753117c 100644
>>>>  --- a/drivers/gpu/drm/bridge/Makefile
>>>>  +++ b/drivers/gpu/drm/bridge/Makefile
>>>>  @@ -24,6 +24,7 @@ obj-$(CONFIG_DRM_TI_SN65DSI86) += ti-sn65dsi86.o
>>>>   obj-$(CONFIG_DRM_TI_TFP410) += ti-tfp410.o
>>>>   obj-$(CONFIG_DRM_TI_TPD12S015) += ti-tpd12s015.o
>>>>   obj-$(CONFIG_DRM_NWL_MIPI_DSI) += nwl-dsi.o
>>>>  +obj-$(CONFIG_DRM_ITE_IT66121) += ite-it66121.o
>>>>
>>>>   obj-y += analogix/
>>>>   obj-y += cadence/
>>>>  diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
>>>>  new file mode 100644
>>>>  index 000000000000..73af49b29dfa
>>>>  --- /dev/null
>>>>  +++ b/drivers/gpu/drm/bridge/ite-it66121.c
>>>>  @@ -0,0 +1,1081 @@
>>>>  +// SPDX-License-Identifier: GPL-2.0-only
>>>>  +/*
>>>>  + * Copyright (C) 2020 BayLibre, SAS
>>>>  + * Author: Phong LE <ple@baylibre.com>
>>>>  + * Copyright (C) 2018-2019, Artem Mygaiev
>>>>  + * Copyright (C) 2017, Fresco Logic, Incorporated.
>>>>  + *
>>>>  + */
>>>>  +
>>>>  +#include <linux/device.h>
>>>>  +#include <linux/i2c.h>
>>>>  +#include <linux/interrupt.h>
>>>>  +#include <linux/module.h>
>>>>  +#include <linux/property.h>
>>>>  +#include <linux/of_graph.h>
>>>>  +#include <linux/pinctrl/consumer.h>
>>>>  +#include <linux/regmap.h>
>>>>  +#include <linux/regulator/consumer.h>
>>>>  +
>>>>  +#include <drm/drm_atomic_helper.h>
>>>>  +#include <drm/drm_bridge.h>
>>>>  +#include <drm/drm_crtc_helper.h>
>>>>  +#include <drm/drm_edid.h>
>>>>  +#include <drm/drm_modes.h>
>>>>  +#include <drm/drm_print.h>
>>>>  +#include <drm/drm_probe_helper.h>
>>>>  +
>>>>  +#define IT66121_VENDOR_ID0_REG            0x00
>>>>  +#define IT66121_VENDOR_ID1_REG            0x01
>>>>  +#define IT66121_DEVICE_ID0_REG            0x02
>>>>  +#define IT66121_DEVICE_ID1_REG            0x03
>>>>  +
>>>>  +#define IT66121_VENDOR_ID0            0x54
>>>>  +#define IT66121_VENDOR_ID1            0x49
>>>>  +#define IT66121_DEVICE_ID0            0x12
>>>>  +#define IT66121_DEVICE_ID1            0x06
>>>>  +#define IT66121_REVISION_MASK            GENMASK(7, 4)
>>>>  +#define IT66121_DEVICE_ID1_MASK            GENMASK(3, 0)
>>>>  +
>>>>  +#define IT66121_MASTER_SEL_REG            0x10
>>>>  +#define IT66121_MASTER_SEL_HOST            BIT(0)
>>>>  +
>>>>  +#define IT66121_AFE_DRV_REG            0x61
>>>>  +#define IT66121_AFE_DRV_RST            BIT(4)
>>>>  +#define IT66121_AFE_DRV_PWD            BIT(5)
>>>>  +
>>>>  +#define IT66121_INPUT_MODE_REG            0x70
>>>>  +#define IT66121_INPUT_MODE_RGB            (0 << 6)
>>>>  +#define IT66121_INPUT_MODE_YUV422        BIT(6)
>>>>  +#define IT66121_INPUT_MODE_YUV444        (2 << 6)
>>>>  +#define IT66121_INPUT_MODE_CCIR656        BIT(4)
>>>>  +#define IT66121_INPUT_MODE_SYNCEMB        BIT(3)
>>>>  +#define IT66121_INPUT_MODE_DDR            BIT(2)
>>>>  +
>>>>  +#define IT66121_INPUT_CSC_REG            0x72
>>>>  +#define IT66121_INPUT_CSC_ENDITHER        BIT(7)
>>>>  +#define IT66121_INPUT_CSC_ENUDFILTER        BIT(6)
>>>>  +#define IT66121_INPUT_CSC_DNFREE_GO        BIT(5)
>>>>  +#define IT66121_INPUT_CSC_RGB_TO_YUV        0x02
>>>>  +#define IT66121_INPUT_CSC_YUV_TO_RGB        0x03
>>>>  +#define IT66121_INPUT_CSC_NO_CONV        0x00
>>>>  +
>>>>  +#define IT66121_AFE_XP_REG            0x62
>>>>  +#define IT66121_AFE_XP_GAINBIT            BIT(7)
>>>>  +#define IT66121_AFE_XP_PWDPLL            BIT(6)
>>>>  +#define IT66121_AFE_XP_ENI            BIT(5)
>>>>  +#define IT66121_AFE_XP_ENO            BIT(4)
>>>>  +#define IT66121_AFE_XP_RESETB            BIT(3)
>>>>  +#define IT66121_AFE_XP_PWDI            BIT(2)
>>>>  +
>>>>  +#define IT66121_AFE_IP_REG            0x64
>>>>  +#define IT66121_AFE_IP_GAINBIT            BIT(7)
>>>>  +#define IT66121_AFE_IP_PWDPLL            BIT(6)
>>>>  +#define IT66121_AFE_IP_CKSEL_05            (0 << 4)
>>>>  +#define IT66121_AFE_IP_CKSEL_1            BIT(4)
>>>>  +#define IT66121_AFE_IP_CKSEL_2            (2 << 4)
>>>>  +#define IT66121_AFE_IP_CKSEL_2OR4        (3 << 4)
>>>>  +#define IT66121_AFE_IP_ER0            BIT(3)
>>>>  +#define IT66121_AFE_IP_RESETB            BIT(2)
>>>>  +#define IT66121_AFE_IP_ENC            BIT(1)
>>>>  +#define IT66121_AFE_IP_EC1            BIT(0)
>>>>  +
>>>>  +#define IT66121_AFE_XP_EC1_REG            0x68
>>>>  +#define IT66121_AFE_XP_EC1_LOWCLK        BIT(4)
>>>>  +
>>>>  +#define IT66121_SW_RST_REG            0x04
>>>>  +#define IT66121_SW_RST_REF            BIT(5)
>>>>  +#define IT66121_SW_RST_AREF            BIT(4)
>>>>  +#define IT66121_SW_RST_VID            BIT(3)
>>>>  +#define IT66121_SW_RST_AUD            BIT(2)
>>>>  +#define IT66121_SW_RST_HDCP            BIT(0)
>>>>  +
>>>>  +#define IT66121_DDC_COMMAND_REG            0x15
>>>>  +#define IT66121_DDC_COMMAND_BURST_READ        0x0
>>>>  +#define IT66121_DDC_COMMAND_EDID_READ        0x3
>>>>  +#define IT66121_DDC_COMMAND_FIFO_CLR        0x9
>>>>  +#define IT66121_DDC_COMMAND_SCL_PULSE        0xA
>>>>  +#define IT66121_DDC_COMMAND_ABORT        0xF
>>>>  +
>>>>  +#define IT66121_HDCP_REG            0x20
>>>>  +#define IT66121_HDCP_CPDESIRED            BIT(0)
>>>>  +#define IT66121_HDCP_EN1P1FEAT            BIT(1)
>>>>  +
>>>>  +#define IT66121_INT_STATUS1_REG            0x06
>>>>  +#define IT66121_INT_STATUS1_AUD_OVF        BIT(7)
>>>>  +#define IT66121_INT_STATUS1_DDC_NOACK        BIT(5)
>>>>  +#define IT66121_INT_STATUS1_DDC_FIFOERR        BIT(4)
>>>>  +#define IT66121_INT_STATUS1_DDC_BUSHANG        BIT(2)
>>>>  +#define IT66121_INT_STATUS1_RX_SENS_STATUS    BIT(1)
>>>>  +#define IT66121_INT_STATUS1_HPD_STATUS        BIT(0)
>>>>  +
>>>>  +#define IT66121_DDC_HEADER_REG            0x11
>>>>  +#define IT66121_DDC_HEADER_HDCP            0x74
>>>>  +#define IT66121_DDC_HEADER_EDID            0xA0
>>>>  +
>>>>  +#define IT66121_DDC_OFFSET_REG            0x12
>>>>  +#define IT66121_DDC_BYTE_REG            0x13
>>>>  +#define IT66121_DDC_SEGMENT_REG            0x14
>>>>  +#define IT66121_DDC_RD_FIFO_REG            0x17
>>>>  +
>>>>  +#define IT66121_CLK_BANK_REG            0x0F
>>>>  +#define IT66121_CLK_BANK_PWROFF_RCLK        BIT(6)
>>>>  +#define IT66121_CLK_BANK_PWROFF_ACLK        BIT(5)
>>>>  +#define IT66121_CLK_BANK_PWROFF_TXCLK        BIT(4)
>>>>  +#define IT66121_CLK_BANK_PWROFF_CRCLK        BIT(3)
>>>>  +#define IT66121_CLK_BANK_0            0
>>>>  +#define IT66121_CLK_BANK_1            1
>>>>  +
>>>>  +#define IT66121_INT_REG                0x05
>>>>  +#define IT66121_INT_ACTIVE_HIGH            BIT(7)
>>>>  +#define IT66121_INT_OPEN_DRAIN            BIT(6)
>>>>  +#define IT66121_INT_TX_CLK_OFF            BIT(0)
>>>>  +
>>>>  +#define IT66121_INT_MASK1_REG            0x09
>>>>  +#define IT66121_INT_MASK1_AUD_OVF        BIT(7)
>>>>  +#define IT66121_INT_MASK1_DDC_NOACK        BIT(5)
>>>>  +#define IT66121_INT_MASK1_DDC_FIFOERR        BIT(4)
>>>>  +#define IT66121_INT_MASK1_DDC_BUSHANG        BIT(2)
>>>>  +#define IT66121_INT_MASK1_RX_SENS        BIT(1)
>>>>  +#define IT66121_INT_MASK1_HPD            BIT(0)
>>>>  +
>>>>  +#define IT66121_INT_CLR1_REG            0x0C
>>>>  +#define IT66121_INT_CLR1_PKTACP            BIT(7)
>>>>  +#define IT66121_INT_CLR1_PKTNULL        BIT(6)
>>>>  +#define IT66121_INT_CLR1_PKTGEN            BIT(5)
>>>>  +#define IT66121_INT_CLR1_KSVLISTCHK        BIT(4)
>>>>  +#define IT66121_INT_CLR1_AUTHDONE        BIT(3)
>>>>  +#define IT66121_INT_CLR1_AUTHFAIL        BIT(2)
>>>>  +#define IT66121_INT_CLR1_RX_SENS        BIT(1)
>>>>  +#define IT66121_INT_CLR1_HPD            BIT(0)
>>>>  +
>>>>  +#define IT66121_AV_MUTE_REG            0xC1
>>>>  +#define IT66121_AV_MUTE_ON            BIT(0)
>>>>  +#define IT66121_AV_MUTE_BLUESCR            BIT(1)
>>>>  +
>>>>  +#define IT66121_PKT_GEN_CTRL_REG        0xC6
>>>>  +#define IT66121_PKT_GEN_CTRL_ON            BIT(0)
>>>>  +#define IT66121_PKT_GEN_CTRL_RPT        BIT(1)
>>>>  +
>>>>  +#define IT66121_AVIINFO_DB1_REG            0x158
>>>>  +#define IT66121_AVIINFO_DB2_REG            0x159
>>>>  +#define IT66121_AVIINFO_DB3_REG            0x15A
>>>>  +#define IT66121_AVIINFO_DB4_REG            0x15B
>>>>  +#define IT66121_AVIINFO_DB5_REG            0x15C
>>>>  +#define IT66121_AVIINFO_CSUM_REG        0x15D
>>>>  +#define IT66121_AVIINFO_DB6_REG            0x15E
>>>>  +#define IT66121_AVIINFO_DB7_REG            0x15F
>>>>  +#define IT66121_AVIINFO_DB8_REG            0x160
>>>>  +#define IT66121_AVIINFO_DB9_REG            0x161
>>>>  +#define IT66121_AVIINFO_DB10_REG        0x162
>>>>  +#define IT66121_AVIINFO_DB11_REG        0x163
>>>>  +#define IT66121_AVIINFO_DB12_REG        0x164
>>>>  +#define IT66121_AVIINFO_DB13_REG        0x165
>>>>  +
>>>>  +#define IT66121_AVI_INFO_PKT_REG        0xCD
>>>>  +#define IT66121_AVI_INFO_PKT_ON            BIT(0)
>>>>  +#define IT66121_AVI_INFO_PKT_RPT        BIT(1)
>>>>  +
>>>>  +#define IT66121_HDMI_MODE_REG            0xC0
>>>>  +#define IT66121_HDMI_MODE_HDMI            BIT(0)
>>>>  +
>>>>  +#define IT66121_SYS_STATUS_REG            0x0E
>>>>  +#define IT66121_SYS_STATUS_ACTIVE_IRQ        BIT(7)
>>>>  +#define IT66121_SYS_STATUS_HPDETECT        BIT(6)
>>>>  +#define IT66121_SYS_STATUS_SENDECTECT        BIT(5)
>>>>  +#define IT66121_SYS_STATUS_VID_STABLE        BIT(4)
>>>>  +#define IT66121_SYS_STATUS_AUD_CTS_CLR        BIT(1)
>>>>  +#define IT66121_SYS_STATUS_CLEAR_IRQ        BIT(0)
>>>>  +
>>>>  +#define IT66121_DDC_STATUS_REG            0x16
>>>>  +#define IT66121_DDC_STATUS_TX_DONE        BIT(7)
>>>>  +#define IT66121_DDC_STATUS_ACTIVE        BIT(6)
>>>>  +#define IT66121_DDC_STATUS_NOACK        BIT(5)
>>>>  +#define IT66121_DDC_STATUS_WAIT_BUS        BIT(4)
>>>>  +#define IT66121_DDC_STATUS_ARBI_LOSE        BIT(3)
>>>>  +#define IT66121_DDC_STATUS_FIFO_FULL        BIT(2)
>>>>  +#define IT66121_DDC_STATUS_FIFO_EMPTY        BIT(1)
>>>>  +#define IT66121_DDC_STATUS_FIFO_VALID        BIT(0)
>>>>  +
>>>>  +#define IT66121_EDID_SLEEP_US            20000
>>>>  +#define IT66121_EDID_TIMEOUT_US            200000
>>>>  +#define IT66121_EDID_FIFO_SIZE            32
>>>>  +#define IT66121_AFE_CLK_HIGH            80000 /* Khz */
>>>>  +
>>>>  +struct it66121_ctx {
>>>>  +    struct regmap *regmap;
>>>>  +    struct drm_bridge bridge;
>>>>  +    struct drm_connector connector;
>>>>  +    struct device *dev;
>>>>  +    struct gpio_desc *gpio_reset;
>>>>  +    struct i2c_client *client;
>>>>  +    struct regulator_bulk_data supplies[3];
>>>>  +    u32 bus_width;
>>>>  +    struct mutex lock; /* Protects fields below and device registers */
>>>>  +    struct edid *edid;
>>>>  +    struct hdmi_avi_infoframe hdmi_avi_infoframe;
>>>>  +};
>>>>  +
>>>>  +static const struct regmap_range_cfg it66121_regmap_banks[] = {
>>>>  +    {
>>>>  +        .name = "it66121",
>>>>  +        .range_min = 0x00,
>>>>  +        .range_max = 0x1FF,
>>>>  +        .selector_reg = IT66121_CLK_BANK_REG,
>>>>  +        .selector_mask = 0x1,
>>>>  +        .selector_shift = 0,
>>>>  +        .window_start = 0x00,
>>>>  +        .window_len = 0x130,
>>>>  +    },
>>>>  +};
>>>>  +
>>>>  +static const struct regmap_config it66121_regmap_config = {
>>>>  +    .val_bits = 8,
>>>>  +    .reg_bits = 8,
>>>>  +    .max_register = 0x1FF,
>>>>  +    .ranges = it66121_regmap_banks,
>>>>  +    .num_ranges = ARRAY_SIZE(it66121_regmap_banks),
>>>>  +};
>>>>  +
>>>>  +static void it66121_hw_reset(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    gpiod_set_value(ctx->gpio_reset, 1);
>>>>  +    msleep(20);
>>>>  +    gpiod_set_value(ctx->gpio_reset, 0);
>>>>  +}
>>>>  +
>>>>  +static int ite66121_power_on(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    return regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>>>  +}
>>>>  +
>>>>  +static int ite66121_power_off(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>>>  +}
>>>>  +
>>>>  +static int it66121_preamble_ddc(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    return regmap_write(ctx->regmap, IT66121_MASTER_SEL_REG,
>>>>  +                IT66121_MASTER_SEL_HOST);
>>>>  +}
>>>>  +
>>>>  +static int it66121_fire_afe(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    return regmap_write(ctx->regmap, IT66121_AFE_DRV_REG, 0);
>>>>  +}
>>>>  +
>>>>  +/* TOFIX: Handle YCbCr Input & Output */
>>>>  +static int it66121_configure_input(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    int ret;
>>>>  +    u8 mode = IT66121_INPUT_MODE_RGB;
>>>>  +
>>>>  +    if (ctx->bus_width == 12)
>>>>  +        mode |= IT66121_INPUT_MODE_DDR;
>>>>  +
>>>>  +    ret = regmap_write(ctx->regmap, IT66121_INPUT_MODE_REG, mode);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    return regmap_write(ctx->regmap, IT66121_INPUT_CSC_REG, IT66121_INPUT_CSC_NO_CONV);
>>>>  +}
>>>>  +
>>>>  +/**
>>>>  + * it66121_configure_afe() - Configure the analog front end
>>>>  + * @ctx: it66121_ctx object
>>>>  + * @mode: mode to configure
>>>>  + *
>>>>  + * RETURNS:
>>>>  + * zero if success, a negative error code otherwise.
>>>>  + */
>>>>  +static int it66121_configure_afe(struct it66121_ctx *ctx,
>>>>  +                 const struct drm_display_mode *mode)
>>>>  +{
>>>>  +    int ret;
>>>>  +
>>>>  +    ret = regmap_write(ctx->regmap, IT66121_AFE_DRV_REG,
>>>>  +               IT66121_AFE_DRV_RST);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    if (mode->clock > IT66121_AFE_CLK_HIGH) {
>>>>  +        ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_REG,
>>>>  +                    IT66121_AFE_XP_GAINBIT |
>>>>  +                    IT66121_AFE_XP_ENO,
>>>>  +                    IT66121_AFE_XP_GAINBIT);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
>>>>  +                    IT66121_AFE_IP_GAINBIT |
>>>>  +                    IT66121_AFE_IP_ER0 |
>>>>  +                    IT66121_AFE_IP_EC1,
>>>>  +                    IT66121_AFE_IP_GAINBIT);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
>>>>  +                    IT66121_AFE_XP_EC1_LOWCLK, 0x80);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +    } else {
>>>>  +        ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_REG,
>>>>  +                    IT66121_AFE_XP_GAINBIT |
>>>>  +                    IT66121_AFE_XP_ENO,
>>>>  +                    IT66121_AFE_XP_ENO);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
>>>>  +                    IT66121_AFE_IP_GAINBIT |
>>>>  +                    IT66121_AFE_IP_ER0 |
>>>>  +                    IT66121_AFE_IP_EC1, IT66121_AFE_IP_ER0 |
>>>>  +                    IT66121_AFE_IP_EC1);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_EC1_REG,
>>>>  +                    IT66121_AFE_XP_EC1_LOWCLK,
>>>>  +                    IT66121_AFE_XP_EC1_LOWCLK);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +    }
>>>>  +
>>>>  +    /* Clear reset flags */
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_SW_RST_REG,
>>>>  +                IT66121_SW_RST_REF | IT66121_SW_RST_VID,
>>>>  +                ~(IT66121_SW_RST_REF | IT66121_SW_RST_VID) &
>>>>  +                0xFF);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    return it66121_fire_afe(ctx);
>>>>  +}
>>>>  +
>>>>  +static inline int it66121_wait_ddc_ready(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    int ret, val;
>>>>  +    u32 busy = IT66121_DDC_STATUS_NOACK | IT66121_DDC_STATUS_WAIT_BUS |
>>>>  +           IT66121_DDC_STATUS_ARBI_LOSE;
>>>>  +
>>>>  +    ret = regmap_read_poll_timeout(ctx->regmap, IT66121_DDC_STATUS_REG, val, true,
>>>>  +                       IT66121_EDID_SLEEP_US, IT66121_EDID_TIMEOUT_US);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    if (val & busy)
>>>>  +        return -EAGAIN;
>>>>  +
>>>>  +    return 0;
>>>>  +}
>>>>  +
>>>>  +static int it66121_clear_ddc_fifo(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    int ret;
>>>>  +
>>>>  +    ret = it66121_preamble_ddc(ctx);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    return regmap_write(ctx->regmap, IT66121_DDC_COMMAND_REG,
>>>>  +                IT66121_DDC_COMMAND_FIFO_CLR);
>>>>  +}
>>>>  +
>>>>  +static int it66121_abort_ddc_ops(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    int ret;
>>>>  +    unsigned int swreset, cpdesire;
>>>>  +
>>>>  +    ret = regmap_read(ctx->regmap, IT66121_SW_RST_REG, &swreset);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_read(ctx->regmap, IT66121_HDCP_REG, &cpdesire);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write(ctx->regmap, IT66121_HDCP_REG,
>>>>  +               cpdesire & (~IT66121_HDCP_CPDESIRED & 0xFF));
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write(ctx->regmap, IT66121_SW_RST_REG,
>>>>  +               (swreset | IT66121_SW_RST_HDCP));
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = it66121_preamble_ddc(ctx);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write(ctx->regmap, IT66121_DDC_COMMAND_REG,
>>>>  +               IT66121_DDC_COMMAND_ABORT);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    return it66121_wait_ddc_ready(ctx);
>>>>  +}
>>>>  +
>>>>  +static int it66121_get_edid_block(void *context, u8 *buf,
>>>>  +                  unsigned int block, size_t len)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = context;
>>>>  +    unsigned int val;
>>>>  +    int remain = len;
>>>>  +    int offset = 0;
>>>>  +    int ret, cnt;
>>>>  +
>>>>  +    offset = (block % 2) * len;
>>>>  +    block = block / 2;
>>>>  +
>>>>  +    ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    if (val & IT66121_INT_STATUS1_DDC_BUSHANG) {
>>>>  +        ret = it66121_abort_ddc_ops(ctx);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +    }
>>>>  +
>>>>  +    ret = it66121_clear_ddc_fifo(ctx);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    while (remain > 0) {
>>>>  +        cnt = (remain > IT66121_EDID_FIFO_SIZE) ?
>>>>  +                IT66121_EDID_FIFO_SIZE : remain;
>>>>  +        ret = it66121_preamble_ddc(ctx);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write(ctx->regmap, IT66121_DDC_COMMAND_REG,
>>>>  +                   IT66121_DDC_COMMAND_FIFO_CLR);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = it66121_wait_ddc_ready(ctx);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        if (val & IT66121_INT_STATUS1_DDC_BUSHANG) {
>>>>  +            ret = it66121_abort_ddc_ops(ctx);
>>>>  +            if (ret)
>>>>  +                return ret;
>>>>  +        }
>>>>  +
>>>>  +        ret = it66121_preamble_ddc(ctx);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write(ctx->regmap, IT66121_DDC_HEADER_REG,
>>>>  +                   IT66121_DDC_HEADER_EDID);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write(ctx->regmap, IT66121_DDC_OFFSET_REG, offset);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write(ctx->regmap, IT66121_DDC_BYTE_REG, cnt);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write(ctx->regmap, IT66121_DDC_SEGMENT_REG, block);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        ret = regmap_write(ctx->regmap, IT66121_DDC_COMMAND_REG,
>>>>  +                   IT66121_DDC_COMMAND_EDID_READ);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        offset += cnt;
>>>>  +        remain -= cnt;
>>>>  +
>>>>  +        /* Per programming manual, sleep here before emptying the FIFO */
>>>>  +        msleep(20);
>>>>  +
>>>>  +        ret = it66121_wait_ddc_ready(ctx);
>>>>  +        if (ret)
>>>>  +            return ret;
>>>>  +
>>>>  +        do {
>>>>  +            ret = regmap_read(ctx->regmap, IT66121_DDC_RD_FIFO_REG, &val);
>>>>  +            if (ret)
>>>>  +                return ret;
>>>>  +            *(buf++) = val;
>>>>  +            cnt--;
>>>>  +        } while (cnt > 0);
>>>>  +    }
>>>>  +
>>>>  +    return 0;
>>>>  +}
>>>>  +
>>>>  +static int it66121_connector_get_modes(struct drm_connector *connector)
>>>>  +{
>>>>  +    int ret, num_modes = 0;
>>>>  +    struct it66121_ctx *ctx = container_of(connector, struct it66121_ctx,
>>>>  +            connector);
>>>>  +
>>>>  +    if (ctx->edid)
>>>>  +        return drm_add_edid_modes(connector, ctx->edid);
>>>>  +
>>>>  +    mutex_lock(&ctx->lock);
>>>>  +
>>>>  +    ctx->edid = drm_do_get_edid(connector, it66121_get_edid_block, ctx);
>>>>  +    if (!ctx->edid) {
>>>>  +        DRM_ERROR("Failed to read EDID\n");
>>>>  +        goto unlock;
>>>>  +    }
>>>>  +
>>>>  +    ret = drm_connector_update_edid_property(connector, ctx->edid);
>>>>  +    if (ret) {
>>>>  +        DRM_ERROR("Failed to update EDID property: %d\n", ret);
>>>>  +        goto unlock;
>>>>  +    }
>>>>  +
>>>>  +    num_modes = drm_add_edid_modes(connector, ctx->edid);
>>>>  +
>>>>  +unlock:
>>>>  +    mutex_unlock(&ctx->lock);
>>>>  +
>>>>  +    return num_modes;
>>>>  +}
>>>>  +
>>>>  +static bool it66121_is_hpd_detect(struct it66121_ctx *ctx)
>>>>  +{
>>>>  +    int val;
>>>>  +
>>>>  +    if (regmap_read(ctx->regmap, IT66121_SYS_STATUS_REG, &val))
>>>>  +        return false;
>>>>  +
>>>>  +    return val & IT66121_SYS_STATUS_HPDETECT;
>>>>  +}
>>>>  +
>>>>  +static int it66121_connector_detect_ctx(struct drm_connector *connector,
>>>>  +                    struct drm_modeset_acquire_ctx *c,
>>>>  +                    bool force)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = container_of(connector, struct it66121_ctx,
>>>>  +            connector);
>>>>  +
>>>>  +    return it66121_is_hpd_detect(ctx) ? connector_status_connected
>>>>  +                      : connector_status_disconnected;
>>>>  +}
>>>>  +
>>>>  +static enum drm_mode_status it66121_mode_valid(struct it66121_ctx *ctx,
>>>>  +                           const struct drm_display_mode *mode)
>>>>  +{
>>>>  +    unsigned long max_clock;
>>>>  +
>>>>  +    max_clock = (ctx->bus_width == 12) ? 74250 : 148500;
>>>>  +
>>>>  +    if (mode->clock > max_clock)
>>>>  +        return MODE_CLOCK_HIGH;
>>>>  +
>>>>  +    if (mode->clock < 25000)
>>>>  +        return MODE_CLOCK_LOW;
>>>>  +
>>>>  +    return MODE_OK;
>>>>  +}
>>>>  +
>>>>  +static enum drm_mode_status it66121_connector_mode_valid(struct drm_connector *connector,
>>>>  +                             struct drm_display_mode *mode)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = container_of(connector, struct it66121_ctx,
>>>>  +            connector);
>>>>  +
>>>>  +    return it66121_mode_valid(ctx, mode);
>>>>  +}
>>>>  +
>>>>  +static struct drm_connector_helper_funcs it66121_connector_helper_funcs = {
>>>>  +    .get_modes = it66121_connector_get_modes,
>>>>  +    .detect_ctx = it66121_connector_detect_ctx,
>>>>  +    .mode_valid = it66121_connector_mode_valid,
>>>>  +};
>>>>  +
>>>>  +static const struct drm_connector_funcs it66121_connector_funcs = {
>>>>  +    .reset = drm_atomic_helper_connector_reset,
>>>>  +    .fill_modes = drm_helper_probe_single_connector_modes,
>>>>  +    .destroy = drm_connector_cleanup,
>>>>  +    .atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>>>>  +    .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>>>  +};
>>>>  +
>>>>  +static int it66121_bridge_attach(struct drm_bridge *bridge,
>>>>  +                 enum drm_bridge_attach_flags flags)
>>>>  +{
>>>>  +    int ret;
>>>>  +    struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx,
>>>>  +            bridge);
>>>>  +
>>>>  +    if (!bridge->encoder) {
>>>>  +        DRM_ERROR("Parent encoder object not found");
>>>>  +        return -ENODEV;
>>>>  +    }
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
>>>>  +                IT66121_CLK_BANK_PWROFF_RCLK, 0);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_INT_REG,
>>>>  +                IT66121_INT_TX_CLK_OFF, 0);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_AFE_DRV_REG,
>>>>  +                IT66121_AFE_DRV_PWD, 0);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_REG,
>>>>  +                IT66121_AFE_XP_PWDI | IT66121_AFE_XP_PWDPLL, 0);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
>>>>  +                IT66121_AFE_IP_PWDPLL, 0);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_AFE_DRV_REG,
>>>>  +                IT66121_AFE_DRV_RST, 0);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_AFE_XP_REG,
>>>>  +                IT66121_AFE_XP_RESETB, IT66121_AFE_XP_RESETB);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_AFE_IP_REG,
>>>>  +                IT66121_AFE_IP_RESETB, IT66121_AFE_IP_RESETB);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_SW_RST_REG,
>>>>  +                IT66121_SW_RST_REF,
>>>>  +                IT66121_SW_RST_REF);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    /* Per programming manual, sleep here for bridge to settle */
>>>>  +    msleep(50);
>>>>  +
>>>>  +    /* Start interrupts */
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_INT_MASK1_REG,
>>>>  +                IT66121_INT_MASK1_DDC_NOACK |
>>>>  +                IT66121_INT_MASK1_HPD |
>>>>  +                IT66121_INT_MASK1_DDC_FIFOERR |
>>>>  +                IT66121_INT_MASK1_DDC_BUSHANG,
>>>>  +                ~(IT66121_INT_MASK1_DDC_NOACK |
>>>>  +                IT66121_INT_MASK1_HPD |
>>>>  +                IT66121_INT_MASK1_DDC_FIFOERR |
>>>>  +                IT66121_INT_MASK1_DDC_BUSHANG) & 0xFF);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
>>>>  +        return 0;
>>>>  +
>>>>  +    ret = drm_connector_init(bridge->dev, &ctx->connector,
>>>>  +                 &it66121_connector_funcs,
>>>>  +                 DRM_MODE_CONNECTOR_HDMIA);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    ctx->connector.polled = DRM_CONNECTOR_POLL_HPD;
>>>>  +    drm_connector_helper_add(&ctx->connector,
>>>>  +                 &it66121_connector_helper_funcs);
>>>>  +
>>>>  +    ret = drm_connector_attach_encoder(&ctx->connector, bridge->encoder);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    return drm_connector_register(&ctx->connector);
>>>>  +}
>>>>  +
>>>>  +static int it66121_set_mute(struct it66121_ctx *ctx, bool mute)
>>>>  +{
>>>>  +    int ret;
>>>>  +    unsigned int val = 0;
>>>>  +
>>>>  +    if (mute)
>>>>  +        val = IT66121_AV_MUTE_ON;
>>>>  +
>>>>  +    ret = regmap_write_bits(ctx->regmap, IT66121_AV_MUTE_REG, IT66121_AV_MUTE_ON, val);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    return regmap_write(ctx->regmap, IT66121_PKT_GEN_CTRL_REG,
>>>>  +                IT66121_PKT_GEN_CTRL_ON | IT66121_PKT_GEN_CTRL_RPT);
>>>>  +}
>>>>  +
>>>>  +#define MAX_OUTPUT_SEL_FORMATS    1
>>>>  +
>>>>  +static u32 *it66121_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>>>>  +                              struct drm_bridge_state *bridge_state,
>>>>  +                              struct drm_crtc_state *crtc_state,
>>>>  +                              struct drm_connector_state *conn_state,
>>>>  +                              unsigned int *num_output_fmts)
>>>>  +{
>>>>  +    u32 *output_fmts;
>>>>  +
>>>>  +    output_fmts = kcalloc(MAX_OUTPUT_SEL_FORMATS, sizeof(*output_fmts),
>>>>  +                  GFP_KERNEL);
>>>>  +    if (!output_fmts)
>>>>  +        return NULL;
>>>>  +
>>>>  +    /* TOFIX handle more than MEDIA_BUS_FMT_RGB888_1X24 as output format */
>>>>  +    output_fmts[0] =  MEDIA_BUS_FMT_RGB888_1X24;
>>>>  +    *num_output_fmts = 1;
>>>>  +
>>>>  +    return output_fmts;
>>>>  +}
>>>>  +
>>>>  +#define MAX_INPUT_SEL_FORMATS    1
>>>>  +
>>>>  +static u32 *it66121_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>>>  +                             struct drm_bridge_state *bridge_state,
>>>>  +                             struct drm_crtc_state *crtc_state,
>>>>  +                             struct drm_connector_state *conn_state,
>>>>  +                             u32 output_fmt,
>>>>  +                             unsigned int *num_input_fmts)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>>>>  +    u32 *input_fmts;
>>>>  +
>>>>  +    *num_input_fmts = 0;
>>>>  +
>>>>  +    input_fmts = kcalloc(MAX_INPUT_SEL_FORMATS, sizeof(*input_fmts),
>>>>  +                 GFP_KERNEL);
>>>>  +    if (!input_fmts)
>>>>  +        return NULL;
>>>>  +
>>>>  +    if (ctx->bus_width == 12)
>>>>  +        /* IT66121FN Datasheet specifies Little-Endian ordering */
>>>>  +        input_fmts[0] = MEDIA_BUS_FMT_RGB888_2X12_LE;
>>>>  +    else
>>>>  +        /* TOFIX support more input bus formats in 24bit width */
>>>>  +        input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
>>>>  +    *num_input_fmts = 1;
>>>>  +
>>>>  +    return input_fmts;
>>>>  +}
>>>>  +
>>>>  +static void it66121_bridge_enable(struct drm_bridge *bridge)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>>>>  +
>>>>  +    it66121_set_mute(ctx, false);
>>>>  +}
>>>>  +
>>>>  +static void it66121_bridge_disable(struct drm_bridge *bridge)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>>>>  +
>>>>  +    it66121_set_mute(ctx, true);
>>>>  +}
>>>>  +
>>>>  +static
>>>>  +void it66121_bridge_mode_set(struct drm_bridge *bridge,
>>>>  +                 const struct drm_display_mode *mode,
>>>>  +                 const struct drm_display_mode *adjusted_mode)
>>>>  +{
>>>>  +    int ret, i;
>>>>  +    u8 buf[HDMI_INFOFRAME_SIZE(AVI)];
>>>>  +    struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>>>>  +    const u16 aviinfo_reg[HDMI_AVI_INFOFRAME_SIZE] = {
>>>>  +        IT66121_AVIINFO_DB1_REG,
>>>>  +        IT66121_AVIINFO_DB2_REG,
>>>>  +        IT66121_AVIINFO_DB3_REG,
>>>>  +        IT66121_AVIINFO_DB4_REG,
>>>>  +        IT66121_AVIINFO_DB5_REG,
>>>>  +        IT66121_AVIINFO_DB6_REG,
>>>>  +        IT66121_AVIINFO_DB7_REG,
>>>>  +        IT66121_AVIINFO_DB8_REG,
>>>>  +        IT66121_AVIINFO_DB9_REG,
>>>>  +        IT66121_AVIINFO_DB10_REG,
>>>>  +        IT66121_AVIINFO_DB11_REG,
>>>>  +        IT66121_AVIINFO_DB12_REG,
>>>>  +        IT66121_AVIINFO_DB13_REG
>>>>  +    };
>>>>  +
>>>>  +    mutex_lock(&ctx->lock);
>>>>  +
>>>>  +    hdmi_avi_infoframe_init(&ctx->hdmi_avi_infoframe);
>>>>  +
>>>>  +    ret = drm_hdmi_avi_infoframe_from_display_mode(&ctx->hdmi_avi_infoframe, &ctx->connector,
>>>>  +                               adjusted_mode);
>>>>  +    if (ret) {
>>>>  +        DRM_ERROR("Failed to setup AVI infoframe: %d\n", ret);
>>>>  +        goto unlock;
>>>>  +    }
>>>>  +
>>>>  +    ret = hdmi_avi_infoframe_pack(&ctx->hdmi_avi_infoframe, buf, sizeof(buf));
>>>>  +    if (ret < 0) {
>>>>  +        DRM_ERROR("Failed to pack infoframe: %d\n", ret);
>>>>  +        goto unlock;
>>>>  +    }
>>>>  +
>>>>  +    /* Write new AVI infoframe packet */
>>>>  +    for (i = 0; i < HDMI_AVI_INFOFRAME_SIZE; i++) {
>>>>  +        if (regmap_write(ctx->regmap, aviinfo_reg[i], buf[i + HDMI_INFOFRAME_HEADER_SIZE]))
>>>>  +            goto unlock;
>>>>  +    }
>>>>  +    if (regmap_write(ctx->regmap, IT66121_AVIINFO_CSUM_REG, buf[3]))
>>>>  +        goto unlock;
>>>>  +
>>>>  +    /* Enable AVI infoframe */
>>>>  +    if (regmap_write(ctx->regmap, IT66121_AVI_INFO_PKT_REG,
>>>>  +             IT66121_AVI_INFO_PKT_ON | IT66121_AVI_INFO_PKT_RPT))
>>>>  +        goto unlock;
>>>>  +
>>>>  +    /* Set TX mode to HDMI */
>>>>  +    if (regmap_write(ctx->regmap, IT66121_HDMI_MODE_REG, IT66121_HDMI_MODE_HDMI))
>>>>  +        goto unlock;
>>>>  +
>>>>  +    if (regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG,
>>>>  +                  IT66121_CLK_BANK_PWROFF_TXCLK, IT66121_CLK_BANK_PWROFF_TXCLK))
>>>>  +        goto unlock;
>>>>  +
>>>>  +    if (it66121_configure_input(ctx))
>>>>  +        goto unlock;
>>>>  +
>>>>  +    if (it66121_configure_afe(ctx, adjusted_mode))
>>>>  +        goto unlock;
>>>>  +
>>>>  +    regmap_write_bits(ctx->regmap, IT66121_CLK_BANK_REG, IT66121_CLK_BANK_PWROFF_TXCLK, 0);
>>>>  +
>>>>  +unlock:
>>>>  +    mutex_unlock(&ctx->lock);
>>>>  +}
>>>>  +
>>>>  +static enum drm_mode_status it66121_bridge_mode_valid(struct drm_bridge *bridge,
>>>>  +                              const struct drm_display_info *info,
>>>>  +                              const struct drm_display_mode *mode)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>>>>  +
>>>>  +    return it66121_mode_valid(ctx, mode);
>>>>  +}
>>>>  +
>>>>  +static enum drm_connector_status it66121_bridge_detect(struct drm_bridge *bridge)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>>>>  +
>>>>  +    return it66121_is_hpd_detect(ctx) ? connector_status_connected
>>>>  +                      : connector_status_disconnected;
>>>>  +}
>>>>  +
>>>>  +static struct edid *it66121_bridge_get_edid(struct drm_bridge *bridge,
>>>>  +                        struct drm_connector *connector)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = container_of(bridge, struct it66121_ctx, bridge);
>>>>  +    struct edid *edid;
>>>>  +
>>>>  +    mutex_lock(&ctx->lock);
>>>>  +    edid = drm_do_get_edid(connector, it66121_get_edid_block, ctx);
>>>>  +    mutex_unlock(&ctx->lock);
>>>>  +
>>>>  +    return edid;
>>>>  +}
>>>>  +
>>>>  +static const struct drm_bridge_funcs it66121_bridge_funcs = {
>>>>  +    .attach = it66121_bridge_attach,
>>>>  +    .enable = it66121_bridge_enable,
>>>>  +    .disable = it66121_bridge_disable,
>>>>  +    .mode_set = it66121_bridge_mode_set,
>>>>  +    .mode_valid = it66121_bridge_mode_valid,
>>>>  +    .detect = it66121_bridge_detect,
>>>>  +    .get_edid = it66121_bridge_get_edid,
>>>>  +    .atomic_get_output_bus_fmts = it66121_bridge_atomic_get_output_bus_fmts,
>>>>  +    .atomic_get_input_bus_fmts = it66121_bridge_atomic_get_input_bus_fmts,
>>>>  +};
>>>>  +
>>>>  +static irqreturn_t it66121_irq_threaded_handler(int irq, void *dev_id)
>>>>  +{
>>>>  +    int ret;
>>>>  +    unsigned int val;
>>>>  +    struct it66121_ctx *ctx = dev_id;
>>>>  +    struct device *dev = ctx->dev;
>>>>  +    bool event = false;
>>>>  +
>>>>  +    mutex_lock(&ctx->lock);
>>>>  +
>>>>  +    ret = regmap_read(ctx->regmap, IT66121_SYS_STATUS_REG, &val);
>>>>  +    if (ret)
>>>>  +        goto unlock;
>>>>  +
>>>>  +    if (!(val & IT66121_SYS_STATUS_ACTIVE_IRQ))
>>>>  +        goto unlock;
>>>>  +
>>>>  +    ret = regmap_read(ctx->regmap, IT66121_INT_STATUS1_REG, &val);
>>>>  +    if (ret) {
>>>>  +        dev_err(dev, "Cannot read STATUS1_REG %d\n", ret);
>>>>  +    } else {
>>>>  +        if (val & IT66121_INT_STATUS1_DDC_FIFOERR)
>>>>  +            it66121_clear_ddc_fifo(ctx);
>>>>  +        if (val & (IT66121_INT_STATUS1_DDC_BUSHANG |
>>>>  +               IT66121_INT_STATUS1_DDC_NOACK))
>>>>  +            it66121_abort_ddc_ops(ctx);
>>>>  +        if (val & IT66121_INT_STATUS1_HPD_STATUS) {
>>>>  +            regmap_write_bits(ctx->regmap, IT66121_INT_CLR1_REG,
>>>>  +                      IT66121_INT_CLR1_HPD, IT66121_INT_CLR1_HPD);
>>>>  +
>>>>  +            if (!it66121_is_hpd_detect(ctx)) {
>>>>  +                kfree(ctx->edid);
>>>>  +                ctx->edid = NULL;
>>>>  +            }
>>>>  +
>>>>  +            event = true;
>>>>  +        }
>>>>  +    }
>>>>  +
>>>>  +    regmap_write_bits(ctx->regmap, IT66121_SYS_STATUS_REG,
>>>>  +              IT66121_SYS_STATUS_CLEAR_IRQ,
>>>>  +              IT66121_SYS_STATUS_CLEAR_IRQ);
>>>>  +
>>>>  +unlock:
>>>>  +    mutex_unlock(&ctx->lock);
>>>>  +
>>>>  +    if (event)
>>>>  +        drm_helper_hpd_irq_event(ctx->bridge.dev);
>>>>  +
>>>>  +    return IRQ_HANDLED;
>>>>  +}
>>>>  +
>>>>  +static int it66121_probe(struct i2c_client *client,
>>>>  +             const struct i2c_device_id *id)
>>>>  +{
>>>>  +    u32 vendor_ids[2], device_ids[2], revision_id;
>>>>  +    struct device_node *ep;
>>>>  +    int ret;
>>>>  +    struct it66121_ctx *ctx;
>>>>  +    struct device *dev = &client->dev;
>>>>  +
>>>>  +    if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
>>>>  +        dev_err(dev, "I2C check functionality failed.\n");
>>>>  +        return -ENXIO;
>>>>  +    }
>>>>  +
>>>>  +    ep = of_graph_get_endpoint_by_regs(dev->of_node, 0, 0);
>>>>  +    if (!ep)
>>>>  +        return -EINVAL;
>>>>  +
>>>>  +    ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>>>>  +    if (!ctx)
>>>>  +        return -ENOMEM;
>>>>  +
>>>>  +    ctx->dev = dev;
>>>>  +    ctx->client = client;
>>>>  +
>>>>  +    of_property_read_u32(ep, "bus-width", &ctx->bus_width);
>>>>  +    of_node_put(ep);
>>>>  +
>>>>  +    if (ctx->bus_width != 12 && ctx->bus_width != 24)
>>>>  +        return -EINVAL;
>>>>  +
>>>>  +    i2c_set_clientdata(client, ctx);
>>>>  +    mutex_init(&ctx->lock);
>>>>  +
>>>>  +    ctx->supplies[0].supply = "vcn33";
>>>>  +    ctx->supplies[1].supply = "vcn18";
>>>>  +    ctx->supplies[2].supply = "vrf12";
>>>>  +    ret = devm_regulator_bulk_get(ctx->dev, 3, ctx->supplies);
>>>>  +    if (ret) {
>>>>  +        dev_err(ctx->dev, "regulator_bulk failed\n");
>>>>  +        return ret;
>>>>  +    }
>>>>  +
>>>>  +    ret = ite66121_power_on(ctx);
>>>>  +    if (ret)
>>>>  +        return ret;
>>>>  +
>>>>  +    it66121_hw_reset(ctx);
>>>>  +
>>>>  +    ctx->regmap = devm_regmap_init_i2c(client, &it66121_regmap_config);
>>>>  +    if (IS_ERR(ctx->regmap)) {
>>>>  +        ite66121_power_off(ctx);
>>>>  +        return PTR_ERR(ctx);
>>>>  +    }
>>>>  +
>>>>  +    regmap_read(ctx->regmap, IT66121_VENDOR_ID0_REG, &vendor_ids[0]);
>>>>  +    regmap_read(ctx->regmap, IT66121_VENDOR_ID1_REG, &vendor_ids[1]);
>>>>  +    regmap_read(ctx->regmap, IT66121_DEVICE_ID0_REG, &device_ids[0]);
>>>>  +    regmap_read(ctx->regmap, IT66121_DEVICE_ID1_REG, &device_ids[1]);
>>>>  +
>>>>  +    /* Revision is shared with DEVICE_ID1 */
>>>>  +    revision_id = FIELD_GET(IT66121_REVISION_MASK, device_ids[1]);
>>>>  +    device_ids[1] &= IT66121_DEVICE_ID1_MASK;
>>>>  +
>>>>  +    if (vendor_ids[0] != IT66121_VENDOR_ID0 || vendor_ids[1] != IT66121_VENDOR_ID1 ||
>>>>  +        device_ids[0] != IT66121_DEVICE_ID0 || device_ids[1] != IT66121_DEVICE_ID1) {
>>>>  +        ite66121_power_off(ctx);
>>>>  +        return -ENODEV;
>>>>  +    }
>>>>  +
>>>>  +    ctx->bridge.funcs = &it66121_bridge_funcs;
>>>>  +    ctx->bridge.of_node = dev->of_node;
>>>>  +
>>>>  +    ret = devm_request_threaded_irq(dev, client->irq, NULL,    it66121_irq_threaded_handler,
>>>>  +                    IRQF_SHARED | IRQF_ONESHOT, dev_name(dev), ctx);
>>>>  +    if (ret < 0) {
>>>>  +        dev_err(dev, "Failed to request irq %d:%d\n", client->irq, ret);
>>>>  +        ite66121_power_off(ctx);
>>>>  +        return ret;
>>>>  +    }
>>>>  +
>>>>  +    drm_bridge_add(&ctx->bridge);
>>>>  +
>>>>  +    dev_info(ctx->dev, "IT66121 revision %d probed\n", revision_id);
>>>>  +
>>>>  +    return 0;
>>>>  +}
>>>>  +
>>>>  +static int it66121_remove(struct i2c_client *client)
>>>>  +{
>>>>  +    struct it66121_ctx *ctx = i2c_get_clientdata(client);
>>>>  +
>>>>  +    ite66121_power_off(ctx);
>>>>  +    drm_bridge_remove(&ctx->bridge);
>>>>  +    kfree(ctx->edid);
>>>>  +    mutex_destroy(&ctx->lock);
>>>>  +
>>>>  +    return 0;
>>>>  +}
>>>>  +
>>>>  +static const struct of_device_id it66121_dt_match[] = {
>>>>  +    { .compatible = "ite,it66121" },
>>>>  +    { }
>>>>  +};
>>>>  +MODULE_DEVICE_TABLE(of, it66121_dt_match);
>>>>  +
>>>>  +static const struct i2c_device_id it66121_id[] = {
>>>>  +    { "it66121", 0 },
>>>>  +    { }
>>>>  +};
>>>>  +MODULE_DEVICE_TABLE(i2c, it66121_id);
>>>>  +
>>>>  +static struct i2c_driver it66121_driver = {
>>>>  +    .driver = {
>>>>  +        .name    = "it66121",
>>>>  +        .of_match_table = it66121_dt_match,
>>>>  +    },
>>>>  +    .probe = it66121_probe,
>>>>  +    .remove = it66121_remove,
>>>>  +    .id_table = it66121_id,
>>>>  +};
>>>>  +
>>>>  +module_i2c_driver(it66121_driver);
>>>>  +
>>>>  +MODULE_AUTHOR("Phong LE");
>>>>  +MODULE_DESCRIPTION("IT66121 HDMI transmitter driver");
>>>>  +MODULE_LICENSE("GPL v2");
>>>>  --
>>>>  2.25.1
>>>>
>>>
>>>
> 
> 

