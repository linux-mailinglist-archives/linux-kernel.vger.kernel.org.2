Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7214A3A4989
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhFKTo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhFKToW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:44:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7957C613CA;
        Fri, 11 Jun 2021 19:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623440543;
        bh=Qb74JVhJmTo2KtoO23vug6MfjvG20FaF6nExXjA1uwE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WzXiWAmhgUWi9FuYDbK4q2gXDRAeM3ZhpZkyCghFX1Jqm2LYd79j9OIwy0zavI8jx
         DwQn+opLK5HQds29cv+x5M7VvENu5ui1B3izd6qfSdU1Q6MGNPWsQs89rusvjdlIdA
         a+7Fk5Rz04Nk5MqSbIfKmA2KLODwhiS2htXr2hDbNWnIuk+hEIp1cFHNFkJMoYI7RZ
         F4WN//L4ngr8pK3IFgABRUYqWHsiGibqVKYuzE3kmhyiWP38+/2HyEheX5aXNHAIMu
         WxgfznxcjqmbwBYN9Zujfa11Oo3pYwa6H0x0U5kecNvqRRfY93IV3SKAeFweeOpTvh
         EmfOhR1rjrXlw==
Subject: Re: [patch 11/41] x86/fpu: Get rid of copy_supervisor_to_kernel()
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
 <20210611163112.153392869@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <efc44816-3fd2-d2f1-f959-99c196e23402@kernel.org>
Date:   Fri, 11 Jun 2021 12:42:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210611163112.153392869@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/21 9:15 AM, Thomas Gleixner wrote:
> If the fast path of restoring the FPU state on sigreturn fails or is not
> taken and the current task's FPU is active then the FPU has to be
> deactivated for the slow path to allow a safe update of the tasks FPU
> memory state.
> 
> With supervisor states enabled, this requires to save the supervisor state
> in the memory state first. Supervisor states require XSAVES so saving only
> the supervisor state requires to reshuffle the memory buffer because XSAVES
> uses the compacted format and therefore stores the supervisor states at the
> beginning of the memory state. That's just an overengineered optimization.
> 
> Get rid of it and save the full state for this case.

Hallelujah.

Reviewed-by: Andy Lutomirski <luto@kernel.org>
