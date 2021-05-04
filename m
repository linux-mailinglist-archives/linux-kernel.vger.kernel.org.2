Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC93C372EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhEDRSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhEDRSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:18:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9101C06138A
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 10:17:47 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a15-20020a05622a02cfb02901b5e54ac2e5so4024839qtx.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=zyk/CnPUPX4IZt1E/UCYCEZ+CYodKlkrWWKieBP0u40=;
        b=sXmep3CNmV6ncUmh4Bwt9ZAeJiSDP0JoBEhefkkGoDExZ3KWPbvsIU53JnIsEc8zfT
         2CLrK3Ev6uYm//ZTV8x3LBbl0pu76DCNtR4bhbBmeIoP1Yxz394XylT340mUTD2ikJIm
         +1cv0jsiXrLQd9DYbrRc3EM3FU169gR0ontu9WZBcWU/oftdv3RNOpv39sWk79rVQmhu
         B/zjoWAHBa3MpJXy4gwirrxumf1PQnWBGtr/HgGs/qyv9/i2JD56atdndo7MZm/gbzY5
         MFZ6Abd/WzdR+F5CHGnUmZQzWy1xnjK6u/Qywe7tLexPOd7WjMK9OLibvAMFXhgOgPAB
         HnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=zyk/CnPUPX4IZt1E/UCYCEZ+CYodKlkrWWKieBP0u40=;
        b=SIigVCfE3WSyfFf9xF0U+PKFvaCi0X2486xQ6vKDhj0YCbaXRhg4U35q12RpP1ye3+
         paxxACUcJ+/i87AcdV3TRQ728JBooSzZo3coUVVhf06pRqVVrMAre2mIVbfCaTlNWwA5
         LPoETPcyGnumkQ4pPXSqhqb1TGDPBN3yr8gL8jWpqnplqvP1GFX7aEKj6a5Rdml7xxTR
         3Mqrsn3qnsr7pzy0BbzZR8JwiaE45O1NTqlo+91678GCUJq2Sas7JsvVktDteopIey+O
         pCuhXVR5hMwxXph5QxXoLCrhYd/zM6/+UcwGIBU1k64ETiNhCm0UNaC52hNX4vcz4b2V
         olmQ==
X-Gm-Message-State: AOAM533Tdw7+CFiMqyFHEu2Q3VZrfkojWyHFnLyZ8fow34jPBCnjtwL/
        oXQA2N8ISg5/QMjvUo6+bj+OdqDbOVU=
X-Google-Smtp-Source: ABdhPJxwWT2eyWq3SHAnHcamuoyl+SuIC6Dyz9Xd5AV959ifFtMmBZB15+K8e6dS33p4FmM7eJNyadnHMuA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:df57:48cb:ea33:a156])
 (user=seanjc job=sendgmr) by 2002:a05:6214:c2d:: with SMTP id
 a13mr18106571qvd.37.1620148666938; Tue, 04 May 2021 10:17:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  4 May 2021 10:17:21 -0700
In-Reply-To: <20210504171734.1434054-1-seanjc@google.com>
Message-Id: <20210504171734.1434054-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210504171734.1434054-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH 02/15] KVM: x86: Emulate RDPID only if RDTSCP is supported
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not advertise emulation support for RDPID if RDTSCP is unsupported.
RDPID emulation subtly relies on MSR_TSC_AUX to exist in hardware, as
both vmx_get_msr() and svm_get_msr() will return an error if the MSR is
unsupported, i.e. ctxt->ops->get_msr() will fail and the emulator will
inject a #UD.

Note, RDPID emulation also relies on RDTSCP being enabled in the guest,
but this is a KVM bug and will eventually be fixed.

Fixes: fb6d4d340e05 ("KVM: x86: emulate RDPID")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f765bf7a529c..c96f79c9fff2 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -637,7 +637,8 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
 	case 7:
 		entry->flags |= KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
 		entry->eax = 0;
-		entry->ecx = F(RDPID);
+		if (kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
+			entry->ecx = F(RDPID);
 		++array->nent;
 	default:
 		break;
-- 
2.31.1.527.g47e6f16901-goog

