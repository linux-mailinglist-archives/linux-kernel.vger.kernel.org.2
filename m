Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30F43141AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbhBHVZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236723AbhBHUPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 15:15:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9958C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 12:15:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 78so14491903ybn.14
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 12:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:reply-to:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=mgnW8xfhzGkssYeGVKL8OKFJiT7oGpD36C+YLUEs9TA=;
        b=oigVJzIQtqcKIBZDm0qdX4NdpwQ6YShdcaV1o/xGRooB0gzajPVvjJq100lfrHrhcF
         T1pAdffB/uYeXuzx8TjxhlctRkOCQNo+TvMT+jo0Psl6fEIomkdO8xDPV0fPEsZIvwcw
         MtFM6u/CauFDs+hv3kFBxRW1JcJidoQhvvUvZyqMtHXLQsxtboN9ldAuWxgpZ8p/sa1v
         wifOxro9QPDE9Qp1SxByCmaBO9S5m64s4BiVREWoczYgOx82VXGfCixwlSytf/woCu4B
         Wm8J1QB9vurDXXZDL1VWdJvnw8vCkYkyBUUC0OQ3TimAOxjR/QZJV6m+PMKwU9pbFMmc
         edag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:date:message-id:mime-version
         :subject:from:to:cc:content-transfer-encoding;
        bh=mgnW8xfhzGkssYeGVKL8OKFJiT7oGpD36C+YLUEs9TA=;
        b=AWo7zw9Vxgf0UjcWuBRaAUX7hv+IQ85YfbFwJkOt6xYwgHekwQyLmFvDoyfECSq3g3
         WWio8tlyN5KWc7b63eDhlMp4wZTnYn25kWTQjXYWezKCHIdAciRuwMi32ccCBoKcb4CV
         C8icJxbcoF+32gQdITtvt47O0ZIWnRwasorkU7819YtFqX1C6IZE5lXeki1866iP9mZa
         sNTlK+YZp9TLYMWEYfPrWGR8LWzgvyUUZox52PKonN5yG7Qn7sCIeSt6y0vMcu7q++Mb
         A/3sDVr4hVyKvYmDaeMnrVgyGznhpLoPWEqmIQ+eZDUfY8EP9sEvexSNTZ0Wjuosiav4
         e8rg==
X-Gm-Message-State: AOAM532EHhf+5BJPwis1Ze3i6I+WDDnRI0k8mbUZudEUVcvG4c7BK2S3
        e93LBEdClOMIhBFhxdq7rKM+gFI0JDs=
X-Google-Smtp-Source: ABdhPJw5y94S/wkdoGcsPKRP3Sy9BcFPhMape3rkfsMv3JYDBQ5F2mL/8AP6qLKHSFk15a98gta66uPQySk=
Sender: "seanjc via sendgmr" <seanjc@seanjc798194.pdx.corp.google.com>
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:f:10:e4db:abc1:a5c0:9dbc])
 (user=seanjc job=sendgmr) by 2002:a5b:745:: with SMTP id s5mr27855419ybq.265.1612815305037;
 Mon, 08 Feb 2021 12:15:05 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon,  8 Feb 2021 12:15:02 -0800
Message-Id: <20210208201502.1239867-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH] KVM: x86/xen: Use hva_t for holding hypercall page address
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hva_t, a.k.a. unsigned long, for the local variable that holds the
hypercall page address.  On 32-bit KVM, gcc complains about using a u64
due to the implicit cast from a 64-bit value to a 32-bit pointer.

  arch/x86/kvm/xen.c: In function =E2=80=98kvm_xen_write_hypercall_page=E2=
=80=99:
  arch/x86/kvm/xen.c:300:22: error: cast to pointer from integer of
                             different size [-Werror=3Dint-to-pointer-cast]
  300 |   page =3D memdup_user((u8 __user *)blob_addr, PAGE_SIZE);

Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Fixes: 23200b7a30de ("KVM: x86/xen: intercept xen hypercalls if enabled")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/xen.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 2cee0376455c..deda1ba8c18a 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -286,8 +286,12 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu=
, u64 data)
 				return 1;
 		}
 	} else {
-		u64 blob_addr =3D lm ? kvm->arch.xen_hvm_config.blob_addr_64
-				   : kvm->arch.xen_hvm_config.blob_addr_32;
+		/*
+		 * Note, truncation is a non-issue as 'lm' is guaranteed to be
+		 * false for a 32-bit kernel, i.e. when hva_t is only 4 bytes.
+		 */
+		hva_t blob_addr =3D lm ? kvm->arch.xen_hvm_config.blob_addr_64
+				     : kvm->arch.xen_hvm_config.blob_addr_32;
 		u8 blob_size =3D lm ? kvm->arch.xen_hvm_config.blob_size_64
 				  : kvm->arch.xen_hvm_config.blob_size_32;
 		u8 *page;
--=20
2.30.0.478.g8a0d178c01-goog

