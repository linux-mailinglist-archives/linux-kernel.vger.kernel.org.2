Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC282367762
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234689AbhDVCW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhDVCWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:22:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1929C06138C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so18267083ybo.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 19:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=xV1In29Y6YEryY5tCZ1OMfBVFbGOPZx6sCXlZ5RL1p8=;
        b=Jb/81HkenqAKVtXbUhkJksYMzFx7vOueqUoQ+FaitFN49C08OYMY8JDKTQkX2baj8O
         5KB6XIlX/uQB352pkMYA41vvWaogPc2mIYaXix9Rwqrvr8tBU0rT1Nh4a5BE0wF4vi35
         cP3VjrOT9pQfmQVPJB/GX7biQ7JvbwHG0gUD+1HgC5v5ZrYmPhQGUE/koZQY5+V0w+ZV
         mmP/QaLBmyHI5iTeExyWyAxGXVjQ8xlku0OJPNSK0YDYS8uiy4XdhZ9iYTNkVT+WijpN
         LNrwG8i8qi67Ezu8SJRUL7WwaJBkZJMxbyqT8uTl5PKe6589b2080hCZlmsrNfCCz+T7
         iPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=xV1In29Y6YEryY5tCZ1OMfBVFbGOPZx6sCXlZ5RL1p8=;
        b=cpp+erwzOUkPRvFImjEVJVbMWQzo2jL/UJKlaAJ2reV410EI1LoGjZGaWICOeHWzGa
         TIacQIdWbueJ8mXGYZ3ao7U1JG6dKviOe9vyQRHdTVOpuF5kXH5iu0Hfh/JCuuZ23GmR
         sX3BMfDCAtv8iAk9vd3nH2wzHgJIVhXD9PgwEV0+YdlWqmhaz9fKCKfSGroJk8QkoiXT
         MJygt8xzT5+ZE8vv9d/tsLuBK3BvVkHKnhSc39Yx8LecdDTI4CiX9w1q/06whIe1i4re
         3byOtRy7eeSBWl1Var64MmVGhQiS3qDi2XYGYq3ooC/awnLuv6dQ/JpjCush3iHx/yqm
         A/hQ==
X-Gm-Message-State: AOAM531s3+1fL3TeXuEPbggfo1CNtd7w3JP8lptpDR/TimueMUKkAGOn
        OwRzflhSqm1YHGObqb8LRNc7hGf+Prk=
X-Google-Smtp-Source: ABdhPJxcLLryq94UfQMF0/DxZoXVAV8YiSzIf/YibaKUlOLioXkOTIGxBhvQfoacNP701GZIx4UYvSMKk80=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e012:374c:592:6194])
 (user=seanjc job=sendgmr) by 2002:a25:bfd2:: with SMTP id q18mr1434457ybm.127.1619058106949;
 Wed, 21 Apr 2021 19:21:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 21 Apr 2021 19:21:26 -0700
In-Reply-To: <20210422022128.3464144-1-seanjc@google.com>
Message-Id: <20210422022128.3464144-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210422022128.3464144-1-seanjc@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 7/9] KVM: x86/xen: Drop RAX[63:32] when processing hypercall
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Truncate RAX to 32 bits, i.e. consume EAX, when retrieving the hypecall
index for a Xen hypercall.  Per Xen documentation[*], the index is EAX
when the vCPU is not in 64-bit mode.

[*] http://xenbits.xenproject.org/docs/sphinx-unstable/guest-guide/x86/hypercall-abi.html

Fixes: 23200b7a30de ("KVM: x86/xen: intercept xen hypercalls if enabled")
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index ae17250e1efe..7f27bb65a572 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -673,7 +673,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	bool longmode;
 	u64 input, params[6];
 
-	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
+	input = (u64)kvm_register_readl(vcpu, VCPU_REGS_RAX);
 
 	/* Hyper-V hypercalls get bit 31 set in EAX */
 	if ((input & 0x80000000) &&
-- 
2.31.1.498.g6c1eba8ee3d-goog

