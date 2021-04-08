Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2126358FFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhDHWtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhDHWth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:49:37 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC103C061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 15:49:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id o123so2931117pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OA781OccRNwXE7rt2K4lFZ5YBX2tVVTL8OP2VVE7W5k=;
        b=WV51htl117L8zuAaqHXXoY7ed5xTWBqk5ntWuoyogOc/YvHhI2fi3POHYHV+gyiI+h
         7jwQJ5n3UeNi0UQ+xcGrHwjZQTU4J95PvkA1frsL8un4AnJ2cNbmyci9oGBSQX11Nx04
         lLiHi1bh92wdh08yNIMHySzMNYC96WXXNunv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OA781OccRNwXE7rt2K4lFZ5YBX2tVVTL8OP2VVE7W5k=;
        b=ui4OZMKVhekW3b2c8fcQ6KpbAyt6VtMG0Emn4k/JrmT6ktgoVah17AS+/qUq+oS0WJ
         3tUc62iSgXX9gKDCZorCSd8FEWgQm9dpsfZqZaR7xwiczwJZiP48/s/9sDDJMLF+TBXw
         x7I0gZuxTqWrCSzrHmOW/wkdzEw1HSCeJn/0kjkCNj4BXftK3SGJ5MfNrkh6/MF/9qWq
         Zhv+xKQUKiMmLd5V1A3dwl119PU9NXzA1ZS/9bVTvWg4cJQqGSFVlzGv66ROnMVxn9vt
         HdekYlNpGOrWD0HWbxWw+XRL4mzahzXP2ZetdV0c0rpAAI531Cuo2MWw7SdLenlPv4Q8
         muug==
X-Gm-Message-State: AOAM531y/5CafN6xLb+qRhgXmVl8h9VoWYcDsZ/6oclFyDdbhfaKsPcH
        sw6BYEUitypS2OkWSpprqTHxLA==
X-Google-Smtp-Source: ABdhPJzBrRR/poki5sG+OHaXYR11z6gwhKEfjfuEHH4IEwICWTvaml5hGOyodyjI9brEWQS0oONOvQ==
X-Received: by 2002:a05:6a00:2389:b029:21a:d3b4:e5 with SMTP id f9-20020a056a002389b029021ad3b400e5mr9858217pfc.39.1617922163264;
        Thu, 08 Apr 2021 15:49:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d013:d350:4066:89b8])
        by smtp.gmail.com with UTF8SMTPSA id d26sm417094pfo.162.2021.04.08.15.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 15:49:22 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:49:21 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-usb@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v6 1/5] dt-bindings: usb: Add binding for Realtek RTS5411
 hub controller
Message-ID: <YG+IcUvJPAa3NieK@google.com>
References: <20210405201817.3977893-1-mka@chromium.org>
 <20210405124900.v6.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20210406163001.GA1910748@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210406163001.GA1910748@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 11:30:01AM -0500, Rob Herring wrote:
> On Mon, Apr 05, 2021 at 01:18:13PM -0700, Matthias Kaehlcke wrote:
> > The Realtek RTS5411 is a USB 3.0 hub controller with 4 ports.
> > 
> > This initial version of the binding only describes USB related
> > aspects of the RTS5411, it does not cover the option of
> > connecting the controller as an i2c slave.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > 
> > Changes in v7:
> > - added type ref for 'companion-hub' property
> > 
> > Changes in v6:
> > - Realtek binding instead of generic onboard_usb_hub
> > - added 'companion-hub' property
> > - added reference to 'usb-device.yaml'
> > - 'fixed' indentation of compatible entries to keep yamllint happy
> > - added 'additionalProperties' entry
> > - updated commit message
> > 
> > Changes in v5:
> > - updated 'title'
> > - only use standard USB compatible strings
> > - deleted 'usb_hub' node
> > - renamed 'usb_controller' node to 'usb-controller'
> > - removed labels from USB nodes
> > - added 'vdd-supply' to USB nodes
> > 
> > Changes in v4:
> > - none
> > 
> > Changes in v3:
> > - updated commit message
> > - removed recursive reference to $self
> > - adjusted 'compatible' definition to support multiple entries
> > - changed USB controller phandle to be a node
> > 
> > Changes in v2:
> > - removed 'wakeup-source' and 'power-off-in-suspend' properties
> > - consistently use spaces for indentation in example
> > 
> >  .../bindings/usb/realtek,rts5411.yaml         | 59 +++++++++++++++++++
> >  1 file changed, 59 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> > new file mode 100644
> > index 000000000000..b59001972749
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> > @@ -0,0 +1,59 @@
> > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/usb/realtek,rts5411.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binding for the Realtek RTS5411 USB 3.0 hub controller
> > +
> > +maintainers:
> > +  - Matthias Kaehlcke <mka@chromium.org>
> > +
> > +allOf:
> > +  - $ref: usb-device.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - usbbda,5411
> > +          - usbbda,411
> > +
> 
> reg: true
> 
> to fix the error.

Will fix in v8 (this is v7, even though the subject says otherwise,
I forgot to increment the version number when sending).

> > +  vdd-supply:
> > +    description:
> > +      phandle to the regulator that provides power to the hub.
> > +
> > +  companion-hub:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > +    description:
> > +      phandle to the companion hub on the controller.
> 
> This should be required I think. I suppose you could only hook up 2.0
> ports, but why. And 3.0 only wouldn't be USB compliant, would it?

Agreed, that makes sense now that this is a specific binding for the
RTS5411. It seems unlikely that a system would use a USB 3.0 capable
hub on a USB 2.0 controller, and as you said 3.0 only wouldn't be USB
compliant.

I made the attribute initially optional because the binding was
intended to be generic (bad idea), and for certain hubs a required
'companion-hub' wouldn't make sense (e.g. USB 2.0 only).

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    usb-controller {
> 
> 'usb' is the standard name.

ack

Thanks for your comments!

m.
