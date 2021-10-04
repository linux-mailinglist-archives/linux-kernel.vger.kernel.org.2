Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A194207CD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhJDJGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhJDJGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:06:02 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11377C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 02:04:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id kc13-20020a056214410d00b00382bc805781so5865046qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 02:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wkyuiZINwNBLMyCf2gjjqTHN+Go0IESaSFToIb6F4Fw=;
        b=TMjOfQHcr/Buzl+oIVWhFVyiArxE1cZ3vpKMWyLANeP2U9TxY8SYN5pke9uBTQYz+U
         RIB1ZRrnPZHnfENtF9YmVzL5b2dsm+8nezApYrkcELyYsTgIxCXqXNO1hgtl+kxWOHqt
         YYimqCXssd0CsMUdzG3aiDaPHuW0jO1FRRSQN9CmPVoQKROHZ0soqL+iSp+ePqyxkxJ4
         aBBfUHuRZy/2zMpYKVQ68s/iuanxLmWb85P3CroP0EVlbrCmCoq91Okjk9cJ5jEAWbgt
         MbAZGlaksbCy17axlm5ayqNk85VH9Kb4lIdjYPdiad/U6IoxI4yhM1WcNa0iTDKHwSHP
         B1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wkyuiZINwNBLMyCf2gjjqTHN+Go0IESaSFToIb6F4Fw=;
        b=nnoqzkXmm7jEA5a/ouVH5gJCtSmfZIfSGTZ6i1+PEzI2k0gDmmgPe96TJwHI9QmkTN
         TFWkmqcaGcd9CHyj1Blut3uBLWHZ0zMXvcsUY/uzvOhNU4pI9ILaGXNC3CIXydMjqGJ4
         4ubAjMYKC7jdK3ZKr14+5ZWsqLpNc/2ZlHHNzmcHN2GM0zxd1zaHhXMwBrvrG9cFXikX
         O76bXCPlMTsczJHLGho3b4WynHxbHxPQM605maFo94Cl3qI37LTBqKt4488dpt5Ouu1F
         0pEJD9IkzeNemJO8rRGLEYhKA2VcvluEa2X8VaoGwC2hcuBXVK3LbRABTzIa0DGn4ec0
         tv1Q==
X-Gm-Message-State: AOAM530z5IxwX0uFB1SLP5J+Lgg4P3xJFABEmGpMdcTXoVaHfzwWeuyk
        BLs06XtYXt9o7/ZuBTGS/PBfQaWj6/Tj
X-Google-Smtp-Source: ABdhPJz17Z7ue1W7hq3hrv29ed/PiZ+fLhUfwKMW5antWu0eaJWy3bZ4lxRPpDIEYNfIk8cbjwcuEEkEbV4g
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:669b:5b16:60b7:a3d4])
 (user=qperret job=sendgmr) by 2002:a0c:85e6:: with SMTP id
 o93mr21326866qva.16.1633338253264; Mon, 04 Oct 2021 02:04:13 -0700 (PDT)
Date:   Mon,  4 Oct 2021 10:03:14 +0100
In-Reply-To: <20211004090328.540941-1-qperret@google.com>
Message-Id: <20211004090328.540941-3-qperret@google.com>
Mime-Version: 1.0
References: <20211004090328.540941-1-qperret@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH 2/2] KVM: arm64: Report corrupted refcount at EL2
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
to catch a corrupt state, but not all of them are treated equally. Let's
make things more consistent by instrumenting hyp_page_ref_dec_and_test()
as well.

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

