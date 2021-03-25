Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A153490F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhCYLnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhCYLl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:41:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDA5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:40:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616672443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sT1I/UDEmzPL85eivZC0vSPEz7amfXSxcoEBFJvccVc=;
        b=338NZ33sQXm28YsiRYrEtAEWRWEw0gsuRzLbNFyXNuCDEf1mTC/b1ULaP3E/q64FVnBtsI
        GzmRH+BGYAsSYk5JN0Jj9Vexe0Edv/gqugg0lcciVxa+vYMfSj+h+Bat61IFVL+hZets+m
        ooc40c8Irc++xT21X9voH6GLUn+Vv/KYAzu6GPQ3BEvJVLg52u7BliS8oU1rxO6fGxGLJc
        MsJaHuLxHkejZbp5X2kUriKxpnDKyMI1Ap16hXSbRCLqze6mYlAn4Wt0FjYoxsAMzxkS74
        WoJFd5VL9NPBnBTlsSz6piLY8erxk4m1UFEObNKC7k6/9F+mUAwrP5KGkdbIyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616672443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sT1I/UDEmzPL85eivZC0vSPEz7amfXSxcoEBFJvccVc=;
        b=dS4JcHfmsCXPPg6+DqKl9uGjM198wpiHF5b38zDEVR2vjSucbiay4LWyiZW2cvKUPBkOz9
        xuftBJf53U/hCmAA==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>, andi.kleen@intel.com
Subject: Re: [PATCH] clocksource: don't run watchdog forever
In-Reply-To: <20210325083411.GA77653@shbuild999.sh.intel.com>
References: <1614653665-20905-1-git-send-email-feng.tang@intel.com> <YD4CdQqX5Lea1rB5@hirez.programming.kicks-ass.net> <20210302120634.GB76460@shbuild999.sh.intel.com> <875z286xtk.fsf@nanos.tec.linutronix.de> <20210325083411.GA77653@shbuild999.sh.intel.com>
Date:   Thu, 25 Mar 2021 12:40:43 +0100
Message-ID: <87zgyr5umc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25 2021 at 16:34, Feng Tang wrote:
> On Wed, Mar 03, 2021 at 04:50:31PM +0100, Thomas Gleixner wrote:
>
> I've checked one open-sourced BIOS code project: EDK2 (https://github.com/tianocore/edk2),
> where I did some grep and can't find places writting to tsc_adjust msr,
> which can give us more confidence that fewer and fewer BIOS will wrongly
> write to tsc_adjust msr :)

The problem is not EDK2. The problem is in the $VENDOR value add which
is _not_ part of EDK2.

So looking at that code does not make me more confident at all.

Thanks,

        tglx
