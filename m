Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67513D646F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbhGZP6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:58:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239144AbhGZPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627317070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jtrnviwOeSNc6bVEgKBxSKNk35cG/WSM04GW8bCgUXg=;
        b=hHqz3UCOBk5YRtcMnVYdf0KwY3LG9JG0Wupp6lDueCkZPOQJYHtSQhN/f/6FN+ndPCsZ4+
        /AXzj9Iy0mnnfDh4x43OOmiSRsZyuPtenFkmCPvySPBacFv7z+Mrp3FJZmrfbpK9vhsbcN
        44cXL+L6CHGqKL+IfuEiQRQtStkL10k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-8PI4LeEbPyG6HHG0URlhDA-1; Mon, 26 Jul 2021 12:31:08 -0400
X-MC-Unique: 8PI4LeEbPyG6HHG0URlhDA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A28231084F4B;
        Mon, 26 Jul 2021 16:31:07 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA2319811;
        Mon, 26 Jul 2021 16:31:07 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     bgardon@google.com
Subject: [PATCH] KVM: x86: enable TDP MMU by default
Date:   Mon, 26 Jul 2021 12:31:06 -0400
Message-Id: <20210726163106.1433600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of fast page fault support, the TDP-specific MMU has reached
feature parity with the original MMU.  All my testing in the last few months
has been done with the TDP MMU; switch the default on 64-bit machines.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index f86158d41af0..43f12f5d12c0 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -10,7 +10,7 @@
 #include <asm/cmpxchg.h>
 #include <trace/events/kvm.h>
 
-static bool __read_mostly tdp_mmu_enabled = false;
+static bool __read_mostly tdp_mmu_enabled = true;
 module_param_named(tdp_mmu, tdp_mmu_enabled, bool, 0644);
 
 /* Initializes the TDP MMU for the VM, if enabled. */
-- 
2.27.0

