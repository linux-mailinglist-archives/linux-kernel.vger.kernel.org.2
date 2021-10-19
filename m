Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FAB433590
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhJSMPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbhJSMPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:15:23 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3EC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:10 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id 75-20020adf82d1000000b00160cbb0f800so10084160wrc.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tdsCErEUABqyyQ1mbx3uMSi/aufrxWWc3XxvUpZyi6c=;
        b=agqompm2B2MZmrGmB/gxpWpG6vgaVYlKU4CIg03TGpGC+4aalw5NfoiD3nd16AtPKC
         +DDl3VZfg72c4W3xGXNnVhohTo/s1mh5Cyu5/QSadO0RvwtMUqZBiqtMAx328Fh9wqjq
         O0Nnn+TUupK1jSkoQ6zAv3/qn9uizgYDbldXMVCRDlXhC3lCi4AOj3ogrxk1mN+ucv3t
         cBTjLmdxquTpk/VsYC9VrDb0/yJLDYC7h9Lyd93revkEa0NK2jXBGNPbXzqtFp+2iCfn
         x3H7XuI7FYVAgUe1wh0Gh6d7Wleobtrh8ZGRAvmytblQRuG07xpaCyWW6Wf03jkJTJVX
         x5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tdsCErEUABqyyQ1mbx3uMSi/aufrxWWc3XxvUpZyi6c=;
        b=3a8la2qWyB1PFK10RiWsJYaOXyMdmVIg8HmajNdUpr/MemTDwOUyD5+7mwBET2on45
         0hIP54H69mdZBqziBws8PNbXZCnArD6lvGd3sikwGDFG9GQNDBxc1qoUKPAVDbQROdlg
         3TEXmerPMb1TvxS7dU6OCdQCX3ww7zwV/SYKtTl7y99rDZJq8KPeVwebVGM8PngDAJVg
         qVcyumkhy38/3VqXzb5/z57QMhTtaccspZe4wZd5t3J8x96hAg6GWGQ4wA8di/8/KPyJ
         NIEqgNra0uwLQhTPKzsoLnC6hHgkLWzshsvaNFsZQKlreVmCiO8BNbYg79jc+KaxEc+n
         YaYg==
X-Gm-Message-State: AOAM532qalQuevC6oeUIglhY+OWVT1w1mPQX7Psd2bRxBzP7BwcrXnQm
        oupm2Lr7VL6FsnH0T8pVtYezYA3P+5E2
X-Google-Smtp-Source: ABdhPJwSSTIWtOO8ktVy4rHrNPU+CIvJsJy3oLDvfo1jOaII6PMNjG5KAfWEfB/Wt+zdj/T+fCLv/8OQmHxo
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:59ca:401f:83a8:de6d])
 (user=qperret job=sendgmr) by 2002:a1c:5417:: with SMTP id
 i23mr5564552wmb.17.1634645589172; Tue, 19 Oct 2021 05:13:09 -0700 (PDT)
Date:   Tue, 19 Oct 2021 13:12:50 +0100
In-Reply-To: <20211019121304.2732332-1-qperret@google.com>
Message-Id: <20211019121304.2732332-2-qperret@google.com>
Mime-Version: 1.0
References: <20211019121304.2732332-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 01/15] KVM: arm64: Check if running in VHE from kvm_host_owns_hyp_mappings()
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

The kvm_host_owns_hyp_mappings() function should return true if and only
if the host kernel is responsible for creating the hypervisor stage-1
mappings. That is only possible in standard non-VHE mode, or during boot
in protected nVHE mode. But either way, non of this makes sense in VHE,
so make sure to catch this case as well, hence making the function
return sensible values in any context (VHE or not).

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index da10996dcdf1..0019b2309f70 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -239,6 +239,9 @@ void free_hyp_pgds(void)
 
 static bool kvm_host_owns_hyp_mappings(void)
 {
+	if (is_kernel_in_hyp_mode())
+		return false;
+
 	if (static_branch_likely(&kvm_protected_mode_initialized))
 		return false;
 
-- 
2.33.0.1079.g6e70778dc9-goog

