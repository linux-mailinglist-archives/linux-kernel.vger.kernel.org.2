Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BE3316EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbhBJSm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbhBJS2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:28:17 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DC5C06121C
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:27 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f127so3371025ybf.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 10:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=k5i+QStGtQxdagBNJrvuN+hHOAh+jl0k4jqWkBv5Txo=;
        b=k+HQLP7ZAGZeXAn/ix0c4UhVWLdldPjZ/ibyMGb3EcJ5r7/SSlasbZ+peiPz4/dfeA
         uEH5B6bRD+SOmm4eWj6xiJndkk0yc+3PpNeQKqMFVbkxN3167GuPxWYqF4f3xVIx/Oee
         8EHYOGRtFSQxw+kOEtOxOGUOeCFlFcNpRE+ntpQoinGKhiX9laJ3bfuEgAacn/YQM+cl
         vzcse75GvtyndIQxoxO3ATIPRX76hclb2stNW5gWjzQSbBGryw8cQXTlVxRdSyakt/h0
         R/oS7dLb4gGHZJcOE86Y68qbBHhKMYJCQM1hvpuCHqh3g45VuoSTYRdnlnOepU+04GUk
         9Umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=k5i+QStGtQxdagBNJrvuN+hHOAh+jl0k4jqWkBv5Txo=;
        b=YUVy5q7/doEvDOQz55WusFZMOh5QQx2FvWXVPDEck7tukloBd9OjVpjNmt7E9Y96tp
         hAVrYEqRNxVw7X/+gyVAyTTcqFuZf+hzwBoPsuq7rC7jzvsk9tiX8dPJF40doWaKqUbU
         0LjoahDPqxtZtuFoQlCzlKud8TDB9wW/O/52yq56hkp72KD5wPR2csWq45Ny2ZwW65B/
         CP3OS/tvL/aCfDlHCFbZeeZ/nrhB0GG04L9RPMheTvlNLxWKa6zy61nvqaNTNZ2lB0EK
         3vqJ0Wfror1GAi7eliAJS3sjUkM+7Y9MAjTweRveT4+iHpYTsYHB308zkdUfMvJl4GAW
         0j+A==
X-Gm-Message-State: AOAM532fb9qrvFQcn7Iu0hwqSfVHM2GUz2SLXaqK0Hb00ufnCjnIP+wO
        sKRs9V7XDbPW4tY6r1nFqLc8iTCrn8M=
X-Google-Smtp-Source: ABdhPJwsbfpnnRhdi/WJEW0HkFZzjg18vDB3jDEI9My/tl73gxM0LcJP75gzxbp7QADg77Mvqm7ahgtBfPQ=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:11fc:33d:bf1:4cb8])
 (user=seanjc job=sendgmr) by 2002:a25:1e42:: with SMTP id e63mr5919281ybe.270.1612981586793;
 Wed, 10 Feb 2021 10:26:26 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 10 Feb 2021 10:26:09 -0800
In-Reply-To: <20210210182609.435200-1-seanjc@google.com>
Message-Id: <20210210182609.435200-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210210182609.435200-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 5/5] KVM: x86/xen: Explicitly pad struct compat_vcpu_info to
 64 bytes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 2 byte pad to struct compat_vcpu_info so that the sum size of its
fields is actually 64 bytes.  The effective size without the padding is
also 64 bytes due to the compiler aligning evtchn_pending_sel to a 4-byte
boundary, but depending on compiler alignment is subtle and unnecessary.

Opportunistically replace spaces with tables in the other fields.

Cc: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 4b32489c0cec..b66a921776f4 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -49,11 +49,12 @@ struct compat_arch_vcpu_info {
 };
 
 struct compat_vcpu_info {
-        uint8_t evtchn_upcall_pending;
-        uint8_t evtchn_upcall_mask;
-        uint32_t evtchn_pending_sel;
-        struct compat_arch_vcpu_info arch;
-        struct pvclock_vcpu_time_info time;
+	uint8_t evtchn_upcall_pending;
+	uint8_t evtchn_upcall_mask;
+	uint16_t pad;
+	uint32_t evtchn_pending_sel;
+	struct compat_arch_vcpu_info arch;
+	struct pvclock_vcpu_time_info time;
 }; /* 64 bytes (x86) */
 
 struct compat_arch_shared_info {
-- 
2.30.0.478.g8a0d178c01-goog

