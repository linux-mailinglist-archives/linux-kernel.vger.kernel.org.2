Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8521A323B14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhBXLL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:11:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232678AbhBXLD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:29 -0500
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF1111EC05BB;
        Wed, 24 Feb 2021 12:02:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GHls/O/EJX+cwlbUJjFb5UNshOjm1y3XildNZ9dteow=;
        b=p7/TyNm/WcUmGw7gmbZsF/D2POvnMwptzXBA0frNezLxTPvX1FXiwYqpkPnO7+Nm7dWuXG
        D/7UFummwemNHGi4wTmj8bYE4CY9O7iGkJdYc4KUE6Pmd9Mx4Jv91gf+Oum1kwhLB1omwE
        Yg4OifnkqwBGOFx6I6bnPzHwMmk2cwo=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 16/21] x86/tools/insn_decoder_test: Convert to insn_decode()
Date:   Wed, 24 Feb 2021 12:02:28 +0100
Message-Id: <20210224110233.19715-17-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/tools/insn_decoder_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/insn_decoder_test.c b/arch/x86/tools/insn_decoder_test.c
index 34eda63c124b..472540aeabc2 100644
--- a/arch/x86/tools/insn_decoder_test.c
+++ b/arch/x86/tools/insn_decoder_test.c
@@ -120,7 +120,7 @@ int main(int argc, char **argv)
 
 	while (fgets(line, BUFSIZE, stdin)) {
 		char copy[BUFSIZE], *s, *tab1, *tab2;
-		int nb = 0;
+		int nb = 0, ret;
 		unsigned int b;
 
 		if (line[0] == '<') {
@@ -148,10 +148,12 @@ int main(int argc, char **argv)
 			} else
 				break;
 		}
+
 		/* Decode an instruction */
-		insn_init(&insn, insn_buff, sizeof(insn_buff), x86_64);
-		insn_get_length(&insn);
-		if (insn.length != nb) {
+		ret = insn_decode(&insn, insn_buff, sizeof(insn_buff),
+				  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
+
+		if (ret < 0 || insn.length != nb) {
 			warnings++;
 			pr_warn("Found an x86 instruction decoder bug, "
 				"please report this.\n", sym);
-- 
2.29.2

