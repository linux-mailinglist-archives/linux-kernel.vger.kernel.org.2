Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFE040786C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhIKNwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 09:52:33 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45506 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235934AbhIKNwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 09:52:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yinan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Uo-bker_1631368273;
Received: from localhost(mailfrom:yinan@linux.alibaba.com fp:SMTPD_---0Uo-bker_1631368273)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 11 Sep 2021 21:51:17 +0800
From:   Yinan Liu <yinan@linux.alibaba.com>
To:     yinan@linux.alibaba.com, rostedt@goodmis.org,
        mark-pk.tsai@mediatek.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] scripts: ftrace - move the nop-processing in ftrace_init to compile time
Date:   Sat, 11 Sep 2021 21:50:43 +0800
Message-Id: <20210911135043.16014-3-yinan@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210911135043.16014-1-yinan@linux.alibaba.com>
References: <20210911135043.16014-1-yinan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When ftrace is enabled, ftrace_init will consume a period of
time, usually around 15~20ms. Approximately 60% of the time is
consumed by nop-processing. Moving the nop-processing to the
compile time can speed up the kernel boot process.

performance test:
        env:    Intel(R) Xeon(R) CPU E5-2682 v4 @ 2.50GHz
        method: before and after patching, compare the
                total time of ftrace_init(), and verify
                the functionality of ftrace.

        avg_time of ftrace_init:
                with patch: 7.114ms
                without patch: 15.763ms

Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
---
 kernel/trace/ftrace.c  |  4 ++++
 scripts/recordmcount.h | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c236da868990..ae3fba331179 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6261,6 +6261,10 @@ static int ftrace_process_locs(struct module *mod,
 	 * until we are finished with it, and there's no
 	 * reason to cause large interrupt latencies while we do it.
 	 */
+#if defined CONFIG_X86 || defined CONFIG_X86_64 || defined CONFIG_ARM || defined CONFIG_ARM64
+	ret = 0;
+	goto out;
+#endif
 	if (!mod)
 		local_irq_save(flags);
 	ftrace_update_code(mod, start_pg);
diff --git a/scripts/recordmcount.h b/scripts/recordmcount.h
index 1e9baa5c4fc6..152311639a0b 100644
--- a/scripts/recordmcount.h
+++ b/scripts/recordmcount.h
@@ -406,6 +406,8 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 			       uint_t const recval,
 			       unsigned const reltype)
 {
+	Elf_Shdr *const shdr0 = (Elf_Shdr *)(_w(ehdr->e_shoff) + (void *)ehdr);
+	Elf_Shdr const *const shdr = &shdr0[w(relhdr->sh_info)];
 	uint_t *const mloc0 = mlocp;
 	Elf_Rel *mrelp = *mrelpp;
 	Elf_Sym const *sym0;
@@ -419,6 +421,7 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 	get_sym_str_and_relp(relhdr, ehdr, &sym0, &str0, &relp);
 
 	for (t = nrel; t; --t) {
+		int ret = -1;
 		if (!mcountsym)
 			mcountsym = get_mcountsym(sym0, relp, str0);
 
@@ -436,6 +439,17 @@ static uint_t *sift_rel_mcount(uint_t *mlocp,
 				*mlocp++ = addend;
 
 			mrelp = (Elf_Rel *)(rel_entsize + (void *)mrelp);
+			/* convert mcount into nop */
+			if (make_nop)
+				ret = make_nop((void *)ehdr,
+						_w(shdr->sh_offset) + _w(relp->r_offset));
+			if (!ret) {
+				Elf_Rel rel;
+				rel = *(Elf_Rel *)relp;
+				Elf_r_info(&rel, Elf_r_sym(relp), rel_type_nop);
+				ulseek(fd_map, (void *)relp - (void *)ehdr, SEEK_SET);
+				uwrite(fd_map, &rel, sizeof(rel));
+			}
 		}
 		relp = (Elf_Rel const *)(rel_entsize + (void *)relp);
 	}
-- 
2.14.4.44.g2045bb6

