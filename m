Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F33206B9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 19:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhBTSsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 13:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhBTSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 13:48:36 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD2CC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 10:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ixnnd1ZWFeoubfz6B3CnLph2u1awvuxZzltoZrXH3h0=; b=J5o4LtFhpr/Xl80nb54aAhmAPF
        qhHsvHPQcScr90rUtST77qgUbz9rE7W5hpdvqqSGf4U/Br6XIJVxMWgpbPijpXMJk6qKywfLjyRyQ
        R1BRIEyelIngarO0AwP9x3pkoaESWAaFZ+RbdVtwRmdIYTAwa+M2Fz6wcOVv7sCDwORE/jg3vQ0ZF
        VBiK1TELeARgZyW3aJFla7VZFtO/7GneDXnAeC4EmbfNoYVy87rDGofRvY8LLKLBZTDmjBy2glmmn
        2Am3mSZXlbmoiMKp5HLkGaOrLqNfjP/7ieYUJlww+ZIEsMbbOAno1xwSUnIAUZ9NGkuPLjbrFc9KS
        HvjcPqNw==;
Received: from [2601:1c0:6280:3f0::d05b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lDXIH-0001uG-En; Sat, 20 Feb 2021 18:47:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Pitre <nico@fluxnic.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        patches@armlinux.org.uk
Subject: [PATCH v4] arm: OABI compat: fix build when EPOLL is not enabled
Date:   Sat, 20 Feb 2021 10:47:48 -0800
Message-Id: <20210220184748.30647-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_EPOLL is not set/enabled, sys_oabi-compat.c has build
errors. Fix these by surrounding them with ifdef CONFIG_EPOLL/endif
and providing stubs for the "EPOLL is not set" case.

../arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_ctl':
../arch/arm/kernel/sys_oabi-compat.c:257:6: error: implicit declaration of function 'ep_op_has_event' [-Werror=implicit-function-declaration]
  257 |  if (ep_op_has_event(op) &&
      |      ^~~~~~~~~~~~~~~
../arch/arm/kernel/sys_oabi-compat.c:264:9: error: implicit declaration of function 'do_epoll_ctl'; did you mean 'sys_epoll_ctl'? [-Werror=implicit-function-declaration]
  264 |  return do_epoll_ctl(epfd, op, fd, &kernel, false);
      |         ^~~~~~~~~~~~

Fixes: c281634c8652 ("ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com> # from an lkp .config file
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: patches@armlinux.org.uk
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
KernelVersion: v5.11
I don't know what format is used for KernelVersion.
This patch applies to any Linux kernel v5.x and probably even older.

v2: use correct Fixes: tag (thanks, rmk)
v3: add patches@ to Cc: list
v4: add KernelVersion for Patch Daemon; add Acked-by from nico@)

 arch/arm/kernel/sys_oabi-compat.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- linux-next-20201214.orig/arch/arm/kernel/sys_oabi-compat.c
+++ linux-next-20201214/arch/arm/kernel/sys_oabi-compat.c
@@ -248,6 +248,7 @@ struct oabi_epoll_event {
 	__u64 data;
 } __attribute__ ((packed,aligned(4)));
 
+#ifdef CONFIG_EPOLL
 asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 				   struct oabi_epoll_event __user *event)
 {
@@ -298,6 +299,20 @@ asmlinkage long sys_oabi_epoll_wait(int
 	kfree(kbuf);
 	return err ? -EFAULT : ret;
 }
+#else
+asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
+				   struct oabi_epoll_event __user *event)
+{
+	return -EINVAL;
+}
+
+asmlinkage long sys_oabi_epoll_wait(int epfd,
+				    struct oabi_epoll_event __user *events,
+				    int maxevents, int timeout)
+{
+	return -EINVAL;
+}
+#endif
 
 struct oabi_sembuf {
 	unsigned short	sem_num;
