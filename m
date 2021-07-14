Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A433C924F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhGNUqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 16:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230015AbhGNUqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 16:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626295431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aMQ8DqHMVD67i2Qp6KYCUt8nJ4P3kjVGOwpx/lcfqOM=;
        b=D/MSjxO1KXZxzuRj3S9og8jZQs+you0NcxuBvRHXwYZO9r/N7jXv8lC1zRHMV6yNBvzluE
        GiZIvYZzfXF2kYyTUOlI31ZM8t3/Gw4mptv1K38wdL+Iw/zw6D+L3bZ7J3JtitxF0+tw+I
        I2dcCVuCiGKzV29i1u0pacMfY0luB3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-jWSlTUACN4Kn7ajh1fpkDQ-1; Wed, 14 Jul 2021 16:43:50 -0400
X-MC-Unique: jWSlTUACN4Kn7ajh1fpkDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E38FC803F56;
        Wed, 14 Jul 2021 20:43:48 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F22645DA61;
        Wed, 14 Jul 2021 20:43:44 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EDCE54172EDE; Wed, 14 Jul 2021 17:43:36 -0300 (-03)
Message-ID: <20210714204233.680326225@fuller.cnet>
User-Agent: quilt/0.66
Date:   Wed, 14 Jul 2021 17:42:07 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christoph Lameter <cl@linux.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Nitesh Lal <nilal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 2/5] common entry: add hook for isolation to __syscall_exit_to_user_mode_work
References: <20210714204205.245522189@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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


