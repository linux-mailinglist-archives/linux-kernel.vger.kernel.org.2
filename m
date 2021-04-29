Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40D736E906
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbhD2KsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240450AbhD2KsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619693234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N9yW175n2/Fko+VjOrEdOCUWNBA9vqG7mA8IcKObQLw=;
        b=S9bZZPEqpkBGSPFrkat08I5/ISDC7fiAPb9fvTf4nMrm6HhLQcWV9lXIVaHkbo51kW8+ew
        jlb+7Jg0Ev7S1gETIYhbKfmTSgbMNecTh5pB/asEyTcRFK+249/9EzEijtuUYHJuxLSj1v
        DTOHJRb0nA/trStzp4JoyJvMZghPTFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-Y3VwTIlZNjG3KF0B0M7I0A-1; Thu, 29 Apr 2021 06:47:10 -0400
X-MC-Unique: Y3VwTIlZNjG3KF0B0M7I0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD55D8018A7;
        Thu, 29 Apr 2021 10:47:08 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 317EE5DF26;
        Thu, 29 Apr 2021 10:47:08 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     srutherford@google.com, seanjc@google.com, joro@8bytes.org,
        brijesh.singh@amd.com, thomas.lendacky@amd.com,
        ashish.kalra@amd.com
Subject: [PATCH v3 0/2] KVM: x86: guest interface for SEV live migration
Date:   Thu, 29 Apr 2021 06:47:05 -0400
Message-Id: <20210429104707.203055-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reviewed version of the guest interface (hypercall+MSR)
for SEV live migration.  The differences lie mostly in the API
for userspace.  In particular:

- the CPUID feature is not exposed in KVM_GET_SUPPORTED_CPUID

- the hypercall must be enabled manually with KVM_ENABLE_CAP

- the MSR has sensible behavior if not filtered

Compared to v2, the KVM-provided behavior of the MSR is different:
it is set to 0 if the guest memory is encrypted, and 1 if it is not.
The idea is that the MSR is read-only if KVM_FEATURE_HC_PAGE_ENC_STATUS
is not exposed to the guest (it should only be exposed if the guest has
encrypted memory), but it also has a sensible value for non-encrypted
guests.  QEMU could however expose a "0" value for the special "-cpu
host,migratable=no" mode if it wanted.

Because of this new behavior, the CPUID bit are split.

Paolo

Ashish Kalra (1):
  KVM: X86: Introduce KVM_HC_PAGE_ENC_STATUS hypercall

Paolo Bonzini (1):
  KVM: x86: add MSR_KVM_MIGRATION_CONTROL

 Documentation/virt/kvm/api.rst        | 14 +++++++
 Documentation/virt/kvm/cpuid.rst      |  9 +++++
 Documentation/virt/kvm/hypercalls.rst | 21 ++++++++++
 Documentation/virt/kvm/msr.rst        | 14 +++++++
 arch/x86/include/asm/kvm-x86-ops.h    |  1 +
 arch/x86/include/asm/kvm_host.h       |  3 ++
 arch/x86/include/uapi/asm/kvm_para.h  |  5 +++
 arch/x86/kvm/cpuid.c                  |  3 +-
 arch/x86/kvm/svm/svm.c                |  1 +
 arch/x86/kvm/vmx/vmx.c                |  7 ++++
 arch/x86/kvm/x86.c                    | 56 +++++++++++++++++++++++++++
 include/uapi/linux/kvm.h              |  1 +
 include/uapi/linux/kvm_para.h         |  1 +
 13 files changed, 135 insertions(+), 1 deletion(-)

-- 
2.26.2

