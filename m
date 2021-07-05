Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C443BC13A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhGEPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231806AbhGEPyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625500299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=26ujWV3iaTeltft8yvSHJqU2fP8edooVCaKqVkKh4l0=;
        b=hy7aWNqJFA7Lao4QOU3a4MAv6CfvSinxkrfJVDsXl2LW9gb8cnuwRFuMEc5h0PKEmIHn05
        6bRT9aTsl1+czMdGrVlJFiXznmpj/FlP+LwvWroWZfGCP8ZHyr/V3Zyz+pcfvZzDBZQgiX
        WK/NBLmNicgcLxJnxqlPv8MNKfJDG/4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-V8bFN2KMP6GptWR468u22w-1; Mon, 05 Jul 2021 11:51:38 -0400
X-MC-Unique: V8bFN2KMP6GptWR468u22w-1
Received: by mail-wr1-f70.google.com with SMTP id p4-20020a5d63840000b0290126f2836a61so6344234wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 08:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=26ujWV3iaTeltft8yvSHJqU2fP8edooVCaKqVkKh4l0=;
        b=Juo79szWTJ8YoLmUVD/G850rv2YepPl77xuZos3laIbK8f+SmEAkQ3kU4NbqWkB8G3
         8YslNGsEt5XijmaWgPDO/YgQ5MOnQlux01oTyGOdx3fDQDd0dhrhK904nAGPsHIV/1rW
         ur30p3kqyYBaGpLBFKeRhpJB8KHhOW2MyC7PDOdjthJJ4pa/Q31qihFuWHr1W/jVsvtl
         GAeBejjRJwVjGqWowpQpfB0u0rjxOXl+5EpR0w7oJUfsx2wEe7MrU5Ow8qbJOorvSFfS
         sG4AUkF+zGxMH+FOjqiqcWhpfhTFKC8OW82Mwrf3/JaP8AmDAb3vUSBoI4ZZ/AVFOa6J
         e46w==
X-Gm-Message-State: AOAM532Sr0rCzeg14hxZnON9NeRbWLjR1rj3osn6xe3dbZn4paH3rjYo
        wnes8Tjqc1wEH4Z40WfamrIO/A0S1/+B+2mcIxxRbKVRD7emoHoRpNZzzdRVP9S/neIJNJhMhRu
        jpJ0zBFCWgBfRIAes8VR9VZMU
X-Received: by 2002:a1c:7915:: with SMTP id l21mr15748819wme.62.1625500296955;
        Mon, 05 Jul 2021 08:51:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA878XcDRnse+gcAZSzI29tEdNmCd/Z3W7NWMOpuhzNnpIHRR5+5VU7DyKelRLKJAKif34Qg==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr15748800wme.62.1625500296747;
        Mon, 05 Jul 2021 08:51:36 -0700 (PDT)
Received: from steredhat (host-87-7-214-34.retail.telecomitalia.it. [87.7.214.34])
        by smtp.gmail.com with ESMTPSA id b9sm16260403wrh.81.2021.07.05.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 08:51:36 -0700 (PDT)
Date:   Mon, 5 Jul 2021 17:51:33 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, kernel@axis.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio_vdpa: reject invalid vq indices
Message-ID: <20210705155133.zas2p4lebsgifz5i@steredhat>
References: <20210701114652.21956-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210701114652.21956-1-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 01:46:52PM +0200, Vincent Whitchurch wrote:
>Do not call vDPA drivers' callbacks with vq indicies larger than what
>the drivers indicate that they support.  vDPA drivers do not bounds
>check the indices.
>
>Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
>---
> drivers/virtio/virtio_vdpa.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>index e28acf482e0c..e9b9dd03f44a 100644
>--- a/drivers/virtio/virtio_vdpa.c
>+++ b/drivers/virtio/virtio_vdpa.c
>@@ -149,6 +149,9 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
> 	if (!name)
> 		return NULL;
>
>+	if (index >= vdpa->nvqs)
>+		return ERR_PTR(-ENOENT);
>+
> 	/* Queue shouldn't already be set up. */
> 	if (ops->get_vq_ready(vdpa, index))
> 		return ERR_PTR(-ENOENT);
>-- 
>2.28.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

