Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4293D7399
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhG0Kqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 06:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhG0Kqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 06:46:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B03C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:46:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so13792308wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DW59eJtYhMdAs/hV0pWYKOp7WsTITzUqBJ8Pl1MmYvU=;
        b=tg4jkLBJTXjnJTkM0mFlT+n1KUtRKrnP5yWho1AsMhjyhI+V3uaSwltg0vd+DEz/7q
         hp5Tu3sO8Q0VbbBjQXJLbr2wfwW1WU/mp7ka8hDtYXkTeuT6VdVBBsRuQ6Wy6r5pkSe8
         tJrGL3ze5fUiSzX8Jc8cIfwmYmCXrbnkdXbmLgR7crl/2XdQtrGHa5ZN1ffjJO3Jtv/e
         3FElbM9IMB8lqRVwglD9AcxDHpBg5ge8wkWnS4rpot2AUIJv04tMUo2zzHqCKRE4nmlM
         WKLCg2AbVzYxRHkbcrUCJZ+cOCa8iA09ZLjlyZJYpEC4AmWAlyeDCpEAinpKE8u13bJe
         eA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DW59eJtYhMdAs/hV0pWYKOp7WsTITzUqBJ8Pl1MmYvU=;
        b=AwQbAF9+tSepuITQRlNoBf8PW2akVXXqkuHs6SRHAvKx0Tqa/MuDS9FbP0b1+Pafrg
         PwWKYedzXb1wB/eM1R0sVZwhJV1xcNe+lFZELv39bHCI3L4QcpOZE4sG3hdBcHBEZPpm
         GhBtVLAICyNw5QAbxfQBTIvn8iAiT10GM/Ur0ZJZ7sdzTEQx0Ok8ab/hNozLEjjhTf9E
         Ur82e3lpOTRzVytvZQOZDJVmjIHJMR433ilMoaz0dzPUmT/Gk3M5ogWU+Gh67Z9k2dct
         BklkuGxgVbQfS3QOWsYgEwAz8XTVl4H37A/WShRM6VURLh1IwNlCPbllL51z8dFNbOUp
         Udnw==
X-Gm-Message-State: AOAM531uKM5Su/P0eJ0hJLF2AVqTrrWN0BapMW6sJ3GFU0HfUQ/Nh3DB
        682Rx6ra10FjkcqlvrEqmWWXDKJxVnYVzsdjRkSIQg==
X-Google-Smtp-Source: ABdhPJylAQRQbO/omIdAEgQZKm8teWyQVWFnL90fXyrj3+ZaUOYW4mpHHqwp9KUDwYHWK618hRaFoATAZ1plmrFeaLg=
X-Received: by 2002:adf:fb92:: with SMTP id a18mr23982590wrr.182.1627382788716;
 Tue, 27 Jul 2021 03:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210723124611.3828908-1-suzuki.poulose@arm.com>
 <20210723124611.3828908-8-suzuki.poulose@arm.com> <CAJ9a7Vi28GuPUx8jvGoYhqBRzWanwhiLJJuLnaZuPj46g3ex2w@mail.gmail.com>
 <064baefd-1213-1e54-20a0-b28f7565a810@arm.com>
In-Reply-To: <064baefd-1213-1e54-20a0-b28f7565a810@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 27 Jul 2021 11:46:18 +0100
Message-ID: <CAJ9a7VgEfx=BREdo23EW60c8W-FXNPrkDjAbiXA-wOi-cm_D8A@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] coresight: trbe: Do not truncate buffer on IRQ
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tamas.zsoldos@arm.com, Al Grant <al.grant@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        jinlmao@qti.qualcomm.com, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Suzuki,

On Mon, 26 Jul 2021 at 17:01, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike,
>
> On 26/07/2021 13:34, Mike Leach wrote:
> > Hi Suzuki,
> >
> > On Fri, 23 Jul 2021 at 13:46, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> The TRBE driver marks the AUX buffer as TRUNCATED when we get an IRQ
> >> on FILL event. This has rather unwanted side-effect of the event
> >> being disabled when there may be more space in the ring buffer.
> >>
> >> So, instead of TRUNCATE we need a different flag to indicate
> >> that the trace may have lost a few bytes (i.e from the point of
> >> generating the FILL event until the IRQ is consumed). Anyways, the
> >> userspace must use the size from RECORD_AUX headers to restrict
> >> the "trace" decoding.
> >>
> >> Using PARTIAL flag causes the perf tool to generate the
> >> following warning:
> >>
> >>    Warning:
> >>    AUX data had gaps in it XX times out of YY!
> >>
> >>    Are you running a KVM guest in the background?
> >>
> >> which is pointlessly scary for a user. The other remaining options
> >> are :
> >>    - COLLISION - Use by SPE to indicate samples collided
> >>    - Add a new flag - Specifically for CoreSight, doesn't sound
> >>      so good, if we can re-use something.
> >>
> >
> > What is the user visible behaviour when using COLLISION?
>
> If you meant a Warning from the perf tool (similar to TRUNCATE or
> PARTIAL), the answer is none. We could add one in the perf tool
> if you think this is necessary.
>

I do - the problem is that we have replaced a visible warning with a
silent failure.

While we agree that the side effects of TRUNCATE mean it unfeasible as
a solution here - at least the PARTIAL message does give some
indication.
The average perf user is going to rely on the output from the tool -
if there is no warning they will assume all is good, but they have
possible non-contiguous trace and no indication of such.

Since we are using a collision flag  in a particular context - i.e.
coresight trace - we have the chance to provide an appropriate message
for this context.

> > The TRUNCATE warning is at least accurate - even if the KVM thing is
> > something of a red herring.
>

Sorry - I meant PARTIAL here - but the comment stands otherwise.

>
> > It is easier to explain a "scary" warning, than try to debug someones
> > problems if perf is silent or misleading when using the COLLISION
> > flag.
>
> The RECORD_AUX still has this flag. So, if someone really wanted to
> know how many times the TRBE fired the IRQ and thus potentially lost a
> few bytes of the trace, they could always look at this.
>

They could - but how would they know that they needed to - what
indicators would they have that the trace was not continuous?
The point of the perf tool is that it presents an accurate picture to
the user, based on the data collected. Most users aren't going to
start digging into the intricacies of the perf data file formats and
nor should they have to.

> Definitely this is not something similar to "TRUNCATED", which we
> realized the hard way, nor the PARTIAL. But the perf tool could
> report something similar. Please remember that the perf tool always
> uses the "size" field from the RECORD_AUX to limit the trace decoding.
>
> So, I am not sure how this could create new problems.
>

There is no issue with decode - but if a user is investigating a
problem using trace, they need to be aware that some trace might be
dropped.
That way they can take mitigating action.

Regards

Mike

> Suzuki
>
> >
> > Regards
> >
> > Mike
> >
> >
> >> Given that we don't already use the "COLLISION" flag, the above
> >> behavior can be notified using this flag for CoreSight.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: James Clark <james.clark@arm.com>
> >> Cc: Mike Leach <mike.leach@linaro.org>
> >> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> >> Cc: Leo Yan <leo.yan@linaro.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-trbe.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> >> index 503bea0137ae..d50f142e86d1 100644
> >> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> >> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> >> @@ -615,7 +615,7 @@ static unsigned long arm_trbe_update_buffer(struct coresight_device *csdev,
> >>                   * for correct size. Also, mark the buffer truncated.
> >>                   */
> >>                  write = get_trbe_limit_pointer();
> >> -               perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
> >> +               perf_aux_output_flag(handle, PERF_AUX_FLAG_COLLISION);
> >>          }
> >>
> >>          offset = write - base;
> >> @@ -708,7 +708,7 @@ static void trbe_handle_overflow(struct perf_output_handle *handle)
> >>           * collection upon the WRAP event, without stopping the source.
> >>           */
> >>          perf_aux_output_flag(handle, PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW |
> >> -                                    PERF_AUX_FLAG_TRUNCATED);
> >> +                                    PERF_AUX_FLAG_COLLISION);
> >>          perf_aux_output_end(handle, size);
> >>          event_data = perf_aux_output_begin(handle, event);
> >>          if (!event_data) {
> >> --
> >> 2.24.1
> >>
> >
> >
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
