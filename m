Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5ED3F5C92
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhHXLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39144 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236358AbhHXLAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629802806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=b832D+EXyszaBxwNcuDTgB1pwTGihDYZVkFT3v4m2hk=;
        b=DV3KPsokOYyRrK8W5og4C8z3bsaUmPMW3rmf/4xnuVXTyKgyB47+MX9/wc8Kfxm/R/ebpL
        /otFpLAkrA0lB1Iz5/NJ+5yx09qgZ+UeMraTheD07M4NOID4BJ5RozWHCu9O/oLeBPmfZP
        ToXfNL7FE6iSm59pvFjvC1sDuom5gzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-q3b7joqBNYiDAOHpiP__sw-1; Tue, 24 Aug 2021 07:00:05 -0400
X-MC-Unique: q3b7joqBNYiDAOHpiP__sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7D1E879A09;
        Tue, 24 Aug 2021 11:00:03 +0000 (UTC)
Received: from localhost (unknown [10.39.195.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 572F5226F0;
        Tue, 24 Aug 2021 10:59:51 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, vgoyal@redhat.com,
        jasowang@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH 0/1] virtio: false unhandled irqs from vring_interrupt()
Date:   Tue, 24 Aug 2021 11:59:43 +0100
Message-Id: <20210824105944.172659-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While investigating an unhandled irq from vring_interrupt() with virtiofs I=
=0D
stumbled onto a possible race that also affects virtio_gpu. This theory is=
=0D
based on code inspection and hopefully you can point out something that mak=
es=0D
this a non-issue in practice :).=0D
=0D
The vring_interrupt() function returns IRQ_NONE when an MSI-X interrupt is=
=0D
taken with no used (completed) buffers in the virtqueue. The kernel disable=
s=0D
the irq and the driver is no longer receives irqs when this happens:=0D
=0D
  irq 77: nobody cared (try booting with the "irqpoll" option)=0D
  ...=0D
  handlers:=0D
  [<00000000a40a49bb>] vring_interrupt=0D
  Disabling IRQ #77=0D
=0D
Consider the following:=0D
=0D
1. An virtiofs irq is handled and the virtio_fs_requests_done_work() work=0D
   function is scheduled to dequeue used buffers:=0D
   vring_interrupt() -> virtio_fs_vq_done() -> schedule_work()=0D
=0D
2. The device adds more used requests and just before...=0D
=0D
3. ...virtio_fs_requests_done_work() empties the virtqueue with=0D
   virtqueue_get_buf().=0D
=0D
4. The device raises the irq and vring_interrupt() is called after=0D
   virtio_fs_requests_done_work emptied the virtqueue:=0D
=0D
   irqreturn_t vring_interrupt(int irq, void *_vq)=0D
   {=0D
       struct vring_virtqueue *vq =3D to_vvq(_vq);=0D
=0D
       if (!more_used(vq)) {=0D
           pr_debug("virtqueue interrupt with no work for %p\n", vq);=0D
           return IRQ_NONE;=0D
           ^^^^^^^^^^^^^^^^=0D
=0D
I have included a patch that switches virtiofs from spin_lock() to=0D
spin_lock_irqsave() to prevent vring_interrupt() from running while the=0D
virtqueue is processed from a work function.=0D
=0D
virtio_gpu has a similar case where virtio_gpu_dequeue_ctrl_func() and=0D
virtio_gpu_dequeue_cursor_func() work functions only use spin_lock().=0D
I think this can result in the same false unhandled irq problem as virtiofs=
.=0D
=0D
This race condition could in theory affect all drivers. The VIRTIO=0D
specification says:=0D
=0D
  Neither of these notification suppression methods are reliable, as they a=
re=0D
  not synchronized with the device, but they serve as useful optimizations.=
=0D
=0D
If virtqueue_disable_cb() is just a hint and might not disable virtqueue ir=
qs=0D
then virtio_net and other drivers have a problem because because an irq cou=
ld=0D
be raised while the driver is dequeuing used buffers. I think we haven't se=
en=0D
this because software VIRTIO devices honor virtqueue_disable_cb(). Hardware=
=0D
devices might cache the value and not disable notifications for some time..=
.=0D
=0D
Have I missed something?=0D
=0D
The virtiofs patch I attached is being stress tested to see if the unhandle=
d=0D
irqs still occur.=0D
=0D
Stefan Hajnoczi (1):=0D
  fuse: disable local irqs when processing vq completions=0D
=0D
 fs/fuse/virtio_fs.c | 15 ++++++++++-----=0D
 1 file changed, 10 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

