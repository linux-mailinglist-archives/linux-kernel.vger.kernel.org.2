Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99711389265
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354563AbhESPUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbhESPUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:20:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7791C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:19:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q6so7496418pjj.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=k8zjSgfqxLxlFthhLmpxkp9fckpuIPaxUqjese+DfO0=;
        b=wxXiEk5cfMSn+oebUrmAqIxaxe3uQoavSW8YeWQIpptNjA8WnDUG7VePoKAlmC0X3O
         ExXkJhERYYfGeg2YXpx0++bbi4QYlSbcGAfqPdxo9ev9zPukWzNm7rGwDT3nj1YTuGO0
         CyqCooNqCKOADjpBaIOmx92dSqsKRRtofCEKtqxEOufeykOaCXulsYTxLQdcCkH8rps3
         BFpJEDMY+8rXMy8gq/yV5F5w3DuA8FIlYu1h6gk+HoD9bgalLiAhkl9MiS4C00OwyGhm
         QmLN1FilocmSUpmomQIomX4Ihb9ZzgL98w9OcjN/zsoNcyBAItwWW0jeyqC+3cXiZzko
         9jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k8zjSgfqxLxlFthhLmpxkp9fckpuIPaxUqjese+DfO0=;
        b=RTkS3Zm6RyYcsDcAyh4/0wx7UC+MKXbqxkbihKtFOjBeQmDv5mpALqYhKT4mtY8RnY
         egXXfhl6s+HRjqVjAmm2/UZlZCl5ZYK7R5RBSCuRQ2y7cA7ZnA80DvobHV6D/ROX2Csn
         zGS+ChGep5khEkCLMGojIcePzwOhOptj4631pE4l9FWa1vZczXss/P0M/LuWg/c18wDd
         cUyG76DhlbXOmOJvOJQxuIk9eixRWB+7EQDhNCstboOZmGNIE5lsKcbntcQbAedC1mNM
         vYqVC6sydmxzxyP0HH8FL1+lt4VmuPm0xk30RrpUZFN7XsF9lmn93WLHTrzge2xKVj7g
         KmpA==
X-Gm-Message-State: AOAM530uHQ+2q8TYpLF44QS6kbwM04dfWAt4STuUplAJErMbBgp3Hb+R
        29BpANpEVqGR4cZIXQlQ7oY/
X-Google-Smtp-Source: ABdhPJy2iC8QxPrIsMllescdd+wISCdojKR/IHdc3CqJD/XKucc1n3UJ6p9YkgMXX9Ve2iyS5UhnHg==
X-Received: by 2002:a17:90a:a78d:: with SMTP id f13mr12007709pjq.161.1621437563291;
        Wed, 19 May 2021 08:19:23 -0700 (PDT)
Received: from localhost.localdomain ([2402:4000:11ca:dcec:9f88:85c9:3532:e27b])
        by smtp.gmail.com with ESMTPSA id k1sm8804547pfa.30.2021.05.19.08.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:19:23 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc:     greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
Subject: [PATCH] Staging: greybus: fix open parenthesis issue in gbphy.c
Date:   Wed, 19 May 2021 20:48:51 +0530
Message-Id: <20210519151851.26006-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fix "Alignment should match open parenthesis" checkpatch error.

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

