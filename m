Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6BC45D4E1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 07:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346090AbhKYGnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 01:43:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346104AbhKYGlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 01:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637822280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eHJ7MMRM38qWNKAfIMagbO6YequielqNERfHEsYHFTs=;
        b=NhbfXD459N4blxY6iUQn41Y0uKQnImFscg8PdzCW9I4+V/b1gCHHDuO9FEGbICZOlP0FV5
        j4XOxdy4jglGgYGt6CAQREsw8Rum8AhU0c/DuqPzVYmuB3kZrB7jmWkU9JIlBDnhLF1dZ3
        nK8h4XuhHDsr1ay1yqCiiuEbA5MLq3o=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-K_J7848HPjOVu1U7uWO-Iw-1; Thu, 25 Nov 2021 01:37:58 -0500
X-MC-Unique: K_J7848HPjOVu1U7uWO-Iw-1
Received: by mail-lj1-f200.google.com with SMTP id b16-20020a2ebc10000000b00218d00045c4so1550126ljf.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 22:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eHJ7MMRM38qWNKAfIMagbO6YequielqNERfHEsYHFTs=;
        b=pf+7Qh7VCy60IYkyABeJK1upPeRAQ/wwuuON0DIdiZZWI+waIvRdkp1a1yPLKnyFLG
         tgKSGUuR7f1OJNgbaV+XZZREtPJFlIjkOT2Xe5s/SmGRwu8ZVRySaLCg9DkL6FHaOAPJ
         nGOqvwUgIda2o4i3N2ZhnBauwIxSM78UcwpA4Qprz0oHeuvDXTzj+Plbo8dTqesqUdO7
         dTIidflPt4/PC29YpXGA/MW5ozwfHFKdXBbR0jC42QwBabRUDCfYFDavq3QruXhQuK5d
         BXHSzEKs42janwgd4lkdinbA7Leo+mBwdyBQLUZqwpopkwWQ+/KpvOwD2lSL+zTikVB+
         WMaw==
X-Gm-Message-State: AOAM532g8ZU95mllBvc23ICuo1a8n4pf27HwKVbFUUxBUsLiW5s4cmWq
        ja7Ew688GHv3kwoFpI+4OgK1W1L6IxprF9ypslXYBflz7wHM3himUtE98PX5YGIOrZk2Zh+ID/r
        tkYux3x67I46KMDiBD7WZv6GY3nr+pfuHqkV0m8A8
X-Received: by 2002:a2e:b742:: with SMTP id k2mr23160436ljo.107.1637822277354;
        Wed, 24 Nov 2021 22:37:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfKDzopEf5gBdNkwJMujTdQMOR0YDXUEhfMXk5jRnMH1m3UyG7mWtqK+GkarTWkC+zcci02fv6RLhaAyr0vd8=
X-Received: by 2002:a2e:b742:: with SMTP id k2mr23160418ljo.107.1637822277134;
 Wed, 24 Nov 2021 22:37:57 -0800 (PST)
MIME-Version: 1.0
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com> <20211110054121-mutt-send-email-mst@kernel.org>
 <dcaf10bed215456ab689956275d4b998@intel.com>
In-Reply-To: <dcaf10bed215456ab689956275d4b998@intel.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 25 Nov 2021 14:37:46 +0800
Message-ID: <CACGkMEsY_XkRo_P+R=ipQ1iYm-AimvLvfXUwEy40Nn4f1D_suA@mail.gmail.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 3:59 PM Wang, Wei W <wei.w.wang@intel.com> wrote:
>
> On Wednesday, November 10, 2021 6:50 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 10, 2021 at 07:12:36AM +0000, Wang, Wei W wrote:
> >
> > hypercalls are fundamentally hypervisor dependent though.
>
> Yes, each hypervisor needs to support it.
> We could simplify the design and implementation to the minimal, so that e=
ach hypervisor can easily support it.
> Once every hypervisor has the support, the guest (MigTD) could be a unifi=
ed version.
> (e.g. no need for each hypervisor user to develop their own MigTD using t=
heir own vsock transport)
>
> > Assuming you can carve up a hypervisor independent hypercall, using it =
for
> > something as mundane and specific as vsock for TDX seems like a huge ov=
erkill.
> > For example, virtio could benefit from faster vmexits that hypercalls g=
ive you
> > for signalling.
> > How about a combination of virtio-mmio and hypercalls for fast-path sig=
nalling
> > then?
>
> We thought about virtio-mmio. There are some barriers:
> 1) It wasn't originally intended for x86 machines. The only machine type =
in QEMU
> that supports it (to run on x86) is microvm. But "microvm" doesn=E2=80=99=
t support TDX currently,
> and adding this support might need larger effort.

Can you explain why microvm needs larger effort? It looks to me it
fits for TDX perfectly since it has less attack surface.

Thanks

> 2) It's simpler than virtio-pci, but still more complex than hypercall.
> 3) Some CSPs don't have virtio support in their software, so this might a=
dd too much development effort for them.
>
> This usage doesn=E2=80=99t need high performance, so faster hypercall for=
 signalling isn't required, I think.
> (but if hypercall has been verified to be much faster than the current EP=
T misconfig based notification,
> it could be added for the general virtio usages)
>
> >
> > > 2)       It is simpler. It doesn=E2=80=99t rely on any complex bus en=
umeration
> > >
> > > (e.g. virtio-pci based vsock device may need the whole implementation=
 of
> > PCI).
> > >
> >
> > Next thing people will try to do is implement a bunch of other device o=
n top of
> > it.  virtio used pci simply because everyone implements pci.  And the r=
eason
> > for *that* is because implementing a basic pci bus is dead simple, whol=
e of
> > pci.c in qemu is <3000 LOC.
>
> This doesn=E2=80=99t include the PCI enumeration in seaBIOS and the PCI d=
river in the guest though.
>
> Virtio has high performance, I think that's an important reason that more=
 devices are continually added.
> For this transport, I couldn=E2=80=99t envision that a bunch of devices w=
ould be added. It's a simple PV method.
>
>
> >
> > >
> > > An example usage is the communication between MigTD and host (Page 8
> > > at
> > >
> > > https://static.sched.com/hosted_files/kvmforum2021/ef/
> > > TDX%20Live%20Migration_Wei%20Wang.pdf).
> > >
> > > MigTD communicates to host to assist the migration of the target (use=
r) TD.
> > >
> > > MigTD is part of the TCB, so its implementation is expected to be as
> > > simple as possible
> > >
> > > (e.g. bare mental implementation without OS, no PCI driver support).
> > >
> > >
> >
> > Try to list drawbacks? For example, passthrough for nested virt isn't p=
ossible
> > unlike pci, neither are hardware implementations.
> >
>
> Why hypercall wouldn't be possible for nested virt?
> L2 hypercall goes to L0 directly and L0 can decide whether to forward the=
 call the L1 (in our case, I think no need as the packet will go out), righ=
t?
>
> Its drawbacks are obvious (e.g. low performance).
> In general, I think it could be considered as a complement to virtio.
> I think most usages would choose virtio as they don=E2=80=99t worry about=
 the complexity and they purse high performance.
> For some special usages that think virtio is too complex to suffice and t=
hey want something simpler, they would consider to use this transport=E3=80=
=82
>
> Thanks,
> Wei
>

