Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C45A322ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhBWMzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbhBWMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:55:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC01C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:54:51 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v1so22464840wrd.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vbdKltIhts0axs04YJ9CyEwqeT/nW8/5+MCqaVe0TFs=;
        b=hi2QVr3GmBlp8a2HbGiRh3SUPtZz5nr6+oD8MZzDNjFHEfWayB7cxB0mlc1jD+wj5V
         3v4cO1xGluyMynbmjLCUSZBvsmeNG5yBZGJZOTWVs8iG+gydyCS9Ge6d1U95q/y7qKOw
         F0BYpY6lpM114H/vDqCKhJWMn6lBVX492HJ/HYvnN9S65dIW0GW1Zyv6oqmXC5QP28fr
         btx8vqeNm9RtXSYJzKkuseVk03ZM7lIq8bxs1A+UtKnYOA6tdErmpcFvhLorJfI6blNh
         uNfhp8lJN/WPTOMMmJJDxHc/lTx0NvQxkGcOXKte5gJy7x4dmy/hTBkplKtNEhJdPB+6
         mqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vbdKltIhts0axs04YJ9CyEwqeT/nW8/5+MCqaVe0TFs=;
        b=RE0uJkU91c2YuUd0wf67WWskjv0J5l21UOV50orGfhIIungws3wci9VfZ7FCLj30gc
         S+Mc6OzY/cWnX+HXPuaGheXBnfSg5x6xTq/lxJ60+lpalwp79UFVYNMlbV6Ho7sJ8BN6
         a3N9Hphf6DlrS6/3iWKM8m9sNTt7R3myqfb6zpZEna3ysXQh8WjWhfAtAQFWxNcMVfNy
         3EQPyDfig7H/qsBLYbNOA5R/e8CAJ2pT9iuk+hYdw4P05tpaSLXZxVasgPK3j99421f8
         bKvgj17Pm8OiNiuwCEFdkgb2hR6H2Ql2is4JBS2qcflI7esA9Qb+qTH8T1WKwawBF3Zn
         Gwjw==
X-Gm-Message-State: AOAM533jom9BfdDG3PXp4+nOTkCOf3+BZqVmsoneXegEOrFY7GKjQFEv
        N7uknuvTYCptREWxMoRDkZLROAnw6EPmri0A
X-Google-Smtp-Source: ABdhPJxzRPhgsCy8jymXBxDG1BSUYj/hDljC3z3J2iMGk8hfjX1fNqcWgIKlNn6pHngZYhVcLE0+GQ==
X-Received: by 2002:a5d:4842:: with SMTP id n2mr14699171wrs.181.1614084890338;
        Tue, 23 Feb 2021 04:54:50 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id k1sm31919995wrx.77.2021.02.23.04.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 04:54:49 -0800 (PST)
Date:   Tue, 23 Feb 2021 12:54:47 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Peter Zijlstra <peterz@infradead.org>, stefan.saecherl@fau.de,
        qy15sije@cip.cs.fau.de, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel: debug: Handle breakpoints in kernel .init.text
 section
Message-ID: <20210223125447.7penkj42hd6ito4i@maple.lan>
References: <1613721694-16418-1-git-send-email-sumit.garg@linaro.org>
 <CAD=FV=X1hsFf08J5JNifzFGw=1ikmXj2mp6K=KMOAzCYDWKZUw@mail.gmail.com>
 <CAFA6WYO0PkbpXUJp9jayb71LsydpnHfLFyc21bHotC1dLJ7Dhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYO0PkbpXUJp9jayb71LsydpnHfLFyc21bHotC1dLJ7Dhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 02:33:50PM +0530, Sumit Garg wrote:
> Thanks Doug for your comments.
> 
> On Tue, 23 Feb 2021 at 05:28, Doug Anderson <dianders@chromium.org> wrote:
> > > To be clear there is still a very small window between call to
> > > free_initmem() and system_state = SYSTEM_RUNNING which can lead to
> > > removal of freed .init.text section breakpoints but I think we can live
> > > with that.
> >
> > I know kdb / kgdb tries to keep out of the way of the rest of the
> > system and so there's a bias to just try to infer the state of the
> > rest of the system, but this feels like a halfway solution when really
> > a cleaner solution really wouldn't intrude much on the main kernel.
> > It seems like it's at least worth asking if we can just add a call
> > like kgdb_drop_init_breakpoints() into main.c.  Then we don't have to
> > try to guess the state...

Just for the record, +1. This would be a better approach.


> Sounds reasonable, will post RFC for this. I think we should call such
> function as kgdb_free_init_mem() in similar way as:
> - kprobe_free_init_mem()
> - ftrace_free_init_mem()

As is matching the names...


> @@ -378,8 +382,13 @@ int dbg_deactivate_sw_breakpoints(void)
>         int i;
> 
>         for (i = 0; i < KGDB_MAX_BREAKPOINTS; i++) {
> -               if (kgdb_break[i].state != BP_ACTIVE)
> +               if (kgdb_break[i].state < BP_ACTIVE_INIT)
> +                       continue;
> +               if (system_state >= SYSTEM_RUNNING &&
> +                   kgdb_break[i].state == BP_ACTIVE_INIT) {
> +                       kgdb_break[i].state = BP_UNDEFINED;
>                         continue;
> +               }
>                 error = kgdb_arch_remove_breakpoint(&kgdb_break[i]);
>                 if (error) {
>                         pr_info("BP remove failed: %lx\n",
> 
> >
> > > +                       kgdb_break[i].state = BP_ACTIVE;
> > > +               else
> > > +                       kgdb_break[i].state = BP_ACTIVE_INIT;
> >
> > I don't really see what the "BP_ACTIVE_INIT" state gets you.  Why not
> > just leave it as "BP_ACTIVE" and put all the logic fully in
> > dbg_deactivate_sw_breakpoints()?
> 
> Please see my response above.
>
> [which was]
> > "BP_ACTIVE_INIT" state is added specifically to handle this scenario
> > as to keep track of breakpoints that actually belong to the .init.text
> > section. And we should be able to again set breakpoints after free
> > since below change in this patch would mark them as "BP_UNDEFINED":

This answer does not say whether the BP_ACTIVE_INIT state needs to be
per-breakpoint state or whether we can infer it from the global state.

Changing the state of breakpoints in .init is a one-shot activity
whether it is triggered explicitly (e.g. kgdb_free_init_mem) or implicitly
(run the first time dbg_deactivate_sw_breakpoints is called with the system
state >= running).

As Doug has suggested it is quite possible to unify all the logic to
handle .init within a single function by running that function when the
state changes globally.


Daniel.
