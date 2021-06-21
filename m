Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594D53AE7BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFUK7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFUK7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:59:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92417C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:57:23 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n23so10192668wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=clF9wEFSrz/v2WVCRdc6dS5IP9XeQy5WQHIia05IgYQ=;
        b=KPtNjFRCb/EW9vegJsEI18s4uWG03qNGQbL7vvggXIxX46EGXTONi8d2khNA64emoN
         hIzoQr7FlbuhqQoFzhTdnXbDR9WOGlT+doWPdYWc6yoDM1mm0YICATMaPH7mlwKIPjgb
         QBBjkRE37ABX4dYD7a0j2HsIiLv/HuZWiT5zzQ+YW6EzUqfBiMOtUUDsbSuY1trRuMpn
         SdSKUdSnBiLYTNeg9VhTpAKeh3ENA3A2qVs9GzpZXmhR6IBSctdzmyF1PbmyqlZXwHMy
         6jFbJl2IpvZDpy+feDWvf+mpn2kUkcHngD6vOzZ4r4NPO/P0Xzc/UTovWgaswE2Tu8QH
         goug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=clF9wEFSrz/v2WVCRdc6dS5IP9XeQy5WQHIia05IgYQ=;
        b=oQ3OiIivvzgj8KlGnDw1qJziGfIGgWyTDksJ8Worr0vXgXDLhK8YLnPOpeccsAFr3+
         ZD77Gl6o4AVv9Awp8/81tUL0Id95ppX0IEm/GbzOeESnCCLiE/6Lk3lsA8vKUoeQ9thU
         Mj9Xe9q0YxDJwAqPYMZJUWNpLtOC284pYd8K9fhL0tgVBchKv6VragZEne3L5O/dPCiE
         tXdj9DLMT2fQ43eCtTn27QoCYKx9d8wBrDXDEO4E94x8e4XobFa4BD8mARyXNDg+Mchb
         PNjj/em37a9SVx/EqJGF+Fjunt8VRywsW7VfamYDpPDAd5zKYtjSCVtVn6CEQv2garYA
         5EgQ==
X-Gm-Message-State: AOAM5303b7KHxaya7MK8QXv1vepJ7HGudVka3uWWFwgNSBi9UbL6bpet
        DjFO83hVW93E6iDPLSWF/MW7PA==
X-Google-Smtp-Source: ABdhPJwk3Ok2JGqa/Wa4XglAtz7paDODsUtTzPHCd18DJieYnxwpV+x0Idh2IrvYbDJ3CiPx2MSqMw==
X-Received: by 2002:a05:600c:3ba0:: with SMTP id n32mr26530846wms.107.1624273042055;
        Mon, 21 Jun 2021 03:57:22 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id p13sm16352891wrt.89.2021.06.21.03.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:57:21 -0700 (PDT)
Date:   Mon, 21 Jun 2021 10:57:18 +0000
From:   Quentin Perret <qperret@google.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        vincent.guittot@linaro.org, qais.yousef@arm.com,
        rickyiu@google.com, wvw@google.com, patrick.bellasi@matbug.net,
        xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
Message-ID: <YNBwjnRbQrWiG57/@google.com>
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-2-qperret@google.com>
 <YMJiaO0IN2pN/EYY@hirez.programming.kicks-ass.net>
 <YMMP9uqcCeDlt95F@google.com>
 <23e44dd5-5229-ac16-5801-3b74f013b7f3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23e44dd5-5229-ac16-5801-3b74f013b7f3@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Thursday 17 Jun 2021 at 17:27:56 (+0200), Dietmar Eggemann wrote:
> On 11/06/2021 09:25, Quentin Perret wrote:
> > On Thursday 10 Jun 2021 at 21:05:12 (+0200), Peter Zijlstra wrote:
> >> On Thu, Jun 10, 2021 at 03:13:04PM +0000, Quentin Perret wrote:
> >>> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
> >>> active task to maintain the last uclamp.max and prevent blocked util
> >>> from suddenly becoming visible.
> >>>
> >>> However, there is an asymmetry in how the flag is set and cleared which
> >>> can lead to having the flag set whilst there are active tasks on the rq.
> >>> Specifically, the flag is cleared in the uclamp_rq_inc() path, which is
> >>> called at enqueue time, but set in uclamp_rq_dec_id() which is called
> >>> both when dequeueing a task _and_ in the update_uclamp_active() path. As
> >>> a result, when both uclamp_rq_{dec,ind}_id() are called from
> >>> update_uclamp_active(), the flag ends up being set but not cleared,
> >>> hence leaving the runqueue in a broken state.
> >>>
> >>> Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
> >>> things remain symmetrical.
> >>
> >> The code you moved is neither in uclamp_rq_inc_id(), although
> >> uclamp_idle_reset() is called from there
> > 
> > Yep, that is what I was trying to say.
> > 
> >> nor does it _set_ the flag.
> > 
> > Ahem. That I don't have a good excuse for ...
> 
> (A) dequeue -> set
> 
> (1) dequeue_task() -> uclamp_rq_dec() ->
> 
> (2) cpu_util_update_eff() -> ... -> uclamp_update_active() ->
> 
> uclamp_rq_dec_id()
> 
>     uclamp_rq_max_value()
> 
>         /* No tasks -- default clamp values */
>         uclamp_idle_value() {
> 
>             if (clamp_id == UCLAMP_MAX)
>                 rq->uclamp_flags |= UCLAMP_FLAG_IDLE;  <-- set
>         }
> 
> ---
> 
> (B) enqueue -> clear
> 
> (1) enqueue_task() ->
> 
> uclamp_rq_inc() {
> 
> (2) cpu_util_update_eff() -> ... -> uclamp_update_active() ->
> 
>     uclamp_rq_inc_id() {
> 
>         uclamp_idle_reset() {
>     						     <-- new clear
>        }                                                     ^
>     }                                                        |
>                                                              |
>     if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)                 |
>         rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;       <-- old clear
> }
> 
> ---
> 
> uclamp_update_active()
> 
>     if (p->uclamp[clamp_id].active) {
>         uclamp_rq_dec_id()            <-- (A2)
> 	uclamp_rq_inc_id()            <-- (B2)
>     }
> 
> Is this existing asymmetry in setting the flag but not clearing it in
> uclamp_update_active() the only issue this patch fixes?

I think this is the root of the problem, but it can have odd symptoms.
In a bad case that can lead to hitting the WARN in uclamp_rq_dec_id
(which is how we've found the bug in the first place).

I'll try and repost this with a correct commit message soon -- still
fighting with my inbox right now.

Thanks,
Quentin
