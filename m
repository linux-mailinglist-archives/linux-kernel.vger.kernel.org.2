Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5F32D8DA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhCDRqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:39 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39978 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232301AbhCDRpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:45:55 -0500
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D6BA71EC04AD;
        Thu,  4 Mar 2021 18:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fms/cSkyvq6e7l0EUpGKreWH3nSqsG+/t272Cvtx7BI=;
        b=NU7Fk38t8hRSIPsAKYC4++lPEmYTqNn4KQU1RqIFLYIrgNhgZhgdpOGgV8GVa5vfoxAVvP
        Mv12ySdEbhef5WVGe/n+PpU4unZVxkIfqZoIJ/msy52qfWFHJaXq278kf0n6E/dnz9hEvq
        8sK3yf/NnCYBkuzfAvptfKBW8NOx6i4=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 15/21] x86/uprobes: Convert to insn_decode()
Date:   Thu,  4 Mar 2021 18:42:31 +0100
Message-Id: <20210304174237.31945-16-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/uprobes.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index a2b413394917..b63cf8f7745e 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -276,12 +276,12 @@ static bool is_prefix_bad(struct insn *insn)
 
 static int uprobe_init_insn(struct arch_uprobe *auprobe, struct insn *insn, bool x86_64)
 {
+	enum insn_mode m = x86_64 ? INSN_MODE_64 : INSN_MODE_32;
 	u32 volatile *good_insns;
+	int ret;
 
-	insn_init(insn, auprobe->insn, sizeof(auprobe->insn), x86_64);
-	/* has the side-effect of processing the entire instruction */
-	insn_get_length(insn);
-	if (!insn_complete(insn))
+	ret = insn_decode(insn, auprobe->insn, sizeof(auprobe->insn), m);
+	if (ret < 0)
 		return -ENOEXEC;
 
 	if (is_prefix_bad(insn))
-- 
2.29.2

