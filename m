Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0404240E96A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345544AbhIPRyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357668AbhIPRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:52:07 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD73C061158
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:28:35 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id b200so8599461iof.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IGawo7qHdYJ6pDlqSWrZJzU7pFqydq2lO0Epdt4VQzw=;
        b=UdjgxAu0WzP8hlYxhK5Q5mSYYPA5I/3WpDrkEFnZYswXjZJw+MQ+U9sNTA5obFhKBM
         GdkzA4dBTAVghkCuWqLbClYfMWZc7vRdsXCZP2fpok8YZkQleFpkdLpFvIqu25NY42p4
         VvS9hzKv4Fmjb62G0WVhWWAE6AbYpalmX5n7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IGawo7qHdYJ6pDlqSWrZJzU7pFqydq2lO0Epdt4VQzw=;
        b=lhI4eOssM3RYlUrwCBWExDqbJA/T4AaGsuL9r66WKbKA5z8Dcf00I/7wogDA2tzb+Y
         iOW3HK0gB7kklns4iSaWXL4L6M9V9XUflEkyidCdD/Jjy71YCnhSEAJEd0n9dBNYbz9k
         b6mhj5ev3th0uQKm5gxuDgAahd7GhvTqprsodsUPTlXFB2hre/b+DG13oHktBEQpIv9A
         f03gYHBV4Ea5Io1m3iEfsznplCkgMbnl9UVF12f0O1YQCDjk0KUcvu9+bnsJK+vLc79E
         zXk0O2nBVTuMar3xdf0Y9+vUGq2j8VDXgo3wKFJGjXeBQaW5oREUJaF/utwhmUDP5GRI
         nAIw==
X-Gm-Message-State: AOAM532SoN4+1m6X0h9hHaCFvebg4xo+LKFAy14oZgMUBCcHpmTY08x9
        zNLIHyqsZkq88rdifG3QKn+ksgpng6B7uw==
X-Google-Smtp-Source: ABdhPJziLvyPzJ0GBHvgIA28lZhF1sVkDTbsv24389FWipSWH0kQo7dPztLoKPhzXbokmY+Tmdj0WA==
X-Received: by 2002:a5d:851a:: with SMTP id q26mr5012871ion.163.1631809714965;
        Thu, 16 Sep 2021 09:28:34 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id c23sm1982258ioi.31.2021.09.16.09.28.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 09:28:34 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id v16so7241636ilg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 09:28:34 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bad:: with SMTP id n13mr2439109ili.142.1631809714033;
 Thu, 16 Sep 2021 09:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210916154253.2731609-1-daniel.thompson@linaro.org>
In-Reply-To: <20210916154253.2731609-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 Sep 2021 09:28:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xri+J2=iQzCHLxB+ksT41V6Rexp+BXWi6Fe7=jq3oTFg@mail.gmail.com>
Message-ID: <CAD=FV=Xri+J2=iQzCHLxB+ksT41V6Rexp+BXWi6Fe7=jq3oTFg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Adopt scheduler's task clasification
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        jing yangyang <jing.yangyang@zte.com.cn>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 16, 2021 at 8:43 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently kdb contains some open-coded routines to generate a summary
> character for each task. This code currently issues warnings, is
> almost certainly broken and won't make any sense to any kernel dev who
> has ever used /proc to examine tasks (D means uninterruptible?).
>
> Fix both the warning and the potential for confusion but adopting the
> scheduler's task clasification. Whilst doing this we also simplify the

s/clasification/classification/


> filtering by using mask strings directly (this means we don't have to
> guess all the characters the scheduler might give us).
>
> Unfortunately we can't quite adopt the scheudler classification it in

s/scheudler/scheduler/


> its entirity because, whilst we can tolerate some changes to the filter

s/entirity/entirety/


> characters, we need to keep I as a means to identify idle CPUs rather than
> system daemons that don't contribute to the load average! Naturally there
> is quite a large comment discussing this.

I'm a bit curious why we're OK with changing other characters but not
'I'. Even if the scheduler use of the character 'I' is a bit
confusing, it still seems like it might be nice to match it just to
avoid confusion. Couldn't we use lowercase 'i' for idle CPUs?
Alternatively beef up the commit message justifying why exactly we
need to keep 'I' as-is.


> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Worth having a "Fixes" for the patch that introduced the warning?


> @@ -74,7 +74,7 @@ static void kdb_show_stack(struct task_struct *p, void *addr)
>   */
>
>  static int
> -kdb_bt1(struct task_struct *p, unsigned long mask, bool btaprompt)
> +kdb_bt1(struct task_struct *p, const char *mask, bool btaprompt)

In the comment above this function there is still a reference to
"DRSTCZEUIMA". Update that?


> @@ -2300,7 +2298,7 @@ void kdb_ps_suppressed(void)
>  /*
>   * kdb_ps - This function implements the 'ps' command which shows a
>   *     list of the active processes.
> - *             ps [DRSTCZEUIMA]   All processes, optionally filtered by state
> + *             ps [RSDTtXZPIMA]   All processes, optionally filtered by state

What about "U"? What about "E"?


> @@ -2742,7 +2741,7 @@ static kdbtab_t maintab[] = {
>         },
>         {       .name = "bta",
>                 .func = kdb_bt,
> -               .usage = "[D|R|S|T|C|Z|E|U|I|M|A]",
> +               .usage = "[R|S|D|T|t|X|Z|P|I|M|A]",

What about "U"? What about "E"?


> @@ -559,7 +484,6 @@ unsigned long kdb_task_state_string(const char *s)
>   */
>  char kdb_task_state_char (const struct task_struct *p)
>  {
> -       unsigned int p_state;
>         unsigned long tmp;
>         char state;
>         int cpu;
> @@ -568,16 +492,20 @@ char kdb_task_state_char (const struct task_struct *p)
>             copy_from_kernel_nofault(&tmp, (char *)p, sizeof(unsigned long)))
>                 return 'E';
>
> -       cpu = kdb_process_cpu(p);

Don't you still need this? You still have the `cpu` variable and you
still use it in the idle task case.


> -       p_state = READ_ONCE(p->__state);
> -       state = (p_state == 0) ? 'R' :
> -               (p_state < 0) ? 'U' :
> -               (p_state & TASK_UNINTERRUPTIBLE) ? 'D' :
> -               (p_state & TASK_STOPPED) ? 'T' :
> -               (p_state & TASK_TRACED) ? 'C' :
> -               (p->exit_state & EXIT_ZOMBIE) ? 'Z' :
> -               (p->exit_state & EXIT_DEAD) ? 'E' :
> -               (p_state & TASK_INTERRUPTIBLE) ? 'S' : '?';
> +       state = task_state_to_char((struct task_struct *) p);

Casting away constness is fine for now and likely makes this easier to
land, but maybe you can send a patch up to change the API to have
"const" in it?


-Doug
