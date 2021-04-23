Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA16369BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbhDWVHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243974AbhDWVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619211972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEWXBD4y4KcDEXqUcvb3jhws1mjqMN/qnM2/qNdowWg=;
        b=iDPi6YOXugeFAPJkhL8IIT5XvHLxCCw94qIQz4atgoVD/duasovYH8Led6Hg+98xAOMuHD
        pE5Fve6Gpu4oriaj6nubaZ499+lBHV+DDRSiiGbGQ2EyASsBeEtZo4W2vdt1gsLxBTjdqc
        ODpayBs7h8Ycc9GDaEdWDl36YL24IBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-gl8oy3XaM3GgfOa117C8MQ-1; Fri, 23 Apr 2021 17:06:11 -0400
X-MC-Unique: gl8oy3XaM3GgfOa117C8MQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62388107ACC7;
        Fri, 23 Apr 2021 21:06:09 +0000 (UTC)
Received: from x1.bristot.me.homenet.telecomitalia.it (ovpn-112-8.rdu2.redhat.com [10.10.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 086E929175;
        Fri, 23 Apr 2021 21:06:05 +0000 (UTC)
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
Subject: [RFC PATCH V2 1/9] tracing/hwlat: Fix Clark's email
Date:   Fri, 23 Apr 2021 23:05:36 +0200
Message-Id: <b92af72aa1128f51ac39f4f0ad4ea1ad093bd037.1619210818.git.bristot@redhat.com>
In-Reply-To: <cover.1619210818.git.bristot@redhat.com>
References: <cover.1619210818.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
index 34dc1a712dcb..902f3cfa3878 100644
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

