Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D76376B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhEGVRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:17:25 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:38826 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGVRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:17:23 -0400
Received: by mail-ot1-f44.google.com with SMTP id q7-20020a9d57870000b02902a5c2bd8c17so9098270oth.5;
        Fri, 07 May 2021 14:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/5D7ZT5Lu0YStgy8faRmpqxBSv65B/x5VGdmWREBghE=;
        b=PX9giO3KOMvodoyTZJBTwy5fgJhkr03NIzfb70FKLmGVNlox8WnopeZ4mT+uJFKlnO
         8+g7O0Enl2bqafT9oZx8aW4V5O10uCyBILj1OVAnPdkCEZb32pAHnMes3luuWopuobuJ
         76HuWdwAm05mt/b2plx5QkTOvnoztCrttsky0wQ7YcGc1lZ4iulbqwYfJqkWBRYHzLPH
         bxGjRG8S45qw7TfhFlKl/m1ZsK0j3euLa/hp6nvALRQbOGKx6BhmwQXiE/2TtoKlfBE2
         b4DVj3VBa1EOv7CG5pZvvLjIX3zEAhyG63U9V/ii79Bl6PgbqRVMo9646Z5Iv1BN+4dz
         9Zqg==
X-Gm-Message-State: AOAM531EgepdV2KbUzTYkDVR0pwJxBC6IJemK8uBtqs2ER7vVi+H5zFj
        TOOBuoljRbH3QJDyOSBzaw==
X-Google-Smtp-Source: ABdhPJykObAS8JsXFLdzmqv6KmJ1UzMdUyE9FJqsiPOL6ZcDskiGKl/Bhkm8EP1lRu9jT7rBYb42MQ==
X-Received: by 2002:a9d:728b:: with SMTP id t11mr5710529otj.230.1620422182286;
        Fri, 07 May 2021 14:16:22 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s85sm1312704oos.4.2021.05.07.14.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 14:16:21 -0700 (PDT)
Received: (nullmailer pid 2900641 invoked by uid 1000);
        Fri, 07 May 2021 21:16:19 -0000
Date:   Fri, 7 May 2021 16:16:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, p.zabel@pengutronix.de, l.stach@pengutronix.de,
        krzk@kernel.org, agx@sigxcpu.org, marex@denx.de,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ping.bai@nxp.com, aford173@gmail.com, abel.vesa@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 08/13] dt-bindings: imx: gpcv2: add support for
 optional resets
Message-ID: <20210507211619.GA2899069@robh.at.kernel.org>
References: <20210506010440.7016-1-peng.fan@oss.nxp.com>
 <20210506010440.7016-9-peng.fan@oss.nxp.com>
 <a6554ae1-75d4-e471-6371-d9ad2246599f@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6554ae1-75d4-e471-6371-d9ad2246599f@kontron.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 08:43:17AM +0200, Frieder Schrempf wrote:
> On 06.05.21 03:04, Peng Fan (OSS) wrote:
> > From: Lucas Stach <l.stach@pengutronix.de>
> > 
> > For some domains the resets of the devices in the domain are not
> > automatically triggered. Add an optional resets property to allow
> > the GPC driver to trigger those resets explicitly.
> > 
> > The resets belong to devices located inside the power domain,
> > which need to be held in reset across the power-up sequence. So we
> > have no means to specify what each reset is in a generic power-domain
> > binding. Same situation as with the clocks in this binding actually.
> 
> My understanding was that Rob wanted this explanation to be contained in the binding docs itself and not only in the commit message, but I might be wrong.

Yes, that would be better.

> 
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> > index a96e6dbf1858..4330c73a2c30 100644
> > --- a/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> > +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpcv2.yaml
> > @@ -66,6 +66,13 @@ properties:
> >  
> >            power-supply: true
> >  
> > +          resets:
> > +            description: |
> > +              A number of phandles to resets that need to be asserted during
> > +              power-up sequencing of the domain.
> > +            minItems: 1
> > +            maxItems: 4
> > +
> >          required:
> >            - '#power-domain-cells'
> >            - reg
> > 
