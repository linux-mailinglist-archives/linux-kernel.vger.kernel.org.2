Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4916387C89
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350231AbhERPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:38:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238479AbhERPiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:38:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621352206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aBjOFkQQebNjz7yFpWcDkZPbwySae7v7T3DPAQxjnvg=;
        b=tkuRpJkQSui/g0MCkzlN2/c2GAmdlvIqC9eOhgmKyAl7V96VmVeG+RClWacseH+CL7pN7u
        Memqx7vECJuLndka0aikv/Q70QcuLlF8AgSOXBIjrFtYJoLoTXoic//+i5deFYbFAortAT
        o7zl1wO0v0zWBGnXESOCNRZHG5vBE/g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EBE10AF3B;
        Tue, 18 May 2021 15:36:45 +0000 (UTC)
Date:   Tue, 18 May 2021 17:36:45 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: revert cleanup handling of false positives
Message-ID: <YKPfDQoN5hToB9nk@alley>
References: <20210517140612.222750-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517140612.222750-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-05-17 23:06:12, Sergey Senozhatsky wrote:
> This reverts commit 9bf3bc949f8aeefeacea4b1198db833b722a8e27.
> 
> I can reproduce the case when resumed VCPU starts to execute
> is_softlockup() with PVCLOCK_GUEST_STOPPED set on this VCPU:
> 
> 	watchdog_timer_fn()
> 	{
> 		...
> 
> 		kvm_check_and_clear_guest_paused();
> 
> 		...
> 
> 		duration = is_softlockup(touch_ts, period_ts);
> 		if (unlikely(duration)) {
> 			....
> 		}
> 	}
> 
> Which means that guest VCPU has been suspended between
> kvm_check_and_clear_guest_paused() and is_softlockup(),
> and jiffies (clock) thus shifted forward.

Are jiffies really updated here?
watchdog_timer_fn() should be called with interrupts disabled.

kvm_check_and_clear_guest_paused() calls
touch_softlockup_watchdog_sync(). It sets softlockup_touch_sync
when jiffies have to be updated explicitely.

Well, I am not 100% sure.

Anyway, the code does not guarantee in which order and how
many times are touch_ts and current jiffies read. And touch_ts
might be updated also from NMI.

I have a patch that mfixes the ordering and makes sure that
the same value is used in all checks. But I still need to double
check some things and write proper commit message.

I would prefer to fix it properly. The original code was
not good either.

Best Regards,
Petr
