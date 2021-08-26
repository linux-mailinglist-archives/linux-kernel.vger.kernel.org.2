Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F0B3F90C0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 01:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhHZWdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 18:33:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34798 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbhHZWdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 18:33:16 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630017146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YrtmNfUSKMqaI+mdWROUQzgaQyI2+Ot0/64zhKsNsy4=;
        b=HWdq1l+E3txuC+pIXxkNAB9C/+BPFn/N+dYoCZF4xGKZmVmGtYWYEp6yV+gDhE9EMgfvjd
        j/Nb9xY3TLaGyYo5AHUWVkF1hvmR+bj7B/iAvVvY+x4Hj1UXzxs9DbExcWV1HOpgrpdC9X
        5TVBO46/VflRRb9JvvtPjlZzJAO0LgORpRTiISUyD0Bi5D/lmvo0P7NnINU+F1ROypanp7
        +/e8E0sKzfoyA0uAigmUkkqe6o/D3YfoUMu8L9zzU0LbrpiXAF5eD9VmS6B5uLZ5tJJ28n
        w+tLYlQQKl4UbsyaxfmQHn/W77qp0ojuURzvwZRUmUBk49GU6Me3TbS/oXT3xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630017146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YrtmNfUSKMqaI+mdWROUQzgaQyI2+Ot0/64zhKsNsy4=;
        b=yBOsLH9d/uO5VvCwgdD96uOPW1x0JeRRgGxJeJ2j0N+VRU3ewIBmvXRdHKkpmp5oWoj8xn
        TLNSR0hjZRftp7Dg==
To:     kernel report robot <oliver.sang@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        feng.tang@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [PCI/MSI]  77e89afc25:  will-it-scale.per_process_ops -2.6%
 regression
In-Reply-To: <20210818145122.GC1721@xsang-OptiPlex-9020>
References: <20210818145122.GC1721@xsang-OptiPlex-9020>
Date:   Fri, 27 Aug 2021 00:32:26 +0200
Message-ID: <87eeaf3khx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18 2021 at 22:51, kernel report robot wrote:

> Greeting,
>
> FYI, we noticed a -2.6% regression of will-it-scale.per_process_ops due to commit:
>
>
> commit: 77e89afc25f30abd56e76a809ee2884d7c1b63ce ("PCI/MSI: Protect msi_desc::masked for multi-MSI")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
>
> in testcase: will-it-scale
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz with 256G memory
> with following parameters:
>
> 	nr_task: 100%
> 	mode: process
> 	test: lseek2
> 	cpufreq_governor: performance
> 	ucode: 0xd000280
>
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>

There is nothing to fix. The commit cures an incorrectness. Comparing
buggy code to correct code is futile.

Thanks,

        tglx
