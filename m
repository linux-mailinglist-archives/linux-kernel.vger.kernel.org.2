Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DB83C28DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhGISMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230116AbhGISM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:12:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625854184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aMQ8DqHMVD67i2Qp6KYCUt8nJ4P3kjVGOwpx/lcfqOM=;
        b=fe0X8MhyiiPi5fMNjMBtTUsVhT0IolTgxqbSvh2Itd0SDuF8awELLuJdzXtW4wlQH9Itut
        y4i2mMItxaKgiNdgFf069OoNVwXfqr1tqtknLv6YY6pY8npA9vrb7WTf2510GdNjA2FDno
        0XumMSgNqqUjEEEt3j8JHl8KzOg8+VQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-7f5vjMhhOR2HzeIauVtuaQ-1; Fri, 09 Jul 2021 14:09:43 -0400
X-MC-Unique: 7f5vjMhhOR2HzeIauVtuaQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453BA19067E0;
        Fri,  9 Jul 2021 18:09:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E110100164A;
        Fri,  9 Jul 2021 18:09:38 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 4B8F7416952E; Fri,  9 Jul 2021 15:09:28 -0300 (-03)
Message-ID: <20210709174428.188395898@fuller.cnet>
User-Agent: quilt/0.66
Date:   Fri, 09 Jul 2021 14:37:28 -0300
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
References: <20210709173726.457181806@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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


