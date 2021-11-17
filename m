Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A804B454274
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 09:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhKQIQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 03:16:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhKQIQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:16:25 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E85C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:13:26 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id u60so5003512ybi.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 00:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXc/W3fsZ8dOeyiOcSijJMj5DXfvkIMk6aAx/SaKEf8=;
        b=yOTlDHdzi/R7Twc9Aoou1k/udGwAK6nbx5/uaL1lptm1SrBDRiA+whmOdxbWNnGXnj
         qigxlWEC2e+SCtY0bZg6+bt10AbciDhc/cYMkCu5njQ3bYcVvUVAbpv5Dfoo3BMmJVuo
         NMyzHJq/UqHlhptNsfyVmckmbtXF+diw/gjvThx7qvvBbMNLgVHDFhB4GCj6V4hVOePJ
         hsd6W+QZw9bZIm1YmYhRL093OjuDukgJiJfGYn0z6Tl5U7r5PiXIJK2cBTAV7239VwZW
         TBKs9n9A8EuFryLOyxAGeL0WZ7MHkD3ZCsAKMvztoZYRjuHBvH5KLDWlyS3hwxtB+kDS
         7RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXc/W3fsZ8dOeyiOcSijJMj5DXfvkIMk6aAx/SaKEf8=;
        b=RmICbpUvkONnUqVM68UscvYlr2pSP81ICrUA6v4BtpTavyhwE/nHh00avIdCAfNDKt
         ejjv+QnpEZK0oNYIvqVHy7nNBuhWJGsn4KNiL1VOeuq4CT0D1uI9c+x84WTfTKcAPgAU
         LujwEtgS1a+F4WXS14r65qaQJnl6SJqhDs40FuGuR+8o32ksp1i5/k6zxgRC4pbIgs1j
         ADXydmSZi0+YKSDq8N25Mvb2ssHlK2JmHUny8/aCz6OeRonchLjpUXS8u7rPOpPWITG6
         RtuXpaaYk8/lkEe3HcLVjBs+5gjD6fLhdDLDFYupY127hrURYqBvaYe/oiajVGSkjkjw
         6Rdg==
X-Gm-Message-State: AOAM532WyzYkTJkDjE1VUE4YDfMVTsiwPx4QsZYfAveGUk9/IbNhsd2A
        2T+ME18may4ntBZ+1Q+7BaycfGQoNv27MF9oqL2j3w==
X-Google-Smtp-Source: ABdhPJwLuHOoPpM54LR2hV1w3OpkkYoyTkMr4ZMw49rWPaQWnoP3DEuhMQs3kgoLn+ezTlNTYVK6hCttkqQAoo2Bd7c=
X-Received: by 2002:a25:a427:: with SMTP id f36mr14948360ybi.245.1637136805947;
 Wed, 17 Nov 2021 00:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20211116173255.19936-1-vincent.guittot@linaro.org> <20211116182758.GB56473@e120937-lin>
In-Reply-To: <20211116182758.GB56473@e120937-lin>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 17 Nov 2021 09:13:14 +0100
Message-ID: <CAKfTPtDND0CfOisFpR7MtB4mi1JKh=Oz-NWV9DqXNLbZE2t3+w@mail.gmail.com>
Subject: Re: [PATCH] arm/scmi: fix base agent discover response
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     sudeep.holla@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

On Tue, 16 Nov 2021 at 19:28, Cristian Marussi <cristian.marussi@arm.com> wrote:
>
> On Tue, Nov 16, 2021 at 06:32:55PM +0100, Vincent Guittot wrote:
> > According to scmi specification, the response of the discover agent request
> > is made of:
> > - int32 status
> > - uint32 agent_id
> > - uint8 name[16]
> >
> > but the current implementation doesn't take into account the agent_id field
> > and only allocates a rx buffer of SCMI_MAX_STR_SIZE length
> >
>
> Hi Vincent,
>
> > Allocate the correct length for rx buffer and copy the name from the
> > correct offset in the response.
> >
> > While no error were returned until v5.15, v5.16-rc1 fails with virtio_scmi
> > transport channel:
> >
> > [    1.093253] arm-scmi firmware:scmi0: SCMI Notifications - Core Enabled.
> > [    1.114776] arm-scmi firmware:scmi0: SCMI Protocol v2.0 'Linaro:PMWG' Firmware version 0x2090000
> > [    1.117544] scmi-virtio virtio0: tx:used len 28 is larger than in buflen 24
> >
>
> Good catch...I was (still) not testing BASE_DISCOVER_AGENT in my virtio setup
> given it's optional....
>
> Once implemented the command I could reproduce and test you fix.
>
> [    1.239629] arm-scmi firmware:scmi: SCMI Notifications - Core Enabled.
> [    1.266401] arm-scmi firmware:scmi: SCMI Protocol v2.0 'EMU-SCMI-VM:userland' Firmware version 0xdeadbeef
> [    1.280360] arm-scmi firmware:scmi: Found 3 protocol(s) 3 agent(s)
> [    1.286304] arm-scmi firmware:scmi: Agent 0: AGENT_00
> [    1.294115] arm-scmi firmware:scmi: Agent 1: AGENT_01
> [    1.301062] arm-scmi firmware:scmi: Agent 2: AGENT_02
>
> LGTM.
>
> Maybe it's worth also a Fixes...

I was not sure which commit to go back.

>
> The earlier where this was introduced seems:
>
> Fixes: b6f20ff8bd94 ("firmware: arm_scmi: add common infrastructure and support for base protocol")

I'm going to put this one to make sure that all LTS will get a fix

>
> and then it was carried on (:D) after heavily refactoring in:
>
> Fixes: 8d3581c2526f ("firmware: arm_scmi: Port base protocol to new interface")
>
> FWIW,
>
> Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks

>
> Thanks,
> Cristian
>
