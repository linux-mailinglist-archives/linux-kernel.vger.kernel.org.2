Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EE431CA73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBPMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhBPMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:13:25 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:12:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v15so12654332wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tsTvIQT2HRdZdmNSzbDR0FzDHX8P9VZOoQPmJWXrOI=;
        b=qNYezyEzJayl10gqLAG43PrqWHTd1WSC68//XU5J8pngSNSa7ac9TqSAov3/+p7cWF
         94bmocWeg7HEdLp0VRIxYih3gmUZOsMtAEOF0S9V5rQhUXdjS3lA3yLztIVkgNVI9FOl
         6AU9cr9TdFce4KZhyZyfL6sJpoYCCDSI6BAELRWhKIiUABhkWDl8qQNiadfYhbyl/bm3
         JL5d+ZB3LAq0eaHHSWxCooqc4l/cx5kzpv/F3aq145VQBRyxAjSRqkoQ6HiZk2Scz4Nt
         x7skaMHdHvunM7w6BK829t5W8d8Bg6pYiYc4Q2x5QIF/AoPuih5xq2Gx9qUCpW/EHOXz
         2X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tsTvIQT2HRdZdmNSzbDR0FzDHX8P9VZOoQPmJWXrOI=;
        b=sdmjBQ+oes+usBXxxKk2UfifxxvQZE1yVIWF8kpcM+5U/gzpl/p3OLfe27CVp0LfqQ
         LvOOYhobyrrlrWNqanhVH/v4fE4HK7H0yxRTlKEFDk78wRKewt9laDaQPTlRMFZXdDvz
         Li7ETvxtrRMM4n+MghEJ40avFF3dnNW7GZagLyVYTT4CZt+lGW0LkyfkfEYJnpzdq85j
         fIWHFRMTAZ2F5A2/h+yzPEMwUNExf/XLj59wJI7WGKtVYDVVEqKAOyPom1thzm+GvpLf
         rVwQA8JVrY9pqgmn69ZbW9KJoSaahbPj7higgWWXVsOsl3LxJQmg0dP8cXYI/WZx4Dx6
         aeTA==
X-Gm-Message-State: AOAM530uUHyJhA50V+2/27VGtqjeY0KSTkmmbchHZtbPQi8LTcbylt44
        qDcNmGX8UijoKT+JYgRWlxEE6H2AFG/Os2gI+IFuWXvUWwQ4wg==
X-Google-Smtp-Source: ABdhPJwwW44neKwsoD97iVe7HBmh7M03FPX4vFgMoogx892QDoevHe9LgDLbnQrqzrJ9ueNxb3hOhGAcJJTNwtDu/s0=
X-Received: by 2002:adf:e884:: with SMTP id d4mr22760951wrm.275.1613477563677;
 Tue, 16 Feb 2021 04:12:43 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-12-git-send-email-anshuman.khandual@arm.com>
 <20210212202628.GC2692426@xps15> <9ca3b9da-dded-1206-e048-835590b2265e@arm.com>
 <CAJ9a7ViX6UUO66WX7M8hixg7dRdx7XPZNpfr3zwTaT=GBbWJSg@mail.gmail.com> <7b20f8b3-4efa-530f-b058-1aae13e4e43e@arm.com>
In-Reply-To: <7b20f8b3-4efa-530f-b058-1aae13e4e43e@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 16 Feb 2021 12:12:32 +0000
Message-ID: <CAJ9a7VjBs_xNzPX3sbVZ2-2QUProqfKmFn9rPLavkq+B=EtHQA@mail.gmail.com>
Subject: Re: [PATCH V3 11/14] coresight: sink: Add TRBE driver
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Tue, 16 Feb 2021 at 09:44, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> Hello Mike,
>
> On 2/16/21 2:30 PM, Mike Leach wrote:
> > Hi Anshuman,
> >
> > There have been plenty of detailed comments so I will restrict mine to
> > a few general issues:-
> >
> > 1) Currently there appears to be no sysfs support (I cannot see the
> > MODE_SYSFS constants running alongside the MODE_PERF ones present in
> > the other sink drivers). This is present on all other coresight
> > devices, and must be provided for this device. It is useful for
> > testing, and there are users out there who will have scripts to use
> > it. It is not essential it makes it into this set, but should be a
> > follow up set.
>
> Sure, will try and add it in a follow up series.
>
> >
> > 2) Using FILL mode for TRBE means that the trace will by definition be
> > lossy. Fill mode will halt collection without cleanly stopping and
> > flushing the source. This will result in the sink missing the last of
> > the data from the source as it stops. Even if taking the exception
> > moves into a prohibited region there is still the possibility the last
> > trace operations will not be seen. Further it is possible that the
> > last few bytes of trace will be an incomplete packet, and indeed the
> > start of the next buffer could contain incomplete packets too.
>
> Just wondering why TRBE and ETE would not sync with each other in order
> for the ETE to possibly resend all the lost trace data, when the TRBE
> runs out of buffer and wrappers around ?

The ETE and TRBE are separate devices - there is no feedback between
them. The ETE can also send to external sinks.
Given the rate of trace generation, buffering enough trace in the ETE
to resend is not realistic, and would be very complicated in terms of
hardware.

Therefore the solution is to stop the source (disable ETE or prohibit
using TFR), flush (TSB CSYNC), then stop collection. A TSB CSYNC
without stopping the ETE, or after TRBE has stopped collection will
have no effect in terms of getting cleanly stopped trace into the
buffer.

> Is this ETE/TRBE behavior same
> for all implementations in the FILL mode ? Just wondering.
>

Yes - there is nothing in either spec that would suggest otherwise.

> >
> > This operation differs from the other sinks which will only halt after
> > the sources have stopped and the path has been flushed. This ensures
> > that the latest trace is complete. The weakness with the older sinks
> > is the lack of interrupt meaning buffers were frequently wrapped so
> > that only the latest trace is available.
>
> Right.
>
> >
> > By using TRBE WRAP mode, with a watermark as described in the TRBE
> > spec, using the interrupts it is possible to approach lossless trace
> > in a way that is not possible with earlier ETR/ETB. This is somethin
> Using TRBTRG_EL1 as the above mentioned watermark ?
>

Using TRBTRG_EL1 precludes using the ETE Event triggers for activating
and marking trace. It is preferable to use the write pointer offset
from the initial base to allow a portion of the buffer to be filled
after wrap. This a little more complex but more flexible in terms of
ETE usage.

> > that has been requested by partners since trace became available in
> > linux systems. (There is still a possibility of loss due to filling
> > the buffer completely and overflowing the watermark, but that can be
> > flagged).
> >
> > While FILL mode trace is a good start, and suitable for some scenarios
> > - WRAP mode needs implementing as well.
>
> I would like to understand this mechanism more. Besides how the perf
> interface suppose to choose between FILL and WRAP mode ? via a new
> event attribute ?
>

That is an open question. Event option is one possibility, configfs or
compile time options are others.
Probably have to look at the performance of wrap mode and decide if it
could be used all the time or if FILL still has value.

We are in the early days of ETE / TRBE development here. I do not
think there is anything wrong with using FILL as a first step. as long
as the limitations are well understood.

Regards

Mike

> >
> > 3) Padding: To be clear, it is not safe for the decoder to run off the
> > end of one buffer, into the padding area and continue decoding, or
> > continue through the padding into the next buffer. However I believe
> > the buffer start / stop points are demarked by the aux_output_start /
> > aux_output_end calls?
>
> Yes.
>
> >
> > With upcoming perf decode updates this should enable the decoder to
> > correctly be started and stopped on the buffer boundaries. The padding
> > is there primarily to ensure that the decoder does not synchronize
> > with the data stream until a genuine sync point is found.
>
> Right.
>
> >
> > 4) TRBE needs to be a loadable module like the rest of coresight.
>
> Even though the driver has all the module constructs, the Kconfig was
> missing a tristate value, which is being fixed for the next version.
>
> - Anshuman



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
