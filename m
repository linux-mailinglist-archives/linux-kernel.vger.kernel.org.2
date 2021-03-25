Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95463349420
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhCYOc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhCYOcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:32:21 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585F0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:32:20 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id f19so2139588ion.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rl6wZx9frr8nq5UyRVhR8/47rcAW+DhQJML6b1WSuTM=;
        b=SJCMdxo2n4EtZx3jkYASzqMgiP6t1TYCayv6JuLM4AJBMWUIRiwtsGMO6et8iOu/bK
         Q5WhAomvVpSlXQZWaFdt4bXKxn7SUUXfuXaYJ/6Mj8nufMgtbaR4jRvSfoQND3en6DGB
         n+oHAjM06iajignVUj1duEgicYNl7nSkN9EXq9wUNp1KokdRjPuEurPDTc0D7WiQeQwD
         ut6GUEqdGzkUxgU8cnG0fOpzJDU3p/tqyLogbwVOEAth9rSq7ulbGDrP0bqY152kV+10
         c3QRXFY03D3B9T9kojLNGNEFk9k80m1epPGR9cgwN5ewn3DGDQG0tLgQWXLlKFfDanV+
         srkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rl6wZx9frr8nq5UyRVhR8/47rcAW+DhQJML6b1WSuTM=;
        b=SC0DQqi46TLNCm1bPgHashngipYOZYlNrPR3NC46BQ/GOX1pPq8H9P0772jK2cDZx4
         +oE8yGNTHrxw+AHzwCgUcxdQNmgqHfHse77rZ5bCOabiyD+dXFEAqml1qJULUNdLbNoc
         2+PZBNlInv2WLwBtOyYIdQCfttgWBGHk0jqnFXPH2ulrMq5X6+xmH5fdjvIY70eTCIQx
         zz2CjvbmaZelXCIwcw1u+rlJpBsCALE4by4gncguXur3NyQzgl+yrvznNvKC5OV+5gWe
         PkeOX3uUhsByjDB2u2O65OZbFaOdzkYBPPStx01AwBrqI89HDD8skzjYBj+jcir2v4KS
         fGBw==
X-Gm-Message-State: AOAM533FRkOdGrPGAYNRRSe74znXveYLesZl14caWNnPc2fim9TaN4RX
        3JV1aE7dNOwjAmgtaToRVlrsOxvAEW0+MN2Rv+g=
X-Google-Smtp-Source: ABdhPJz6RqptTdBNTn/eR9+4b2IVH7qe8XIhYK52Uq0KQuw6uMuELIuo9G6N6kJXb0pvJVmvmaOHAs1jOmfiao/t1CU=
X-Received: by 2002:a5d:9bc8:: with SMTP id d8mr6482674ion.115.1616682739817;
 Thu, 25 Mar 2021 07:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210320113916.22175-1-hqjagain@gmail.com> <20210324205642.65e03248@oasis.local.home>
In-Reply-To: <20210324205642.65e03248@oasis.local.home>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Thu, 25 Mar 2021 22:31:27 +0800
Message-ID: <CAJRQjocpqrbbmq8EvYPwHcHJwbb1986XPqoFbqRySC31iORXFg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Update create_system_filter() kernel-doc comment
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 8:56 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 20 Mar 2021 11:39:16 +0000
> Qiujun Huang <hqjagain@gmail.com> wrote:
>
> > commit f306cc82a93d ("tracing: Update event filters for multibuffer")
> > added the parameter @tr for create_system_filter().
> >
> > commit bb9ef1cb7d86 ("tracing: Change apply_subsystem_event_filter() paths to
> > check file->system == dir")
> > changed the parameter from @system to @dir.
> >
> > commit 1e144d73f729 ("tracing: Add trace_array parameter to
> > create_event_filter()")
> > added the parameter @tr for create_filter().
> >
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  kernel/trace/trace_events_filter.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index e91259f6a722..00e78a012de9 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -1693,6 +1693,7 @@ static void create_filter_finish(struct filter_parse_error *pe)
> >
> >  /**
> >   * create_filter - create a filter for a trace_event_call
> > + * @tr: the trace array associated with these events
>
> This looks fine.
>
> >   * @call: trace_event_call to create a filter for
> >   * @filter_str: filter string
> >   * @set_str: remember @filter_str and enable detailed error in filter
> > @@ -1741,8 +1742,9 @@ int create_event_filter(struct trace_array *tr,
> >  }
> >
> >  /**
> > - * create_system_filter - create a filter for an event_subsystem
> > - * @system: event_subsystem to create a filter for
> > + * create_system_filter - create a filter for an event_subsystem_dir
>
> Do you know what a "event_subsystem_dir" is? I don't.
>
> In fact, the original text makes much more sense. You could remove the
> "_" and have it say "event subsystem".
>
>
> > + * @dir: event_subsystem_dir to create a filter for
>
> I have no idea what the above text even means. @dir is the descriptor
> for the system directory.

Get that.

>
> > + * @tr: the trace array associated with these events
> >   * @filter_str: filter string
> >   * @filterp: out param for created filter (always updated on return)
> >   *
>
> Looking at the code I think it should have another clean up, as where
> both @dir and @tr as passed it, it should just pass in @dir, because
> @tr is simply @dir->tr.

I'll clean it up in another patch.

>
> -- Steve

Thanks
