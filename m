Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 983BF349EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhCZBrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:47:18 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:43979 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhCZBqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:46:54 -0400
Received: by mail-il1-f176.google.com with SMTP id d2so3781147ilm.10;
        Thu, 25 Mar 2021 18:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jml2kqyjYBIczDmIBfoy96cm/TgFfWPNgcxRNXU69dI=;
        b=KCMSuKC20vOBaAC5b4WVy21Imbnr3xPNeNQ8UstQWPKNCAHb/hrvbIVkpFKiIQnNuh
         CogKGY61cKt+19V1EB7FrpHBNleXRGjdsd+Frnt/1GtbMK0MubYR9ANX94UDpXSn0d26
         mrVRkRKjVmiX1ewhA7J4lcaFCaP1ggDzY2S1J+UOwMNCpPXcfzwtksfsiNwR/PbLP9OR
         aMhHm4XnL+Puoh2p8Pml8rmZEsr4Sv3jAe7EuRkG2MmlP5QASVU8xiXhAj3OiHRkgzmG
         kCwjqfAJBwzrz+2wJbt21D6hK5YF6nlQtNffps5ZGCM92696b8/uvrJEFgQgXS4DrIvM
         sPwA==
X-Gm-Message-State: AOAM530sm1X/pXOuWu2ceUTBo46UUQLyb/f/ioBu1hXiUm+P1s83WDQF
        /+HIPx8VQq0YFY9mG0Xpmw==
X-Google-Smtp-Source: ABdhPJxnMHMYW+sT92LUqM9KxBk5gKQzviBp2iJdIJW/gnAj4T17Zfq1H0d06Csqf0VRkg9KBqqo8A==
X-Received: by 2002:a05:6e02:d46:: with SMTP id h6mr7810002ilj.80.1616723213741;
        Thu, 25 Mar 2021 18:46:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y15sm3364593ilv.70.2021.03.25.18.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:46:53 -0700 (PDT)
Received: (nullmailer pid 2155266 invoked by uid 1000);
        Fri, 26 Mar 2021 01:46:50 -0000
Date:   Thu, 25 Mar 2021 19:46:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-juniper
Message-ID: <20210326014650.GA2155214@robh.at.kernel.org>
References: <20210319035245.2751911-1-hsinyi@chromium.org>
 <20210319035245.2751911-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319035245.2751911-2-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2021 11:52:43 +0800, Hsin-Yi Wang wrote:
> mt8183-kukui-jacuzzi-juniper board also known as Acer Chromebook Spin 311,
> using mediatek mt8183 SoC.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
