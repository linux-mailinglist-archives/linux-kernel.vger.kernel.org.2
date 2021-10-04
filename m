Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737AB4211C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhJDOqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhJDOqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:46:04 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C4C061745;
        Mon,  4 Oct 2021 07:44:15 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h129so20580627iof.1;
        Mon, 04 Oct 2021 07:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFn5wnEKAEZb25y29QzIAy3UngZkq+Tr6QhUXIqoMzk=;
        b=XAy6xseKyA85uWu1AcjgqVxdVMhk/76Z8hg+31lpt+87yEJMxXwBvO8mxmzXawd4wo
         P6gWWRtvtpImu/vCTs46kGmuSkzGNRyRhJ52TpNNDRcT8aTJhb8F3DLdKqphel/4QWsD
         g+RjodCdu7YYMvRxnHCz/PLtrDOMpCDsCfQ4F8CxnypEaYtFB3Z7h1/Ei4lP0da2cRpN
         7fW+gn7WNtNfUu4XjWvQxrj8l0gjuEiMQP7YiVfKE4yVVtjFDnrt3ueGCcWgDznoUmn0
         hH/3UuGZdwV5lJ9EtwqZv2/w9H9PWHdFZe4dKZy5oxzMJtQi+3EmBdtBjQ+ftkLg5aPy
         etMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFn5wnEKAEZb25y29QzIAy3UngZkq+Tr6QhUXIqoMzk=;
        b=CL4BDLL3a8esOQidNNj/1RSGOzvj/0KIL6Zqqi6G6SaDYzrQqNbxRbtFbqzAOWRgAo
         mDuNtVIniYrCFajxFq9XDCDAMpkobGxAJNKkkei8X56WEhHpMm2j+VEsI9/7voO/2FIU
         upI1IRemJfyjl+wWFkTp8bvwBa5I149qKIjuMbBCtdQ1fYkRxMQoPblxjHwU5qJls963
         a9Ke8R0sZ2hRQBP+7W31qV8l0eleDh9LvjXcREeJmKoYki4/Q4aowsR1rLLQsHvtMqOc
         hqYKcOHMlekKcnDRiIB51WCJJKZXIcnXfzvRwWHr/NUh0/nrHyjw7jJTWWaeppjaIXPY
         ju9A==
X-Gm-Message-State: AOAM533r5zbV34Ofwd3QMiVR9cL4K0OIeIuD7zEKoq3trPubPJiae+He
        Kpmd7EXHqWHC+vhOALvEGHo=
X-Google-Smtp-Source: ABdhPJwEK9aiS5cXI9Wt4cweO7upc9wAlSU/oP6P8LW313Ia3YpyQIuAlQjfAb77zbpDZBjB69QQAw==
X-Received: by 2002:a6b:5a0c:: with SMTP id o12mr9781570iob.140.1633358653912;
        Mon, 04 Oct 2021 07:44:13 -0700 (PDT)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.7])
        by smtp.gmail.com with ESMTPSA id b11sm3692382ile.12.2021.10.04.07.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:44:13 -0700 (PDT)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     Brandon Wyman <bjwyman@gmail.com>
Subject: [PATCH 1/2] hwmon: (pmbus/ibm-cffps) Add mfg_id debugfs entry
Date:   Mon,  4 Oct 2021 14:43:38 +0000
Message-Id: <20211004144339.2634330-1-bjwyman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the manufacturer ID to the debugfs entries.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index df712ce4b164..2ee47cbbb665 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -18,6 +18,7 @@
 
 #include "pmbus.h"
 
+#define CFFPS_MFG_ID_CMD                        0x99
 #define CFFPS_FRU_CMD				0x9A
 #define CFFPS_PN_CMD				0x9B
 #define CFFPS_HEADER_CMD			0x9C
@@ -34,7 +35,7 @@
 #define CFFPS_INPUT_HISTORY_SIZE		100
 
 #define CFFPS_CCIN_REVISION			GENMASK(7, 0)
-#define  CFFPS_CCIN_REVISION_LEGACY		 0xde
+#define CFFPS_CCIN_REVISION_LEGACY		 0xde
 #define CFFPS_CCIN_VERSION			GENMASK(15, 8)
 #define CFFPS_CCIN_VERSION_1			 0x2b
 #define CFFPS_CCIN_VERSION_2			 0x2e
@@ -57,6 +58,7 @@
 
 enum {
 	CFFPS_DEBUGFS_INPUT_HISTORY = 0,
+	CFFPS_DEBUGFS_MFG_ID,
 	CFFPS_DEBUGFS_FRU,
 	CFFPS_DEBUGFS_PN,
 	CFFPS_DEBUGFS_HEADER,
@@ -158,6 +160,9 @@ static ssize_t ibm_cffps_debugfs_read(struct file *file, char __user *buf,
 	switch (idx) {
 	case CFFPS_DEBUGFS_INPUT_HISTORY:
 		return ibm_cffps_read_input_history(psu, buf, count, ppos);
+	case CFFPS_DEBUGFS_MFG_ID:
+		cmd = CFFPS_MFG_ID_CMD;
+		break;
 	case CFFPS_DEBUGFS_FRU:
 		cmd = CFFPS_FRU_CMD;
 		break;
@@ -558,6 +563,9 @@ static int ibm_cffps_probe(struct i2c_client *client)
 	debugfs_create_file("input_history", 0444, ibm_cffps_dir,
 			    &psu->debugfs_entries[CFFPS_DEBUGFS_INPUT_HISTORY],
 			    &ibm_cffps_fops);
+	debugfs_create_file("mfg_id", 0444, ibm_cffps_dir,
+			    &psu->debugfs_entries[CFFPS_DEBUGFS_MFG_ID],
+			    &ibm_cffps_fops);
 	debugfs_create_file("fru", 0444, ibm_cffps_dir,
 			    &psu->debugfs_entries[CFFPS_DEBUGFS_FRU],
 			    &ibm_cffps_fops);
-- 
2.25.1

