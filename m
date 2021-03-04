Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E065132D8D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 18:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbhCDRqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 12:46:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39864 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237393AbhCDRnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 12:43:35 -0500
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B8731EC04BF;
        Thu,  4 Mar 2021 18:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614879773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dn7xdOixbJ18iX/uu48fTyX8QZ8h+c1ptsOI2BGg9UA=;
        b=FbJhSB4yC1Qp5C54CoBEV4Ifazd5sDKyhDhfDaVR3iiAf/0lsTe2J/mFQqgZoqwt38XR4b
        nRRamLYNsbOV0sATm+kun2JCispt/c1+S2j7igZFAudf1Vscr4IZr0w3/hqA+6ckY2ne0E
        qTcMp3ZnhbqUNkja8oBWVVP3Wl5/PmM=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 06/21] x86/boot/compressed/sev-es: Convert to insn_decode()
Date:   Thu,  4 Mar 2021 18:42:22 +0100
Message-Id: <20210304174237.31945-7-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210304174237.31945-1-bp@alien8.de>
References: <20210304174237.31945-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Other than simplifying the code there should be no functional changes
resulting from this.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/boot/compressed/sev-es.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 27826c265aab..801c626fc3d4 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -78,16 +78,15 @@ static inline void sev_es_wr_ghcb_msr(u64 val)
 static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 {
 	char buffer[MAX_INSN_SIZE];
-	enum es_result ret;
+	int ret;
 
 	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
 
-	insn_init(&ctxt->insn, buffer, MAX_INSN_SIZE, 1);
-	insn_get_length(&ctxt->insn);
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
 
-	ret = ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
-
-	return ret;
+	return ES_OK;
 }
 
 static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
-- 
2.29.2

