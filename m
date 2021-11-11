Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B144DDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhKKWKs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Nov 2021 17:10:48 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:55649 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhKKWKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 17:10:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-6NyxCiVjNaOH38PjM6hYgw-1; Thu, 11 Nov 2021 17:07:53 -0500
X-MC-Unique: 6NyxCiVjNaOH38PjM6hYgw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15E618042E5;
        Thu, 11 Nov 2021 22:07:52 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AEB4179B3;
        Thu, 11 Nov 2021 22:07:49 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing/osnoise: Make osnoise_instances static
Date:   Thu, 11 Nov 2021 23:07:42 +0100
Message-Id: <d001f0eeac66e2b2eeec7d2a15e9e7abede0453a.1636667971.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the struct list_head osnoise_instances definition static.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org
Fixes: dae181349f1e ("tracing/osnoise: Support a list of trace_array *tr")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/trace_osnoise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 3e4a1651e329..7520d43aed55 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -55,7 +55,8 @@ struct osnoise_instance {
 	struct list_head	list;
 	struct trace_array	*tr;
 };
-struct list_head osnoise_instances;
+
+static struct list_head osnoise_instances;
 
 static bool osnoise_has_registered_instances(void)
 {
-- 
2.31.1

