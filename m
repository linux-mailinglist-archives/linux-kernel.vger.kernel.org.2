Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E923F35AEDC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 17:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbhDJPeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 11:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhDJPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 11:34:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE9C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 08:33:45 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1aea005aa758d9575cf1c9.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:ea00:5aa7:58d9:575c:f1c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E30F11EC0409;
        Sat, 10 Apr 2021 17:33:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618068823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JU+alkv88K3AjjKG+MMMv2hhK+iQ284WVJBIZRCDjo0=;
        b=sNmzpVJFSF7X2weFcgRoe8TQVNxZj3AcD84Z1x3QZS9H4OfyVqGYB7sXKOg5RRB87p0PFn
        Ep3sPN2Rt40xq9MTbiDFK8EHOsliB6UsXhzv0ik1WcqZIIEwvvnHrZ9DDtWRm8QcX4Nn6c
        j03I92wuKT+JQN5bt66LIZ1lPRnH7WY=
Date:   Sat, 10 Apr 2021 17:33:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: [PATCH -v1.1] x86/msr: Block writes to certain MSRs unconditionally
Message-ID: <20210410153338.GD21691@zn.tnic>
References: <20210410121144.GC21691@zn.tnic>
 <437BACC3-A1F7-4C65-80C7-98F6652A14E6@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <437BACC3-A1F7-4C65-80C7-98F6652A14E6@amacapital.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 07:51:58AM -0700, Andy Lutomirski wrote:
> Can you add STAR, CSTAR, LSTAR, SYSENTER*, SYSCALL*, and EFER please?

Sure.

---

From: Borislav Petkov <bp@suse.de>
Date: Sat, 10 Apr 2021 14:08:13 +0200

There are a bunch of MSRs which luserspace has no business poking
at, whatsoever. Add a ban list and put the TSC-related MSRs and the
ring0-entry and features control MSRs in there. Issue a big juicy splat
to catch offenders.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/msr.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index ed8ac6bcbafb..2435a619cd9f 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -78,6 +78,21 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 	return bytes ? bytes : err;
 }
 
+static const u32 msr_ban_list[] = {
+	MSR_IA32_TSC,
+	MSR_TSC_AUX,
+	MSR_IA32_TSC_ADJUST,
+	MSR_IA32_TSC_DEADLINE,
+	MSR_EFER,
+	MSR_STAR,
+	MSR_CSTAR,
+	MSR_LSTAR,
+	MSR_SYSCALL_MASK,
+	MSR_IA32_SYSENTER_CS,
+	MSR_IA32_SYSENTER_ESP,
+	MSR_IA32_SYSENTER_EIP,
+};
+
 static int filter_write(u32 reg)
 {
 	/*
@@ -89,6 +104,16 @@ static int filter_write(u32 reg)
 	 * avoid saturating the ring buffer.
 	 */
 	static DEFINE_RATELIMIT_STATE(fw_rs, 30 * HZ, 1);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(msr_ban_list); i++) {
+		if (msr_ban_list[i] != reg)
+			continue;
+
+		WARN_ONCE(1, "Blocked write to MSR 0x%x.\n", reg);
+
+		return -EINVAL;
+	}
 
 	switch (allow_writes) {
 	case MSR_WRITES_ON:  return 0;
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
