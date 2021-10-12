Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B212429EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbhJLHdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbhJLHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:33:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D5C061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:31:32 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id a73so13168344pge.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WKIBNSq7zcpTlIrOfspDfNxkrUhFt3Q+atkNmbPY00c=;
        b=lY9ss1VNWZYaDl2V7LvI9KhMrd34v1kW+F88RdrMq1iKTq3zZX5KRRwQIhZzMv+IN9
         GkQ7UEMXR+jnnsJtvLvNNailmOZ/74+YTat7qmJHEs76hJsPxCJFHe7Ccn9dbPuWY44l
         0stsTbQIOYxMie+3AdSsyZ4JpN+GzsITtxyoMlFPxSuCcHEfMvDERlLuPo6ii74DNQIy
         hmNaa0eKX/k35PzGJttIiCGazGbVQzrhYzdoA876fi3yMlEiztOP/QSH/ZbeB1t3uIe2
         tGppmaSVXMqkm/WwKODNziWjjoQ4DC34ygImVuIibopPnDcouUWGmNiFzpl3UwaeVbz9
         gN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WKIBNSq7zcpTlIrOfspDfNxkrUhFt3Q+atkNmbPY00c=;
        b=eP1N3winDuq5K2X6sYpwnZNC/KRIOgq/REGPzdUZqRUBHb8zu865rbWUzMZ03KdPkD
         7qrM6Za7PszT/xBJIDxyO3Dlvodu9Ufa37xFh37zdD/EJfla0OfD+MGNqIIz3njalVbW
         RD+8wJH6c42mUlnWoLAoQruA2o+oNVLQ5O9TsaEiFzgMT4jg7nuEm0b5TsZflngESc5l
         KbKsuJTTKGYMrzzBjef83ShaK+W3jHox7Xzvzw46umnuf+cR0PTyR6FVXesBTwynUl9+
         JjSzDl/Vuu4wM6tQhhcRYfNXuo3NYBddjOhCas3UUBtZTQDr2QEO1pk6ejS+E+D/Rz7B
         Gppw==
X-Gm-Message-State: AOAM533/wNU1xGdNc4/e6HvLmfWiNKu2+xpUYQk4+qmOAGZRi1fUSdk/
        ufo3fuBM+5kl8rUCyC1gFCdVeg==
X-Google-Smtp-Source: ABdhPJzZlIS5cSGRq4AT7xeuY+T12+CRjbGYIGrv76NOr2svLmO1II5hUMIAgEYP4EsGRy6yacphHQ==
X-Received: by 2002:a63:e24b:: with SMTP id y11mr21466972pgj.452.1634023891741;
        Tue, 12 Oct 2021 00:31:31 -0700 (PDT)
Received: from localhost.localdomain ([223.178.212.208])
        by smtp.gmail.com with ESMTPSA id lw14sm1927634pjb.34.2021.10.12.00.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 00:31:31 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     op-tee@lists.trustedfirmware.org
Cc:     jens.wiklander@linaro.org, sudeep.holla@arm.com,
        jerome@forissier.org, daniel.thompson@linaro.org,
        maxim.uvarov@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] tee: optee: Fix missing devices unregister during optee_remove
Date:   Tue, 12 Oct 2021 13:01:16 +0530
Message-Id: <20211012073116.4156054-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When OP-TEE driver is built as a module, OP-TEE client devices
registered on TEE bus during probe should be unregistered during
optee_remove. So implement optee_unregister_devices() accordingly.

Fixes: c3fa24af9244 ("tee: optee: add TEE bus device enumeration support")
Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/core.c          |  3 +++
 drivers/tee/optee/device.c        | 22 ++++++++++++++++++++++
 drivers/tee/optee/optee_private.h |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index ccad3c7c8f6d..3915dc574503 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -586,6 +586,9 @@ static int optee_remove(struct platform_device *pdev)
 {
 	struct optee *optee = platform_get_drvdata(pdev);
 
+	/* Unregister OP-TEE specific client devices on TEE bus */
+	optee_unregister_devices();
+
 	/*
 	 * Ask OP-TEE to free all cached shared memory objects to decrease
 	 * reference counters and also avoid wild pointers in secure world
diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index ec1d24693eba..128a2d2a50a1 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -53,6 +53,13 @@ static int get_devices(struct tee_context *ctx, u32 session,
 	return 0;
 }
 
+static void optee_release_device(struct device *dev)
+{
+	struct tee_client_device *optee_device = to_tee_client_device(dev);
+
+	kfree(optee_device);
+}
+
 static int optee_register_device(const uuid_t *device_uuid)
 {
 	struct tee_client_device *optee_device = NULL;
@@ -63,6 +70,7 @@ static int optee_register_device(const uuid_t *device_uuid)
 		return -ENOMEM;
 
 	optee_device->dev.bus = &tee_bus_type;
+	optee_device->dev.release = optee_release_device;
 	if (dev_set_name(&optee_device->dev, "optee-ta-%pUb", device_uuid)) {
 		kfree(optee_device);
 		return -ENOMEM;
@@ -154,3 +162,17 @@ int optee_enumerate_devices(u32 func)
 {
 	return  __optee_enumerate_devices(func);
 }
+
+static int __optee_unregister_device(struct device *dev, void *data)
+{
+	if (!strncmp(dev_name(dev), "optee-ta", strlen("optee-ta")))
+		device_unregister(dev);
+
+	return 0;
+}
+
+void optee_unregister_devices(void)
+{
+	bus_for_each_dev(&tee_bus_type, NULL, NULL,
+			 __optee_unregister_device);
+}
diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
index e25b216a14ef..39be9aa7bd22 100644
--- a/drivers/tee/optee/optee_private.h
+++ b/drivers/tee/optee/optee_private.h
@@ -183,6 +183,7 @@ void optee_fill_pages_list(u64 *dst, struct page **pages, int num_pages,
 #define PTA_CMD_GET_DEVICES		0x0
 #define PTA_CMD_GET_DEVICES_SUPP	0x1
 int optee_enumerate_devices(u32 func);
+void optee_unregister_devices(void);
 
 /*
  * Small helpers
-- 
2.25.1

