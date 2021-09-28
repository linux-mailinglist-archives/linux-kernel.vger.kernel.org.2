Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD6F41B5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 20:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbhI1SRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 14:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241531AbhI1SRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 14:17:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F3806128E;
        Tue, 28 Sep 2021 18:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632852959;
        bh=nKHEMhUfOMm7s+gjuVRlOm323XKF0sXn5BSetBQ8MwE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pa7KCpV4FQ7ZU0tSD3z+zuh4SkLqLz9xdLn103N09EaduolBzKVLyn1Cnl2HLY4IC
         Hh8jZpYO+1TU+lr6CRGoZXDT4732s2Gil69rdVMZYzWriSEJOtwU5eHNlKrSipB5Ax
         rkxkgmnlvzT+Or6FrefV3K3/quuaaCjekjh7b4CqpIou7anTLoLApkOQkrABFrQ21s
         tVhbtO77YSswb1OX74txgwMNsb8JIgAsUBJLapUJmFwemXGpyeUg6zFpli5rdeGt6Q
         Jy7k4+8Hqbg58yd/CNqb9qBrJhhSlqpQ7CJyawGMQABrACUos8BuZkI3tjsxA4LfWN
         8OvVJktkXKDFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D00C5C0815; Tue, 28 Sep 2021 11:15:59 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:15:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rcu,sched: noinstr fixes
Message-ID: <20210928181559.GD880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928084020.819856223@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928084020.819856223@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 10:40:20AM +0200, Peter Zijlstra wrote:
> A few noinstr fixes.. I'll stick the sched one in sched/urgent, Paul could you pick up the other two?

I queued those two, thank you!  I am guessing that you are looking for
me to send them ASAP.  If so, not a problem, but please confirm.

After all, yes, these are simple and low-risk, but in the absence of
any need to hurry them, extended testing is even lower risk.  ;-)

							Thanx, Paul
