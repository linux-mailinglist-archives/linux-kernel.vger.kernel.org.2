Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5B13ADACA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 18:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhFSQDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 12:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234676AbhFSQDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 12:03:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967D1C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 09:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uXPHLU3hV4qMnUsWVZpS/Eb0r9gRa5L7KTOCm8VKpCg=; b=dc2fR2TOCzLOec4jyoj+YEzooT
        U7a4iFRExeKQUs7mTtXDUZeJFYXodDdQCDrQcWrMgQie1CnFBqFWsG0qBEcGrLByqQPluq+UTkEX9
        IqLS2p2LH5+8sEXo1XLOAwFndpm19mBbBVJO/dPB8jRGpvwfgdjzrsXs3qRxS4CNsxvf0JgGLkkJA
        LzIc9yQPOk9VQBuMw+Vcu/T8X7A3L/Td7O9uzV6TgpPkXQtG5RG+/DMR2q0fWYj+6AkB3MxEjjkKz
        qxn2JZgUcWyUjNw+gsNZVNtMBZN7AK2+EvlN/pM6H8xpjCe5o/wHaI2ysK8/omg1x1ZeNQ0NUKfYo
        1nNFagrw==;
Received: from [2601:1c0:6280:3f0::aefb] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ludPR-00HFgj-Kv; Sat, 19 Jun 2021 16:01:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/tools: fix objdump version check again
Date:   Sat, 19 Jun 2021 09:01:23 -0700
Message-Id: <20210619160123.26328-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip (omit) any version string info that is parenthesized.

Warning: objdump version 15) is older than 2.19
build-r1020.out:Warning: Skipping posttest.

when 'objdump -v' says:
GNU objdump (GNU Binutils; SUSE Linux Enterprise 15) 2.35.1.20201123-7.18

Fixes: 8bee738bb1979 ("x86: Fix objdump version check in chkobjdump.awk for different formats.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/tools/chkobjdump.awk |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210618.orig/arch/x86/tools/chkobjdump.awk
+++ linux-next-20210618/arch/x86/tools/chkobjdump.awk
@@ -10,6 +10,7 @@ BEGIN {
 
 /^GNU objdump/ {
 	verstr = ""
+	gsub(/\(.*\)/, "");
 	for (i = 3; i <= NF; i++)
 		if (match($(i), "^[0-9]")) {
 			verstr = $(i);
