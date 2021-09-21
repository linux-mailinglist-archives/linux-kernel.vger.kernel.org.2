Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D00412B31
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245286AbhIUCKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbhIUB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:57:04 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21904C06B66C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:03:11 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id u22-20020a05620a455600b004333191e844so57095311qkp.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 17:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=qy6jnuw2GHlynPgzbk2CZqujQi44xwunFVHUnFWapBw=;
        b=atMRoGvtJcJ4uvVqbduvJvc99n3a9PyUuCDbBDOizbGTnbkFKk6asmcxJsiMzmVIkr
         /va1+9qWt0uDCdW3jVw64vHTYpuB5p6JIPj1XY0+AG296sVHW1Ztyv4c24XYh5ixF5yH
         FL6svOJFw1OFkiX09Mmf1FNyb+jY4ZFB+yzhPWNKRSzeoAMBXxnJ5UzpAHtoERnBfm16
         C4Wi1MeCivz7mrM6Mkuda8SacLpZQsENqYigvBfEzK5WhxjcZh1kUzlQWvhf7kzoUGGn
         HasvrTgPLXLMR8Ou2lGPnjZqNWvNyS8bmNy4EUgkkBOE5lPLl8TBxAHiHWXyP5/JIdjI
         p0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=qy6jnuw2GHlynPgzbk2CZqujQi44xwunFVHUnFWapBw=;
        b=L6UMLQQk0fsXMbjVMYb9y/u+5Gwsi6QPoxAx/uqYtCq+EPIJ2kNxe6gHk/3QVjUytu
         XUlNBnb6bHGHFIMMYFkzYb/8oa5411bq9zQX+VF/FIr1DAPJttIzrulwaDWZ002qtJoS
         +6sX5ySDP0qaLqo9sU7zFvexQZtK7KjLH0xYEy6gqbVeg2NHywLE2faRk56f/Qcw5QE2
         mGwkmHYaVj1xnn5zplZ8gofm4fdnd53Kt1PtUv3DShrVfPwu4D+il2Ib//wlOraCtiWz
         3+7SB0WVmFc25SwpDENjFAvP/LkhykdOwhNPFU2B14+fTytWfTGofEmLS0rCsEd4UeLE
         P8gg==
X-Gm-Message-State: AOAM532LerfTI6s4EZWHAIXtIRUIXGhJqL3vYhn1R7mkIBi9BaDnPKbp
        VotnvEm/w1t9GJm7y/aflBAIhGbNMK8=
X-Google-Smtp-Source: ABdhPJyYy20E1PWeG4X2h35A3S9jwhu/QptShKwhi30DqtfKV4bWTw4znqUXz6Hlngh+2RzvST3vobdsvdU=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e430:8766:b902:5ee3])
 (user=seanjc job=sendgmr) by 2002:a05:6214:12ee:: with SMTP id
 w14mr28258154qvv.52.1632182590355; Mon, 20 Sep 2021 17:03:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 20 Sep 2021 17:02:55 -0700
In-Reply-To: <20210921000303.400537-1-seanjc@google.com>
Message-Id: <20210921000303.400537-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210921000303.400537-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 02/10] KVM: x86: Clear KVM's cached guest CR3 at RESET/INIT
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

Explicitly zero the guest's CR3 and mark it available+dirty at RESET/INIT.
Per Intel's SDM and AMD's APM, CR3 is zeroed at both RESET and INIT.  For
RESET, this is a nop as vcpu is zero-allocated.  For INIT, the bug has
likely escaped notice because no firmware/kernel puts its page tables root
at PA=0, let alone relies on INIT to get the desired CR3 for such page
tables.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e77a5bf2d940..2cb38c67ed43 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10899,6 +10899,9 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	kvm_set_rflags(vcpu, X86_EFLAGS_FIXED);
 	kvm_rip_write(vcpu, 0xfff0);
 
+	vcpu->arch.cr3 = 0;
+	kvm_register_mark_dirty(vcpu, VCPU_EXREG_CR3);
+
 	/*
 	 * CR0.CD/NW are set on RESET, preserved on INIT.  Note, some versions
 	 * of Intel's SDM list CD/NW as being set on INIT, but they contradict
-- 
2.33.0.464.g1972c5931b-goog

