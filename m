Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F4A4221A0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbhJEJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhJEJFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:05:13 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FB0C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:03:22 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id x23-20020a05600c21d700b0030d23749278so1028714wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IJ5d9LFfxfsfjOyzMb9wAWVGNaAsBq4D1S2tLUmROQw=;
        b=k+C6KttgJIhWI0N6my6Gmd+ifempL0NxliApNM7bNFc4Zypp/266/edmPpEdSuDO6k
         BE90f8QW/H93+LTSCmLBuGx6sAqz7pvyDbd+uGNlrq2s33VlMhGlGZHNhEJGQskmS7Sq
         H3A4s6gUk4VgPHHkYEMLWraNS5mgRAPw+PZ4EBgI3WL0zgszOi1M00F1dadnofYdFWon
         FgyIwwZ5d7m1fgmZMM8TOnwJdR2xercMi9sTasNLWYOOCQ9DIzXjssEiSBg7PlQOcvX5
         L2sCgUPBIptqZ2kWHkne6YuTtKba/WcDG0cGnwu/hL7rHcLbGW7NnTteqVrtdarf8XNk
         zYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IJ5d9LFfxfsfjOyzMb9wAWVGNaAsBq4D1S2tLUmROQw=;
        b=yLvagOP93/oATjnVdFgUq/6tU2Y3hmdtfhTCTzpulRfG6kdgxxUnORz/QJA25vjUTl
         0oTOY7cyiuh0VYdwqqW8IG/bHpgt2W8EEhRarUkmmHXw/gIDu2zyk4hG8Y7I2mE1xIlJ
         E+dqZjJGJ9fbyYorrVPoqxK33kD1PBux1fkLM3wfiLcE4vNGi8hpdaLCcjyCl5l6wQyI
         V9FMEX0asQ48chuudgE5d8yWlnbfVw4omYDrM+QKAAlmTCFlboxsToECaPBbNhhVsTal
         oNA5QQKP3xNVDZ69ufm3LDss8kG4tOBXhS1wo2yGg7HM/51bpv1iXJjG7plO/bhqCM+8
         VWJQ==
X-Gm-Message-State: AOAM533DltzdiIr1txPMxGSXOGCcT++xBmyyjZg8ybvJPjtEBZmspp8p
        LVHrAFY2SML3dilDy4EuSf41AduEDZQP
X-Google-Smtp-Source: ABdhPJyWTqPJLcSZAfXhuyYllToltNQE4ex6rZPSYifRYSyemm303hl/IP70LZOn0VKNHsWefxffl1TuuHTX
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:5700:9128:3106:b389])
 (user=qperret job=sendgmr) by 2002:a05:600c:3b26:: with SMTP id
 m38mr484791wms.0.1633424600779; Tue, 05 Oct 2021 02:03:20 -0700 (PDT)
Date:   Tue,  5 Oct 2021 10:01:42 +0100
In-Reply-To: <20211005090155.734578-1-qperret@google.com>
Message-Id: <20211005090155.734578-6-qperret@google.com>
Mime-Version: 1.0
References: <20211005090155.734578-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 2/2] KVM: arm64: Report corrupted refcount at EL2
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the refcount manipulation helpers used at EL2 are instrumented
to catch a corrupted state, but not all of them are treated equally. Let's
make things more consistent by instrumenting hyp_page_ref_dec_and_test()
as well.

Acked-by: Will Deacon <will@kernel.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/nvhe/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/nvhe/page_alloc.c b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
index a6e874e61a40..0bd7701ad1df 100644
--- a/arch/arm64/kvm/hyp/nvhe/page_alloc.c
+++ b/arch/arm64/kvm/hyp/nvhe/page_alloc.c
@@ -152,6 +152,7 @@ static inline void hyp_page_ref_inc(struct hyp_page *p)
 
 static inline int hyp_page_ref_dec_and_test(struct hyp_page *p)
 {
+	BUG_ON(!p->refcount);
 	p->refcount--;
 	return (p->refcount == 0);
 }
-- 
2.33.0.800.g4c38ced690-goog

