Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA19B318D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 15:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhBKOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 09:35:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232128AbhBKOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613053901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qx1vF4VDTg9ZiVHP56/p9LQUivZBdKHBXUEg2h4ECWE=;
        b=WskLWRG7/P4GFAYlV6HEtjB0VkJPtIIj0q7fRjmSSlF9uWcQniLblflAFqH/i+N8LU1sEf
        ZaER0cJBJiyhlHwnGT0OZYmhc+oTFz5YHJYYzkRI5mmJPjWBU7w6/psaHcmSPrv0VZdR40
        lfqDw5hPk8biWwsYoJzhrpk4PP6D6O8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-0aqQYH9hMzKf57KU6BVQ9Q-1; Thu, 11 Feb 2021 09:31:39 -0500
X-MC-Unique: 0aqQYH9hMzKf57KU6BVQ9Q-1
Received: by mail-ed1-f70.google.com with SMTP id l23so4635402edt.23
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 06:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qx1vF4VDTg9ZiVHP56/p9LQUivZBdKHBXUEg2h4ECWE=;
        b=PAYhOgg6JfBhv/eXNgRMvZyf+dD4JbM0BRQp4t7tN+T/NO4BVxeS4i5BzbaRkioUYN
         dbay8XJi7QiDxLQgU3prmYhRS+mtZVIGUiWi5u9AT5WoWDLuwLAViNBsn3NTSbRFJheQ
         na9EBQPlq31YFs+XLlR4NMcfkk15oaPX6cnnxxBsjWwRv+CKFoRfASHNgyVJgpabzmUt
         TdluDJY4+2kQAhsMOhsqo51/ejvlgkxruuWOWalJcgMPkf2jHwJsZEWLpAT+IbSPWfUg
         /NRqftjgQckrHVXuBI9Hn5Feuv+NrS+OaTtDdhjV6oBX4HUnmu/CGEseyZmKhI+PTe+Q
         eLPg==
X-Gm-Message-State: AOAM530UelBhXZaOWBuBKDCFQmPYlcbD1euyhBBTTWu2JHIFq6HYZRjo
        JCMOOmEXi7aZKCGNn9GeEr8XIp0I5hKxMOfcnahsfruZa++FLOu/hoet6TDOhiZBrAj5utHr5uV
        3ycJsSh/v4balv88J/AjZF68q
X-Received: by 2002:a05:6402:2690:: with SMTP id w16mr8674189edd.304.1613053898761;
        Thu, 11 Feb 2021 06:31:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsl6V5GNKxpKd/ex6D4v2PjeuJ2YZDy6YsN4AWMb++9K3iYM1L51RtUTNQ9HDhfu68aafpbg==
X-Received: by 2002:a05:6402:2690:: with SMTP id w16mr8674161edd.304.1613053898597;
        Thu, 11 Feb 2021 06:31:38 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id u2sm4173850edo.38.2021.02.11.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 06:31:37 -0800 (PST)
Date:   Thu, 11 Feb 2021 15:31:35 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Colin Ian King <colin.king@canonical.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Jeff Vander Stoep <jeffv@google.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v4 16/17] loopback/vsock: setup SEQPACKET ops for
 transport
Message-ID: <20210211143135.jbrfb5izewuiiaka@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151851.806233-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210207151851.806233-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please move this patch before the test and I'd change the prefix in 
"vsock_loopback" or "vsock/loopback".

Thanks,
Stefano

On Sun, Feb 07, 2021 at 06:18:48PM +0300, Arseny Krasnov wrote:
>This adds SEQPACKET ops for loopback transport
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/vsock_loopback.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index a45f7ffca8c5..c0da94119f74 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -89,6 +89,11 @@ static struct virtio_transport loopback_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_seq_send_len	  = virtio_transport_seqpacket_seq_send_len,
>+		.seqpacket_seq_send_eor	  = virtio_transport_seqpacket_seq_send_eor,
>+		.seqpacket_seq_get_len	  = virtio_transport_seqpacket_seq_get_len,
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>-- 
>2.25.1
>

