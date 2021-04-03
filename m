Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B14353456
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbhDCOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 10:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhDCOef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 10:34:35 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C404C61242;
        Sat,  3 Apr 2021 14:34:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1lShM7-0040Es-Jp; Sat, 03 Apr 2021 10:34:31 -0400
Message-ID: <20210403143431.497619619@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 03 Apr 2021 10:33:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wan Jiabing <wanjiabing@vivo.com>
Subject: [for-next][PATCH 1/4] tracing: Remove duplicate struct declaration in trace_events.h
References: <20210403143347.409590683@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wan Jiabing <wanjiabing@vivo.com>

struct trace_array is declared twice. One has been declared
at forward declaration. Remove the duplicate.

Link: https://lkml.kernel.org/r/20210330034056.2266969-1-wanjiabing@vivo.com

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 36e27c1f42e0..ad413b382a3c 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -404,7 +404,6 @@ trace_get_fields(struct trace_event_call *event_call)
 	return event_call->class->get_fields(event_call);
 }
 
-struct trace_array;
 struct trace_subsystem_dir;
 
 enum {
-- 
2.30.1


