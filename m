Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0D8F43E6DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 19:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJ1RNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhJ1RM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 13:12:57 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BC4C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:10:30 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id v193so6594344pfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wVbViCn1zYbA5LR9hUnHBdFFQuE21UCca59RgZWVkdQ=;
        b=ZmxQ221QAXQlBqomXh/jJx3T/qgB6VeZAITESiEDx41zyszYMJYFPhzSkj1HRjnS68
         tqRxsomNfKtM5G+/jt9jWm9zvdRa3KTRbQ2pgE+UmALC+nWKvygh19cXIp47lNZVkydE
         B+d9j8kDp5L+zsONN+v39v6f+hkonMaH/WNJHjCXS4vuXJ8MsWHVWMQsSxgDGVVGWph3
         88VfOuJw2EbJfkumIEw13O0h5We0qrmtcz1Mt7mmb8argl6kg4ZtZB3ylI1sr9tfedfD
         deh1BjXCahsnK5CMhCsOsbpZzOeqdQocrhOlOShrf3E3RXVFGTodxa30TG8dv1TJfs3W
         PVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wVbViCn1zYbA5LR9hUnHBdFFQuE21UCca59RgZWVkdQ=;
        b=P6t9q9soWQwdRFpam+/ItiLxYPseq4qZYlvjD62qg2psZ4AMLUwY7HYvHHHZNuTguE
         R8nWLjffNwaWox1Xz4LftsKXUhqe8xL3qbwWDXjAC99CJWnyqQhulEXz50eKZ5vsEkXy
         WBFyWxn8VSgtXFq2pySfrqc/TiyfvYzxg2mTe0F4/O/XBb1auILDIvX9ELlC4eA95WBP
         D/OTNSTa4sMbueDfIBGiUebRl6tPRGGGuyAAP6RQ1MV9Yy1z8HdR9E3ozysujbAlK3vz
         RYJGhctr1MFVkwrFtzLrhAuFBAOH28Oo99Ye4QomkVhqFG441+95EPQLRZTGjAZUw1hg
         M02Q==
X-Gm-Message-State: AOAM531ZUimDGxiJzJ+sPJVGc6k+7oy4LElhBcRZZanza8D8fFprqe+S
        PuCE4lpnzXFdEkidUzyhgSuwIhkvgIxwtK7QCr6roQ==
X-Google-Smtp-Source: ABdhPJwwC1K47dYNQixY3sDFKQEIswUHSBgoRiolf1pddqRHvhfHMWFBL6FjLJeNsXWKJOvLDX2gsfTfQBaVQD8Rhdk=
X-Received: by 2002:a63:618d:: with SMTP id v135mr4170958pgb.79.1635441029064;
 Thu, 28 Oct 2021 10:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20211027205919.1648553-1-kaleshsingh@google.com>
 <20211027205919.1648553-3-kaleshsingh@google.com> <20211028065849.76b1bd7151e440881298b523@kernel.org>
 <CAC_TJvdxEuqkzH+VDNQvWZbLjHj0BKfnCHn647Y9-Ve2UTftRg@mail.gmail.com>
 <20211027195454.60993c83@rorschach.local.home> <20211028094351.617b7c2ea7c56055ee68d909@kernel.org>
 <CAC_TJveUiij8SQwfHVOYhQASq7bd0PUbyu7k0QLh-8S5ttC+wQ@mail.gmail.com>
In-Reply-To: <CAC_TJveUiij8SQwfHVOYhQASq7bd0PUbyu7k0QLh-8S5ttC+wQ@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 28 Oct 2021 10:10:17 -0700
Message-ID: <CAC_TJvcbxM6156CPEYB1FweLobXT1Mo6CTDqc3ks=Nq-eZcQOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] tracing/kselftests: Remove triggers with references
 before their definitions
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, surenb@google.com,
        hridya@google.com, namhyung@kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 7:58 PM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> On Wed, Oct 27, 2021 at 5:43 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Wed, 27 Oct 2021 19:54:54 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > On Wed, 27 Oct 2021 16:26:00 -0700
> > > Kalesh Singh <kaleshsingh@google.com> wrote:
> > >
> > > > > Why don't you use 'tac'? I love that idea :)
> > > > > Did you find any issue?
> > > >
> > > > Hi Masami,
> > > >
> > > > Thanks for the reviews. As with the first set of patches using tac
> > > > gives a regression here, though I'm not sure why it doesn't work -- I
> > > > also thought reversing the order would handle any dependencies
> > > > correctly.
> > >
> > > Right, because are triggers not added by list_add_rcu() which adds to
> > > the head of the list.
> >
> > Oops, so are the triggers shown in the reverse order?
> > (newer entry is top, older one is bottom)
> > Then do we need this patch, because we don't care about the
> > dependency.
>
> In the case of the hist expression tests. they create a variable:
> echo 'hist:keys=common_pid:x=1+2' >> trigger
>
> Then print its value in another histogram:
> echo 'hist:keys=common_pid:vals=$x' >> trigger
>
> At least in this case, the triggers are listed from oldest (top) to
> newest (bottom):
> cat trigger
> hist:keys=common_pid:vals=hitcount:x=3:sort=hitcount:size=2048 [active]

I realized the result of the expression can be read directly from the
trigger info, now that expressions of constants are squashed to a
single constant. So we wouldn't need the second trigger to see the
value and can drop this patch. I'll resend a new version.

Thanks,
Kalesh

> hist:keys=common_pid:vals=hitcount,$x:sort=hitcount:size=2048 [active]
>
> So we need to remove the trigger with the var ref first.
>
> - Kalesh
> >
> > > If anything, shouldn't things be removed in order?
> >
> > Hmm, I think the trigger itself might better to be changed. If any dependency in
> > the trigger list, it can not be restored from the copied file, like
> > below may fail.
> >
> > cat events/foo/bar/trigger > /tmp/foo.bar.trigger
> > cat /tmp/foo.bar.trigger > events/foo/bar/trigger
> >
> > (of course we can use 'tac' to restore it ...)
> >
> > This is
> >
> > Thank you,
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
