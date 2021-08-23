Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8568B3F5378
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 00:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhHWWob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 18:44:31 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43559 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhHWWoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 18:44:30 -0400
Received: by mail-ot1-f42.google.com with SMTP id x10-20020a056830408a00b004f26cead745so40716168ott.10;
        Mon, 23 Aug 2021 15:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gx5tRxni4JPjQJdOKA2ckEH891YFidYtWQTg4z4AvhU=;
        b=aU7GtDYrk9/TcWLOO24V31oI5jckSUhNAgApjMOdvf6YsvXU5XevFdyGlneLB9NsvM
         G6GmLh3WK+tTmgN40QZ10chXhhfeex9FTEpTVt59/wM64i9S2LpVDAvYpauUyWOVuOb4
         UrkokzLYxLBbPiTWpyvJwTq01Jfy4E35fbLBPy5btSrJB/onD0Y3YTz/79LjGmdXtQRC
         /xAws0faAEiNWby5M3PtI/Yj9WLShWblCCcv0TxW/KdA44UZeVgGZFtHjvMhDPV4zLBX
         6/zIrj8Rkqw/HhRmfx31an5/kvgDNxaOEffaHomglbHibZifcIjTYPN1ADmNqyzzXqQn
         pX2g==
X-Gm-Message-State: AOAM531ih8IojWsBJqtQnaOL//9rSIJrnc+sllBHjyiHw7CVjsgCM9Zz
        RwFaP2IwqfA8c8VppF80RkOqtrnJ8w==
X-Google-Smtp-Source: ABdhPJx15/z0Ao9IpjV+6RPw4A0UFJc4gWmgZ9kjjdmXvWPq6T7IMhFJ8QZpn+vMmsNCFF5lL6pYIw==
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr669163oic.49.1629758626884;
        Mon, 23 Aug 2021 15:43:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e7sm3182070oom.26.2021.08.23.15.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 15:43:46 -0700 (PDT)
Received: (nullmailer pid 2881591 invoked by uid 1000);
        Mon, 23 Aug 2021 22:43:45 -0000
Date:   Mon, 23 Aug 2021 17:43:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 6/6] phy: dt-bindings: cdns,dphy: add Rx DPHY
 compatible
Message-ID: <YSQkoVTjemx+nFpS@robh.at.kernel.org>
References: <20210820190346.18550-1-p.yadav@ti.com>
 <20210820190346.18550-7-p.yadav@ti.com>
 <YSL9lkLB0wKk9sem@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSL9lkLB0wKk9sem@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 04:44:54AM +0300, Laurent Pinchart wrote:
> Hi Pratyush,
> 
> Thank you for the patch.
> 
> On Sat, Aug 21, 2021 at 12:33:46AM +0530, Pratyush Yadav wrote:
> > The DPHY is treated to be in Tx mode by default. Add a new compatible
> > for Rx mode DPHYs.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > 
> > ---
> > 
> > Changes in v4:
> > - New in v4.
> > 
> >  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > index d5a5e1f0b671..48b6a841152e 100644
> > --- a/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/cdns,dphy.yaml
> > @@ -11,8 +11,9 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    items:
> > +    oneOf:
> >        - const: cdns,dphy
> > +      - const: cdns,dphy-rx
> 
> It's customary to use an enum instead:
> 
>   compatibles:
>     enum:
>       - cdns,dphy
>       - cdns,dphy-tx
> 
> I don't know if Rob has a preference for consistency (or for any other
> reason). In either case,

Yes, use enum.

Rob
