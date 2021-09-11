Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA56E407657
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 13:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhIKL6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 07:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbhIKL6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 07:58:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEC3C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v6WPdxMCjSoLNlI5VNVmU79AfLZr9gl0E6xtIsMqPH0=; b=muouqXBopCp5uPyywT21UwZaoK
        Mx9DWao1sL6BR8XN1JCCVLwoj9aKBeRD38jYEjN+VKbl7Ppg713gOLdxDBBr4FAcoRX9rPyOGmmy8
        apywXuA4oS9B3X9FdKQch0N7rgMqHJDp4ap0J7zG4Y3Ytg2tm7FOhyj9SZ8uZEr2T/DEizL2K/lXD
        HzGu/EhF2hr6cZ3K57PI/z4Q0OJ8Vr3ll3EVKkT+h6pXtIxJGZJWYvI8X6Wz9qj8DlCaUZBSSXQf5
        z9MQtmJKDAZcQFfBZlSlg2mxa51rHkPIJIiznSTaipQHpUYTMYz5hDWCbmaZKwpw6a1/GvIJJT6aj
        1ruiYw6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mP1dL-002MqN-IM; Sat, 11 Sep 2021 11:57:24 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA8FE9862C9; Sat, 11 Sep 2021 13:57:21 +0200 (CEST)
Date:   Sat, 11 Sep 2021 13:57:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH peterz-queue:sched/core] sched: fix build warning with W=1
Message-ID: <20210911115721.GV4323@worktop.programming.kicks-ass.net>
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

Yeah, I got the mails... :-)

I'll need it per patch tho, so that I can fix the individual commits.
Let me go do that. Thanks for looking at this.
