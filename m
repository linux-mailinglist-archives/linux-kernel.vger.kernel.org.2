Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73FF34E297
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhC3Hx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhC3Hxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:53:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AA4C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:53:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w11so5735418ply.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sSZY0eJ77vdtYQefXb2yo/92zDLVSNWjzbsQ6OFfRDY=;
        b=EVbwTv02+x9ZZzeuFpVvG1763ys6pi18GwTHaYzg7QhVSefOeHqlRabQ19roKqUvnc
         61Ttv9P79rA9wnYQlp+7NssWHpG3zGqm3bb2u0wyzAbIZ/B4QoMMesxBuxvA/U0r1F87
         KiT0NDeS9VkKWPopX175eLTj8oCEx0uYTU6UK8kX/O1FYbY5MguxiB3orbx0Za8hTVvM
         1PyB+l+9zJ6IiD0+Q3XyDY7o8m7AYmTlc0m/y7Myjt9CL06a3/DisR48cNlT7B+j8Ukh
         zap77UZ2CP9YEXnuxgn+FAKzZamGmnYzzHVzeFvWFJxr7RoNZAShd+75W2pMOL5VuQMd
         T5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sSZY0eJ77vdtYQefXb2yo/92zDLVSNWjzbsQ6OFfRDY=;
        b=em/PLEZ6p2K7abQu4BAEs6SPqF0wsO7Us0TSx1kcnXAl6NzQ+m8OyW1PyD2q86gL05
         R/UOeBVwo5u0GWQVkDSLwdp1d4zhtczdAvIGmR7LYIwNj738RgYpHRnDQSc0s56DpHa0
         LSM51P7mqFU1byo9bqcHZUraNFD978GM1LJ1hLnD9O6sVfNYiAB15nj1Une5575BPCtB
         Sv/kgBU6U9ZgFsamT4+qwvQpXE5CpkHgiYt5us51EUVJLnS8SdIumNBO3SAvys7MfAd8
         FjPjrs7ozxuy1wI9YtaDEEM7hJwDfgRGUNysYd6XRGk59pfll7AAordRoHQenUta7fYg
         al+g==
X-Gm-Message-State: AOAM533J5bV9XEZiguKWjd6E1Rdr+an57svJI4DiIeS7lAMgoCbcKo9H
        6t9DpAHERDJwN+B++e+C0r3/RCOGdgXIxGCD+OSf+A==
X-Google-Smtp-Source: ABdhPJzrbhDosdqkF9Wl5ayuaorrj13GIgInJxIUci8Wxhc58N/za6y1BfQDth8/QPB2EY/A+2Eiyf+Cww2UkNfo/g0=
X-Received: by 2002:a17:90b:4008:: with SMTP id ie8mr3140931pjb.231.1617090824200;
 Tue, 30 Mar 2021 00:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <1617067704-28850-1-git-send-email-bbhatt@codeaurora.org> <1617067704-28850-4-git-send-email-bbhatt@codeaurora.org>
In-Reply-To: <1617067704-28850-4-git-send-email-bbhatt@codeaurora.org>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Tue, 30 Mar 2021 10:01:53 +0200
Message-ID: <CAMZdPi_wwBt99yGDw9AkeF0AB11_MyTr3o__srqj7QnpHzTX3w@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] bus: mhi: core: Handle EDL mode entry appropriately
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hemant Kumar <hemantk@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2FybCBZaW4o5q635byg5oiQKQ==?= <carl.yin@quectel.com>,
        Naveen Kumar <naveen.kumar@quectel.com>,
        abickett@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 03:28, Bhaumik Bhatt <bbhatt@codeaurora.org> wrote:
>
> Device entering EDL or Emergency Download Mode will be in a
> SYS_ERROR MHI state. This requires MHI host to proceed with the
> EDL image download over BHI before device can enter an MHI READY
> state and proceed with further bootup. Allow this to be handled
> by relying on the execution environment check after SYS_ERROR
> processing to determine whether to wait for an MHI READY or
> download the EDL image over BHI after moving MHI PM state to
> Power on Reset internally. This way handling is contained well
> within the MHI core driver and helps pave the way for Flash
> Programmer execution environment functionality.
>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
