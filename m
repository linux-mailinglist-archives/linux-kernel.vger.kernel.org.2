Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1794C3D569B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhGZItS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbhGZItG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 04:49:06 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4EAC0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:34 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id l7-20020ac848c70000b0290252173fe79cso4076845qtr.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oI1lsqd2Q7dxLS0xam0vuO1J8Xxzsd51ZvtsfH3kSqA=;
        b=bXUXb/i9hSD5qN+TC+k+TwbawB1Ioga3ua3ibJeKI8gHVrRfQF1zVfzZ9qUKUJWIZb
         D3xLOECrzB08csaTg6TGm2x6MiN2M0qkKt7aUpIzWlvypa7VgYw7HoaS8o9nwDLUc3Nt
         H/I3JOAjQfDHzXOk2iBvFyJl4Ofl/yegYHjGNrZWBdXPhk1D876uuHch99124AS6qus7
         EeemZ0cg6jHhbWX/57lWGRwafDUed/QpP+m0HQ1U2ANbhgXhsZwGerOpdJs9Df1RiqXo
         uEtAXLQXFJZUQjutSGSIyRCOHeo6U82U5bsQSPmEcXs8Wfx1gjaZbyNisbC3A+TAs1WN
         NoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oI1lsqd2Q7dxLS0xam0vuO1J8Xxzsd51ZvtsfH3kSqA=;
        b=hip17ejCzOZH8vwZArEv94PbuKl8unhlk3WIK9iIAKPJNLKh0bMSiaT8GXPkLkqyA9
         pVcLyqbf/dzGvVOhWIwvUJPbLQ86yRy4ok/IPZ+jjK8nztIUjhptEckFL7AB1bl2rjpB
         79J2JNz4PKzJG7HrbbP5O/1PeeeCcOrEoIgKlcjuDOP6JK8/PZfesySor86P4ZxQtRnu
         NYgawosgojX/yvJsNhnt719I9CYTCBpCnBElkDOBSkF/gRkIVx2rj6Pfj2gV9HGO6rGs
         93FOSB3iaxMqzsjrMZt8y4pHmySx1gjbNZ6jXfKvTQXaFRabZ/KdpVqJ/egswcYQhJXY
         FriQ==
X-Gm-Message-State: AOAM532hvF3D/zGprUzUKf8KoxYyT8dMW2o2KdPXFoLUnB1wUE5UiZbH
        cR3gVHYDnmuVEqMdJ6OD7NKow7N6eJSJ
X-Google-Smtp-Source: ABdhPJyCiJBcW6GLm8E7sXXL2J+ym67KXeRU47WQn21gBL8HZOPCdK1XRTVEI/TyzJ/m4gVul31p0IuTxjtT
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:23a0:2f14:433:e6cb])
 (user=qperret job=sendgmr) by 2002:a0c:aacd:: with SMTP id
 g13mr2247331qvb.20.1627291773337; Mon, 26 Jul 2021 02:29:33 -0700 (PDT)
Date:   Mon, 26 Jul 2021 10:28:59 +0100
In-Reply-To: <20210726092905.2198501-1-qperret@google.com>
Message-Id: <20210726092905.2198501-11-qperret@google.com>
Mime-Version: 1.0
References: <20210726092905.2198501-1-qperret@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH v2 10/16] KVM: arm64: Add helpers to tag shared pages in SW bits
From:   Quentin Perret <qperret@google.com>
To:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com,
        Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will soon start annotating shared pages in page-tables in nVHE
protected mode. Define all the states in which a page can be (owned,
shared and owned, shared and borrowed), and provide helpers allowing to
convert this into SW bits annotations using the matching prot
attributes.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
index 9c227d87c36d..facbd9a7ab99 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
@@ -12,6 +12,33 @@
 #include <asm/virt.h>
 #include <nvhe/spinlock.h>
 
+/*
+ * SW bits 0-1 are reserved to track the memory ownership state of each page:
+ *   00: The page is owned solely by the page-table owner.
+ *   01: The page is owned by the page-table owner, but is shared
+ *       with another entity.
+ *   10: The page is shared with, but not owned by the page-table owner.
+ *   11: Reserved for future use (lending).
+ */
+enum pkvm_page_state
+{
+	PKVM_PAGE_OWNED			= 0ULL,
+	PKVM_PAGE_SHARED_OWNED		= KVM_PGTABLE_PROT_SW0,
+	PKVM_PAGE_SHARED_BORROWED	= KVM_PGTABLE_PROT_SW1,
+};
+
+#define PKVM_PAGE_STATE_PROT_MASK	(KVM_PGTABLE_PROT_SW0 | KVM_PGTABLE_PROT_SW1)
+static inline enum kvm_pgtable_prot pkvm_mkstate(enum kvm_pgtable_prot prot,
+						 enum pkvm_page_state state)
+{
+	return (prot & ~PKVM_PAGE_STATE_PROT_MASK) | state;
+}
+
+static inline enum pkvm_page_state pkvm_getstate(enum kvm_pgtable_prot prot)
+{
+	return prot & PKVM_PAGE_STATE_PROT_MASK;
+}
+
 struct host_kvm {
 	struct kvm_arch arch;
 	struct kvm_pgtable pgt;
-- 
2.32.0.432.gabb21c7263-goog

