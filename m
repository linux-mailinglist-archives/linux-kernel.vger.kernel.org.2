Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB80369DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 02:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbhDXAtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 20:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbhDXAsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 20:48:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39021C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n11-20020a25808b0000b02904d9818b80e8so26105969ybk.14
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 17:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=bZhFtNS6H4/qf4I8RWVJ2+WzcwhJXicC5JMUikKYnuU=;
        b=jFVVaBFZMcDYN7hb4egS1sUaS6IMOo7muvsB5U4vo0ARzbvBBEorLBvCAW/At38u6N
         Rox4cksEOHGe8nBD7fxsO0TK8JrEKwIAs8aXMT8hBdvkFrAYUzU6t3o0aHlhxTtPTkp7
         oABbrSeMftw785UuunwjeGx+eg8khpZDWI0R7gjLo5wJrSaZisYbZWub76DXwmSPHRCC
         Plnmt9gApth3A0lCrYWwctC6MSLbbYhsr+wWcHaM/oEeomqvRncWFvhpVLQNYufxO8tv
         NyTWauJC27FU95S6wBSZIYW6+vDBi59LSChLyQ6GBt/6CHl4MfiGw2UOltARSlRxSbdq
         SZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=bZhFtNS6H4/qf4I8RWVJ2+WzcwhJXicC5JMUikKYnuU=;
        b=lYrMYo8MjiuMamZ2gZxTXMG3djaTTq91FdQWu41rcztOhO0q2jFzIQUbmNhKLW5epw
         SBL2TWXCQFv4v7erKpHWOSm0MGl3J56B+ovcxxudJVMEjNdaxvMcsM6VN1cXZV/+M0SB
         GS5o3Kd0OeOeRIBzhU5svGL3DT5lAT4OLz0lAuAugG9diSzbu2LQKoE6r03UVEacmZc/
         5TvnYFo3GPQ+Y+Y71yXB8KTj7CL1jGbPpJRPZPFe+dCXLvIqzzMBqXNBmxwZSkQDvX3U
         dJvg+aquPTAm5wkQyxhFQRavxA+TaML8s1IEt3bpUmABZQdr7jENnk6xGbz92N6pEMWa
         q75g==
X-Gm-Message-State: AOAM532Zg0OnozUx21HV+pBlSXYlyWyBDIS1dyEsqtVda3klMCkX5jGb
        1mSIHovvptqVYUJb7JeUQDNygI1sgVk=
X-Google-Smtp-Source: ABdhPJzW7SSyk1RpTzdj7JWWqLsRpSIgopTP0PSz261q7zhylYUyaXFATUOLvvXvDD5ESYWQsrYl4ze9zeg=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:ad52:3246:e190:f070])
 (user=seanjc job=sendgmr) by 2002:a25:ba83:: with SMTP id s3mr9551305ybg.280.1619225244508;
 Fri, 23 Apr 2021 17:47:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 23 Apr 2021 17:46:13 -0700
In-Reply-To: <20210424004645.3950558-1-seanjc@google.com>
Message-Id: <20210424004645.3950558-12-seanjc@google.com>
Mime-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH 11/43] KVM: x86: WARN if the APIC map is dirty without an
 in-kernel local APIC
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN if KVM ends up in a state where it thinks its APIC map needs to be
recalculated, but KVM is not emulating the local APIC.  This is mostly
to document KVM's "rules" in order to provide clarity in future cleanups.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 152591f9243a..655eb1d07344 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -192,6 +192,9 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 	if (atomic_read_acquire(&kvm->arch.apic_map_dirty) == CLEAN)
 		return;
 
+	WARN_ONCE(!irqchip_in_kernel(kvm),
+		  "Dirty APIC map without an in-kernel local APIC");
+
 	mutex_lock(&kvm->arch.apic_map_lock);
 	/*
 	 * Read kvm->arch.apic_map_dirty before kvm->arch.apic_map
-- 
2.31.1.498.g6c1eba8ee3d-goog

