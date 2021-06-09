Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08E23A20F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFIXp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhFIXpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:45:12 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB842C061280
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 16:43:15 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b20-20020ac87fd40000b02901e1370c5e12so12478066qtk.17
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=AvlzpSEIa9aM5YGGjLq2zoHFMvduDK875CtYDd8dUL4=;
        b=ifbBgdC2nQ37DNJxiu2U2mgYs0uHPbXMIH2n+cwuFFAH3iKBe0qhAO5/HRlTdd/4gs
         weRLHdWGD9UbIn2pAQUz8rHljyeUxKHvtCbS+xVYvJCSnDe3dxpRkMXraJCLh/gyvhm5
         5yrTTOtc7Mny/qg/Gj7Vg4/nOw02qcWhgnsgPkIwueGb2ZabKjxzssvPCtXkp60CfKFE
         PmoQ45l64W4zQkJrONpN53AUoSBmF7Je3yLzxcZ5RUwEZrYHZLNwDeyGtEeFMYv0WR6g
         HNk4IRb6Qsrddzx8dVSpTL71KipzEdzcFYuM1HCXzJ5Hg6kSObAN4k3pBurFUMN3geqe
         de7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=AvlzpSEIa9aM5YGGjLq2zoHFMvduDK875CtYDd8dUL4=;
        b=bC3PSU1x6+X7ekqNBn/w+zlYdqxLeDDhy8KIXCKIlR7sRGkbc4U+FdjApyrCalaFZ3
         W7xL2hk3hGZc7NX8Z16i2iAtcea5BWlNYGshL8Jm1VicThzRzkzaA2STpaQDcR6z6DEX
         JGuTAYnVNjiistasbNhMVxwcIVTXA9F89SNyNZZb6d4mI7lgC6FjQD1bdla9tJd1GRv7
         N38B6HEJPDJlO+OuMo5DoGxxu57EAiLjehJAPG571c4Kmq+4JSSHKfbR8n7ekvA6XcZF
         3NI9txt9YRr7LPUXJGz7PqHG+DmSn4HiQyCef7uMiY+JtHBohZP0SSgdEnPS65Myc+Wd
         9yuw==
X-Gm-Message-State: AOAM532HIAt4UohSMlQhdUjkt+8/dI7TKTdT3iQpZghcXQLcxyspjUaJ
        dOJwqbV5rMX74U6Zvi7EhpNYBLB4NY4=
X-Google-Smtp-Source: ABdhPJx232hNBWou88XddItzp4JVduww7ZRV8rUjKiIgDLbiXVcQWPYtOjEGIKR1VhkY6bLEHvW6mLXOC/U=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:8daf:e5e:ae50:4f28])
 (user=seanjc job=sendgmr) by 2002:ad4:576e:: with SMTP id r14mr2569384qvx.61.1623282195011;
 Wed, 09 Jun 2021 16:43:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  9 Jun 2021 16:42:34 -0700
In-Reply-To: <20210609234235.1244004-1-seanjc@google.com>
Message-Id: <20210609234235.1244004-15-seanjc@google.com>
Mime-Version: 1.0
References: <20210609234235.1244004-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 14/15] KVM: nVMX: WARN if subtly-impossible VMFUNC conditions occur
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Junaid Shahid <junaids@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN and inject #UD when emulating VMFUNC for L2 if the function is
out-of-bounds or if VMFUNC is not enabled in vmcs12.  Neither condition
should occur in practice, as the CPU is supposed to prioritize the #UD
over VM-Exit for out-of-bounds input and KVM is supposed to enable
VMFUNC in vmcs02 if and only if it's enabled in vmcs12, but neither of
those dependencies is obvious.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index f686618d9ede..0075d3f0f8fa 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5494,6 +5494,16 @@ static int handle_vmfunc(struct kvm_vcpu *vcpu)
 	}
 
 	vmcs12 = get_vmcs12(vcpu);
+
+	/*
+	 * #UD on out-of-bounds function has priority over VM-Exit, and VMFUNC
+	 * is enabled in vmcs02 if and only if it's enabled in vmcs12.
+	 */
+	if (WARN_ON_ONCE((function > 63) || !nested_cpu_has_vmfunc(vmcs12))) {
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		return 1;
+	}
+
 	if (!(vmcs12->vm_function_control & BIT_ULL(function)))
 		goto fail;
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

