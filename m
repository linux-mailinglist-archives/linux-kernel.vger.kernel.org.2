Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE621339150
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 16:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhCLPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 10:31:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232244AbhCLPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 10:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615563082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dqP8/iSv8z7OYLNatC6uWrHlEt8bV6+WSEJM+AzQzGQ=;
        b=eERN+skkLWgnwLPVjVkNLWf9mw4dKVI1OR+PjwxzUXGg5A45NaOAs587sZfNldIbP3mV96
        US9wn0FTzV6FixY8HXXJaNR/sjdI1YWqf6DX3d9EqHx77OZR8FQGKTXoH0cJmXk8kGApmu
        4c7zpZJAgGSMK4R8Q86h9CbB0D1FHCw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-nupbEAzWOSWW8nADHrpQDg-1; Fri, 12 Mar 2021 10:31:20 -0500
X-MC-Unique: nupbEAzWOSWW8nADHrpQDg-1
Received: by mail-wm1-f71.google.com with SMTP id z26so5497280wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 07:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dqP8/iSv8z7OYLNatC6uWrHlEt8bV6+WSEJM+AzQzGQ=;
        b=NTx+lKkMQYpNhBQxbei27JX8hssiZLULCaLB7LtF5IJRVTywPyEzbNIhgvjfSG2Ip7
         SgpV4+CTYko1DlpAU5eJFwYq/HJKjFDY5nn/eCdimfpORPBpcN8eC5j+ZsaxyORRyLjr
         JP2JLdWchEKAKQycayIBcbI5U7p7NQUTUIJYJfcp7SGjKadHcSTSjBGzEfOHM1Y1qRKl
         QHCDLYJIR8QK2TnbHIueqWr0dEZ9IiEp6CKpDRvBaX7YWaeryclMQh+FTuBYDZ9vwPfg
         t7rStsXB/JiuNZDedznuKMefFuvPtizIV9bf0p66Hw7nli23t2Ga57fAdrPKZ4y5TUJk
         9BuQ==
X-Gm-Message-State: AOAM5339aO0mmv5ZQR+IFuSf/P6mETH6wqcf4aIEmV8J+DoV61hnfm/S
        roOIaIukQIj3nITfrlP5lrk12rU7tZn2UPrLoia+F0lxHr6UEoq9a2HUsR5N3Amtpj/yTBssYxa
        KFNTR0004PJmzaDd77S2E0CRQ
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr13968832wmq.73.1615563079597;
        Fri, 12 Mar 2021 07:31:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsigtJAKBTjGiEoVSbW5etqcx7WQtQts6oCyXsi10ljlCxqfwYO6rEoSzUUEkOfAk+AuCklA==
X-Received: by 2002:a05:600c:198d:: with SMTP id t13mr13968802wmq.73.1615563079413;
        Fri, 12 Mar 2021 07:31:19 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id p6sm8096595wru.2.2021.03.12.07.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 07:31:19 -0800 (PST)
Date:   Fri, 12 Mar 2021 16:31:16 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jorgen Hansen <jhansen@vmware.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Andra Paraschiv <andraprs@amazon.com>,
        Colin Ian King <colin.king@canonical.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stsp2@yandex.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v6 09/22] virtio/vsock: set packet's type in
 virtio_transport_send_pkt_info()
Message-ID: <20210312153116.ot7g4dcb2aidwne4@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180125.3465547-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210307180125.3465547-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 09:01:22PM +0300, Arseny Krasnov wrote:
>This moves passing type of packet from 'info' structure to  'virtio_
>transport_send_pkt_info()' function. There is no need to set type of
>packet which differs from type of socket. Since at current time only
>stream type is supported, set it directly in 'virtio_transport_send_
>pkt_info()', so callers don't need to set it.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 19 +++++--------------
> 1 file changed, 5 insertions(+), 14 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

