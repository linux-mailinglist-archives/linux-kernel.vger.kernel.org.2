Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB66315B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbhBJAg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:36:58 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:41349 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbhBIUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:49:17 -0500
Received: by mail-ot1-f52.google.com with SMTP id s107so18740457otb.8;
        Tue, 09 Feb 2021 12:48:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6GfRCsmy7FJEj63mhoY+V+O3PvN7JiICzZ8IwcVEyCU=;
        b=j8k6xngKhUU4RUGH3d5ZS8tHa3cCe+uJSp4zZYPvAxeY6mJ7dhNv0aHCz2hP67yVSq
         +4pdx8V3wSQ2RDZvBQd173lEysRlSnPxrba4fi00XJODQ/IKM+jsl+0Hk1NTZs6UZ1JQ
         m7JDvKkrydK2bq8ac7Q1GMKWa8abKZtyiFxliY8mqsZyvekjYMFZZBT/Vd2BHP63wUZ0
         tKNiQLMEuiu7EQHzg8t2+cbXa9EYJoRAsUnwPQ02eyDpQNUS33vSK5uvJ8LrlspQEyfq
         L1VMH1Ybz/ZfZqnodh+M792SWPmK2dMFAHl4w57dhlcuqji7Oy4DfsQTxRzo9NFQT06h
         lfjQ==
X-Gm-Message-State: AOAM532PDynB+WBqmPVdFEO2wHkZ3tcv2JyCLeQ17QinT+9kxA2z3lHG
        I/L8yi81k0EeV104xUybtA==
X-Google-Smtp-Source: ABdhPJxhyGab36VocoyC8HQ3QP0wYUMPGADBulPSTA+DfJ3gz0WxubjQ1ZAnu7tf9zmm5qDOSlcdVw==
X-Received: by 2002:a9d:65d4:: with SMTP id z20mr17893027oth.349.1612903709536;
        Tue, 09 Feb 2021 12:48:29 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z30sm1043647otj.61.2021.02.09.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:48:28 -0800 (PST)
Received: (nullmailer pid 150932 invoked by uid 1000);
        Tue, 09 Feb 2021 20:48:27 -0000
Date:   Tue, 9 Feb 2021 14:48:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org, Min Guo <min.guo@mediatek.com>
Subject: Re: [PATCH next v3 04/16] dt-bindings: phy: mediatek: hdmi-phy:
 modify compatible items
Message-ID: <20210209204827.GA150874@robh.at.kernel.org>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
 <20210201070016.41721-4-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070016.41721-4-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 15:00:04 +0800, Chunfeng Yun wrote:
> mt7623-hdmi-tx is compatible to mt2701-hdmi-tx, and the compatible
> "mediatek,mt7623-hdmi-tx" is not supported in driver, in fact uses
> "mediatek,mt2701-hdmi-tx" instead on MT7623, so changes the
> compatible items to make dependence clear.
> 
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: modify commit message
> v2: no changes
> ---
>  .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml    | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
