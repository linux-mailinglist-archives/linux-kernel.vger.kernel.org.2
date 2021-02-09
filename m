Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED393315B56
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbhBJAfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:35:19 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:33676 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhBIUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:49:52 -0500
Received: by mail-oi1-f178.google.com with SMTP id g84so7114941oib.0;
        Tue, 09 Feb 2021 12:49:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kZg0YSVP+RYC0Ye5U9uEUqshiAXagYrgvYF8cSBhWZY=;
        b=JKKbStCRj7DvLMeetkU+1+BvqXl3ECZDHTbkZbCm6AlcXrtt8Vsx1uvU7OPn6hiNYJ
         npvnrzbAIf0ZY34D2NC66gttCx2iT2q+bzPeqZ/T+SNj5ZLVJFVjnAaERe/04qpx6KiN
         G/0puOL77rsRIavRGAiYTE9n4+Joh29aigRPLtyErTruuSUHutik8GHcBZFt1Gr6o81f
         ji2iDi98c83HGwFnETv083jP86VXr1JJM4mBkKUxZaoIWfekM4ZJLSLJVW682dKh3zxU
         +6Sk0/Wnq+Fg+DFdqEWC+nl8C1aD8OETqWoA4J8tpfBcfmCSkJunMRp+hi2v0C7hUpAa
         z5QA==
X-Gm-Message-State: AOAM530S/Gq/XpX23Q6mgFKzEeoBSbHHq/isWU/etmUSmfqa78WBA/ut
        urN/nFFJOl2fALyQ+Nfkcg==
X-Google-Smtp-Source: ABdhPJxzW2te9n33SGwrMlyb8WB/trBkbriR0NJ2iQxRfdRAYmb9sJYZ1n8iOYmAEjuyjkBSjpVSqA==
X-Received: by 2002:a05:6808:5cf:: with SMTP id d15mr3589604oij.69.1612903743737;
        Tue, 09 Feb 2021 12:49:03 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l67sm1090581oih.57.2021.02.09.12.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:49:02 -0800 (PST)
Received: (nullmailer pid 152013 invoked by uid 1000);
        Tue, 09 Feb 2021 20:49:00 -0000
Date:   Tue, 9 Feb 2021 14:49:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-usb@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Min Guo <min.guo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH next v3 05/16] dt-bindings: phy: mediatek: tphy: change
 patternProperties
Message-ID: <20210209204900.GA151981@robh.at.kernel.org>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
 <20210201070016.41721-5-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070016.41721-5-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 15:00:05 +0800, Chunfeng Yun wrote:
> The phy may be named as pcie-phy when the T-PHY only supports
> PCIe mode, it's also the similar case for SATA, named as
> sata-phy.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v3: no changes
> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
