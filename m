Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BD132294F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhBWLMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:12:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47072 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231701AbhBWLMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:12:15 -0500
Received: from zn.tnic (p200300ec2f08d800f4a123a8a64e4d27.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:d800:f4a1:23a8:a64e:4d27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 400761EC01CE;
        Tue, 23 Feb 2021 12:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614078694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=PRRcv0X1Lc/+5F9ee4mDYr4SyzrtXxI6gDWofpgstZI=;
        b=Fs0quUH8ycBXWNVNLda6wXP4Gui/qo7jH1fLn4BFr8wtBx/Xn+KSP/frjSSgOhrp3FSkEM
        RbtaNeokIx5CPwE+fkdBi9PQRFBmUztCKUKyhoJEvS8yRGrtGvqByQVPcsw4GjUhcfrQdr
        jlePjg0HYpYQegBI9soY9QR1VFSoFT8=
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev-es: Remove subtraction of res variable
Date:   Tue, 23 Feb 2021 12:11:30 +0100
Message-Id: <20210223111130.16201-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

vc_decode_insn() calls copy_from_kernel_nofault() by way of
vc_fetch_insn_kernel() to fetch 15 bytes max of opcodes to decode.

copy_from_kernel_nofault() returns negative on error and 0 on success.
The error case is handled by returning ES_EXCEPTION.

In the success case, the ret variable which contains the return value is
0 so there's no need to subtract it from MAX_INSN_SIZE when initializing
the insn buffer for further decoding. Remove it.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/sev-es.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 84c1821819af..1e78f4bd7bf2 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -267,7 +267,7 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE - res, 1);
+		insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
 		insn_get_length(&ctxt->insn);
 	}
 
-- 
2.29.2

