Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A03627E6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbhDPSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:46:42 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:42968 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237334AbhDPSql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:46:41 -0400
Received: by mail-oo1-f41.google.com with SMTP id e12-20020a056820060cb02901e94efc049dso1414756oow.9;
        Fri, 16 Apr 2021 11:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=etRLZlwfrAw/ObAL86CRzvNdPZ4wzFCSG0hWaLZVyQQ=;
        b=NNlEVSzfrH/ovKjZFgyVt7U0ekTXLzAGpDK/6gdRT3M5MNahfhdLNnGnCY//WundxN
         9PFZAV94K4+OWfxXtxvMSTZqpGHMBBMS3VTt+f9CsX0+iHYRvSfVmBXav99SMbRkY4QV
         KckBiCjvncnrdrUxxM7AzXK82v7ArWV2ZnYsQB6I2+3cdcLpYoRfGJw64ArqruJ9bjOC
         x448v1+cE/dI8RUBPqFEBvXaFXITlw0DSaT6jJM6+4TL1Om/PW1c1nrZRWI/XNfBCfHL
         fzd7ojaLPzXBz4muzKXMXusqxWX0akA2xJfXA+gMdwCJ7VaOS7MsUwldM/7+2fSi4Qsk
         xwcA==
X-Gm-Message-State: AOAM532fxZnSTVq0OGx9XWD8tGxlONgVNK8i2Db9ZLZJW5XU6T3rxZvf
        JxEl4D5iq44Yjff8hpkcLA==
X-Google-Smtp-Source: ABdhPJzM+rTbpoSYC8X7T8dgCSFTM86qBDJb19n9iGSJidvKf3L/X2rk0r8MR/j+ieTN7E1NrqOfkA==
X-Received: by 2002:a4a:8c4f:: with SMTP id v15mr4358271ooj.25.1618598776489;
        Fri, 16 Apr 2021 11:46:16 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m133sm1539286oia.22.2021.04.16.11.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:46:14 -0700 (PDT)
Received: (nullmailer pid 3733903 invoked by uid 1000);
        Fri, 16 Apr 2021 18:46:13 -0000
Date:   Fri, 16 Apr 2021 13:46:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 3/5] dt-bindings: mtd: add OTP bindings
Message-ID: <20210416184613.GA3731279@robh.at.kernel.org>
References: <20210416114928.27758-1-michael@walle.cc>
 <20210416114928.27758-4-michael@walle.cc>
 <1618597801.604723.3708338.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618597801.604723.3708338.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:30:01PM -0500, Rob Herring wrote:
> On Fri, 16 Apr 2021 13:49:26 +0200, Michael Walle wrote:
> > Flash devices can have one-time-programmable regions. Add a nvmem
> > binding so they can be used as a nvmem provider.
> > 
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> > Changes since RFC:
> >  - added missing "$"
> >  - dropped first example
> >  - use real device compatibles
> > 
> >    Please note, that this will lead to an error without patch 4/5, which
> >    introduces that property for the jedec,spi-nor. Should I keep it
> >    seperate or should I squash that patch into this one?
> > 
> >  .../devicetree/bindings/mtd/mtd.yaml          | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mtd.example.dt.yaml: flash@0: 'otp-1', 'otp-2' do not match any of the regexes: '^partition@', 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml

Don't worry about this one if the series passes. There's not really a 
good way to avoid it other than moving the example.

Rob
