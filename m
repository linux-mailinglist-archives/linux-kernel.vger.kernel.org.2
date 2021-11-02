Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768314434BA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 18:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhKBRqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 13:46:17 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38800 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbhKBRqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 13:46:15 -0400
Received: by mail-oi1-f179.google.com with SMTP id bo10so4217281oib.5;
        Tue, 02 Nov 2021 10:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1T3840NthAg+NzqSwmuw7M3cighqIVRGGdTsN20/Ies=;
        b=TYMduyVR3YxyjL9pEFMKw1U6wMim/q0Qa8VlUBGlEmZiTnejIQMizEAf3VTagvoOPv
         MGpmd3sI3ehEjiDFWnpxrqZ4WCymJWfJhTXlNsqZdbD/tZVpwx+6/4fxaW/L7N2y+xKp
         y+RQ19Bt3RhX+rrVqJsz3OjDLG+CJGxsP+52x95b/felXBAcTCf4F89R2uW66eT0uDf7
         Z9vFv/yGygTmOYeJSdX+CEDlZsADzk3uzgIDGFrU9xQzi+6HKDymFzU6qfdSr3AXZpZH
         TLzsaD3zCj5zDRkxOaehe22G4rDl2wXyeepTOAyzHBNrowemS28NCBtDSqVZeyC1ryFh
         WjBw==
X-Gm-Message-State: AOAM530MoQ+/UkDYWGBl8cASErc1/Fy2+3Dp+SjXS2WIbtd5Dky9m+Kh
        rgU1Yjg4E/BYsqiOrY6Q0A==
X-Google-Smtp-Source: ABdhPJzrO50Y4/4GkGyHbeY+MZvvQN8+acMvreHLSq8/gloe/iF6NOGhwlsm3d6o+ATIPcwWFX6DZg==
X-Received: by 2002:a54:4f94:: with SMTP id g20mr6492412oiy.10.1635875019833;
        Tue, 02 Nov 2021 10:43:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k24sm539690oou.18.2021.11.02.10.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 10:43:38 -0700 (PDT)
Received: (nullmailer pid 3141437 invoked by uid 1000);
        Tue, 02 Nov 2021 17:43:38 -0000
Date:   Tue, 2 Nov 2021 12:43:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 7/8] dt-bindings: phy: uniphier-ahci: Add bindings for
 Pro4 SoC
Message-ID: <YYF4ygcYuLLILnji@robh.at.kernel.org>
References: <1635503947-18250-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1635503947-18250-8-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635503947-18250-8-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 19:39:06 +0900, Kunihiko Hayashi wrote:
> Update AHCI-PHY binding document for UniPhier Pro4 SoC. Add a compatible
> string, clock and reset lines for the SoC to the document.
> 
> Pro4 AHCI-PHY needs to control additional GIO clock line and reset lines
> ("pm", "tx", and "rx").
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/phy/socionext,uniphier-ahci-phy.yaml   | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
