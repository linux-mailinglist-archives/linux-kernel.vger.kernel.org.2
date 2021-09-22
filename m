Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16A5414E65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbhIVQwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 12:52:45 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39690 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236688AbhIVQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 12:52:38 -0400
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63CED1EC056A;
        Wed, 22 Sep 2021 18:51:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632329467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qMRgyqoVAPm2Bo5acTF5l+54J1tQ1rTsULeoPAbnkRM=;
        b=MrHBWfY+GmqK+GoBoofoo/9k9DyXy/3ypX+KvobQdehBdgeEwUl+rkWybyIU/Y9HRfiJV4
        evHR9I4o28VS+SBYJXADtu6dUCpEhWDjSRDV4gVwPGsyNdyawt0nleDQ3hMnuohq1oh6D+
        tVfMv0wE3rsOCXQp8hisB6CHDRCLXFo=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 5/5] x86/mce: Sort mca_config members to get rid of unnecessary padding
Date:   Wed, 22 Sep 2021 18:51:01 +0200
Message-Id: <20210922165101.18951-6-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210922165101.18951-1-bp@alien8.de>
References: <20210922165101.18951-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

$ pahole -C mca_config arch/x86/kernel/cpu/mce/core.o

before:

   /* size: 40, cachelines: 1, members: 16 */
   /* sum members: 21, holes: 1, sum holes: 3 */
   /* sum bitfield members: 64 bits, bit holes: 2, sum bit holes: 32 bits */
   /* padding: 4 */
   /* last cacheline: 40 bytes */

after:

   /* size: 32, cachelines: 1, members: 16 */
   /* padding: 3 */
   /* last cacheline: 32 bytes */

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/internal.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 21865545cd3b..37b9e381ef02 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -113,11 +113,6 @@ static inline void mce_unregister_injector_chain(struct notifier_block *nb)	{ }
 #endif
 
 struct mca_config {
-	bool dont_log_ce;
-	bool cmci_disabled;
-	bool ignore_ce;
-	bool print_all;
-
 	__u64 lmce_disabled		: 1,
 	      disabled			: 1,
 	      ser			: 1,
@@ -127,11 +122,16 @@ struct mca_config {
 	      initialized		: 1,
 	      __reserved		: 58;
 
-	s8 bootlog;
+	bool dont_log_ce;
+	bool cmci_disabled;
+	bool ignore_ce;
+	bool print_all;
+
 	int tolerant;
 	int monarch_timeout;
 	int panic_timeout;
 	u32 rip_msr;
+	s8 bootlog;
 };
 
 extern struct mca_config mca_cfg;
-- 
2.29.2

