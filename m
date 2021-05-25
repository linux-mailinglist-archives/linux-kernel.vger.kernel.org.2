Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A5390C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 00:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhEYWTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 18:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhEYWTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 18:19:06 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B827C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:17:35 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id d21so31742831oic.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rAt0rX4y6MI6ZB6kkQP4Yst97dY399ucmi/u+eK/3GY=;
        b=CtjGKGpYznf77xLWs1Ue894zcq5aWq12bzNkODUdmqJyvv+cHiAoUUskWgoe9xl/11
         j5gT6aIS40ni40dDrTZOZDHg6VQazpry4qrXTrK0HFIhsUbMRYjmW1KPoLGmYYAJiCmN
         1J/WAjt9RNxB5C/oBHI3Gjvhkv/IzMV2clwDA1rkz3TRmsKUGi2HZrFyatbwHR+hkIWC
         1DrJXBA3q31620hFXQEElNaKOR1vnh5bj99SAhequye3cyItSQKbjaAM+uRfvABcK5Xu
         7bw1Dl9UtN1HiPGVHHQJX9ymvrEdFFYRTicmKY9Gw8bxBu1jt4VlimEx3bSfHcwpyVjB
         OEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rAt0rX4y6MI6ZB6kkQP4Yst97dY399ucmi/u+eK/3GY=;
        b=eqPEK0BTYedTD4u+NNqX9RhC14O5jA+bG4GRFGf4KypNlPTKWn4HP5sqMicfLSOFYE
         62BX5mGpg8l0fvz45X52M6Si9iACg+k1ZxEyeUWqEj2PN2p9RozO/jrqlyGqqKSuwwCL
         ZRIINF1Zq6J6F9bJ0cMx2+7fBZEOAIPf6GTX3gd8UiBz4NRbWaj8SKDgCMSzntjuhKHy
         mDeK9XK4HL/sZJR3I1cF7TfLqe4OgmZQ1YTtiF3A8B5wYalGhsHvbJg/co1FVlOC0ZaL
         L+L3aVLhd6wlFTFzOSJ2FnFiwJfXlMCIrajnS/9LuHJcu+x7L++3FwnR4hAPpUjEsanQ
         q3Fg==
X-Gm-Message-State: AOAM530TOhNSVF3/5+HS9haWCfILxMW+tP6U7W3hRTj3Q3jRwpPZ/e8q
        hcV357wZGdpGmsUGbAJDgh5gZ1/Gs2FAow==
X-Google-Smtp-Source: ABdhPJypwIUtHa2O5+N6hagpKC4xJkrNUf937JJWNQUmUWOjOexUCMZHCDnmWb0SJ+LUVKnTKVMbxg==
X-Received: by 2002:aca:1702:: with SMTP id j2mr333254oii.1.1621981054278;
        Tue, 25 May 2021 15:17:34 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i26sm3718106oos.21.2021.05.25.15.17.32
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 25 May 2021 15:17:33 -0700 (PDT)
Date:   Tue, 25 May 2021 15:17:22 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, joel@joelfernandes.org,
        Ingo Molnar <mingo@kernel.org>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched: Add CONFIG_SCHED_CORE help text
In-Reply-To: <YKyhtwhEgvtUDOyl@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.11.2105251510590.2465@eggly.anvils>
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils> <YKyhtwhEgvtUDOyl@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Peter Zijlstra wrote:

> Subject: sched: Add CONFIG_SCHED_CORE help text
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Tue May 25 08:53:28 CEST 2021
> 
> Hugh noted that the SCHED_CORE Kconfig option could do with a help
> text.
> 
> Requested-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks,
Acked-by: Hugh Dickins <hughd@google.com>
if necessary (but there's more than enough of me there already).

> ---
>  kernel/Kconfig.preempt |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -104,4 +104,18 @@ config SCHED_CORE
>  	bool "Core Scheduling for SMT"
>  	default y
>  	depends on SCHED_SMT
> +	help
> +	  This option permits Core Scheduling, a means of coordinated task
> +	  selection across SMT siblings. When enabled -- see
> +	  prctl(PR_SCHED_CORE) -- task selection ensures that all SMT siblings
> +	  will execute a task from the same 'core group', forcing idle when no
> +	  matching task is found.
> +
> +	  Use of this feature includes:
> +	   - mitigation of some (not all) SMT side channels;
> +	   - limiting SMT interference to improve determinism and/or performance.
> +
> +	  SCHED_CORE is default enabled when SCHED_SMT is enabled -- when
> +	  unused there should be no impact on performance.
> +
