Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07010321449
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBVKnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBVKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:43:11 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0DC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:42:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n4so18546222wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4I8/e2g26fKgyDbLzwFA1lsSaN1mfB36eS6RU48Kpg=;
        b=MaWYpZqG2eB5gkaVIkLlDOHhxrbnuAcfl4Y5A84F2LgJ/ovBafxI+tFnsEP6NtCe0F
         cZcL/UtTbJ7Gsct0WVgZONdi36+ArDX5nk+R8wLU29W8wxioDRbRrQnGWmjqQ//X+hj2
         h3y6qs9OO28VDrqEjCgBWRAa9NMcryOYsRFdQIDgBoDDwhMZMGfTaNTZRfZX+uE0Bkt4
         DxyaToCT6WZor3MlqkQ8wCT7hG1kPUE+8+fcj2m3AHYHH3Skqn9F4opWhwydRLYVV2Lq
         3vPrpPYe5Be2Wc+My24dv48qjw2aIhofZtTD+9a/X4fZLM1MMvJYzOAjk1D719Ir+Dmx
         oPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4I8/e2g26fKgyDbLzwFA1lsSaN1mfB36eS6RU48Kpg=;
        b=CKEFOnVjpJWRrCuURoMXz/BrdGcm4aEIZuL20tt/wrogBYr9zVWfAaio+tv8+OLHHB
         j2TzGBmO2NLn9DislU2O34yJTFcyUKD4vhpn1C9cHN2q9H0fr3LsYNHwyKiX78S4YpG0
         AVk931PfDtGphSDveCef0NEyTrpmm5P3p1IDvc6ooXegCwB+u+rgnoubUAlbGxHFyltI
         R2xDCr3p/Z3yBBw9Ul6VXntR7WwHm4pYVJJEGmbcsOYO6p5lsxd9GjjUZtY+q1udKFTx
         aqEaiCa4ezEbmScgClvwHrATFwujwT5kZKo1AEbad7EmHegNmMQ6AoJ7t0QN2Puesrus
         ykfw==
X-Gm-Message-State: AOAM531alvgvFQJisRHXXqovPXPiuqK2+ae6NmCUSu9nwtNuLe1ooIJY
        tNKt23Ak/6UXrWKgPwdTcuT4REXfT3+QxWZpb/xZ0jC3AaE=
X-Google-Smtp-Source: ABdhPJxeHsuJrk7srEnwkNexYGmats7fGd6uoYkLpJ0tk31TcGO0OQtAV/OvJmDYJhQyphMZ41Bs3Ky38i35sNiYZ5A=
X-Received: by 2002:a5d:6443:: with SMTP id d3mr12469437wrw.39.1613990548962;
 Mon, 22 Feb 2021 02:42:28 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210212202628.GC2692426@xps15> <9ca3b9da-dded-1206-e048-835590b2265e@arm.com>
 <CAJ9a7ViX6UUO66WX7M8hixg7dRdx7XPZNpfr3zwTaT=GBbWJSg@mail.gmail.com>
 <3d886de7-6f97-aa77-be15-635efb9de791@arm.com> <CAJ9a7Vhv=EPWdsGBZAz-OO214Xw84j-KiXzw51OTZPvKqyUorw@mail.gmail.com>
 <bb72c8e1-e16d-e8e1-5aff-2a2ce78e84b1@arm.com>
In-Reply-To: <bb72c8e1-e16d-e8e1-5aff-2a2ce78e84b1@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 22 Feb 2021 10:42:18 +0000
Message-ID: <CAJ9a7Vjxz6_mD3zk13+qjU63zMXFOW8H14qfXw40YpKTFAuHqw@mail.gmail.com>
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Thu, 18 Feb 2021 at 15:14, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 2/18/21 2:30 PM, Mike Leach wrote:
> > HI Suzuki,
> >
> > On Thu, 18 Feb 2021 at 07:50, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> Hi Mike
> >>
> >> On 2/16/21 9:00 AM, Mike Leach wrote:
> >>> Hi Anshuman,
> >>>
> >>> There have been plenty of detailed comments so I will restrict mine to
> >>> a few general issues:-
> >>>
> >>> 1) Currently there appears to be no sysfs support (I cannot see the
> >>> MODE_SYSFS constants running alongside the MODE_PERF ones present in
> >>> the other sink drivers). This is present on all other coresight
> >>> devices, and must be provided for this device. It is useful for
> >>> testing, and there are users out there who will have scripts to use
> >>> it. It is not essential it makes it into this set, but should be a
> >>> follow up set.
> >>
> >> This is mentioned in the cover-letter and as you rightly said
> >> we could add this in a later series.
> >>
> >
> > Yes - I see that it was mentioned at the end as an open question - so
> > I guess this is my answer!
> >
> >>>
> >>> 2) Using FILL mode for TRBE means that the trace will by definition be
> >>> lossy. Fill mode will halt collection without cleanly stopping and
> >>> flushing the source. This will result in the sink missing the last of
> >>> the data from the source as it stops. Even if taking the exception
> >>> moves into a prohibited region there is still the possibility the last
> >>> trace operations will not be seen. Further it is possible that the
> >>
> >> Correct.
> >>
> >>> last few bytes of trace will be an incomplete packet, and indeed the
> >>> start of the next buffer could contain incomplete packets too.
> >>
> >> Yes, this is possible.
> >>
> >>>
> >>> This operation differs from the other sinks which will only halt after
> >>> the sources have stopped and the path has been flushed. This ensures
> >>> that the latest trace is complete. The weakness with the older sinks
> >>> is the lack of interrupt meaning buffers were frequently wrapped so
> >>> that only the latest trace is available.
> >>
> >> This is true, when there was no overflow. i.e, we follow the normal
> >> source-stop-flush, sink-stop.
> >>
> >>>
> >>> By using TRBE WRAP mode, with a watermark as described in the TRBE
> >>> spec, using the interrupts it is possible to approach lossless trace
> >>> in a way that is not possible with earlier ETR/ETB. This is something
> >>
> >> It may be possible to do lossless trace, but not without double buffering
> >> in perf mode. In perf mode, with a single buffer, we have to honor the
> >> boundaries set by the aux_buffer head and tail, otherwise we could be
> >> corrupting the trace being consumed by the userland.
> >>
> >> Please remember that the "water mark" is considered as the END of the
> >> buffer by TRBE (unlike the SoC-600 ETR). So the LIMIT pointer could be
> >> one of :
> >>
> >>     * Tail pointer ( of the handle space, <=  End_of_the_Buffer)
> >>     * Wake up pointer ( when the userspace would like to be woken up ,<= End_of_the_Buffer)
> >>
> >> So, if we use WRAP mode for perf, the TRBE would overwrite the from
> >> the Base, after we hit the LIMIT, where we should have started
> >> writing *after* the LIMIT (when LIMIT < End_of_the_Buffer). Moreover
> >> restarting from the Base is going to be even more trouble some
> >> as it is most likely the data, perf is still collecting.
> >>
> >
> > I agree that the TRBE must write inbetween head and tail / wakeup.
> > Howver, there is no reason that I can see why the trbe_base register
> > has to remain constant @ the start of the vmapped aux buffer.
> > A valid trbe write buffer could be set by:
> > trbe_base >= head (rounded up to page boundary)
> > trbe_limit <= min(tail, wakeup) (rounded down to page boundary)
> > trbe_write is then trbe_base + "watermark" offset. - as suggested in
> > the TRBE spec.
>
> The problem is we are dealing with separate entities. The producer
> and the consumer are separate entities playing with a single,
> infinite running ring buffer. Had this been a double buffering scheme,
> this would work really nice. In fact, I had some plans to do this for
> SoC-600 ETR.
>
> Coming back, with the proposed approach :
>
> head         write (watermark)          end-of-real buffer
>    /          |
>   ^---v-------^----------v---------------|
>      /                    \
> base(aligned)            limit (wakeup/tail)
>
> In this case, assuming single shared buffer, the TRBE would start
> writing from "write" watermark and WRAP at limit, going back to base.
>
> The issues here are :
>    - If there were no overflow, we cant update the AUX handle
>      unless we pad from head to write (which might be significant).
>
>   If there was overflow :
>    - You have wrongly ordered data. i.e, the older trace is at "write"
> and newer trace is at "base". Unless we copy the data written from
> base to the end of "limit", the userspace can't consume it. Or else
> it thinks the data at base is older and this gets the trace decoding
> gone for a toss.
>

Both of these issues are dealt with if we allow for the insertion of
metadata into the buffer as I described below.
The consumer - as the copier to user space - does not care about the
internal structure of the buffer. The consumer cannot touch the area
that the producer is filling until it is given permission by the call
that updates the head pointer.
Thus the problem becomes one for the decoder to sort out. If it knows
the internal format of the buffer - then it can unwrap, and decode the
correct trace.

Either way - without a wrap flow, we cannot match the performance of
intel-pt as our trace will always be truncated on the FILL IRQ.
The intel-pt IRQ will both service the aux buffer, but also stop and
start the trace generation - something that will happen in the WRAP
flow, but cannot happen cleanly in the FILL flow.

So WRAP flow is required - either by double buffering or a scheme that
avoids this.

Regards

Mike


> As you can see, two players dealing with a single buffer doesn't allow
> for the kind of flow possible with WRAP.
>
> On the other hand this works perfectly with double buffering. We could
> copy the data from the "write" to limit, followed by from "base" to the
> current write ptr. This could well be used for sysfs, but since we
> have asynchronous collection, we don't need the interrupt and thus
> fall back to CIRCULAR_BUFFER mode.
>
> >
> > The issue then becomes unravelling the buffer. Given what we know now,
> > and the work on aux buffers, I would suggest that we can easily insert
> > meta data to do this in the front of the buffer, saving any trace
> > overwirtten at the end of the buffer, and setting a new flag in the
> > aux buffer to tell userspace decode to sort it out. Thus the only copy
> > needed is in the region of 8 bytes perhaps.
> >
> > Of course there are potential inefficiencies here in usage of buffer
> > space, and yes we cannot guarantee lossless trace, but FILL mode
> > guarantees lossy trace and a truncated buffer for every time it wraps
> > (by definition, if FILL mode wraps then you cannot be sure that you
> > have all the possible trace so it has to be marked as truncated in the
> > same way we mark wrapped ETR buffers as truncated whenever they are
> > wrapped).
> >
> >>> that has been requested by partners since trace became available in
> >>> linux systems. (There is still a possibility of loss due to filling
> >>> the buffer completely and overflowing the watermark, but that can be
> >>> flagged).
> >>>
> >>> While FILL mode trace is a good start, and suitable for some scenarios
> >>> - WRAP mode needs implementing as well.
> >>
> >> Using WRAP mode makes sense only in the case of double buffering. Even
> >> with that, we are not guaranteed that we wouldn't loose trace data, with
> >> significantly larger buffer than the AUX buffer. So this may not be the
> >> right choice looking at the performance and the software expectations.
> >>
> >> When it comes to sysfs mode, I believe we could use the CIRCULAR_BUFFER
> >> mode, as the collection is asynchronous.
> >
> > Agreed - this makes the most sense here.
> >
> >> I understand WRAP is suitable
> >> for lossless collection, but unfortunately the Linux sof
> >>
> >
> > sentence unexpectedly truncated?!
>
> Sorry, needed some more coffee after the break :-). It should have been :
>
> "... but unfortunately the Linux software semantics (especially perf)
> doesn't make this any better usable than the FILL mode".
>
> Cheers
> Suzuki



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
