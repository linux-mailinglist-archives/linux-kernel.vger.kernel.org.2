Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F167B44B0C3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239441AbhKIP5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 10:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239138AbhKIP5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 10:57:41 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56354C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 07:54:55 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id p11-20020a9d4e0b000000b0055a5741bff7so31501797otf.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J2BWM/D/O6dLf23Hfa6szmHiiJ90bLdtonD436duf4I=;
        b=hN0bkCPsYjCvyrMBxO8w0D/LZKDOtSz4D3sHyGPLmR/ZYJiZl7ha52gLpkQ0JyukrM
         BASRd/6Ltmxz6DdnF7G3XNnjVrgk3PNRSS+nuIyox37nUvcUZLoygVc1ZsMc+WIfCy6l
         JfYpyOcGbZK9RuN0LFVjOzCN0XigMGn7SMcoWD6h6dpC7jzPNVXhdu3M0nYYc51mMCLc
         WZZrL4LB1c8M91rnRXQuESBqyE1z++Tl2Ehafk5xRxZcEYcgyGlVjTFa+cqTDhomO6nn
         xM7Ix55GJxGBU83J6LUC7+yCULR7GxvoLB2GLvoeJwIFGo71mvKOxRL5CQut4UrvcG7V
         GTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J2BWM/D/O6dLf23Hfa6szmHiiJ90bLdtonD436duf4I=;
        b=tW9/XPExu2SbCo8ADnjpHXTRxW52o7/+gslSgliGAssanLz1XmcrsNv7LDODIWeSea
         oTUli1eMN0dQfTsJVBV8yHNhUxF1LscZp1ds3TuRGA1zgdpDTAJ0H46JyTXK5Ctgt8Ek
         4e/J2tfSHTAv3naW3Z48sUf2HaAQCQlzkOoa12h4tq5FkuoBz+Xw4g4u5QrjVZ7SLxDV
         rmfAcbcQ23CaN1ItMkS201W1RTrqxrUK9eGlWTqKXR84+xeW3To6LMPNHrGeNA+lfkWy
         KzoW3fHoSihjIgsp7jzj3mCcxlF+qTYiQXB1wBcdtuSi20rk06sEmHwnOXW9c2lOl2Vf
         T0tA==
X-Gm-Message-State: AOAM532IMKqjkiQ2/AuqMaNFDgL80aYuAONTHaSLWUuE4zSYgNSjhxKy
        cFSCqzl4iAgNjPX1pfsKDrUAEA==
X-Google-Smtp-Source: ABdhPJxeVMLFGR7Ycu8kluImtDwDwYEH4/r962d+izO3xg79wwialyaWogujdi/sD546fMa7jn4Dww==
X-Received: by 2002:a9d:352:: with SMTP id 76mr6551987otv.79.1636473294656;
        Tue, 09 Nov 2021 07:54:54 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i16sm3019032oig.15.2021.11.09.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:54:53 -0800 (PST)
Date:   Tue, 9 Nov 2021 07:56:27 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Shawn Guo <shawn.guo@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] clk: qcom: smd-rpm: Report enable state to framework
Message-ID: <YYqaK/Evzuup0ocs@ripper>
References: <20211109022558.14529-1-shawn.guo@linaro.org>
 <YYpMzau3CWRQYlkJ@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYpMzau3CWRQYlkJ@gerhold.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09 Nov 02:26 PST 2021, Stephan Gerhold wrote:

> Hi Shawn,
> 
> On Tue, Nov 09, 2021 at 10:25:55AM +0800, Shawn Guo wrote:
> > Currently the enable state of smd-rpm clocks are not properly reported
> > back to framework due to missing .is_enabled and .is_prepared hooks.
> > This causes a couple of issues.
> > 
> > - All those unused clocks are not voted for off, because framework has
> >   no knowledge that they are unused.  It becomes a problem for vlow
> >   power mode support, as we do not have every single RPM clock claimed
> >   and voted for off by client devices, and rely on clock framework to
> >   disable those unused RPM clocks.
> > 
> 
> I posted a similar patch a bit more than a year ago [1]. Back then one
> of the concerns was that we might disable critical clocks just because
> they have no driver using it actively. For example, not all of the
> platforms using clk-smd-rpm already have an interconnect driver.
> Disabling the interconnect related clocks will almost certainly make the
> device lock up completely. (I tried it back then, it definitely does...)
> 
> I proposed adding CLK_IGNORE_UNUSED for the interconnect related clocks
> back then [2] which would allow disabling most of the clocks at least.
> Stephen Boyd had an alternative proposal to instead move the
> interconnect related clocks completely out of clk-smd-rpm [3].
> But I'm still unsure how this would work in a backwards compatible way. [4]
> 

With the introduction of QoS the interconnect drivers need to be mmio
devices, and plural, while in order to talk to the RPM we need something
on the rpmsg bus.

So I don't think Stephen's proposal will work, unless we like in the
RPMh case comes up with an equivalent of the bcm-voter (which just moved
the clocks from one clock driver to a "clock" driver).


On the other hand, if clocks and the clk-smd-rpm driver in particular
moves to sync_state then this wouldn't be a problem...

Regards,
Bjorn

> Since your patches are more or less identical I'm afraid the same
> concerns still need to be solved somehow. :)
> 
> Thanks,
> Stephan
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20200817140908.185976-1-stephan@gerhold.net/
> [2]: https://lore.kernel.org/linux-arm-msm/20200818080738.GA46574@gerhold.net/
> [3]: https://lore.kernel.org/linux-arm-msm/159796605593.334488.8355244657387381953@swboyd.mtv.corp.google.com/
> [4]: https://lore.kernel.org/linux-arm-msm/20200821064857.GA905@gerhold.net/
