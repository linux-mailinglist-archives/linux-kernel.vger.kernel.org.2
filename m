Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A47400005
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 14:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349389AbhICMwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 08:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58455 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235336AbhICMwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 08:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630673499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DF2I+24AkIxRwqkEhT0lnpePfg+abdYQYWaKlAVyD/A=;
        b=gQO/YjnpOavhjKn+et6awOLXAomVF/O4bjkscPiJtW3quEhEZanj8pg/V47Ab4oAoisf+R
        makDiY6WhZSIZLDCg0UxoP4C4sDe3QDwRBPHvSXd6UQeKGPIngKVrutLzzYnCCy45mgEmn
        97HYrn4Rfx7nFayw4O2ls3d/9aZU+Rw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-lUptgJWNMUmBgZRvmpZaJA-1; Fri, 03 Sep 2021 08:51:36 -0400
X-MC-Unique: lUptgJWNMUmBgZRvmpZaJA-1
Received: by mail-ej1-f71.google.com with SMTP id f23-20020a17090624d700b005d7f8be91eeso2660523ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 05:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DF2I+24AkIxRwqkEhT0lnpePfg+abdYQYWaKlAVyD/A=;
        b=b0RVHU7riW63dHDlDQ0egGnKGDdxZOO4v5z3AxWqOTO/bpGgxChqjGqhrOT+DICPYR
         Qm1XNymcI09BMglTfJA+pLj+J2OJj8gBrKOVIfC5OgCPGkID4/syxmCXcd+7gXqLm5h7
         H7N0wVT2D2CE/5UDeIQSBjrCUH0BVl3PJ7lpY6H9wtuvWiC3tSZbGN6bNldhP7yNtAmF
         pquEPJgfWHeuZiBieBbYET6Hlavz8sOotAiJc46uud7lue5poxPiQqyb2YmW+Uh+t+yu
         ZQJV80Oin44d/olezKWM9pRC9jrsTxpxOMZQJ/rR66zWAjpeMB1nVK79NfX46+WbJKsu
         nK/w==
X-Gm-Message-State: AOAM530RuVyM539iKO3XQG6U7mzrc+tF5qGYTuRoYoWQ3AUdfkXzqJLQ
        hlq8gA3tccnvngCdHSwNe7N+XhIDjRiTZoD1YsjxXPsKeBRhNJ9uo5MUQoNjFVqrjdcloLIyWuL
        ZIKsDfIvPq87MScgJgEdahLRQ
X-Received: by 2002:a05:6402:18ec:: with SMTP id x44mr3799673edy.331.1630673495254;
        Fri, 03 Sep 2021 05:51:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8/zNYsvWxJttqosppBPW56JQy0Hy96063NjGYssxoHP8Kz56/+VNYFokXhgAQGoC1tL6Bkw==
X-Received: by 2002:a05:6402:18ec:: with SMTP id x44mr3799651edy.331.1630673494961;
        Fri, 03 Sep 2021 05:51:34 -0700 (PDT)
Received: from steredhat (host-79-51-2-59.retail.telecomitalia.it. [79.51.2.59])
        by smtp.gmail.com with ESMTPSA id b2sm2876144edt.74.2021.09.03.05.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 05:51:34 -0700 (PDT)
Date:   Fri, 3 Sep 2021 14:51:32 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [PATCH net-next v5 3/6] vhost/vsock: support MSG_EOR bit
 processing
Message-ID: <20210903125132.fpuwfij6ggsg4wuf@steredhat>
References: <20210903123016.3272800-1-arseny.krasnov@kaspersky.com>
 <20210903123238.3273526-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210903123238.3273526-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 03:32:35PM +0300, Arseny Krasnov wrote:
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
>index feaf650affbe..938aefbc75ec 100644
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
>+				if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR) {
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
> 			/* We are queueing the same virtio_vsock_pkt to 
> 			handle
> 			 * the remaining bytes, and we want to deliver it
>-- 
>2.25.1
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

