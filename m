Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731D532FAD2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 14:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhCFNVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 08:21:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbhCFNVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 08:21:31 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E0C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 05:21:31 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id t9so720915pjl.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DiLJEzUYSjWKZRnQ/OSV4uC9BkvYewFcPZAfwJV5do8=;
        b=HC2zKGaD0vgmeuBKAIYl+wbNGOJi195p/L7QPwuVy8CecnSkmy6GQdZXq3nwzlB1iA
         cv+1CyFlI4dlwRb3xW/YbRXIyaW72Z766k7SLuAPlTqc7A2E8zNYy0hMonjkpMLJg3F8
         wFW8uNgR0AF8ivk9CkYSlnnvgMaZwSOnzzXrSgaIxwnzSD6oDVIFH8jdI6uJaRQzcRBa
         7K3m6czo8vDZCGcUWaebrISHCmjjTqVCtCF12Y7kLsQiedJ/7xi32lAMWErFb4O3VWKR
         g/wZrEmwadfFXUctYUo7MJiYyV0wWFescqi+plNlJ2OVCKsKOs1FTc66eN3rzPUIP6zP
         wwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DiLJEzUYSjWKZRnQ/OSV4uC9BkvYewFcPZAfwJV5do8=;
        b=nX3EpOSZG695byr2AuXbeyp2R8NRyMzIT46jD5ztRf/g/0q3SsYL7mPmabe3s8y/+S
         ZV+TAmfAIvpQyj+jmaNTQcMznUvrKqQ2EMUi3W5iSDN5yVlQRPLGndgU+0O0HN04tgbc
         j8MLlmNg9vMr5wdOKPNY5ZAOxQpTFgt094L6kwjDWrV9DO6m9WDOagkZ9CFCN56x3rWU
         wPNbj8ThU9PPaGOvjvkMf5Q9rRNK9omSYbENiZlZrKSEudFKFyeUfiMunw1b/fbf8fT+
         eKeCIWMuquwZs2suiudiiVuNQ20nxIv90WSzWXg/lW+xhghhrzo1honrDsFM68WHQMoT
         4Kcg==
X-Gm-Message-State: AOAM531ojrlBiV1+mgiHdsAGplwHVwvGRNLLM2OXEZec9FAjeEpERSAY
        o7eoQie7EKIFbiy14NcoNFw=
X-Google-Smtp-Source: ABdhPJxxwGRiXYpPH6blU+U/8KAtaoiUkCxyTdALnXpIKbLVNyB/TOtIIvaFpPOKg2Qryp5oQU5biQ==
X-Received: by 2002:a17:90a:7c48:: with SMTP id e8mr15984704pjl.89.1615036890844;
        Sat, 06 Mar 2021 05:21:30 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id gw20sm5472827pjb.3.2021.03.06.05.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 05:21:30 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: [PATCH] mm:process_vm_access: remove duplicate include
Date:   Sat,  6 Mar 2021 05:21:22 -0800
Message-Id: <20210306132122.220431-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/compat.h' included in 'process_vm_access.c' is duplicated.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 mm/process_vm_access.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index f5fee9cf90f8..4bcc11958089 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -9,7 +9,6 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/sched.h>
-#include <linux/compat.h>
 #include <linux/sched/mm.h>
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
-- 
2.25.1

