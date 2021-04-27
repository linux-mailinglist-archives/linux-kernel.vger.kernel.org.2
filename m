Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B1736C571
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhD0LnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhD0Lm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:42:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200A4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 04:42:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619523732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=jSVDUyEHja1tbp9s9K8VqIiEVzIx/QRHGOyQtWiQYpg=;
        b=cGMbBB8IBQAdopstVtkxdq83Cnivv6vs5wp8kG9LuwsjccltBYvRkXAWE82W0BczCYZNHL
        tEQGb+oFDuQAQbxa8KKMp5oimDctBOr/9sU68pJQ2A6Kiz7TUY6kGL7kCuAZk/XnUK5YfK
        +lGdbW3klSL9/C4ErVFxEtRa2j0pYs5yI8KE9YDIUt450uJJwKkNBoHrjrB6uY8ODoZIck
        K7tKTBROeSeqLhAX94wgCNOG2K5+SOLlMScm1/pA1kK2OZKMoYm5ud8/W+JpfQaciw0Oue
        L7vWzPdNxQ93PuJLs/fYBSoFxDjF8e1UwcU9tuwweXE2URt/87EIxQdxmikGmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619523732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=jSVDUyEHja1tbp9s9K8VqIiEVzIx/QRHGOyQtWiQYpg=;
        b=2Di9OTi/ZHJrJ8SpcamDhBzQAz1mMQvXqIPQaIEeph0BEwKLjShpfjUZZJrCj6WADeHJVV
        1hniNMuacCUF0VBA==
To:     kernel test robot <oliver.sang@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, x86@kernel.org
Subject: Re: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2% regression
In-Reply-To: <20210427090013.GG32408@xsang-OptiPlex-9020>
Date:   Tue, 27 Apr 2021 13:42:12 +0200
Message-ID: <87fszcnecr.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

On Tue, Apr 27 2021 at 17:00, kernel test robot wrote:

> Greeting,
>
> FYI, we noticed a -5.2% regression of will-it-scale.per_thread_ops due to commit:
>
> commit: cbe16f35bee6880becca6f20d2ebf6b457148552 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

this is the second report in the last week which makes not a lot of sense.
And this oneis makes absolutely no sense at all.

This commit affects request_irq() and the related variants and has
exactly ZERO influence on anything related to that test case simply
because.

I seriously have to ask the question whether this test infrastructure is
actually measuring what it claims to measure.

As this commit clearly _cannot_ have the 'measured' side effect, this
points to some serious issue in the tests or the test infrastructure
itself.

Thanks,

        tglx
