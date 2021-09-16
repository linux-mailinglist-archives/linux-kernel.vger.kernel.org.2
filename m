Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF08740EB29
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 21:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhIPTzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 15:55:31 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44006 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbhIPTza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 15:55:30 -0400
Received: by mail-ot1-f49.google.com with SMTP id x10-20020a056830408a00b004f26cead745so9784713ott.10;
        Thu, 16 Sep 2021 12:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nIxwaUEvO52JiUFv2rx1jd30G1rckEmUPljusYpNyWI=;
        b=x4Xu67Aiz8ijJj0kvvGqiZJnvvWqjku5AAQtUiAauunJFPEDFMqMvqYww0m3X0UgTG
         BVEb02eBSOSvapii7IIkFdBqE8YLt+4FERAGcsayUmRuXtzt1CJ+YArdT1SUjsCgGWdN
         RrzPeg8nL+qAvqUn+3qbHLWIQw5yg8RWac4aYFT/+jEOQ8lLb6miHPE9p2Tn8qxV9o95
         Pe4lmUrEofhFIECQ2U/9ngdmi959j3Q7rYY+2LmIrMg+oxBLA8PQXtBh9VPbtj52ZNXl
         uD8/KtiBASSII8MLxvIRQeUX90JBKrEVS5COYsT/ZKO5FplCW/owmnUn3aD9bW3Jbs1y
         1c6w==
X-Gm-Message-State: AOAM533nP+QKWzhWdRrAzaXI10WkDpKVgEqjlodCbC00hSMmmKIr6Vt/
        ldwkHKoBR3XGL1MabMX0JA==
X-Google-Smtp-Source: ABdhPJzDJKvWeXlCtxttQ7YBEykimFOuraagds1Vx92Sb1hTsgi4GQpIrMvHtEeNb+qonyTmRKYEag==
X-Received: by 2002:a05:6830:2473:: with SMTP id x51mr6073026otr.34.1631822048869;
        Thu, 16 Sep 2021 12:54:08 -0700 (PDT)
Received: from robh.at.kernel.org (107-211-252-53.lightspeed.cicril.sbcglobal.net. [107.211.252.53])
        by smtp.gmail.com with ESMTPSA id a23sm955442otp.44.2021.09.16.12.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 12:54:07 -0700 (PDT)
Received: (nullmailer pid 1385604 invoked by uid 1000);
        Thu, 16 Sep 2021 19:54:05 -0000
Date:   Thu, 16 Sep 2021 14:54:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] dt-bindings: display: Document the Xylon LogiCVC
 display controller
Message-ID: <YUOg3T8nytBzxIHl@robh.at.kernel.org>
References: <20210914200539.732093-1-paul.kocialkowski@bootlin.com>
 <20210914200539.732093-2-paul.kocialkowski@bootlin.com>
 <1631710594.961761.935947.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631710594.961761.935947.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 07:56:34AM -0500, Rob Herring wrote:
> On Tue, 14 Sep 2021 22:05:36 +0200, Paul Kocialkowski wrote:
> > The Xylon LogiCVC is a display controller implemented as programmable
> > logic in Xilinx FPGAs.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../display/xylon,logicvc-display.yaml        | 302 ++++++++++++++++++
> >  1 file changed, 302 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/xylon,logicvc-display.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/xylon,logicvc-display.example.dt.yaml: logicvc@43c00000: 'display@0' does not match any of the regexes: '^gpio@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/xylon,logicvc.yaml

You can ignore this.

Rob
