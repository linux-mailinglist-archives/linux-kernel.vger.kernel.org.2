Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975B245CBC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350687AbhKXSHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242387AbhKXSGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:06:38 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A1661056;
        Wed, 24 Nov 2021 18:03:28 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1mpwcB-0027uL-H8;
        Wed, 24 Nov 2021 13:03:27 -0500
Message-ID: <20211124180327.365930589@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Nov 2021 13:03:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH RT 07/13] fscache: Use only one fscache_object_cong_wait (2)
References: <20211124180303.574562279@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.10.78-rt56-rc3 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is an update of the original patch, removing put_cpu_var() which
was overseen in the initial patch.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 fs/fscache/object.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fscache/object.c b/fs/fscache/object.c
index 55158f30d093..fb9794dce721 100644
--- a/fs/fscache/object.c
+++ b/fs/fscache/object.c
@@ -823,8 +823,6 @@ void fscache_enqueue_object(struct fscache_object *object)
 				wake_up(&fscache_object_cong_wait);
 		} else
 			fscache_put_object(object, fscache_obj_put_queue);
-
-		put_cpu_var(fscache_object_cong_wait);
 	}
 }
 
-- 
2.33.0
