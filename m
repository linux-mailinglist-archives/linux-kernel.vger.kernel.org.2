Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D221532A862
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1580253AbhCBRa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444817AbhCBPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:06:28 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DB1C0698CD
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 07:01:04 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id i16so4666173qtv.18
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 07:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0DGi8WZ41csXemjNsmACrndajQddZ4pCIIm4i2MnuBE=;
        b=NE6Q1GAgjfYI2WSnlZK6ccjnYEU6vpTfApOHpsJa8pc8twhDpFxuOBo32r89W8t2Kc
         YIB2XzSRTuyKBC2SBUZYIpJ7X4Lwzup0jJUpmkpiEcqkF3y7b0xBe/fYkbHGMCWJVaUl
         +pZoQqqiNkX+eDaJA/FSLnqVZb4bFe+3fBD3LjgG7dXQpUDq1BampNoAf4Yqpv6jDuu2
         qsKdLOcxfPInMZ+6hngaTT3gdvCEg2NqfDhIB467NAn1rkMN9qG1UhjNDSuKBp35gTvX
         Z0FQb+JQ83j4h0wmWUQ5CY9BbZ2yBx+w4CwV0O68SlSrz6GTdXVcdwtswSt+dQHcseV+
         WnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0DGi8WZ41csXemjNsmACrndajQddZ4pCIIm4i2MnuBE=;
        b=Qe5ZUS1BnU8AhfIClh7eAVo8pOEWCjgxfk+W3EQMkY4KCHyLSfLQPRHsdZb6+oze4E
         9Skfqz9nUe+h7eZRSPG5pPPp7b4dCEATx5Pv3VobbQRtWHKysJ2laG0ri/QkWA26ejPP
         Ujm+DpRgSqgnWLrBu13hql3vzu1L5aWdMOW6fEIKIbm+tgl4IL8dBI6fIOi2fS5w6qMJ
         e9Yd+JuJ79hekj9pUO6jWmxHzpocCGMJ2h5qo6RwV75TN8JHXEWGP3r3jn/HRxOKkpHY
         XiwyahmP3LkCWOFAQUPaJajj2VQeAVhCqAs3ZoR5N/5+3M4LPN1B9HloFvY08/Xk/BZm
         UaMQ==
X-Gm-Message-State: AOAM531lfzQjhRUFv7vAp5P0SlFixkYmppbDnxBuJcdAErI3i0q4MHve
        2D+bDdLnGfxBvDUQCyRyqaHLnPUHTo03
X-Google-Smtp-Source: ABdhPJxW29HrCwNVsnKe95k20fj29Sf36Q0W3cKnVBDqrtxU2VNcdgoeoSV78CPoA72FRV1PB5O9++BrTYke
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a0c:ed45:: with SMTP id
 v5mr19863045qvq.13.1614697263353; Tue, 02 Mar 2021 07:01:03 -0800 (PST)
Date:   Tue,  2 Mar 2021 14:59:55 +0000
In-Reply-To: <20210302150002.3685113-1-qperret@google.com>
Message-Id: <20210302150002.3685113-26-qperret@google.com>
Mime-Version: 1.0
References: <20210302150002.3685113-1-qperret@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3 25/32] KVM: arm64: Sort the hypervisor memblocks
From:   Quentin Perret <qperret@google.com>
To:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com
Cc:     android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, qperret@google.com, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon need to check if a Physical Address belongs to a memblock
at EL2, so make sure to sort them so this can be done efficiently.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/reserved_mem.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
index fd42705a3c26..83ca23ac259b 100644
--- a/arch/arm64/kvm/hyp/reserved_mem.c
+++ b/arch/arm64/kvm/hyp/reserved_mem.c
@@ -6,6 +6,7 @@
 
 #include <linux/kvm_host.h>
 #include <linux/memblock.h>
+#include <linux/sort.h>
 
 #include <asm/kvm_host.h>
 
@@ -18,6 +19,23 @@ static unsigned int *hyp_memblock_nr_ptr = &kvm_nvhe_sym(hyp_memblock_nr);
 phys_addr_t hyp_mem_base;
 phys_addr_t hyp_mem_size;
 
+static int cmp_hyp_memblock(const void *p1, const void *p2)
+{
+	const struct memblock_region *r1 = p1;
+	const struct memblock_region *r2 = p2;
+
+	return r1->base < r2->base ? -1 : (r1->base > r2->base);
+}
+
+static void __init sort_memblock_regions(void)
+{
+	sort(hyp_memory,
+	     *hyp_memblock_nr_ptr,
+	     sizeof(struct memblock_region),
+	     cmp_hyp_memblock,
+	     NULL);
+}
+
 static int __init register_memblock_regions(void)
 {
 	struct memblock_region *reg;
@@ -29,6 +47,7 @@ static int __init register_memblock_regions(void)
 		hyp_memory[*hyp_memblock_nr_ptr] = *reg;
 		(*hyp_memblock_nr_ptr)++;
 	}
+	sort_memblock_regions();
 
 	return 0;
 }
-- 
2.30.1.766.gb4fecdf3b7-goog

