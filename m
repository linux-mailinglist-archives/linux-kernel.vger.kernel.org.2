Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD345E064
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 19:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356757AbhKYSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 13:09:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239213AbhKYSH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 13:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637863457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uqHYC6pMdILCZt4L46t3fYUcohv6tOiNRcfAVmZ0lZA=;
        b=AX44U2Yt3XjNwY/ajB1oxIo/wQqpc+H7mNJI980qCXpd2KnzfAx7XJljXiNp0Td9UNDwwc
        B0qF62wJERbHqlSBZaGUsle9HQiNoMhp6NOWz5Ndd0itgSV685R+dF372GOjAYcNwa5Mvj
        sjo4A2gmvhhBRODKCpvFOJ39216raeI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-O0Xs8O5CPoOboC7wHD-gNQ-1; Thu, 25 Nov 2021 13:04:16 -0500
X-MC-Unique: O0Xs8O5CPoOboC7wHD-gNQ-1
Received: by mail-ed1-f70.google.com with SMTP id y9-20020aa7c249000000b003e7bf7a1579so6028364edo.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 10:04:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uqHYC6pMdILCZt4L46t3fYUcohv6tOiNRcfAVmZ0lZA=;
        b=O1I8Jr4WODYQ86hAGlv4zEvtaPm/WysGaudIERCWGnLHBpyEvRaLrD0UjaLzASpi8R
         uHXv/5wVTAEHmcS/E2sZhu9Yk95FM6IxF8scolk/pW4P3bl6XvfPFWVwgKDl++XKWDIY
         C+nBRcQc8X16WoBnWFbDt01lMhwKr+1co4QA06ht1N5XvJk1bSB3lcfCaiddwu+tzS9O
         gVgi0gIUI8DxHJVlmH8LnqSxSrKFiMOy4iG7Z/TsXnpy9jEEsVxYvkHdftn6SLG7OopZ
         iBXNux8DTcTus2Cg38mq5QcVcQ4K0WbkKS495dSwqVAawDTbYiJsnIM9A03+4HKS0nvx
         8OnQ==
X-Gm-Message-State: AOAM531xaQevVCbnjxS0rvOs3ynoI7KEayRVSKJcDmqr6LLT3jkyNQl0
        6d8+a9JrcsKuZLXykuJzT/Afke4XTPvFSPP89hpz7fo2S0ecmU4KVjxKRtPshflrMjbt/oxtm06
        16A7b1DINtSS4TniKcie2VqtwJ+k/NqfKJ8kQuOTVytGNxjFsYgf86CH5NRs7bJTcAiW4Kw==
X-Received: by 2002:a17:906:5951:: with SMTP id g17mr34494256ejr.315.1637863454900;
        Thu, 25 Nov 2021 10:04:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUwyeLJh7uyU1G5zbFj303QzV/bRNx8rnoSzog0EBaXN/XxDE9bEwdzbCGmSFxfoUoiZ3rxA==
X-Received: by 2002:a17:906:5951:: with SMTP id g17mr34494215ejr.315.1637863454657;
        Thu, 25 Nov 2021 10:04:14 -0800 (PST)
Received: from redhat.com ([176.12.197.47])
        by smtp.gmail.com with ESMTPSA id h10sm2399113edj.1.2021.11.25.10.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 10:04:14 -0800 (PST)
Date:   Thu, 25 Nov 2021 13:04:11 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Laurent Vivier <lvivier@redhat.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Subject: [PATCH] hwrng: virtio - unregister device before reset
Message-ID: <20211125180343.134505-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unregister after reset is clearly wrong - device
can be used while it's reset. There's an attempt to
protect against that using hwrng_removed but it
seems racy since access can be in progress
when the flag is set.

Just unregister, then reset seems simpler and cleaner.
NB: we might be able to drop hwrng_removed in a follow-up patch.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

NB: lightly tested. Don't know much about rng. Any reviewers?


 drivers/char/hw_random/virtio-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index b2bf78b25630..e856df7e285c 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -179,9 +179,9 @@ static void remove_common(struct virtio_device *vdev)
 	vi->data_avail = 0;
 	vi->data_idx = 0;
 	complete(&vi->have_data);
-	virtio_reset_device(vdev);
 	if (vi->hwrng_register_done)
 		hwrng_unregister(&vi->hwrng);
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 	ida_simple_remove(&rng_index_ida, vi->index);
 	kfree(vi);
-- 
MST

