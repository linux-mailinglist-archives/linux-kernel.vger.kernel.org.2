Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC632580A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhBYUwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhBYUtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:49:36 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79221C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:06 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id o8so5480982qkl.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 12:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=R+3qyk75OyMv69ToYBZnoUD1V0Rjb1vbME1iuRO3dNg=;
        b=H5v2Kf6tbzCtssLZcl4hWSoGFPeWy7/JqV4By6Wycn1UfvewDWxDCg8TxM8YEA/W/d
         c44KERXz0vSFS3/fZ2ADSsMvbxx0OKIlQD9wIDyaoqqC7jhxSsbX6THRxkfrVuQjny+x
         QYDGMUsAZo5hpGcjOzeEvD05lWMnz+Q1E0lFczc3P7LnLGfhg8g8utYOCCOgVG91j2RU
         CAY1XlAedXlAnJh/w2kcePHLdvhXrBsJWTJGKWZTlGoOkJ4h0KvSbyaaCz5K+TPfi02l
         kricOdkcZ839sAdCjnr5PooTQQ69GAFeHNtmW0P5AV6K4bs/mYPCN1GI6MNeL5u2xRMQ
         8M4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=R+3qyk75OyMv69ToYBZnoUD1V0Rjb1vbME1iuRO3dNg=;
        b=lz0DShO56xp3z5pYw8Hwd1SNImDHp5WMhg+k0ORoZwTnNzaU+qHOZzjGZZP4bZTCoV
         IBrpmNu/up7TA+tdHO/Au7OQO5ek+eb7SIrly67fzo0XQr8X0hoy2BOTADoSwu+3BGA1
         u6rUMcyZ/oVXnxe+3WbXLP1lgBwqJ/j1lHTicq+yJAQ+t6nt73TstOf+GXzlDg/tyHBU
         hpL1xxoIEVpLwijbKc3gJs+mEmHkKDRqNIiAqxDD9Ncz0ZnlKlc6btbYe3yJF6iXzq2F
         6+SAD3fiHgXprtTLa/u6GA9dhtlfDI5FteCK+yJjrD9Rs3mCzz6RL2TmEY6Kzn7GTEOV
         9WUA==
X-Gm-Message-State: AOAM531q58TlQd6Tx3hXAV1sclQ8tYL2C3IFeKTJ8sdBwt6zOif1Xk0A
        a66j7mGMVDiIFbtMjZgjf880VIpDC3s=
X-Google-Smtp-Source: ABdhPJxOyOPXIcCg+rrBJkSmXlc0BLwBqSeKmuqOavbjG8Uj46/f/f07F7rzRgiF+LqY0AZrjl05av9TTXQ=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:34c4:7c1d:f9ba:4576])
 (user=seanjc job=sendgmr) by 2002:ad4:496b:: with SMTP id p11mr3307590qvy.33.1614286085594;
 Thu, 25 Feb 2021 12:48:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 25 Feb 2021 12:47:28 -0800
In-Reply-To: <20210225204749.1512652-1-seanjc@google.com>
Message-Id: <20210225204749.1512652-4-seanjc@google.com>
Mime-Version: 1.0
References: <20210225204749.1512652-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 03/24] KVM: x86/mmu: Bail from fast_page_fault() if SPTE is
 not shadow-present
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bail from fast_page_fault() if the SPTE is not a shadow-present SPTE.
Functionally, this is not strictly necessary as the !is_access_allowed()
check will eventually reject the fast path, but an early check on
shadow-present skips unnecessary checks and will allow a future patch to
tweak the A/D status auditing to warn if KVM attempts to query A/D bits
without first ensuring the SPTE is a shadow-present SPTE.

Note, is_shadow_present_pte() is quite expensive at this time, i.e. this
might be a net negative in the short term.  A future patch will optimize
is_shadow_present_pte() to a single AND operation and remedy the issue.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d75524bc8423..93b0285e8b38 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3061,6 +3061,9 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			if (!is_shadow_present_pte(spte))
 				break;
 
+		if (!is_shadow_present_pte(spte))
+			break;
+
 		sp = sptep_to_sp(iterator.sptep);
 		if (!is_last_spte(spte, sp->role.level))
 			break;
-- 
2.30.1.766.gb4fecdf3b7-goog

