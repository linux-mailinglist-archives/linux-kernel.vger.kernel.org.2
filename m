Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96AF3B97F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 23:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhGAVJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 17:09:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234071AbhGAVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 17:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625173584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aMQ8DqHMVD67i2Qp6KYCUt8nJ4P3kjVGOwpx/lcfqOM=;
        b=KwNfJLP9OtRrcYTIMcY5yLehsquqAymswyHqPfU4wfnMtxYcWYwAVxYGqp8wb19WT5l7Yo
        B4sEs5LIXZxKlBCxyh/TJRGEgxVZp7kUiAubrob5DgJt+OsFkARMuF+VOziIGgEI+H6VRI
        +rWSOgm5BxkuJ7ry+QacGCNVVnOUazE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-XIIRn4Y0Nw-kgrc4ITFcdw-1; Thu, 01 Jul 2021 17:06:20 -0400
X-MC-Unique: XIIRn4Y0Nw-kgrc4ITFcdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1A511018721;
        Thu,  1 Jul 2021 21:06:19 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 320655D6A8;
        Thu,  1 Jul 2021 21:06:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 23F2A4179DC2; Thu,  1 Jul 2021 18:06:06 -0300 (-03)
Message-ID: <20210701210458.320619947@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 01 Jul 2021 18:03:38 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 2/5] common entry: add hook for isolation to __syscall_exit_to_user_mode_work
References: <20210701210336.358118649@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This hook will be used by the next patch to perform synchronization
of per-CPU vmstats.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6-vmstat-update/kernel/entry/common.c
===================================================================
--- linux-2.6-vmstat-update.orig/kernel/entry/common.c
+++ linux-2.6-vmstat-update/kernel/entry/common.c
@@ -284,9 +284,18 @@ static void syscall_exit_to_user_mode_pr
 		syscall_exit_work(regs, work);
 }
 
+/*
+ * Isolaton specific exit to user mode preparation. Runs with interrupts
+ * enabled.
+ */
+static void isolation_exit_to_user_mode_prepare(void)
+{
+}
+
 static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
 {
 	syscall_exit_to_user_mode_prepare(regs);
+	isolation_exit_to_user_mode_prepare();
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
 }


