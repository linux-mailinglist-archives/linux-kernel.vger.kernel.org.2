Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F3540BA67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbhINVi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbhINVi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:38:26 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EF4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:37:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id w78so1156356qkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QfLyoS/knpvzT0Bix+STgO/jKm0Ji7ZOPiwk0Sv8GjI=;
        b=f/1jHaZ/OdNGv/KlwhLXDys+VoYt45/YWHBclxzfIsx86kQOlrnyks7/zeN/m5VETJ
         THXTNgDk4mSFQ0ZfbP4zy/FsPKGwlDSN6rUGqaKnfoyodPwYK4TnGxesV/gzPuI8qFno
         iaLoquJEsKqfcUGFbjJna21//JyDGlnrHusyhLAKEPSxx1DnnjszFoMaLBYzOt63cUHM
         e0nqD2MD/YTgIESAWFczg5ProwoCKPeia1MuoBKa1inBY0p3iKs7W9CNI/96eHVv761X
         0in2oaPcHFPEY5Xxtp9iiNc/SqDE9/ghMoYlgCsCWsyx4zqn7J0ZRTH/GH3hDiM8vSL2
         cl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QfLyoS/knpvzT0Bix+STgO/jKm0Ji7ZOPiwk0Sv8GjI=;
        b=tWhc0yYT4hR8oF9xHr9z9uq+RCgDiGP8owhI3mzcBzhJiLzZ7HHmVJlwaC3PY4rRI6
         gImPLxqJWREJMhljiYcEW9kC9qtq4ftY6yXkwoHZfRkFC4a6PWy4Bi3l0xJ8zfFUgaph
         WZ5ba7gbSlpm8SGWQq+VfvpUZ4JDhoWwRxZOUOaDySzxIxcSLTuYAUWXNMkZhrh0ldIb
         tdrfnfS9qUnAwlCCInMmBFMAuT8x2j8QguYMbBfTN30KKHaVlnrmfVUh33tbs0sRMkJK
         dEqiCISYFzNhhIziqZ80+DYrxJ0nKviZgGYK2AJkeb8pCe6slavBcLnY/pbcnCBI/Zgq
         xlwA==
X-Gm-Message-State: AOAM532BdJLMR3q34oG52giR3di2Azmc2YfL/KgkygvldFqrus54yKou
        M7002ngwAFdPah58LwP7cyg=
X-Google-Smtp-Source: ABdhPJxNi2vbW83hYA3Zi/244geUsgsiYd4i4UGRDtj5nMracZU/FsbqE9W9oZeSvanWxkMVCJF/Rg==
X-Received: by 2002:a05:620a:290d:: with SMTP id m13mr7009333qkp.426.1631655427875;
        Tue, 14 Sep 2021 14:37:07 -0700 (PDT)
Received: from localhost.localdomain ([191.84.239.65])
        by smtp.gmail.com with ESMTPSA id o7sm6716611qtw.87.2021.09.14.14.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:37:07 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 5/8] staging: vchiq_arm: cleanup blank lines
Date:   Tue, 14 Sep 2021 18:35:34 -0300
Message-Id: <20210914213532.396654-5-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914213532.396654-1-gascoar@gmail.com>
References: <20210914213532.396654-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines after open braces and before close
braces.

Reported by checkpatch.pl
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index bb4035f2de65..ffacf1c7212b 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1218,7 +1218,6 @@ int vchiq_dump_platform_service_state(void *dump_context,
 struct vchiq_state *
 vchiq_get_state(void)
 {
-
 	if (!g_state.remote)
 		pr_err("%s: g_state.remote == NULL\n", __func__);
 	else if (g_state.remote->initialised != 1)
@@ -1339,7 +1338,6 @@ vchiq_arm_init_state(struct vchiq_state *state,
 
 		arm_state->state = state;
 		arm_state->first_connect = 0;
-
 	}
 }
 
-- 
2.33.0

