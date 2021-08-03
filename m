Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033753DF5C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbhHCTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:33:26 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:40876 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239556AbhHCTdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:33:25 -0400
Received: by mail-io1-f54.google.com with SMTP id m13so25515255iol.7;
        Tue, 03 Aug 2021 12:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JmV/mK9Cmrzz8TecZ3mWSxFbghgcbYKa5Hb241xyq2c=;
        b=dv/91VJESqOAx0lqAwiDssZy24tiTrcnjxY5kxr65MfoWyyFeRR2XD0Ihtl/HjEPva
         WVpujpYKs14RzSomoTruIrYn0M81KahftnPDCFoFSQ6y/0q97D/dsw3oSxgfsv9ozJdX
         XQU24oPkwHhRT+N/ST71j9FUsGyUsUh7SMC02UBCBHv2C+29rV3GfYMaIU5cvJMpoEwl
         THocj6slAtnD6IFBPIxpd0KMXF07VuouUxBmgOm+8qFvT4UtFC4LkD5ktgayEo/5aGwA
         UK186mT5as61OoQWMt2yXWHolfTScXO2ugWEES7fT8o9v2RtKvSkuXphI4adby64eGgG
         s+hg==
X-Gm-Message-State: AOAM530u/EV7qVBJMrKNgvSeHhvfd74fJj0WlmXTBuyydKnNRZxL8lRU
        5lLrzzTBj+NPHLMrvWH9CbmmT5xBUg==
X-Google-Smtp-Source: ABdhPJyTpyl7eMaj3K/g8xu0iNrwI8YFelKj4Ami65ADnflKN6mxc4iAA1xFopgpDRPulr8tyTnkrw==
X-Received: by 2002:a02:90d0:: with SMTP id c16mr20451202jag.106.1628019193368;
        Tue, 03 Aug 2021 12:33:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i7sm7815602ilk.7.2021.08.03.12.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 12:33:12 -0700 (PDT)
Received: (nullmailer pid 3607606 invoked by uid 1000);
        Tue, 03 Aug 2021 19:33:11 -0000
Date:   Tue, 3 Aug 2021 13:33:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kyle Tso <kyletso@google.com>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: connector: Add pd-supported property
Message-ID: <YQmZ9/ytzOHoSaN3@robh.at.kernel.org>
References: <20210730061832.1927936-1-kyletso@google.com>
 <20210730061832.1927936-2-kyletso@google.com>
 <68732310-d53a-a86b-f43c-2ceb22051338@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68732310-d53a-a86b-f43c-2ceb22051338@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 11:29:06PM -0700, Guenter Roeck wrote:
> On 7/29/21 11:18 PM, Kyle Tso wrote:
> > Set "pd-unsupported" property if the Type-C connector has no power
> > delivery support.
> > 
> 
> subject is still wrong (it says pd-supported).

And the commit msg too.

> 
> 
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >   .../devicetree/bindings/connector/usb-connector.yaml          | 4 ++++
> >   1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > index 92b49bc37939..21ec470117a6 100644
> > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > @@ -111,6 +111,10 @@ properties:
> >         - 1.5A
> >         - 3.0A
> > +  pd-unsupported:
> > +    description: Set this property if the Type-C connector has no power delivery support.
> > +    type: boolean
> > +
> >     # The following are optional properties for "usb-c-connector" with power
> >     # delivery support.
> >     source-pdos:
> > 
> 
> 
