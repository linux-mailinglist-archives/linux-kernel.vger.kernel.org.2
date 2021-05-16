Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBD9381C4A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 05:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhEPDtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 23:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhEPDtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 23:49:03 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85474C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 20:47:48 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso2754694ots.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 20:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdBNcSQ1fL9YYvu0gmDFkHR89r/K55hXfYPZOrq9QCs=;
        b=qfgZxKKQXKOKsW/GDWCLAyrQduY+tQL7sbUY1svUl02N2kFG/M31drqyoWvlFPfPKC
         I/7I0e/wtJOHt5xAIAmCFF0A2eXsqKUdSn6dFo0uH2+pkJOWFPMIlBfZDt/JmDFSHXl3
         wTSg6B4U82paFC2hJx5xJQA4kBX5bNS8aVHoNK+0nxQwR1uXXm9S5PDR6apMWY+eslyx
         CLi34rT0b6vfiGmKT36j5EaN0kNU3oljL6VQBtHt4or3HbBx8D4aCSmBlcqNkw81oDCF
         n/qdQnIMoW2pe1b/lYYnSEZzRdYTHCqhQo8uap1jsuvIgycYz35xHZiXqhcTbHDUK1MW
         8V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NdBNcSQ1fL9YYvu0gmDFkHR89r/K55hXfYPZOrq9QCs=;
        b=jI1YhU6nCf64e/IGG8sl68dksX+uT5dYytpJ7Kkayo8Yby8OTWxgVBaruC5Hxp01/d
         G3xm66alEnyCy5747sB+0Q9ps3szGnRi1uT5gY7vMhk/V7jkANmtohW6T7GEWbG3x/Ku
         pF+UcT2KyXpQtyg03ZxcM5/H8oPuVgjltUPUDXrfSZnFfS4M8XHBfVprZUpiO4yQtz7F
         2xLsY4KeXNb4J04MgOn1xNwhhC8ojl8LxX1bfUVoXDhm5H0NxAqH9Ci7OFO8uDrkzjJQ
         4yFAyxnrEBjL+zqidethB0dYQFXlZ1DuOhLo5eT3WYMAkDYFYyGB4dJb+v9dvRR+FvB4
         5jcw==
X-Gm-Message-State: AOAM533L6hpwTmdr1cMqINqSaAwxa9mtAnpl58ZAsJdMjTGWp0tWoXHn
        yQrsHXvCaoDdarGYxIaIceE1jOpFvC98tw==
X-Google-Smtp-Source: ABdhPJwClncgW5BfBUpGmjfKmFl8ypszchTFc4WYEjbc9jL5pnTXnKM0AvulKto/XB0ScttVnwEu7A==
X-Received: by 2002:a05:6830:44f:: with SMTP id d15mr7395709otc.369.1621136867718;
        Sat, 15 May 2021 20:47:47 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q1sm2403157otc.21.2021.05.15.20.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 20:47:47 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <jun.li@nxp.com>, Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: mux: Fix matching with typec_altmode_desc
Date:   Sat, 15 May 2021 20:47:30 -0700
Message-Id: <20210516034730.621461-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In typec_mux_match() "nval" is assigned the number of elements in the
"svid" fwnode property, then the variable is used to store the success
of the read and finally attempts to loop between 0 and "success" - i.e.
not at all - and the code returns indicating that no match was found.

Fix this by using a separate variable to track the success of the read,
to allow the loop to get a change to find a match.

Fixes: 96a6d031ca99 ("usb: typec: mux: Find the muxes by also matching against the device node")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/typec/mux.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 9da22ae3006c..8514bec7e1b8 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -191,6 +191,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 	bool match;
 	int nval;
 	u16 *val;
+	int ret;
 	int i;
 
 	/*
@@ -218,10 +219,10 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 	if (!val)
 		return ERR_PTR(-ENOMEM);
 
-	nval = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
-	if (nval < 0) {
+	ret = fwnode_property_read_u16_array(fwnode, "svid", val, nval);
+	if (ret < 0) {
 		kfree(val);
-		return ERR_PTR(nval);
+		return ERR_PTR(ret);
 	}
 
 	for (i = 0; i < nval; i++) {
-- 
2.29.2

