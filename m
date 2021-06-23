Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803583B23C9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbhFWXIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhFWXI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:08:29 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AB6C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:06:10 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id es19-20020a0562141933b029023930e98a57so4630910qvb.18
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 16:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ECxHPd8ARt3g/FbXO6kaB2YAiLV+c0qQVpIxsjvN8ho=;
        b=sEtH99jwiQ93AFFZ+4qGZKG6dGPffpY3n63kic4KqeOVt+fqR+Uuaqjvl2aPaOs5LV
         +kAOO2CbASDeHPRmOqt/NzKURFkBm6luGWNTqkWADfEsQKkEDyk/v4fPH7zLfREIo8nS
         VlR9OensOnYHTVVaqLwGXPkGTdFY8ZsdPz0jRF0dSt11MlKK5XBqT0yKVrJBErLszjD5
         l+tQEpYQELkuyN5LBtOKNsJ0S8HEGlQW1ZbIYrCKYdUA81ANlFmwvgmxlj/FPUs38ywk
         xHkha3JfyoMkZ93y5B7uADrAJtxUP/QrRQ5h9Q0ljV3nO7y3rKi7Ud8kNpOiz/xLIRQF
         dqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ECxHPd8ARt3g/FbXO6kaB2YAiLV+c0qQVpIxsjvN8ho=;
        b=QdTCgJyo+SzOCOx/lPYglZqz9KS4l2Dk4hyBBHKpZ5sOkUGq56SYyoREh6J78UOGYA
         CW1ILpW3GU13811sQDKr42HoSEuCCvP7JehS4OGXJLxyZYdn3QiHD0dTcz7CQsfnoD3e
         cx0hzwTA+LTtGTVKL2aI1LAEhDNp5QAUPEv4/V+wfW9+LXcULjR9OOjbO9OwY+687/G1
         6GqaS8vgPmChRH8wGhFuaUtzEIe49UR1Db2bJ7fsTGN3RzLoOLb0mhL/2CzpnqqZlB7g
         GPKKk3IWbRV3NaYiTL2ZuVGn/7LggK2oGud5FQV36+hetKyGxI+ZeIXcBcG7XpcMFBCx
         rUVw==
X-Gm-Message-State: AOAM532Uo27VEiQnUPaxAAWestUWWJlUqTZAKqgLct8d25SG3SQHrlGI
        AiuW6bPJw4Y9zQD24CeKG8W075EYM5M=
X-Google-Smtp-Source: ABdhPJwGGkYrzt9VXDp9VVzM6DTgXp7pCLDTPfh12+pCsTsoR+0WhHJK2RbX/l1BTJ0xgBwdpzwy9aOHv2Q=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e9e:5b86:b4f2:e3c9])
 (user=seanjc job=sendgmr) by 2002:a05:6902:522:: with SMTP id
 y2mr730525ybs.12.1624489569847; Wed, 23 Jun 2021 16:06:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 23 Jun 2021 16:05:50 -0700
In-Reply-To: <20210623230552.4027702-1-seanjc@google.com>
Message-Id: <20210623230552.4027702-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210623230552.4027702-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 5/7] KVM: VMX: Refactor 32-bit PSE PT creation to avoid using
 MMU macro
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Gonda <pgonda@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compute the number of PTEs to be filled for the 32-bit PSE page tables
using the page size and the size of each entry.  While using the MMU's
PT32_ENT_PER_PAGE macro is arguably better in isolation, removing VMX's
usage will allow a future namespacing cleanup to move the guest page
table macros into paging_tmpl.h, out of the reach of code that isn't
directly related to shadow paging.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab6f682645d7..f6fa922ca6e3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3584,7 +3584,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	}
 
 	/* Set up identity-mapping pagetable for EPT in real mode */
-	for (i = 0; i < PT32_ENT_PER_PAGE; i++) {
+	for (i = 0; i < (PAGE_SIZE / sizeof(tmp)); i++) {
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
 		if (__copy_to_user(uaddr + i * sizeof(tmp), &tmp, sizeof(tmp))) {
-- 
2.32.0.288.g62a8d224e6-goog

