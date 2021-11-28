Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD7646076A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358388AbhK1QU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:20:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35754 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbhK1QSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:18:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72E0FB80D10
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 16:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7BBC53FC7;
        Sun, 28 Nov 2021 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638116103;
        bh=ExbSBshbbwnHbo97uVIa25GN2ty9N/NPvVqrH0yw1Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVi9MPib5uv8YRVEFHTi8Xoi2v5ZYmsvyU22wWKwwLQkTPyC79OL8m6quDzVXg4tW
         eQRpWZ6FI1/cs1D0JLmd2TW+9kpVeb2XNCRDALLqZvdTgTxAGyn8ZrtNbtpWGlPMRS
         L+9RtLjhVZIDzjcXGAlVaofEceO1btUF6UAEE70trmO1xu5dEfXQoO89tn1eNYPu5T
         vlsr+1fkcJ9cMwfxmsNy5RcgeV4m2Z2HBF/5TYGKMRLD8OiBfyFb/9aKrvUvdEZUAo
         t22oooPzh2Pp/hYL05thWDJVSX8ZwLJm820ifj/0Cp3J1HG9gDIxymKXcku0rc/U1c
         IpUEkSTJm+rCA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@atishpatra.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org
Subject: [PATCH 3/5] riscv: kvm: make kvm_riscv_vcpu_fp_clean() static
Date:   Mon, 29 Nov 2021 00:07:39 +0800
Message-Id: <20211128160741.2122-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211128160741.2122-1-jszhang@kernel.org>
References: <20211128160741.2122-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users outside vcpu_fp.c so make kvm_riscv_vcpu_fp_clean()
static.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kvm/vcpu_fp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_fp.c b/arch/riscv/kvm/vcpu_fp.c
index 1b070152578f..4449a976e5a6 100644
--- a/arch/riscv/kvm/vcpu_fp.c
+++ b/arch/riscv/kvm/vcpu_fp.c
@@ -26,7 +26,7 @@ void kvm_riscv_vcpu_fp_reset(struct kvm_vcpu *vcpu)
 		cntx->sstatus |= SR_FS_OFF;
 }
 
-void kvm_riscv_vcpu_fp_clean(struct kvm_cpu_context *cntx)
+static void kvm_riscv_vcpu_fp_clean(struct kvm_cpu_context *cntx)
 {
 	cntx->sstatus &= ~SR_FS;
 	cntx->sstatus |= SR_FS_CLEAN;
-- 
2.34.0

