Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FCF44F54B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 21:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhKMUom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 15:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKMUoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 15:44:39 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA5C061766
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:41:46 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y196so10537837wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Nov 2021 12:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znqfsEnlktjZeaYUl3uU6wdVUZvKPQCplrE2NccVU2E=;
        b=J4IY9fizfH5EC4xc3HLziLsEe0fMKuL+2kHqXiMI4vxUR98rLWlHUpF/yIpo8ea1bq
         U8XBxAZkeKCkCymVn8ciJqcdXo1+5r2jKuwz3EuzPFrbYZE22fNA96JLkMT5QppXAKdY
         fBt5MVpxlkRZXj1d4CIr7CBBet6hU42sGXOZqOhBqn0eWT8WvAJ8J3+TrW5O+KAja4pZ
         gA/eFphAWZtG3CF+rAX3Gk++NAc1+oFkj4X/enfdphpZY+Zy6L/i2bvuTnaLF7kMu/+y
         yLa35tvdIkqpSrGQt0yAtyuWhIVbOpHLMd+9dNL/r6Pmgzoy1tYULOUnnCFn/P+dYMXy
         qEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znqfsEnlktjZeaYUl3uU6wdVUZvKPQCplrE2NccVU2E=;
        b=47FvhtamCyewWt8C8IeoJA6bo+nxhFJl4fVwKwIXHyh4CxhzDMOw5XMyMJb4eyJ2B1
         SybLbBbQkoc110vVCWfoetL66GOwAgrtU4Dm+K6lKfV+1KvEKtrFhRyL1IwsSKHm8tA1
         he691lgxhsIF2mJtUbtPKn3edO2zGvm6RH+H8tT+9Rkd4QbveU1JGOyiChJL3OBsKfuh
         rgjFFGwLVtOONyAdcRc0jUWe62t28bVG/nhC+Z1RHZFL2BbD/CCxC4GgM8F15TVsUSNo
         hjq1uaBDq1OWDH6Ih+pzGaTv7OSfBPTZdIxGJg6lC9peF7JUNOt5On6BhflanOEyjWoD
         DtSg==
X-Gm-Message-State: AOAM532/HaOCQv0bjvpQZ1nVf6vXQ/+EGE6fUpWcqMMWYoW/yTsrZDJP
        AOemauOPI+/YDdBv1+djwrTXOB7xa10=
X-Google-Smtp-Source: ABdhPJyQxFHrqfKREVguc1TQr0R6psqjvP35yrvtLo7ZwWKjXq0/NLWYgjrO7fqjlRiwp0vBLQ1Ftg==
X-Received: by 2002:a05:600c:500b:: with SMTP id n11mr31195115wmr.38.1636836105430;
        Sat, 13 Nov 2021 12:41:45 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id a9sm9144289wrt.66.2021.11.13.12.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 12:41:45 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] device property: Check fwnode->secondary when finding properties
Date:   Sat, 13 Nov 2021 20:41:41 +0000
Message-Id: <20211113204141.520924-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fwnode_property_get_reference_args() searches for named properties
against a fwnode_handle, but these could instead be against the fwnode's
secondary. If the property isn't found against the primary, check the
secondary to see if it's there instead.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/base/property.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f1f35b48ab8b..7bac12b32fcb 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -478,8 +478,16 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
 				       unsigned int nargs, unsigned int index,
 				       struct fwnode_reference_args *args)
 {
-	return fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
-				  nargs, index, args);
+	int ret;
+
+	ret = fwnode_call_int_op(fwnode, get_reference_args, prop, nargs_prop,
+				 nargs, index, args);
+
+	if (ret < 0 && !IS_ERR_OR_NULL(fwnode->secondary))
+		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
+					 prop, nargs_prop, nargs, index, args);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
-- 
2.25.1

