Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EABE3CAC30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbhGOTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbhGOTJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:09:27 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA401C08EAC2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:59:04 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so7295808oti.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=uARztaoGqxtCxUXEaCvWao2wggByc75Y4p//QGKTuik=;
        b=LqDvHuMNbdE0uDYqjIOxiAwbKh9hOZDODAww90m7DQpUrwC70XXUuSiu6YEaCAdaNQ
         ghSilahZ7d4up2ZoTWDFxx/t7+u5Tg3UodsaG+ERm94RSO2gVHm6/+cQHjynp6nShTG1
         mLnXZ2KFhfrXejXJU/K+whj+HikZ8JbISEJ5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=uARztaoGqxtCxUXEaCvWao2wggByc75Y4p//QGKTuik=;
        b=mtp8JkGpbELX42kBegi83G13SKTWgLjhTYlxKCH3RN6eOrfKzc1E1l6Jsydn9kE+kA
         mkXIeGBge7uNQm0zwfwF4/rOCX+qO9KJKPp7K8a7rR/RezXxZmSg1aAMr6TLd3cDsTIR
         8fgxPsiYNKHzlxDDewc76GXf3BFuVqeqesavvzMOGdBlbadYebXaxalDqxrY69AJuVY3
         /pzL1TglBtvT7zqJhJ/2xvw67UhDSmzZqOCZSVANaQxTR7DiZCCYJ64lhwChGKwiRmIU
         /EgnuTjn28wX+Q5jtl536bkPK+Ul3R6r+BYbiOs39QllWFjx8Kif4mOxf/4keHUqLw5u
         BwlA==
X-Gm-Message-State: AOAM532FN0IR6ZzbotjNf6uMLJARuZ5ivQiI0bFBL7XYF3p3OoHVTb9u
        +hi2B7tRn1n/23MYK14OxuZLOVT21u/ra9lD8ggFpg==
X-Google-Smtp-Source: ABdhPJz2Jj/5ttUOdkAzHnEsQQtTBLdlipJ0FFoTKaILvuwmNCpcrDU/Ba0wfcqwVexPBLr2ZVKReu7ek9znD8Q5/l0=
X-Received: by 2002:a9d:8c7:: with SMTP id 65mr4993040otf.25.1626375544249;
 Thu, 15 Jul 2021 11:59:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Jul 2021 20:59:03 +0200
MIME-Version: 1.0
In-Reply-To: <ef24f67a334698610b7b8e607a727b5d@codeaurora.org>
References: <1625592020-22658-1-git-send-email-khsieh@codeaurora.org>
 <1625592020-22658-3-git-send-email-khsieh@codeaurora.org> <CAE-0n52WyMKdQ96ji=5YLBxpndgB_CLsxscXaFexMPdLducrkQ@mail.gmail.com>
 <ef24f67a334698610b7b8e607a727b5d@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 15 Jul 2021 20:59:03 +0200
Message-ID: <CAE-0n53M1XWa1Ng-+bBLQyKLRzabbTOofOMqknQbF+PWuE6=hw@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/msm/dp: reduce link rate if failed at link
 training 1
To:     khsieh@codeaurora.org
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, abhinavk@codeaurora.org, aravindh@codeaurora.org,
        airlied@linux.ie, daniel@ffwll.ch, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-07-09 10:46:41)
> On 2021-07-08 00:33, Stephen Boyd wrote:
> >> +
> >> +static bool dp_ctrl_any_lane_cr_lose(struct dp_ctrl_private *ctrl,
> >> +                                       u8 *cr_status)
> >> +{
> >> +       int i;
> >> +       u8 status;
> >> +       int lane = ctrl->link->link_params.num_lanes;
> >> +
> >> +       for (i = 0; i < lane; i++) {
> >> +               status = cr_status[i / 2];
> >> +               status >>= ((i % 2) * 4);
> >> +               if (!(status & DP_LANE_CR_DONE))
> >> +                       return true;
> >> +       }
> >> +
> >> +       return false;
> >> +}
> >
> > Why not use !drm_dp_clock_recovery_ok() for dp_ctrl_any_lane_cr_lose()?
> ok,
>
> > And then move dp_ctrl_any_lane_cr_done() next to
> > drm_dp_clock_recovery_ok() and call it drm_dp_clock_recovery_any_ok()?
> no understand how it work, can you elaborate it more?

I'm suggesting to make a new function called
drm_dp_clock_recovery_any_ok(), written next to
drm_dp_clock_recovery_ok(). Then call it from here instead of implement
it locally in the qcom DP driver.
