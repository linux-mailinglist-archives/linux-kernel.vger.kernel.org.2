Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433EB38924D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhESPNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhESPNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:13:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED82C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:12:11 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id gf3so500202pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=p1U+oAmLN15Il7adctUFj5XirLGOy/razNk7lJyJFbo=;
        b=fDqCDfJ54DtEaGdhd7sYWeGzt4g5NM1DIHv1VGG6R9KY3pCiA1TAMdlKwjMhGrUW2N
         qOPoXyUogAHhL6SxtjlanPeoWbzotuyDUU3DpwdBpor7gvyw8Kj4E6nK2h2nP29tGEua
         vM0ijpVrIhjmzHxQVq6+6a4jxUKihNrLATb/gkTaJubJwhP45QA8jxYHTQfU2lxtVxZ4
         oGp4y/zam6vB7FXyyOyM+ce6FzpeUA7S46S9VDMJpUL4viM/xz58Hk5Ib/hygwTXc1mW
         +oHmWmTbMIC2mHrZIdV4/eWvP+zb4gJi/vvLf84f40r2TOog30aKjvCgNVU54Dr3VYHb
         Xcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p1U+oAmLN15Il7adctUFj5XirLGOy/razNk7lJyJFbo=;
        b=pSL9ArESs5uidFmVVqxojPkQ1oZM4IPJa/SojRVFiVHBfmR6Xj/xHKMQEi0Pu6JxZy
         /k02Z2GQ0a9iLBccSKgACr8VYofb8OP5Ro5o4fh7kuF6rMFqqwy9Lu8mNTb0rBhzVqvp
         693GG/DmkWVtiuh1U0unVUSBwMRp7Pb/16JbM/VlNpNeMtGZQVaAEyz9mFIaAOqz1g7K
         WIasXfV4WeJGo0RkWb0U/JAGGMBiq3fAlOplT51ZsLwH+lxeC8xTwtuDXJZyeXbamPOu
         V7GtxbCdLus7yfa81WoADuldHdSxpzd83Nl0BhrVLXjJymRUvzKpZpBeU3aerpnaZdbl
         pjxw==
X-Gm-Message-State: AOAM533XpxWUh90YcwSCUSpwFq4Oq5+u2SyHEib7ddOXEW4lGgrpBM4i
        v+QwdmswaKRffFkORLp7mQCm
X-Google-Smtp-Source: ABdhPJwWWRjTit2FSgkPlyWC4e1fX4x3syhQE7l//ZKhD0H6Ai90FQWeppLVuJOiu5iuWP7Lfp15rQ==
X-Received: by 2002:a17:90a:d24f:: with SMTP id o15mr11834852pjw.83.1621437130579;
        Wed, 19 May 2021 08:12:10 -0700 (PDT)
Received: from localhost.localdomain ([2402:4000:11ca:dcec:9f88:85c9:3532:e27b])
        by smtp.gmail.com with ESMTPSA id c195sm6414618pfb.144.2021.05.19.08.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:12:10 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     ash15.sulaiman@gmil.com, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: greybus: fix open parenthesis issue in gbphy.c
Date:   Wed, 19 May 2021 20:41:51 +0530
Message-Id: <20210519151151.25667-1-asha.16@itfac.mrt.ac.lk>
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

