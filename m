Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFCC407692
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhIKMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 08:23:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523EC061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 05:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GUNcEutT0mEBhENHiF0F3UXb+JNzNoJHfhcJSMtDZCI=; b=NzESvma6fyq52V87bsGMq4yXgV
        4ILtCo6/hbS+L2UPQ2Oxvg/qmIANgVtKvy0jIpPJEm79aSN7XAk2GsODoqwL8ppkSfc4iXdGXfd8s
        Uz22cpOKOX11A0BluXHUeCacvTLWUHlQda28fxtwRVgJcaLXmWEI1Zc1AAhhQH/WclAvOvL2Tgxpc
        BcU71TNP3vM13VyTHbAQ+gOr2ZGl5QEdOllhtz7MRoY4ftXHZW4kYfur4LQMGp6Iexni+Xl8RJqze
        uZU2NvNNZ6zz/w86XU8N/9BSyoZ6BzbyketHm19qSGQ8h+LgjzKV0MqHqOKwH6MiBIRtXzETEKF3C
        2wDrdwUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mP21R-002N6d-2y; Sat, 11 Sep 2021 12:22:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A7D379862C9; Sat, 11 Sep 2021 14:22:16 +0200 (CEST)
Date:   Sat, 11 Sep 2021 14:22:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH peterz-queue:sched/core] sched: fix build warning with W=1
Message-ID: <20210911122216.GX4323@worktop.programming.kicks-ass.net>
References: <20210911082505.115758-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911082505.115758-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2021 at 08:25:05AM +0000, Yafang Shao wrote:
> kernel test robot reported some build warnings with W=1 as below,
> 
> kernel/sched/fair.c:892:34: warning: variable 'stats' set but not used
> kernel/sched/core.c:10238:42: warning: variable 'stats' set but not used
> kernel/sched/fair.c:893:29: warning: variable 'p' set but not used
> kernel/sched/rt.c:1292:29: warning: variable 'p' set but not used
> kernel/sched/deadline.c:1486:34: warning: variable 'stats' set but not used
> arch/nds32/include/asm/current.h:10:13: warning: variable '$r25' set but not used
> 
> These warnings happen when CONFIG_SCHEDSTATS is not set, in which
> case the schedstat_* functions will be none. We should add
> '__maybe_unused' to fix it

I really hate all of this, I think the compiler is just being unhelpful
in the extreme. Also, I spupose the warning is in W=1 for a reason,
let's just completely ignore all of this.
