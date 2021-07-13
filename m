Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C8C3C74B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 18:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhGMQhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 12:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbhGMQgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 12:36:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B228C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c13-20020a25880d0000b029055492c8987bso27619306ybl.19
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 09:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=2p0iOguwtrAqfZk6csdNwTfhtvIQqe6ewaUZHjQW6QQ=;
        b=bwqJvkBxbRL0/g4Xzd9Ql1plZAvQNrdXHppJu6oYhco63ZmuP/tVS8P+zbXYdG+ZGc
         gvw4h+9xWoxBp7Ni+vvzkMwTXdP2uW98D7eyuH9AOUG8tN2CSZnhEbvrvAuNV+T7jR0n
         PbRRy+RcA+q5hJJ5GEKfy6Hpo6oV0P35P49kmXnx7A9Tbn9b0VHHjCRQJFQB96C9DkR9
         FwVAqAxZejhBCiIYw67z9X1NLxGm0y8/uXQfYZr95I8YbCv8/Utet/LN+oXxYvtrD/Fb
         KpNOmI2OBjI7fXZqKkzTI52M118bhAV6FYfVnVU13byy7qYBGMQkF6JBtCYqlybSquwz
         phJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=2p0iOguwtrAqfZk6csdNwTfhtvIQqe6ewaUZHjQW6QQ=;
        b=avUIEo5toQ1K33bwTJo88oc/OMQPcOYIh/lUfAwyk5RsEkUkvOFLxw2hWc7ILnPIjX
         /aVNA+S0ooAQ0QFnAiAhAcpj23AYfAtywp3mIvKVbRfyIoPEXo2RhzPDZsWhc6aoBn5i
         rshSbUwn6VIqML8HYeldwFRPsufIRnNJHLgjQUfTF3pT7BXprlKFrQjjrjLug9carHiM
         vK6+8G49km7I0bwjSBesZtkj0fzATgrojxQfun6HLmaE4TS2e9eZIP8E4iy96OppH9LQ
         J6Wy09a//Dsmrd0Lz/nGpY3q2Ct5oJj93KAknFopklseYR128iX1/mpsWLyaGIitfx74
         J86A==
X-Gm-Message-State: AOAM531Cs+lsb8yqbwHFDeyszQEo7O0rvDzut52wHgDqybY+KYS1epVN
        tx55fv/XqOuY7i+UynKp1O3pfjNRjI0=
X-Google-Smtp-Source: ABdhPJzNTBWmA3tPCuNn4jseNgyZpSNd1p78BX6a4vgfI+qwfUwp5NwdI/d8xzHu1U1caO3EMzuVHOinO0I=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:825e:11a1:364b:8109])
 (user=seanjc job=sendgmr) by 2002:a25:f827:: with SMTP id u39mr6778858ybd.100.1626194035426;
 Tue, 13 Jul 2021 09:33:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jul 2021 09:32:49 -0700
In-Reply-To: <20210713163324.627647-1-seanjc@google.com>
Message-Id: <20210713163324.627647-12-seanjc@google.com>
Mime-Version: 1.0
References: <20210713163324.627647-1-seanjc@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 11/46] KVM: x86: WARN if the APIC map is dirty without an
 in-kernel local APIC
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

WARN if KVM ends up in a state where it thinks its APIC map needs to be
recalculated, but KVM is not emulating the local APIC.  This is mostly
to document KVM's "rules" in order to provide clarity in future cleanups.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ba5a27879f1d..add4dd1e3528 100644
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
2.32.0.93.g670b81a890-goog

