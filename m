Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790DA3B3D02
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhFYHJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:09:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhFYHJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624604822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pbp23JlztCvQMDGSzMZ1vEk44RnDqxHLzKF7l4kjbo8=;
        b=FyukX7w2i/F3f1kqZX+5YL8eBYc0UUCqIdRMRPIChHb8CMG9dXT+rCvmOSfchqDctSBo1G
        JCOzeTgj+11h8p/31vC9the4OSgt6GiiLqCne3YjF09iKohKNwnTQR1i4LKULYUXtf24IP
        8yzn5ACBgj35LVQxf2CaIrxbD8OesQE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-_FWv4OPeNxm2lGx0kRf8Zw-1; Fri, 25 Jun 2021 03:07:00 -0400
X-MC-Unique: _FWv4OPeNxm2lGx0kRf8Zw-1
Received: by mail-ed1-f72.google.com with SMTP id t11-20020a056402524bb029038ffacf1cafso4692258edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pbp23JlztCvQMDGSzMZ1vEk44RnDqxHLzKF7l4kjbo8=;
        b=ToIGvfDSOVQJve6wn/sXrRMEzaXZUblzTqDJ1F2P5P4cCrW3Me1hltzw0c7BPdZNI4
         e3zY8FnlFGGqiLrBqD7UcPWUqo+vlBwEbheb8mxGc3XtkuaKS+7kjamuJrooUUewrqY7
         37C2C916OSy0kZMZQzU4/6geAQJlHzxruTMuWHIlTedvyQjr77jmquE9Mtd6QZtSBf0a
         +EeBvbpaqAODzcgx+lGquI5FXboyYzsExoa9rlGXJNiPQoAYnYFBr1cX9P3A5N9fmrnV
         bP+d+KV1Szzlnmz98C6ku2t73AWUJx9AY7GK+gWAQ6V6V6WjgpNHBSdrorMFdYzEvXI3
         KZ/w==
X-Gm-Message-State: AOAM533kHRiyN3yJGAve976TOUSwBFrxphfvGNDbSuEvNfEmHspgoNl0
        4YERZOUHLmGzpE6V7FMy3E6tk2tp2em3vpfZGeKAStuF14qU262/oNGngf2E19exHmQWMhb/7du
        OrJIyEwqb2KK4LN86iUInZKsU
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr9248399eja.275.1624604819189;
        Fri, 25 Jun 2021 00:06:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyaw4UrNydP6rJ+aMKvQTiKfg4uzK7jEe1lT6tuybSH8BIUV+HiOjSEMQXmQAWrdq0eFca0A==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr9248372eja.275.1624604818971;
        Fri, 25 Jun 2021 00:06:58 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id e28sm3333482edc.24.2021.06.25.00.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:06:58 -0700 (PDT)
Date:   Fri, 25 Jun 2021 09:06:56 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robh+dt@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v4] Documentation, dt, numa: Add note to empty NUMA node
Message-ID: <20210625070656.j373hveemf5cdch4@gator>
References: <20210625052338.4875-1-gshan@redhat.com>
 <20210625070217.4ffmfe7nwlusbbjc@gator>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625070217.4ffmfe7nwlusbbjc@gator>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:02:17AM +0200, Andrew Jones wrote:
> On Fri, Jun 25, 2021 at 01:23:38PM +0800, Gavin Shan wrote:
> > The empty memory nodes, where no memory resides in, are allowed.
> > For these empty memory nodes, the 'len' of 'reg' property is zero.
> > The NUMA node IDs are still valid and parsed, but memory can be
> > added to them through hotplug afterwards. I finds difficulty to
> > get where it's properly documented.
> > 
> > So lets add note to empty memory nodes in the NUMA binding doc.
> > 
> > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > ---
> >  Documentation/devicetree/bindings/numa.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> > index 21b35053ca5a..0fc882e44270 100644
> > --- a/Documentation/devicetree/bindings/numa.txt
> > +++ b/Documentation/devicetree/bindings/numa.txt
> > @@ -109,6 +109,10 @@ Example:
> >  Dual socket system consists of 2 boards connected through ccn bus and
> >  each board having one socket/soc of 8 cpus, memory and pci bus.
> >  
> > +Note that empty memory nodes, which no memory resides in, are allowed.
> > +The NUMA node IDs in these empty memory nodes are still valid, but
> > +memory can be added into them through hotplug afterwards.
> 
> Please change the second sentence to:
> 
>   The NUMA node IDs in these empty memory nodes are still valid and
>   memory may be added into them through hotplug afterwards.
> 
> But, this doesn't look like the right place for this paragraph. You're
> adding the paragraph to the example section, but the example doesn't have
> any empty memory nodes.
> 
> I think the paragraph should be added to section "2 - numa-node-id" and an

Or maybe even create a new section for it.

> example empty memory node should be provided. Also, the commit message
> talks about the length of 'reg' being zero, which is an important
> distinction which should also be documented.
> 
> Thanks,
> drew
> 
> > +
> >  	memory@c00000 {
> >  		device_type = "memory";
> >  		reg = <0x0 0xc00000 0x0 0x80000000>;
> > -- 
> > 2.23.0
> > 

