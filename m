Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439EA346BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 23:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbhCWWIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 18:08:11 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:38901 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbhCWWHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 18:07:42 -0400
Received: by mail-io1-f53.google.com with SMTP id e8so19415106iok.5;
        Tue, 23 Mar 2021 15:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=duC2vQDOWTSfWZWv1lE7SGrANbWeUaoPK0ak3TfFKF0=;
        b=UXaYAF5NGg61/tEcud5q9Qn7WazSqNLCXMoc1kvLYmxXu913zO+TgNwe/Iw8FC4LvF
         jrtBu8QqK2fWEJeKWm052mDayrNVQQwqN6W+mG5tfpXBDnCL/vEU5JucTC5u7lqTtFEV
         s2DyEy3jfQzgkXJcI9MtpYMq49tsUJjSJ+Xkg8abB+jy5aVNoI+fdE+ICAmTGM6daafF
         O0f8/vbnaan7UipWxlLVJzrNmAxNILoisvA7kpILgOqcGLiBjPc6dd4Ji3LxINqI2mih
         x0x0D1Vv3mMp87RsQ+9UqNlmQWE6EZNTQ9PVCU4U3lRGC2PeeDMsFMpEEVEvaQ2y0mZq
         kyFQ==
X-Gm-Message-State: AOAM532F4RUOPryXXaR/KsgrLzEt/Bzl/uVNEUR9yylyaOzdux/C80LC
        eShK9khrJccihHda0v8FUw==
X-Google-Smtp-Source: ABdhPJx5CUAJFvnGhugiymB5gjr3DCufBCGz0JSxA6lD/EsVVv3Sx2P/b+bfSicGZK0xaQgaZWeOrQ==
X-Received: by 2002:a05:6602:1592:: with SMTP id e18mr178341iow.49.1616537262173;
        Tue, 23 Mar 2021 15:07:42 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id r5sm74223ilb.75.2021.03.23.15.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 15:07:41 -0700 (PDT)
Received: (nullmailer pid 1425584 invoked by uid 1000);
        Tue, 23 Mar 2021 22:07:40 -0000
Date:   Tue, 23 Mar 2021 16:07:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v8 1/3] dt-bindings: reset: microchip sparx5 reset driver
 bindings
Message-ID: <20210323220740.GA1425527@robh.at.kernel.org>
References: <20210316090839.3207930-1-steen.hegelund@microchip.com>
 <20210316090839.3207930-2-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316090839.3207930-2-steen.hegelund@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021 10:08:37 +0100, Steen Hegelund wrote:
> Document the Sparx5 reset device driver bindings
> 
> The driver uses a syscon and an IO range on sparx5 for access to
> the reset control and the reset status.
> 
> Sparx5 will no longer use the existing Ocelot chip reset driver, but use
> this new switch reset driver as it has the reset controller interface that
> allows the first client to perform the reset on behalf of all the Sparx5
> component drivers.
> 
> Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> ---
>  .../bindings/reset/microchip,rst.yaml         | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
