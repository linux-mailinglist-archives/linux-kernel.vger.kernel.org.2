Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C109A3FC9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhHaOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:34:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:48704 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbhHaOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 10:34:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 337DE2228D;
        Tue, 31 Aug 2021 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630420433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xAEprQsW0N81GpF1JlP4+oliaEb/wfRvXCgcIbPMyM=;
        b=EOHRQBRTVET1mtXY9RS08x3F+XNuVKJwfmWj3m19yLSK5tZcUolsbmmQfvbRoBrXqCQyCJ
        Pvd6qktaFRs+MGtx8xHLQZ6BIGsG1CYAPkOsKAsZbNO3LkHaW12upKWkO8iFDbwlktEp2H
        OsbHF4qnHs2xJHlf/t+tuwG1mkH2ZsI=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DDE74A3B9E;
        Tue, 31 Aug 2021 14:33:52 +0000 (UTC)
Date:   Tue, 31 Aug 2021 16:33:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     James Wang <jnwang@linux.alibaba.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel hang during reboot when cmdline include a non-exist
 console device
Message-ID: <YS490P27YM6UlB2z@alley>
References: <CAHk-=wj+G8MXRUk5HRCvUr8gOpbR+zXQ6WNTB0E7n32fTUjKxQ@mail.gmail.com>
 <YS2fZ1sknFYKtJFi@google.com>
 <YS3k5TRf5oLLEdKu@alley>
 <YS3stL0cTn5ZQSNx@google.com>
 <fc18d17a-b185-7a1e-2135-ec83f3f8c70f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc18d17a-b185-7a1e-2135-ec83f3f8c70f@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-08-31 21:45:05, James Wang wrote:
> 
> 在 2021/8/31 PM4:47, Sergey Senozhatsky 写道:
> > And may I ask, just in case, if James can revert a revert of Petr's commit:
> > 
> >         revert a91bd6223ecd46addc71ee6fcd432206d39365d2
> > 
> > boot with wrong console argument and see if the kernel reboots without
> > any problems.
> 
> After test, revert Petr's commit can work; reboot without any problem;

Interesting, it looks like the panic() is really caused by missing
stdout, stdin, and stderr, for the init process.

Unfortunately, the fix is not easy, as described in the commit
a91bd6223ecd46addc71e ("Revert "init/console: Use ttynull as
a fallback when there is no console").

Best Regards,
Petr
