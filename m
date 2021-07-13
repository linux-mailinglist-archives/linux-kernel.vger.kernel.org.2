Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0713D3C749F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhGMQgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhGMQga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8353C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h7-20020a5b0a870000b029054c59edf217so27712557ybq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=CGUCznRdiPWAmsCMQFonxOBex98YQEwxWBKOh5eQt7M=;
        b=tJqwt8bZlc8oPW/4EXV9GTQdpI1HLnBQftLNu4By8/T3ToR8ArcbB9DvXcDFFNlyEw
         8WGUYedXdNMVnobO4pNadTycYVgvAqx+pU9fBKQwrveviacCgiUe18n1XQTtJECgVnSD
         nEmhRfmToc4gQ2EiDKpiUBqatrjl0o4v41mw6KOFeh08WRlBzWHqupDweD875Nm3LzCa
         SHBnz5mw89ezDDv0lxIOD1gXHU1dathcQwWezPxEEq5rSx9TWP18aTDg5gV02+V7DOde
         hHUG0LVjlHoKSJZ0QcOAIvzh0z4EjlVlPWvYe3LvuMPBKNJZGEmTikF22RI9jVnxvkDq
         CIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=CGUCznRdiPWAmsCMQFonxOBex98YQEwxWBKOh5eQt7M=;
        b=GqOb+4JhUVmebjxtvZD5vabL8ud53YQ00xo/Ow+eyGJZETbMXMecWIgvzNE8jt1syZ
         TqiyaZGWWYksC/ye8vZAN3L6hwu0+E18nmQF57jgQ6/qY9+eiCrx1G99Nn4EMfYY8Tpl
         htv6uV858W081SS9rZ1XV2dfSVkq05dLCC/HvTTsp23u16UNHocOfhqt2eClVkRP2Kz+
         oGzkjrE5zdoXAc2BpOJoCA2afWquf8Oa5aURQLa0qFCTLyau2APKNQAKjGcPcyIoxz6s
         rst6VbnG1g49n13XmwcxWXcY3K+YURLzY1ZhCkHWMDRl1y1U9bW+AO/4Q54PW3U/Aael
         nJqA==
X-Gm-Message-State: AOAM530y/FlIpv4LCVj/Rnf9UWM5i712awGZtQNjbyN389hpwk2Qf/Uu
        YUQh6pgMTkoPz/bZ11uen7bFlkztTHE=
X-Google-Smtp-Source: ABdhPJwCVfYAbbbuA0so14IArA0SM/M/g2EbwalCLw55NEUbXBxsGXZnNsPeOTln8DYQHm8nyn9QAMQ9+Lg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:ab41:: with SMTP id u59mr7079483ybi.218.1626194018438;
 Tue, 13 Jul 2021 09:33:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:40 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 02/46] KVM: nVMX: Set LDTR to its architecturally defined
 value on nested VM-Exit
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set L1's LDTR on VM-Exit per the Intel SDM:

  The host-state area does not contain a selector field for LDTR. LDTR is
  established as follows on all VM exits: the selector is cleared to
  0000H, the segment is marked unusable and is otherwise undefined
  (although the base address is always canonical).

This is likely a benign bug since the LDTR is unusable, as it means the
L1 VMM is conditioned to reload its LDTR in order to function properly on
bare metal.

Fixes: 4704d0befb07 ("KVM: nVMX: Exiting from L2 to L1")
Reviewed-by: Reiji Watanabe <reijiw@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 1a52134b0c42..7f8184f432b4 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4298,6 +4298,10 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	};
 	vmx_set_segment(vcpu, &seg, VCPU_SREG_TR);
 
+	memset(&seg, 0, sizeof(seg));
+	seg.unusable = 1;
+	vmx_set_segment(vcpu, &seg, VCPU_SREG_LDTR);
+
 	kvm_set_dr(vcpu, 7, 0x400);
 	vmcs_write64(GUEST_IA32_DEBUGCTL, 0);
 
-- 
2.32.0.93.g670b81a890-goog

