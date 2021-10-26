Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58C543B7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhJZRBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237628AbhJZRBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:01:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE8C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:59:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e12so20473262wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zIiyeXHRszCpd6dN4MFI18tK54Aupg2Rr73ro+sG4vY=;
        b=JbTVal6HIp4qPfphJ6ID0F+2NjaasB7R5U3gE1JdhdiPHNqp/xEhTbqQg3o1IRxNnq
         EsCpXexe0yGOWZkUEeQ4Ovs/GVhM8yFxmUqN1lwkZizN32Vknffo3dVDiel2e3aJ05Yb
         hqHDrdus3pGT/xbkVjFJv6f0BiIvkE6Mh/8cW4aa0nlL0conWh5RmeM/retoVCF6UEsl
         Ws5cs/L0robwByGx0COprb7cMytKuj9JcK3bVNOq2NGpr2LQEWNeN/rawkwRvonGLaFG
         nIQjD2EoUIr1z7mykpC7u5jnXIwKP67P/CAsIUpy8lTuhb2ZTiF2E8Yq1ViSDjrwAGm+
         u16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zIiyeXHRszCpd6dN4MFI18tK54Aupg2Rr73ro+sG4vY=;
        b=Bc2LSE6aXgqqkWbYxiXMVM+wkX+PBDiET0vgM4NgvNx7oLUDAhhG33v8aD6R1jGALq
         jXO8tCwYwc/58BCGPzg1DueF2ncHRgXFc4RgPZZxMV/uIeZWoirWYe1tIuw5DT6OZ4jL
         bWk3bkR8lihbkC9Eq46+ZMmYb67NWKdSOiC7RyJXetMl2XgAys4lK2syXY12zo4qwrLu
         ctTQqGUVTDmmUH2uYUGiEJ57azBDvrPinMRRHvLHyPOC4yFpeO6bffzOyiM4ceFyIDow
         Dihw+z1IIq4sAPTqI9cQG/OR3nSTmNbjRJxOSty6hlLJ7+cW9zUdKmqnCN56sZvnM3nf
         Ku8Q==
X-Gm-Message-State: AOAM533E4PPH6IsexABuQqn68T4s1wynU3dt8k9KYuCIJLp32bP3VS8u
        CK3T7uMZ0n1sxGXEh6njQ+SeW50mEWKZ2LtV6v8=
X-Google-Smtp-Source: ABdhPJy7Bt6Ds5A1VUKe7KXCCNYyU9u1mcSI6SyXDIlUtgrm8hBDF9wzRc3UA6Atw7bUjHAWVdFO9jTpr7MIk6fJ93Q=
X-Received: by 2002:adf:e747:: with SMTP id c7mr1645538wrn.108.1635267551531;
 Tue, 26 Oct 2021 09:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211021185335.380810-1-xiehuan09@gmail.com> <20211022180752.0ed07b35@gandalf.local.home>
 <CAEr6+EBq_v+DGSDeiX5Dqc0RgD0sPpbhzpi=T2=r7M2oh90Fpg@mail.gmail.com>
 <20211026104720.03ad26c2@gandalf.local.home> <CAEr6+EDn=g+Q4FfxKn96K5CPcVT9B3FqJA0w4MMfo45DH8oShw@mail.gmail.com>
 <20211026114435.682fe060@gandalf.local.home> <CAEr6+ECnV_a+pTxf857Q3=gA5-bi+awtw-w=tzhBJdgXUq4PMQ@mail.gmail.com>
In-Reply-To: <CAEr6+ECnV_a+pTxf857Q3=gA5-bi+awtw-w=tzhBJdgXUq4PMQ@mail.gmail.com>
From:   Huan Xie <xiehuan09@gmail.com>
Date:   Wed, 27 Oct 2021 00:58:59 +0800
Message-ID: <CAEr6+EBROjKJ0LqTb1q5OMNJW61bKxUXTDTUrv0XdoJcEqpXvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] trace: Add trace any kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi steven,

On Wed, Oct 27, 2021 at 12:11 AM Huan Xie <xiehuan09@gmail.com> wrote:
>
> On Tue, Oct 26, 2021 at 11:44 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 26 Oct 2021 23:40:03 +0800
> > Huan Xie <xiehuan09@gmail.com> wrote:
> >
> > > > > static void trace_object_trigger(struct event_trigger_data *data,
> > > > > struct trace_buffer *buffer,  void *rec,
> > > > >                    struct ring_buffer_event *event)
> > > >
> > > >
> > > > OK, so let me ask this question. What is it that you want to see?
> > >
> > > Thanks, I got your point now,  my original idea was to just track the
> > > flow of objects.
> >
> > Well, the current patch set doesn't really show any flow of objects, as it
> > only records a value that never changes until the next kprobe is hit, and
> > we get that from the kprobe itself.
>
> My original purpose was to track which functions the (struct bio)
> passed through for the linux block subsystem.
> and which functions the (struct page) passed through for the linux
> memory subsystem.  ;-)
> and I feel this help will be great for learning and developing the linux kernel.

I doubt you may have misunderstood my first patch ;-)

1. Get the argN from the kprobe and record it (call it object).
2. The function trace_object_events_call() scanning every function args,
 If any of the args match the above record(object), output the ip and
parent ip to the ring buffer, so that we
can know which function the object has passed through.

> >
> > > >
> > > > And let's say I want to monitor that __bi_cnt while functions are being
> > > > traced. What would be *really cool*, is to mark that value!
> > >
> > > This is really cool to  get the change of the value. And is a good
> > > feature enhancement.
> > >
> >
> > Right, and this is what I thought the purpose of your patch was! :-)
> >
> > And why I got really excited about it. So I don't see this as a feature
> > enhancement to your patch, but the feature enhancement that your patch can
> > give us.
> >
> > -- Steve
>
> --
> JeffXie
--
JeffXie
