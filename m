Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096B14211C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhJDOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234902AbhJDOqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:46:13 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD60C061745;
        Mon,  4 Oct 2021 07:44:24 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id l20so6162152ilk.2;
        Mon, 04 Oct 2021 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7EvqN40ZsaJpmzmKI90qpoq8EiCU5xRqyhC9TLRD+0=;
        b=bnpINp6npWGwJuvw9UmB8B647LD2eEkrKSk56Dn9bP/J+Jg1w4p4Pus3+Qmuyds5Mz
         81uLXhL2ifxN5Vuhl0+Z6K38vYsAi+tVgVK2SGHo2gyXyP4T/li3Puulj2mCRXVWfv7q
         IvojXX8bH9OiTZ7UZ8nBYWCHInxs/7ItgoOjS8ZDkQ/b7VObC4lCjweFNGWnlwf/CXkF
         90F5OHbKLxf8lViRSbqVCXF638A/ZZfcadu0vjTJlMj/CLFOWs6aqFpYywlW03XrTbIT
         VD0d8oS4zPJlEYpYrXeowzR3xSgwLlygI13jhQcZ7i974HLPOahq0M8NHJcpYB4WhxPz
         sPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7EvqN40ZsaJpmzmKI90qpoq8EiCU5xRqyhC9TLRD+0=;
        b=KTa6VuI6TC3Y8r0yG+kee5+XQus6widbuxGi42pq04b4nMBfpz634jFsG/ztjtCD+s
         0iaAIxeRCpwqLTaKy4qdVDdz3tdnCx15e0Axzo3ars/YlYeBGYb4DwNCL/PvsUBi5uaj
         FyySbTwi7tb22l78q2hozg1lQCcaDA8M3Rv67RCRjxMhEKscEQD3jX/H9uLtWLlVjy5s
         sLkphJ9gYKgd5HW819EeuCOHJvoldRBi7sFjEL7E2/ctxepDw5oEWZinA32Wa271p0od
         o97wJ7iS6sYXS9jbLeTtg3/UUzZpO1kzqDIe51A+EAhFERCx/hFLdM63fOE6TcDyb6hT
         4gHw==
X-Gm-Message-State: AOAM532J295tlyUPYoYPn/jq1cicEnLeG0xXLCFCq4MngZw5PhKIp8WA
        18Bfu83vn1chOfQrZ4NZsFo=
X-Google-Smtp-Source: ABdhPJy6AOE/KMxXys6rH0bg3VLu7gyzjWJnK7GpWxYJzISlnn5gnuq7UmgP7BPV1NxOT6CVOi7Tng==
X-Received: by 2002:a05:6e02:1445:: with SMTP id p5mr6807213ilo.11.1633358663794;
        Mon, 04 Oct 2021 07:44:23 -0700 (PDT)
Received: from fstone04p1.aus.stglabs.ibm.com ([129.41.86.7])
        by smtp.gmail.com with ESMTPSA id b11sm3692382ile.12.2021.10.04.07.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:44:23 -0700 (PDT)
From:   Brandon Wyman <bjwyman@gmail.com>
To:     Joel Stanley <joel@jms.id.au>, openbmc@lists.ozlabs.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Cc:     Brandon Wyman <bjwyman@gmail.com>
Subject: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Use MFR_ID to choose version
Date:   Mon,  4 Oct 2021 14:43:39 +0000
Message-Id: <20211004144339.2634330-2-bjwyman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144339.2634330-1-bjwyman@gmail.com>
References: <20211004144339.2634330-1-bjwyman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are multiple power supplies that will indicate
CFFPS_CCIN_VERSION_1, use the manufacturer ID to determine if it should
be treated as version cffps1 or version cffps2.

Signed-off-by: Brandon Wyman <bjwyman@gmail.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index 2ee47cbbb665..292c87331f2b 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -502,16 +502,29 @@ static int ibm_cffps_probe(struct i2c_client *client)
 		u16 ccin_revision = 0;
 		u16 ccin_version = CFFPS_CCIN_VERSION_1;
 		int ccin = i2c_smbus_read_word_swapped(client, CFFPS_CCIN_CMD);
+		char mfg_id[I2C_SMBUS_BLOCK_MAX + 2] = { 0 };
 
 		if (ccin > 0) {
 			ccin_revision = FIELD_GET(CFFPS_CCIN_REVISION, ccin);
 			ccin_version = FIELD_GET(CFFPS_CCIN_VERSION, ccin);
 		}
 
+		rc = i2c_smbus_read_block_data(client, PMBUS_MFR_ID,
+				mfg_id);
+		if (rc < 0) {
+			dev_err(&client->dev,
+					"Failed to read Manufacturer ID\n");
+			return rc;
+		}
+
 		switch (ccin_version) {
 		default:
 		case CFFPS_CCIN_VERSION_1:
-			vs = cffps1;
+			if ((strncmp(mfg_id, "ACBE", 4) == 0) ||
+					(strncmp(mfg_id, "ARTE", 4) == 0))
+				vs = cffps1;
+			else
+				vs = cffps2;
 			break;
 		case CFFPS_CCIN_VERSION_2:
 			vs = cffps2;
-- 
2.25.1

