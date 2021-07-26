Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61A63D5679
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhGZIrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232617AbhGZIrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627291700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yqmtXjR23l4x2rUuqXYQINAtvK/goiI836gDq6BQI34=;
        b=asI7Fim5x8GuEO8/P5QADAH+VwWVtuL+NjrrC/8qZKyN//Ah7Ss9YO/NDhkbjjRBY7toH2
        rtfoIwRBPEdUqWhE5vfAuL9mYjzaDwdaciZvhBOTWLmBHTMH20uEbYisrQQhP4cGEI1Wpx
        5KsWp1u0jgxxi2yp7OmW69GdOWBpFgs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-ap-w-n15Nii4I8j64e1s_g-1; Mon, 26 Jul 2021 05:28:19 -0400
X-MC-Unique: ap-w-n15Nii4I8j64e1s_g-1
Received: by mail-ed1-f71.google.com with SMTP id j22-20020a50ed160000b02903ab03a06e86so4378965eds.14
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yqmtXjR23l4x2rUuqXYQINAtvK/goiI836gDq6BQI34=;
        b=s9cx074ScT/zH5gbNnrprZyavWeEKkBtDabECPEZ7eq3p8N6MTsYaExcGLO+4AwHu5
         n1H0hCtf1ogTfKrGk/kpRkLJUX/xi6moJ4NMr7tahuVR+L7aDutmFStSrBG5sxjAtdN6
         Jc1BbGjPsH7QGg3fOD80JgEDAjG2gTbrZf4+zN8rsLT7U+D3bzZjX4YScXXoZZtEBMUW
         CnYp+NZxohPX9ZIE/lVb8GkpWDlFNDxHhVbIurrZGqQ3/nMqU6DXgNbfgqIylmwDHl2i
         Rm+LAYvecBMTEmuRg8CQafspcYdOdk1kP/PFnKHG57O6QfqGhmSAE4NG+BsF3klM86Ew
         QD3g==
X-Gm-Message-State: AOAM530QJKl7BC/oo6aovV57F+7c68NQnGHraJslpKUJNSu2+eP2tLxZ
        eiVX03HPJ/oXg9X7qE9NqhYXsPUCOWiPQkhnNF+A8negJ9EVH0oHoeH/a2obexWLVDZ8sWVvTqE
        kVfKbLdEl5IyIBMSGKkgR9NDl
X-Received: by 2002:a17:906:2547:: with SMTP id j7mr2792655ejb.491.1627291697847;
        Mon, 26 Jul 2021 02:28:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDjPQEOSbUwrd7RuKpfzjmfg9QK7jBxQRsM4T4gkOmvXljzMIWlFzbVuMfo9+mPG8MdZHaOw==
X-Received: by 2002:a17:906:2547:: with SMTP id j7mr2792640ejb.491.1627291697720;
        Mon, 26 Jul 2021 02:28:17 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id bd24sm4357947edb.56.2021.07.26.02.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:28:17 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:28:15 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] vdpa_sim: Fix return value check for
 vdpa_alloc_device()
Message-ID: <20210726092815.hyesvf44lq6jtxuo@steredhat>
References: <20210715080026.242-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210715080026.242-1-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:00:23PM +0800, Xie Yongji wrote:
>The vdpa_alloc_device() returns an error pointer upon
>failure, not NULL. To handle the failure correctly, this
>replaces NULL check with IS_ERR() check and propagate the
>error upwards.
>
>Fixes: 2c53d0f64c06 ("vdpasim: vDPA device simulator")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index 14e024de5cbf..c621cf7feec0 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -251,8 +251,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>
> 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
> 				    dev_attr->name);
>-	if (!vdpasim)
>+	if (IS_ERR(vdpasim)) {
>+		ret = PTR_ERR(vdpasim);
> 		goto err_alloc;
>+	}
>
> 	vdpasim->dev_attr = *dev_attr;
> 	INIT_WORK(&vdpasim->work, dev_attr->work_fn);
>-- 
>2.11.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

