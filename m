Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF08323B08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 12:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhBXLHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 06:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbhBXLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:03:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50651C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 03:02:42 -0800 (PST)
Received: from zn.tnic (p200300ec2f0d180081510bd8ee909965.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1800:8151:bd8:ee90:9965])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C852C1EC05B0;
        Wed, 24 Feb 2021 12:02:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614164560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dn7xdOixbJ18iX/uu48fTyX8QZ8h+c1ptsOI2BGg9UA=;
        b=BuKj5Plf3b0W+yPCESW/d4Bis+YM9qHbxzkmZIcSIYle3PN2qYm84A+uKfTWWcvWqlvtqz
        00lAOfHrEkIpsHWixIOMmSwnN9T4zSHVtpOY2xrYXnIrNYoOeCuikytXtwoLM43OOlIpk1
        lfZtXfb9KJs0gOT0X3dvpP9emIFuYUw=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/21] x86/boot/compressed/sev-es: Convert to insn_decode()
Date:   Wed, 24 Feb 2021 12:02:18 +0100
Message-Id: <20210224110233.19715-7-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224110233.19715-1-bp@alien8.de>
References: <20210224110233.19715-1-bp@alien8.de>
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

