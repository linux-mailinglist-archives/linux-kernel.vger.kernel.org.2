Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E648343B5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbhJZPrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231580AbhJZPrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:47:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 215D961078;
        Tue, 26 Oct 2021 15:44:37 +0000 (UTC)
Date:   Tue, 26 Oct 2021 11:44:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Huan Xie <xiehuan09@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [RFC PATCH v2] trace: Add trace any kernel object
Message-ID: <20211026114435.682fe060@gandalf.local.home>
In-Reply-To: <CAEr6+EDn=g+Q4FfxKn96K5CPcVT9B3FqJA0w4MMfo45DH8oShw@mail.gmail.com>
References: <20211021185335.380810-1-xiehuan09@gmail.com>
        <20211022180752.0ed07b35@gandalf.local.home>
        <CAEr6+EBq_v+DGSDeiX5Dqc0RgD0sPpbhzpi=T2=r7M2oh90Fpg@mail.gmail.com>
        <20211026104720.03ad26c2@gandalf.local.home>
        <CAEr6+EDn=g+Q4FfxKn96K5CPcVT9B3FqJA0w4MMfo45DH8oShw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 23:40:03 +0800
Huan Xie <xiehuan09@gmail.com> wrote:

> > > static void trace_object_trigger(struct event_trigger_data *data,
> > > struct trace_buffer *buffer,  void *rec,
> > >                    struct ring_buffer_event *event)  
> >
> >
> > OK, so let me ask this question. What is it that you want to see?  
> 
> Thanks, I got your point now,  my original idea was to just track the
> flow of objects.

Well, the current patch set doesn't really show any flow of objects, as it
only records a value that never changes until the next kprobe is hit, and
we get that from the kprobe itself.


> >
> > And let's say I want to monitor that __bi_cnt while functions are being
> > traced. What would be *really cool*, is to mark that value!  
> 
> This is really cool to  get the change of the value. And is a good
> feature enhancement.
> 

Right, and this is what I thought the purpose of your patch was! :-)

And why I got really excited about it. So I don't see this as a feature
enhancement to your patch, but the feature enhancement that your patch can
give us.

-- Steve
