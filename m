Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97AD3F61E0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 17:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhHXPnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 11:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238439AbhHXPng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 11:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629819772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5GBmI2eLHGG6ZdSAuDUji80HERG9HLQ6xks6WVJU3Gw=;
        b=GzjuzlZ7KKgyep0qtM3IR14z1j57m76XVB2+IDb0cXE7puMOrtDNLj/77HlVms1cpbtfhe
        F/2CKyqClOxhlkgBv5nYzESLfxXciZBcsdlDY7LzA2DAIju5OG4mUEc7L3NefR+cXghQhX
        eNROGsiqaCKq/FRkc08s0imKdUrTiQI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-w4w1SXBdOwyeQP0gf39onA-1; Tue, 24 Aug 2021 11:42:51 -0400
X-MC-Unique: w4w1SXBdOwyeQP0gf39onA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E46B2760DB;
        Tue, 24 Aug 2021 15:42:49 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E652C4EF67;
        Tue, 24 Aug 2021 15:42:38 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 1E1574175283; Tue, 24 Aug 2021 12:42:15 -0300 (-03)
Message-ID: <20210824152646.859859224@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 24 Aug 2021 12:24:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch V3 6/8] KVM: x86: call isolation prepare from VM-entry code path
References: <20210824152423.300346181@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM-entry code path is an entry point similar to userspace return
when task isolation is concerned.

Call isolation_exit_to_user_mode_prepare before VM-enter.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 arch/x86/kvm/x86.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/arch/x86/kvm/x86.c
===================================================================
--- linux-2.6.orig/arch/x86/kvm/x86.c
+++ linux-2.6/arch/x86/kvm/x86.c
@@ -59,6 +59,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/entry-kvm.h>
 #include <linux/suspend.h>
+#include <linux/task_isolation.h>
 
 #include <trace/events/kvm.h>
 
@@ -9539,6 +9540,8 @@ static int vcpu_enter_guest(struct kvm_v
 		goto cancel_injection;
 	}
 
+	isolation_exit_to_user_mode_prepare();
+
 	preempt_disable();
 
 	static_call(kvm_x86_prepare_guest_switch)(vcpu);


