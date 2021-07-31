Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAF73DC1C6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhGaAB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbhGaABy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:01:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EEFC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 17:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WkE3KlhiEc/T/RN63NH5ytGuQYS0xe2KeWTed/zJz0c=; b=XLkqIhfAe3WbCAemZVB16/RKIB
        Oans3x8jqkWXH1CKdoq+X0MlFnL1yRGW47wpZcTrgthOwBaCTK8YDz7Q44VLjcl0tCaG5WeTi1X2p
        sDS50v/ym9EyWeLo3+4MHiyyAd3rALPXUBd6EPL8eF+mAhOvPVHQIRCsf+ZU+0zZ1zykf+/dJ7w3Z
        xk54Ml1jagYJgmssm4kOE+TauYdaEuCeKD93MFTN5vTY+4fJFfJM+7NM50a2E0hUKXPfLZP8w0SmF
        MGW/o9xyfw5/3JJky/JXTB/b+P9UK+abEhKR+nk/ueQfDZmILZCm6RJDBJECPJ1oDWwFuGisk3PmW
        uzOAOjzQ==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m9cRn-00AZtp-EL; Sat, 31 Jul 2021 00:01:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH v3 RESEND] x86/tools: fix objdump version check again
Date:   Fri, 30 Jul 2021 17:01:46 -0700
Message-Id: <20210731000146.2720-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip (omit) any version string info that is parenthesized.

Warning: objdump version 15) is older than 2.19
Warning: Skipping posttest.

where 'objdump -v' says:
GNU objdump (GNU Binutils; SUSE Linux Enterprise 15) 2.35.1.20201123-7.18

Fixes: 8bee738bb1979 ("x86: Fix objdump version check in chkobjdump.awk for different formats.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>
---
v3: rebase & resend
    correct Ingo's email address (not @elte.hu)
    add x86@kernel.org email address
    add BP's email address

 arch/x86/tools/chkobjdump.awk |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210715.orig/arch/x86/tools/chkobjdump.awk
+++ linux-next-20210715/arch/x86/tools/chkobjdump.awk
@@ -10,6 +10,7 @@ BEGIN {
 
 /^GNU objdump/ {
 	verstr = ""
+	gsub(/\(.*\)/, "");
 	for (i = 3; i <= NF; i++)
 		if (match($(i), "^[0-9]")) {
 			verstr = $(i);
