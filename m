Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110BC415183
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237721AbhIVUkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:40:25 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39709 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbhIVUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:40:24 -0400
Received: by mail-ot1-f41.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so5365758ota.6;
        Wed, 22 Sep 2021 13:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X82q8E3VgYbOTACwRkDSN4yi4ZRfYfFimN3Vm/VTiiY=;
        b=OrC8tnZ7JRCA5EaliLZg9g3CWOL/+4Ubxe3rU/zkKE/bvFq97XUmM6AssG/ReoZd2N
         leD3At/kvaDlJm5F3xD7Fwxu1ZFuC2E3rvFzMPuu/7bJm2qhz+7Ks41uxJxya2+k7xNA
         aF2jKGxh/C8rpYsRqxZ4cCrb35LqZbh9rpdX3Zv/zolVMcgg5bjBbQt2Exis31X3MTmx
         Drq9FBJ34g9bUR4cx+yKUSstTmjOV/r2YkuHWuse5H/tDSx4rm7qjYWi+g3c7nj1L1vH
         qjFNgOJP1zKw8KAgZn9n2AbRr0oV6grZSNdMh6dOUtTq8Vnd/TnXgaihwM7AanOmDo6f
         sPDQ==
X-Gm-Message-State: AOAM53348j3AxgeXC1LBd4VAd1LBOc/XPmw1fv3hBkB2+rO/5EAWmLYP
        CS0tmtcww1Jsr+vo7qslMA==
X-Google-Smtp-Source: ABdhPJxTRmgokL0wStMwRqV+oX3EonIurKbmn+qsKo6StyhL7ScBG2aXp6OpIyu21+e0lOYyQvHS6A==
X-Received: by 2002:a9d:7344:: with SMTP id l4mr985741otk.155.1632343133437;
        Wed, 22 Sep 2021 13:38:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb44sm741272oib.37.2021.09.22.13.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:38:52 -0700 (PDT)
Received: (nullmailer pid 1252331 invoked by uid 1000);
        Wed, 22 Sep 2021 20:38:51 -0000
Date:   Wed, 22 Sep 2021 15:38:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexander Graf <graf@amazon.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Stan Skowronek <stan@corellium.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        linux-usb@vger.kernel.org
Subject: Re: [RFT PATCH 1/9] dt-bindings: usb: tps6598x: Add Apple CD321x
 compatible
Message-ID: <YUuUW0qTbFC+1Fo/@robh.at.kernel.org>
References: <20210918120934.28252-1-sven@svenpeter.dev>
 <20210918120934.28252-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918120934.28252-2-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 14:09:26 +0200, Sven Peter wrote:
> A variant of the TI TPS 6598x Type-C Port Switch and Power Delivery
> controller known as Apple CD321x is present on boards with Apple SoCs
> such as the M1. Add its compatible to the device tree binding.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
