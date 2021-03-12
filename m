Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B7533915F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhCLPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60778 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231861AbhCLPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615563197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EGb6AXgwl1nr5zRdbpARNJm/jkKcLJumJXwWNk6t/ZM=;
        b=WD5Yyby3iB+3ldmbJyAiniGsu3Is0/O0a8kkfQYpb2GQ2WmbSo1wYrODQb4MILWnB2dP/A
        793OSQDQB0oSR1gOWUr8CIsnnyeOWs4hIUT3z3hF4NtPgVIpijVsKWdOnUBjMOgeyp7Tdx
        DJLVr/uxqYSO/yHpmvRquVU/7Uy/j30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-jrubmWErPxmNcu5-ueCdLA-1; Fri, 12 Mar 2021 10:33:15 -0500
X-MC-Unique: jrubmWErPxmNcu5-ueCdLA-1
Received: by mail-wm1-f71.google.com with SMTP id m17so2173484wml.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EGb6AXgwl1nr5zRdbpARNJm/jkKcLJumJXwWNk6t/ZM=;
        b=EpYul73+KucI1/p9rn8XlGFxVUxplBRzGvJ+y/ZQOd1FWXofO1uf+hY4laZN1yWF6V
         O9FY5yHMA1Dz1puys8u/zO+5MNyGSYpXSnml0CZ3fIkt8YM38FYcBAQ8icjXVhpJmzWM
         u9fNftbsIQJ7iE5k1Hy6vYxyO4FQ+cKsduMTltMqhbJxzq+tPChuilKRj6vZhjycqzqE
         aQ3UCgqIi0K8IK0ZGIq3R78kAbfsyBhp9zZLvbR90XM5mKw0Pa19NhDhQn8xdYZ57Vus
         HQwdUvy7qBc1ZiKzmx2t6N7HiWeNyHvVCZ+MATY8590VHgHY+jU3TOaTkrXbsWo5GJdq
         YaXg==
X-Gm-Message-State: AOAM530DI+jnz95sG8vc0ekcukAZkzBqn0v2E/6sliXgYK/6/CpEfqWl
        4QjjJzLAAJIVmhzwj0AT0EzTHIUODzI5bPPsjxtJm3wT23OnTKZAWR/p5jzzEuovDnON4ZePlB5
        PSKnDQLjK0dWlirGnDfBm3Zlh
X-Received: by 2002:a5d:6602:: with SMTP id n2mr14787230wru.262.1615563194405;
        Fri, 12 Mar 2021 07:33:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1RDUTjqMib142hX4+22hYQB63u70C7eZFaAyLkKWSCQkvVf0EtQUYs3f0XWrxZzKygWvWQQ==
X-Received: by 2002:a5d:6602:: with SMTP id n2mr14787212wru.262.1615563194209;
        Fri, 12 Mar 2021 07:33:14 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id e8sm2440515wme.14.2021.03.12.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:33:13 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:33:11 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        Norbert Slusarek <nslusarek@gmx.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v6 10/22] virtio/vsock: simplify credit update
 function API
Message-ID: <20210312153311.4vfhrb7aqhfqmokc@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180147.3465680-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210307180147.3465680-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 09:01:44PM +0300, Arseny Krasnov wrote:
>This function is static and 'hdr' arg was always NULL.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 7 +++----
> 1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

