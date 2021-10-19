Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C34335AB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhJSMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbhJSMPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:53 -0400
Received: from mail-lj1-x24a.google.com (mail-lj1-x24a.google.com [IPv6:2a00:1450:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9524C06176F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:38 -0700 (PDT)
Received: by mail-lj1-x24a.google.com with SMTP id f13-20020a05651c02cd00b00210dee0c36eso798465ljo.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ISeivE4VJePhwCDFvsBtzOVIerKBvyMpPq/U4suJ8Dg=;
        b=pMTyZ0Vbl+u7Dlf64iUAHAL8iII5oExKlGMnTMHZaH1N3KOh6pszIEURsP71VOA8zm
         YmAfLbs73BpmIWiQFsAwuQdZch7d1aBX0VE1dqPVlo4MR+Iv3SEIvK1dzqA44YUBqokQ
         3BWhGEojgqF2KRv1G62YRc39Vn8Nnjta2ATq8LApIpEt7DGix0abtEW9pGr56bx76kdj
         22z6U+fFymB5GMOz4WZX6L7B8vnwJ+yGDZM1gxOHNZEdOyXICg/04hJWqSYDUUhm5VGZ
         8XPgn1dhN12ntFAgc27i+8EKZxW4j4Rv26/Vjwmr2QvI0pNoKwfj6Pef3gBLMRK7blQh
         duHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ISeivE4VJePhwCDFvsBtzOVIerKBvyMpPq/U4suJ8Dg=;
        b=Km8NQck+OD/K4rTAVwyjZyJbOeL/CS13VhiBAo6XBgnH1FhwZt36/yS2r75EG1GTds
         j+Ng355YxWbtIr7hONv0qww65TPLeTq0R31GhUAGGZH7Bg1Er3zdoDVSZ7/JOfL0R3Wy
         jeWmxk3vftehZBms8cY+XPDwLoY0syQEIF71aM10Lur67s775rObGBT7xQE7NqIo5Wta
         Q8OPVzAgqDlW0r8Bt4540w1U1SBVBhS+EUgIFGziZztf2sqLwDjYqB6w5G9jjrcfF+M6
         XA0MWZH+NHHE+4+F+89RBvoDtrBm4h7KlXJgx2KUBse7H6mQkNqbAKIASn6Up/czXyd/
         MjIw==
X-Gm-Message-State: AOAM531lrzo/Wk2kfm5wLQ5UJYx0AhcthR3tM3zFyGxO7x5cPxgLJsNa
        o1oqKzvtF7YfhTg9Z2P5Uf8WRguls7Ze
X-Google-Smtp-Source: ABdhPJwgKkmhxiB5XvxU66pG49kdREnEBCBJUkS8jWIoTxJjPaFPdF/auvzHlo/liyhgODAIlIOug/KJN2Yd
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a2e:7816:: with SMTP id
 t22mr6884979ljc.133.1634645617143; Tue, 19 Oct 2021 05:13:37 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:13:02 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-14-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 13/15] KVM: arm64: Implement do_unshare() helper for
 unsharing memory
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Andrew Walbran <qwandor@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

Tearing down a previously shared memory region results in the borrower
losing access to the underlying pages and returning them to the "owned"
state in the owner.

Implement a do_unshare() helper, along the same lines as do_share(), to
provide this functionality for the host-to-hyp case.

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 115 ++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index ab1732c38b3b..205616c9f107 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -474,6 +474,16 @@ static int host_request_owned_transition(u64 *completer_addr,
 	return __host_check_page_state_range(addr, size, PKVM_PAGE_OWNED);
 }
 
+static int host_request_unshare(u64 *completer_addr,
+				const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+	u64 addr = tx->initiator.addr;
+
+	*completer_addr = tx->initiator.host.completer_addr;
+	return __host_check_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
+}
+
 static int host_initiate_share(u64 *completer_addr,
 			       const struct pkvm_mem_transition *tx)
 {
@@ -484,6 +494,16 @@ static int host_initiate_share(u64 *completer_addr,
 	return __host_set_page_state_range(addr, size, PKVM_PAGE_SHARED_OWNED);
 }
 
+static int host_initiate_unshare(u64 *completer_addr,
+				 const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+	u64 addr = tx->initiator.addr;
+
+	*completer_addr = tx->initiator.host.completer_addr;
+	return __host_set_page_state_range(addr, size, PKVM_PAGE_OWNED);
+}
+
 static enum pkvm_page_state hyp_get_page_state(kvm_pte_t pte)
 {
 	if (!kvm_pte_valid(pte))
@@ -524,6 +544,17 @@ static int hyp_ack_share(u64 addr, const struct pkvm_mem_transition *tx,
 	return __hyp_check_page_state_range(addr, size, PKVM_NOPAGE);
 }
 
+static int hyp_ack_unshare(u64 addr, const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+
+	if (__hyp_ack_skip_pgtable_check(tx))
+		return 0;
+
+	return __hyp_check_page_state_range(addr, size,
+					    PKVM_PAGE_SHARED_BORROWED);
+}
+
 static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
 			      enum kvm_pgtable_prot perms)
 {
@@ -534,6 +565,14 @@ static int hyp_complete_share(u64 addr, const struct pkvm_mem_transition *tx,
 	return pkvm_create_mappings_locked(start, end, prot);
 }
 
+static int hyp_complete_unshare(u64 addr, const struct pkvm_mem_transition *tx)
+{
+	u64 size = tx->nr_pages * PAGE_SIZE;
+	int ret = kvm_pgtable_hyp_unmap(&pkvm_pgtable, addr, size);
+
+	return (ret != size) ? -EFAULT : 0;
+}
+
 static int check_share(struct pkvm_mem_share *share)
 {
 	const struct pkvm_mem_transition *tx = &share->tx;
@@ -610,6 +649,82 @@ static int do_share(struct pkvm_mem_share *share)
 	return WARN_ON(__do_share(share));
 }
 
+static int check_unshare(struct pkvm_mem_share *share)
+{
+	const struct pkvm_mem_transition *tx = &share->tx;
+	u64 completer_addr;
+	int ret;
+
+	switch (tx->initiator.id) {
+	case PKVM_ID_HOST:
+		ret = host_request_unshare(&completer_addr, tx);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	switch (tx->completer.id) {
+	case PKVM_ID_HYP:
+		ret = hyp_ack_unshare(completer_addr, tx);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static int __do_unshare(struct pkvm_mem_share *share)
+{
+	const struct pkvm_mem_transition *tx = &share->tx;
+	u64 completer_addr;
+	int ret;
+
+	switch (tx->initiator.id) {
+	case PKVM_ID_HOST:
+		ret = host_initiate_unshare(&completer_addr, tx);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	switch (tx->completer.id) {
+	case PKVM_ID_HYP:
+		ret = hyp_complete_unshare(completer_addr, tx);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*
+ * do_unshare():
+ *
+ * The page owner revokes access from another component for a range of
+ * pages which were previously shared using do_share().
+ *
+ * Initiator: SHARED_OWNED	=> OWNED
+ * Completer: SHARED_BORROWED	=> NOPAGE
+ */
+static int do_unshare(struct pkvm_mem_share *share)
+{
+	int ret;
+
+	ret = check_unshare(share);
+	if (ret)
+		return ret;
+
+	return WARN_ON(__do_unshare(share));
+}
+
 int __pkvm_host_share_hyp(u64 pfn)
 {
 	int ret;
-- 
2.33.0.1079.g6e70778dc9-goog

