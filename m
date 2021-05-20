Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A95238B8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhETVaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhETVaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:30:20 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA23C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:28:58 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so16146991oth.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=FFBVHwnW1tZiywR0xsIn3hudAVRO7jEM83ktdfD3dwM=;
        b=LVzJNs3LTIl9Ghv2MXwEzztGaNDMTV+9v+a/00sblUxMskQogecq2upWszMoWprccD
         zcv4TPuPrjJ6TMlEGSYQ3EBGR3e5gLVcFR4rBzdiq75bIq4uUYoG4yDXhKjP8zYHhbCk
         RQMnBfBY40mN9kR9Ai9LjjlAsNUrWqawmsVC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=FFBVHwnW1tZiywR0xsIn3hudAVRO7jEM83ktdfD3dwM=;
        b=hzs312Hn1pd7sPCmMFTqHq6hdhjQ6gRf4TS9yom/Yaj5ioSG5q04pjV60aSIx9CA/O
         KFd/kAPee2n/M7KZVf4yLJcpXs/8U8ifvmlxoH/woFrKbOINlC2HvWvma/iVqwjSR/r3
         KvQJ6IEv/okRVM9IrRBjVaOMxIs++JvhJzmVIv1DpK3NIlVu0x8ArfVXKpjvOprRRJWM
         pOiJSCHVrcprpt2wRXXDzogpJvstxKVoJI+P9fblsVkL+cxnXwE0g33j78ht4rM+9Dv/
         Hk7X/phWoNa2dOL/1KrfFAUSwKtfUzZHoseWKsKrl054tZhslRWBMx4uV5yL1N3cnHM+
         968g==
X-Gm-Message-State: AOAM532xkw+i9ffUQ5DXrWJOzojiyzqOLGIMRaoLvNv957gOwogvh111
        csaxaFi3qkdApbd4erYeiKwNo8e4gwgrXCEG0KfhOg==
X-Google-Smtp-Source: ABdhPJyTQt86b45EKB6A4VpCoVhWUHFd2TFTCQ91yUrLfMNzlXKfX3+CMI93A+f4h+RKq8bIgZqGMBQ0a6xM0NvFmHs=
X-Received: by 2002:a05:6830:4a1:: with SMTP id l1mr5491643otd.25.1621546137535;
 Thu, 20 May 2021 14:28:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 May 2021 14:28:57 -0700
MIME-Version: 1.0
In-Reply-To: <f476d82d0798e0d7eb9e12949aa2c8f1@codeaurora.org>
References: <1621013713-6860-1-git-send-email-khsieh@codeaurora.org>
 <CAE-0n53VUr=f=PKnO5HhXZ3BAG_mNBwmQrfQPxHvxLZPDReA+g@mail.gmail.com>
 <c1a3ced9ac4682bae310712a11576322@codeaurora.org> <CAE-0n50yRCA00ck_FtXwzKw_R8UcocMzTh8V7NOe4ob__3G3bg@mail.gmail.com>
 <e071434531947e5c4275a1a14b77b2c3@codeaurora.org> <CAE-0n52rBrjy-=dpqK+dae2GNk1rAaQnKqCjzdqiAoS13gHpSQ@mail.gmail.com>
 <f476d82d0798e0d7eb9e12949aa2c8f1@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 20 May 2021 14:28:57 -0700
Message-ID: <CAE-0n51+mbCAqWWTOMDA4Rx_=96V4tK8g+UWVZ-nnp50dFzRPA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/msm/dp: handle irq_hpd with sink_count = 0 correctly
To:     khsieh@codeaurora.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-05-20 13:05:48)
> On 2021-05-20 12:28, Stephen Boyd wrote:
> >> Put dongle to D3 state so that it will not issue the unnecessary
> >> second
> >> irq_hpd with sink_count = 0. this will prevent the annoy but unharmful
> >> DP_LINK_STATUS_UPDATED warning message.
> >> Again, we can not disable hpd interrupt since dongle still attached
> >> and
> >> hdmi cable can be plugged in at any instant.
> >>
> >
> > Right I'm not suggesting to disable hpd interrupt, just the hpd_irq
> > interrupt once an unplug irq comes in, and do that in hardirq context.
> > Also, I'm suggesting that we consider unplug as a higher priority if
> > the
> > hard irq handler is delayed for some reason and both an unplug irq and
> > an hpd irq are pending in the hardware when the hard irq handler is
> > running. Putting the dongle into D3 state won't fix these problems.
>
>
>
> The unplug interrupt is not happen in this case since dongle still
> attached.
> The unplug interrupt only happen when dongle unplugged.

Agreed.

>
> I think you mistakenly think DP_LINK_STATUS_UPDATED is caused by unplug
> interrupt.

Ok, got it.

> DP_LINK_STATUS_UPDATED happen is due to dongle issue two consecutive
> irq_hpd with sink_count = 0 when hdmi cable unplugged from dongle.
> The first irq_hpd with sink_count = 0 is handled as expected to turn off
> display.
> After that the second irq_hpd with sink_count = 0 is handled.
> Since display had turned off, then there is nothing to do but spill
> DP_LINK_STATUS_UPDATED warning message.
> There is no unplug (hpd become low) happen in this case since dongle
> still attached.

Agreed.

>
> All interrupt (plug/irq_hpd and unplug) are required to be handled in
> the order of happening.
> We can not ignore any one.
> For example, you plug/unplug two different resolution monitor
> alternative to/from dongle and unplug dongle once for while.
>
> I think the race condition you describe here all had been taken care
> with
> 1) convert irq into event and store at event q in order.
> 2) irq handled base on transaction. Next irq can be handled when
> previous irq transaction is done.
>

I'm mostly trying to point out that the irq handling and masking needs
to be done in the hard irq context and not in the kthread. It may or may
not be related to this message that's printed.

What happens if the hardirq is blocked by some other irq that takes a
long time to process? Imagine this scenario:

CPU0                                CPU1
----                                ----
 really_long_other_hardirq() {
                                    hpd_irq
				    hpd_irq
				    hpd low
 }

 dp_display_irq_handler() {
   status = DP_DP_IRQ_HPD_INT_MASK | DP_DP_HPD_UNPLUG_INT_MASK
   <fork things to kthread>
 }

Shouldn't we ignore any hpd_irq events in this scenario? And shouldn't
we be disabling the hpd_irq by masking it with DP_DP_IRQ_HPD_INT_MASK
when hpd goes low (i.e. DP_DP_HPD_UNPLUG_INT_MASK)?
