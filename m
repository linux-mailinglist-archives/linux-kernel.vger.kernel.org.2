Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C954D382874
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbhEQJiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbhEQJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:36:49 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244D6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:34 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l70so4262649pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eCM07yV+8ZYPCGkGSb+ltYoBYNY6Q8goaUeuE/GSdRk=;
        b=XoQcbFVUBqicWVW+la1Elsm3pldUVc0X9Yhc6SAxXd4MIBv+EM8ctN8GDyo7HLmVfx
         Ahj6jHOHtklFNAIdMeBVbfki3zb9K2rCfCfPK90KfpH6tAoCmgdo4RmG+yiGV6msnX4r
         ZZ+TD11Oq6QaluyMRNQxquws47e9tst9vRq8eSaf2xVsGFPJZAF6BewND6VJ+29q1JIs
         bvFJ4tmwspKcTyNYSZZI2rJH9AV6CoOfY2NHMcdE6+2eweRa/98GTdAw9w9hR4L71VjJ
         SsBYsuSlQtXVycBWapc6Ho4Hnu/wQwtlh2ei7dudfrmntJ1EbsPdIXKuPsYOjxv0VYte
         6nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eCM07yV+8ZYPCGkGSb+ltYoBYNY6Q8goaUeuE/GSdRk=;
        b=mRKAhWhLRhEgVbUxHGCX30Pt8SZx0h+eDD/YAgbLbf6y4+SeRubkc+batEq3SQSPlc
         pNubFXSrz2Lax4pXt2Bng420UjY4oE8h13dDKIU3co0gPtEbP7elrQ/90Ju/vvQkCnsB
         a1wakAyQH3ywvxEAJ1pXOLWcgTFQNYQS4lVN68jBFb/AOsmNHsA/IGijIAd/UcGw7VfE
         dcGUOGytWTFtWgbgstCWb+CMPbLIIk3cuPT0LCj5dHMwnQSH56PrxmE+IupHdqpjxXrm
         X+S55ZgjlWOUx1HrDouqXgjCmfWe2vjVvGg4S7+4qw+17ushiwRFWWJBbChtDzdf2G8q
         bQTw==
X-Gm-Message-State: AOAM532cTUgJFEgc8qyPUPfnv6B9jZX7XOU35s3DDm0uyjYfgBB0CZVJ
        mG1/JvTWQyhHznSwSm2CmuDx
X-Google-Smtp-Source: ABdhPJzS2LUrGPAqYxcImZqMVPkhGafEQnh9rnCMEllfKgQQwnA5fX3BnB0C6ec/nrTQpiDIUT283Q==
X-Received: by 2002:aa7:9a81:0:b029:28e:b12c:9862 with SMTP id w1-20020aa79a810000b029028eb12c9862mr59913169pfi.51.1621244133641;
        Mon, 17 May 2021 02:35:33 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id a20sm9541305pfc.186.2021.05.17.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:35:33 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com
Cc:     amit@kernel.org, arei.gonglei@huawei.com, airlied@linux.ie,
        kraxel@redhat.com, jean-philippe@linaro.org, ohad@wizery.com,
        bjorn.andersson@linaro.org, david@redhat.com, vgoyal@redhat.com,
        miklos@szeredi.hu, lucho@ionkov.net, asmadeus@codewreck.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 10/15] virtio: Handle virtio_device_ready() failure
Date:   Mon, 17 May 2021 17:34:23 +0800
Message-Id: <20210517093428.670-11-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517093428.670-1-xieyongji@bytedance.com>
References: <20210517093428.670-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now virtio_device_ready() will return error if we get
invalid status. Let's handle this case in virtio_dev_probe().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 4b15c00c0a0a..ff16e1cce2e7 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -263,8 +263,11 @@ static int virtio_dev_probe(struct device *_d)
 		goto err;
 
 	/* If probe didn't do it, mark device DRIVER_OK ourselves. */
-	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
-		virtio_device_ready(dev);
+	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK)) {
+		err = virtio_device_ready(dev);
+		if (err)
+			goto err_ready;
+	}
 
 	if (drv->scan)
 		drv->scan(dev);
@@ -272,6 +275,8 @@ static int virtio_dev_probe(struct device *_d)
 	virtio_config_enable(dev);
 
 	return 0;
+err_ready:
+	drv->remove(dev);
 err:
 	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
 	return err;
-- 
2.11.0

