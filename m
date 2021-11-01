Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78A4442138
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhKAUCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:02:06 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35412 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:02:00 -0400
Received: by mail-ot1-f42.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so5981364otf.2;
        Mon, 01 Nov 2021 12:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RCn9gBg6NO4mGNPgVHHu6pp3N057Vgxif3opcrxgFSg=;
        b=us6m0lIi+cRW30UtuODP5crtln7sept0n7eMhFilA7ljbAom7B30yYp5YtRJh5/wEv
         x0sGBV/J/aE5BmK5KZccAiY1BfmGiTqp3AR3XOwKmsJQy8PTJJ0QrjNCswTeOzzLMpNz
         EFBxt1KSApInfc4qPxtWndZ7evJBFC2ACIFY2aGRNoIbN4ClvXV1rPOpgxIJGZhlCH7g
         lvdamWRbrUII5P8orZrfmyNHKLmMvAmBoPWe+vfNw/pa5ScDCG0re+pdO/qVAY8Pp6hL
         4bnzI/jcqDa/cFEJnTc5KeuxqErdLiu9Pedt36ekJ45vTGHiOX1Lioh6y05ZcNTShf26
         tjQw==
X-Gm-Message-State: AOAM530zm/knQW2NmrBT2xaQIqeTQtLQo1xfm3nkLTEBgxGP1ocwph5F
        Q1IOT28MXUV65TIBliY1vA==
X-Google-Smtp-Source: ABdhPJwc1aM/9qVaw5onZZ4k2IyW+NOM/C0jLpL0GyE/JrUPFMHC4/2qo258wQei7yo5FnVNxKmvVA==
X-Received: by 2002:a05:6830:19:: with SMTP id c25mr22864842otp.60.1635796766320;
        Mon, 01 Nov 2021 12:59:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t12sm3067730oiw.39.2021.11.01.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:59:25 -0700 (PDT)
Received: (nullmailer pid 936366 invoked by uid 1000);
        Mon, 01 Nov 2021 19:59:24 -0000
Date:   Mon, 1 Nov 2021 14:59:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     devicetree@vger.kernel.org, sboyd@kernel.org, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, maz@kernel.org, wells.lu@sunplus.com,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        broonie@kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: clock: Add bindings for SP7021 clock
 driver
Message-ID: <YYBHHJhFYaIFTRsn@robh.at.kernel.org>
References: <cover.1635737544.git.qinjian@cqplus1.com>
 <5b6062dfd2e5e6bbe940a87ba46ceb926f288546.1635737544.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b6062dfd2e5e6bbe940a87ba46ceb926f288546.1635737544.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021 13:01:55 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   |  38 ++++++
>  MAINTAINERS                                   |   2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 112 ++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
