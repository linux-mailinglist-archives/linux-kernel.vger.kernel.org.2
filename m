Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C5733EDE2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhCQKBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCQKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:01:29 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDDCC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:01:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so2938993pjc.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ur+B5Cw9G34aMhGrZAWpyIFIOjPh9x7EMM4RGZ2Aiyc=;
        b=ZL0b837C4n8sVuDTUk7AEB59bhSj5i+4r6xgJ+EH9c0YIOMvxhQzMUiuCNqdErNHey
         1P1YCXSRJgM3XJGsGleFVMO3PuYUHxVOMYM1J5u6PjXuLPZeA7KRp0ggr93dYTj4hJcW
         8lB8sQxZqNCKTms5Fni9J9FYbxOMEk642nz2jm8Sva27DLSqS1AbGyF/VyPpOh1nbb/M
         GmMwi+EFkAXlywW/XdlLUrXY6tmFPG5yDKzxExLo8FSSc+0OQGVY6kLuInM6Cg60TwJp
         L5moGSYwPeNm5teE8TH2RU9LUADS6e+Yqh08hwO41eF1rxeBkOfIUcyZzMbtEszZtcM5
         f6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ur+B5Cw9G34aMhGrZAWpyIFIOjPh9x7EMM4RGZ2Aiyc=;
        b=PNR7sBALOcdGSHdHRzTIZ2UMpyng8sbH8XOUyYCE7LlcF3spKg2RDoSNHAI5XDRexI
         j+nH47/fhcu54aENuBs4qUIElktMNQqGApVTEs6GCY+4CHDYYtJgbQSI391dA14Z973C
         OaMg4Vbv4s8V3R6MZs83Nk0UA9wXliw7rfd96LC+1hL9/NOQorKraFlwhT+VrYqQn5N2
         eBbPNjhJytbqgp0wEQAw5/ksuE1U7Sdro0hCDfjwHnd5z3eqDIOVMTN+rCVo4+i2Qm00
         NlBLI5wJdfKRzSjpgkCz7aqYD9fyP/mkU/4TtMbQltM8ZoMWv2G/GAtvriWUTSV6llh/
         Hy/w==
X-Gm-Message-State: AOAM530vaRlRD2CMqeEnxbAcScdCHnSVtbNmV1K8xe9UllNl9JCJNwlY
        XQTrdbfAamjgEI6N2sULvm4=
X-Google-Smtp-Source: ABdhPJzo3WEdRkC/WEQYY5q1zoCY4VgbIC+vJ5yN+fzoovcYIHjEVHCAh80btvEbpex4YVwmxnNTRA==
X-Received: by 2002:a17:90a:e2cb:: with SMTP id fr11mr3917808pjb.2.1615975288635;
        Wed, 17 Mar 2021 03:01:28 -0700 (PDT)
Received: from DESKTOP-4V60UBS.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id p5sm18923817pfq.56.2021.03.17.03.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:01:28 -0700 (PDT)
From:   Xiaofeng Cao <cxfcosmos@gmail.com>
X-Google-Original-From: Xiaofeng Cao <caoxiaofeng@yulong.com>
To:     christian.brauner@ubuntu.com, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Xiaofeng Cao <caoxiaofeng@yulong.com>
Subject: [PATCH] kernel:user_namespace: Fix typo issue
Date:   Wed, 17 Mar 2021 18:01:29 +0800
Message-Id: <20210317100129.12440-1-caoxiaofeng@yulong.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change 'verifing' to 'verifying'
change 'certaint' to 'certain'
change 'approprpiate' to 'appropriate'

Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>
---
 kernel/user_namespace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index af612945a4d0..9aa66aa3e364 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -85,7 +85,7 @@ int create_user_ns(struct cred *new)
 	/*
 	 * Verify that we can not violate the policy of which files
 	 * may be accessed that is specified by the root directory,
-	 * by verifing that the root directory is at the root of the
+	 * by verifying that the root directory is at the root of the
 	 * mount namespace which allows all files to be accessed.
 	 */
 	ret = -EPERM;
@@ -959,7 +959,7 @@ static ssize_t map_write(struct file *file, const char __user *buf,
 			goto out;
 		ret = -EINVAL;
 	}
-	/* Be very certaint the new map actually exists */
+	/* Be very certain the new map actually exists */
 	if (new_map.nr_extents == 0)
 		goto out;
 
@@ -1110,7 +1110,7 @@ static bool new_idmap_permitted(const struct file *file,
 
 	/* Allow the specified ids if we have the appropriate capability
 	 * (CAP_SETUID or CAP_SETGID) over the parent user namespace.
-	 * And the opener of the id file also had the approprpiate capability.
+	 * And the opener of the id file also has the appropriate capability.
 	 */
 	if (ns_capable(ns->parent, cap_setid) &&
 	    file_ns_capable(file, ns->parent, cap_setid))
-- 
2.25.1

