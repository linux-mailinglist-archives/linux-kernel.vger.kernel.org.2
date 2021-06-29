Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E793B7191
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhF2Lvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 07:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhF2LvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 07:51:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC16761D23;
        Tue, 29 Jun 2021 11:48:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1lyCEV-000SZw-Sb; Tue, 29 Jun 2021 07:48:51 -0400
Message-ID: <20210629114851.727489957@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 29 Jun 2021 07:48:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [for-next][PATCH 5/6] Documentation: Fix a typo on trace/osnoise-tracer
References: <20210629114811.473560262@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@redhat.com>

s/RUNTIME IN USE/RUNTIME IN US/

Link: https://lkml.kernel.org/r/43e5160422a967218aa651c47f523e8d32d6a59e.1624872608.git.bristot@redhat.com

Fixes: bce29ac9ce0b ("trace: Add osnoise tracer")
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/osnoise-tracer.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/osnoise-tracer.rst b/Documentation/trace/osnoise-tracer.rst
index 37a3c10fb216..b648cb9bf1f0 100644
--- a/Documentation/trace/osnoise-tracer.rst
+++ b/Documentation/trace/osnoise-tracer.rst
@@ -77,7 +77,7 @@ In addition to the regular trace fields (from TASK-PID to TIMESTAMP), the
 tracer prints a message at the end of each period for each CPU that is
 running an osnoise/ thread. The osnoise specific fields report:
 
- - The RUNTIME IN USE reports the amount of time in microseconds that
+ - The RUNTIME IN US reports the amount of time in microseconds that
    the osnoise thread kept looping reading the time.
  - The NOISE IN US reports the sum of noise in microseconds observed
    by the osnoise tracer during the associated runtime.
-- 
2.30.2
