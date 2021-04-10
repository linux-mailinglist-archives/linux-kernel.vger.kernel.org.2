Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A735AFAC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 20:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhDJSnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 14:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhDJSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 14:43:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE152C06138A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 11:43:30 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618080207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4XQwk4nUTgQqJA9NE+O84z5sHqbSD0/n7q9/Ovq2w0=;
        b=TqAODkmbuIdv9Gy14NeeBnnzS4xD+iM+Pbhzec1eIh68GJepJLO2Z0JES+F/zh2/VHtLoa
        NgMqBfrwdc/DSFaM6HbrTsNaYfgsnnwRvqCnEJAB1Ia31LwajrrhfBQ7VZYRDpXp7SW2ll
        BxN7deQ8lnn1yC2wkRINS+Va9CBzD8Z8rxwxddPqtr/MGAXE9ISXTtN8fHb0W7VbCKMKSv
        xtrquFfxJicBrUCyxMotV6EV/A4WghJwrVCatDuqvD4LU1gMINADafFAp9az/bNiODwlRv
        PqXCzCBqmIDzal0hO4AAjujZPObtGQNQmL+7slfD2B3IF5ERt9XWi9wWdeWd0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618080207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4XQwk4nUTgQqJA9NE+O84z5sHqbSD0/n7q9/Ovq2w0=;
        b=wRskDAGxOOOMp4ce3CA/WJ4tQFJRxCxIDYV7IaY6R5+UItAQ8jnmSPXfQw9oMZmPQh2hgA
        pL6L9KCZKqTcc6CA==
To:     Borislav Petkov <bp@alien8.de>
Cc:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always checked
In-Reply-To: <20210410094752.GB21691@zn.tnic>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com> <87y2dq32xc.ffs@nanos.tec.linutronix.de> <20210410094752.GB21691@zn.tnic>
Date:   Sat, 10 Apr 2021 20:43:27 +0200
Message-ID: <87fszy2d68.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10 2021 at 11:47, Borislav Petkov wrote:

> On Sat, Apr 10, 2021 at 11:27:11AM +0200, Thomas Gleixner wrote:
>> On Tue, Mar 30 2021 at 16:25, Feng Tang wrote:
>> > Normally the tsc_sync will be checked every time system enters idle state,
>> > but there is still caveat that a system won't enter idle, either because
>> > it's too busy or configured purposely to not enter idle. Setup a periodic
>> > timer to make sure the check is always on.
>> 
>> Bah. I really hate the fact that we don't have a knob to disable writes
>> to the TSC/TSC_ADJUST msrs. That would spare this business alltogether.
>
> We have the MSR filtering and I'd *love* to add those MSRs to a
> permanent ban list of MSRs which will never ever be written to from
> luserspace.

That's good, but what I really want is a knob which prevents BIOS/SMM
from writing to it. The only reason why BIOS ever needs to write is for
physical hotplug and perhaps for 4+ socket machines on boot. After that
every write is a bug.

Thanks,

        tglx
