Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657B741421B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 08:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhIVGqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 02:46:11 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:44424
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232770AbhIVGqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 02:46:09 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 59D7D3F226
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632293079;
        bh=PHpWlL5286L9Vy7vwwtJJDOqUvt0lVJtNPWSRo8nnkI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=X2tPR+GdMJEYpgN/lUT3nmnkcPVIYTt3aKblh1AYZR++NEA0fisxxTNEBo/xlggv+
         lPbS2lVmNuPPzXA/hLNj1pLCfhqLSAeyJYBmz3WuBPZ3SAmTsSnOH2MzVdiCljIlVc
         6zwToe9Mb4hckB429xPBWIJQY3MzGhteM3SXMY33sz8I9COX1AYafL6xHVCCY55aow
         qXGpoakfdhJ3D4t55/vo83PSgyq9QnhPZ+AEeI5u/NKWmfyBLNPu60LQySzYml9uXK
         jmkJstHdpkgSf9koyCKB6GqJvaZ02RAiSXaTF1SfNjgd5o3PHEneyLKBSl3EfoEgLJ
         3tEGlHxEbvTUA==
Received: by mail-wr1-f69.google.com with SMTP id v15-20020adff68f000000b0015df51efa18so1150220wrp.16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 23:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PHpWlL5286L9Vy7vwwtJJDOqUvt0lVJtNPWSRo8nnkI=;
        b=UKDqlkx9IIYUT608FwoNH6MkNiPTLJFUHgA1Mcj4LOL8l3tk9vA0FfILnXJv2X2X2p
         FVEvCMVGfzJXrDFgOS0r+eydntG38sjRLDHZlv0cCfVY+Eq++zQF9//NwrDENCK6qLV5
         krLJ+tE3Sm8sI0uYaNiHxrmHlsYMTeddk0tYZC7SzL0RKCypCvx7flQbqaTIXFZ3KCvK
         /F+Jy52sUw/0QX/fV66PqRCSD0Yw1Lyh0F6HWDl05Cujr4WXLJSzchlWDcKsPE14WWxi
         wQ0oiO/MQVLKOo5xZg2HFha8uqdjg4xgp+N+XrzLoyCccocOlkAD+lgcRlo0q0cH1ZO3
         Itqw==
X-Gm-Message-State: AOAM5310+Dq/5CFnEL6mcla2+VzslqpkM9eW70jlpMW6zJ0fjj2Cszpm
        bCc4PAydViVzLm+LNUp96GuJoyAAvoBk4SkD6Ms38dt+Cep1fEtn43yPDzMAec4pdRDtzPQsJXr
        CwifMSBgdyWuWwd2VQvgOwKqeOZVGjEsoVDzmt/bSDg==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr40411572wrb.237.1632293079013;
        Tue, 21 Sep 2021 23:44:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7X/xE8BOJMFBcSLMZa3NNLNdKake1etQzDd7PnPQEF6xSjGfjlZkAQpczOFislXeA7hs9uQ==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr40411555wrb.237.1632293078867;
        Tue, 21 Sep 2021 23:44:38 -0700 (PDT)
Received: from localhost.localdomain (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id g2sm1244554wrb.20.2021.09.21.23.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 23:44:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, youlin.pei@mediatek.com,
        srv_heupstream@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, anan.sun@mediatek.com,
        devicetree@vger.kernel.org, yi.kuo@mediatek.com,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        ming-fan.chen@mediatek.com, iommu@lists.linux-foundation.org,
        Ikjoon Jang <ikjn@chromium.org>, anthony.huang@mediatek.com
Subject: Re: [PATCH v4 00/13] MT8195 SMI support
Date:   Wed, 22 Sep 2021 08:44:01 +0200
Message-Id: <163229303729.7874.4095337797772755570.b4-ty@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914113703.31466-1-yong.wu@mediatek.com>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 19:36:50 +0800, Yong Wu wrote:
> This patchset mainly adds SMI support for mt8195.
> 
> Comparing with the previous version, add two new functions:
> a) add smi sub common
> b) add initial setting for smi-common and smi-larb.
> 
> Change note:
> v4:1) base on v5.15-rc1
>    2) In the dt-binding:
>       a. add "else mediatek,smi: false." in the yaml.
>       b. Remove mediatek,smi_sub_common. since we have only 2 level currently,
>       It should be smi-sub-common if that node has "mediatek,smi". otherwise,
>       it is smi-common.
> 
> [...]

Applied, thanks!

[01/13] dt-bindings: memory: mediatek: Add mt8195 smi binding
        commit: b01065eee432b3ae91a2c0aaab66c2cae2e9812d
[02/13] dt-bindings: memory: mediatek: Add mt8195 smi sub common
        commit: 599e681a31a2dfa7359b8e420a1157ed015f840b
[03/13] memory: mtk-smi: Use clk_bulk clock ops
        commit: 0e14917c57f9d8b9b7d4f41813849a29659447b3
[04/13] memory: mtk-smi: Rename smi_gen to smi_type
        commit: a5c18986f404206fdbc27f208620dc13bffb5657
[05/13] memory: mtk-smi: Adjust some code position
        commit: 534e0ad2ed4f9296a8c7ccb1a393bc4d5000dbad
[06/13] memory: mtk-smi: Add error handle for smi_probe
        commit: 30b869e77a1c626190bbbe6b4e5f5382b0102ac3
[07/13] memory: mtk-smi: Add device link for smi-sub-common
        commit: 47404757702ec8aa5c8310cdf58a267081f0ce6c
[08/13] memory: mtk-smi: Add clocks for smi-sub-common
        commit: 3e4f74e0ea5a6a6d6d825fd7afd8a10afbd1152c
[09/13] memory: mtk-smi: Use devm_platform_ioremap_resource
        commit: 912fea8bf8d854aef967c82a279ffd20be0326d7
[10/13] memory: mtk-smi: mt8195: Add smi support
        commit: cc4f9dcd9c1543394d6ee0d635551a2bd96bcacb
[11/13] memory: mtk-smi: mt8195: Add initial setting for smi-common
        commit: 431e9cab7097b5d5eb3cf2b04d4b12d272df85e0
[12/13] memory: mtk-smi: mt8195: Add initial setting for smi-larb
        commit: fe6dd2a4017d3dfbf4a530d95270a1d498a16a4c
[13/13] MAINTAINERS: Add entry for MediaTek SMI
        commit: 93403ede5aa4edeec2c63541b185d9c4fc9ae1e4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
