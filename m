Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C153FFABD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 08:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347483AbhICG4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 02:56:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347254AbhICG4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630652144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EeO/1ruPx/J3HagGwQQq0jPFzGgymZG7mS2oDGjCub4=;
        b=AEC5tqOyojbpH3X8GZVtqdsU1HIfKgKTL+SdhIdqmKQQpW8bOc/WVsYi5OOVTFmUXQMifq
        L4wAJRULZix6bDKBOuNlyLM9v7/xMf6R6xJ7vM0nfZ7RJrVtw5IXr7MdfRqoQ13vFNcatK
        Rl+W8rixVIZpx6Ve3/WN8PQuCI0o/BA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-mX8xWzP1Nua97E8Oqwflmw-1; Fri, 03 Sep 2021 02:55:43 -0400
X-MC-Unique: mX8xWzP1Nua97E8Oqwflmw-1
Received: by mail-ej1-f70.google.com with SMTP id cf17-20020a170906b2d100b005d42490f86bso2258260ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 23:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EeO/1ruPx/J3HagGwQQq0jPFzGgymZG7mS2oDGjCub4=;
        b=uV8Qvdi78EWsOpmc7Ztxh6zkflcDO/bPsUu8UJqK8imcS65aSMvn4NrLPRuCcTUw8W
         spSVyc0WgTqxJ+cfV3P6kEu5xbCrGoucoHE3J0M0R9nuQqFF2bDdLkFHs65XIEcIE9H6
         85RiCNI5na9LrkqPEjQu7GoPq2A04Dtl0H99UVLc6c0long3pldjlHdLH+skzGDs/NAq
         UmezKnCv+LqIlP47mZwmUdEl+FaG3Efulq+JKRS1YIfZ5IXMf7p4p/bGMo5VvWsnNKxP
         Qo8xyHN1ubQKMpzCs5pO8LBhdcs1L9tMhUiZTG8sKQFxpgTKpNXkLOeRiaaXjzTKRCAu
         7+NQ==
X-Gm-Message-State: AOAM531ey0AdFffAU79bFFIfmBiTYvcKAkyitTirh8bvoTEG/yvqUeeB
        gzQdwM6148Lzw21lWK96TS6NBvuqQiuzBYNrYoTOdbObo6UANOFdrEhMhMA1KM77BpRPlJds0c5
        T0E7OxM62cpoK8FqSINOWGOs8
X-Received: by 2002:a05:6402:2909:: with SMTP id ee9mr2379470edb.377.1630652142358;
        Thu, 02 Sep 2021 23:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqmSk8HBLIJKh7TPV1i1K1+xzAXzo7Ae30A7P6UZPUjSR75Ct+E874fXO8233Bd4c/cP2SjA==
X-Received: by 2002:a05:6402:2909:: with SMTP id ee9mr2379457edb.377.1630652142126;
        Thu, 02 Sep 2021 23:55:42 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it. [79.51.2.59])
        by smtp.gmail.com with ESMTPSA id k12sm2391179edq.59.2021.09.02.23.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 23:55:41 -0700 (PDT)
Date:   Fri, 3 Sep 2021 08:55:39 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v4 3/6] vhost/vsock: support MSG_EOR bit
 processing
Message-ID: <20210903065539.nb2hk4sszdtlqfmb@steredhat>
References: <20210903061353.3187150-1-arseny.krasnov@kaspersky.com>
 <20210903061541.3187840-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210903061541.3187840-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 09:15:38AM +0300, Arseny Krasnov wrote:
>'MSG_EOR' handling has similar logic as 'MSG_EOM' - if bit present
>in packet's header, reset it to 0. Then restore it back if packet
>processing wasn't completed. Instead of bool variable for each
>flag, bit mask variable was added: it has logical OR of 'MSG_EOR'
>and 'MSG_EOM' if needed, to restore flags, this variable is ORed
>with flags field of packet.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c | 22 +++++++++++++---------
> 1 file changed, 13 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index feaf650affbe..93e8d635e18f 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -114,7 +114,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		size_t nbytes;
> 		size_t iov_len, payload_len;
> 		int head;
>-		bool restore_flag = false;
>+		u32 flags_to_restore = 0;
>
> 		spin_lock_bh(&vsock->send_pkt_list_lock);
> 		if (list_empty(&vsock->send_pkt_list)) {
>@@ -179,15 +179,20 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 			 * created dynamically and are initialized with header
> 			 * of current packet(except length). But in case of
> 			 * SOCK_SEQPACKET, we also must clear message delimeter
>-			 * bit(VIRTIO_VSOCK_SEQ_EOM). Otherwise, instead of one
>-			 * packet with delimeter(which marks end of message),
>-			 * there will be sequence of packets with delimeter
>-			 * bit set. After initialized header will be copied to
>-			 * rx buffer, this bit will be restored.
>+			 * bit (VIRTIO_VSOCK_SEQ_EOM) and MSG_EOR bit
>+			 * (VIRTIO_VSOCK_SEQ_EOR) if set. Otherwise,
>+			 * there will be sequence of packets with these
>+			 * bits set. After initialized header will be copied to
>+			 * rx buffer, these required bits will be restored.
> 			 */
> 			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
> 				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>-				restore_flag = true;
>+				flags_to_restore |= VIRTIO_VSOCK_SEQ_EOM;
>+
>+				if (le32_to_cpu(pkt->hdr.flags & VIRTIO_VSOCK_SEQ_EOR)) {
>+					pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
>+					flags_to_restore |= VIRTIO_VSOCK_SEQ_EOR;
>+				}
> 			}
> 		}
>
>@@ -224,8 +229,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
> 		 * to send it with the next available buffer.
> 		 */
> 		if (pkt->off < pkt->len) {
>-			if (restore_flag)
>-				pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
>+			pkt->hdr.flags |= cpu_to_le32(flags_to_restore);
>
> 			/* We are queueing the same virtio_vsock_pkt to handle
> 			 * the remaining bytes, and we want to deliver it
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

