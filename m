Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AF736BF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 08:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhD0Gjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 02:39:43 -0400
Received: from mail-m121145.qiye.163.com ([115.236.121.145]:54092 "EHLO
        mail-m121145.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhD0Gjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 02:39:40 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 57B5980012C;
        Tue, 27 Apr 2021 14:38:55 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] x86/smpboot: Remove duplicate includes
Date:   Tue, 27 Apr 2021 14:38:26 +0800
Message-Id: <20210427063835.9039-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGhhMQ1ZPS0JIQhkfSBoeQxlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Txw4HT8JFlYCESERPglD
        QzgwFBxVSlVKTUpCTktOTkhNSU9OVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSExLNwY+
X-HM-Tid: 0a79120d5b44b03akuuu57b5980012c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm/intel-family.h is included at line 80.
asm/cpu_device_id.h is included at line 81.
Remove duplicate includes here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 arch/x86/kernel/smpboot.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 1e2050c4f94a..c1c1bd1ab921 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1863,9 +1863,6 @@ static bool slv_set_max_freq_ratio(u64 *base_freq, u64 *turbo_freq)
 	return true;
 }
 
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
-
 #define X86_MATCH(model)					\
 	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,		\
 		INTEL_FAM6_##model, X86_FEATURE_APERFMPERF, NULL)
-- 
2.25.1

