Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936A03D920F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhG1Pct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237291AbhG1Pcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:32:48 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6632CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:32:45 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id p2-20020a5d48c20000b0290150e4a5e7e0so1070718wrs.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qzw4XcX4w+ny84Qln9d15Ry0/+5tfssrXUUN0rRDVVc=;
        b=G3I/3fhsNE6Og2SNbp7xijYfhxbbi8EEXzZO7tjVLLwHEwaGAf2WH4WDSAI9RuBK2v
         y7MINQTjeOU9oU90HjjguDGAwa4tof8t/8vq/m2JE5pv2a/YNi09Y4IPEqg/Mq+fBEPD
         Z0d/8fw19uWXRPZVYkNEbf40fgTfDWXSKtSXKuEpcdnImMph1V/8lTDcxryYsvCOGEJx
         bdhwsqESBm+n86hEdsfP11ImWIAtFpMKBxxxA86Z4l4ZbGbeKxemOU97Z+VC4VrnXV3V
         xL3tHvSnAfmB7Ax5kGhpV8zZqSzrsqsT6CwvAXBclwHpCvv307H5rs9J7qPyzU9u9jLx
         Izwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qzw4XcX4w+ny84Qln9d15Ry0/+5tfssrXUUN0rRDVVc=;
        b=X7k5+k3MQGNyUURz0jQDd5BwjM7HqkLq1/DDadVDDQ+1epBWmSfZysFRZYdNvxDbE9
         ooT+9tDT4aKLsCYSdy8x3E4K4vJw9+WJDr2aoDEUD7Z8r6HGlGIzmGSEAD/6WWAJePZE
         F/ORGIgVST39p82yMslP21m+sV3MajmbrOqtMLDbLp0SQp2QfababwYj/+MN8gf+XyMp
         W8MDIP6KUkYr5rarI9QDjTVy8dts+sxe8UsXxZbLsz3p214R/U34FQzakSGeAzbjB4ab
         GScffm/ZJeGOEBCPCUSFPwQZ2XGygRNLVfuki6iOvzN9EWlKZ3CfHqyD0URQJB8XUTCA
         7iLw==
X-Gm-Message-State: AOAM530Sz+GxZ7LQjkPncgQ37iNfohEKtoc6xMnaJIaL0JLoPtUSbajS
        RxTVrQE9wIIsL1N9SFfg9l+rO7cXlckMgg==
X-Google-Smtp-Source: ABdhPJx3RYSTCqCub5lOGXrHgg5jPvAqfn3GPah0zCRIxkTx6aci9KeM6XDoX5DGxOYQRxwXx1QUpmsxtpyJMg==
X-Received: from dbrazdil.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:7f9b])
 (user=dbrazdil job=sendgmr) by 2002:a05:600c:4101:: with SMTP id
 j1mr308618wmi.110.1627486363975; Wed, 28 Jul 2021 08:32:43 -0700 (PDT)
Date:   Wed, 28 Jul 2021 15:32:32 +0000
In-Reply-To: <20210728153232.1018911-1-dbrazdil@google.com>
Message-Id: <20210728153232.1018911-3-dbrazdil@google.com>
Mime-Version: 1.0
References: <20210728153232.1018911-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 2/2] KVM: arm64: Minor optimization of range_is_memory
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently range_is_memory finds the corresponding struct memblock_region
for both the lower and upper bounds of the given address range with two
rounds of binary search, and then checks that the two memblocks are the
same. Simplify this by only doing binary search on the lower bound and
then checking that the upper bound is in the same memblock.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/mem_protect.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index a6ce991b1467..37d73af69634 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -189,13 +189,18 @@ static bool find_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
 	return false;
 }
 
+static bool is_in_mem_range(phys_addr_t addr, struct kvm_mem_range *range)
+{
+	return range->start <= addr && addr < range->end;
+}
+
 static bool range_is_memory(u64 start, u64 end)
 {
-	struct kvm_mem_range r1, r2;
+	struct kvm_mem_range r;
 
-	if (!find_mem_range(start, &r1) || !find_mem_range(end - 1, &r2))
+	if (!find_mem_range(start, &r))
 		return false;
-	if (r1.start != r2.start)
+	if (!is_in_mem_range(end - 1, &r))
 		return false;
 
 	return true;
-- 
2.32.0.432.gabb21c7263-goog

