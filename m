Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32F8389530
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhESSVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhESSVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:21:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCD1C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:19:56 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id e19so10491903pfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 11:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=PW4uVNBA3mRHR7tGnDQy6S2ZgHL0fGnS5upoxeLAFS4=;
        b=LAgQL50DJZ6I9DmMa17MmOp5E9BA+o10kFJrra9ikHEiPJnl7hP3KDysdkzJPCxdO7
         DNZHH5mef9Uw1FEq/YgnMwDZSXtkBpurEZy40MAUAE7qhAJnlJnsb7eP20CsDOCoFlnp
         ghGpALsJQ/OuaPCQTkNbDnZfxhiFVZ6pCJbVUb1ZNKi/KgrEPysh+ylJBmltbEFGwF2q
         K5ru/1URHJN6RxsMaNI+py45qPI0/J/fk7PTJA2ziWIDGsMD/cuuSgd+R7oMoxChfN6i
         o0ebko7Wmxl1fqf6WZFguy6+GD++rzI0D0k2kMz4GLL40VcRGZE9SAcjuFlgE4XUttmr
         mjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PW4uVNBA3mRHR7tGnDQy6S2ZgHL0fGnS5upoxeLAFS4=;
        b=oDySypSTD6np3AB4s4mWHzzCUCH1hLDSL1FeJ4Mvfq5u2GfWESoO8PzSvcyvhyCLhq
         eXKszWlNFnyb7LCwKtPd838UbyGsO+dv9Xkr6rBDGkcGQaMjtv0I+qJBYxIp8KPNZ6M1
         vXEiOKA/u3trrzylnTTJpxg5uvni5LOl8An11s4BeAC+L3St5zR78iPbkyf3R7u/mm7U
         CPMyz7Bz1rkn7omyph/IVEv6jHyjjl5kaLE62Wld2ManHsN56h4u3j70zjsE4z6kRh6J
         rOsHMgjFAyaxduJ1amX6mUA5w4CAXoaqAuKtNKboVl5ql1IGG0od7YOazHEeO1T6CtUL
         i4mQ==
X-Gm-Message-State: AOAM531wqEbOMITVS4mc4n0Qp9JO4FcClU1aXKPy8qbJQ8N23bw0uV6Y
        8SrEs08HPVca1m1aZOZQtc1v
X-Google-Smtp-Source: ABdhPJwXcf9yyVLYIrdBHqNyMJx+0WlY19enz6Kx/vmPzEP/3lG3o6ZWg/PgjWn9idU+8IRKMq/cXg==
X-Received: by 2002:a63:5218:: with SMTP id g24mr384869pgb.309.1621448395848;
        Wed, 19 May 2021 11:19:55 -0700 (PDT)
Received: from localhost.localdomain ([2402:4000:11c7:ee12:ddf7:464f:3770:cc69])
        by smtp.gmail.com with ESMTPSA id 205sm78211pfc.201.2021.05.19.11.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 11:19:55 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
Subject: [PATCH V2] Staging: greybus: fix open parenthesis error in gbphy.c
Date:   Wed, 19 May 2021 23:49:38 +0530
Message-Id: <20210519181938.30813-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix "Alignment should match open parenthesis" checkpatch error.

Signed-off-by: "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
---
 drivers/staging/greybus/gbphy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index 9fc5c47be9bd..13d319860da5 100644
--- a/drivers/staging/greybus/gbphy.c
+++ b/drivers/staging/greybus/gbphy.c
@@ -27,7 +27,7 @@ struct gbphy_host {
 static DEFINE_IDA(gbphy_id);
 
 static ssize_t protocol_id_show(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+				struct device_attribute *attr, char *buf)
 {
 	struct gbphy_device *gbphy_dev = to_gbphy_dev(dev);
 
@@ -221,7 +221,7 @@ void gb_gbphy_deregister_driver(struct gbphy_driver *driver)
 EXPORT_SYMBOL_GPL(gb_gbphy_deregister_driver);
 
 static struct gbphy_device *gb_gbphy_create_dev(struct gb_bundle *bundle,
-				struct greybus_descriptor_cport *cport_desc)
+						struct greybus_descriptor_cport *cport_desc)
 {
 	struct gbphy_device *gbphy_dev;
 	int retval;
-- 
2.17.1

