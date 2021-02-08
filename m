Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9B5313FD8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbhBHUC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:02:58 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45831 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235549AbhBHSV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:21:57 -0500
Received: by mail-oi1-f173.google.com with SMTP id m7so16559518oiw.12;
        Mon, 08 Feb 2021 10:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yT8WnppJbVZfpbRjwXZRaLF1Kx8p3ocolq2G8S6zsHQ=;
        b=lq51VAbZlKUV64jvwLjGh0y7YtmR1p8YUFOLwhrnAzKzABdVv8NWly1OnQNSY7025o
         uj4JKp6Wl89DVanO+2Lfr+tgpCmhXDmI1a20/QuFx96fjHuXKwykKeqwK/vLDkFjapbs
         grcV7VA25RhnHTBNzCYa1LIc+qnSXj4mHjoXz6N3uRQ4shARuCweADuOfeTXqPAO0gSA
         tfwCn7WLywRlIfjRiB05Ax18ZYyteHs0HDrzIwXGoW40ADyZH09FNfl/d925oGOcCs0Z
         r3roY3IMPpNOxybF+upHFJ7zSZV0deqWPGpCBbOvMUUjCieUcshEtshEnRINE0YTj105
         8FhA==
X-Gm-Message-State: AOAM530iG0IsokvRQZWGhlVlmLBolIBW849DEnIh4Bu1gJZUIH+3TrBT
        xAdowdsZAfnPc5zMBE477g==
X-Google-Smtp-Source: ABdhPJwMxPAwvhYn2SwOTD+njytvlMJrKMT+ayLz33Qtlqx3xzg9IIeYMv/25js4iJn5OgGH++eDSg==
X-Received: by 2002:aca:5e84:: with SMTP id s126mr12263oib.175.1612808476055;
        Mon, 08 Feb 2021 10:21:16 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a22sm3845267otp.53.2021.02.08.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:21:14 -0800 (PST)
Received: (nullmailer pid 1653616 invoked by uid 1000);
        Mon, 08 Feb 2021 18:21:13 -0000
Date:   Mon, 8 Feb 2021 12:21:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leo Li <leoyang.li@nxp.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to
 yaml schema
Message-ID: <20210208182113.GA1648694@robh.at.kernel.org>
References: <20210205234734.3397-1-leoyang.li@nxp.com>
 <20210205234734.3397-4-leoyang.li@nxp.com>
 <1612803322.544738.1522086.nullmailer@robh.at.kernel.org>
 <VE1PR04MB6687E8BF45496B8505A6EC118F8F9@VE1PR04MB6687.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB6687E8BF45496B8505A6EC118F8F9@VE1PR04MB6687.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:07:14PM +0000, Leo Li wrote:
> 
> 
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, February 8, 2021 10:55 AM
> > To: Leo Li <leoyang.li@nxp.com>
> > Cc: linux-arm-kernel@lists.infradead.org; Oleksij Rempel <linux@rempel-
> > privat.de>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> > <krzk@kernel.org>; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Shawn Guo <shawnguo@kernel.org>
> > Subject: Re: [PATCH 03/15] dt-bindings: memory: fsl: convert ifc binding to
> > yaml schema
> > 
> > On Fri, 05 Feb 2021 17:47:22 -0600, Li Yang wrote:
> > > Convert the txt binding to yaml format and add description.  Also
> > > updated the recommended node name to ifc-bus to align with the
> > > simple-bus node name requirements.
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > ---
> > >  .../bindings/memory-controllers/fsl/ifc.txt   |  82 ----------
> > >  .../bindings/memory-controllers/fsl/ifc.yaml  | 140
> > > ++++++++++++++++++
> > >  2 files changed, 140 insertions(+), 82 deletions(-)  delete mode
> > > 100644
> > > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> > >
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/memory-
> > controllers/fsl/ifc.example.dts:36.27-49.19: Warning (simple_bus_reg):
> > /example-0/soc/ifc-bus@ffe1e000/flash@0,0: simple-bus unit address
> > format error, expected "0"
> > Documentation/devicetree/bindings/memory-
> > controllers/fsl/ifc.example.dts:51.27-64.19: Warning (simple_bus_reg):
> > /example-0/soc/ifc-bus@ffe1e000/flash@1,0: simple-bus unit address
> > format error, expected "100000000"
> > Documentation/devicetree/bindings/memory-
> > controllers/fsl/ifc.example.dts:66.26-71.19: Warning (simple_bus_reg):
> > /example-0/soc/ifc-bus@ffe1e000/cpld@3,0: simple-bus unit address format
> > error, expected "300000000"
> 
> Hi Rob,
> 
> I saw these warnings, but cannot find a good solution to it.  The 
> first cell in the address is the Chip select, while the second cell 
> in the address is the address offset within the chip select.  It 
> would confusing to combine the two cells of different purposes into 
> a single address as suggested by the warning.  Can we allow the 
> multi-cell address in the node name?

Drop 'simple-bus'. It's not a simple bus. You have registers that 
presumably have some configuration needed.

Rob
