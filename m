Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B0A40D983
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 14:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239316AbhIPMM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 08:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:59138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239283AbhIPMMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 08:12:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6174560F4A;
        Thu, 16 Sep 2021 12:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631794258;
        bh=svVCg+n5Jf6lVzK0daIYKluiQvyzcAJGbbRa9Dg1Ptg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tH4Y9fHRFU7QTvuqlBiMLZ1lFSU9oiZ7n1oXyVNxUcg1eyifg1wUYOB+ZW3mmCMRB
         3ly/wUyg26p+m9o2xOkWTB0jmcnOFd63Y2scndNP3sjBL2ooGPnCT9G4apmbBDbHfQ
         M3m2Rh92DsPH9OqonvYkaWtcooGrAY54hzXddcf6fPZFPB1uIDwZriuKLllaU4Tc6U
         0ah3zIQM9zzRu1D5WpezMpsX50yowI+6t4dehxIYVBKtq2M1OKat8DYHzOoMBmY5qK
         nQqSMyBYYm45q8Y5e7O5aCubF+V+3KA83GDIIo2YF/shOkCt8AznJ46beuDqBjvtFd
         6D5inkEHeLQ3g==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org,
        urezki@gmail.com, boqun.feng@gmail.com,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        joel@joelfernandes.org
Subject: [PATCH 2/4] rcu: Remove useless WRITE_ONCE() on rcu_data.exp_deferred_qs
Date:   Thu, 16 Sep 2021 14:10:46 +0200
Message-Id: <20210916121048.36623-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916121048.36623-1-frederic@kernel.org>
References: <20210916121048.36623-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is never written nor read remotely. Remove this confusion.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_exp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f3947c49eee7..4266610b4587 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -255,7 +255,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
  */
 static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
-	WRITE_ONCE(rdp->exp_deferred_qs, false);
+	rdp->exp_deferred_qs = false;
 	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
 }
 
-- 
2.25.1

