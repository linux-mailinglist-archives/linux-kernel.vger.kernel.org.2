Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60407319218
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 19:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhBKSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 13:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbhBKSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 13:00:05 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B3FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:59:24 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u15so3732318plf.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 09:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+om9eHtS9j/YdxgTsTfGj56DNm0I/KgrW6X/2Oi1Uis=;
        b=aMI0kNpZOLIKo69EZWvigH+ZrGg1sMA7p0WKReEGFGURdA7v7G8PLbzWpPmkmX6Bk5
         5UrLqs3i10MdHiIiaoe2kmn2v6pJ5YoH7wyGKxa9yJfA62/SQGOHq/0xmB4D0ijKjj7R
         F9bO7kgi5gR6xdgaYQg/cZKA+kvNFiCelyvEdayok2915LDzTzJQbMd0Ly5AaCwt9gBT
         n3r17efCwwpWYq93HCEil/9PoP7Km3Lfctz0TFZ3r56QD+obUSTTm1PZ9rRziQrDvfdy
         PKQ6dSdXRFNGgYNLK/K3zHNn+0yt/a4YM7Lc1UPYKW2F5XP8V9tffH3OKv7RByHSVAro
         dLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+om9eHtS9j/YdxgTsTfGj56DNm0I/KgrW6X/2Oi1Uis=;
        b=Q/D8VNeWjlvruRzE8/U3aBBDAAgqZNbZ8x+l1ahrDFtF64vAt+J4JBNP6MMDLAL2rb
         wvUjijFPiTLpydfBuVOtpLzqwRzCmP8rbBuXQa27JtL21wif5eUpObsd758msClIs2Sh
         1i304YQa4JBiY36jI3Z2YIpROk4W0jYLKRXO4DV33F9eAn06pMDvUU+WXIVgRdKl+0Zz
         EI1QweZ63fZCjbS6qZObSNLBJu48xK5CyhQmD4xcRIgeytk/XMsm6euxWs+o3zq8JfwX
         hWlAipsiAa3buK/7CA3XpiWr6w3oThL4V/Q8fcGUDrlyZjCdEwTZztio3PwU8wvzbp+H
         r2qQ==
X-Gm-Message-State: AOAM531OuCdNVDX1tKeqvQlT1iP1EsvSXV+LOWxFa2psbOO9VVM1b6PT
        SxK9B0rB9Wf8tzmYaPS412k=
X-Google-Smtp-Source: ABdhPJxrtP2fAwNHtKx0zlDJ5SHzwXPh1c6ZZeqKKHVEX5gLiJUxnBmmqlcHL/gYU2lWH6hotTjQOA==
X-Received: by 2002:a17:902:6b43:b029:df:fb48:aecf with SMTP id g3-20020a1709026b43b02900dffb48aecfmr8452570plt.67.1613066363755;
        Thu, 11 Feb 2021 09:59:23 -0800 (PST)
Received: from localhost ([2601:1c0:6c02:1d30:4920:87a0:85cd:f278])
        by smtp.gmail.com with ESMTPSA id c23sm6180015pfi.47.2021.02.11.09.59.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2021 09:59:23 -0800 (PST)
From:   Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     Adithya Chandrakasan <adithya.chandrakasan@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Staging: mm: util.c: checkpatch.pl coding style warning fix
Date:   Thu, 11 Feb 2021 09:59:14 -0800
Message-Id: <0c1ce6d55fb011f29b2c22134f59829402eba175.1613066176.git.adithya.chandrakasan@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <bce53689-4a6e-c3c3-a09c-6e946a577f61@redhat.com>
References: <bce53689-4a6e-c3c3-a09c-6e946a577f61@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FILE: mm/util.c:930:
checkpatch.pl scripts basic coding style issues as below
WARNING: Missing a blank line after declarations

Signed-off-by: Adithya Chandrakasan <adithya.chandrakasan@gmail.com>
---
 mm/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/util.c b/mm/util.c
index 8c9b7d1e7c49..60286876636d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -927,6 +927,7 @@ int get_cmdline(struct task_struct *task, char *buffer, int buflen)
 	unsigned int len;
 	struct mm_struct *mm = get_task_mm(task);
 	unsigned long arg_start, arg_end, env_start, env_end;
+
 	if (!mm)
 		goto out;
 	if (!mm->arg_end)
-- 
2.25.1

