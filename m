Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED3032C495
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444904AbhCDAPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353201AbhCDADm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:03:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7140A64FD0;
        Thu,  4 Mar 2021 00:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816023;
        bh=U0pkZGfxvPXzP41Wnbtcb5M7LOdeJNoh0cq/g7hlzfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XiqivoCus+5dH1Ll8ZP8vFj/3djmC2pb+NFJA1nUAgDQbosHOnJfTvrY4/pSotPrP
         qVQN6cCoDSGEylzr/bW+wLhs58x5Df966lvDQ2kLDivoHDqLp1RoNFedlMrZCTUDrs
         k2NLOWvQLSA/LeuzUmViMmjriyYjt4Yoo0UO7DTTuAT/BGs3j/wYONOgvKJNxcIBrG
         SIRkeR2DoVNsihoPfuuEpkBh64JZIWaP5pFMty721UTuqdLf2A6PI81EwEw2ZsMXgM
         bL8wW8BJHBqrzUgKls3otVlTpfJdGkH7d9UgxHhewnGIOR1ZGTqee7ROJNu3wDtk/H
         noCC31gyKmBDg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 08/10] docs: Correctly spell Stephen Hemminger's name
Date:   Wed,  3 Mar 2021 16:00:17 -0800
Message-Id: <20210304000019.22459-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit replaces "Steve" with the his real name, which is "Stephen".

Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/RTFP.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/RTFP.txt b/Documentation/RCU/RTFP.txt
index 3b0876c..588d973 100644
--- a/Documentation/RCU/RTFP.txt
+++ b/Documentation/RCU/RTFP.txt
@@ -847,7 +847,7 @@ Symposium on Distributed Computing}
 	'It's entirely possible that the current user could be replaced
 	by RCU and/or seqlocks, and we could get rid of brlocks entirely.'
 	.
-	Steve Hemminger responds by replacing them with RCU.
+	Stephen Hemminger responds by replacing them with RCU.
 }
 }
 
-- 
2.9.5

