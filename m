Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F537B28C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhEKX2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhEKX1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:27:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D53C61626;
        Tue, 11 May 2021 23:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620775589;
        bh=ByFhsJzgyVmzsHlJ/ZAOETPN5zcLmH100XfPg5/iLys=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=bXeggXC99FhfVYiQ4Rb5kFgwVcf/Ei3wy9w0r7KQwUNXElAwE2Hhbz0c+6YrqSP4X
         9V/VClA3MgrAZOEuaOBSYdqHGTiFa7AYBxr9wdpBUJUy5vmH9osaV0xXhBc6dYyKip
         vpYJP+yTveuRw7MVbPVBnTYhsKBl+lPY8XZvVbF0YHL3vT2bKSQgYssUcnv8YfZXMQ
         M3yyXM90TWxKdvnOMm34iPWmbH41DuNoppgQA9tXN455yuqVHv4j6rxN/XO+t/O2sk
         8phoU7klEUHfizJdIeEIitHBlaK7XW7bSZm0HmjZKD96oMnCrgGsfOdSdki1I5BWCJ
         UAY0qyU40rXCQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0A7535C0138; Tue, 11 May 2021 16:26:29 -0700 (PDT)
Date:   Tue, 11 May 2021 16:26:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model] Fix smp_mb__after_spinlock() spelling
Message-ID: <20210511232629.GA2896493@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A misspelled git-grep regex revealed that smp_mb__after_spinlock()
was misspelled in explanation.txt.  This commit adds the missing "_".

Fixes: 1c27b644c0fd ("Automate memory-barriers.txt; provide Linux-kernel memory model")
[ paulmck: Apply Alan Stern commit-log feedback. ]
Signed-off-by: Björn Töpel <bjorn.topel@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index f9d610d5a1a4..5d72f3112e56 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -2510,7 +2510,7 @@ they behave as follows:
 	smp_mb__after_atomic() orders po-earlier atomic updates and
 	the events preceding them against all po-later events;
 
-	smp_mb_after_spinlock() orders po-earlier lock acquisition
+	smp_mb__after_spinlock() orders po-earlier lock acquisition
 	events and the events preceding them against all po-later
 	events.
 
