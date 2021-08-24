Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB773F5CE6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhHXLKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:10:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236531AbhHXLKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629803403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6MzIVYD6Rkcf1avefY9xlULEY3kI1KocMJ7+mbhVSUk=;
        b=J9zoicPacGc8JCVXDTJ1GPTrxpOvQpo1Q/257vWmOFjmtp5Agg0IF8Dg9Q/xwcx1Ik7eRK
        BWYjpB6K7Aqy5VmftBmDWsYkhPbASYgWnqYorRktJDMywF5vTY/k8HvGljgnemD44ew/Nv
        OpbAykFaiQPxE3CZdd2bEWOOJrxEAyM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-VWlYptDnNvS2AGmK7jZFUw-1; Tue, 24 Aug 2021 07:10:02 -0400
X-MC-Unique: VWlYptDnNvS2AGmK7jZFUw-1
Received: by mail-ed1-f69.google.com with SMTP id x4-20020a50d9c4000000b003bed5199871so10330122edj.14
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 04:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6MzIVYD6Rkcf1avefY9xlULEY3kI1KocMJ7+mbhVSUk=;
        b=s196ylXTNgP3mNhHWofKhGN73zCmh+iwYOVUYt068BffFpi8eQTKKi7y7uNG3L14dP
         f3pYzYQBrVQQnyJXOvkveEgvgcHjig0ozKvvq3/LBOWHBYfKiGDMvs3dQREdV8+s6xNB
         9f3108OKDe3xALQ+z5oHXFBn3trrEQLgyL2EplCNxeNO8vFRjmQkExScb3PLF1AkCKWW
         4lTEYt/QDfg/fGeaubV3SXkQrqeSjCX+4TR2p04r/fvwbgX89gOL+kQYVmGyMUypjWex
         HLZ+0XYQA3cijtJ2C90iJTQ0+OVQHKXBf44v/NQO1Ogd9ucyj/cwEY2h07usdo0/BkXC
         ZReA==
X-Gm-Message-State: AOAM532ToJ+KbVGsthV27tFzvAQ1vDet5WukWg98pE3uOVNausBD4lBC
        n4frhFFEzjXm51ucr/1eZCse0NpS/HAbpX9w2X8lVbVtMwW2XRieTtfId0NIhOrpLaTFXq4z7PL
        B7so5hdG2tLClOaZMwqlqSST3
X-Received: by 2002:a17:906:9bdc:: with SMTP id de28mr40030309ejc.154.1629803401151;
        Tue, 24 Aug 2021 04:10:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJym2zZCfOfkB6aYg6hvpM9EYCUNutnmi5ZkMGiE/H3YmE4qf/VSJ5+nHLjDGlfYfIZpl2VYMg==
X-Received: by 2002:a17:906:9bdc:: with SMTP id de28mr40030281ejc.154.1629803400969;
        Tue, 24 Aug 2021 04:10:00 -0700 (PDT)
Received: from steredhat (host-79-45-8-152.retail.telecomitalia.it. [79.45.8.152])
        by smtp.gmail.com with ESMTPSA id u2sm9003772ejc.61.2021.08.24.04.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 04:10:00 -0700 (PDT)
Date:   Tue, 24 Aug 2021 13:09:56 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com, robin.murphy@arm.com,
        songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 03/12] vdpa: Fix some coding style issues
Message-ID: <20210824110956.gtajf34s2xpm66gx@steredhat>
References: <20210818120642.165-1-xieyongji@bytedance.com>
 <20210818120642.165-4-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210818120642.165-4-xieyongji@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 08:06:33PM +0800, Xie Yongji wrote:
>Fix some code indent issues and following checkpatch warning:
>
>WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>371: FILE: include/linux/vdpa.h:371:
>+static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
>
>Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>---
> include/linux/vdpa.h | 34 +++++++++++++++++-----------------
> 1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>index 954b340f6c2f..8a645f8f4476 100644
>--- a/include/linux/vdpa.h
>+++ b/include/linux/vdpa.h
>@@ -43,17 +43,17 @@ struct vdpa_vq_state_split {
>  * @last_used_idx: used index
>  */
> struct vdpa_vq_state_packed {
>-        u16	last_avail_counter:1;
>-        u16	last_avail_idx:15;
>-        u16	last_used_counter:1;
>-        u16	last_used_idx:15;
>+	u16	last_avail_counter:1;
>+	u16	last_avail_idx:15;
>+	u16	last_used_counter:1;
>+	u16	last_used_idx:15;
> };
>
> struct vdpa_vq_state {
>-     union {
>-          struct vdpa_vq_state_split split;
>-          struct vdpa_vq_state_packed packed;
>-     };
>+	union {
>+		struct vdpa_vq_state_split split;
>+		struct vdpa_vq_state_packed packed;
>+	};
> };
>
> struct vdpa_mgmt_dev;
>@@ -131,7 +131,7 @@ struct vdpa_iova_range {
>  *				@vdev: vdpa device
>  *				@idx: virtqueue index
>  *				@state: pointer to returned state (last_avail_idx)
>- * @get_vq_notification: 	Get the notification area for a virtqueue
>+ * @get_vq_notification:	Get the notification area for a virtqueue
>  *				@vdev: vdpa device
>  *				@idx: virtqueue index
>  *				Returns the notifcation area
>@@ -353,25 +353,25 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>
> static inline void vdpa_reset(struct vdpa_device *vdev)
> {
>-        const struct vdpa_config_ops *ops = vdev->config;
>+	const struct vdpa_config_ops *ops = vdev->config;
>
> 	vdev->features_valid = false;
>-        ops->set_status(vdev, 0);
>+	ops->set_status(vdev, 0);
> }
>
> static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
> {
>-        const struct vdpa_config_ops *ops = vdev->config;
>+	const struct vdpa_config_ops *ops = vdev->config;
>
> 	vdev->features_valid = true;
>-        return ops->set_features(vdev, features);
>+	return ops->set_features(vdev, features);
> }
>
>-
>-static inline void vdpa_get_config(struct vdpa_device *vdev, unsigned offset,
>-				   void *buf, unsigned int len)
>+static inline void vdpa_get_config(struct vdpa_device *vdev,
>+				   unsigned int offset, void *buf,
>+				   unsigned int len)
> {
>-        const struct vdpa_config_ops *ops = vdev->config;
>+	const struct vdpa_config_ops *ops = vdev->config;
>
> 	/*
> 	 * Config accesses aren't supposed to trigger before features are set.
>-- 
>2.11.0
>

