Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC8545F65C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 22:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242019AbhKZVbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 16:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242335AbhKZV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 16:29:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE2C061758
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 13:26:09 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637961967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjNUKG+s4Ps6r9zLUOn5nxDOIRtHOKUgQW134JHaKqA=;
        b=R4JIywl7ZbItEW3yhvSHkyA5fdPrGPcSzi9z2XIywE8OB2SOlRnSGfIMftPWUGgjWkkB1l
        tnqHNeVTvegOL+8EpCYrXsaF49Jbwd1hVkznuH1p0cZl6fvfHSBvRZAsc8HlcZ83ByJkOd
        BbZrfhUW6OINrRi/T3j67J2YAdh222SQ/Rp/hJVrkQ7zltGs4Mh4e/NuBzN7QICZLpl/zL
        dj0KA/d0N0i5KzdFZo/vAfD31v3+EByGzG46ItN8i14nX+jDLfjoR9e0FQpAPSnOwoZ6wm
        YBWAk3vRy7XPfcgnJl/c5NWiqbndeIMcvrZgjf6vSHPHbgw7+Y6tZdO9LZoOIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637961967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WjNUKG+s4Ps6r9zLUOn5nxDOIRtHOKUgQW134JHaKqA=;
        b=6TZNzD8/CFcvWt1+cHtze92ARSCHNIQ9lcjE40DBzdEnafmhCTxpeOKsNA44tZ5RG2CIBu
        Ti1ZHyTkfwZaInDw==
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     oleksandr@natalenko.name, john.stultz@linaro.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v3 1/2] timers: Implement usleep_idle_range()
In-Reply-To: <20211126145015.15862-2-sj@kernel.org>
References: <20211126145015.15862-1-sj@kernel.org>
 <20211126145015.15862-2-sj@kernel.org>
Date:   Fri, 26 Nov 2021 22:26:06 +0100
Message-ID: <874k7yhamp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26 2021 at 14:50, SeongJae Park wrote:
> Some kernel threads such as DAMON could need to repeatedly sleep in
> micro seconds level.  Because usleep_range() sleeps in uninterruptible
> state, however, such threads would make /proc/loadavg reports fake load.
>
> To help such cases, this commit implements a variant of usleep_range()
> called usleep_idle_range().  It is same to usleep_range() but sets the
> state of the current task as TASK_IDLE while sleeping.
>
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: SeongJae Park <sj@kernel.org>

Andrew, I assume you want to pick that up along with the mm fix, right?

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
