Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829114047C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhIIJcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:32:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhIIJcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631179897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oyk/5xbj6JBnipmhdcExzScdKjpjWsEFPTKPgPPwe0U=;
        b=YBl/gCbGJS+/Frcz0DURoZyWvbHlLCOT4mCtA+Sp/RGXFaJtcKRIllP8WZVWOlOWBS2gYF
        nuvJo+YF1ZhM9qvfY097qr8xHt/Fuu23mvKyMWJEVqEvFar0J3R7GY38PjXwSzrJk+t2rY
        bBupyCD+mzMP9hrPvNQAiG0/vx3sIrE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-JdQd7GcDO3KONU5oUZ_dfQ-1; Thu, 09 Sep 2021 05:31:36 -0400
X-MC-Unique: JdQd7GcDO3KONU5oUZ_dfQ-1
Received: by mail-lf1-f69.google.com with SMTP id x14-20020ac2488e000000b003d91325c257so515133lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 02:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyk/5xbj6JBnipmhdcExzScdKjpjWsEFPTKPgPPwe0U=;
        b=m/9wsxumNFHNjKX1jF8WXlxp2L69AN6mPAq0EqH34sEKEbPs0AP70JemY1glmd8VyZ
         aKR/IsGvtyKKrobWgfrv1JXy/Cdh8si/aMTxho218iWw9SgD6ZtdkMEn7vV6fH0+bzBo
         zLT8axydVsXu4V8lZFlz6xJQu6PxA0nTtMvAYLU1+yNBmu6VfhCRiHCJLUKGXrpLHyMd
         vBmFczOK0MpD/0/8kvqDYUbNSE595RyZMSsH11exxfG/AXphdKJzVdniJ5zntOeifaTW
         HCDnO3sHh/cMuAWyLw9Cnvngg+TL0AEb0/mOMbSC/wCubYCJA4hwfKBrcs3e6crq0Kh6
         +FMQ==
X-Gm-Message-State: AOAM5311Ys1vrG/cbUyoinsh51zUXJMRXBuT12tCosx0TNZBe6k4gClG
        CHtltHdRjGt4c49UziPEseSE006ApNozlE8BbKVVdpzIIhD+74igHIgf745Ar9pLeDMfWwDhlFU
        bdB+dInP9V0nU/csZFplUrD4peogPsjNeZ2EyCzyM
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr1579262lfg.629.1631179894476;
        Thu, 09 Sep 2021 02:31:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoCrurk4RtgIW8ahoORtM+vXj+ouEemSvE6SvpTvr8/YNjYdY8lb0LhbVcW+5BwC5jNXDL7KpsEazZVqPsEz4=
X-Received: by 2002:ac2:5fc5:: with SMTP id q5mr1579255lfg.629.1631179894307;
 Thu, 09 Sep 2021 02:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <CACGkMEuEwbDQUtYHz=0O4pQcb6ibY0MAT7hLDjN=Okw8c9CZGA@mail.gmail.com> <20210909051936-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210909051936-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Sep 2021 17:31:23 +0800
Message-ID: <CACGkMEvt5G-f4U=ReXNdmBcbywzsAhV1eYL2bP2Wp4RA_pKrYQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] vDPA driver for legacy virtio-pci device
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 5:21 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Sep 09, 2021 at 11:05:06AM +0800, Jason Wang wrote:
> > On Wed, Sep 8, 2021 at 8:22 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
> > >
> > > This series implements the vDPA driver for legacy virtio-pci device.
> > > Currently we already have the vDPA driver for modern virtio-pci device
> > > only, but there are some legacy virtio-pci devices conforming to the
> > > virtio-pci specifications of 0.9.x or older versions. For example,
> > > ENI(Elastic Network Interface) of Alibaba ECS baremetal instance is a
> > > hardware virtio network device which follows the Virtio PCI Card 0.9.5
> > > Draft specification. Such legacy virtio-pci devices have some
> > > inconsistent behaviour with modern virtio-pci devices, so some common
> > > codes are split out and modern device specific codes are moved to a
> > > separated file.
> >
> > What worries me a little bit are:
> >
> > 1) vDPA requires IOMMU_PLATFORM to be supported by the device to work,
> > if I understand ENI correctly, it's a legacy device so it can't
> > support ACCESS_PLATFORM. Or is it a legacy device that supports
> > ACCESS_PLATFORM implicitly.
> > 2) vDPA tries to present a 1.0 device, in this case the behavior could
> > be ruled by the spec. If we tries to present an 1.0 device on top of
> > legacy device we may suffer a lot of issues:
> >
> > - endian issue: 1.0 use le but legacy may use native endian
> > - queue_enable semantic which is missed in the legacy
> > - virtqueue size, as you mentioned below
>
> So this all kind of works when guest and host are
> strongly ordered and LE. Case in point x86.
> Question is how do we limit this to an x86 guest?
> Add a new ioctl declaring that this is the case?

I think the most simple way is to disable the driver on non LE host
(assuming it tries to use native endian which is kind of impossible).

Thanks

>
> --
> MST
>

