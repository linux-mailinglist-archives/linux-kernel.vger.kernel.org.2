Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1444D918
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 16:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhKKPWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 10:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhKKPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 10:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636643996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2K10Q3RYJAYLzZSO7lPYSVevInAJlNcm48b9LQMpGM=;
        b=KWv+1+rlFcg7DI0aDvp3RDzsxTBMOVM5H6f6T83cki83NB0I3VhpS44EDiXaHh8hchXakb
        C4sUlj/8DD3f1FQuC7/udtcFvDNeo+BVLFK4ZXY9PVnXKGFzNxc4HjnLy3tEjdSZ2/1feO
        WVQssfXz1BttWzLN/DaWSItilpp6iHY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-v6nKBjEwPdOuECQSEpVSDg-1; Thu, 11 Nov 2021 10:19:55 -0500
X-MC-Unique: v6nKBjEwPdOuECQSEpVSDg-1
Received: by mail-ed1-f69.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so5682718edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 07:19:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=j2K10Q3RYJAYLzZSO7lPYSVevInAJlNcm48b9LQMpGM=;
        b=TuwhIU3YOcKsbdiaq3tqMzLAnlOn1UFuDcayjoXQzkKu/iLtfMUdHPc8GYP78WBXK0
         5LcDSz484rPuE6nFKlO+LVBNeCm8Cnz77vL5TNDab34Jl37U3SUvP18FQgC1lwlBtCYG
         U30OxRs0nF2isk+lyE6H6dEK8bpa5sx/h2LxqEFbmxGA3rkh4JHzfHfjeh/QSqi2hHNW
         degglY7ltvxbaUnck97KGxJyHhFi6kmcr38jP5vAMrdH0Gvt/xcZhMGCWAy4XH31MKjU
         hRzqHsuhvaBliDxOGgiT2KA0zmDUMcyLKIRnrEQw01aaQGevHwaBIKMMEc0/nwWAOoSN
         4CxA==
X-Gm-Message-State: AOAM530U83xePh41d05UpM1UzhTkLYspWNa8TlFdy4PgNI/5pLYow7aW
        3ORhtsT6008+1zcbnWgIOrD9+M4Zy/hQAcS2B3yI4bIjoAhG1Ro8wFdOCOV/2YPiU2OpQfttzV7
        obysyakupfHavtaFBqD/NPOfL
X-Received: by 2002:a17:907:3daa:: with SMTP id he42mr10526834ejc.160.1636643993890;
        Thu, 11 Nov 2021 07:19:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyX+KFReiwpzw5VrVHE+1osuTAa+gMpiHonwGnKiRCl72CA5QaAceNd1oRYUsyAX6jJQJbX+Q==
X-Received: by 2002:a17:907:3daa:: with SMTP id he42mr10526785ejc.160.1636643993635;
        Thu, 11 Nov 2021 07:19:53 -0800 (PST)
Received: from redhat.com ([2.55.135.246])
        by smtp.gmail.com with ESMTPSA id d13sm1682608edv.29.2021.11.11.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 07:19:52 -0800 (PST)
Date:   Thu, 11 Nov 2021 10:19:47 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <20211111100414-mutt-send-email-mst@kernel.org>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110054121-mutt-send-email-mst@kernel.org>
 <dcaf10bed215456ab689956275d4b998@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcaf10bed215456ab689956275d4b998@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 07:58:29AM +0000, Wang, Wei W wrote:
> On Wednesday, November 10, 2021 6:50 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 10, 2021 at 07:12:36AM +0000, Wang, Wei W wrote:
> >
> > hypercalls are fundamentally hypervisor dependent though.
> 
> Yes, each hypervisor needs to support it.
> We could simplify the design and implementation to the minimal, so that each hypervisor can easily support it.
> Once every hypervisor has the support, the guest (MigTD) could be a unified version.
> (e.g. no need for each hypervisor user to develop their own MigTD using their own vsock transport)
> 
> > Assuming you can carve up a hypervisor independent hypercall, using it for
> > something as mundane and specific as vsock for TDX seems like a huge overkill.
> > For example, virtio could benefit from faster vmexits that hypercalls give you
> > for signalling.
> > How about a combination of virtio-mmio and hypercalls for fast-path signalling
> > then?
> 
> We thought about virtio-mmio. There are some barriers:
> 1) It wasn't originally intended for x86 machines. The only machine type in QEMU
> that supports it (to run on x86) is microvm. But "microvm" doesn’t support TDX currently,
> and adding this support might need larger effort.
> 2) It's simpler than virtio-pci, but still more complex than hypercall.
> 3) Some CSPs don't have virtio support in their software, so this might add too much development effort for them.
> 
> This usage doesn’t need high performance, so faster hypercall for signalling isn't required, I think.
> (but if hypercall has been verified to be much faster than the current EPT misconfig based notification,
> it could be added for the general virtio usages)
> 
> > 
> > > 2)       It is simpler. It doesn’t rely on any complex bus enumeration
> > >
> > > (e.g. virtio-pci based vsock device may need the whole implementation of
> > PCI).
> > >
> > 
> > Next thing people will try to do is implement a bunch of other device on top of
> > it.  virtio used pci simply because everyone implements pci.  And the reason
> > for *that* is because implementing a basic pci bus is dead simple, whole of
> > pci.c in qemu is <3000 LOC.
> 
> This doesn’t include the PCI enumeration in seaBIOS and the PCI driver in the guest though.

Do we really need to worry about migrating guests that did not complete
PCI enumeration yet?

Anyway, kvm unit test has a ~500 LOC pci driver.  It does not support pci bridges
or interrupts though - if you want to do that then requiring that the device in
question is on bus 0 and using polling seems like a reasonable limitation?

> Virtio has high performance, I think that's an important reason that more devices are continually added.
> For this transport, I couldn’t envision that a bunch of devices would be added. It's a simple PV method.

Famous last words. My point is adding a vendor agnostic hypercall needs
a bunch of negotiation and agreement between vendors. If you are going
to all the trouble, it seems like a waste to make it single use.

> 
> > 
> > >
> > > An example usage is the communication between MigTD and host (Page 8
> > > at
> > >
> > > https://static.sched.com/hosted_files/kvmforum2021/ef/
> > > TDX%20Live%20Migration_Wei%20Wang.pdf).
> > >
> > > MigTD communicates to host to assist the migration of the target (user) TD.
> > >
> > > MigTD is part of the TCB, so its implementation is expected to be as
> > > simple as possible
> > >
> > > (e.g. bare mental implementation without OS, no PCI driver support).
> > >
> > >
> > 
> > Try to list drawbacks? For example, passthrough for nested virt isn't possible
> > unlike pci, neither are hardware implementations.
> > 
> 
> Why hypercall wouldn't be possible for nested virt?
> L2 hypercall goes to L0 directly and L0 can decide whether to forward the call the L1 (in our case, I think no need as the packet will go out), right?
> 
> Its drawbacks are obvious (e.g. low performance). 

Exactly.

> In general, I think it could be considered as a complement to virtio.
> I think most usages would choose virtio as they don’t worry about the complexity and they purse high performance.
> For some special usages that think virtio is too complex to suffice and they want something simpler, they would consider to use this transport。
> 
> Thanks,
> Wei

So implement a small subset of virtio then, no one forces you to use all
its features. virtio mmio is about 30 registers, most can be stubbed to
constants. packed ring is much simpler than split one.

-- 
MST

