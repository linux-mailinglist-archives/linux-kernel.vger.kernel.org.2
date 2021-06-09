Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0303A1191
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhFIKx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbhFIKxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:53:02 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D1C061760;
        Wed,  9 Jun 2021 03:50:51 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 11so12304241plk.12;
        Wed, 09 Jun 2021 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uhhoFhnqfuRXBw6ejRCmokUFjspHAB30X75CNsh+fk=;
        b=uOCm30htSg4dyosplWe7ui6YgaX4eGBdYE0IJ6ImKuH1xKLLCYZtw7HlqKB8SW1t20
         izEpRSZPr95bIaL12tb/GBNzHGWO0dLKr76koshyceJ3HldyWBixXFiTyTlXzlLj7A7W
         YX2UwPhemNaAkUG+f2pJopRZlSVR26gidbIqVl7X01lSDndUvzUPcJ1p8oKulM5FgtSr
         pvO8UIeNdsWBvvS87pCRtQgaUYzaDoUvUYBPdIPiSfcBfFt+V7BJgj8GBcMYbXh16YR7
         6guJPSiFh40qiZo+pnzRpVRmFMIzI6XTJ84WXWjwcOuErJRGs69hK7JgFTH//jtnd6vF
         CMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9uhhoFhnqfuRXBw6ejRCmokUFjspHAB30X75CNsh+fk=;
        b=TF2LGqz5WpPS0p5s9Nz/O6+jTSV03OnKE/TAt3LVbpESKY5dq4G8WPtRxq+MA4Ntr5
         0rbfWIyiWvel2UjyF1vFL3xvlA+KANMhPM1uG8kkOf+qqpYNFi0XeuLT1cLrJxvke4Dy
         I1tBe54dWtxCmjbhfCk9hoAzocOIyDtxrpDC7F4f43NUsaSq05ibWZ1WPj841RS+rF9e
         +kUGRcogngJ3uax9TRuKdD3XwIBT40MuYAMHyPqpwAa2XLVUKUpEcRn2r58ZK/rSIZ1X
         aoh6vRgWlIR0T+fPcSlV09ucRYTxblAEpgyE4yGlKm3EkdM8ADTmjXtiFCWB3PF/UB3M
         no2g==
X-Gm-Message-State: AOAM530TNdeSxow/arbt+KqFpIe4GVEAM3KBVfYzukohT6TlYfHN/IQz
        ZSMjbNkui3gO0mODE8czHu5jfw5kUMAKLg==
X-Google-Smtp-Source: ABdhPJz8boDKVBFz4qOFVqg6LfpTslZ93nb6v7ALMYXyaj0iZpDrzx0OR0FO09TNaziQ4wdn6u11Cg==
X-Received: by 2002:a17:90a:4e0b:: with SMTP id n11mr31294023pjh.155.1623235851070;
        Wed, 09 Jun 2021 03:50:51 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id u14sm18240126pjx.14.2021.06.09.03.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:50:50 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     mhiramat@kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-kernel@vger.kernel.org, guoren@kernel.org,
        linux-csky@vger.kernel.org
Subject: [PATCH 1/5] kprobes: Do not use local variable when creating debugfs file
Date:   Wed,  9 Jun 2021 19:50:15 +0900
Message-Id: <20210609105019.3626677-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210609105019.3626677-1-punitagrawal@gmail.com>
References: <20210609105019.3626677-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

debugfs_create_file() takes a pointer argument that can be used during
file operation callbacks (accessible via i_private in the inode
structure). An obvious requirement is for the pointer to refer to
valid memory when used.

When creating the debugfs file to dynamically enable / disable
kprobes, a pointer to local variable is passed to
debugfs_create_file(); which will go out of scope when the init
function returns. The reason this hasn't triggered random memory
corruption is because the pointer is not accessed during the debugfs
file callbacks.

Fix the incorrect (and unnecessary) usage of local variable during
debugfs_file_create() by passing NULL instead.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
---
 kernel/kprobes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08fdd7a6..fdb1ea2e963b 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2816,13 +2816,12 @@ static const struct file_operations fops_kp = {
 static int __init debugfs_kprobe_init(void)
 {
 	struct dentry *dir;
-	unsigned int value = 1;
 
 	dir = debugfs_create_dir("kprobes", NULL);
 
 	debugfs_create_file("list", 0400, dir, NULL, &kprobes_fops);
 
-	debugfs_create_file("enabled", 0600, dir, &value, &fops_kp);
+	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
 
 	debugfs_create_file("blacklist", 0400, dir, NULL,
 			    &kprobe_blacklist_fops);
-- 
2.30.2

