Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052693D8438
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 01:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhG0Xpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 19:45:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232766AbhG0Xpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 19:45:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2A1A6023D;
        Tue, 27 Jul 2021 23:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627429542;
        bh=pw3vDBYq/E70MLJiyo1SOB3k0+81t/eDoUYxe/62VaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ej15lNwtpLeQYGifczVzDdJV84FiQq3CFeiqWvD8DKg47HaOgc7mrV2DZGElYBYU8
         7DA7Pn0C0ZFjZsxJBnawsLfh3AvzoWCiHdb8oRZaz2DNpZsqElooNYMJdE2uJ0GAMC
         g4O6ssVfeYRds3+7TbROFS3zjSA2Brk0kwiAy1PIAA1MYUelRs+GfM/a+eC9h+p8YY
         BT27gBu0xgRmg7zyX3+TsmjpTALxav9s7EAY1xqFOSdNS7Synuhmmw3vX3PasHNkZG
         b2K3KS0ITq1tN4RhnCTPD0Hix6YBuaUo5Yo3UkfduquUxzd3x4/hZsk+h420wq/Eo5
         JdDrXaJ8GfKJg==
Date:   Wed, 28 Jul 2021 01:45:39 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     nsaenzju@redhat.com, linux-kernel@vger.kernel.org,
        Nitesh Lal <nilal@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@marvell.com>,
        Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 1/4] add basic task isolation prctl interface
Message-ID: <20210727234539.GH283787@lothringen>
References: <20210727103803.464432924@fuller.cnet>
 <20210727104119.551607458@fuller.cnet>
 <7b2d6bf91d30c007e19a7d2cbddcb2460e72d163.camel@redhat.com>
 <20210727110050.GA502360@fuller.cnet>
 <a020a45ddea10956938f59bd235b88fe873d0e98.camel@redhat.com>
 <20210727130930.GB283787@lothringen>
 <20210727145209.GA518735@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727145209.GA518735@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:52:09AM -0300, Marcelo Tosatti wrote:
> The meaning of isolated is specified as follows:
> 
> Isolation features
> ==================
> 
> - prctl(PR_ISOL_GET, ISOL_SUP_FEATURES, 0, 0, 0) returns the supported
> features as a return value.
> 
> - prctl(PR_ISOL_SET, ISOL_FEATURES, bitmask, 0, 0) enables the features in
> the bitmask.
> 
> - prctl(PR_ISOL_GET, ISOL_FEATURES, 0, 0, 0) returns the currently
> enabled features.

So what are the ISOL_FEATURES here? A mode that we enter such as flush
vmstat _everytime_ we resume to userpace after (and including) this prctl() ?

If so I'd rather call that ISOL_MODE because feature is too general.

> 
> The supported features are:
> 
> ISOL_F_QUIESCE_ON_URET: quiesce deferred actions on return to userspace.
> ----------------------
> 
> Quiescing of different actions can be performed on return to userspace.
> 
> - prctl(PR_ISOL_GET, PR_ISOL_SUP_QUIESCE_CFG, 0, 0, 0) returns
> the supported actions to be quiesced.
> 
> - prctl(PR_ISOL_SET, PR_ISOL_QUIESCE_CFG, quiesce_bitmask, 0, 0) returns
> the currently supported actions to be quiesced.
> 
> - prctl(PR_ISOL_GET, PR_ISOL_QUIESCE_CFG, 0, 0, 0) returns
> the currently enabled actions to be quiesced.
> 
> #define ISOL_F_QUIESCE_VMSTAT_SYNC      (1<<0)
> #define ISOL_F_QUIESCE_NOHZ_FULL        (1<<1)
> #define ISOL_F_QUIESCE_DEFER_TLB_FLUSH  (1<<2)

And then PR_ISOL_QUIESCE_CFG is a oneshot operation that applies only upon
return to this ctrl, right? If so perhaps this should be called just
ISOL_QUIESCE or ISOL_QUIESCE_ONCE or ISOL_REQ ?

But that's just naming debate because otherwise that prctl layout looks good
to me.

Thanks!
