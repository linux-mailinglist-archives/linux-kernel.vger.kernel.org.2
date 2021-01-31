Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1018A309F34
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhAaWRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:17:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:37108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhAaWNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:13:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DBBB64E51;
        Sun, 31 Jan 2021 17:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113895;
        bh=CNpgb/IqxKW9fcAp/ircjHKvncodYrH0lcqqvhfq9mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cuAMCWLvI6AAyKW4uq+x6K+5CY6e5tMSvVy67id6ayx7XkyTJF4/nTuRzXQOoWfwm
         nLyPlpUE6WblH0UEl9impS/SrhJI8/6bSJlNPe90uFe/upru1ADBDLFjGd8eYtkceP
         iNHaFRT9ndDQnYpF5E1lUbRlXVOIi0ZAA17tjswid0BCKnsewz/eRciX75NhbxDNFA
         joBKjibMqurGdBAwPgpsaH1JOQAwuIu02VRxEyF26EdxOanWUyaFz5laPD8SxLT/jG
         fBgRda4VYdSdT1FnqF1OhdXI5o9lb25gtEmQPEd3b6rLsr9v68x46lX4lyuYZieoYl
         Xa+bFS8WvHNEw==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 11/11] x86/fault: Don't look for extable entries for SMEP violations
Date:   Sun, 31 Jan 2021 09:24:42 -0800
Message-Id: <45fd30a3ef59733d8618fcd3736217b5edda3971.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we get a SMEP violation or a fault that would have been a SMEP
violation if we had SMEP, we shouldn't run fixups.  Just OOPS.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d39946ad8a91..08f5f74cf989 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1211,12 +1211,13 @@ void do_user_addr_fault(struct pt_regs *regs,
 		/*
 		 * Whoops, this is kernel mode code trying to execute from
 		 * user memory.  Unless this is AMD erratum #93, we are toast.
-		 * Don't even try to look up the VMA.
+		 * Don't even try to look up the VMA or look for extable
+		 * entries.
 		 */
 		if (is_errata93(regs, address))
 			return;
 
-		bad_area_nosemaphore(regs, error_code, address);
+		page_fault_oops(regs, error_code, address);
 		return;
 	}
 
-- 
2.29.2

