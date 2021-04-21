Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031C9367413
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 22:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhDUURS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 16:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbhDUURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 16:17:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4B1C06138A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 13:16:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sd23so56694350ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 13:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivDrmLJQ78MRoNxDq6lpDH6wyRibjzDPlh4Bfq0I76g=;
        b=aZNQaP9Nt8mcyewR1rhQdrQsUpCmDSag+YgDnubsGHHFQBM4/YFVPI6bFVgVGn8TBS
         QM53rSV14uzrOPWWWNkncUX7QiiKC1Lj4+ZGwZpJxrZ/cdi8dX//yUdmZIiK1ZN497t9
         yXqcul3Q1SIiyro2nVViotBK+X4EOeSGOfKWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ivDrmLJQ78MRoNxDq6lpDH6wyRibjzDPlh4Bfq0I76g=;
        b=A4qvDZoPOHtS94IofZUUciDLf8/R8K27k73SqDDZUxs2SWpMPF1lUlEQAswwzZsEd7
         MoL1xrpHitISMEvbPWoyPSwcSVmC/AlNU2loJTlFDtg0aVCyk6Bzda4Ylk7VAPLo8Tfq
         hrXiMkLAOcYp5pMl8RTMc8g+oNCrKAtY3lh3pGstCZAFP+sW8cwn3ErtZg2pW44+l/Vl
         phPB8nppOnm5+wc+56tKq2eNZeol8SfmHt7+jSirJJ9AhxdDYs6W7EnFgyS65cpkYOlH
         xKpVuiZljXqFPXaNqwwyi6Qr0c7g/n0TocPXxS1LY8718cwlKc2CcBopwSpIq7vez3ZC
         XbPw==
X-Gm-Message-State: AOAM5317A5yN1bOme/OhE6s9L8zN9zgMyPbOfBLjUlYr+i+8yuCQkkcV
        y54GVXPvX4d58josXbVXgnmpWUCP6RCP4Vsna5Q=
X-Google-Smtp-Source: ABdhPJzttZUmAioz/rDZIfVjdKdCfclwYa/Lkfbgwz6n9uxqccMtaO6hxzGpMyecZ3o1yZBPtAHz6A==
X-Received: by 2002:a17:906:aecd:: with SMTP id me13mr34886896ejb.324.1619036202576;
        Wed, 21 Apr 2021 13:16:42 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id u19sm348825edy.23.2021.04.21.13.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 13:16:42 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: atkbd - simplify atkbd_show_force_release()
Date:   Wed, 21 Apr 2021 22:16:39 +0200
Message-Id: <20210421201639.1541945-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can just include the newline in the format string, and scnprintf()
guarantees nul-termination. These days, sysfs_emit() is
preferred in sysfs ->show methods, so switch to that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/input/keyboard/atkbd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index edc613efc158..b146a3ec631a 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1492,13 +1492,8 @@ static ssize_t atkbd_set_extra(struct atkbd *atkbd, const char *buf, size_t coun
 
 static ssize_t atkbd_show_force_release(struct atkbd *atkbd, char *buf)
 {
-	size_t len = scnprintf(buf, PAGE_SIZE - 1, "%*pbl",
-			       ATKBD_KEYMAP_SIZE, atkbd->force_release_mask);
-
-	buf[len++] = '\n';
-	buf[len] = '\0';
-
-	return len;
+	return sysfs_emit(buf, "%*pbl\n",
+			  ATKBD_KEYMAP_SIZE, atkbd->force_release_mask);
 }
 
 static ssize_t atkbd_set_force_release(struct atkbd *atkbd,
-- 
2.29.2

