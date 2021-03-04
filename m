Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6E32D911
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhCDRy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:54:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40016 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238305AbhCDRpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:45:55 -0500
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDEFF1EC0528;
        Thu,  4 Mar 2021 18:43:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=36oIlNwpSo97MePWR2Li0m8swcNcInEZok/jC589IGc=;
        b=LefQIZTJyLGH/k3kMn90zDkqkKGsNy1dzt+E8Cut1cCqV+XqwW+VBQo7wmhZsF1EdEuSAj
        vMqxuI49XQVygX+o5lZKZ7hRefE9Acx5DNNfTufXOj28Rse6J5MIXbeLYj/9Pef3Dm0aSw
        RGu0n58dJJiKRrL6d9hR+9aCHey/1mE=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 18/21] x86/tools/insn_sanity: Convert to insn_decode()
Date:   Thu,  4 Mar 2021 18:42:34 +0100
Message-Id: <20210304174237.31945-19-bp@alien8.de>
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
 arch/x86/tools/insn_sanity.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/tools/insn_sanity.c b/arch/x86/tools/insn_sanity.c
index c6a0000ae635..213f35f94feb 100644
--- a/arch/x86/tools/insn_sanity.c
+++ b/arch/x86/tools/insn_sanity.c
@@ -218,8 +218,8 @@ static void parse_args(int argc, char **argv)
 
 int main(int argc, char **argv)
 {
+	int insns = 0, ret;
 	struct insn insn;
-	int insns = 0;
 	int errors = 0;
 	unsigned long i;
 	unsigned char insn_buff[MAX_INSN_SIZE * 2];
@@ -237,15 +237,15 @@ int main(int argc, char **argv)
 			continue;
 
 		/* Decode an instruction */
-		insn_init(&insn, insn_buff, sizeof(insn_buff), x86_64);
-		insn_get_length(&insn);
+		ret = insn_decode(&insn, insn_buff, sizeof(insn_buff),
+				  x86_64 ? INSN_MODE_64 : INSN_MODE_32);
 
 		if (insn.next_byte <= insn.kaddr ||
 		    insn.kaddr + MAX_INSN_SIZE < insn.next_byte) {
 			/* Access out-of-range memory */
 			dump_stream(stderr, "Error: Found an access violation", i, insn_buff, &insn);
 			errors++;
-		} else if (verbose && !insn_complete(&insn))
+		} else if (verbose && ret < 0)
 			dump_stream(stdout, "Info: Found an undecodable input", i, insn_buff, &insn);
 		else if (verbose >= 2)
 			dump_insn(stdout, &insn);
-- 
2.29.2

