Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986B0382879
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbhEQJi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236131AbhEQJgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:54 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5BC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s4so1255220plg.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNq8gr989Cum5eqHTtmZ5NFuzewoSMmlqjhN+Y3JjjU=;
        b=zBB0D5s4sq1tRVYKSTHCHoewqcNYE9/9D3K5o+cRGAc0CclrS9NLlx+OnuGlvsbGae
         kVors8xjwdFxeQpN/PKex1ymbZ+WoBMfjHORYmzxt9ksfMAx14q2X2wtHNU/RurNYqAQ
         ROVHEpSJHT4iIqBNdWwi2KQSaxNTpu+pCSbMP2E+ZlrwLqRDD8vplVKp/ktzrHz23XRU
         srVJkZc2hJFNwOpxPrRWF0uQQ7wvT5xWsJ4fRpJUscqBBTXymhl+/MI0Y4r4KucTj6Aw
         euw1yoLymT68Qk5twmIoSJpfV9wHYVb8ok1R38dGMsp+YgwoVsvmgvS2WSKuP0Msr57L
         I0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNq8gr989Cum5eqHTtmZ5NFuzewoSMmlqjhN+Y3JjjU=;
        b=BsdquK1e5dwH3cDhfnvQn3z+0+d/AGwMoohbDUmTWvbsDYFHM2bxR1uyEQSu8lxv0r
         VDbAspv1rXz/4kPwj9rF7a4HfoL57mZqHmtY4r25rHdzC0geVyHsZTVIP+5T+pk1F+xF
         7qN9n+Jh0/HmthFb8mbcmj9xbgOeU8yDJjJIirNr7UUCNrr00k3XBfi2/S3YU/utTcQu
         eS4JimQvofrh3MpMtD2Mvl0O5w/ryNUoQtwW4NOutjUEotm0ZWeckvCQHJQZOurxB4Ok
         +DQdQfRt+jEDBIi+EN9Tw14ZHhIpcevcbT+1M5ZGs6AnrrbOf2DsfSiEZVb97T1/wM4h
         L+AQ==
X-Gm-Message-State: AOAM531CLjxM1r71xZiHfCdpPqKF6N4s4l7fUrEd+Zn2xdfVaudUpKVM
        N0GIt7OueEehzyhfQtnmapE6
X-Google-Smtp-Source: ABdhPJxSQA7/qLFgqM39uhNUgORKWUTMOCaXpx41h26BzChg4S+QHLSCkpAO3gGVi4z5OEYrEETn8Q==
X-Received: by 2002:a17:90a:b38a:: with SMTP id e10mr67737493pjr.175.1621244137631;
        Mon, 17 May 2021 02:35:37 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id t22sm2584245pfl.50.2021.05.17.02.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:37 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/15] virtio-balloon: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:24 +0800
Message-Id: <20210517093428.670-12-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case in both probe
and resume paths.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_balloon.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 7565970c3901..4f183dd901b3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -997,12 +997,17 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 	}
 
-	virtio_device_ready(vdev);
+	err = virtio_device_ready(vdev);
+	if (err)
+		goto out_unregister_page_report;
 
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	return 0;
 
+out_unregister_page_report:
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
+		page_reporting_unregister(&vb->pr_dev_info);
 out_unregister_oom:
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
 		unregister_oom_notifier(&vb->oom_nb);
@@ -1096,7 +1101,11 @@ static int virtballoon_restore(struct virtio_device *vdev)
 	if (ret)
 		return ret;
 
-	virtio_device_ready(vdev);
+	ret = virtio_device_ready(vdev);
+	if (ret) {
+		vdev->config->del_vqs(vdev);
+		return ret;
+	}
 
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
-- 
2.11.0

