Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9BD309BB2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 12:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhAaLhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 06:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbhAaKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:05:36 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF2EC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:04:56 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id a19so13381053qka.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nzheroJB8cIA6Q/LI8iqtJZO27wdGlOAjDJoyuxr+Cw=;
        b=t5XJThddyWzYRgQeQ++ep+9YXj75dhsgl7+7t/uOV2igBYIWkrxXR9RSP8fGtmYzxi
         H7gs8QZVpdei1ZdwEe9m7IYRFfCgFOCfUr2frFRcguY+aIGrDcngi9S5bOMAG8UOeHH5
         mIlVqaMlVoKihg1pYiv4aPLn3ZhamoraJvUIGweGUkNz/Zv5x2N8wOch9Mhq54SemOy2
         c/EVo8hVc1LTF/8gom/lQY1HEd/6fABqORz+bTzCJFzL1DF75+uR/52D0xYA+rFImCZ5
         jq2CGU2R8U5Xq9hwtA0NgzBUBZW40TzYsIvpTd4E/OwBK79sphr3W4Cpw0kXwUmqzZSo
         F2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nzheroJB8cIA6Q/LI8iqtJZO27wdGlOAjDJoyuxr+Cw=;
        b=OrfZMAI+rdDxlaVVelR2Rs1+w6cMnzft9PaW3B/WsGmJtU9oKfUTTLqgcCIP8FyZqX
         ofoqSdTWFESSc9Y1LJ9PDvt0DJLtomxeNd2ihL+hchQxfSVD3gdn4zEZ3ImodXURFg6e
         6dQ/6GLFWcVWz0GXHNlG9WFWDI+DjAJeTpG1p0mW1PBErCvhVQAiq2KwwHIuxmkHYvDn
         ACCJu6XuXpbsy+cn/dBN597p1/p2eK1Rb5ZxUR5dhyfZhf5e9J+j6o2Sg3qGhZwPp4qK
         FFIO2Gqu7KBG5aanZvxWbxldXttZvM0DrgPlVPyQw45Cgie8X+U80QGb+TMO3BauH2O8
         T0dg==
X-Gm-Message-State: AOAM533/mt/0X+QR428xNtPa4FKo9EQht5QVCrSww3LHfeZ9pveQ45jF
        pOI1SWofJf4Nxx2DeaMb3sb23kztNHxQGNsAl1kulw==
X-Google-Smtp-Source: ABdhPJxG0f17DBUxma0xJnhqszbZXx5dPJnA7oRRxSioGzcEFXC9zpvNhXfqN+5RJEkwolyKXI0Vc4ROqxCTGHB5daQ=
X-Received: by 2002:a05:620a:918:: with SMTP id v24mr11391742qkv.350.1612087495220;
 Sun, 31 Jan 2021 02:04:55 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
In-Reply-To: <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 31 Jan 2021 11:04:43 +0100
Message-ID: <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
Subject: Re: Process-wide watchpoints
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:43 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > for sampling race detection),
> > > number of threads in the process can be up to, say, ~~10K and the
> > > watchpoint is intended to be set for a very brief period of time
> > > (~~few ms).
> >
> > Performance is a consideration here, doing lots of IPIs in such a short
> > window, on potentially large machines is a DoS risk.
> >
> > > This can be done today with both perf_event_open and ptrace.
> > > However, the problem is that both APIs work on a single thread level
> > > (? perf_event_open can be inherited by children, but not for existing
> > > siblings). So doing this would require iterating over, say, 10K
> >
> > One way would be to create the event before the process starts spawning
> > threads and keeping it disabled. Then every thread will inherit it, but
> > it'll be inactive.
> >
> > > I see at least one potential problem: what do we do if some sibling
> > > thread already has all 4 watchpoints consumed?
> >
> > That would be immediately avoided by this, since it will have the
> > watchpoint reserved per inheriting the event.
> >
> > Then you can do ioctl(PERF_EVENT_IOC_{MODIFY_ATTRIBUTES,ENABLE,DISABLE})
> > to update the watch location and enable/disable it. This _will_ indeed
> > result in a shitload of IPIs if the threads are active, but it should
> > work.
>
> Aha! That's the possibility I missed.
> We will try to prototype this and get back with more questions if/when
> we have them.
> Thanks!

Hi Peter,

I've tested this approach and it works, but only in half.
PERF_EVENT_IOC_{ENABLE,DISABLE} work as advertised.
However, PERF_EVENT_IOC_MODIFY_ATTRIBUTES does not work for inherited
child events.
Does something like this make any sense to you? Are you willing to
accept such change?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d18791a72d..f6974807a32c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3174,7 +3174,7 @@ int perf_event_refresh(struct perf_event *event,
int refresh)
 }
 EXPORT_SYMBOL_GPL(perf_event_refresh);

-static int perf_event_modify_breakpoint(struct perf_event *bp,
+static int _perf_event_modify_breakpoint(struct perf_event *bp,
                                         struct perf_event_attr *attr)
 {
        int err;
@@ -3189,6 +3189,28 @@ static int perf_event_modify_breakpoint(struct
perf_event *bp,
        return err;
 }

+static int perf_event_modify_breakpoint(struct perf_event *bp,
+                                       struct perf_event_attr *attr)
+{
+       struct perf_event *child;
+       int err;
+
+       WARN_ON_ONCE(bp->ctx->parent_ctx);
+
+       mutex_lock(&bp->child_mutex);
+       err = _perf_event_modify_breakpoint(bp, attr);
+       if (err)
+               goto unlock;
+       list_for_each_entry(child, &bp->child_list, child_list) {
+               err = _perf_event_modify_breakpoint(child, attr);
+               if (err)
+                       goto unlock;
+       }
+unlock:
+       mutex_unlock(&bp->child_mutex);
+       return err;
+}
+
 static int perf_event_modify_attr(struct perf_event *event,
                                  struct perf_event_attr *attr)
