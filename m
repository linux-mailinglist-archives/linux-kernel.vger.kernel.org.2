Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A6E382869
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhEQJgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236087AbhEQJgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:23 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999F6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d78so3678362pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iHQwQzh3oj7BjfcV4OFN9VRSTy1bzIatq/wkqo5gPoE=;
        b=dMn9yZp3VdnC1XpsmevQJ4rAiAx9FyNxR5XWe7N9ZH7Xx/Au3tiL5BruCHMqGVGZBc
         uKaJpRVFyD2CpLTtfwFfIM8Mrd02PmdyAVH9rRnYP0zwGiyhxhTp2bVcxNEe/GiVLRkG
         YkbPihPTKH7iRi7I7DNpilHYsUsmc4PfvaghybzAqp25B0ciQ9evG0315TSxKmNTBiZT
         VNf7NznhDAV8mtniM4U5CjWgba6onNrAt/E0+QPPawd5SSHE2G7XPc6YWayfqluW6a17
         OJ3MhogLuBfApcYVGAXvVnzMyudycOHNrGpr67WZnooshWHwa+8DZCBdDOx3B91AphIO
         raww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iHQwQzh3oj7BjfcV4OFN9VRSTy1bzIatq/wkqo5gPoE=;
        b=TQ1Q2GDNHDYVKwoM5vwPTB6pFUC63QXmmENVic5IVNPUA3uGMBCg5tUrfDlNyr/DJe
         6MPGo8gtwLNRtCN7KoJYt1XZR5BjX0cUektr8oxS5jrm3Rem9Z6bnRanRWzjTZR0xJ8g
         2oQqGWk7y4hrtXqlaAHlxWKADDVqmJfO2LaRCLFj9vdZIB7CR0DOLj42wiiSjQEDb15W
         FOFFZywc7XDu8NY4/mFnHw5TejnppFb/JH3QLXd0Cy2gViJYJdYk4HJf1Y5r3m7JuUIj
         xIYjJbdk8ntEviOSLhRbrmKn7bjFqJ5M7Jh7/3wUdoeWWYnK8DdUpHrMTIIEyUb9xMVU
         V2UQ==
X-Gm-Message-State: AOAM530oDuHErbZBKIcsB7fJKqMGo919u3qSYF2PSfpux2ouQR8vIFJJ
        SnLKpGpWmXj5v1tEqNGWlPBE
X-Google-Smtp-Source: ABdhPJxkyPmezvc3E9Kb2x4uHx56xpDQDXio19GBdMFkOLHKP7bwHiVGNz0l3EW6EhGgnOscNpdpOA==
X-Received: by 2002:a62:bd19:0:b029:2db:9bd7:edf0 with SMTP id a25-20020a62bd190000b02902db9bd7edf0mr5429296pff.40.1621244106218;
        Mon, 17 May 2021 02:35:06 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id z5sm7020079pfa.172.2021.05.17.02.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:05 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/15] virtio_console: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:16 +0800
Message-Id: <20210517093428.670-4-xieyongji@bytedance.com>
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
 drivers/char/virtio_console.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b85abe1eb2d1..1c40ca6d76ba 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2048,7 +2048,11 @@ static int virtcons_probe(struct virtio_device *vdev)
 	INIT_LIST_HEAD(&portdev->ports);
 	INIT_LIST_HEAD(&portdev->list);
 
-	virtio_device_ready(portdev->vdev);
+	err = virtio_device_ready(portdev->vdev);
+	if (err) {
+		dev_err(&vdev->dev, "Error %d enable virtio device\n", err);
+		goto free_vqs;
+	}
 
 	INIT_WORK(&portdev->config_work, &config_work_handler);
 	INIT_WORK(&portdev->control_work, &control_work_handler);
@@ -2100,6 +2104,8 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	return 0;
 
+free_vqs:
+	remove_vqs(portdev);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
@@ -2178,7 +2184,11 @@ static int virtcons_restore(struct virtio_device *vdev)
 	if (ret)
 		return ret;
 
-	virtio_device_ready(portdev->vdev);
+	ret = virtio_device_ready(portdev->vdev);
+	if (ret) {
+		remove_vqs(portdev);
+		return ret;
+	}
 
 	if (use_multiport(portdev))
 		fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
-- 
2.11.0

