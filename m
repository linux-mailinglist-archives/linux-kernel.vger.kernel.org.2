Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE22442134
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 20:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhKAUBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 16:01:37 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:43909 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAUBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 16:01:35 -0400
Received: by mail-oo1-f54.google.com with SMTP id x135-20020a4a418d000000b002b961605657so5951635ooa.10;
        Mon, 01 Nov 2021 12:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P4yf0/RJJTO707X28C6gjptjzJu306yuYyoatECp3Cw=;
        b=C571Ot8TVH3zmhjwI8IvQjxsKFpq6e+sLghzHvuXRuYRnYG6pBRiNlCtIT1MVpc/bG
         hdcdAjlxhGi4exTwimG0nCW7Nz5sTAz+1QGxHwUJTOsx6zWqzXeRw/OFih0X8n8aH/ox
         5q/9c/xMmxGvVRKe4HFIsdHHtFmmC+84/w/1qf6vkzkfhTmjDxG90Cj8e6nSSrDsHFjV
         TlCHOFU7jsgx4XBKzSFCjKrand0dv7U9ed5/sSBOsZz2pHTn1P38Cvwn8pHQ/malDY8T
         OUirGe6P/BBTC10ekeLm6KS0Wc9N7d5mVN9MRDZcJOP4wQO3jbUNXEB69qv36pElSAA4
         03UA==
X-Gm-Message-State: AOAM530V5oV1m49ijFRwaMUVyht54ClbwpCJzq/PiUuOnfw9mujXvGrM
        PZV3dajB4GKq4IPWZhEavw==
X-Google-Smtp-Source: ABdhPJxLufXU/SGbvCYYMWFNd6u844obE7VmFwQmuvxYzp2DmN8gLhbRUdLnq5m8FfpQtAd75RjNRA==
X-Received: by 2002:a05:6820:1622:: with SMTP id bb34mr9281532oob.93.1635796741776;
        Mon, 01 Nov 2021 12:59:01 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t12sm3591760oth.21.2021.11.01.12.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:59:00 -0700 (PDT)
Received: (nullmailer pid 935479 invoked by uid 1000);
        Mon, 01 Nov 2021 19:58:59 -0000
Date:   Mon, 1 Nov 2021 14:58:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, broonie@kernel.org,
        wells.lu@sunplus.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH v3 2/8] dt-bindings: arm: sunplus: Add bindings for
 Sunplus SP7021 SoC boards
Message-ID: <YYBHA/AEq3zvI4+N@robh.at.kernel.org>
References: <cover.1635737544.git.qinjian@cqplus1.com>
 <5d790d13fbe818504552054849646a7a19ae852a.1635737544.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d790d13fbe818504552054849646a7a19ae852a.1635737544.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021 13:01:52 +0800, Qin Jian wrote:
> This introduces bindings for boards based Sunplus SP7021 SoC.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  .../bindings/arm/sunplus,sp7021.yaml          | 27 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
