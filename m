Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3572C3D567E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhGZIsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232762AbhGZIsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627291740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5MLQvS6lxg2D9sP+beeEnZvsI6R8MfRGKcYDHuWf39g=;
        b=iuiGyoZP4uWk7JiMFqeFxiseczJ+tw6QNcPOkcQIOXCfYuMsJKM0wdovUnTqYTb4vtKNqU
        iP6stIaZ3a5OL5SOTxH3+iRR9MdfmMLo5vXgH2/Y1bK8gS6dPwulf2g8hVCHDkUIYdTsGi
        KJqevCNfrI6LCR4vUEjp4My069ZONuw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254--H1UCBVxPwuVRoyE1PTJTw-1; Mon, 26 Jul 2021 05:28:59 -0400
X-MC-Unique: -H1UCBVxPwuVRoyE1PTJTw-1
Received: by mail-ed1-f69.google.com with SMTP id dn8-20020a05640222e8b029039ef9536577so4414285edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MLQvS6lxg2D9sP+beeEnZvsI6R8MfRGKcYDHuWf39g=;
        b=PBdTEe1HE8jAo29IfvuSnd7lgzcmXTNgjAgoG3fqJJUrg9LiviUwDrW7JipcMJHZIq
         NAW3zCJTtVpNJPzwda+UGKo7p9wr5+/K5w/dbyOLlvfNmdTYGI/5oQQPuNWDThm3QC4L
         g+gtZ0u4xrc5ofkmdBMSNg3FRXBIVUT7DwSonJWTjFcCck1bLlOlE8l6kWXt1OhBjyHq
         tkbX+lBctXUcryTilWCDgkG0NsTPB3WlBb3576nxqJ/uTKGhXaw2h+6CO/T7ZJI+Yo1f
         JO5aNBqfGek9Be196CfxwjFssZJVy8vev7FkJzR2SL5FtRF1Q/FUjU5xK53nk1gtahIu
         Yt6A==
X-Gm-Message-State: AOAM533RutnNsATDFqAoCvapytbKWSBM7HzE1fFrSisctqsbIwpxCeZn
        TjLbASKO2UDjROsW59dVZPepMSlnymNGR4lvd+L50MvT0zgdTzd42Z6poaXmfX6mFPEqhsAkOUU
        6jdVQUbkQ1GMgET+kMS8eKYwZ
X-Received: by 2002:a17:906:7190:: with SMTP id h16mr16332003ejk.251.1627291738147;
        Mon, 26 Jul 2021 02:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcwwxWV6IkV0YjMM6Irhh1zwz2Ur7YaVcKLlvQvdAoHQkOw7sodWQFSqQU5yBbZPHw0ts31A==
X-Received: by 2002:a17:906:7190:: with SMTP id h16mr16331991ejk.251.1627291738014;
        Mon, 26 Jul 2021 02:28:58 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id em9sm14094434ejc.88.2021.07.26.02.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:28:57 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:28:55 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] vDPA/ifcvf: Fix return value check for
 vdpa_alloc_device()
Message-ID: <20210726092855.xg3yicwltfwozz6y@steredhat>
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-3-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210715080026.242-3-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:00:25PM +0800, Xie Yongji wrote:
>The vdpa_alloc_device() returns an error pointer upon
>failure, not NULL. To handle the failure correctly, this
>replaces NULL check with IS_ERR() check and propagate the
>error upwards.
>
>Fixes: 5a2414bc454e ("virtio: Intel IFC VF driver for VDPA")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vdpa/ifcvf/ifcvf_main.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>index 21b78f1cd521..351c6cfb24c3 100644
>--- a/drivers/vdpa/ifcvf/ifcvf_main.c
>+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>@@ -493,9 +493,9 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
> 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
> 				    dev, &ifc_vdpa_ops, NULL);
>-	if (adapter == NULL) {
>+	if (IS_ERR(adapter)) {
> 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
>-		return -ENOMEM;
>+		return PTR_ERR(adapter);
> 	}
>
> 	pci_set_master(pdev);
>-- 
>2.11.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

