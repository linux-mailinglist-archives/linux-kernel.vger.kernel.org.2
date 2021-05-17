Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327A638287D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbhEQJic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbhEQJiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:38:08 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D738C0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 22so4158724pfv.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eSSgTqCwF0AbLQkviLxaoSkVosc45pkRsLWs9e+sHs0=;
        b=rP79KkhvyoPnaHssbWzxPdD85UHgU9h99Ifm761H9FRvwqefN7x8PPEGrW7c3Ecofw
         OfCihyoOw8sNTbOM9B30WjRlmmqXWb6q45lxQNTQAiI5+OEw8mvyePm7aWD25tPc5aPG
         0DaEWjE6bgCGTvVseg1sIZiysHYsVHrHBrBMcmX1t5D1FOfyIJNKPffRtEm+jjb1p4Y2
         pLkBYL3Gs2DkzJepXc3VC0blxgHASCLa+oxNOHhmq+LigLqHq2pBSVOyewhQQXVU+mbA
         wNV78SwbMfmS8i1x9pYQtkknYJnJ6X6Y+FzgL5rS2NglnQZLX48ZAG/cqW2oKKnR0EU+
         ODNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eSSgTqCwF0AbLQkviLxaoSkVosc45pkRsLWs9e+sHs0=;
        b=q3EzzTJ/96hDWcN84BsOPeYkxp/B8L4tWofRuBptE3lE9QQIHlXkBBeWX9Z9/OcQ8P
         eFip8EB5iHrc86K/yHN571nVOIqhgi60UCvVEG4Nhhnk1yw4X4CkfWRAK3UB5dN8HRb8
         qQ6NmHE42MjlOLNJeg5HAKwySDK/dwv9/zHb15OPCYdbPKgvSOhAPFlk0yxcSQAHMqS/
         SZyTAFssjOSfE+3UsabmNzHwEnaqiUbXufBfif+Xc9PktGnV4jPSgWOS8CTrzmwjiln0
         cZwMvQkaisfLPQQfv7IWSsrDgO/MRiG0JHXjsji/IAOQNOEPb7yz4a+tfiD81ebhHivf
         O6zQ==
X-Gm-Message-State: AOAM531TNjwKwqApH3CIP7HefWi4w6FQmJ+G2NQaHPCQGxELOh7C6ZWI
        4AeH0UGQReroiF3njrdhFDK+
X-Google-Smtp-Source: ABdhPJz0RNHllbeUqAEwY8QuD4u7lFf5NTuAXElgdmUrKvl9e3vvwvWl87a7wkXaVNlhb/MMgtDN3Q==
X-Received: by 2002:a63:145e:: with SMTP id 30mr29327021pgu.174.1621244149121;
        Mon, 17 May 2021 02:35:49 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id j4sm11359423pjm.10.2021.05.17.02.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:48 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 14/15] virtiofs: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:27 +0800
Message-Id: <20210517093428.670-15-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case on probe.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/fuse/virtio_fs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index e61c94eaa20f..ade0dc42ebfd 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -883,7 +883,9 @@ static int virtio_fs_probe(struct virtio_device *vdev)
 	/* Bring the device online in case the filesystem is mounted and
 	 * requests need to be sent before we return.
 	 */
-	virtio_device_ready(vdev);
+	ret = virtio_device_ready(vdev);
+	if (ret < 0)
+		goto out_vqs;
 
 	ret = virtio_fs_add_instance(fs);
 	if (ret < 0)
-- 
2.11.0

