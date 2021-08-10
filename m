Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EBE3E4BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhHISA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbhHISAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:00:46 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01695C0619E3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 10:58:36 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t128so24759380oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 10:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4djiLnstO6wNm5dbfz6GkwUhLMxD4qnGqmOobmKJsZI=;
        b=N0Or96M7aOJWZYUH7SjZ+jABZ8KfI3HYyYZ8WV2SQjolwax13kczXpC88nlv5hSMxj
         gNCVS8m2JuKwd7BNPkv2h+Qto+O+e9MXJjQ+T6+A4D3In7YFA0zho8eEqa945fib9PNd
         DseInCVPLXOvKb6uWLXrGipkaVWjw2nWCuJ/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4djiLnstO6wNm5dbfz6GkwUhLMxD4qnGqmOobmKJsZI=;
        b=je8pfKxVNZANXMquMyLQw6tDWFnVx0jW9F+ZOV4h2VnAtsjQ26gUk1cLEynsMs2sxi
         CbYcLG2b15pwEj8M1MZnY875CgVKxaky73hXMdyIiLypDRrC7kYP/RP1A2yHtiqhIBub
         X0+pCuyA0ewmw2Gl9/o1A4in2lC+LyTFCg9+RCb6uR5n9FnEFYHpoKu9pd3OeL2llQG2
         9h8tl/tdsGz8YApyx6kXnX0G0uOEGOkeS82L6aE/wPC8LZg0sRX7fXKW4I3gYY9Huexx
         lp3JmmE0oHbNg3/FyHhwKswd1cCMEZEdXeE4bNJuvVNhK31boqPAr5ieUCKXWElDSBYG
         RMQg==
X-Gm-Message-State: AOAM533W2o4/q1jt5UWH+nshZPOxK7yA2lFIvtk8+q2YY1QoK1NuagtV
        AaVZN8RWy7KW/ITmTaQ9I4M5D1xqlCI3qWSIpW/mgw==
X-Google-Smtp-Source: ABdhPJxqoY3xYfEbdhBxxGGW7jgDxDDtkRxO1ZmZ7Cw1eBlkW2LNeRhEp0vUHIT6TuAWSHIn/gAh9ovhPr0Ka+R+htA=
X-Received: by 2002:a05:6808:984:: with SMTP id a4mr302594oic.166.1628531915413;
 Mon, 09 Aug 2021 10:58:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Aug 2021 10:58:34 -0700
MIME-Version: 1.0
In-Reply-To: <bf2b00c5-0826-00d2-ca95-b4ae6a030211@codeaurora.org>
References: <1628180254-758-1-git-send-email-deesin@codeaurora.org>
 <CAE-0n5203g4CkF5WP1fQYU57fntXbdyVBsMsTKU_xPkgvbt+7Q@mail.gmail.com> <bf2b00c5-0826-00d2-ca95-b4ae6a030211@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 9 Aug 2021 10:58:34 -0700
Message-ID: <CAE-0n53ojhs+RMpsYtVjsrYbb_PRdkJOvxFhiTtJPMUDuoP_eA@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] soc: qcom: smp2p: Add wakeup capability to SMP2P IRQ
To:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, clew@codeaurora.org,
        sibis@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Deepak Kumar Singh (2021-08-09 04:05:08)
>
> On 8/6/2021 1:10 AM, Stephen Boyd wrote:
> > Quoting Deepak Kumar Singh (2021-08-05 09:17:33)
> >> Some use cases require SMP2P interrupts to wake up the host
> >> from suspend.
> > Please elaborate on this point so we understand what sort of scenarios
> > want to wakeup from suspend.
>
> Once such scenario is where WiFi/modem crashes and notifies crash to
> local host through smp2p
>
> if local host is in suspend it should wake up to handle the crash and
> reboot the WiFi/modem.

Does anything go wrong if the firmware crashes during suspend and the
local host doesn't handle it until it wakes for some other reason? I'd
like to understand if the crash handling can be delayed/combined with
another wakeup.

>
> >> Mark smp2p interrupt as wakeup capable to abort
> >> the suspend.
> >>
> >> Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> >> ---
> >>   drivers/soc/qcom/smp2p.c | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> >> index 2df4883..f8659b0 100644
> >> --- a/drivers/soc/qcom/smp2p.c
> >> +++ b/drivers/soc/qcom/smp2p.c
> >> @@ -18,6 +18,7 @@
> >>   #include <linux/soc/qcom/smem.h>
> >>   #include <linux/soc/qcom/smem_state.h>
> >>   #include <linux/spinlock.h>
> >> +#include <linux/pm_wakeirq.h>
> >>
> >>   /*
> >>    * The Shared Memory Point to Point (SMP2P) protocol facilitates communication
> >> @@ -538,9 +539,19 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
> >>                  goto unwind_interfaces;
> >>          }
> >>
> >> +       ret = device_init_wakeup(&pdev->dev, true);
> > Is smp2p supposed to wake up the device by default? If not, then this
> > should be device_set_wakeup_capable() instead so that userspace can
> > decide if it wants to get the wakeup.
> yes, we want smp2p to be wake up capable by default.

Why?
