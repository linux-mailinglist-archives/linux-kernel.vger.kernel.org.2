Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03723C58B0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380258AbhGLIv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 04:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348826AbhGLH4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:56:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 807AE61248;
        Mon, 12 Jul 2021 07:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626076326;
        bh=KiVb36/Ar1uMsO/wxTvf/Rmd6EnwMYFXOjO8Cl7UO3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V5qjLRxOhJPYk4KBy3He10CwID9ZXa8JuNHvELAeu01za+AytrQWVjV6Y/qxv5bVf
         UWHu6kCzXtjrxLVTf70xqasd5fEhm4MLgtz3t1qO4yHGwD9q0S3UwVNUMvWJHQjAdI
         nIMTgMGRbsi4VaUPS1vpkRwTnywSOyfzZ5z4zYYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.13 594/800] bpf, x86: Fix extable offset calculation
Date:   Mon, 12 Jul 2021 08:10:17 +0200
Message-Id: <20210712061030.508374721@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060912.995381202@linuxfoundation.org>
References: <20210712060912.995381202@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

[ Upstream commit 328aac5ecd119ede3633f7d17969b1ff34ccc784 ]

Commit 4c5de127598e1 ("bpf: Emit explicit NULL pointer checks for PROBE_LDX
instructions.") is emitting a couple of instructions before the actual load.
Consider those additional instructions while calculating extable offset.

Fixes: 4c5de127598e1 ("bpf: Emit explicit NULL pointer checks for PROBE_LDX instructions.")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20210622110026.1157847-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 2a2e290fa5d8..a3d867f22153 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -1297,7 +1297,7 @@ st:			if (is_imm8(insn->off))
 			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
 			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
 				struct exception_table_entry *ex;
-				u8 *_insn = image + proglen;
+				u8 *_insn = image + proglen + (start_of_ldx - temp);
 				s64 delta;
 
 				/* populate jmp_offset for JMP above */
-- 
2.30.2



