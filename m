Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A71E42B106
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhJMAiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbhJMAiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:38:04 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F1BC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:36:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j193-20020a2523ca000000b005b789d71d9aso1277267ybj.21
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Ur67iQAkeqlRv9mxlrBpPoT3NcIyXRW0G2yRaXW02qI=;
        b=YQb07mKwbr10fxF1UcmqI8DkNWqLkuUT8+dr7LjyhpZWTEOoHprPTHMmj3jOM12koF
         MMZyob7gLPEMkHDhLf57f6ema1WkqYfzC21l1e43H0/BEZLBRBEZ97oNnm2dxMmGTO0f
         xE6ueSmqND2eTuG8v6GCgcYtUaVlcV9RlU+//0H6XzYcfixD6/ucFB29reqLxtICxhfw
         KdZCazoo0k6UpIcd8VAlphTXfN2vrejL9VN5iHtMSPtXEP98v3QZExK9QNvjSK3R1jv2
         2Y9t8/0W+wodMYX13lUrJKl4Dj0f1YQ5HkNJSC+uud5kwU0yY7xClY4ymwhQnu+8ZnNZ
         3D2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Ur67iQAkeqlRv9mxlrBpPoT3NcIyXRW0G2yRaXW02qI=;
        b=O09CHEajisIfKqxGN5oLG2PhxJRmHzoNV5lppXJl6RFajZaHX5xESRFxR9wZio2wI1
         reVXk6+t4AOLCbWhKGBz68YgOnPD+oxYUWK4M3r5cSpfk72f0i5IYXvtkqWPyVt+oAZU
         ap498ZxqZQsBUE7Yczx3b2vb+gHkpzT4IhnG4EcdX+mqGk87GpDmngtG7nzSIXT/oLKR
         t0NEVwGPAxhP7aOtnvqBfaN87LjTLIMTllSbdLwUeKbh+Ez4I6m5q4JR4yHIGCCHuaFg
         tb4m1xXsFMFFR3HI77w7IiPsmIgLe/A2hu5KdnVF0T3O1dw2Kd7R+23+Q34/FIzXbE5l
         Y/QQ==
X-Gm-Message-State: AOAM531fjzPxQCF4CCfe6Tksu9HuGSZRTh9O+69s8yEiUbW/cGsc9flf
        8rcXMiYtr6uMLx3mgWI4qN8q0qlP2c0=
X-Google-Smtp-Source: ABdhPJwyy6oF7ZIdto6mAUgPKZ9Rf90ti6UzVqI00XsbG6KKN2g13iSOxOmNQN3UqJRmHAtAxsNKnvp0LMY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:e55e:31ed:7b83:d4a6])
 (user=seanjc job=sendgmr) by 2002:a25:d3d2:: with SMTP id e201mr30426257ybf.260.1634085360999;
 Tue, 12 Oct 2021 17:36:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 12 Oct 2021 17:35:54 -0700
In-Reply-To: <20211013003554.47705-1-seanjc@google.com>
Message-Id: <20211013003554.47705-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211013003554.47705-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 2/2] KVM: x86: WARN if APIC HW/SW disable static keys are
 non-zero on unload
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+9fc046ab2b0cf295a063@syzkaller.appspotmail.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN if the static keys used to track if any vCPU has disabled its APIC
are left elevated at module exit.  Unlike the underflow case, nothing in
the static key infrastructure will complain if a key is left elevated,
and because an elevated key only affects performance, nothing in KVM will
fail if either ey is improperly incremented.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 7af25304bda9..d6ac32f3f650 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2946,5 +2946,7 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 void kvm_lapic_exit(void)
 {
 	static_key_deferred_flush(&apic_hw_disabled);
+	WARN_ON(static_branch_unlikely(&apic_hw_disabled.key));
 	static_key_deferred_flush(&apic_sw_disabled);
+	WARN_ON(static_branch_unlikely(&apic_sw_disabled.key));
 }
-- 
2.33.0.1079.g6e70778dc9-goog

