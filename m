Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23711389253
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354322AbhESPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbhESPOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:14:37 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:13:16 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m190so9688340pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=p1U+oAmLN15Il7adctUFj5XirLGOy/razNk7lJyJFbo=;
        b=n40THdRfAoBafaZbp00vGauvtDhhN41cyBhmX8LROnMMA2m4ryRmfFtwciXVPn2wEG
         JZMzcViWQpO/rxkeJqvd/yRjxqy+ERr9O/Rinc84y8DQ4yeX3Mpue3T2IiUJT4nyMEEX
         x859Z7VW1AeD8g+3niJPNx353nqxBt7Iv6z+dMhi5MxWU/eo3vrCswTLPh4/WqI0ju6F
         ISRZzhrXQaFwphhLhD0KkRg6gOIC62kqWBCQ+FVHCkYnN4x7vY/JzqNO3dn7sws50CGx
         wXbhgI/tNTxNoTTev1Eici2LlWqZP+c40KOH248Az9A46p1UmMtRbKdLHkvaU4CTBOcD
         nZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p1U+oAmLN15Il7adctUFj5XirLGOy/razNk7lJyJFbo=;
        b=a7SWwgiRHsNkgRw7XM5kej04WB0JTp/nhBlE1WJHwutaX0Ms/ai7IS5dX1CDW6Lov2
         ayFKcBeD8lChOrKbDcU2OceWOPdV+hRKnNA/IoGLHnYoKVRt3p0Nlheo8okOUJ0pAC6N
         /C3kDKGgGnmjgTaAXAMq+TAQV3xY9kuMtpvkn3zIcKUoYJGXf+mYZPutf8x3k9RPwaNC
         ++tQFXqqTisf88Ms/wuEtSQcJBIMYArxf1KdPK6+8VqfwjsVPevSfkm+HCRgZTqpIFtM
         lOaz2RUOWHQkkKPIFKf64rZ31rBzOIj2wFCuDFHRXYE7BEU9jSe/240y7cRmpst5vT8J
         shag==
X-Gm-Message-State: AOAM531n8rP9wA3HCzEPuRDwfslyGYP8/UJ797xECTwW7+rQV8b7+Iwh
        d7dJEabXsqQUyJHAlPYK15RuZsU0RJaSRP5jfw==
X-Google-Smtp-Source: ABdhPJy/Myxcy7bbgNjO9/KwP0pk3uC5ShQibLxNRwLOs5F4vzS/w4fcBWkjdNPZmN3wbPescTZr+g==
X-Received: by 2002:a65:6a44:: with SMTP id o4mr11269699pgu.145.1621437196050;
        Wed, 19 May 2021 08:13:16 -0700 (PDT)
Received: from localhost.localdomain ([2402:4000:11ca:dcec:9f88:85c9:3532:e27b])
        by smtp.gmail.com with ESMTPSA id n23sm2408025pff.93.2021.05.19.08.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:13:15 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     ash15.sulaiman@gmail.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: greybus: fix open parenthesis issue in gbphy.c
Date:   Wed, 19 May 2021 20:42:58 +0530
Message-Id: <20210519151258.25845-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix "Alignment should match open parenthesis" checkpatch
 error.

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

