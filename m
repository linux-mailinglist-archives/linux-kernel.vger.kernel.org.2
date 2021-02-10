Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4937E315D76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbhBJCkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:34642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235043AbhBJCgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:36:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6574964E5B;
        Wed, 10 Feb 2021 02:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924435;
        bh=jz7kDiFJcINdjgVT2eVSSkNbzkyQcpTZqngJqJck5pg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OkM/D1RDYFACY3KcIRSOgVRQIK2IDbr8OCP/Ycwsj6YPWiS2vAwVh8jz6mNxqh46/
         3giXFUBa76qPRwpayqX4AMRFn7uKgkMNf7PA+RgD/Dtwgcp0jOMRs427PYIiDYcvFw
         EccSeehbC+yjkj2O3o+1okT0z73HWMEwSmg6Pi0Zt8REi0VYuMx3YnDD/2hQH39lCn
         BSMIdm1qCMjkTgAI74RLtfOd0J5ClOmucR9EH4kpntsLuZh5XvIq/ByliB93mEAMVZ
         vELly7aCuQIg+YtbziAiWnghv0wtl6+UXWbotJYQz3+2v3DJsDgaSqQnAwfb68Qfg8
         GvlXpnQzIVUSA==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 08/14] x86/fault: Skip erratum #93 workaround on new CPUs
Date:   Tue,  9 Feb 2021 18:33:40 -0800
Message-Id: <8969c688ee663e99901cf4b0383bc6662ce79707.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Erratum #93 applies to the first generation of AMD K8 CPUs.  Skip the
workaround on newer CPUs.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index cbb1a9754473..3fe2f4800b69 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -442,9 +442,8 @@ static void dump_pagetable(unsigned long address)
  */
 static int is_errata93(struct pt_regs *regs, unsigned long address)
 {
-#if defined(CONFIG_X86_64) && defined(CONFIG_CPU_SUP_AMD)
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD
-	    || boot_cpu_data.x86 != 0xf)
+#if defined(CONFIG_X86_64)
+	if (!is_amd_k8_pre_npt())
 		return 0;
 
 	if (user_mode(regs))
-- 
2.29.2

