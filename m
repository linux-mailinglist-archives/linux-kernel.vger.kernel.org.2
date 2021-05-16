Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3DE381C52
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 05:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbhEPDuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 23:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbhEPDuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 23:50:05 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E04C061573
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 20:48:51 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so2743499otc.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 May 2021 20:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhSuvbBg5gouj0NE7hl4DXAk820cn3WTuep5FOuXDwc=;
        b=lkZxtWoEjjiosjTeDSf4x3x9LrI+RVU2xKtvHK+igcsoDCFKplXu+Ri92PWCej7FD2
         vLkJ3Uv0hjZGbAoShkD+zgDIbMM6Ylu9prE3RoStAEcHY94pzxo8+qgV0GMyXPgeW604
         jz//XMdatYIawZv5H1x90QQVFViruQBPcb82xLFVd71KzOQX8muETHUqmBCarZqOmBzK
         MSBkgRdS6mcMk++RwG0CgzKdWPWw9KEhAtlyjZOLEupuYNmLdR973mDPvY0sMucfnl5D
         Q9LoSqhw+tNqATp1edBIBhxAO4WGxWWLXbSubAuTKT2eZmbg6+Sz8OfzJYJvI6hhFHw6
         EBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OhSuvbBg5gouj0NE7hl4DXAk820cn3WTuep5FOuXDwc=;
        b=nSQW3nonCluQGonw1HfYulBveEe9gu+J1/7wautgbGMcED11Q7lapgsurWiuXY/sFc
         KNs6JbEozh6ad7LsWh4wF3bEL0Cx1DngzMfnLNagk6Di1fPUpHW0FY6FZi6Mou564BKU
         lDAyiVr29Kxh3Eq86Oj7yaVlBEUcZkOVPvrYvFbbgG+sxtMaVYkBGA5mdUqZEvs3Ln9q
         UZ6JPuYzQrxn4hWT4HJHRf8S4nZDNm8fsO+GOR2TeM27XXxC50VMmv2dGhrg5nQGcU6D
         xUiS+VzScR8gWrohGtjJZG02I1emw9wxqRnv7qwqTIChBodp4k6bTsHhTaVVzrM56hQw
         YtPg==
X-Gm-Message-State: AOAM531CTWorYCxlcrbsnirkMauvMVdBFwm7eVeqPSJ8cy81RZBisMyz
        ZqWe7qd4FVE++H3pCHFy2l9HTw==
X-Google-Smtp-Source: ABdhPJyvorLo/0yrCwQe4/dEA9gklJA0g2j0oBuvydQy1cGORFcBO748zV7AJg6c7yxn8J2BIank/w==
X-Received: by 2002:a9d:6255:: with SMTP id i21mr42041532otk.284.1621136930641;
        Sat, 15 May 2021 20:48:50 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u15sm613702ote.81.2021.05.15.20.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 20:48:50 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: mux: Fix copy-paste of the container_of
Date:   Sat, 15 May 2021 20:48:33 -0700
Message-Id: <20210516034833.621530-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the boilerplate code was copy pasted from the typec_switch and
retained the use of the switch's container_of macros. The two structs
are identical in this regard, so this change doesn't cause a functional
change today, but could possibly cause future issues.

Fixes: 3370db35193b ("usb: typec: Registering real device entries for the muxes")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/usb/typec/mux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/mux.c b/drivers/usb/typec/mux.c
index 8514bec7e1b8..e4467c4c3742 100644
--- a/drivers/usb/typec/mux.c
+++ b/drivers/usb/typec/mux.c
@@ -45,7 +45,7 @@ static void *typec_switch_match(struct fwnode_handle *fwnode, const char *id,
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				switch_fwnode_match);
 
-	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
+	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
 /**
@@ -87,7 +87,7 @@ EXPORT_SYMBOL_GPL(typec_switch_put);
 
 static void typec_switch_release(struct device *dev)
 {
-	kfree(to_typec_switch(dev));
+	kfree(to_typec_mux(dev));
 }
 
 static const struct device_type typec_switch_dev_type = {
@@ -239,7 +239,7 @@ static void *typec_mux_match(struct fwnode_handle *fwnode, const char *id,
 	dev = class_find_device(&typec_mux_class, NULL, fwnode,
 				mux_fwnode_match);
 
-	return dev ? to_typec_switch(dev) : ERR_PTR(-EPROBE_DEFER);
+	return dev ? to_typec_mux(dev) : ERR_PTR(-EPROBE_DEFER);
 }
 
 /**
-- 
2.29.2

