Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA12C414ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236766AbhIVRKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236676AbhIVRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632330554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=SHrxHOUJFC7SXjO6oPt56HM9d80tm/abAg5EY0FI59M=;
        b=MCTvOO8xYoPzYUwfALlViZ4okVlsuJnAbZTaRZn+hu+Sr+YVIyfznOgLCuCyk9kofxSRsu
        BBHRJlRpbDiuB27VzAQJhd9zAr7ShyYW9U+wDs3Ig43ftIuFWeVGfWZFQBFH+Uaav6wPYL
        V6epK2EfocTnu+2voV0/Kld2FStfIyU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-bqVte1b5PcW-zOzon214Pw-1; Wed, 22 Sep 2021 13:09:11 -0400
X-MC-Unique: bqVte1b5PcW-zOzon214Pw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93E261023F4D;
        Wed, 22 Sep 2021 17:09:08 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.39.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F001E970E0;
        Wed, 22 Sep 2021 17:09:04 +0000 (UTC)
From:   Laurent Vivier <lvivier@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Potapenko <glider@google.com>,
        linux-crypto@vger.kernel.org, Dmitriy Vyukov <dvyukov@google.com>,
        rusty@rustcorp.com.au, amit@kernel.org, akong@redhat.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Matt Mackall <mpm@selenic.com>,
        virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 0/4] hwrng: virtio - add an internal buffer
Date:   Wed, 22 Sep 2021 19:08:59 +0200
Message-Id: <20210922170903.577801-1-lvivier@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hwrng core uses two buffers that can be mixed in the virtio-rng queue.=0D
=0D
This series fixes the problem by adding an internal buffer in virtio-rng.=0D
=0D
Once the internal buffer is added, we can fix two other problems:=0D
=0D
- to be able to release the driver without waiting the device releases the=
=0D
  buffer=0D
=0D
- actually returns some data when wait=3D0 as we can have some already=0D
  available data=0D
=0D
It also tries to improve the performance by always having a buffer in=0D
the queue of the device.=0D
=0D
Laurent Vivier (4):=0D
  hwrng: virtio - add an internal buffer=0D
  hwrng: virtio - don't wait on cleanup=0D
  hwrng: virtio - don't waste entropy=0D
  hwrng: virtio - always add a pending request=0D
=0D
 drivers/char/hw_random/virtio-rng.c | 84 +++++++++++++++++++++--------=0D
 1 file changed, 63 insertions(+), 21 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D

