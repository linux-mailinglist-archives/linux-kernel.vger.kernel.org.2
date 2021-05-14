Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1E380D25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhENPcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbhENPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:32:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2776FC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:31:37 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z1so153979ils.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4qjl7DpmdiFL4QHuRO1KjC+QpNDLedNMiNr4q9jrz0=;
        b=OhD6TMKqRSENg6OUQOjbehTQCTNC+vWJ7P16mpJZEXosYwIOLK3pcVdrcan7ZhunWP
         6PxVVxwg/vmkvOhdb4BFO3d7GTRhiWRn9zrX5wyADGviAATpZ31/N8NZY4bKSBrZ4VFG
         0cdv520++VcV961qawAkNjSO+CobYw8nfdy5k+eETWcpztk9FrdKPQuYIQ2DQH3qfGSa
         XbqqJZ6kHJKte4UnmQ8ZL0rTDCK3ueMsgD0KNBnEoHDW1IqkuAb7s7iWUHP2JkQG17pM
         pdiIb65aKEWwXvQNE4EhZ2goLu7my2179FFY1omFtB9KihLu0e2qFG96mC4QbbvIoDN0
         CjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4qjl7DpmdiFL4QHuRO1KjC+QpNDLedNMiNr4q9jrz0=;
        b=RAIz0zVRdcQ4qp+nabLn9bbrvmDtxeE1ZNUY4MboUp8uCzYdscvzP9aj6rDZRFFB0r
         tdGobgbTcv2Pk5e4L3IATYLNBaEKcvUtNccntjImDikocg6ZbLSN+YkM2lcl4e/G2ByA
         PJk/wJ82dM6ZuX6IwXrl8t/+hSP7BKZgCcXrWIqhKsH7O8roixmbsX8/ILusJrz2J2Ub
         I80SNG7y4n6Av9iSqYMEH5aR0GH+eQ4/jbTVBLxVZMoT7j6cfmQJG0rsKRl8CoGBN8yq
         UdAOt1JgvFBZNZlgi3PRCb8ekzYAL0s5kdfpZf4qFZhL20fC3Vzj5pUV+xMgP7EwAgO3
         p6oQ==
X-Gm-Message-State: AOAM532sv/4bpB8Gm/N6AtJBPDSuC2Y4hUfNh8EK2rkFZ3op1dv7zf/9
        6+p6T1bQ9Of1HTJJQziiPBXJjN34RRJifP2jjbw42w==
X-Google-Smtp-Source: ABdhPJxW4THASuTUhaFDmufMv6BK/LiEvabejzLV7tBRek2jdQ6mhBk/vp5nMAK+0vbEq6UWDIkb7dVC6sEPK787iB8=
X-Received: by 2002:a05:6e02:54a:: with SMTP id i10mr3088214ils.252.1621006296613;
 Fri, 14 May 2021 08:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <fb6c8a4e284a9b6c043f4ac382387b19bd100976.camel@linux.intel.com> <20210513132051.31465-1-ggherdovich@suse.cz>
In-Reply-To: <20210513132051.31465-1-ggherdovich@suse.cz>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Fri, 14 May 2021 08:31:25 -0700
Message-ID: <CAAYoRsUcyFsFWDE=r+aMgDBa6hcgXgtE2jJ_NHas5e4TdgiBTg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Add Icelake servers support in
 no-HWP mode
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Can I on-board to this patch or do you want me to submit another?
I want to add COMETLAKE (tested), as below:

... Doug

On Thu, May 13, 2021 at 6:21 AM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> Users may disable HWP in firmware, in which case intel_pstate wouldn't load
> unless the CPU model is explicitly supported.
>
> Add ICELAKE_X to the list of CPUs that can register intel_pstate while not
> advertising the HWP capability. Without this change, an ICELAKE_X in no-HWP
> mode could only use the acpi_cpufreq frequency scaling driver.
>
> See also commit d8de7a44e11f ("cpufreq: intel_pstate: Add Skylake servers
> support").
>
> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
> ---
> This replaces https://lore.kernel.org/lkml/20210513075930.22657-1-ggherdovich@suse.cz
>
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index f0401064d7aa..28c9733e0dce 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2087,6 +2087,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
>         X86_MATCH(ATOM_GOLDMONT,        core_funcs),
>         X86_MATCH(ATOM_GOLDMONT_PLUS,   core_funcs),
>         X86_MATCH(SKYLAKE_X,            core_funcs),
> +       X86_MATCH(ICELAKE_X,            core_funcs),
   +       X86_MATCH(COMETLAKE,          core_funcs),
>         {}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
> --
> 2.26.2
>
