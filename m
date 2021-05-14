Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D65381208
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 22:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhENUw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 16:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232011AbhENUwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 16:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621025502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wKoX0gYd0syiKSWXtGHsmueE0vbHoSklMQVmxBBC1nA=;
        b=Y1MCDTIT4wjwiCj3Eq5JJCLOQbz3zeQOEyf5NOXMxhecEKHtNawzAg+OblgDpTcnjSQS7e
        bO1n3tCBUSRFywLERSa218C/uqbBu80jRcEBxa/fH3wBZu0wwGDBKaZxvAArb8PyQ5xIWs
        fJlBEYQ/51+RLbvM5w08WBe7v6G3cOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-UjtKM-sZNKCWDVKpNEBfUw-1; Fri, 14 May 2021 16:51:40 -0400
X-MC-Unique: UjtKM-sZNKCWDVKpNEBfUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 826CC1854E25;
        Fri, 14 May 2021 20:51:39 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-113-210.rdu2.redhat.com [10.10.113.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 051071A871;
        Fri, 14 May 2021 20:51:35 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Subject: [PATCH V3 1/9] tracing/hwlat: Fix Clark's email
Date:   Fri, 14 May 2021 22:51:10 +0200
Message-Id: <2a59f63cf52eb85db8cbdd8fc8bdb7bc50cf2c02.1621024265.git.bristot@redhat.com>
In-Reply-To: <cover.1621024265.git.bristot@redhat.com>
References: <cover.1621024265.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clark's email is williams@redhat.com

No functional change.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Clark Willaims <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/trace/trace_hwlat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 632ef88131a9..0a5635401125 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -34,7 +34,7 @@
  * Copyright (C) 2008-2009 Jon Masters, Red Hat, Inc. <jcm@redhat.com>
  * Copyright (C) 2013-2016 Steven Rostedt, Red Hat, Inc. <srostedt@redhat.com>
  *
- * Includes useful feedback from Clark Williams <clark@redhat.com>
+ * Includes useful feedback from Clark Williams <williams@redhat.com>
  *
  */
 #include <linux/kthread.h>
-- 
2.26.3

