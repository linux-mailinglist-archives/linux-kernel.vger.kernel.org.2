Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788683D567C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhGZIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232617AbhGZIsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627291721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpEimmbDo4aEMkM3vqcFaTpt6N3ZuHHkK6+swTTSQGg=;
        b=dsRTJBZnUm+l6cQiSVEZ0G69hmo//Co1VE1l+BkaLnXSj2wjCFaO+xSiDfzJSd62DrJPPK
        KfCdF4/BNwhxVqCCca63OHWitTcgXOOhhXavC6Dkz6n2l5OrFKp5P6clHKGTc9S3nL80Mn
        h+kU61eCPuLc5WQx4f3+p3C5HHgb/I4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-XS7hToi2Orq1bd6DDnMHHQ-1; Mon, 26 Jul 2021 05:28:40 -0400
X-MC-Unique: XS7hToi2Orq1bd6DDnMHHQ-1
Received: by mail-ed1-f70.google.com with SMTP id l10-20020aa7caca0000b02903b874f26036so4363523edt.20
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpEimmbDo4aEMkM3vqcFaTpt6N3ZuHHkK6+swTTSQGg=;
        b=K4Ic1NuCkkIOOEMa60rwhviDl/FaPeXgTP6MKCKKAYKdhCHmJg1SkJDJ8s/4LZsfIJ
         7npkzfMhcWgVWQYbSnAo/j85gETuItWxCFg/8ehn26IIloTz4o0YLhRyspAxHo4dY8EJ
         Ds3oFjQDD2P54+DqlTRCST8rhJaeTnrHGnkmN7IyuVXVeK3nGVL/2yncf1KYQAESTMmV
         m6iZZcO9/eA4mrm2+xwZYMd9UNDsoKAlnR5pejAUs4qX3x0vmGBEWkIWxMmWZ9fSzDHp
         maa7AQNsR1xvdPKLnLIobYDSe5p3BftJ4UBJRuRL5LJlmROlxEy3TSoV7uwczpkOGMKQ
         RhsA==
X-Gm-Message-State: AOAM530/u1Tyj6LfySQL8j8XnD6+4bUKZiXXhlyU6vXqxI4rtilnTFeG
        PTNscCOcjmPNpW7frIZId9XUSW2MsoDYy/GpDPvtk4icH9QapWcB4Ks+P53iU4H3F8W9nvTKBVR
        OkTeOF5h6XEsCw+eCH6V7GWO3
X-Received: by 2002:a05:6402:b8a:: with SMTP id cf10mr20061219edb.61.1627291718739;
        Mon, 26 Jul 2021 02:28:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlLHEa+X6F8XlAdINKvSd7LbBvwznspuSlArmjdXhgPjvf+vEJs5F8ESJ/Jy+za1FvvHAEyw==
X-Received: by 2002:a05:6402:b8a:: with SMTP id cf10mr20061212edb.61.1627291718632;
        Mon, 26 Jul 2021 02:28:38 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id i14sm14026380eja.91.2021.07.26.02.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 02:28:38 -0700 (PDT)
Date:   Mon, 26 Jul 2021 11:28:36 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, dan.carpenter@oracle.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] vp_vdpa: Fix return value check for
 vdpa_alloc_device()
Message-ID: <20210726092836.3iokq436ffwpwt3q@steredhat>
References: <20210715080026.242-1-xieyongji@bytedance.com>
 <20210715080026.242-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210715080026.242-2-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:00:24PM +0800, Xie Yongji wrote:
>The vdpa_alloc_device() returns an error pointer upon
>failure, not NULL. To handle the failure correctly, this
>replaces NULL check with IS_ERR() check and propagate the
>error upwards.
>
>Fixes: 64b9f64f80a6 ("vdpa: introduce virtio pci driver")
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index 7b4a6396c553..fe0527329857 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -436,9 +436,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
> 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> 				    dev, &vp_vdpa_ops, NULL);
>-	if (vp_vdpa == NULL) {
>+	if (IS_ERR(vp_vdpa)) {
> 		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
>-		return -ENOMEM;
>+		return PTR_ERR(vp_vdpa);
> 	}
>
> 	mdev = &vp_vdpa->mdev;
>-- 
>2.11.0
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

