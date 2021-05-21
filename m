Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DCD38C105
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhEUHyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbhEUHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:54:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Rtlup+fauhu/WfletXJx5U+N+g6I1TwSLIMa7TtqpCQ=; b=TgEyYWI+kHy5pUXV5YID2Dcgl2
        pEmUYIK0pYImE4KyDXsjQGa9+lsi1ELoI/LRZXViMqrNWclmTnDbtdYMfnsCVMqp4JZNxnCXsXgoO
        3ycoYhsTvpv6Lc+VhKU+N6Z5xU2mRgr+iI5m8TMUA2sPRph/RkRPqheNIIEoBWxokROS4e7GqvqH6
        chxL3f/2e7cQYZHl3iDh/TKLYImlVgd9pu6eLw0N9tBbmyixOAvNW9vP7HxrNL0WBuIy3fS2KwTfz
        KJfUWNA/poal2xwGQNJE0wPz2pNVLOybbFhywK/p16kgGpCU9jpaM9CuODDLkvUOHyZ0RqjFRL/ej
        EPkA7GwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ljzy8-004IKF-EC; Fri, 21 May 2021 07:53:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8322A300103;
        Fri, 21 May 2021 09:53:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63CF72C6D2B85; Fri, 21 May 2021 09:53:15 +0200 (CEST)
Date:   Fri, 21 May 2021 09:53:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, joel@joelfernandes.org
Subject: Re: config SCHED_CORE
Message-ID: <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 08:06:07PM -0700, Hugh Dickins wrote:
> Hi Peter,
> 
> make oldconfig gave me no help at all on how to decide whether to choose
> SCHED_CORE Y or n, beyond it recommending Y.  Maybe you'll delete that
> option later, or maybe removing the prompt string would silence it.

Ah, you're quite right. I never seem to have gotten around to actually
writing anything useful there :/ Similarly the documentation for all
this seems to have gone missing too.

Joel, could I ask you to refresh the document to match the current state
of things and repost? I still whole hartedly despise this RST crud, it
makes it so hard to read / modify the files.

( I think the latest version is here:
  https://lkml.kernel.org/r/20210324214020.34142-8-joel@joelfernandes.org
)

Anyway, how is something like the below, Joel can add a reference to the
document once it's there.

---
 kernel/Kconfig.preempt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index ea1e3331c0ba..3c4566cd20ef 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -104,4 +104,16 @@ config SCHED_CORE
 	bool "Core Scheduling for SMT"
 	default y
 	depends on SCHED_SMT
-
+	help
+	  This option enables Core scheduling, a means of coordinated task
+	  selection across SMT siblings with the express purpose of creating a
+	  Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)
+	  -- task selection will ensure all SMT siblings will execute a task
+	  from the same 'core group', forcing idle when no matching task is found.
+
+	  This provides means of mitigation against a number of SMT side-channels;
+	  but is, on its own, insufficient to mitigate all known side-channels.
+	  Notable: the MDS class of attacks require more.
+
+	  Default enabled for anything that has SCHED_SMT, when unused there should
+	  be no impact on performance.
