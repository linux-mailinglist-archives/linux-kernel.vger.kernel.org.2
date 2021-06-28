Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845083B65BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbhF1Pez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236320AbhF1PSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624893378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f3U919sa8lNb7vV6JsVUpYBDy/niNjT2AdvpDrnRy9s=;
        b=FOugfhsiOiR5C8Fgd3V2vWlRTtEgk+DYbRARyvS8SKF/8oSAdAsS4liOpG9dtaErF8fsRi
        cCrdp/4bO9ElSoz8SVvzQy8a31cU2PVuxYpb6MBvrJ41nyKEpav9sVNgnHxh78XhTlA3Kq
        /7qOj6/KVLoIuahds68T2qyGxa45gj8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-xd5mmOHXOxGFkt678KzSLw-1; Mon, 28 Jun 2021 11:16:16 -0400
X-MC-Unique: xd5mmOHXOxGFkt678KzSLw-1
Received: by mail-ed1-f69.google.com with SMTP id h11-20020a50ed8b0000b02903947b9ca1f3so9771374edr.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 08:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3U919sa8lNb7vV6JsVUpYBDy/niNjT2AdvpDrnRy9s=;
        b=s4qbpFBvEVxN15CbE1+hIKgGnoGvX0svOkduKnL883UWZdDq2EKXlIi61ozGWe9Wbl
         5iYGREf+wfdqo8AiXVeF3++d0KjSTJ96ZAu+Of9JnCLu8zJ3z36ec7ZkfynVDvx8E8YM
         z5XdL0aY7ud+WM+2KRqwXfhSFBWwlHIr3NYzoljFTN0nExgzIE/EK8yUITtQjN4prsDc
         e5mROGZHHDBE0iJLjRTEJWmm/m02Wew1/7Y/1JjtrpGYOo870PLM6CXNvhjTGEw6GyRa
         eJrqmP1fd0q9CDzfcfumMhJVk9acTgpz2JRwqNd+TAl9LvykwZKBM3w4rXCKExsZFy4W
         MGNw==
X-Gm-Message-State: AOAM532g02iH/mehKLFz83dwF7yPsCtu2WjhPBGDqtvbolQjT94RYKTm
        iCBk5CcXf9DIP+1j0IVefYbG1MsdmsN87WOa0fRIg2ze1/D5Cq7sv38z3F41Od+E603zoGOc77i
        D9rY0poTC8x3kTXFb8teLMQ+I
X-Received: by 2002:a05:6402:4316:: with SMTP id m22mr33796768edc.316.1624893375315;
        Mon, 28 Jun 2021 08:16:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzp1SSZvTlLkSF9hZBOks1djPGKi5UsUwUmX2C268COINPVulrBnVHYSkRuBwjGh1BeQI+cuQ==
X-Received: by 2002:a05:6402:4316:: with SMTP id m22mr33796741edc.316.1624893375113;
        Mon, 28 Jun 2021 08:16:15 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it. [79.18.148.79])
        by smtp.gmail.com with ESMTPSA id j22sm7354669ejt.11.2021.06.28.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 08:16:14 -0700 (PDT)
Date:   Mon, 28 Jun 2021 17:16:12 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vp_vdpa: correct the return value when fail to map
 notification
Message-ID: <20210628151612.h4il4c4ivljapi6v@steredhat>
References: <20210624035939.26618-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210624035939.26618-1-jasowang@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:59:39AM +0800, Jason Wang wrote:
>We forget to assign a error value when we fail to map the notification
>during prove. This patch fixes it.
>
>Reported-by: kernel test robot <lkp@intel.com>
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Fixes: 11d8ffed00b23 ("vp_vdpa: switch to use vp_modern_map_vq_notify()")
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/vdpa/virtio_pci/vp_vdpa.c | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
>index c76ebb531212..9145e0624565 100644
>--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
>+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
>@@ -442,6 +442,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 			vp_modern_map_vq_notify(mdev, i,
> 						&vp_vdpa->vring[i].notify_pa);
> 		if (!vp_vdpa->vring[i].notify) {
>+			ret = -EINVAL;
> 			dev_warn(&pdev->dev, "Fail to map vq notify %d\n", i);
> 			goto err;
> 		}
>-- 
>2.25.1

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

