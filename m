Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B143DA10A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 12:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhG2K2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 06:28:18 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:33740
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235510AbhG2K2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 06:28:16 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 5CB2E3F10D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627554490;
        bh=3lP5TEMwTNPyCtaRO7YTrbYiyPUNNmQTosdLpyAOjSM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=If9TBU+wQQeikjra/bfR40KQSWIg674pX9vm6rPYNpMT7ywLBytNcy9UDo/OfGsJp
         awGZFLTrwcZ+QgBOq+StGJE9aN9kANw5hegfyybTbXxQUmaEuBWv4LjlIDPhpkGbsV
         a37PmWgxlMysmVftYEndMLJicq/A5QsmO2bXwxHY6TYe2FBDQj+7HD6wz1sYoy3yXS
         6M8OqYHAD/Dw3tRXXPrUFj51zWy8m/VP7D+Umn/YCycAuvjIoRJqp2pxUy5YbjFuRP
         svmzLycM68Sw6RyZ2EOKMmMQvjsOu5wPC4ofuTDFb9yOV9oJFYyIJJQio5ITi97i3w
         vSEqi65TCQ/jA==
Received: by mail-ed1-f70.google.com with SMTP id c20-20020a0564021014b029039994f9cab9so1272734edu.22
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 03:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3lP5TEMwTNPyCtaRO7YTrbYiyPUNNmQTosdLpyAOjSM=;
        b=FCmK2ICsPdwMzU9dk8ke1HaYWVPfy17Dlf0x4486Ktw5RSrY2Kt6DmT4JbdGQvZQXq
         nkf10YSkLQxke1JGPniUZz3Kg7l7KYqwK5wyhJBfPYttW1BhBwjEZl8zGa52B1EEy4iF
         9ffEZQNWy5h4u3Sk/TOVdQRspJ3Uv34qy58kWOsao251w8Y8H9h3C5vS8rKlggRW6xAc
         m9bHa5XpaNPAlsi6k/AeSlnMCW9AOkdXruluEI1mFUPFvwI6VhkyoMYgVa3nqNpVhbBn
         OhN2jp0Ik81SOwixqKPPNQASjOxs1hMh7d1RLqddNavSnpwVT2dWWA+w+2jwNXwRVxaE
         FCWg==
X-Gm-Message-State: AOAM531X62QnJj8SxoIw6sKoWVNAMQ2NVgqIlMompf4KoUm8zIuGDFlE
        npoHeGfmWgQD77MmX5YvD1/4KijSXfVwO3jmgMM34wWEJouZYqSGdrCTJMTzfvS6lPrxcooacvQ
        gcR8uNqdfDkynJjuUyUPalX4NBC9KEP552jsfSyEFOA==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr5046979ede.201.1627554489070;
        Thu, 29 Jul 2021 03:28:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDLD2DRNNjgpMQdhV0g9xtas8XsRGAMIj1z025QIlHTNhjbpRJ8xFwsiV6UpjuwmkQEz3hpw==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr5046964ede.201.1627554488915;
        Thu, 29 Jul 2021 03:28:08 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id kf3sm824603ejc.118.2021.07.29.03.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 03:28:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] mei: constify passed buffers and structures
Date:   Thu, 29 Jul 2021 12:28:03 +0200
Message-Id: <20210729102803.46289-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Buffers and structures passed to MEI bus and client API can be made
const for safer code and clear indication that it is not modified.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/misc/mei/bus.c     | 18 +++++++++---------
 drivers/misc/mei/client.h  |  2 +-
 drivers/misc/mei/mei_dev.h |  2 +-
 include/linux/mei_cl_bus.h |  9 +++++----
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 935acc6bbf3c..09188d9afc06 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -31,7 +31,7 @@
  *
  * Return: written size bytes or < 0 on error
  */
-ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length, u8 vtag,
+ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
 		      unsigned int mode)
 {
 	struct mei_device *bus;
@@ -232,8 +232,8 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
  *  * < 0 on error
  */
 
-ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, u8 *buf, size_t length,
-			    u8 vtag)
+ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, const u8 *buf,
+			    size_t length, u8 vtag)
 {
 	struct mei_cl *cl = cldev->cl;
 
@@ -296,7 +296,7 @@ EXPORT_SYMBOL_GPL(mei_cldev_recv_nonblock_vtag);
  *  * written size in bytes
  *  * < 0 on error
  */
-ssize_t mei_cldev_send(struct mei_cl_device *cldev, u8 *buf, size_t length)
+ssize_t mei_cldev_send(struct mei_cl_device *cldev, const u8 *buf, size_t length)
 {
 	return mei_cldev_send_vtag(cldev, buf, length, 0);
 }
@@ -552,7 +552,7 @@ EXPORT_SYMBOL_GPL(mei_cldev_ver);
  *
  * Return: true if me client is initialized and connected
  */
-bool mei_cldev_enabled(struct mei_cl_device *cldev)
+bool mei_cldev_enabled(const struct mei_cl_device *cldev)
 {
 	return mei_cl_is_connected(cldev->cl);
 }
@@ -771,8 +771,8 @@ EXPORT_SYMBOL_GPL(mei_cldev_disable);
  * Return: id on success; NULL if no id is matching
  */
 static const
-struct mei_cl_device_id *mei_cl_device_find(struct mei_cl_device *cldev,
-					    struct mei_cl_driver *cldrv)
+struct mei_cl_device_id *mei_cl_device_find(const struct mei_cl_device *cldev,
+					    const struct mei_cl_driver *cldrv)
 {
 	const struct mei_cl_device_id *id;
 	const uuid_le *uuid;
@@ -815,8 +815,8 @@ struct mei_cl_device_id *mei_cl_device_find(struct mei_cl_device *cldev,
  */
 static int mei_cl_device_match(struct device *dev, struct device_driver *drv)
 {
-	struct mei_cl_device *cldev = to_mei_cl_device(dev);
-	struct mei_cl_driver *cldrv = to_mei_cl_driver(drv);
+	const struct mei_cl_device *cldev = to_mei_cl_device(dev);
+	const struct mei_cl_driver *cldrv = to_mei_cl_driver(drv);
 	const struct mei_cl_device_id *found_id;
 
 	if (!cldev)
diff --git a/drivers/misc/mei/client.h b/drivers/misc/mei/client.h
index b12cdcde9436..418056fb1489 100644
--- a/drivers/misc/mei/client.h
+++ b/drivers/misc/mei/client.h
@@ -160,7 +160,7 @@ int mei_cl_vt_support_check(const struct mei_cl *cl);
  *
  * Return: true if the host client is connected
  */
-static inline bool mei_cl_is_connected(struct mei_cl *cl)
+static inline bool mei_cl_is_connected(const struct mei_cl *cl)
 {
 	return  cl->state == MEI_FILE_CONNECTED;
 }
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index b7b6ef344e80..694f866f87ef 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -356,7 +356,7 @@ struct mei_hw_ops {
 /* MEI bus API*/
 void mei_cl_bus_rescan_work(struct work_struct *work);
 void mei_cl_bus_dev_fixup(struct mei_cl_device *dev);
-ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length, u8 vtag,
+ssize_t __mei_cl_send(struct mei_cl *cl, const u8 *buf, size_t length, u8 vtag,
 		      unsigned int mode);
 ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
 		      unsigned int mode, unsigned long timeout);
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index 07f5ef8fc456..c6786c12b207 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -91,12 +91,13 @@ void mei_cldev_driver_unregister(struct mei_cl_driver *cldrv);
 		      mei_cldev_driver_register,\
 		      mei_cldev_driver_unregister)
 
-ssize_t mei_cldev_send(struct mei_cl_device *cldev, u8 *buf, size_t length);
+ssize_t mei_cldev_send(struct mei_cl_device *cldev, const u8 *buf,
+		       size_t length);
 ssize_t mei_cldev_recv(struct mei_cl_device *cldev, u8 *buf, size_t length);
 ssize_t mei_cldev_recv_nonblock(struct mei_cl_device *cldev, u8 *buf,
 				size_t length);
-ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, u8 *buf, size_t length,
-			    u8 vtag);
+ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, const u8 *buf,
+			    size_t length, u8 vtag);
 ssize_t mei_cldev_recv_vtag(struct mei_cl_device *cldev, u8 *buf, size_t length,
 			    u8 *vtag);
 ssize_t mei_cldev_recv_nonblock_vtag(struct mei_cl_device *cldev, u8 *buf,
@@ -114,6 +115,6 @@ void mei_cldev_set_drvdata(struct mei_cl_device *cldev, void *data);
 
 int mei_cldev_enable(struct mei_cl_device *cldev);
 int mei_cldev_disable(struct mei_cl_device *cldev);
-bool mei_cldev_enabled(struct mei_cl_device *cldev);
+bool mei_cldev_enabled(const struct mei_cl_device *cldev);
 
 #endif /* _LINUX_MEI_CL_BUS_H */
-- 
2.27.0

