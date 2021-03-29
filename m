Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA1434DA2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 00:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhC2WVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 18:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhC2WVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 18:21:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0414C061762;
        Mon, 29 Mar 2021 15:21:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so21778003ejc.10;
        Mon, 29 Mar 2021 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dRhm46fv/CqnkUkyrWxeHSP37MaaFXnAoj+y1DNtN2Y=;
        b=eXnfqJl1qFLQeJZK7a51+ogFSQiWCPIvWWPdoOkG2H4KyQjJ5b3RzF8TOPw+YtSnyf
         UsXkN6LccYrhgqc0d6wiq0+zL2QjM+iiV2v17BkfyVOZ2YbcQUSANEDqVbaWMG+Cgs4C
         SDw9l/yxjyKqwK4v4Op07CkxWQ+jmsY/Kq3tDE7Ui61NkL0fv8aFFQEaYvKoQ+qZHPMs
         /LvGqbgcUvk9qCllf2ZZxkmcbKr37hnkdMZCAyUDP8lIniG41DCBAwFyDNkwf8OSvk96
         OgQJqtPexDqSLLNY2+jZx2l2m+kQvAdK0Hd7BMN4ulH8sNtXkQNhgbsji6E/SBTtCDQ8
         zOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dRhm46fv/CqnkUkyrWxeHSP37MaaFXnAoj+y1DNtN2Y=;
        b=CbjvL8gp6tFKRVqw9MBcWDm71I8xtYcIklqPLJQ+VnzyPxZb40jh1uL6XUlQ+44Er6
         tZLmvfYS9C4q64HO4uNmP1zG6GbxPwj54HYfVloQPeiNbBzfV/Zc/9rUvHV8/y3faGfa
         RrxmpHwVKb96/0fo/srZOWzEmAOxLSA32G258FiCbuBGXACS7PzLQ9ODQJP/usFvIQv+
         w98PlxSjA0bUOsbLaV+Ydte0b+RpKRZGG1V9TVQDDdE+eHv2SMFftzUAc7yycLhTDAjF
         p88jnCOgt+VnEOsaTuCVpyY138jz9MTwaXhilyDaDEKOE7xflNEGv1tTcG/rULIT1I1u
         uGuQ==
X-Gm-Message-State: AOAM530xYg5aYG1wr/nM+DTyhzD8Z0iI5hoACWaNBx74XrGCxscVlMsS
        KgU0yif8j9nQYGPfEUAExBIGFWsV9HI=
X-Google-Smtp-Source: ABdhPJxPkXZkXl6gT+vge6Qqo83lznr5txu39g6Vu4BfeimfbFhfubouHJu8gD4kK/UKCPInRKLQRQ==
X-Received: by 2002:a17:906:701:: with SMTP id y1mr5194908ejb.243.1617056496624;
        Mon, 29 Mar 2021 15:21:36 -0700 (PDT)
Received: from BV030612LT ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id d15sm9797536edx.62.2021.03.29.15.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 15:21:36 -0700 (PDT)
Date:   Tue, 30 Mar 2021 01:21:33 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: soc: actions: Add Actions Semi Owl
 socinfo binding
Message-ID: <20210329222133.GA1792209@BV030612LT>
References: <cover.1616178258.git.cristian.ciocaltea@gmail.com>
 <95105518f61408743d17783099ed9c373a3dfe18.1616178258.git.cristian.ciocaltea@gmail.com>
 <20210327163006.GA185779@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210327163006.GA185779@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 10:30:06AM -0600, Rob Herring wrote:
> On Fri, Mar 19, 2021 at 08:27:59PM +0200, Cristian Ciocaltea wrote:
> > Add devicetree binding for the Actions Semi Owl SoCs info module.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
> >  .../bindings/soc/actions/owl-socinfo.yaml     | 71 +++++++++++++++++++

[...]

> > +
> > +patternProperties:
> > +  "^soc(@[0-9a-f]+)?$":
> 
> Make this a $nodename property.
> 
> > +    type: object
> > +    properties:
> 
> And move this up to top-level.
> 
> You need a custom 'select' entry to exclude 'simple-bus'.

Indeed, I missed it..

> > +      compatible:
> > +        items:
> > +          - enum:
> > +              - actions,s500-soc
> > +              - actions,s700-soc
> > +              - actions,s900-soc
> > +          - const: simple-bus
> > +
> > +      "#address-cells":
> > +        enum: [1, 2]
> > +
> > +      "#size-cells":
> > +        enum: [1, 2]
> > +
> > +      ranges: true
> > +
> > +      actions,serial-number-addrs:
> > +        description: |
> > +          Contains the physical addresses in DDR memory where the two parts
> > +          of the serial number (low & high) can be read from.
> > +          This is currently supported only on the S500 SoC variant.
> > +        $ref: /schemas/types.yaml#/definitions/uint32-array
> > +        minItems: 2
> > +        maxItems: 2
> 
> Humm, it doesn't really seem you have an actual device or bus here, but 
> are abusing DT to create your socinfo device.
> 
> As the only property is data in main memory, you should do a compatible 
> for that memory region and put it under reserved-memory. You need that 
> anyway to prevent the kernel from using the memory, right?

Right, this region should be exposed as reserved-memory. Will handle
it in the next revision.

> Rob

Thanks for the review,
Cristi
