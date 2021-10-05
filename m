Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CCD422199
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhJEJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhJEJEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:04:24 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A99C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:02:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id e2-20020ad45582000000b0037e7bdc88d4so20661210qvx.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wkyuiZINwNBLMyCf2gjjqTHN+Go0IESaSFToIb6F4Fw=;
        b=EKFnh/sXPfL6SyxAQSUAY6zRBxqFcb3PSl/vj5lGE5JSiKVIYXjqNkN1c3ma+yItZf
         Sk0o0NPthUFScy8hUZ0wwOootL0G4y2vL/YJuxg3Dtw4kvPj4ocxd0/gXRLX1ih/LGSv
         kJieebl7g9OC5vkrvzjJ+WIu1oy3uhPGasNwC17W2CNL4nezRMLhlsl77YmYptBherI1
         RgFFqaUthvhyo277EzH+4gHTmvxLf9dWDJ31uiYuUcGjUlwSsAR0phVTLp8+gM3LfCBk
         kOW+OG0MAYoB5rguVBaWbIDO/tcBdGv7n83nZne3vgNNIs3aqfeDZM4jt3A7FSzg85LE
         AMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wkyuiZINwNBLMyCf2gjjqTHN+Go0IESaSFToIb6F4Fw=;
        b=FokEKW9PbFlLqfSw/qAoRIAw6yD/PuZ2QFjQA4FnerorKavI08XlhSYVy7QxYCObSd
         gCEWTIqC0SOQxsDppXJq2nNKznVDUhXBAiDybIFvlfXu4f4DUH9SKmox2Rd1UBHOWDmH
         EMoSmw2tsK8k2IPXe3kFNCy0J4qCnqLV5qDeAs1z4Bh0nYvin95HYttPtizRTeqDnLiM
         j/zJwCBFMC3Qcjagv1Em19kV6pzfFWiIJszpxuxtNLud1N/n6qxfDvBHDyX1RBIWAQNe
         kJousTraVkjDIg1ViFGerFVbj6XWRY45lzWJMA0Jws1JfE8cP3ycPETQvKka+T6AFe8f
         XxlQ==
X-Gm-Message-State: AOAM531xipaka7T+0VhnQwme6dVZACD/AtpWMwiT6V9ReoasXI2GIvQ4
        GmWm8E6zitFgMUWdufePBBl1e66E3S+v
X-Google-Smtp-Source: ABdhPJwLRnkFWRvGHIY32Rqa3Eiquzx86qZPVIsgO2JHnhRBY0a0MNCuAi59I89wj4Q70Jl6kpZxagSP7sBv
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:5700:9128:3106:b389])
 (user=qperret job=sendgmr) by 2002:a05:6214:1267:: with SMTP id
 r7mr9710216qvv.16.1633424553449; Tue, 05 Oct 2021 02:02:33 -0700 (PDT)
Date:   Tue,  5 Oct 2021 10:01:39 +0100
In-Reply-To: <20211005090155.734578-1-qperret@google.com>
Message-Id: <20211005090155.734578-3-qperret@google.com>
Mime-Version: 1.0
References: <20211005090155.734578-1-qperret@google.com>
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

