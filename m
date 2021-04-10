Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3A635AD35
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 14:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhDJMMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 08:12:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33160 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231279AbhDJMMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:12:02 -0400
Received: from zn.tnic (p200300ec2f1aea006082a170ade1e1be.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:ea00:6082:a170:ade1:e1be])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 295201EC0503;
        Sat, 10 Apr 2021 14:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618056707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kPPK/QMaoIar+FjxS46ZX+QeZKTmcaML04EwAs17eoA=;
        b=cOPHBVMHtx8z+KZh+56NNI8efPVD7MKscwZGsmnizKyR3svhxJ2TUQu2sfApm6T2FId4BO
        vWlw6I3XxKH8zNQfRmJ21ZJuNksOxyGaFVT+Ok/08Zv/lQWmMdNWT0KHl4dYbTkm7CRLAS
        MbvJJxjw4yVoRfYHlgJS+8Yzc65Gp4k=
Date:   Sat, 10 Apr 2021 14:11:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
Message-ID: <20210410121144.GC21691@zn.tnic>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de>
 <20210410094752.GB21691@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210410094752.GB21691@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>
Date: Sat, 10 Apr 2021 14:08:13 +0200

There are a bunch of MSRs which luserspace has no business poking at,
whatsoever. Add a ban list and put the TSC-related MSRs in there. Issue
a big juicy splat to catch offenders.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/msr.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index ed8ac6bcbafb..574bd2c6d4f8 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -78,6 +78,13 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 	return bytes ? bytes : err;
 }
 
+static const u32 msr_ban_list[] = {
+	MSR_IA32_TSC,
+	MSR_TSC_AUX,
+	MSR_IA32_TSC_ADJUST,
+	MSR_IA32_TSC_DEADLINE,
+};
+
 static int filter_write(u32 reg)
 {
 	/*
@@ -89,6 +96,16 @@ static int filter_write(u32 reg)
 	 * avoid saturating the ring buffer.
 	 */
 	static DEFINE_RATELIMIT_STATE(fw_rs, 30 * HZ, 1);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(msr_ban_list); i++) {
+		if (msr_ban_list[i] != reg)
+			continue;
+
+		WARN_ONCE(1, "Blocked write to MSR 0x%x\n", reg);
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
