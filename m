Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327F440BA65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhINViH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbhINVh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:37:56 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC7C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:36:39 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id w9so601627qvs.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYT43AQgWkXWw9PkZN5kpZUGD9/3+eOTi7mNOSzM89U=;
        b=IdyiQpCpSlX05iDj4TDDswyyQwy3Ko7uev0BLGA0YL+ZKgzsrWzcylhJZ+6FUFCcuA
         yLWXY940XkeV2te/Lu2mOD/JCgSBty0SytQrjnP+IcZwoHXStlqZLzf+yCdJwRIG4mR6
         GBrBFcIUYNLrW8Wt3VGezoNBGrXoSnJRlNwKYQtL/IlMee4yU0D1Kv7YqHa8oOHWkIjv
         8m0C7YYHgX1xAxsX5FW6nLycaL7HUk/av/2tcUzQ+LIVc2/9I6eeS7KI4d+r7dbr9653
         EHBSdKJ9SqmeG581RBylOwHyX+NwwmUg0js/N9uPD81kyhx8q9kfhr12jWsAICRa+EvY
         aKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYT43AQgWkXWw9PkZN5kpZUGD9/3+eOTi7mNOSzM89U=;
        b=v3XMSh894qAgqvY2cRv4wPUE6v0+WV6mpaTykmuJ9qG9PfMUGkyaWlSaKKnBxey/j0
         EC/hcBoPxanS4K1pw2dwDMZgSOEWe+sq7HxXr0flpEgzkEySRf3DZKPCBpeGsASbSmrm
         yRYtKecYrDgIenZm2WJiTJUMZcdP46OQd5aPbGeKQy+H5Ni5+6jWVrzBV0wIwoeHfwOJ
         ounOfMJQsGt0Zzh81g3GcZ9uhRBreGnn/QzKX4yERL4MRfumE3bKu//id0sTn2hBE1+K
         b602GbLHuyHU7K2oPotVSJkP/87y8RKdrQTc+jVsDJo8eQ3c+HagMpLr6g4QUvB3mhJX
         9cUQ==
X-Gm-Message-State: AOAM531vlCBezyG5uI5HegQ3f9N5N7FqLc+zJw+Qgcgk4U27E/5nKCR3
        y0k/2FyDQj8JAmr0GoKZH9A=
X-Google-Smtp-Source: ABdhPJzpz7XV+yBcY5vgeLriCCYzEfZt9KOkoP0JcRfhwDWYH7QwH6mt6xvlSAySwJbXQL775ULqQg==
X-Received: by 2002:a0c:ab4e:: with SMTP id i14mr7743350qvb.28.1631655398247;
        Tue, 14 Sep 2021 14:36:38 -0700 (PDT)
Received: from localhost.localdomain ([191.84.239.65])
        by smtp.gmail.com with ESMTPSA id o7sm6716611qtw.87.2021.09.14.14.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:36:37 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 3/8] staging: vchiq_arm: remove unnecessary space in cast
Date:   Tue, 14 Sep 2021 18:35:30 -0300
Message-Id: <20210914213532.396654-3-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914213532.396654-1-gascoar@gmail.com>
References: <20210914213532.396654-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by checkpatch.pl, no space is necessary after a cast.
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 435f1bd68ba3..f8b3997125e4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -337,7 +337,7 @@ create_pagelist(char *buf, char __user *ubuf,
 		down(&g_free_fragments_mutex);
 		fragments = g_free_fragments;
 		WARN_ON(!fragments);
-		g_free_fragments = *(char **) g_free_fragments;
+		g_free_fragments = *(char **)g_free_fragments;
 		up(&g_free_fragments_mutex);
 		pagelist->type = PAGELIST_READ_WITH_FRAGMENTS +
 			(fragments - g_fragments_base) / g_fragments_size;
-- 
2.33.0

