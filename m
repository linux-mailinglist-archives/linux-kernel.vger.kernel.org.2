Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94893BE92D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 16:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhGGOD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 10:03:27 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42891 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhGGOD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 10:03:26 -0400
Received: by mail-lf1-f43.google.com with SMTP id u18so4221086lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 07:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cr+5wo3WdSoAEHGmbrh0ZPwPCRii+HYvMNAQfwiCqAA=;
        b=OH7ByA4SLC4dBwoTQJT79JhpdmFxqR7O8l04O3G3Rqx5E5bsPUDnLEQ93e2hK45ys/
         hzIheAJxYgTm9ZH0K3eEJvcQuQYnhKMc/pMoXj206vXuW590ptbc6pkgC1vXfeHJzhrm
         0Zo/7lpvVtlAI4qHg8OR8aZQvAAVkN6T+eE1xOzOJPTZ2Lvkz3L56e3kZ9c/SsaoBVOR
         0kahnhRhdcbDowSOKgUjuLGs3duGGnOdGsNtZf4U472m//hgX5AC5KEX1A5iPTeGMnm1
         e9/D2hDTAsGycMLrY1pIOzGZgzd+naEjuovbWCP0LFsAe50FFchmp86SCIa+WIsF8kLq
         3zMQ==
X-Gm-Message-State: AOAM532pL7Vp0FuDS8QVDfYakJP9VQTskOGQnUb51jbhZnvPJg4JzVd+
        x9k5ho1wNpBf1GhpWMNQIycFsN5x69lKJB3QTJM=
X-Google-Smtp-Source: ABdhPJwk/6ok/k3U1oaTW5RJ+E6lavIUwoGpyftMjnrv6SyW+AfCjyzmZkrm7LA/suJmVL+7WWBGdwWAGwdhxixE6C8=
X-Received: by 2002:a19:4916:: with SMTP id w22mr19840934lfa.374.1625666443533;
 Wed, 07 Jul 2021 07:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210706154315.3567166e@gandalf.local.home> <CAM9d7chmHmm3tjJik5EQDOJOdn7G0D3W9EJUogf_POnyTe6tcA@mail.gmail.com>
 <20210706205039.64182493@rorschach.local.home>
In-Reply-To: <20210706205039.64182493@rorschach.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 7 Jul 2021 07:00:32 -0700
Message-ID: <CAM9d7chF1Qnch5PmhfAWbTPcN5ocgVEvNKqFYsLxWOiaZPdYgQ@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Add linear buckets to histogram logic
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Daniel Bristot de Oliveira Subject: [PATCH] tracing:" 
        <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 6, 2021 at 5:50 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 6 Jul 2021 16:20:07 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > >  { bytes_req: ~ 1400-1499 } hitcount:         30
> > >  { bytes_req: ~ 2000-2099 } hitcount:          6
> > >  { bytes_req: ~ 4000-4099 } hitcount:       2168
> > >  { bytes_req: ~ 5000-5099 } hitcount:          6
> >
> > For consistency with the log2 histogram, I'd like to see
> >
> >   { bytes_req: ~ 100 } hitcount:  3149
> >   { bytes_req: ~ 200 } hitcount:  1468
> >   { bytes_req: ~ 300 } hitcount:    39
> >   ...
> >
> > Or, if you really care about the value range
> >
> >   { bytes_req: 0 ~ 99 } hitcount:  3149
> >   { bytes_req: 100 ~ 199 } hitcount:  1468
> >   { bytes_req: 200 ~ 299 } hitcount:    39
>
> (Let the bike-shedding begin! ;-)

Sorry about that!  :)

>
> I actually dislike the log2 notation. For example, I just ran it with
> this:
>
>  ># echo 'hist:keys=bytes_req.log2:sort=bytes_req' > events/kmem/kmalloc/trigger
>  ># cat events/kmem/kmalloc/hist
>  # event histogram
>  #
>  # trigger info: hist:keys=bytes_req.log2:vals=hitcount:sort=bytes_req.log2:size=2048 [active]
>  #
>
>  { bytes_req: ~ 2^5  } hitcount:          8
>  { bytes_req: ~ 2^6  } hitcount:          2
>  { bytes_req: ~ 2^7  } hitcount:          4
>  { bytes_req: ~ 2^8  } hitcount:          2
>  { bytes_req: ~ 2^9  } hitcount:          2
>  { bytes_req: ~ 2^10 } hitcount:          3
>
>  Totals:
>      Hits: 21
>      Entries: 6
>      Dropped: 0
>
> And I don't know if that first entry is: 2^4 - 2^5 or if it is 2^5 - 2^6.
>
> And to me '~' means "approximately", but I also took it as "not exactly".
> I used it as:
>
>   { bytes_req: ~ 1400-1499 } hitcount:         30
>
> To mean, it's "approximately somewhere between 1400 and 1499" so, I kept the "~".
>
> Now for your suggestions:
>
> >   { bytes_req: ~ 100 } hitcount:  3149
> >   { bytes_req: ~ 200 } hitcount:  1468
> >   { bytes_req: ~ 300 } hitcount:    39
>
> Suffers the same fate as I dislike in log2. Is " ~ 100" 0-100 or 100-200?
>
> >   { bytes_req: 0 ~ 99 } hitcount:  3149
> >   { bytes_req: 100 ~ 199 } hitcount:  1468
> >   { bytes_req: 200 ~ 299 } hitcount:    39
>
> I feel is farther from log2 than my version. Stating that "~" means
> approximation, what does "0 ~ 99" really mean?

To me, it means "range".  The original intention was to
express [FROM, TO) and I thought we can omit the FROM
since it's same as TO of the previous line.  But we can use
inclusive ranges with FROM and TO for clarity.

But it's up to you.  I don't object to your change.

>
> So far I prefer my original version.
>
> BTW, we are also working on a user space parser for this, thus the
> output format of all hist logic is going to be a user space API (if it
> hasn't already become one.)
>
> So we do need to get this correct for the long haul.

Agreed.

Namhyung
