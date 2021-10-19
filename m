Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC7E433B29
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhJSPxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 11:53:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25107 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233375AbhJSPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634658651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yCMj7cGiAu5uMlGEpnkY5Gp+0hj0LFryQP/5PMxjEWw=;
        b=DVrrtb1kpJT4jFZK8DWmDFzyg/A9c6st4zRnTptoLQV08FAURv71YXgHghDJcJz732NP4u
        eO+pDSh5cA3GSEN1NmVcha9w6XNYWznbHi/EKg54HK+NVrKNDpY+JeKhpXdAUf6/GQ6aA8
        f7R8yts6ddWCOult80luHtGf4Hp3SSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-xrKxAw2sOd6w9DODt9hpew-1; Tue, 19 Oct 2021 11:50:47 -0400
X-MC-Unique: xrKxAw2sOd6w9DODt9hpew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D285156AC3;
        Tue, 19 Oct 2021 15:50:44 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FF3D62AEE;
        Tue, 19 Oct 2021 15:50:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E0CAE41A8033; Tue, 19 Oct 2021 12:49:35 -0300 (-03)
Message-ID: <20211019154210.845548159@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Tue, 19 Oct 2021 12:24:37 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch v5 6/8] KVM: x86: call isolation prepare from VM-entry code path
References: <20211019152431.885037499@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 
@@ -9574,6 +9575,8 @@ static int vcpu_enter_guest(struct kvm_v
 		goto cancel_injection;
 	}
 
+	isolation_exit_to_user_mode_prepare();
+
 	preempt_disable();
 
 	static_call(kvm_x86_prepare_guest_switch)(vcpu);


