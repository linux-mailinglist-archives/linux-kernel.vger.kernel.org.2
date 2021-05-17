Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7E3827F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236073AbhEQJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbhEQJLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:11:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E908DC06138C
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cu11-20020a17090afa8bb029015d5d5d2175so2495180pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cjsl8oNu3abooxKjC39QauJ1tWnfY0vCJ3akhqpZuKQ=;
        b=Kje+9xk6VuHV0uv4t6r/lx2SiSA0pPUS2HxXcvqlWtfsKen/Fbc/RZK4Nb/GPo676T
         1rvN58Zq7B0sICZ4ZsC1ZbMHA9SxvyR1XVHpnD6YRAI2l1G3m1uGbE0CD+ruRdjvB5n9
         iJs7NV+fth+ULNJz6SHEkGXeb7/Xu8JcvNAHQfvDyGAn8/XHRmQftkLxH9ocm97HZSrC
         wP5NNnp3+y6yaEiA1TvbUvGQkWnwTi9Ug6pLcTSvwj3JpEav9YNIZAS+adqozild5foP
         cA1zJMlQDmzsNjvRJ+Jj1X5eguSDT1gvoozdsdSUdpTRp4OxicPheWJzCEev3xp493zb
         c5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cjsl8oNu3abooxKjC39QauJ1tWnfY0vCJ3akhqpZuKQ=;
        b=abn3QPaDoQEltUn3Tbpzl+LwaQHMEafCWJOJzhSeFLh1Cum6yHBtyzVkNlwjQSbqYE
         TmnqpUuexnM6z/Kzb05eE/O5VznJ0JYoPZa5Hr7hvKyZRtft9eH58v2vXTGR7agu99n1
         H6CiW72yRM+S1J47/1X8t7VykqBhAuk2sZOJYh6rA4JjhSGqjtRwqLJW4irz3T9FVVmm
         Eqf/7nKkZROG1K169ltEjeTGwUbtETfaPJHVVd9UqZSuXCMmxJ0RRmGypKZpRhcqk1V2
         l8cqqQHWeVUmPQLfvhYAoLc/k7YQH6ywZ53wUP1jvt6PAptLoYRCvufy8azcXJM9jN8o
         PBJg==
X-Gm-Message-State: AOAM531ZDN8m67g144a6sT2uTM9uh0w6/JEyL0Ntl8ECRzSQmL+0smnI
        dXG6FsrZE+6DuuPXaLVhregp
X-Google-Smtp-Source: ABdhPJyutCBXzwyBfFPF0YcDpJxaCT1Hc4p5mLZC+7qITdWwA1ydfqq8VnQlEAKUwmBqYtrZDZWF8w==
X-Received: by 2002:a17:90a:4404:: with SMTP id s4mr25941864pjg.218.1621242599509;
        Mon, 17 May 2021 02:09:59 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id f9sm1230538pfc.42.2021.05.17.02.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:09:59 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, dan.j.williams@intel.com,
        johannes@sipsolutions.net, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 16/17] vsock: Remove unused used length
Date:   Mon, 17 May 2021 17:08:35 +0800
Message-Id: <20210517090836.533-17-xieyongji@bytedance.com>
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
 net/vmw_vsock/virtio_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 2700a63ab095..f0fc432c8697 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -298,10 +298,9 @@ static void virtio_transport_tx_work(struct work_struct *work)
 
 	do {
 		struct virtio_vsock_pkt *pkt;
-		unsigned int len;
 
 		virtqueue_disable_cb(vq);
-		while ((pkt = virtqueue_get_buf(vq, &len)) != NULL) {
+		while ((pkt = virtqueue_get_buf(vq, NULL)) != NULL) {
 			virtio_transport_free_pkt(pkt);
 			added = true;
 		}
-- 
2.11.0

