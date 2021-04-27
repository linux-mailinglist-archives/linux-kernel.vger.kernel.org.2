Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941F936CBC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238526AbhD0TiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:38:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43018 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbhD0Th4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:37:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619552232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ot3CX42DdeSAWCrHpKWnb8PLwfyj5Nk4Iu25OpQHJ+o=;
        b=PV/CdW8tLiAAH7Ne3YiOX/ggBfcEMdH/U2/ik4DL53XI0TJHDRyWNZQUNP32JYAZv6DUsv
        gOAIHaWLNsv8l/+0L7BBz25kQVZ6Eij/jgBc9XqnMbrcibs/o8O8RxeQoaOcsE510Tt8Bk
        jQsrchfqhHM39danXhl9Pd1VR5WsilSWOd78GxJC4rm7u9D8do1VSSvYwiFczqYRNqebv7
        w/fzuo+1vqI7bQrXWap0WSA7BuQ+6Z2ljwxAFOyWHjhrgw1BZi5ZRmSPmTvbNttbMTXxcT
        BSCh9CFY62jCRgFS9Vsh+oaTyDgUma1k/B94h950cybjgD2nOTIBd7LPivhV+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619552232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ot3CX42DdeSAWCrHpKWnb8PLwfyj5Nk4Iu25OpQHJ+o=;
        b=elbh7KiE73tjeIgfFriSiKWEbwpfgLRdVTW287uCTJD1PJqhgTlt5vqy6/JMvzv7KTbZqu
        Y4DUBWFf7nntKADA==
To:     kernel test robot <oliver.sang@intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, x86@kernel.org
Subject: Re: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops -5.2% regression
In-Reply-To: <87fszcnecr.ffs@nanos.tec.linutronix.de>
References: <87fszcnecr.ffs@nanos.tec.linutronix.de>
Date:   Tue, 27 Apr 2021 21:37:11 +0200
Message-ID: <87czufo6xk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27 2021 at 13:42, Thomas Gleixner wrote:
> On Tue, Apr 27 2021 at 17:00, kernel test robot wrote:
>> FYI, we noticed a -5.2% regression of will-it-scale.per_thread_ops due to commit:
>>
>> commit: cbe16f35bee6880becca6f20d2ebf6b457148552 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> this is the second report in the last week which makes not a lot of sense.
> And this oneis makes absolutely no sense at all.
>
> This commit affects request_irq() and the related variants and has
> exactly ZERO influence on anything related to that test case simply
> because.
>
> I seriously have to ask the question whether this test infrastructure is
> actually measuring what it claims to measure.
>
> As this commit clearly _cannot_ have the 'measured' side effect, this
> points to some serious issue in the tests or the test infrastructure
> itself.

Just to illustrate the issue:

I ran the will-it-scale getppid1 test manually against plain v5.12 and
against v5.12 + cherrypicked cbe16f35be, i.e. the "offending" commit.

The result for a full run is just in the noise:

    average:    < 0.1%
    minimum:     -0.22%
    maximum:      0.29%

IOW very far away from -5.2%.

That's an order of magnitude off.

And no, I'm not going to run that lkp-test muck simply because it's
unusable and the test result of will-it-scale itself is clear enough.

Thanks,

        tglx

