Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948FC3E05D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhHDQYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhHDQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:24:49 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EE6C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 09:24:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so2170892oti.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=bPGAJ1O4XY4xsJwp1tio/KzVLh6cCEwMAyfzs69Wdns=;
        b=KOO128q3ZaIvPyPvjxovgNX30WEEa6/W/NpQhKwj13IOSiOJOIsKO/VXr6ItCk5W5O
         fg2gVArGO2n8ipiJ+RhV1fkJZgWm5Df72mRdKsWj9ouiDgQu6iB61BIiK6zbwPydqvTQ
         RkCEQ0DjUHHyamMi8cXB+PUfj1bbuC9YLQpuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=bPGAJ1O4XY4xsJwp1tio/KzVLh6cCEwMAyfzs69Wdns=;
        b=iqCjdzZW8oxsU9c7EsDXPwV1uclfS63dK4j1FALM0a7IljQoIWatWF1Fv7MC2i/2Un
         0NotOgLMalfmqEe1ACIAxFnxJXyYyhrEJ8LbJFt1WU7H9Yyt1JRDEcZzugQ3EZ81vFGw
         nM9FkdUwCspG6Tvm0wi/JkU09uf4AxjBPNDinRh6LuBaDOC32M1b2VC0nT1DfQJFJStj
         +PHd1sA0EPnkqg+iVkIOukDQhdtmRQb+qASP6UeOM8a0E+lhQ2AM6FXUcMU3r3ysMYpR
         qLqHfH+kHHAzLBksAWM1vDl4BHcRa2y8KS9AwH0XD8CC4CnYw9SyG40lbAZP5dGlizfi
         qFig==
X-Gm-Message-State: AOAM531pzXlZnzGJ/pyEJMx0FBjb9gBSd6q61YGqpLcnn4ZQQCz76MZR
        T5C2jfPtkECDgQtNGt+EXTN1PgYlPJIJsBiMdbtWBA==
X-Google-Smtp-Source: ABdhPJwESZ2fueBO9Cwh5ZfEKrgIdlZyanmaz/kvcpyGNnZR1WLw1cWI+G4ecqRzKDmX26tsafgzDe4YPwUFx/Hsyas=
X-Received: by 2002:a05:6830:1490:: with SMTP id s16mr411904otq.233.1628094275464;
 Wed, 04 Aug 2021 09:24:35 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Aug 2021 09:24:34 -0700
MIME-Version: 1.0
In-Reply-To: <ab2a7aadb6ada58246ec972c4938c627@codeaurora.org>
References: <1628007913-29892-1-git-send-email-khsieh@codeaurora.org>
 <CAE-0n51yNrmrqgDrkj2+c2Bx-bYxNs1m2pQBxvVkSpBH2hxzoA@mail.gmail.com> <ab2a7aadb6ada58246ec972c4938c627@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 4 Aug 2021 09:24:34 -0700
Message-ID: <CAE-0n52bpS4mxM+=xxXvxQYSc5p_xyhkPQ07E1ad9uM1ZBKLwA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/msm/dp: update is_connected status base on sink
 count at dp_pm_resume()
To:     khsieh@codeaurora.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robdclark@gmail.com,
        sean@poorly.run, vkoul@kernel.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-08-04 08:48:04)
> On 2021-08-03 12:05, Stephen Boyd wrote:
> > Quoting Kuogee Hsieh (2021-08-03 09:25:13)
> >> @@ -1327,14 +1327,26 @@ static int dp_pm_resume(struct device *dev)
> >>
> >>         dp_catalog_ctrl_hpd_config(dp->catalog);
> >>
> >> -       status = dp_catalog_link_is_connected(dp->catalog);
> >> +       /*
> >> +        * set sink to normal operation mode -- D0
> >> +        * before dpcd read
> >> +        */
> >> +       dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> >> +
> >> +       /* if sink conencted, do dpcd read sink count */
> >
> > s/conencted/connected/
> >
> > This also just says what the code is doing. Why do we only read the
> > sink
> > count if the link is connected? Can we read the sink count even if the
> > link isn't connected and then consider sink count as 0 if trying to
> > read
> > fails?
> >
> yes, we can do that.
> But it will suffer aux time out and retry.
> i think it is better to avoid this overhead by check connection first.
>

Hmm ok. Maybe something is wrong with the aux channel where it doesn't
avoid the timeout if the connection is obviously not established yet.
