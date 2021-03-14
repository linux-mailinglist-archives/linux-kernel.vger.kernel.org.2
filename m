Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C5533A7CE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 21:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhCNUSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbhCNUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 16:18:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD11C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 13:18:06 -0700 (PDT)
Received: from zn.tnic (p200300ec2f226300e8f2914ee59d30a8.dip0.t-ipconnect.de [IPv6:2003:ec:2f22:6300:e8f2:914e:e59d:30a8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D28F1EC0118;
        Sun, 14 Mar 2021 21:18:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615753084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=kqK+Mu2Ypm8wBbJ3qyhwX7QHCTfi8akC5xDaegGKBuM=;
        b=AKJCzcl6ks0j5qJEWz8bOsq0PVehAhZrRA0XRMkx9/fs2B4tzUDcX0oOW5pRAlkNKkjKuG
        v7bzd01+xykyIEuEPWLW9vyiDf+kJlqMHGEpVtLS+QvyvtcG+ulgIzenY37Y5S2A53UY0R
        dNTv721pa69sZQAiplYssjkjH3YLBgc=
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/mce/inject: Add IPID for injection too
Date:   Sun, 14 Mar 2021 21:18:06 +0100
Message-Id: <20210314201806.12798-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Add an injection file in order to specify IPID too when injecting an
error, for example, for using the machinery to decode MCEs from other
machines.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/inject.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 7b360731fc2d..4e86d97f9653 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -74,6 +74,7 @@ MCE_INJECT_SET(status);
 MCE_INJECT_SET(misc);
 MCE_INJECT_SET(addr);
 MCE_INJECT_SET(synd);
+MCE_INJECT_SET(ipid);
 
 #define MCE_INJECT_GET(reg)						\
 static int inj_##reg##_get(void *data, u64 *val)			\
@@ -88,11 +89,13 @@ MCE_INJECT_GET(status);
 MCE_INJECT_GET(misc);
 MCE_INJECT_GET(addr);
 MCE_INJECT_GET(synd);
+MCE_INJECT_GET(ipid);
 
 DEFINE_SIMPLE_ATTRIBUTE(status_fops, inj_status_get, inj_status_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(misc_fops, inj_misc_get, inj_misc_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(addr_fops, inj_addr_get, inj_addr_set, "%llx\n");
 DEFINE_SIMPLE_ATTRIBUTE(synd_fops, inj_synd_get, inj_synd_set, "%llx\n");
+DEFINE_SIMPLE_ATTRIBUTE(ipid_fops, inj_ipid_get, inj_ipid_set, "%llx\n");
 
 static void setup_inj_struct(struct mce *m)
 {
@@ -629,6 +632,8 @@ static const char readme_msg[] =
 "\t    is present in hardware. \n"
 "\t  - \"th\": Trigger APIC interrupt for Threshold errors. Causes threshold \n"
 "\t    APIC interrupt handler to handle the error. \n"
+"\n"
+"ipid:\t IPID (AMD-specific)\n"
 "\n";
 
 static ssize_t
@@ -652,6 +657,7 @@ static struct dfs_node {
 	{ .name = "misc",	.fops = &misc_fops,   .perm = S_IRUSR | S_IWUSR },
 	{ .name = "addr",	.fops = &addr_fops,   .perm = S_IRUSR | S_IWUSR },
 	{ .name = "synd",	.fops = &synd_fops,   .perm = S_IRUSR | S_IWUSR },
+	{ .name = "ipid",	.fops = &ipid_fops,   .perm = S_IRUSR | S_IWUSR },
 	{ .name = "bank",	.fops = &bank_fops,   .perm = S_IRUSR | S_IWUSR },
 	{ .name = "flags",	.fops = &flags_fops,  .perm = S_IRUSR | S_IWUSR },
 	{ .name = "cpu",	.fops = &extcpu_fops, .perm = S_IRUSR | S_IWUSR },
-- 
2.29.2

