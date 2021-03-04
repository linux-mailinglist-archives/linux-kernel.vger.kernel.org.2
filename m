Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BCA32D386
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhCDMrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:47:47 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:52003 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231294AbhCDMrQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:47:16 -0500
Received: from localhost.localdomain (ip5f5aed34.dynamic.kabel-deutschland.de [95.90.237.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2E1AB20647918;
        Thu,  4 Mar 2021 13:46:34 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guohan Lu <lguohan@gmail.com>,
        Joe LeVeque <jolevequ@microsoft.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] kexec: Add kexec reboot string
Date:   Thu,  4 Mar 2021 13:46:26 +0100
Message-Id: <20210304124626.13927-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe LeVeque <jolevequ@microsoft.com>

The purpose is to notify the kernel module for fast reboot.

Upstream a patch from the SONiC network operating system [1].

[1]: https://github.com/Azure/sonic-linux-kernel/pull/46

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index a0b6780740c8..f04d04d1b855 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1165,7 +1165,7 @@ int kernel_kexec(void)
 #endif
 	{
 		kexec_in_progress = true;
-		kernel_restart_prepare(NULL);
+		kernel_restart_prepare("kexec reboot");
 		migrate_to_reboot_cpu();
 
 		/*
-- 
2.30.1

