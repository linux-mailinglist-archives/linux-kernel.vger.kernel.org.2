Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BC8450541
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 14:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhKONXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 08:23:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50336 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231709AbhKONVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 08:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636982332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iP0ybKEaZFfcg49nTmM2VQMFL3C3mQnM57BqSNpXbBw=;
        b=RYgzAUlYbTF7g5OD8VPIId49d/ejCTsZhn8NONJZ+p2hKEjCSP+18ifidtRxqEBfBaAHjO
        x1j7/3ytdEO7U9DB/ZPaUAL/S+AsDsmpMxrcyugRJ62ufflm0K+Y6ugB5zWyb6+IVxD/cH
        V1n/ZVrAc57lO4qWpQms9F5WbGEFoKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-0ac-3q7qNeG8ljpbLjRafw-1; Mon, 15 Nov 2021 08:18:51 -0500
X-MC-Unique: 0ac-3q7qNeG8ljpbLjRafw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BAA6804141;
        Mon, 15 Nov 2021 13:18:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 356E810016F5;
        Mon, 15 Nov 2021 13:18:38 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT)), Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 0/2] VMX: nested migration fixes for 32 bit nested guests
Date:   Mon, 15 Nov 2021 15:18:35 +0200
Message-Id: <20211115131837.195527-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is hopefully the last issue I was tracking in regard to nested migrati=
on,=0D
as far as I know.=0D
=0D
The issue is that migration of L1 which is normal 64 bit guest,=0D
but is running a 32 bit nested guest is broken on VMX and I finally found o=
ut why.=0D
=0D
There are two bugs, both related to the fact that qemu first restores SREGS=
=0D
of L2, and only then sets the nested state. That haunts us till this day.=0D
=0D
First issue is that vmx_set_nested_state does some checks on the host=0D
state stored in vmcs12, but it uses the current IA32_EFER which is from L2.=
=0D
Thus, consistency checks fail.=0D
=0D
Second issue (happens on both VMX and SVM with npt/ept enabled in both L0 a=
nd L1)=0D
is that after migration L1 mmu (aka root_mmu) is initialized by L2's IA32_E=
FER=0D
due to the way qemu loads SREGS before the nested state, and later is not=0D
initialized again because in this particular case the 32 bitness of L2's IA=
32_EFER=0D
is not captured in mmu role.=0D
=0D
V2:=0D
Thanks to Sean and Paolo for helping me make more correct fixes for both of=
 the issues.=0D
=0D
I still haven't researched the 'fixes' tag, since I suspect that 32 bit nes=
ted=0D
migration wasn't tested much ever, so this bug might be present since long =
time ago.=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (2):=0D
  KVM: nVMX: don't use vcpu->arch.efer when checking host state on=0D
    nested state load=0D
  KVM: x86/mmu: include efer.lma in extended mmu role=0D
=0D
 arch/x86/include/asm/kvm_host.h |  1 +=0D
 arch/x86/kvm/mmu/mmu.c          |  1 +=0D
 arch/x86/kvm/vmx/nested.c       | 22 +++++++++++++++++-----=0D
 3 files changed, 19 insertions(+), 5 deletions(-)=0D
=0D
-- =0D
2.26.3=0D
=0D

