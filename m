Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBED5307D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhA1SNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:36018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhA1SJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:09:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E451F64E07;
        Thu, 28 Jan 2021 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611857301;
        bh=OGnQjiAgDA+88msfO4WmhcYEeZS/bNwPrFTaeyzswjA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ms8PfZju4tvgssHZjkeqp4UYoYnlnNZQzQBsbyOk6GlaqF2fx6nuxVOxfCog4zU/y
         SXH5QTCcEicGYmgE2RW2tuIzTyncvWwsPrcJ1YNWZG1wOsvoJTFg2tGekXm/aUq7XH
         jfmE/5P1xTJWBdccnG5fZYKGsSl8TI5PeXsz/QxY6SwCveATCnCZLUmX7iqRMGAXvs
         Wzl9hdegZSwG6+nbnzZNBJKf4Jt3d/L6E6LmEJWYZ67qTb0GiXEWe3ad6kxVvys/eJ
         dkWaDtomrh+KXG2fOVGeb3LvszPiYwRYP0Ft00sQ8nwUAqmnxBu6EjU8KCSqtjvDrA
         99OGszTo768+A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 929E63523769; Thu, 28 Jan 2021 10:08:21 -0800 (PST)
Date:   Thu, 28 Jan 2021 10:08:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@intel.com
Subject: Re: [workqueue] d5bff968ea:
 WARNING:at_kernel/workqueue.c:#process_one_work
Message-ID: <20210128180821.GA24510@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210126073925.1962-1-hdanton@sina.com>
 <20210127092128.2299-1-hdanton@sina.com>
 <20210128090905.1596-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128090905.1596-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 05:09:05PM +0800, Hillf Danton wrote:
> On Thu, 28 Jan 2021 15:52:40 +0800 Xing Zhengjun wrote:

[ . . . ]

> >I test the patch 4 times, no warning appears in the kernel log.
> 
> Thank you so much Zhengjun!
> 
> And the overall brain dump so far is
> 
> 1/ before and after d5bff968ea, changing the allowed ptr at online time
> is the key to quiesce the warning in process_one_work().
> 
> 2/ marking pcpu before changing aptr in rebind_workers() is mandatory in
> regards to cutting the risk of triggering such a warning.
> 
> 3/ we canot maintain such an order without quiescing the 508 warning for
> kworkers. And we have a couple of excuses to do so, a) the number of
> allowed CPUs is no longer checked in is_per_cpu_kthread() instead of
> PF_NO_SETAFFINITY, b) there is always a followup act to change the aptr
> in order to fix the number of aCPUs. 
> 
> 4/ same order is maintained also at rescue time.

Just out of curiosity, does this test still fail on current mainline?

							Thanx, Paul
