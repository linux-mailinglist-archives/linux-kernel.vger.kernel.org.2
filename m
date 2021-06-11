Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA93A48D6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFKStz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhFKStx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3153E61042;
        Fri, 11 Jun 2021 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623437275;
        bh=Vmypy4K+1A/edF0vShE8gEQdjBb6fd6InO7a7lpJm8Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UyKqkM3tDMNEJUjg3vjmgvDYVh5FZ76pI4EnxEA0FUukwB3Fll1DB453T1jWyGPtg
         6muE5QjLKZnL7LuWtHOZP7+RGyKMi9dj7N0SGwmv+4We9lPnFiWrpBe8DNYhy3ZgDV
         nn25Wf0Oq8bnh1OPMG9IUwMO4aGU3EaNVdiHpIWkN4nq4EBeEW+hjycc6gprLAG5NO
         ngYJcJTx1oR3L2KtxDXsrYehbGn7OmlOpt30+gCSkutrJNSALYFag4SduSATklVbhN
         Mz8sF+tzc+28UjVpsTfUScTgq9WK6d1dSWeQoijUMexHixVV/xPZXt2cWtn5Ne14CE
         Xjng7gmKPR6kQ==
Subject: Re: [patch 07/41] x86/fpu: Simplify PTRACE_GETREGS code
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210611161523.508908024@linutronix.de>
 <20210611163111.724946882@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b396ad22-8a1e-07a0-f744-9b443d63c593@kernel.org>
Date:   Fri, 11 Jun 2021 11:47:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611163111.724946882@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 9:15 AM, Thomas Gleixner wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> ptrace() has interfaces that let a ptracer inspect a ptracee's register state.
> This includes XSAVE state.  The ptrace() ABI includes a hardware-format XSAVE
> buffer for both the SETREGS and GETREGS interfaces.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
