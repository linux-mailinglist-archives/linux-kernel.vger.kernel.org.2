Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A043B415A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhFYKUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229956AbhFYKUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624616306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j4JjaRWxUDx5AdOtHK4Ew9qGgb8hCuqA6q+y3PqBTgY=;
        b=D4dZP871d4DkvI4FcGvb2j9zIArTDYNH4+bEMTsCF4vVaKiN7CmilwaEJJIte2YkidjUqo
        27pUP6zFLPbZD8JdSg4xjJtihoN2+a2PIyklMXkkFvcMwt3lBbk+kwu5AKBFEx5chKoQ1u
        lNyAKBkULQL8DXpNugNZmG9wP8zU4r4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-vtwYtqmQNBe-h-5nibvurw-1; Fri, 25 Jun 2021 06:18:24 -0400
X-MC-Unique: vtwYtqmQNBe-h-5nibvurw-1
Received: by mail-ed1-f71.google.com with SMTP id o16-20020aa7c7d00000b02903951279f8f3so2121398eds.11
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4JjaRWxUDx5AdOtHK4Ew9qGgb8hCuqA6q+y3PqBTgY=;
        b=PI2khcGFPsQIb/Ze4uiI/irfyv5v6rXld6UfuMXryu4Y0eV2BfhXZkTObz7T83xThA
         bhlvCVmZwCcMEe08kralahdsBPDD5JmCJPsTjiqX+vyP7rxuhLu6B5htfZbiM4Dq2i/g
         ZfhrzBXainSlEL/baoLOtAUqysUqmENqBjWW1+8erR83mpHSUQCSjoB8JysaG4o3poeH
         rU6eSZ9y8otwbMt/y6h8YwZ1UPlUbNzNbX8SAVCTN6p4HxJF6pPlLKBd5hbuwwsy0dnC
         VmUrs/nZv0baU6ufNZ/IaUJaaDgkKW23Iz0awMLONLl1sSXl8Y/x4VCuNzqZ8Mvby/Jp
         K0Dw==
X-Gm-Message-State: AOAM533EMWv7G0dk97W29NheiX2ZqT4cUuJNBm3hfJ6hk1M9jwe9dadA
        f+HQCuh4QAEE7YZR3u6o9U/QVcwsL5wT/fJ/vHRfCnHP5e29lpIZMiv/QFs4+uljmLkS5UvWULV
        QhgAEIyneuK+54NZoJ5QSKO/l
X-Received: by 2002:a05:6402:1205:: with SMTP id c5mr825484edw.68.1624616303497;
        Fri, 25 Jun 2021 03:18:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZ2VSyWKHxXfWjdEbJqwFfP1+cB72b3Qml5NrsRAiLAiJuSsz8pxPlIKRyTD4YB8/ZhtdlSg==
X-Received: by 2002:a05:6402:1205:: with SMTP id c5mr825463edw.68.1624616303266;
        Fri, 25 Jun 2021 03:18:23 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id s18sm2526921ejh.12.2021.06.25.03.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:18:22 -0700 (PDT)
Date:   Fri, 25 Jun 2021 12:18:21 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robh+dt@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v4] Documentation, dt, numa: Add note to empty NUMA node
Message-ID: <20210625101821.3t3vgj2pnw3hqpzm@gator>
References: <20210625052338.4875-1-gshan@redhat.com>
 <20210625070217.4ffmfe7nwlusbbjc@gator>
 <20210625070656.j373hveemf5cdch4@gator>
 <41643136-798b-a0f3-aee7-b6af94a2fc67@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41643136-798b-a0f3-aee7-b6af94a2fc67@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 06:36:48PM +1000, Gavin Shan wrote:
> On 6/25/21 5:06 PM, Andrew Jones wrote:
> > On Fri, Jun 25, 2021 at 09:02:17AM +0200, Andrew Jones wrote:
> > > On Fri, Jun 25, 2021 at 01:23:38PM +0800, Gavin Shan wrote:
> > > > The empty memory nodes, where no memory resides in, are allowed.
> > > > For these empty memory nodes, the 'len' of 'reg' property is zero.
> > > > The NUMA node IDs are still valid and parsed, but memory can be
> > > > added to them through hotplug afterwards. I finds difficulty to
> > > > get where it's properly documented.
> > > > 
> > > > So lets add note to empty memory nodes in the NUMA binding doc.
> > > > 
> > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > > ---
> > > >   Documentation/devicetree/bindings/numa.txt | 4 ++++
> > > >   1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> > > > index 21b35053ca5a..0fc882e44270 100644
> > > > --- a/Documentation/devicetree/bindings/numa.txt
> > > > +++ b/Documentation/devicetree/bindings/numa.txt
> > > > @@ -109,6 +109,10 @@ Example:
> > > >   Dual socket system consists of 2 boards connected through ccn bus and
> > > >   each board having one socket/soc of 8 cpus, memory and pci bus.
> > > > +Note that empty memory nodes, which no memory resides in, are allowed.
> > > > +The NUMA node IDs in these empty memory nodes are still valid, but
> > > > +memory can be added into them through hotplug afterwards.
> > > 
> > > Please change the second sentence to:
> > > 
> > >    The NUMA node IDs in these empty memory nodes are still valid and
> > >    memory may be added into them through hotplug afterwards.
> > > 
> > > But, this doesn't look like the right place for this paragraph. You're
> > > adding the paragraph to the example section, but the example doesn't have
> > > any empty memory nodes.
> > > 
> > > I think the paragraph should be added to section "2 - numa-node-id" and an
> > 
> > Or maybe even create a new section for it.
> > 
> > > example empty memory node should be provided. Also, the commit message
> > > talks about the length of 'reg' being zero, which is an important
> > > distinction which should also be documented.
> > > 
> 
> Drew, thanks for your comments. Yeah, it sounds sensible to create
> a new section for it and an example would be more helpful. Please
> check if below changes are fine to you. I probably need Randy's review
> again.
> 
> I'm trying to avoid too many revisions for this sort of trivial patch,
> even though I already had. However, it's time frame for v5.14 and I'm
> pushing this to be merged during the cycle.

We must revise until we're satisfied... Also, I wouldn't call writing
specifications trivial.

> 
> --- a/Documentation/devicetree/bindings/numa.txt
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -103,7 +103,65 @@ Example:
>  		};
>  ==============================================================================
> -4 - Example dts
> +4 - Empty memory node

nodes

> +==============================================================================
> +
> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
> +field of 'reg' property is zero, but 'base-address' is dummy and invalid

 is a dummy address and is invalid.

> +for these empty memory nodes.

Can drop this "for these empty memory nodes" that's clear from the
context.

> However, the NUMA node IDs and distance maps
> +for them are still valid, but memory may be added into them through hotplug
   ^ drop 'for them'         ^ Again, this should be "and". "but" is a
contrastive conjunction. We want to express that the nodes are valid *and*
may have memory hotplugged later.

> +afterwards.

I'll just rewrite it:

 Empty memory nodes, which no memory resides in, are allowed. The 'length'
 field of the 'reg' property is zero, but the 'base-address' is a dummy
 address and invalid. However, the NUMA node IDs and distance maps are
 still valid and memory may be added into them through hotplug afterwards.

> +
> +Example:
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +		numa-node-id = <0>;
> +	};
> +
> +	memory@0x80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x80000000>;
> +		numa-node-id = <1>;
> +	};
> +
> +	/* Empty memory node */

You should write how you've selected the dummy addresses for the empty
memory nodes, perhaps here in the /* Empty memory node */ comments or
above in the paragraph or both.

> +	memory@0x100000000 {
> +		device_type = "memory";
> +		reg = <0x1 0x0 0x0 0x0>;
> +		numa-node-id = <2>;
> +	};
> +
> +	/* Empty memory node */
> +	memory@0x180000000 {
> +		device_type = "memory";
> +		reg = <0x1 0x80000000 0x0 0x0>;
> +		numa-node-id = <3>;
> +	};
> +
> +	distance-map {
> +		compatible = "numa-distance-map-v1";
> +		distance-matrix = <0 0  10>,
> +				  <0 1  20>,
> +				  <0 2  40>,
> +				  <0 3  20>,
> +				  <1 0  20>,
> +				  <1 1  10>,
> +				  <1 2  20>,
> +				  <1 3  40>,
> +				  <2 0  40>,
> +				  <2 1  20>,
> +				  <2 2  10>,
> +				  <2 3  20>,
> +				  <3 0  20>,
> +				  <3 1  40>,
> +				  <3 2  20>,
> +				  <3 3  10>;
> +	};
> +
> +==============================================================================
> +5 - Example dts
>  ==============================================================================
>  Dual socket system consists of 2 boards connected through ccn bus and
> 
> 
> Thanks,
> Gavin
> 
>

Thanks,
drew

