Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC13458B98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 10:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbhKVJfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 04:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29058 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238918AbhKVJfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 04:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637573527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=belxqpIEPM8b5ddVw8XKTj7NYwBuhVnMMeNM/xGD1js=;
        b=e9KycYzwqc/zDGu+ifks2yqEGqKI/fLCZRPm2vclsBSqiKT1U+rnLRXw18yJSPdqMb7YWn
        DNmBlm2xFvmmnKA1tHZKsuUcixpIQ7NjFj7Zo0K7UkXM6hkWGEXot1sMvZeWN1l51tPfB+
        b3LDTCPZydhhpfsuTm0MIpNLnvmlsPM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-Ac8Gn3ZHO0CmBGAI6GG4qQ-1; Mon, 22 Nov 2021 04:32:06 -0500
X-MC-Unique: Ac8Gn3ZHO0CmBGAI6GG4qQ-1
Received: by mail-ed1-f72.google.com with SMTP id q17-20020aa7da91000000b003e7c0641b9cso14264384eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 01:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=belxqpIEPM8b5ddVw8XKTj7NYwBuhVnMMeNM/xGD1js=;
        b=eTKpHbonmawanuQlQ8s/lmCMdG3ChW4OPb6CsBjP77D9jFC6p56anIRem24M/denQ2
         8tcZajmsIok7JhGe8eCTUW8i7GV7f29HQTrMzOrWg6zH9rbfMJe0qvUkqABLKmfL7oYr
         e5/AwY7Ty4pcaCBiVNX/wOY5v6l/+c0lQBSRSnbBVFx85ji1dJzOjd4ZgULjbhDhb0HF
         hM3UBUnPr1ZvIxYDadakB0J2UFz5+hwsVZCx8h9jN862Tn+f7lnGc5pHyFtEhfIW+MYI
         vYO3VloapKOF3MVQhfZzfjeWDV1NwHYwOcjwVVk9FctG5S8jxAIx/uujX8b0x6VsXr0R
         F5ig==
X-Gm-Message-State: AOAM530brTZDIjB4ptcspDzSQbuA/r5vlsF2HkU4dW74DaIiHyWe0meb
        diGvetps3NzxGaWBbO2gesGehWuSia1e420DInDqWJDjTG68L/GSxKZOWOFJ65peY7wvwDIGmZO
        qk+TYKHBN2lcSOCGtm7L5VzMYVNCLa/403T7oo8Wv7QEPe0v7RkmItXwPzskc/5QPj/hkRA==
X-Received: by 2002:a17:906:b2d0:: with SMTP id cf16mr38631574ejb.52.1637573525322;
        Mon, 22 Nov 2021 01:32:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaDt8hngfWzHfFUTs49+2toJfr7BA5IoCX89wF8FGrB5kAMe2yz7xlpf9wWvnAeYerGQlgwg==
X-Received: by 2002:a17:906:b2d0:: with SMTP id cf16mr38631543ejb.52.1637573525115;
        Mon, 22 Nov 2021 01:32:05 -0800 (PST)
Received: from redhat.com ([2.55.128.84])
        by smtp.gmail.com with ESMTPSA id jg32sm3539120ejc.43.2021.11.22.01.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 01:32:04 -0800 (PST)
Date:   Mon, 22 Nov 2021 04:32:01 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        f.hetzelt@tu-berlin.de, david.kaplan@amd.com,
        konrad.wilk@oracle.com
Subject: [PATCH] vsock/virtio: suppress used length validation
Message-ID: <20211122093036.285952-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that vhost vsock violates the virtio spec
by supplying the out buffer length in the used length
(should just be the in length).
As a result, attempts to validate the used length fail with:
vmw_vsock_virtio_transport virtio1: tx: used len 44 is larger than in buflen 0

Since vsock driver does not use the length fox tx and
validates the length before use for rx, it is safe to
suppress the validation in virtio core for this driver.

Reported-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 939779f5152d ("virtio_ring: validate used buffer length")
Cc: "Jason Wang" <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f7c99dfd16c..3f82b2f1e6dd 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -731,6 +731,7 @@ static unsigned int features[] = {
 static struct virtio_driver virtio_vsock_driver = {
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
+	.suppress_used_validation = true,
 	.driver.name = KBUILD_MODNAME,
 	.driver.owner = THIS_MODULE,
 	.id_table = id_table,
-- 
MST

