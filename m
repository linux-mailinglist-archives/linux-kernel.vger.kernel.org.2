Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB6B34AB39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhCZPOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbhCZPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:14:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D9BC0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:14:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id ce10so8946121ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNBOvxce4K4wBx+3sqJnAcmfi681Xs2rjZl0yu+GJDk=;
        b=djyYbpuAilDLPjvYIPPbNxtcKD3imP/sqI2p4Bi/GMmciAYyKGLq4Uulj25hzPahlk
         bScPDwt0ntdlwQmVqsWdwjxr367iZsgPFOq/LABi9qYTlOiMJfk7bb1VgiAbs0CqA4ym
         jWSaE6aBJT/CwZHxhn7fiBYdfrhYXyXYymEzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNBOvxce4K4wBx+3sqJnAcmfi681Xs2rjZl0yu+GJDk=;
        b=FAztFIWcZx0JdqkBG1GNennznQmAm7JI0NuSn8k3AmPTqebymnfpEo8kD8Zp5KP6gx
         5HC2sp7VKB1/dBuVPbS85ioQWUQGGiJVYtSWErQeAsaNPqllevS6Kwexxdvk6EIg4J5X
         1k7RQA95s8uIfnBVEguOwg5zWRVB0c3thg5z7dKo8GOC20rGrwaU1PSdD/E2JbGBfXPf
         Eozp5HYJa5wMH9q+YyKv0Qh/jy/puBQZ5zGMmEbKawPn3GxyRfzXcd+jGBsEDmTq1rdX
         Hxa6FWr7388+4ZLGLU69R1C/liww6O/RqmeBFL5Q5P0sXYCBY0qvLcWxIBtpecmPrmVm
         DAgw==
X-Gm-Message-State: AOAM532U9dpPkduUeAluZ5+wdl3IkstfeX8KoJl/GnPxbzuSrLsJhEpj
        yFKc4r8PI0CwJDN3/zc9Rjn7sQ==
X-Google-Smtp-Source: ABdhPJxJFPSx2SKt4DYzQM5kO4GUOXsis0kqhIQJF43uABZ8E/rPvRLdlx4uQoFccqGKHeEFkiQJqw==
X-Received: by 2002:a17:906:2b46:: with SMTP id b6mr15752493ejg.521.1616771657468;
        Fri, 26 Mar 2021 08:14:17 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id g7sm3967626ejw.51.2021.03.26.08.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:14:16 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: drop pointless nul-termination in debugfs_read_file_bool()
Date:   Fri, 26 Mar 2021 16:14:11 +0100
Message-Id: <20210326151411.732220-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple_read_from_buffer() doesn't care about any bytes in the buffer
beyond "available". Making the buffer nul-terminated is therefore
completely pointless.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 fs/debugfs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 686e0ad28788..9979d981e9be 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -773,7 +773,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_atomic_t);
 ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 			       size_t count, loff_t *ppos)
 {
-	char buf[3];
+	char buf[2];
 	bool val;
 	int r;
 	struct dentry *dentry = F_DENTRY(file);
@@ -789,7 +789,6 @@ ssize_t debugfs_read_file_bool(struct file *file, char __user *user_buf,
 	else
 		buf[0] = 'N';
 	buf[1] = '\n';
-	buf[2] = 0x00;
 	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
 }
 EXPORT_SYMBOL_GPL(debugfs_read_file_bool);
-- 
2.29.2

