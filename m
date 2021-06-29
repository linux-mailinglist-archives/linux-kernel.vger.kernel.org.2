Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79B3B775C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbhF2Rqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234328AbhF2Rqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:46:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C14061DB4;
        Tue, 29 Jun 2021 17:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624988649;
        bh=8gHJC+yPstpWRzMQd8vFfsS18EiAWm/wP+ptzgWsleY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Va9nOCwCfE72lhi3a47LPDhFR7BuovjaOW9A8EQOveVfgf/lJGy8TgyanqV813u6J
         HnoU9PwcBk247Uy3StjGvzoNJTiNbZanTF1l0iBMwk6MOd1nJTVjqgfMqbrEg3nSmu
         jJgzFUcS/hWIFTvGl2mZ91zmRDvnYjKNTxA8aq65L7whjrxfArxE0eXMd9JwDnpnsh
         fdv2HeZzoKCfX3jbNhO0WpMW76kDn+O+HRqb/xalv1UzoqwrAf7qLk91+gujdRX4i2
         B1eTOhjiRFwOEay5Q9mHSMy1krYf1qdDjmDo348uoqrwAyUOQgrrc+KfX3BP943K3P
         A/yoeKdKVUCaA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D1CD15C0546; Tue, 29 Jun 2021 10:44:08 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:44:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Liu Song <fishland@aliyun.com>
Cc:     liu.song11@zte.com.cn, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove unnecessary updates to ret in rcu_gp_fqs_loop
Message-ID: <20210629174408.GS4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210629135551.4080-1-fishland@aliyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629135551.4080-1-fishland@aliyun.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 09:55:51PM +0800, Liu Song wrote:
> From: Liu Song <liu.song11@zte.com.cn>
> 
> The ret value will be updated in the subsequent process,
> so there is no need to update it here.
> 
> Signed-off-by: Liu Song <liu.song11@zte.com.cn>

Good eyes, and it is safe to say that rcutorture would never have found
that one.  ;-)

As usual, I could not resist the urge to edit the commit log, and I also
added the "(void)" to indicate that the code intends to ignore the return
value, as it now uses elapsed time to make its decisions.

Please let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit 48434fc6700c31bd258713c24b78053fe47d393e
Author: Liu Song <liu.song11@zte.com.cn>
Date:   Tue Jun 29 21:55:51 2021 +0800

    rcu: Remove useless "ret" update in rcu_gp_fqs_loop()
    
    Within rcu_gp_fqs_loop(), the "ret" local variable is set to the
    return value from swait_event_idle_timeout_exclusive(), but "ret" is
    unconditionally overwritten later in the code.  This commit therefore
    removes this useless assignment.
    
    Signed-off-by: Liu Song <liu.song11@zte.com.cn>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35ed10bb95ef..a627a200a5ae 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1958,8 +1958,8 @@ static noinline_for_stack void rcu_gp_fqs_loop(void)
 		trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
 				       TPS("fqswait"));
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_WAIT_FQS);
-		ret = swait_event_idle_timeout_exclusive(
-				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
+		(void)swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
+				 rcu_gp_fqs_check_wake(&gf), j);
 		rcu_gp_torture_wait();
 		WRITE_ONCE(rcu_state.gp_state, RCU_GP_DOING_FQS);
 		/* Locking provides needed memory barriers. */
