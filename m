Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA0932F55F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 22:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCEVkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 16:40:14 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45157 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhCEVkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 16:40:10 -0500
Received: by mail-ot1-f43.google.com with SMTP id d9so3194172ote.12;
        Fri, 05 Mar 2021 13:40:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mYxHptw1KTbed+zvBUFMPUGWjJ8e/M/IJSiaMc6FiG0=;
        b=S20hKb869IJbbNOwzULSbWCFrQHzGOORMEgWWFrssatYO1Dc/wf/lPD141q19VJFDO
         BKb4SpjWusWBIvXbnhWhTx7DQM2rsZfaEvojQSwBmywTngIIhPhY7b+IYUOHbEz6omTr
         dWCf4vbySoxohqmtZJRx+C/J8KJ8InLNw6n5lTZASjwVrq/f8Mzp1xR/YYqH4py/f6kU
         hf8aoDdMkwV+ZLUH+BSueR3NvwS3B19EkaAZWHn8tt8f5/kSlA4wRwJw6Kr+zj+WNjhL
         jDlzydckaCfEqciBlH3eq07aha9W6sTBQq6GmrmY+U1oN+V/xYQlTqfoHbiuYNl4BZAE
         v4Ww==
X-Gm-Message-State: AOAM53291PaDacoUb9kOtIFPDsFuHxzYcAKnDqPVn5wlc7trXQ8wwcuY
        Sg0n7iui9ucCiab76dwKAA==
X-Google-Smtp-Source: ABdhPJxJWs82v6UCi7T+ocmuMtvRYdjiCAavf9R0ZHLXHuKCB44oFhGx5YWQhccXCvwnp1clVl/37g==
X-Received: by 2002:a9d:7e85:: with SMTP id m5mr9561336otp.11.1614980410021;
        Fri, 05 Mar 2021 13:40:10 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w15sm843978otp.29.2021.03.05.13.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 13:40:09 -0800 (PST)
Received: (nullmailer pid 692471 invoked by uid 1000);
        Fri, 05 Mar 2021 21:40:08 -0000
Date:   Fri, 5 Mar 2021 15:40:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: display: bridge: Add bindings for
 Chipone ICN6211
Message-ID: <20210305214008.GA688115@robh.at.kernel.org>
References: <20210214175211.105107-1-jagan@amarulasolutions.com>
 <CAG3jFysAq0rSVRgjDSu6gF4kHcqOGAZt+b0Rz_reHgQr3Scy6A@mail.gmail.com>
 <CAMty3ZAk0W8KbFPo3fo3NavEvveRfptovOeaWA_hh0rXVYhDnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZAk0W8KbFPo3fo3NavEvveRfptovOeaWA_hh0rXVYhDnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 05:38:16PM +0530, Jagan Teki wrote:
> On Mon, Feb 15, 2021 at 5:28 PM Robert Foss <robert.foss@linaro.org> wrote:
> >
> > Hey Jagan,
> >
> > Thanks for submitting this.
> >
> > checkpatch.pl threw some typ-o warnings, and I listed them below. I
> > think either spelling is correct, but 'spelling.txt' does list this as
> > a typ-o explicitly, so I would suggest conforming to that just to
> > silence the checkpatch warning.
> >
> > This patch also passes 'dt_binding_check' and 'dtbs_check', but I
> > think I'd like to defer to Rob Herring for an actual r-b.
> >
> > On Sun, 14 Feb 2021 at 18:55, Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > ICN6211 is MIPI-DSI to RGB Convertor bridge from Chipone.
> > >
> > > It has a flexible configuration of MIPI DSI signal input and
> > > produce RGB565, RGB666, RGB888 output format.
> > >
> > > Add dt-bingings for it.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - updated to new dt-bindings style
> > >
> > >  .../display/bridge/chipone,icn6211.yaml       | 90 +++++++++++++++++++
> > >  1 file changed, 90 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > new file mode 100644
> > > index 000000000000..13764f13fe46
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
> > > @@ -0,0 +1,90 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/bridge/chipone,icn6211.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Chipone ICN6211 MIPI-DSI to RGB Converter bridge
> >
> > $ scripts/checkpatch.pl --git HEAD~0
> > WARNING: 'Convertor' may be misspelled - perhaps 'Converter'?
> 
> Thanks for pointing it.
> 
> I was aware of it before sending it and need to understand whether we
> need to use vendor naming conversion or not. Chipone call these
> devices are Convertor [1], So I have used the vendor notation for
> better understanding.
> 
> Any comments are this would be welcome?

Fix their spelling. If you need to propagate spelling/grammar errors, 
there's a defined way to do so.

Rob

> 
> [1] http://en.chiponeic.com/content/details45_123.html
> 
> Jagan.
