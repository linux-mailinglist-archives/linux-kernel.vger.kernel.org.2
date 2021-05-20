Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A3C389AB7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhETBET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229525AbhETBER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:04:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0854D6100A;
        Thu, 20 May 2021 01:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621472576;
        bh=Lf/8QEJNwE3bPrrZVsNXjplajFp91+e38C42i8jmbkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYRVfyZJgvP4rPI60P5gD5ZZ+BRhfvGLBaXVXfbHFkavmRgl0cJlE+NNkh1WPTfVI
         hl6AKVwglJM6trM6ENDCxCZsePwO4D96kNoCQZrtGMaspqSZ4WpzysTUWTWrNDLl0R
         RzlV+MCk0QlhoPpSxcVsVDuONM/I4ZzFTxh8zH7xYqr6LudXdEp5+BAvCZXsWavEpU
         h+qx9wUezjOS8ZNxCmK3FqBI56fk+tFQBppaKo7CPyrfWWh/yz1PVZfIkY2gVew1+H
         D/9sFf8smHmMqCS9gsvvc0LRoZ6Va8n1bdekZ7qgk9okaccmtkOcRgFvHw//ou+nZH
         l42vYhivFGCOw==
Date:   Thu, 20 May 2021 03:02:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/3] rcu/nocb: Start moving nocb code to its own plugin
 file
Message-ID: <20210520010254.GC22836@lothringen>
References: <20210519000930.15702-1-frederic@kernel.org>
 <20210519000930.15702-2-frederic@kernel.org>
 <20210519155508.GX4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519155508.GX4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 08:55:08AM -0700, Paul E. McKenney wrote:
> On Wed, May 19, 2021 at 02:09:28AM +0200, Frederic Weisbecker wrote:
> > tree_plugin.h is now gathering not only the (no)preempt-rcu specifics
> > but also other features like NO_CB. As the latter has grown quite in
> > complexity and volume, it's may be a good idea to start moving the
> > related code to its own file so we don't need to browse thousand lines
> > to find what we need.
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Applied with the usual wordsmithing, thank you!
> 
> But for consistency with the other similar files included by
> kernel/rcu/tree.c, should the name instead be kernel/rcu/tree_nocb.h?

Ah yes, I hesitated but tree_nocb.h is indeed more consistent. Can I let
you do the rename?

> Also, if Ingo and I are one the author list, shouldn't you be as well?  ;-)

Heh, alright feel free to add the following as a fixup :-)

diff --git a/kernel/rcu/nocb.h b/kernel/rcu/nocb.h
index a7783923833e..bf2690ca5d2b 100644
--- a/kernel/rcu/nocb.h
+++ b/kernel/rcu/nocb.h
@@ -6,9 +6,11 @@
  *
  * Copyright Red Hat, 2009
  * Copyright IBM Corporation, 2009
+ * Copyright SUSE, 2021
  *
  * Author: Ingo Molnar <mingo@elte.hu>
  *	   Paul E. McKenney <paulmck@linux.ibm.com>
+ *	   Frederic Weisbecker <frederic@kernel.org>
  */
 
 #ifdef CONFIG_RCU_NOCB_CPU


Or perhaps you prefer a separate patch?

Thanks!
