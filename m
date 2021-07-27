Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D63D7C04
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 19:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhG0RSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 13:18:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229494AbhG0RSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 13:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627406292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/VQR9JMb6h/Iq7YO5RJosLBeEaBclm4UKmr7Ftphbjw=;
        b=UOA1ShrGlzk+kKEVjpUsLJv6uhDpKfmgQXuCMUpz12MZFCITeJza7NwBr2Z4jkWzuSTvaP
        5DMVDxHYwr0QGPBMsM2HhoRUgsbjoaZXjJsRFRF2Y4u+doEN1yyK29deWbaWUCLSsLdwIR
        SI4kkL/k+M5FDgN0ujV1SfQThgeHrqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-SFaODQTYNTuuIpNtjeo76w-1; Tue, 27 Jul 2021 13:18:10 -0400
X-MC-Unique: SFaODQTYNTuuIpNtjeo76w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0E05192D789;
        Tue, 27 Jul 2021 17:18:09 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8AFBE61095;
        Tue, 27 Jul 2021 17:18:09 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com
Subject: [PATCH v2 0/2] KVM: Don't take mmu_lock for range invalidation unless necessary
Date:   Tue, 27 Jul 2021 13:18:06 -0400
Message-Id: <20210727171808.1645060-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my take on Sean's patch to restrict taking the mmu_lock in the
MMU notifiers.  The first patch includes the locking changes, while
the second is the optimization.

v1->v2: moved the "if (!kvm->mmu_notifier_count)" early return to patch 2

Paolo Bonzini (1):
  KVM: Block memslot updates across range_start() and range_end()

Sean Christopherson (1):
  KVM: Don't take mmu_lock for range invalidation unless necessary

 Documentation/virt/kvm/locking.rst |  6 +++
 include/linux/kvm_host.h           | 10 +++-
 virt/kvm/kvm_main.c                | 79 ++++++++++++++++++++++++------
 3 files changed, 78 insertions(+), 17 deletions(-)

-- 
2.27.0

