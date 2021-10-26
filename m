Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D930D43B69D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhJZQNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbhJZQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:13:37 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C20C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:11:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g141so14626913wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNvhvS+omTapD0lmRTOHfCi+rtlERIM+Ep5FDBCLxiw=;
        b=V10uwXBbPFCW4DIAj09kz/W2rvsCVSHTbss1G3lQ4vq/iZwPq3NCT3p4v9Xc0kG4yD
         Z95BB9lR3KDVX3iB6PMjItUIkFtDJhwFOuIzhshSnWpiIX4m0JYAFos+OkQaP7UwxY2t
         DdffPWWYCEmKZE8OAyPUYNzzimRVna3axdnr6P9Ql9WnJ1QUr4egcS+wmVPxOYRlflzT
         c/TTJVrx5hymjXDaOr9qk9/IHWTlo19vtaXFmX872LwDlTBfh7dsRIzZWozfPqvaFYS8
         L4g1TgxLfGyvVzry3xLr5uUTwxws+41DYQexRnO9v/koq55//dHq92ajjr4o0wrIUmsf
         j1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNvhvS+omTapD0lmRTOHfCi+rtlERIM+Ep5FDBCLxiw=;
        b=kojvRy4SHE06WWRMaiwFBtSCI9Yo+dzuwPL6XVdOhu7FS+aynlZQXBRoP2oCJVMVN5
         raPou2VURlklzcPExp0MVYDXxpn/cVDYGtYYKFY1Pi8rMyVzzn2i6SD6CeuYuiqjQ93P
         B+X4Axu8LnAXGfT6JQ/qKLVTOtsh13DyxEWCaoLEsOQ2HYrkEVGF/VF+wDwahHxGsoMu
         cY28gvjiTCGWwJ7KcHoD6ibAXjr+9uNyHv4gRshinoapctHhqnrqmZFNK4dZ8uJxiete
         bLzMquRkay9sJHZYUwrdlJR3vZ7zpLHb9ghHx+AX963khPp/mqI4kQ9P3Ry+J54PfIBN
         3grA==
X-Gm-Message-State: AOAM533vqqYlhA8GUMYMzpRBeedE51K977dFtrwE82dkacZ7RujF+ivm
        gLtE2CsAifColarbkG1IOTTbSqqhvVrtXbyB4Js=
X-Google-Smtp-Source: ABdhPJzENddQNKUL/rorx4/R/VFBpK7Kptw0/L0wkjGN9eZg/KMPY70sd/5695/paGBUqIGzFq8S02sBLjSiLNGFbyg=
X-Received: by 2002:a1c:f316:: with SMTP id q22mr41990131wmq.55.1635264672402;
 Tue, 26 Oct 2021 09:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211021185335.380810-1-xiehuan09@gmail.com> <20211022180752.0ed07b35@gandalf.local.home>
 <CAEr6+EBq_v+DGSDeiX5Dqc0RgD0sPpbhzpi=T2=r7M2oh90Fpg@mail.gmail.com>
 <20211026104720.03ad26c2@gandalf.local.home> <CAEr6+EDn=g+Q4FfxKn96K5CPcVT9B3FqJA0w4MMfo45DH8oShw@mail.gmail.com>
 <20211026114435.682fe060@gandalf.local.home>
In-Reply-To: <20211026114435.682fe060@gandalf.local.home>
From:   Huan Xie <xiehuan09@gmail.com>
Date:   Wed, 27 Oct 2021 00:11:00 +0800
Message-ID: <CAEr6+ECnV_a+pTxf857Q3=gA5-bi+awtw-w=tzhBJdgXUq4PMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] trace: Add trace any kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:44 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Oct 2021 23:40:03 +0800
> Huan Xie <xiehuan09@gmail.com> wrote:
>
> > > > static void trace_object_trigger(struct event_trigger_data *data,
> > > > struct trace_buffer *buffer,  void *rec,
> > > >                    struct ring_buffer_event *event)
> > >
> > >
> > > OK, so let me ask this question. What is it that you want to see?
> >
> > Thanks, I got your point now,  my original idea was to just track the
> > flow of objects.
>
> Well, the current patch set doesn't really show any flow of objects, as it
> only records a value that never changes until the next kprobe is hit, and
> we get that from the kprobe itself.

My original purpose was to track which functions the (struct bio)
passed through for the linux block subsystem.
and which functions the (struct page) passed through for the linux
memory subsystem.  ;-)
and I feel this help will be great for learning and developing the linux kernel.

>
> > >
> > > And let's say I want to monitor that __bi_cnt while functions are being
> > > traced. What would be *really cool*, is to mark that value!
> >
> > This is really cool to  get the change of the value. And is a good
> > feature enhancement.
> >
>
> Right, and this is what I thought the purpose of your patch was! :-)
>
> And why I got really excited about it. So I don't see this as a feature
> enhancement to your patch, but the feature enhancement that your patch can
> give us.
>
> -- Steve

--
JeffXie
