Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46E30EE16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbhBDILr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhBDILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:11:45 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D95C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 00:11:04 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id a1so1303115qvd.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Nog0rN1xf0KJgJL+WKZHZDXJcBl2YkqYIvV+qIaqw0=;
        b=vjqK6vq1mqbvodBwCVvC16zvZ55GAlwUvGcO5wKvXJgUEH3I8aASfppDhfrVYzIwBA
         TnYnUXtkr63u5/DMNY0w5uXeqtgm3oJHAcI9mvCj5xfqvWO+m8N/A/xZnrQfd/T0fyS9
         3RsZSx2vBdAtGI4kKmkp+zEsxihvfVc1Q0ol69PKFpurZuvcZu85IbSqWSIke+VLrrJJ
         m9+tTeKwh3y2jx8Qt0eydv1E/U1OTHst8Ujrv0nBjDECjnZJrgWS+fWXYkIH63s/F3gG
         VHFNPkGOCqYtjidc913a8wfoKFcCYC3bnVNeldRcArmLCtsD3NDfceD8ZRS5GvW2Es9T
         rFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Nog0rN1xf0KJgJL+WKZHZDXJcBl2YkqYIvV+qIaqw0=;
        b=lKFJSv0Na2lSro3jN6L3cnynw0eeq9Z8Fy7RWiI8K09ZUajpFkkkOGq543Ky96kNwh
         VSHfq0SoxBB/lYw0gX5cm9JpxqMLKfF4hfOTTPBtem23QIAa20n0kW0upMOn9N4KK/fN
         qXkRAFQQe0XBbKVc8qfMLpyS4/JEH0RHCZsyoKh/g934lWoG52HnPjuwn60/arW/wdOw
         05199urUXGtmch/dAnw/iYPfKlIwGnycgtLoqHiaqOiUv0vS1gUl1Yw8CriqL4rbx+4N
         WwceEdJByjBsne09AQ7f+o5ILQLRSTSUasNJRNqSaaPT9TNa2LbPvnSPcGYi4BjZuFL5
         ntqA==
X-Gm-Message-State: AOAM531KyKnW1Iu0VWrBTFhh82D2uxbskTCVBbGOLqu4JK3Rzzrhnlww
        JS3Ol+B7kRV/SspJfBFHTBhvrRL/mPTuaiOSoVvxAw==
X-Google-Smtp-Source: ABdhPJyxh7OkH68oMlCcLLygHG4tBaqblba+vktv9F97W5rg8PHQlPLQbVuPyFUlZu/Vpw0u9obIcqHYjmykPPF/Olo=
X-Received: by 2002:a0c:ab16:: with SMTP id h22mr6458067qvb.44.1612426263739;
 Thu, 04 Feb 2021 00:11:03 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com>
 <20201112103125.GV2628@hirez.programming.kicks-ass.net> <CACT4Y+ayRHua-6UyRwSM3=_oi+NkXbaO3-zZ1mpDmWonbybkeA@mail.gmail.com>
 <CACT4Y+bW1gpv8bz0vswaVUt-OB07oJ3NBeTi+vchAe8TTWK+mg@mail.gmail.com>
 <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com> <CAM9d7ci4GqApJoG5B2ise2R20Eu7yz1zFxkA+wM-LoCDRCdnbw@mail.gmail.com>
In-Reply-To: <CAM9d7ci4GqApJoG5B2ise2R20Eu7yz1zFxkA+wM-LoCDRCdnbw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 4 Feb 2021 09:10:52 +0100
Message-ID: <CACT4Y+Z34tz4k09Ei+BDzrM1XmftTzTRBG7nkJLReN+ZTUXhPw@mail.gmail.com>
Subject: Re: Process-wide watchpoints
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 6:38 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hello,
>
> On Sun, Jan 31, 2021 at 7:28 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > Not directly related to the above question, but related to my use case.
> > Could we extend bpf_perf_event_data with some more data re breakpoint events?
> >
> > struct bpf_perf_event_data {
> >     bpf_user_pt_regs_t regs;
> >     __u64 sample_period;
> >     __u64 addr;
> > };
> >
> > Ideally, I would like to have an actual access address, size and
> > read/write type (may not match bp addr/size). Is that info easily
> > available at the point of bpf hook call?
> > Or, if that's not available at least breakpoint bp_type/bp_size.
> >
> > Is it correct that we can materialize in bpf_perf_event_data anything
> > that's available in bpf_perf_event_data_kern (if it makes sense in the
> > public interface of course)?
> >
> > struct bpf_perf_event_data_kern {
> >     bpf_user_pt_regs_t *regs;
> >     struct perf_sample_data *data;
> >     struct perf_event *event;
> > };
> >
> > Unfortunately I don't see perf_event_attr.bp_type/bp_size
> > stored/accessible anywhere in bpf_perf_event_data_kern. What would be
> > the right way to expose them in bpf_perf_event_data?
>
> I think you can access it via event->attr.bp_type/size in the struct
> bpf_perf_event_data_kern.


Hi Namhyung,

Right, that's I need. Thanks.
