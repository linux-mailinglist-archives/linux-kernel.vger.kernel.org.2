Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC37C31A954
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 02:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbhBMBIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 20:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhBMBG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 20:06:56 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FC3C0617AB
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:05:44 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id d10so1408283qtx.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 17:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=P+psZ8urjSB19xd68DRcw5VIbpFuXXaxHhSRR+LYyzM=;
        b=k6qkmAvojRBdZtQiL1P3/gZ3Ohf8rmwo3kI3u0nfcqM5xXx6p631Ajcjl7zcdiSRHw
         rSrO6ebqY02dZji0IdXk3bfJ5KOGfMWTqIEHeOxX/52Zirlye6uHVDxtE9b/IDBHvRMg
         em81wXDx2Jhw8H9RLPrAkYG/HGeB5hKozyuYvnjJPqLUrKf1n9QWMuJSFLigZ3fOum4j
         2/ObS62FRkWpAfG/DsdH1nX+jFmy9f4dP1o81l/TVYOlbhERATidBSkyhF5QDQtg1pCE
         OKGBlkJBVpi6IWvji/drU8AyH4AyrGrPJRERqG/70KuSCMqWJXjR3VG/8KB+shu6U8F0
         0eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=P+psZ8urjSB19xd68DRcw5VIbpFuXXaxHhSRR+LYyzM=;
        b=ILmoEMoOiaf5xH5jR1WEPz9oWYliXzHtGm28MAsCOcrSK6N3Qf7NaJIC8iTFl8p+F2
         qv3YA0P3Mh7v1KLudYP0wJTkv12ZRRXEdfcsUXh4yI9BntYjpM5060lNf8QxjPPfQyVN
         qxtj52t1dlATPR8RYxfDU5pePcPOsF5L/IaJ7z3BuS90cP56vggEudzeeahCjpqV0Ykr
         5GDryX1YiMhbk1aRZ4yw71udRzd+1Nv9zXpc40IgXs3OctqEgl5uoyfG+gvdwqwcRCBV
         fWmlMFoRdoek5/Jt0etn2pe5eeUoFZiF1dhfip4n0wDNIIk8RDt58V+sGOuTl56PEwOI
         VBEg==
X-Gm-Message-State: AOAM532KarDYtFgPdkuQt7y4PHrSypg8LyA9vUBVR72/9KQqg/5mP9yv
        PgUDGnyPc3RBpztuIFqiH7iVNO3p7IY=
X-Google-Smtp-Source: ABdhPJy0LFozKYfLKCDmm992FOaE4QAa6HOq5vsXSWWjOS4e2eIfXgPp1+BlwSSEBaBZnvdBtmc0SFrpE7w=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:b407:1780:13d2:b27])
 (user=seanjc job=sendgmr) by 2002:a05:6214:94a:: with SMTP id
 dn10mr5178605qvb.28.1613178343985; Fri, 12 Feb 2021 17:05:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 12 Feb 2021 17:05:16 -0800
In-Reply-To: <20210213010518.1682691-1-seanjc@google.com>
Message-Id: <20210213010518.1682691-8-seanjc@google.com>
Mime-Version: 1.0
References: <20210213010518.1682691-1-seanjc@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 7/9] KVM: x86/xen: Drop RAX[63:32] when processing hypercall
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
index af8f6562fce4..5bfed72edd07 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -383,7 +383,7 @@ int kvm_xen_hypercall(struct kvm_vcpu *vcpu)
 	bool longmode;
 	u64 input, params[6];
 
-	input = (u64)kvm_register_read(vcpu, VCPU_REGS_RAX);
+	input = (u64)kvm_register_readl(vcpu, VCPU_REGS_RAX);
 
 	/* Hyper-V hypercalls get bit 31 set in EAX */
 	if ((input & 0x80000000) &&
-- 
2.30.0.478.g8a0d178c01-goog

