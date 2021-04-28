Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57BD236D023
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbhD1BBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbhD1BBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:01:43 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C011C061761
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 18:00:58 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id n184so35473611oia.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 18:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8wdUGizdOQkeU53ObcRJpkgfm/WRlYlaa9gy40KNWEs=;
        b=tgM/P7dlU+MABRZmDg24Pr9Y0nyr9ylWPpMTaBBrVfn1uiqDZAY0+xsUTUVXR6K29W
         nkiPTejP/b3L023WME2dvshrUq9xN/cHJBwAcqrJKqAPm9MrfZtSPRwqOhmlgg2/4err
         aeVM0mb+srsvK9OfKSBMXBK17ffIFIZ5OecSWmHl+8izzdNEOqcb070kJ5f9acItyp3M
         FEBoQcuzNrlKlzbvaHMcyQ9ffHU2ZlIZ2NgN/wt6D2WMYA3q9d2LA2NcI/hU79o/Vyb6
         n2eNBkzaWNUxHzUfhVyrt8cxRxTgSBvv9A6Ka/2K9Q0Phig5PfNt5pqY5iL3ib4KA1JN
         hREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8wdUGizdOQkeU53ObcRJpkgfm/WRlYlaa9gy40KNWEs=;
        b=Es4HYlzlHbh1sXbyrfLyj0bkHwvGTbt0JhVpiccmtDuwMXEELI7s1kgsJ07wTCq2YU
         AbM7ishkTM1EmObzu7wnv7Yc1OaCjb8tjAA8VBBBqMvrC2iEhIDOApbp+nWOhT9HN5Hd
         CKxbf18GE/+GOIkALaoOYM9HzKl2nrc0DSM7eQmBio0gm/HY14YKfzejB4HZV61qAePy
         qBUVksXacYYej+7oYgc0VPC42f8gnapzC5UJC3NVeVCJBJlAwYE9nMktywxVpJcCNHwr
         BXMgoxTY71pOB9ttCyd1yAzT8XsgqwVqWpzI8xV3yqi3lHTPSSuv2LvO5u2GACa8AsPr
         nl3w==
X-Gm-Message-State: AOAM531V4f5RNNT23o4o+R/kM6NcZmoN2cTBw636d2205QkwGgjt1g0u
        t6djH5+Q2F36nYmzNsrGffA=
X-Google-Smtp-Source: ABdhPJwnCKdPjQzaF38chMqE3EcWuFLbZt/w5kbRQT/JNvWCO51eYDFt8rvv5PnFObC7bIHSNM7Ngg==
X-Received: by 2002:aca:c414:: with SMTP id u20mr2756625oif.59.1619571658048;
        Tue, 27 Apr 2021 18:00:58 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id 34sm339004otf.38.2021.04.27.18.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 18:00:57 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 2/2] dyndbg: drop uninformative vpr_info
Date:   Tue, 27 Apr 2021 19:00:31 -0600
Message-Id: <20210428010031.571623-3-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210428010031.571623-1-jim.cromie@gmail.com>
References: <20210428010031.571623-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a vpr_info which I added in 2012, when I knew even less than now.
In 2019, a simpler pr_fmt stripped it of context, and any remaining value.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 613293896e47..b260d8218628 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -922,7 +922,6 @@ static const struct seq_operations ddebug_proc_seqops = {
 
 static int ddebug_proc_open(struct inode *inode, struct file *file)
 {
-	vpr_info("called\n");
 	return seq_open_private(file, &ddebug_proc_seqops,
 				sizeof(struct ddebug_iter));
 }
-- 
2.30.2

