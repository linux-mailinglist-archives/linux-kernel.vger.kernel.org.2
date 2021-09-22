Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C223414ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhIVRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 13:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236802AbhIVRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 13:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632330557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Du5vZNXnhXvnlyGaYPOtC+IJQXZjh+l7JG2ObOtN8d0=;
        b=V/qKiVU3qqJC5ewJrwzOx0aVdgR3YvBsvfGOc4hEfIeQDgHCfpZdRsrt6McvWgMWc5ZWFB
        a3rxhSyrA5HIL5g/8EqjJvH9Ok3L0DYIIFt8ZbaImz8jFYMPy/vGPJYgIJt7c9qDWzdqcc
        ZzL77PjFDkKlYePgHW6nUPF/7E8thP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-R0K_rPlnNMGz-__ugYJ27g-1; Wed, 22 Sep 2021 13:09:16 -0400
X-MC-Unique: R0K_rPlnNMGz-__ugYJ27g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BE888145EE;
        Wed, 22 Sep 2021 17:09:15 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.39.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B620652A1;
        Wed, 22 Sep 2021 17:09:12 +0000 (UTC)
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
Subject: [PATCH 2/4] hwrng: virtio - don't wait on cleanup
Date:   Wed, 22 Sep 2021 19:09:01 +0200
Message-Id: <20210922170903.577801-3-lvivier@redhat.com>
In-Reply-To: <20210922170903.577801-1-lvivier@redhat.com>
References: <20210922170903.577801-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When virtio-rng device was dropped by the hwrng core we were forced
to wait the buffer to come back from the device to not have
remaining ongoing operation that could spoil the buffer.

But now, as the buffer is internal to the virtio-rng we can release
the waiting loop immediately, the buffer will be retrieve and use
when the virtio-rng driver will be selected again.

This avoids to hang on an rng_current write command if the virtio-rng
device is blocked by a lack of entropy. This allows to select
another entropy source if the current one is empty.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 208c547dcac1..173aeea835bb 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -82,6 +82,11 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 		ret = wait_for_completion_killable(&vi->have_data);
 		if (ret < 0)
 			return ret;
+		/* if vi->data_avail is 0, we have been interrupted
+		 * by a cleanup, but buffer stays in the queue
+		 */
+		if (vi->data_avail == 0)
+			return read;
 
 		chunk = min_t(unsigned int, size, vi->data_avail);
 		memcpy(buf + read, vi->data, chunk);
@@ -105,7 +110,7 @@ static void virtio_cleanup(struct hwrng *rng)
 	struct virtrng_info *vi = (struct virtrng_info *)rng->priv;
 
 	if (vi->busy)
-		wait_for_completion(&vi->have_data);
+		complete(&vi->have_data);
 }
 
 static int probe_common(struct virtio_device *vdev)
-- 
2.31.1

