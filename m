Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78833EBF1B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 02:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhHNAvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 20:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbhHNAvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 20:51:12 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72ACC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:50:44 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w14so17751180pjh.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 17:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2usMwN71Id/jafU+KaKLsXArdoasRYQFTH+/hN9aT/E=;
        b=cScxCDhPffNg8QIYW+mVRO3aeSrcflrLVe/dT4s0ylRVztfiOpz0MlhpmISnkA3oFE
         MJSzrffWJNUiaD6o63ulgbEOq81YRb/74ERVPnUf/VaGUaa/DNUMdsjkHRJweO3Vuxdr
         RPhYc8obp/E//eYzEFgUdHcXnpxtrsaLPHGTWrrGT1PBlLYSo+lrgu9/POdm5Ymkhxde
         6u+qHx0YdB1s0yzf1AfodzIGhS0l405W5z//DmtEEIn9KzA3NLl4NoN3IwSCJXaMrjEk
         BG4PruT8dkBFgTS4UcHVC71wHUUh7bv7FvURCNmuDsaOfGn1F/5oOMZZE8gbPwWTuRCH
         HXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2usMwN71Id/jafU+KaKLsXArdoasRYQFTH+/hN9aT/E=;
        b=mSiRln+uk2nHw3GaepsWv7O1uCLUCHCQNaplO9hes/lrnqzJZO132H/3lT3nQf43/i
         Ta9uANA4EWM4N34IHsPeXYmdeaA2RD1ObGtED21i5JY7vwiT8HWyoV0tgnxQP1gNt8B+
         v5Fcb2xxIpEJccXWqoDsmRud9v2tDCoF4BImshrKEbgG63t/yWqIo1KBoLuh+kvScAMz
         fZqr0z4/uJZtK5x6d6+oOe+MJ+3mvtZs3fJWazcO29AucZtGpEGKEUbFW612xY6tm4bj
         M6s8OTaq5eNujTrHT76TociV4sO86jhEdqLzImOzKZCNtnY6mqND5DOoeA0LDqlzOPFx
         ymXg==
X-Gm-Message-State: AOAM533KuN3RVRNVKO0v5np0jkfwV3YzIzCmGScujFuGP1ArR2flaJMp
        Tj7Tak+OgyNhFwJ9+QRr76U=
X-Google-Smtp-Source: ABdhPJzCR3+05oXoJr5Nw3UxqNvhNrtNj//NluhADYbj1S1KYJUi9ep199tfjX5QFOHzF7JvCYbB7A==
X-Received: by 2002:a05:6a00:18a3:b029:3dd:8ade:9b8c with SMTP id x35-20020a056a0018a3b02903dd8ade9b8cmr5001592pfh.63.1628902244434;
        Fri, 13 Aug 2021 17:50:44 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id b17sm3872780pgl.61.2021.08.13.17.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 17:50:43 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] tty: replace in_irq() with in_hardirq()
Date:   Sat, 14 Aug 2021 08:50:33 +0800
Message-Id: <20210814005033.2381-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the obsolete and ambiguos macro in_irq() with new
macro in_hardirq().

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 drivers/tty/sysrq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 6628792431dc..c911196ac893 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -258,7 +258,7 @@ static void sysrq_handle_showallcpus(int key)
 	if (!trigger_all_cpu_backtrace()) {
 		struct pt_regs *regs = NULL;
 
-		if (in_irq())
+		if (in_hardirq())
 			regs = get_irq_regs();
 		if (regs) {
 			pr_info("CPU%d:\n", smp_processor_id());
@@ -280,7 +280,7 @@ static void sysrq_handle_showregs(int key)
 {
 	struct pt_regs *regs = NULL;
 
-	if (in_irq())
+	if (in_hardirq())
 		regs = get_irq_regs();
 	if (regs)
 		show_regs(regs);
-- 
2.30.2

