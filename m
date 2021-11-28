Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C452A460B1C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 00:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359569AbhK1XaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 18:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhK1X2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 18:28:21 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1092DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 15:25:04 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id o13so32590949wrs.12
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 15:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NkR6Y2sLvs44kHr2zIEXdmLWltIilyN25oDz/JxEfU=;
        b=L7K6wiawXYXTuxydpOt7pxnXvwBLZodPddK2psMn0p0V6rMQB0mfybjcY4nvr2SnV+
         HC5LEai2AUiXaeFX3Zub9et+DaO3Gbnce2z/Kqfrl5N1KQLztMs4yz17VJfClBRTC0TA
         LjQ4/KFSUp5Qrm8x+MC2nxdTmH57MrSyZwizq5k6f5Y+02KJvkjjaktGHykwCZz5PN1v
         wOQREQ+j8VFJsfNs1PBeSWpIxRlfbH+YBrgfRraayoZXKZq8A/Z2r0VOnSMMkKxcXVjD
         gHpIcUeMKsaNI+Wg8iH+HYFGy0IPPGbgZrKFRsaBPbqZiPi1jsUmo+CZHWJY6iBufy2l
         K4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4NkR6Y2sLvs44kHr2zIEXdmLWltIilyN25oDz/JxEfU=;
        b=K/1qgnFdX6DwiZpVrUY3JEpqzAV6eDliha1v9I6AaBVX0xd8Slaa3dx8yeBaV/oVAC
         uTmHmxqi2UhhwamNY9j4F+0R94fdm+0bTzAiTjg2wsHXklFzACOBfNtY1ThTlDJhWy5q
         aWPEkW9lrbU89HFzwXJsEwDn6MJnWKVEkc7GHikQp/1joa0WyHf8KI/ZwXDs/wl/4C6j
         SYd1WF1nZneKBaHX+5M8a8I1+KX46MD0kRnpuP6kjwCqXhhj4JgihCkVLcYnkfDTg99l
         7t2Dt35ujNYsgQ01gBr8L56kNEdQPaIzPd6Yz//I+o0OhibSMsI5194OHu0Ee42wXUTS
         RBow==
X-Gm-Message-State: AOAM530HPL9BrT/hEXvHVYlFhK7Rh+w6wi3g3syd8QNbBY5PiefMwlQT
        30jaI632SaEFkR1OQVr245IIt+N/pxI=
X-Google-Smtp-Source: ABdhPJxvVgA+l5XOVRU+iXZYdYya9nusjSabdd9YjR7QQL4oozGY/JaqRxQbMD31iN12mw/8cRT8qQ==
X-Received: by 2002:a5d:6508:: with SMTP id x8mr29360194wru.388.1638141902541;
        Sun, 28 Nov 2021 15:25:02 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id r17sm14136936wmq.11.2021.11.28.15.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 15:25:01 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com, hdegoede@redhat.com
Subject: [PATCH v2] device property: Check fwnode->secondary when finding properties
Date:   Sun, 28 Nov 2021 23:24:55 +0000
Message-Id: <20211128232455.39332-1-djrscally@gmail.com>
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
Changes since v1: 

	- Added !IS_ERR_OR_NULL(fwnode) to the if guard to protect against
	null pointer dereference.

 drivers/base/property.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f1f35b48ab8b..11e3d6308eb0 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -478,8 +478,17 @@ int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
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
+	if (ret < 0 && !IS_ERR_OR_NULL(fwnode) &&
+	    !IS_ERR_OR_NULL(fwnode->secondary))
+		ret = fwnode_call_int_op(fwnode->secondary, get_reference_args,
+					 prop, nargs_prop, nargs, index, args);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_get_reference_args);
 
-- 
2.25.1

