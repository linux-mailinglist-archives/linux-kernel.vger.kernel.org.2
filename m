Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9660388D64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353125AbhESMC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:02:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:54594 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346290AbhESMCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:02:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621425688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CKCCA4uGoDUr0kdQS1te8hopA2mifUTP8Tl3Ty74AR4=;
        b=W1WjFsyG8Kx82VA+T2NuXO1036rB9210NOrtUrtxMTnrtGbmZ0c00RrvEG41/PmlkD7IyK
        HR94/SFnas1sOx3nllsvssdGUglouNBlZQEzkzgAQP4KEUD4Fj/2WAlk3kIVny45rCK6zF
        YRuBawFFqxF6S0Yi62ZtkXMXJKeSUbw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D1F72AF19;
        Wed, 19 May 2021 12:01:28 +0000 (UTC)
Date:   Wed, 19 May 2021 14:01:28 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: Reliable handling of timestamps
Message-ID: <YKT+GMZVIiRNIDle@alley>
References: <20210517140612.222750-1-senozhatsky@chromium.org>
 <YKPfDQoN5hToB9nk@alley>
 <YKT55gw+RZfyoFf7@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKT55gw+RZfyoFf7@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-05-19 13:43:34, Petr Mladek wrote:
> The commit 9bf3bc949f8aeefeacea4b ("watchdog: cleanup handling of false
> positives") tried to handle a virtual host stopped by the host a more
> straightforward and cleaner way.
> 
> But it introduced a risk of false softlockup reports. The virtual host
> might be stopped at any time, for example between
> kvm_check_and_clear_guest_paused() and is_softlockup().
> As a result, is_softlockup() might read the updated jiffies
> are detects softlockup.
> 
> Fix all the problems by making the code even more explicit.

This is my preferred solution. It makes it clear when the various
values are read and various situations handled.

In the original code, kvm_check_and_clear_guest_paused() was handled
partially in the given and partially in the next watchdog_timer_fn()
invocation.

It would be great to push this patch or at least Sergey's revert
for 5.13.

Best Regards,
Petr
