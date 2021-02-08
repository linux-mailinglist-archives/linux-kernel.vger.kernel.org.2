Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4679313E64
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbhBHTDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:03:14 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36162 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbhBHRc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:32:58 -0500
Received: by mail-ot1-f54.google.com with SMTP id 100so8228642otg.3;
        Mon, 08 Feb 2021 09:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJGZSCJAur/5Hm+o5HKIZJ3m/1BQyOjxp7i5ki4kvKg=;
        b=FI4kHoVs+Ih3QpTR9XpLHWJXjph9OtP0qEm/RW2M4OQcNjdtVfEOscGrLEWv6WreEv
         8ReF2b+esWXrfv23VrpRkmTL4/jr8NqaK3i3YyFT6XwggmNEQE8Ea/04nRXztjYuLhDm
         7+/VmgfOPfa8zCHwF6bXPWb4GL7kgDmpw4cIib38JpZL/SC/+fyyCRriDUn3QQdi0Pcm
         Ox3gWyPu+qeZR47reYHVRwfs5r3ZdUSc4lfCrRsD4bkRjHiKG5EV5b5Wzw+VMf97WAUm
         kwDraLficWFXQZisaJVlBOq63nN/9YBBvgF+ZVpT06nt53h0lMMkHK9GfpkPtYUmhG4o
         wCSw==
X-Gm-Message-State: AOAM530UapH0uhCn5gSwFzkrSiH0lzoMVkBLOHkZU/9rSvU6cnt7l0os
        H0l/eYiNbfAyJkxUIWIX+Q==
X-Google-Smtp-Source: ABdhPJw4/R4KH0mvoPgQxyLxAdM16oo9jlsjZpjjo7ro5BZRGiRShXk92zZZg3RgRWmLqj4kALEs9w==
X-Received: by 2002:a9d:640b:: with SMTP id h11mr13124079otl.224.1612805537064;
        Mon, 08 Feb 2021 09:32:17 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y65sm1324246oie.50.2021.02.08.09.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 09:32:16 -0800 (PST)
Received: (nullmailer pid 1578321 invoked by uid 1000);
        Mon, 08 Feb 2021 17:32:15 -0000
Date:   Mon, 8 Feb 2021 11:32:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Arnd Bergmann <arnd@kernel.org>,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org, soc@kernel.org,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/18] dt-bindings: vendor-prefixes: add AAPL prefix
Message-ID: <20210208173215.GA1567700@robh.at.kernel.org>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-2-marcan@marcan.st>
 <20210208102730.p4nhsl35oowsklv2@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208102730.p4nhsl35oowsklv2@kozik-lap>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 11:27:30AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Feb 05, 2021 at 05:39:34AM +0900, Hector Martin wrote:
> > Amusingly, this wasn't yet documented, even though this vendor prefix
> > has been used since time immemorial on PPC.
> > 
> > Signed-off-by: Hector Martin <marcan@marcan.st>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 041ae90b0d8f..d7950c723472 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -25,6 +25,8 @@ patternProperties:
> >    # Keep list in alphabetical order.
> >    "^70mai,.*":
> >      description: 70mai Co., Ltd.
> > +  "^AAPL,.*":
> 
> All prefixes are lower case... see ABB below (not mentioning that the
> company name is not APPLE), so just "apple".

Grep the kernel tree for 'AAPL,'. It comes from the the ticker symbol 
which early on was the preferred form, but we've tended to move away 
from that. The DT Apple ships (which is *very* different) uses both 
forms.

So keep what exists already or have old AAPL and new apple?

Rob
