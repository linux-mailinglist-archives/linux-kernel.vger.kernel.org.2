Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDA40F3EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236683AbhIQITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhIQITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:19:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDF6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:18:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id w17so5612115wrv.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+EBxk48D2Ri39ajK9sHFGOT1FXUJjXNGWwxV16s2SjI=;
        b=Hrv+P7lmpHE0m2T8u2gh057X/ZLS4E7VSZNGXccENgj/N7Uxh11gCyN0lGU3oNhHxe
         +XTIXz/CyI56g3MW2Y7mpIGKcOE8Alpy0OC6f6z+O+RNY+GH+jhKS71yws1V2tGKd2XC
         33TsdEARtBKBXszG8D5z2rGTwQKU2xcfvCAEpg52oAgwRXUs7FG2JzZltoAKXu1tJ/36
         /p8Y9AE/xdjBzDHThA9q/79J+29I4NMyhGX+74SmB8DACGGrOEUBkn8PJdtaWo6i20YQ
         sVZm6yCqvRkVh5cnSomMq6GMBUCRR8jJToIepYDslIotXjdj6HlMC/VK2lQH2AU6Sl5m
         nifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EBxk48D2Ri39ajK9sHFGOT1FXUJjXNGWwxV16s2SjI=;
        b=jcVpWIJd1aVZz/tvvRbb4BwvSesuzj2cv6TZ4qsoT8OESF2/MXe5ApexZcFku+KDos
         R1gimRKGbeokRXZmsVdYNk+/BgaSnl/oYjMI9SfFSl0tcmcxmrcBbaMobl6oiRNjSO5l
         Tv3ZN1bdNff65Cr01u9szIlqG8ZGGy8it+tFs91ODPm7bkPHSAg12HBE2Jo7Y+LN3LVU
         PiRmxmci8lNWtG4Spmj3UIMg4LkV0kj/Lpztm4kRWvSx+KhxsSv9kRJh9ckkCfA91opu
         Q4LFjdp/Zm3TbM/yWlGfzMinE95dBjFNd9PGOC+rmjAPRYz4isNDQ9zR1l2aZ6BkVv4c
         8Y9Q==
X-Gm-Message-State: AOAM533Smgbngzq4SbuteiqUTGfn0tmbAyYGCg/igiRgKdztzfxWNPQs
        ZtenEUV1nlROJyccotTGBdsYpg==
X-Google-Smtp-Source: ABdhPJzw2bpggPBJCppZg2Y1vp0YqGgFpDYA9U0vmBJeddmUbIU6OoaSWRLKxa/DK4Lg1oi/oWwrzQ==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr10685224wrv.405.1631866698733;
        Fri, 17 Sep 2021 01:18:18 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v21sm781664wrv.3.2021.09.17.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:18:18 -0700 (PDT)
Date:   Fri, 17 Sep 2021 09:18:16 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Subject: Re: [PATCH] kdb: Adopt scheduler's task clasification
Message-ID: <20210917081816.kkyvqbdptnyke5jp@maple.lan>
References: <20210916154253.2731609-1-daniel.thompson@linaro.org>
 <CAD=FV=Xri+J2=iQzCHLxB+ksT41V6Rexp+BXWi6Fe7=jq3oTFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xri+J2=iQzCHLxB+ksT41V6Rexp+BXWi6Fe7=jq3oTFg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 09:28:22AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Thu, Sep 16, 2021 at 8:43 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > Currently kdb contains some open-coded routines to generate a summary
> > character for each task. This code currently issues warnings, is
> > almost certainly broken and won't make any sense to any kernel dev who
> > has ever used /proc to examine tasks (D means uninterruptible?).
> >
> > Fix both the warning and the potential for confusion but adopting the
> > scheduler's task clasification. Whilst doing this we also simplify the
> 
> s/clasification/classification/
> [...]
> s/scheudler/scheduler/
> [...]
> s/entirity/entirety/

Will do. Thanks.


> > characters, we need to keep I as a means to identify idle CPUs rather than
> > system daemons that don't contribute to the load average! Naturally there
> > is quite a large comment discussing this.
> 
> I'm a bit curious why we're OK with changing other characters but not
> 'I'. Even if the scheduler use of the character 'I' is a bit
> confusing, it still seems like it might be nice to match it just to
> avoid confusion. Couldn't we use lowercase 'i' for idle CPUs?
> Alternatively beef up the commit message justifying why exactly we
> need to keep 'I' as-is.

I've been though a couple of iterations and nothing felt 100% right
(to the extent I should probably have marked the patch RFC).

There is another thing I left for a later patch... and that is that
the logic to hide sleeping kernel threads (called system daemons
in the comments) is also rather broken at present since, in the modern
kernel, the majority of sleeping system deamons today tend to be doing
uninterruptible sleeps (and many are marked no load and are reported
as idle). That means that the S -> M translation needs to change since
the way it hides processes is too unpredictable. I think it needs to
become an S -> s, D -> d and, if we keep I, I -> i.

Or, putting it another way, once we fix the S -> M translations, then
finding a character that implies idle and does not collide with the
existing set is very hard.

Perhaps '-' might be a good way to mark idle tasks? It's different that
the not-really-a-task nature of idle tasks might be obvious.

Let me take a second look!


> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Worth having a "Fixes" for the patch that introduced the warning?

I'm never sure how useful Fixes: that point to the dawn of time
actually are.


> > @@ -74,7 +74,7 @@ static void kdb_show_stack(struct task_struct *p, void *addr)
> >   */
> >
> >  static int
> > -kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
> > +kdb_bt1(struct task_struct *p, const char *mask, bool btaprompt)
> 
> In the comment above this function there is still a reference to
> "DRSTCZEUIMA". Update that?

We spotted. I'm inclined to change this and the one for ps to
<filter> and not attempt to maintain a list of valid characters.


> > @@ -2300,7 +2298,7 @@ void kdb_ps_suppressed(void)
> >  /*
> >   * kdb_ps - This function implements the 'ps' command which shows a
> >   *     list of the active processes.
> > - *             ps [DRSTCZEUIMA]   All processes, optionally filtered by state
> > + *             ps [RSDTtXZPIMA]   All processes, optionally filtered by state
> 
> What about "U"? What about "E"?

As above... keeping these comments maintained seems a little pointless.
I'll switch this to filter.
> 
> 
> > @@ -2742,7 +2741,7 @@ static kdbtab_t maintab[] = {
> >         },
> >         {       .name = "bta",
> >                 .func = kdb_bt,
> > -               .usage = "[D|R|S|T|C|Z|E|U|I|M|A]",
> > +               .usage = "[R|S|D|T|t|X|Z|P|I|M|A]",
> 
> What about "U"? What about "E"?

I might even consider <filter> here (and a few extra hints). The output
of ps (or ps A) is a much more useful way to figure out the interesting
tasks to filter.


> > @@ -559,7 +484,6 @@ unsigned long kdb_task_state_string(const char *s)
> >   */
> >  char kdb_task_state_char (const struct task_struct *p)
> >  {
> > -       unsigned int p_state;
> >         unsigned long tmp;
> >         char state;
> >         int cpu;
> > @@ -568,16 +492,20 @@ char kdb_task_state_char (const struct task_struct *p)
> >             copy_from_kernel_nofault(&tmp, (char *)p, sizeof(unsigned long)))
> >                 return 'E';
> >
> > -       cpu = kdb_process_cpu(p);
> 
> Don't you still need this? You still have the `cpu` variable and you
> still use it in the idle task case.

Not sure what happened here. I have to assume fat fingers post testing
since I tested the code paths to recognise idle threads before posting.


> > -       p_state = READ_ONCE(p->__state);
> > -       state = (p_state == 0) ? 'R' :
> > -               (p_state < 0) ? 'U' :
> > -               (p_state & TASK_UNINTERRUPTIBLE) ? 'D' :
> > -               (p_state & TASK_STOPPED) ? 'T' :
> > -               (p_state & TASK_TRACED) ? 'C' :
> > -               (p->exit_state & EXIT_ZOMBIE) ? 'Z' :
> > -               (p->exit_state & EXIT_DEAD) ? 'E' :
> > -               (p_state & TASK_INTERRUPTIBLE) ? 'S' : '?';
> > +       state = task_state_to_char((struct task_struct *) p);
> 
> Casting away constness is fine for now and likely makes this easier to
> land, but maybe you can send a patch up to change the API to have
> "const" in it?

I already have the patch written but I'd like to keep it decoupled from
the this one due to the warning fix aspect (I'll note in header).


Daniel.
