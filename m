Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEE845ED8F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377298AbhKZMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377428AbhKZMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:10:55 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165E9C061D78;
        Fri, 26 Nov 2021 03:36:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8C3911F46833
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637926565; bh=GIN8NoFGOSznfLIa1UX7Cx0wpd48djpTS3XTrBwxP9Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lZK3eP0ZA/iBWLFpQoU5OPkTE18dCbYBdQ1mKszmuTulvkifopnqeZp8OsEiv7GAu
         RCLdmKj/fK+LVGYjHBz2bPbpRyE/ZwiSjLnqbQQ7i9dVX6+Fd51wThoFc7zVOspUyP
         JO3+KR/f5O6qTgVzDQZZK5nmlcSCuncVTz/86w99gOT+sr+G/tScpGIJG1+81z5DFq
         lvz//6jrIxmZx6zGp5gMs2cUVe1nrcpemkjLq+qZ09/EQGyd5+RBPOnLJ/AlnILeBZ
         kmpbUnkcZfAkpR/wrRkFXllVKynfJplCP7ERDwfclm3DFRoVTmE+LVUIenUy4vpLiY
         x4i9nW99BwfMw==
Subject: Re: [PATCH v6 1/3] dt-bindings: mediatek: add adsp-mbox document
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>, tzungbi@google.com,
        cujomalainey@google.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        sound-open-firmware@alsa-project.org
References: <20211126093021.25462-1-allen-kh.cheng@mediatek.com>
 <20211126093021.25462-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <56c862fd-2fc3-4cbb-97a8-154a9faabd6f@collabora.com>
Date:   Fri, 26 Nov 2021 12:36:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211126093021.25462-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/11/21 10:30, allen-kh.cheng ha scritto:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This patch adds document for mediatek adsp mbox
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>   .../bindings/mailbox/mtk,adsp-mbox.yaml       | 52 +++++++++++++++++++
>   1 file changed, 52 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
> new file mode 100644
> index 000000000000..a0149566ae56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mtk,adsp-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek ADSP mailbox
> +
> +maintainers:
> +  - Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> +
> +description: |
> +  The MTK ADSP mailbox Inter-Processor Communication (IPC) enables the SoC
> +  to ommunicate with ADSP by passing messages through two mailbox channels.
> +  The MTK ADSP mailbox IPC also provides the ability for one processor to
> +  signal the other processor using interrupts.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-adsp-mbox
> +
> +  "#mbox-cells":
> +    const: 0
> +
> +  reg:
> +    description:
> +      Physical address base for dsp mbox base registers.
> +
> +  interrupts:
> +    description:
> +      adsp mbox interrupt
> +
> +required:
> +  - compatible
> +  - "#mbox-cells"
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    adsp_mailbox0:adsp_mailbox0@10816000 {

This should be:

adsp_mailbox0: mailbox@10816000 {

> +        compatible = "mediatek,mt8195-adsp-mbox";
> +        #mbox-cells = <0>;
> +        reg = <0x10816000 0x1000>;
> +        interrupts = <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH 0>;
> +    };
> 

Regards,
- Angelo
