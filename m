Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6965945D9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 13:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhKYMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 07:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56132 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240085AbhKYMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 07:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637841882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3pVl0kkbRL9wlqXrxeUcmJA6blq5l7kvBORl/ZbdwE=;
        b=CxZTRGsYb5U8mFFaZxJ0x4nE3COnzZ6elVzQTdfHCcSCRtyaKg+nFJfMcOmYfNenEv2RiD
        mqN9KlXxLbctBvkgwx6jnh7xFDrE57UJotm/wIeYkZht39eJgSfe66xaE7qq0TijZADsFb
        WRt97x8Rt+OiObbGjTU+BT3z60IjWi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-p8NDlZe4PfC7_v_1qa6qaQ-1; Thu, 25 Nov 2021 07:04:39 -0500
X-MC-Unique: p8NDlZe4PfC7_v_1qa6qaQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C79E1100C663;
        Thu, 25 Nov 2021 12:04:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B07518171;
        Thu, 25 Nov 2021 12:04:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 1E7DD180092A; Thu, 25 Nov 2021 13:04:25 +0100 (CET)
Date:   Thu, 25 Nov 2021 13:04:25 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Wang, Wei W" <wei.w.wang@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "srutherford@google.com" <srutherford@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <20211125120425.s7kzzuvtdhqgyf3g@sirius.home.kraxel.org>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110054121-mutt-send-email-mst@kernel.org>
 <dcaf10bed215456ab689956275d4b998@intel.com>
 <CACGkMEsY_XkRo_P+R=ipQ1iYm-AimvLvfXUwEy40Nn4f1D_suA@mail.gmail.com>
 <58911901bd7b4bc3a99642214106bc2f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58911901bd7b4bc3a99642214106bc2f@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 08:43:55AM +0000, Wang, Wei W wrote:
> On Thursday, November 25, 2021 2:38 PM, Jason Wang wrote:
> > > We thought about virtio-mmio. There are some barriers:
> > > 1) It wasn't originally intended for x86 machines. The only machine
> > > type in QEMU that supports it (to run on x86) is microvm. But
> > > "microvm" doesn’t support TDX currently, and adding this support might
> > need larger effort.
> > 
> > Can you explain why microvm needs larger effort? It looks to me it fits for TDX
> > perfectly since it has less attack surface.
> 
> The main thing is TDVF doesn’t support microvm so far (the based OVMF
> support for microvm is still under their community discussion).

Initial microvm support (direct kernel boot only) is merged in upstream
OVMF.  Better device support is underway: virtio-mmio patches are out
for review, patches for pcie support exist.

TDX patches for OVMF are under review upstream, I havn't noticed
anything which would be a blocker for microvm.  If it doesn't work
out-of-the-box it should be mostly wiring up things needed on guest
(ovmf) and/or host (qemu) side.

(same goes for sev btw).

> Do you guys think it is possible to add virtio-mmio support for q35?
> (e.g. create a special platform bus in some fashion for memory mapped devices)
> Not sure if the effort would be larger.

I'd rather explore the microvm path than making q35 even more
frankenstein than it already is.

Also the pcie host bridge is present in q35 no matter what, so one of
the reasons to use virtio-mmio ("we can reduce the attach surface by
turning off pcie") goes away.

take care,
  Gerd

