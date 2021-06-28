Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC173B5A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhF1Ig4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232353AbhF1Igx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624869266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BaA05LSXDHChHzjRGg73pz540UQJsz3irrDNsnm9Uhc=;
        b=ad2+Ix89hY1uOEacXhI6kaxsaKau8pLswsEDYq9of379x7hGTgmeejH1b3+GwdOqy+PU7x
        KIWJxucXpd0lB32hFwcRbNx1B9pmmjWz7PxOqN5PVnrTxX1EOxi3Er1u19as4CCMQpihi5
        LMeOBZLSc05TdflYjVYz36Sjv4G8GvY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-V-S2LHLeNKKR6Yz7wzCTPQ-1; Mon, 28 Jun 2021 04:34:25 -0400
X-MC-Unique: V-S2LHLeNKKR6Yz7wzCTPQ-1
Received: by mail-ed1-f71.google.com with SMTP id z5-20020a05640235c5b0290393974bcf7eso9045405edc.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 01:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BaA05LSXDHChHzjRGg73pz540UQJsz3irrDNsnm9Uhc=;
        b=nrPOiFA2aieDd+lERCtseQpiTNw9kaESPYHKHYqGkJ+eN+6LBrS2IKBuHSkUCiwnln
         4/+BbuBifuUwcdi3IDubOYK8PCFDH4pbNxEP991VB+bNegPdVJ1iuIr7x3iKcI8QmvZk
         HHFlgoa/VoaCIXsXECqQJ+iZH5+p3nChcDHNinE6ZDM0/COWWDnT2pLSvQzXRi98ctbh
         V477VTZsJtfmikmXnDj3N6mJw8PCY+j9U2uOOu/Aiu/dNBBD4KzyRaSteJt4SFBypGUk
         f/BucjGjBSUaLxxIXbzGDFZXcdfR0vwMRt/0psyVq0bEppEIiwLaQ6oWJfJI4A38Ffww
         l+uA==
X-Gm-Message-State: AOAM532zRlO9lVOY66EyUuNTcPEd6xfPqtAy5HwRsLWTOP3skEuoXqQ5
        rIVVKnSgUX7btgoMtD8qpm/vebC3ZxT+l5ZVxs8UrioZMg+0Wl0AgjcbRB1jf4IX2lN7RrC3KIw
        LTcan6RnmUrA68vfWxr+nEbEN
X-Received: by 2002:aa7:c54c:: with SMTP id s12mr31848944edr.24.1624869263939;
        Mon, 28 Jun 2021 01:34:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaj3Ah5f4hXpXN+sCUyDTF1a0Fp2L4NjiiQBqnCwrA1yUuU/Wgm59g3JxlNSGWzxEVMRD2AQ==
X-Received: by 2002:aa7:c54c:: with SMTP id s12mr31848926edr.24.1624869263671;
        Mon, 28 Jun 2021 01:34:23 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id m7sm6527201ejo.95.2021.06.28.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 01:34:23 -0700 (PDT)
Date:   Mon, 28 Jun 2021 10:34:20 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robh+dt@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v4] Documentation, dt, numa: Add note to empty NUMA node
Message-ID: <20210628083420.v47xbbtcgjj2mu47@gator>
References: <20210625052338.4875-1-gshan@redhat.com>
 <20210625070217.4ffmfe7nwlusbbjc@gator>
 <20210625070656.j373hveemf5cdch4@gator>
 <41643136-798b-a0f3-aee7-b6af94a2fc67@redhat.com>
 <20210625101821.3t3vgj2pnw3hqpzm@gator>
 <62d04903-e4f3-2302-d530-5942e33ae116@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d04903-e4f3-2302-d530-5942e33ae116@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:14:49PM +1000, Gavin Shan wrote:
> On 6/25/21 8:18 PM, Andrew Jones wrote:
> > On Fri, Jun 25, 2021 at 06:36:48PM +1000, Gavin Shan wrote:
> > > On 6/25/21 5:06 PM, Andrew Jones wrote:
> > > > On Fri, Jun 25, 2021 at 09:02:17AM +0200, Andrew Jones wrote:
> > > > > On Fri, Jun 25, 2021 at 01:23:38PM +0800, Gavin Shan wrote:
> > > > > > The empty memory nodes, where no memory resides in, are allowed.
> > > > > > For these empty memory nodes, the 'len' of 'reg' property is zero.
> > > > > > The NUMA node IDs are still valid and parsed, but memory can be
> > > > > > added to them through hotplug afterwards. I finds difficulty to
> > > > > > get where it's properly documented.
> > > > > > 
> > > > > > So lets add note to empty memory nodes in the NUMA binding doc.
> > > > > > 
> > > > > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > > > > ---
> > > > > >    Documentation/devicetree/bindings/numa.txt | 4 ++++
> > > > > >    1 file changed, 4 insertions(+)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> > > > > > index 21b35053ca5a..0fc882e44270 100644
> > > > > > --- a/Documentation/devicetree/bindings/numa.txt
> > > > > > +++ b/Documentation/devicetree/bindings/numa.txt
> > > > > > @@ -109,6 +109,10 @@ Example:
> > > > > >    Dual socket system consists of 2 boards connected through ccn bus and
> > > > > >    each board having one socket/soc of 8 cpus, memory and pci bus.
> > > > > > +Note that empty memory nodes, which no memory resides in, are allowed.
> > > > > > +The NUMA node IDs in these empty memory nodes are still valid, but
> > > > > > +memory can be added into them through hotplug afterwards.
> > > > > 
> > > > > Please change the second sentence to:
> > > > > 
> > > > >     The NUMA node IDs in these empty memory nodes are still valid and
> > > > >     memory may be added into them through hotplug afterwards.
> > > > > 
> > > > > But, this doesn't look like the right place for this paragraph. You're
> > > > > adding the paragraph to the example section, but the example doesn't have
> > > > > any empty memory nodes.
> > > > > 
> > > > > I think the paragraph should be added to section "2 - numa-node-id" and an
> > > > 
> > > > Or maybe even create a new section for it.
> > > > 
> > > > > example empty memory node should be provided. Also, the commit message
> > > > > talks about the length of 'reg' being zero, which is an important
> > > > > distinction which should also be documented.
> > > > > 
> > > 
> > > Drew, thanks for your comments. Yeah, it sounds sensible to create
> > > a new section for it and an example would be more helpful. Please
> > > check if below changes are fine to you. I probably need Randy's review
> > > again.
> > > 
> > > I'm trying to avoid too many revisions for this sort of trivial patch,
> > > even though I already had. However, it's time frame for v5.14 and I'm
> > > pushing this to be merged during the cycle.
> > 
> > We must revise until we're satisfied... Also, I wouldn't call writing
> > specifications trivial.
> > 
> 
> [...]
> 
> > I'll just rewrite it:
> > 
> >   Empty memory nodes, which no memory resides in, are allowed. The 'length'
> >   field of the 'reg' property is zero, but the 'base-address' is a dummy
> >   address and invalid. However, the NUMA node IDs and distance maps are
> >   still valid and memory may be added into them through hotplug afterwards.
> > 
> 
> [...]
> 
> > 
> > You should write how you've selected the dummy addresses for the empty
> > memory nodes, perhaps here in the /* Empty memory node */ comments or
> > above in the paragraph or both.
> > 
> > > +	memory@0x100000000 {
> > > +		device_type = "memory";
> > > +		reg = <0x1 0x0 0x0 0x0>;
> > > +		numa-node-id = <2>;
> > > +	};
> > > +
> > > +	/* Empty memory node */
> > > +	memory@0x180000000 {
> > > +		device_type = "memory";
> > > +		reg = <0x1 0x80000000 0x0 0x0>;
> > > +		numa-node-id = <3>;
> > > +	};
> > > +
> 
> [...]
> 
> Thanks, Drew. As 'base-address' is dummy address and invalid. So we
> would note it as suggestion. With your suggestion integrated, how about
> something like this?
> 
> ==============================================================================
> 4 - Empty memory nodes
> ==============================================================================
> 
> Empty memory nodes, which no memory resides in, are allowed. The 'length'
> field of the 'reg' property is zero, but the 'base-address' is a dummy
> address and invalid. The 'base-address' could be the summation of highest
> memory address plus the NUMA node ID. However, the NUMA node IDs and
> distance maps are still valid and memory may be added into them through
> hotplug afterwards.
> 
>        :
> 
>        memory@0 {
>                 device_type = "memory";
>                 reg = <0x0 0x0 0x0 0x80000000>;
>                 numa-node-id = <0>;
>         };
> 
>         memory@0x80000000 {
>                 device_type = "memory";
>                 reg = <0x0 0x80000000 0x0 0x80000000>;
>                 numa-node-id = <1>;
>         };
> 
>         /* Empty memory node */
>         memory@0x100000002 {
>                 device_type = "memory";
>                 reg = <0x1 0x2 0x0 0x0>;
>                 numa-node-id = <2>;
>         };
> 
>         /* Empty memory node */
>         memory@0x100000003 {
>                 device_type = "memory";
>                 reg = <0x1 0x3 0x0 0x0>;
>                 numa-node-id = <3>;
>         };
> 
>         :
> 
> Thanks,
> Gavin
> 
>

Looks good to me.

Thanks,
drew 

