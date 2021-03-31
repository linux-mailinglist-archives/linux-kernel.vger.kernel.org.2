Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467E634FD4D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbhCaJmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234941AbhCaJlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:41:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6CCC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:13 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id w3so29114569ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIwg6fry+Umqo+Of4e5vr2qOPugGJzkkuRXJAWKwcs8=;
        b=LnDias1Jrm476BZXUhqFrqUw+jR4kzh0BITGbU7vsBbI9wNSzW5wXQA6SUQv98ZVLu
         oxRV/n7Ol+wfkx35GtIwA7tpyBESL0/3o42x7U58H3n0VdOUNwxIe33yPrPPR7uNqpB7
         vj08hzOITknwFAWtCJRBFkQ6T7aiWP81LWS6R5ao29S96Lq9D7276eictPHx7u0MTL2R
         TODZK4q55PhLz1YkVxK3Tj9BUA3PUlKRIMPhtE2g8zBK+DEtUaIcn+d+LhYnu2864m7a
         TPQwAp5kl25PIAoi6CxIBzO53ZTn28tqnZQXTwwD0akHpwDx3E5vEzHnmnK0VEpdXn2Y
         7kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIwg6fry+Umqo+Of4e5vr2qOPugGJzkkuRXJAWKwcs8=;
        b=A0Hrw5P6ALpOw0fit0tpkhxa8i9MQbU/95wSPOKlS+eOIz4atSYCWNUWBNgSJ+rDrZ
         R7gf428R4xy9pi1cyGyUcGFUqqudkdjrupqN/FIu0sPi7wYgQmN7gQ52adN7w3p7aOqx
         O3/N+RC65Ph+Yp0beNSXL+R3KpbOY+TZ1BvV0UjRDJnam3GKHMjW6ujyE1yXqke5j09C
         NXUBA/pUoZP6ztv9qNIlvk6NIyTE/Cl0PD4gRWpNrUNPhJp/NZ0Y/4GaEiI1ixdAXBsD
         wuzWd0oE58wf6D/fGXiczZzTVFr5M/ZssiBVB4DLMYEfjEb2jksX3hjpO4Y6EPbsGD71
         GXcw==
X-Gm-Message-State: AOAM531gVc6cvg9QfJ7eiTGPm2ZvmMyBIneBP7CSevJOgMu+5OcnWQeQ
        95Brvl5aPJnQaNa0wvUx/fw=
X-Google-Smtp-Source: ABdhPJzNOhMRAlA6+jn0HJT9bO1TjK3UQqzfs+BEuaO/7OVy0zQooaugRIkY9C8BFjLReoepNA56fQ==
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr2597650ejt.216.1617183672320;
        Wed, 31 Mar 2021 02:41:12 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id gn3sm829140ejc.2.2021.03.31.02.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:41:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 32/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in os_dep/mlme_linux.c
Date:   Wed, 31 Mar 2021 11:40:00 +0200
Message-Id: <5653acfb5c93ae5c0dc0ef47434603db5a291cf3.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index ba4d3789a41e..bda0c34f2086 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -145,11 +145,11 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	u8 *buff, *p, i;
 	union iwreq_data wrqu;
 
-	RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("+rtw_report_sec_ie, authmode =%d\n", authmode));
+	pr_info("%s+%s, authmode =%d\n", DRIVER_PREFIX, __func__, authmode);
 
 	buff = NULL;
 	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
-		RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("rtw_report_sec_ie, authmode =%d\n", authmode));
+		pr_info("%s %s, authmode =%d\n", DRIVER_PREFIX, __func__, authmode);
 
 		buff = rtw_zmalloc(IW_CUSTOM_MAX);
 		if (NULL == buff) {
-- 
2.20.1

