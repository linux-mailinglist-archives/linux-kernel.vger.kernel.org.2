Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82A231EFCD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhBRT0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:26:43 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45367 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbhBRSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 13:34:22 -0500
Received: by mail-ot1-f48.google.com with SMTP id v16so2734330ote.12;
        Thu, 18 Feb 2021 10:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fj+E6ZYsKNOutdOovZVamZYGG7ykgokFczWsXUFVYwU=;
        b=Ntz3WGOlp+8becDHcOXf4Ib9cbj+H4hPhwBM8r2lgQzsCgS6RjLFYCRRNBEnglk5uA
         G8sD6l+eDY32GJBlcOFos98YitCCdFqZDC0I8kTNCp1PSwWu3fqOfQdxmmvM7lriI5ry
         E+Yg9AlBWkXhSmAynI7UWf3WCF/HIrjmzFdeDv+dk+f1+IJj6YzvVpM2+MqjCTyJbZ9J
         g9g6CEBH6/mTD6E3c2+bpD0dur2j9NaoWrKugEB9AA/BHYT94gwvZfAq2/TBmC/xXRMs
         ZQIVnkO6lizTICInweobI3BX2XNJKLqp5fZpFUUECxAne/WEk+/5liPqzAsUvxv5cGZS
         l8Ig==
X-Gm-Message-State: AOAM530CkLn1p4VIZX6wrcDygqn2eP+1xbTlq5y0sSbM3bu5pjnraGbO
        ewkqpmioxWWjJbqzb8h4jg==
X-Google-Smtp-Source: ABdhPJw78VYgYSaLhJeA0oFrTBqgHf0s2kBZJI3jHRXX0u57q5JQs1Q7ivvuWHEVEBbVuWjXKf3rhQ==
X-Received: by 2002:a05:6830:4129:: with SMTP id w41mr4036327ott.332.1613673217418;
        Thu, 18 Feb 2021 10:33:37 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a10sm1339470oie.39.2021.02.18.10.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 10:33:36 -0800 (PST)
Received: (nullmailer pid 929727 invoked by uid 1000);
        Thu, 18 Feb 2021 18:33:35 -0000
Date:   Thu, 18 Feb 2021 12:33:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        devicetree@vger.kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lcherian@marvell.com,
        mike.leach@linaro.org
Subject: Re: [PATCH V3 06/14] dts: bindings: Document device tree bindings
 for ETE
Message-ID: <20210218183335.GA915713@robh.at.kernel.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-7-git-send-email-anshuman.khandual@arm.com>
 <20210209190031.GA4102836@robh.at.kernel.org>
 <4d0e6b88-72c2-be23-f43a-3f541f9ebb86@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d0e6b88-72c2-be23-f43a-3f541f9ebb86@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:33:44PM +0000, Suzuki K Poulose wrote:
> Hi Rob
> 
> On 2/9/21 7:00 PM, Rob Herring wrote:
> > On Wed, Jan 27, 2021 at 02:25:30PM +0530, Anshuman Khandual wrote:
> > > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > 
> > > Document the device tree bindings for Embedded Trace Extensions.
> > > ETE can be connected to legacy coresight components and thus
> > > could optionally contain a connection graph as described by
> > > the CoreSight bindings.
> > > 
> > > Cc: devicetree@vger.kernel.org
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Cc: Mike Leach <mike.leach@linaro.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > > ---
> > > Changes in V3:
> > > 
> > > - Fixed all DT yaml semantics problems
> > > 
> > >   Documentation/devicetree/bindings/arm/ete.yaml | 74 ++++++++++++++++++++++++++
> > >   1 file changed, 74 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/ete.yaml b/Documentation/devicetree/bindings/arm/ete.yaml
> > > new file mode 100644
> > > index 0000000..edc1fe2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/ete.yaml
> > > @@ -0,0 +1,74 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> > > +# Copyright 2021, Arm Ltd
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/arm/ete.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: ARM Embedded Trace Extensions
> > > +
> > > +maintainers:
> > > +  - Suzuki K Poulose <suzuki.poulose@arm.com>
> > > +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> > > +
> > > +description: |
> > > +  Arm Embedded Trace Extension(ETE) is a per CPU trace component that
> > > +  allows tracing the CPU execution. It overlaps with the CoreSight ETMv4
> > > +  architecture and has extended support for future architecture changes.
> > > +  The trace generated by the ETE could be stored via legacy CoreSight
> > > +  components (e.g, TMC-ETR) or other means (e.g, using a per CPU buffer
> > > +  Arm Trace Buffer Extension (TRBE)). Since the ETE can be connected to
> > > +  legacy CoreSight components, a node must be listed per instance, along
> > > +  with any optional connection graph as per the coresight bindings.
> > > +  See bindings/arm/coresight.txt.
> > > +
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^ete([0-9a-f]+)$"
> > > +  compatible:
> > > +    items:
> > > +      - const: arm,embedded-trace-extension
> > > +
> > > +  cpu:
> > 
> > We've already established 'cpus' for this purpose.
> > 
> 
> Please see : https://lkml.kernel.org/r/9417218b-6eda-373b-a2cb-869089ffc7cd@arm.com
> for my response in the previous version to this and the one with out-ports.

Okay, fair enough.

> 
> > > +    description: |
> > > +      Handle to the cpu this ETE is bound to.
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +
> > > +  out-ports:
> > > +    type: object
> > 
> > Replace with: $ref: /schemas/graph.yaml#/properties/ports
> 
> So, just to confirm again :
> The CoreSight graph bindings expect the input ports and output ports
> grouped under in-ports{} and out-ports{} respectively to avoid having
> to specify the direction of the ports in the individual "port" nodes.
> i.e
> 
> in-ports {
> 
> 	property: ports
> 	  OR
> 	property: port
> 
> 	required:
> 		OneOf:
> 			ports
> 			port

No, 'ports' as a child of in-ports is not correct. There should only be 
'port(@[0-9a-f]+)?' nodes. That's why you need the above $ref added. The 
$ref doesn't define the node name is 'ports', but what a 'ports' or 
'foo-ports' contains.

> }
> 
> out-ports {
> 
> 	# same as above
> }
> 
> So thats why I added out-ports as a new object, where the ports/port
> could be a child node.
> 
> Ideally the definition of out-ports /in-ports should go to a common schema
> for CoreSight bindings, when we move to Yaml for the existing bindings,
> which will follow in a separate series, later.

Yes, maybe, but I'm not sure something common is going to help here. 
You'll still have to describe what each 'port' node does in each device 
specific binding.

Rob
