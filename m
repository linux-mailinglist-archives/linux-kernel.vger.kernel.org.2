Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC13C3DF002
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbhHCORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbhHCORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:20 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0k6H0TlpQiIG8T0gkNhLFAoaG8dP3h1ysdzyIOTlzbg=;
        b=IdCNmtXWkWR04l93utaEbWisUqgSX+dBsCOfdXQoDAipMLnvjKsikYNCRqqU899fMoXuTg
        s8yxboNK+sIuCbRlmz/nNr65YmVO5Yzg3nUsZFk8xoNYyfig1BWc8zPY2DZ3jZ2bQNoapo
        Z9617OCaHPL4RkhCRUQFGz4nLnERe4gz9zt8oycKx6Ll1C2IkRt7U4EJ7BLHoPVxOVgu+K
        A2FzxUImK30aqumH9YfdkWZnAJtGIRre2wJOoIw4zbYHXNNkrPz2fg3xjPBjZAHRPQir2I
        xhiUOX87sMzRmwG1DpTDkxRGwlhphjLQXiuwqIFzjidNCR1D5dJNiYKbmdkwKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0k6H0TlpQiIG8T0gkNhLFAoaG8dP3h1ysdzyIOTlzbg=;
        b=udVCVLJ2newdh0ZNz56+jM9pkapoG3FVJX45U+XcubImZJjAMfVV4GflHIaF7zx5LTUb9A
        oEOrO6NraEAp6sCA==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Gonglei <arei.gonglei@huawei.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH 12/38] crypto: virtio: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:55 +0200
Message-Id: <20210803141621.780504-13-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Gonglei <arei.gonglei@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/crypto/virtio/virtio_crypto_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_core.c b/drivers/crypto/vi=
rtio/virtio_crypto_core.c
index 080955a1dd9c0..e2375d9923087 100644
--- a/drivers/crypto/virtio/virtio_crypto_core.c
+++ b/drivers/crypto/virtio/virtio_crypto_core.c
@@ -187,9 +187,9 @@ static int virtcrypto_init_vqs(struct virtio_crypto *vi)
 	if (ret)
 		goto err_free;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	virtcrypto_set_affinity(vi);
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return 0;
=20
--=20
2.32.0

