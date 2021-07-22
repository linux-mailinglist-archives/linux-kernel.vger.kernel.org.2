Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C48C3D20D4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGVIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60451 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231313AbhGVIqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:46:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626945997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sitYVGzO7q3UBKDLxFbPwkC2YGfP0wGEiWAx0alN54M=;
        b=Oybg+OT/pqdgmW+EMgb0dDlPpqHEc5hmLBS/bEUldxEX+yjcBxXKBB/z7NP9kSa2H5hgY6
        +yV8Md2h6cVp+aaxZfRrl3/SaHIjcUtaI2Peo88IZGvN0GiEJEKPf3E9ZDbgM/hHkmqzVu
        0laarlPyQL6rIwDoBaDb2tEQKimy3aA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-j62nvQofMZeeoLScZ1k2pA-1; Thu, 22 Jul 2021 05:26:34 -0400
X-MC-Unique: j62nvQofMZeeoLScZ1k2pA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FFFC5A07F;
        Thu, 22 Jul 2021 09:26:32 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E05C10023AB;
        Thu, 22 Jul 2021 09:26:29 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] KVM: Documentation: Fix KVM_CAP_ENFORCE_PV_FEATURE_CPUID name
Date:   Thu, 22 Jul 2021 11:26:28 +0200
Message-Id: <20210722092628.236474-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'KVM_CAP_ENFORCE_PV_CPUID' doesn't match the define in
include/uapi/linux/kvm.h.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b9ddce5638f5..52eba4a275ad 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7049,7 +7049,7 @@ In combination with KVM_CAP_X86_USER_SPACE_MSR, this allows user space to
 trap and emulate MSRs that are outside of the scope of KVM as well as
 limit the attack surface on KVM's MSR emulation code.
 
-8.28 KVM_CAP_ENFORCE_PV_CPUID
+8.28 KVM_CAP_ENFORCE_PV_FEATURE_CPUID
 -----------------------------
 
 Architectures: x86
-- 
2.31.1

