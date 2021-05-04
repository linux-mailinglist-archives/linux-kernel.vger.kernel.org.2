Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F150372C37
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhEDOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231336AbhEDOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620139229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kY1X0Ob5QnrkMKpSaPxZa/1lEOOAKUMTFQRU2EjHhsk=;
        b=DlyfIokoDWqv8NFaAs4AenwVKnL5np7NE7dXPBeW4eZHhKp1Xdq5V0G61griEt0dnMkhIb
        RvuRNjy7W+tgZrSacFVxJdr7AqmTNzwN5F2gF11axMzqK2TGLwliuMzFMdT69gdaAzs1JR
        Z/eZA5CJmQeZzjrXl5gNlOxJz1M/aCQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-89l2iu_RNkaN05qwuDjWFg-1; Tue, 04 May 2021 10:40:25 -0400
X-MC-Unique: 89l2iu_RNkaN05qwuDjWFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D9F6824FAE;
        Tue,  4 May 2021 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8141F5D9DE;
        Tue,  4 May 2021 14:39:38 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Cathy Avery <cavery@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 0/2] KVM: nSVM: few fixes for the nested migration
Date:   Tue,  4 May 2021 17:39:34 +0300
Message-Id: <20210504143936.1644378-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those are few fixes for issues I uncovered by doing variants of a=0D
synthetic migration test I just created:=0D
=0D
I modified the qemu, such that on each vm pause/resume cycle,=0D
just prior to resuming a vCPU, qemu reads its KVM state,=0D
then (optionaly) resets this state by uploading a=0D
dummy reset state to KVM, and then it uploads back to KVM,=0D
the state that this vCPU had before.=0D
=0D
V2: those are only last 2 patches from V1,=0D
updated with review feedback from Paolo (Thanks!).=0D
=0D
Best regards,=0D
	Maxim Levitsky=0D
=0D
Maxim Levitsky (2):=0D
  KVM: nSVM: always restore the L1's GIF on migration=0D
  KVM: nSVM: remove a warning about vmcb01 VM exit reason=0D
=0D
 arch/x86/kvm/svm/nested.c | 3 ++-=0D
 1 file changed, 2 insertions(+), 1 deletion(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

