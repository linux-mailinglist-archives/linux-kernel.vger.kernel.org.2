Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2E53F5B66
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbhHXJxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:53:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235859AbhHXJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629798738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kg6z7dt36I6LiVKwFciZ2psrGVbf2/o69+fbyjnvf4U=;
        b=K+ZSkxXeABECk6jRYbwZD3AZ4j9Ov1+qEQrllGV81DaGd7feB0ZAgvWjhuusEDvkxKUcX0
        eXZw4Spcmdi6iPf1CUOykhp1L24P2OnR9VxeKH2wdl2HE1wPgjg2C+QqGtMsSaLt2l0zc/
        z05mKazh8sJwf8WT+O8Tar2wvz2ZMYs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-hSiHupqTOrytU4qLaG7yTQ-1; Tue, 24 Aug 2021 05:52:14 -0400
X-MC-Unique: hSiHupqTOrytU4qLaG7yTQ-1
Received: by mail-ed1-f70.google.com with SMTP id bx23-20020a0564020b5700b003bf2eb11718so10228222edb.20
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kg6z7dt36I6LiVKwFciZ2psrGVbf2/o69+fbyjnvf4U=;
        b=AlbBEWDwvbgsuR3dVdZ0tzkhjfpB79u26RJIqsr8wkftUTYtjgO/t2qCfwDGAKM0PW
         qnHIalq5mF2qf2vYtNh0WXOfYwFRlLf/KalRDs49r/FT9c+SxqenpzuYwmIUFgePSMt/
         K0f6wzVI/NZEdEHNWlDo27p5g9WSjnA/D/SS/ZRCkhyWmDAsYs1POP3yG26WPurKE4bF
         tVO+aVFKdBkgU072x5DIKAKsH7fWOLkeMlDg59GD8uurfLDTHzHnW3ZkZVM7bqvG/ULd
         cDipVs1LGaUJTCGhstj2fJC4A1SOPtrcciN8BUD6YcDnqS1a7dlqsMZ8sklxTPdpkIo5
         elhw==
X-Gm-Message-State: AOAM531uqdXKL1y7C4kzgpnbO7iAQsboal6MOG56IadE1Pi/MHtpYb0N
        xhTUVGdwIakjsah/DpAOLm3e/RsrAtp8t/KjI8bJhVz42u7YNkzaqY+TnpqUtuDANLFyT3IJJOC
        nMwFiGQvSlKIdC3DG+gqoB5eN
X-Received: by 2002:a05:6402:358d:: with SMTP id y13mr42408322edc.300.1629798733738;
        Tue, 24 Aug 2021 02:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4YQVPnF4P439rZmYEXIkrS86lreoMk06pzGCFXpJnDrLV059NdnDnDKyu+XUq3zGXCMLhIw==
X-Received: by 2002:a05:6402:358d:: with SMTP id y13mr42408309edc.300.1629798733637;
        Tue, 24 Aug 2021 02:52:13 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it. [79.45.8.152])
        by smtp.gmail.com with ESMTPSA id h8sm9152292ejj.22.2021.08.24.02.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:52:13 -0700 (PDT)
Date:   Tue, 24 Aug 2021 11:52:10 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseny Krasnov <arseny.krasnov@kaspersky.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Norbert Slusarek <nslusarek@gmx.net>,
        Colin Ian King <colin.king@canonical.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stsp2@yandex.ru, oxffffaa@gmail.co
Subject: Re: [RFC PATCH v3 1/6] virtio/vsock: rename 'EOR' to 'EOM' bit.
Message-ID: <20210824095210.z3iwnjmyztys3yja@steredhat>
References: <20210816085036.4173627-1-arseny.krasnov@kaspersky.com>
 <20210816085112.4173869-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210816085112.4173869-1-arseny.krasnov@kaspersky.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 11:51:09AM +0300, Arseny Krasnov wrote:
>This current implemented bit is used to mark end of messages
>('EOM' - end of message), not records('EOR' - end of record).
>Also rename 'record' to 'message' in implementation as it is
>different things.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> drivers/vhost/vsock.c                   | 12 ++++++------
> include/uapi/linux/virtio_vsock.h       |  2 +-
> net/vmw_vsock/virtio_transport_common.c | 14 +++++++-------
> 3 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

