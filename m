Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D444402EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJ2TMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ2TMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:12:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E07C061766
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:10:17 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 71-20020a9d034d000000b00553e24ce2b8so10246848otv.7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6E8vcYJD1fKDP3XaD/ycH8JYuUdwy86+ns+dWhU9gv0=;
        b=RocDwXFrDGO/UvAZFqVuRg/v72xtGyOM9Lk5I2qYuyt1+h8yABESCofSInZzYjJ7g5
         cOTtJivWVwprgwt3Q5LXiAJYIEl+sdyNTcBH1qmMMZJlh1QmB9bHBS76g/C8pElZQDuB
         q4l3oiqhf6zDfV9HFpik4L4/j1+eP7S6z4164=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6E8vcYJD1fKDP3XaD/ycH8JYuUdwy86+ns+dWhU9gv0=;
        b=rcWlbeU2hv70zFlhn6yJvM70C/7E4nonpM2zZCIAd3yuQt0QhUl5tjkWeCAjnkJfnq
         /pfcrtCqYPG3kjstKQMLMoX70D+Wk/u30baArAyfR6KUJCVKSVyv8NLTkB1dnMh09/Jj
         k2q6uszDn6FlZVavYNMh1/wgevaNdDJ2ALTRVXOdfWImoz29eJSMEMfF6f1+fhZQSD78
         U+MiRHFU6RYRvvfbxIcD5xBRJOmeLSxmcnNn48yFQBYeqn2KmgLw4t5uSOVPMfCgZVxb
         F+q7LmgXPpN5yn6ddIyr5jHow+O1P+Rl47G8MsYjH4AZ9RBJMDFJbeSI9qZK8BqJKkU1
         szcg==
X-Gm-Message-State: AOAM531xxn8dtujXBQXP2+NPQybUsyFIcVWaBFQqCn+RBeIdZMU1mqcd
        N3EXh7fNv+RR4zjRwVUAiWIYRyAxPUSYxhV9XVuZWQ==
X-Google-Smtp-Source: ABdhPJxCk6IMb59lyzYez87DGQZ6Gc3q17oYBRmUQDgX/ynDSJlazwQKn7ZL0Q43BMkQWirfnUQPme8eEHyOBDDqfXA=
X-Received: by 2002:a05:6830:1290:: with SMTP id z16mr2825771otp.159.1635534616693;
 Fri, 29 Oct 2021 12:10:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Oct 2021 14:10:16 -0500
MIME-Version: 1.0
In-Reply-To: <1635510619-6715-1-git-send-email-quic_kalyant@quicinc.com>
References: <y> <1635510619-6715-1-git-send-email-quic_kalyant@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 29 Oct 2021 14:10:16 -0500
Message-ID: <CAE-0n51eW3kkeW+3vJyqVTUF-R5G38SF2VjXi4SksuFbz=zcQg@mail.gmail.com>
Subject: Re: [v2] drm/msm/disp/dpu1: set default group ID for CTL.
To:     Kalyan Thota <quic_kalyant@quicinc.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        y@qualcomm.com
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, mkrishn@codeaurora.org,
        abhinavk@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kalyan Thota (2021-10-29 05:30:19)
> New required programming in CTL for SC7280. Group ID informs
> HW of which VM owns that CTL. Force this group ID to
> default/disabled until virtualization support is enabled in SW.
>
> Changes in v1:
>  - Fix documentation and add descritpion for the change (Stephen)
>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
