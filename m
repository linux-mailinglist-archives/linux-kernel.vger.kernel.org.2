Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC63426D04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242992AbhJHOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24668 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242845AbhJHOva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633704569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=yCMj7cGiAu5uMlGEpnkY5Gp+0hj0LFryQP/5PMxjEWw=;
        b=Ci59J2pB74HcwcExil1md0wOuutbVpdb71QpNrQwRrpxTflDzqavrl0vrxPlk4rhafdzz7
        vKQjb620fG8fb4Rlwg4xtHiifgbLjyovJyRL+LQ9Vc9gm73beqv0gQcPNCyr33Trj7NTts
        ++XoEw5ttqt6Vb8g1kpzTxrpmP/zlu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-1hu7g4w8Ne6UZIZ-JY0hqg-1; Fri, 08 Oct 2021 10:49:24 -0400
X-MC-Unique: 1hu7g4w8Ne6UZIZ-JY0hqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31E67EC1A6;
        Fri,  8 Oct 2021 14:49:23 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 409995F4ED;
        Fri,  8 Oct 2021 14:49:05 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EEC7E425E3F9; Fri,  8 Oct 2021 11:48:13 -0300 (-03)
Message-ID: <20211007193526.450327326@fedora.localdomain>
User-Agent: quilt/0.66
Date:   Thu, 07 Oct 2021 16:23:52 -0300
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
Subject: [patch v4 6/8] KVM: x86: call isolation prepare from VM-entry code path
References: <20211007192346.731667417@fedora.localdomain>
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


