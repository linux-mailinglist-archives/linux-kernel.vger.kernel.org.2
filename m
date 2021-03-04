Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118DC32D8DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbhCDRqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238764AbhCDRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:44:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AB0C061764
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 09:42:56 -0800 (PST)
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 727FD1EC04AD;
        Thu,  4 Mar 2021 18:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RD/U/Eq/ovMUKB5R5We/MH1f5iTCO1C0AjtDCf1uKaE=;
        b=XP8YaUNCxruJEcB18+V+JgZplnoaaMjS0dwcc5i0lrrNTH2r5r+qvol7/6WqjhU9rvCt0X
        slFVUcnxUEF/KDlTne7sul6zcN88Gpvo/kYdUO7HJyhpKEmGA01MFtpY8SAiWrWT5bMTbB
        G3wlR64IONQ/CXrf7d/oXxuqjqWl9jc=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 09/21] x86/alternative: Use insn_decode()
Date:   Thu,  4 Mar 2021 18:42:25 +0100
Message-Id: <20210304174237.31945-10-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

No functional changes, just simplification.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/alternative.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8d778e46725d..ce28c5c1deba 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1274,15 +1274,15 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
 			       const void *opcode, size_t len, const void *emulate)
 {
 	struct insn insn;
+	int ret;
 
 	memcpy((void *)tp->text, opcode, len);
 	if (!emulate)
 		emulate = opcode;
 
-	kernel_insn_init(&insn, emulate, MAX_INSN_SIZE);
-	insn_get_length(&insn);
+	ret = insn_decode(&insn, emulate, MAX_INSN_SIZE, INSN_MODE_KERN);
 
-	BUG_ON(!insn_complete(&insn));
+	BUG_ON(ret < 0);
 	BUG_ON(len != insn.length);
 
 	tp->rel_addr = addr - (void *)_stext;
-- 
2.29.2

