Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B854B3AD375
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 22:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhFRUTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 16:19:32 -0400
Received: from mail-oo1-f50.google.com ([209.85.161.50]:45605 "EHLO
        mail-oo1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFRUTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 16:19:30 -0400
Received: by mail-oo1-f50.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso2735372ooc.12;
        Fri, 18 Jun 2021 13:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=at8Myk4DsreoksXWhWhn1VfubfRyMhmgM5RY9nidd0I=;
        b=qrX8Z2HvN1D4cQ2CB01pRIzJ7f1xHkPoVPMZzl0XMHWG8EmQmv6l3UXakiNCdtKu/7
         TkyvDn1R8p6hGYRI/92vHfq/RMkmib9/cP86qMdBMW6+BKi6aj7jIcItGQWjByP2qq7x
         T7yrkIuB/DgM6++GODo5H7d4OP2gwnOcf4Mcd6LTBWLIEfC54r7VknHuBkuZKEERnftQ
         lVko8LsNUsm4ALui85z8WSR8jKm9RTg/jTbHdxhhLCgaFUMaEIUBJjrNa56JayHqaJsP
         goGoYA2dsmn8Alus1FrnhlBhI+SrFJfdGGvFwsxL3ATSvVdbA+lFk++2vMydGOBHU5JH
         J9Ng==
X-Gm-Message-State: AOAM530SJ7DrecioWfO0YDyfgOXKdRkMtfhMPz4gNp0tgtqzFA9N4S2O
        HvnR7SCsyoHVoU8FpF9kREXnKs7c5w==
X-Google-Smtp-Source: ABdhPJxqFEA9rXPOgW7E10gTRzwgMNK+lYYml+/GsKKYEMjiCcf2jlqnug3lBLGqDZKwbY45tBWPmw==
X-Received: by 2002:a4a:97ed:: with SMTP id x42mr10401939ooi.49.1624047440838;
        Fri, 18 Jun 2021 13:17:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r12sm1243890otc.38.2021.06.18.13.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:17:20 -0700 (PDT)
Received: (nullmailer pid 2808537 invoked by uid 1000);
        Fri, 18 Jun 2021 20:17:18 -0000
Date:   Fri, 18 Jun 2021 14:17:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     bjorn.andersson@linaro.org, broonie@kernel.org,
        plai@codeaurora.org, tiwai@suse.de, devicetree@vger.kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        bgoswami@codeaurora.org
Subject: Re: [RFC PATCH 05/13] ASoC: qcom: audioreach: add q6apm support
Message-ID: <20210618201718.GA2807622@robh.at.kernel.org>
References: <20210607152836.17154-1-srinivas.kandagatla@linaro.org>
 <20210607152836.17154-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607152836.17154-6-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 04:28:28PM +0100, Srinivas Kandagatla wrote:
> Add support to q6apm (Audio Process Manager) component which is
> core Audioreach service running in the DSP.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  include/dt-bindings/sound/qcom,q6apm.h | 215 ++++++++

This goes in the binding patch.

>  sound/soc/qcom/audioreach/Makefile     |   2 +-
>  sound/soc/qcom/audioreach/audioreach.c | 252 +++++++++
>  sound/soc/qcom/audioreach/audioreach.h |   6 +
>  sound/soc/qcom/audioreach/q6apm.c      | 695 +++++++++++++++++++++++++
>  sound/soc/qcom/audioreach/q6apm.h      | 171 ++++++
>  6 files changed, 1340 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/sound/qcom,q6apm.h
>  create mode 100644 sound/soc/qcom/audioreach/q6apm.c
>  create mode 100644 sound/soc/qcom/audioreach/q6apm.h
> 
> diff --git a/include/dt-bindings/sound/qcom,q6apm.h b/include/dt-bindings/sound/qcom,q6apm.h
> new file mode 100644
> index 000000000000..38e3a426b15a
> --- /dev/null
> +++ b/include/dt-bindings/sound/qcom,q6apm.h
> @@ -0,0 +1,215 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Dual license.

> +#ifndef __DT_BINDINGS_Q6_APM_H__
> +#define __DT_BINDINGS_Q6_APM_H__
> +
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA1	1
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA2	2
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA3	3
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA4	4
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA5	5
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA6	6
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA7	7
> +#define	MSM_FRONTEND_DAI_MULTIMEDIA8	8
> +
> +/* Audio Process Manager (APM) virtual ports IDs */
> +#define HDMI_RX		1
> +#define SLIMBUS_0_RX    2
> +#define SLIMBUS_0_TX    3
> +#define SLIMBUS_1_RX    4
> +#define SLIMBUS_1_TX    5
> +#define SLIMBUS_2_RX    6
> +#define SLIMBUS_2_TX    7
> +#define SLIMBUS_3_RX    8
> +#define SLIMBUS_3_TX    9
> +#define SLIMBUS_4_RX    10
> +#define SLIMBUS_4_TX    11
> +#define SLIMBUS_5_RX    12
> +#define SLIMBUS_5_TX    13
> +#define SLIMBUS_6_RX    14
> +#define SLIMBUS_6_TX    15
> +#define PRIMARY_MI2S_RX		16
> +#define PRIMARY_MI2S_TX		17
> +#define SECONDARY_MI2S_RX	18
> +#define SECONDARY_MI2S_TX	19
> +#define TERTIARY_MI2S_RX	20
> +#define TERTIARY_MI2S_TX	21
> +#define QUATERNARY_MI2S_RX	22
> +#define QUATERNARY_MI2S_TX	23
> +#define PRIMARY_TDM_RX_0	24
> +#define PRIMARY_TDM_TX_0	25
> +#define PRIMARY_TDM_RX_1	26
> +#define PRIMARY_TDM_TX_1	27
> +#define PRIMARY_TDM_RX_2	28
> +#define PRIMARY_TDM_TX_2	29
> +#define PRIMARY_TDM_RX_3	30
> +#define PRIMARY_TDM_TX_3	31
> +#define PRIMARY_TDM_RX_4	32
> +#define PRIMARY_TDM_TX_4	33
> +#define PRIMARY_TDM_RX_5	34
> +#define PRIMARY_TDM_TX_5	35
> +#define PRIMARY_TDM_RX_6	36
> +#define PRIMARY_TDM_TX_6	37
> +#define PRIMARY_TDM_RX_7	38
> +#define PRIMARY_TDM_TX_7	39
> +#define SECONDARY_TDM_RX_0	40
> +#define SECONDARY_TDM_TX_0	41
> +#define SECONDARY_TDM_RX_1	42
> +#define SECONDARY_TDM_TX_1	43
> +#define SECONDARY_TDM_RX_2	44
> +#define SECONDARY_TDM_TX_2	45
> +#define SECONDARY_TDM_RX_3	46
> +#define SECONDARY_TDM_TX_3	47
> +#define SECONDARY_TDM_RX_4	48
> +#define SECONDARY_TDM_TX_4	49
> +#define SECONDARY_TDM_RX_5	50
> +#define SECONDARY_TDM_TX_5	51
> +#define SECONDARY_TDM_RX_6	52
> +#define SECONDARY_TDM_TX_6	53
> +#define SECONDARY_TDM_RX_7	54
> +#define SECONDARY_TDM_TX_7	55
> +#define TERTIARY_TDM_RX_0	56
> +#define TERTIARY_TDM_TX_0	57
> +#define TERTIARY_TDM_RX_1	58
> +#define TERTIARY_TDM_TX_1	59
> +#define TERTIARY_TDM_RX_2	60
> +#define TERTIARY_TDM_TX_2	61
> +#define TERTIARY_TDM_RX_3	62
> +#define TERTIARY_TDM_TX_3	63
> +#define TERTIARY_TDM_RX_4	64
> +#define TERTIARY_TDM_TX_4	65
> +#define TERTIARY_TDM_RX_5	66
> +#define TERTIARY_TDM_TX_5	67
> +#define TERTIARY_TDM_RX_6	68
> +#define TERTIARY_TDM_TX_6	69
> +#define TERTIARY_TDM_RX_7	70
> +#define TERTIARY_TDM_TX_7	71
> +#define QUATERNARY_TDM_RX_0	72
> +#define QUATERNARY_TDM_TX_0	73
> +#define QUATERNARY_TDM_RX_1	74
> +#define QUATERNARY_TDM_TX_1	75
> +#define QUATERNARY_TDM_RX_2	76
> +#define QUATERNARY_TDM_TX_2	77
> +#define QUATERNARY_TDM_RX_3	78
> +#define QUATERNARY_TDM_TX_3	79
> +#define QUATERNARY_TDM_RX_4	80
> +#define QUATERNARY_TDM_TX_4	81
> +#define QUATERNARY_TDM_RX_5	82
> +#define QUATERNARY_TDM_TX_5	83
> +#define QUATERNARY_TDM_RX_6	84
> +#define QUATERNARY_TDM_TX_6	85
> +#define QUATERNARY_TDM_RX_7	86
> +#define QUATERNARY_TDM_TX_7	87
> +#define QUINARY_TDM_RX_0	88
> +#define QUINARY_TDM_TX_0	89
> +#define QUINARY_TDM_RX_1	90
> +#define QUINARY_TDM_TX_1	91
> +#define QUINARY_TDM_RX_2	92
> +#define QUINARY_TDM_TX_2	93
> +#define QUINARY_TDM_RX_3	94
> +#define QUINARY_TDM_TX_3	95
> +#define QUINARY_TDM_RX_4	96
> +#define QUINARY_TDM_TX_4	97
> +#define QUINARY_TDM_RX_5	98
> +#define QUINARY_TDM_TX_5	99
> +#define QUINARY_TDM_RX_6	100
> +#define QUINARY_TDM_TX_6	101
> +#define QUINARY_TDM_RX_7	102
> +#define QUINARY_TDM_TX_7	103
> +#define DISPLAY_PORT_RX		104
> +#define WSA_CODEC_DMA_RX_0	105
> +#define WSA_CODEC_DMA_TX_0	106
> +#define WSA_CODEC_DMA_RX_1	107
> +#define WSA_CODEC_DMA_TX_1	108
> +#define WSA_CODEC_DMA_TX_2	109
> +#define VA_CODEC_DMA_TX_0	110
> +#define VA_CODEC_DMA_TX_1	111
> +#define VA_CODEC_DMA_TX_2	112
> +#define RX_CODEC_DMA_RX_0	113
> +#define TX_CODEC_DMA_TX_0	114
> +#define RX_CODEC_DMA_RX_1	115
> +#define TX_CODEC_DMA_TX_1	116
> +#define RX_CODEC_DMA_RX_2	117
> +#define TX_CODEC_DMA_TX_2	118
> +#define RX_CODEC_DMA_RX_3	119
> +#define TX_CODEC_DMA_TX_3	120
> +#define RX_CODEC_DMA_RX_4	121
> +#define TX_CODEC_DMA_TX_4	122
> +#define RX_CODEC_DMA_RX_5	123
> +#define TX_CODEC_DMA_TX_5	124
> +#define RX_CODEC_DMA_RX_6	125
> +#define RX_CODEC_DMA_RX_7	126
> +
> +#define LPASS_CLK_ID_PRI_MI2S_IBIT	1
> +#define LPASS_CLK_ID_PRI_MI2S_EBIT	2
> +#define LPASS_CLK_ID_SEC_MI2S_IBIT	3
> +#define LPASS_CLK_ID_SEC_MI2S_EBIT	4
> +#define LPASS_CLK_ID_TER_MI2S_IBIT	5
> +#define LPASS_CLK_ID_TER_MI2S_EBIT	6
> +#define LPASS_CLK_ID_QUAD_MI2S_IBIT	7
> +#define LPASS_CLK_ID_QUAD_MI2S_EBIT	8
> +#define LPASS_CLK_ID_SPEAKER_I2S_IBIT	9
> +#define LPASS_CLK_ID_SPEAKER_I2S_EBIT	10
> +#define LPASS_CLK_ID_SPEAKER_I2S_OSR	11
> +#define LPASS_CLK_ID_QUI_MI2S_IBIT	12
> +#define LPASS_CLK_ID_QUI_MI2S_EBIT	13
> +#define LPASS_CLK_ID_SEN_MI2S_IBIT	14
> +#define LPASS_CLK_ID_SEN_MI2S_EBIT	15
> +#define LPASS_CLK_ID_INT0_MI2S_IBIT	16
> +#define LPASS_CLK_ID_INT1_MI2S_IBIT	17
> +#define LPASS_CLK_ID_INT2_MI2S_IBIT	18
> +#define LPASS_CLK_ID_INT3_MI2S_IBIT	19
> +#define LPASS_CLK_ID_INT4_MI2S_IBIT	20
> +#define LPASS_CLK_ID_INT5_MI2S_IBIT	21
> +#define LPASS_CLK_ID_INT6_MI2S_IBIT	22
> +#define LPASS_CLK_ID_QUI_MI2S_OSR	23
> +#define LPASS_CLK_ID_PRI_PCM_IBIT	24
> +#define LPASS_CLK_ID_PRI_PCM_EBIT	25
> +#define LPASS_CLK_ID_SEC_PCM_IBIT	26
> +#define LPASS_CLK_ID_SEC_PCM_EBIT	27
> +#define LPASS_CLK_ID_TER_PCM_IBIT	28
> +#define LPASS_CLK_ID_TER_PCM_EBIT	29
> +#define LPASS_CLK_ID_QUAD_PCM_IBIT	30
> +#define LPASS_CLK_ID_QUAD_PCM_EBIT	31
> +#define LPASS_CLK_ID_QUIN_PCM_IBIT	32
> +#define LPASS_CLK_ID_QUIN_PCM_EBIT	33
> +#define LPASS_CLK_ID_QUI_PCM_OSR	34
> +#define LPASS_CLK_ID_PRI_TDM_IBIT	35
> +#define LPASS_CLK_ID_PRI_TDM_EBIT	36
> +#define LPASS_CLK_ID_SEC_TDM_IBIT	37
> +#define LPASS_CLK_ID_SEC_TDM_EBIT	38
> +#define LPASS_CLK_ID_TER_TDM_IBIT	39
> +#define LPASS_CLK_ID_TER_TDM_EBIT	40
> +#define LPASS_CLK_ID_QUAD_TDM_IBIT	41
> +#define LPASS_CLK_ID_QUAD_TDM_EBIT	42
> +#define LPASS_CLK_ID_QUIN_TDM_IBIT	43
> +#define LPASS_CLK_ID_QUIN_TDM_EBIT	44
> +#define LPASS_CLK_ID_QUIN_TDM_OSR	45
> +#define LPASS_CLK_ID_MCLK_1		46
> +#define LPASS_CLK_ID_MCLK_2		47
> +#define LPASS_CLK_ID_MCLK_3		48
> +#define LPASS_CLK_ID_MCLK_4		49
> +#define LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE	50
> +#define LPASS_CLK_ID_INT_MCLK_0		51
> +#define LPASS_CLK_ID_INT_MCLK_1		52
> +#define LPASS_CLK_ID_MCLK_5		53
> +#define LPASS_CLK_ID_WSA_CORE_MCLK	54
> +#define LPASS_CLK_ID_WSA_CORE_NPL_MCLK	55
> +#define LPASS_CLK_ID_VA_CORE_MCLK	56
> +#define LPASS_CLK_ID_TX_CORE_MCLK	57
> +#define LPASS_CLK_ID_TX_CORE_NPL_MCLK	58
> +#define LPASS_CLK_ID_RX_CORE_MCLK	59
> +#define LPASS_CLK_ID_RX_CORE_NPL_MCLK	60
> +#define LPASS_CLK_ID_VA_CORE_2X_MCLK	61
> +
> +#define LPASS_HW_AVTIMER_VOTE		101
> +#define LPASS_HW_MACRO_VOTE		102
> +#define LPASS_HW_DCODEC_VOTE		103
> +
> +#define Q6APM_MAX_CLK_ID			104
> +
> +#define LPASS_CLK_ATTRIBUTE_INVALID		0x0
> +#define LPASS_CLK_ATTRIBUTE_COUPLE_NO		0x1
> +#define LPASS_CLK_ATTRIBUTE_COUPLE_DIVIDEND	0x2
> +#define LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR	0x3
> +
> +#endif /* __DT_BINDINGS_Q6_APM_H__ */
