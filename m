Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9093C9215
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhGNUdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:33:10 -0400
Received: from mail-il1-f177.google.com ([209.85.166.177]:42965 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhGNUdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:33:09 -0400
Received: by mail-il1-f177.google.com with SMTP id h3so2862140ilc.9;
        Wed, 14 Jul 2021 13:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M9lwU/VCLeE/+nWVD4Z39mOZ46afUvQ9sGuTfqHArMo=;
        b=guRQ97nLNduG/9PQSYSQUYSR2sL6CdYBDg9VEgAPEfFBjtYj1Sa3/MDl66yDElSmMD
         5DbpNv9QZHbPJcyg0kY8EaYKJVPYAHX7wT63c1MzV4bG8QH8pRa9ljd4BzBbQiro/rer
         GD0h1uCthuV/cs/l74QpHC16+EnBuFE3kX7LU1E2G1ISN9+is29kLU2xUR66OD+D6iqL
         WB49sIW6sS/QEBXnHF12gritIas7mXUS97dl9G+P1Z7Rk+fgtgjfE65zYN0Es9Yav60M
         NnGApxbqAxUKaygmIXUBrn0q7KeZ7XB3y30z6eQt07MXyGKoYLRDvREW2FvvTPD07SOl
         DKOw==
X-Gm-Message-State: AOAM530Ec6maQY/ZOvALZDYneHTsa/oDZh4SXNdurelYgR08ReqrIBKD
        rpufP3pljCsqODlH/kKQyA==
X-Google-Smtp-Source: ABdhPJzuzxDWx8MQSmyJj28+lBodjVhYnmHjPlW4BVR12Iypy4Ks1HdtN9MJue3JLnOTdrlwpA06AA==
X-Received: by 2002:a92:c544:: with SMTP id a4mr8336682ilj.266.1626294616647;
        Wed, 14 Jul 2021 13:30:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x1sm1721778ioa.54.2021.07.14.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 13:30:15 -0700 (PDT)
Received: (nullmailer pid 3466302 invoked by uid 1000);
        Wed, 14 Jul 2021 20:30:13 -0000
Date:   Wed, 14 Jul 2021 14:30:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Christophe Branchereau <cbranchereau@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Innolux EJ030NA
Message-ID: <20210714203013.GA3287208@robh.at.kernel.org>
References: <20210625121045.81711-1-paul@crapouillou.net>
 <YOk60yTP9L1gT3+W@ravnborg.org>
 <HBW0WQ.NHPOJDIT9XWR1@crapouillou.net>
 <YOlvev0nvXVYU01y@ravnborg.org>
 <K4Y0WQ.MLS1MDCVFJWL3@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <K4Y0WQ.MLS1MDCVFJWL3@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 11:21:56AM +0100, Paul Cercueil wrote:
> 
> [...]
> 
> > >  I am not sure; the doc states that this (additionalProperties:
> > > false) "can't
> > >  be used in case where another schema is referenced", which is the
> > > case here,
> > >  as we include "panel-common.yaml".
> > 
> > This DT schema already list all relevant properties like:
> > 
> > 	backlight: true
> > 
> > So "additionalProperties: false" tells that no other properties are
> > allowed other than the listed properties.
> > 
> > To my best understanding unevaluatedProperties: false is less strict and
> > should be used if one does not list all possilbe properties.

Right. There's some value of listing which common properties you are 
using as well.

> > This could be the case for a panel haging below a SPI controller as in
> > this case. So in other words giving this some extra thought I think
> > unevaluatedProperties: false is OK here.
> 
> A panel below a SPI controller would have all its SPI-specific properties
> covered by spi-controller.yaml, I believe? So maybe "additionalProperties:
> false" would work?

No. Because spi-controller.yaml is evaluated on the SPI host node and 
this one is evaluated on the SPI slave. There's some work to address 
this, but it means every SPI slave will have to reference a SPI device 
schema. The bigger issue here is SPI controller specific device 
properties. So for this case, we'll have to use unevaluatedProperties.

> 
> In any case, if I use "additionalProperties: false", "make dt_binding_check"
> complains that my example's "spi-max-frequency" property is not covered. So
> maybe you are right.
> 
> > So my r-b is ok if you keep it as it.
> > 
> > PS. Where do you guys hang out with the downfall of freenode - somewhere
> > on oftc?
> 
> We moved to #opendingux on Libera.
> 
> Cheers,
> -Paul
> 
> 
> 
