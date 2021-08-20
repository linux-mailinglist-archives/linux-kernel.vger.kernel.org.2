Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC433F29A1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 11:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbhHTJ4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 05:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237840AbhHTJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 05:56:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194CBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cm7YxYZOEUkP6Dnb1/JQxXIHjE0MtDK0+1YjijMBUBc=; b=i52s9L/z9eHow6roQ4zUj8WygW
        asPhat2AvBzFwX4cGIalNCBvuQxXz+MFaaXbK083qtz7QvvNGgurvuDflAbHmHTf048NeOSrR1ElR
        uduM75V9TTbfw/Wgcx60hTa07MmMmwSB4z7HuofMLpssC2d6Z3kPQKhgwLQA0Lw9TC1QCV0aIBxwQ
        1Kx3Zyu63kSM1UV1pFS8YMiHTJ6ydH0oXNTsDvHm7/fPqqUd+gEkI3X4NEP0Ig9dBTMOPw5ubyEey
        xkPIhauyvq9OE2YUXRZv9htomkAIZXLaUWGgxHJhNGOJR6oUQCodHa1UhC5HTxzb1ZoeB2QRB3WMs
        67hVoOjg==;
Received: from [2001:4bb8:188:1b1:43a3:4b88:ec18:d4de] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mH1EN-006Ks5-Ds; Fri, 20 Aug 2021 09:55:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: unexport get_{mm,task}_exe_file
Date:   Fri, 20 Aug 2021 11:54:30 +0200
Message-Id: <20210820095430.445242-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only used by core code and the tomoyo which can't be a module either.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/fork.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index af408d06e1fb7..dc8eb1300418a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1238,7 +1238,6 @@ struct file *get_mm_exe_file(struct mm_struct *mm)
 	rcu_read_unlock();
 	return exe_file;
 }
-EXPORT_SYMBOL(get_mm_exe_file);
 
 /**
  * get_task_exe_file - acquire a reference to the task's executable file
@@ -1261,7 +1260,6 @@ struct file *get_task_exe_file(struct task_struct *task)
 	task_unlock(task);
 	return exe_file;
 }
-EXPORT_SYMBOL(get_task_exe_file);
 
 /**
  * get_task_mm - acquire a reference to the task's mm
-- 
2.30.2

