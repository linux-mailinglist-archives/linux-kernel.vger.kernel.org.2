Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1879D3827E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbhEQJNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhEQJKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:10:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35909C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso5196702pjp.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XrBPmpD/KttIoIpn+brqDAzEl6q2KovLaOihZzxdv4Q=;
        b=WsW48V+UUyGmG31CCkz5gShSDgKnqaVC9SmjMG4nbfmAU70syWfms1/w0ha+IvSbqB
         S2rkRCfec/Kr+hvnxS+dqEiPZ3zIboRmT55TfZsUcRexRca8MDbZ9FyT4OlOlsBBYToo
         M6rYqFspP9mLGP1bdyUBoQJtEwluH+aeF346phtO5+7gDhxQJtBivuuSBSqEI396DeBs
         G3RkzjBpybkDnAWSwTJTwapny+EhfErE0QB45trOZEhK7NVm/67bmiqRg8rktd4N+Wwn
         k7Eg/IE/rNREzjIQA69KRtZ8bj1ryXxAvduMACwt96eIp8Ne6NeOgPZwrtiZKJs4QtAG
         5y+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XrBPmpD/KttIoIpn+brqDAzEl6q2KovLaOihZzxdv4Q=;
        b=F9PAqZe69zNkZQOAkbaUM+EUydKQrf6Kgw98vcCiXpMt1NV+D9rbkVUzWgbRa47tHF
         b9eeijBhmZ6iO17WC68mAR17PtstoV8zq8LnjHrKU+pVZ2zX9maeKrwOv2aTHQ/WvecH
         K4NsK+V54d9SrOOX8feN0BS72POt0IQaeIrXvGAG1HGd3hMoHpeF204XeV/aQ9wZh1Nt
         B8LhSLzsFvPHBO2vCREZ2vQRDzWQBPbwmSG2ut79vCUSRGwU1Gmhl4k2+HVL+2B2r5Tv
         Fq/QzhV/n7neTKZy85XwExkVEoEqtGrK8Q/ROT+pCtdTRa2JApthU0Lcfm5I7yE2vpBK
         1zGQ==
X-Gm-Message-State: AOAM531vkrSXLouSxLoUo2E+KfMjUzSLgvXZaP14w2OQZjTq72OngOmD
        O6sEbwiELb+6YZvtYvib1QDs
X-Google-Smtp-Source: ABdhPJxRokLm5e0w8QWa/AVyYwcf724Wgt8QlLrlr0skyk6D3vvhuA6MYYHauEUBVH39yzO0jqG89A==
X-Received: by 2002:a17:90a:d909:: with SMTP id c9mr17150106pjv.190.1621242577868;
        Mon, 17 May 2021 02:09:37 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id o3sm10017695pgh.22.2021.05.17.02.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:37 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/17] rpmsg: virtio: Remove unused used length
Date:   Mon, 17 May 2021 17:08:29 +0800
Message-Id: <20210517090836.533-11-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517090836.533-1-xieyongji@bytedance.com>
References: <20210517090836.533-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The used length is not used in some cases. Let's drop it
and pass NULL to virtqueue_get_buf() instead.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index e87d4cf926eb..10df8bc0c3e1 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -437,7 +437,6 @@ static struct rpmsg_device *__rpmsg_create_channel(struct virtproc_info *vrp,
 /* super simple buffer "allocator" that is just enough for now */
 static void *get_a_tx_buf(struct virtproc_info *vrp)
 {
-	unsigned int len;
 	void *ret;
 
 	/* support multiple concurrent senders */
@@ -451,7 +450,7 @@ static void *get_a_tx_buf(struct virtproc_info *vrp)
 		ret = vrp->sbufs + vrp->buf_size * vrp->last_sbuf++;
 	/* or recycle a used one */
 	else
-		ret = virtqueue_get_buf(vrp->svq, &len);
+		ret = virtqueue_get_buf(vrp->svq, NULL);
 
 	mutex_unlock(&vrp->tx_lock);
 
-- 
2.11.0

