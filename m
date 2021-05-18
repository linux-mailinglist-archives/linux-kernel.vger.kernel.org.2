Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66275387A20
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhERNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhERNk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:40:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56120C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:39:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x19so14234150lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 06:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrf7kNqbVnAq1Hf1uDBaFlAV929R3QrjgqvJW3l17CY=;
        b=DMufJIyGl+qNFpflK8tU5hLtyEQK9T7KiW3MEpqtY3+36Of1jx9dJuhnl+YfejEiLM
         hPANf0IEpDtgAouU4WTLfVxIzrpDgnNkLM8E+N91lh0Fh1aq488EttAQrJrj1HMscFkz
         +wqn4bWB1oOKviRzm0K7jp8TjQf0kurdf+i6UUos208vX+n0yPGMg5JCnZmWfP+bbxuP
         luJYVWEAtucWfTN+0xCrWWFFCvUNvMZTO1LRA25gSk7j2Zk8SiLZJqwLQvMaf2TtPm8h
         7mxwLAQ4r2y+5/oW5f9m6zeQv4kqNrG5hW54jVdCmgqxUDhRic5qJhAJb4+BzLxQH5+C
         zAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrf7kNqbVnAq1Hf1uDBaFlAV929R3QrjgqvJW3l17CY=;
        b=m/45ycOMh+ovAovAdDEQAGzxvqJLiP0iLtQ4LGHeVUO07LbuK4RjynLd4IMXydKpOe
         XCVPnr5q0yLK0QA1joexS1iNd48nJ8f9myPQvcMJabacZv+Ah4+smnfVWv/zxTCzswde
         pbqk4IN1/yXlA4QUqTeFJTtJNmQTnhx8DnTzj5GhDBF2OaBUGLX0Xm8U0gs1Gi7190QT
         UNZvh0EmIWgk4hUVueJCRMXy9TXGOQJKtBqfQ6dTE8bQnAhcB26z5kPVV/866CNSdAxH
         QdgCB39ro1qc69FUm4Djcz4huCeDzDu98mWY+fwnCcnOqvA0We2CMgjU/LvgX+bzLUna
         WseA==
X-Gm-Message-State: AOAM533TT0VZgW6AYlHXX6QqF5wug70t4SWoWcQiiV21Pt/1Sqw5PXMS
        rQ1B7DCZ/5jTWKs4drnx0wGa/SM5oIBpjogkBwPidg==
X-Google-Smtp-Source: ABdhPJx422ES6gfI9g9zWtdAm24lIHv7zsc/CM8d0RwvK3AgZCihGwzdt92BAiHNiWlB+C5wItRT3gYSF7KGJMHkGC0=
X-Received: by 2002:a05:6512:22c2:: with SMTP id g2mr4601044lfu.305.1621345178822;
 Tue, 18 May 2021 06:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <1621239831-5870-1-git-send-email-beata.michalska@arm.com> <1621239831-5870-2-git-send-email-beata.michalska@arm.com>
In-Reply-To: <1621239831-5870-2-git-send-email-beata.michalska@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 18 May 2021 15:39:27 +0200
Message-ID: <CAKfTPtAPcayjhedNWaL20rsaUQbxXFdEXAF8aqwd9YX5gLVbOQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] sched/core: Introduce SD_ASYM_CPUCAPACITY_FULL
 sched_domain flag
To:     Beata Michalska <beata.michalska@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 at 10:24, Beata Michalska <beata.michalska@arm.com> wrote:
>
> Introducing new, complementary to SD_ASYM_CPUCAPACITY, sched_domain
> topology flag, to distinguish between shed_domains where any CPU
> capacity asymmetry is detected (SD_ASYM_CPUCAPACITY) and ones where
> a full range of CPU capacities is visible to all domain members
> (SD_ASYM_CPUCAPACITY_FULL).

I'm not sure about what you want to detect:

Is it a sched_domain level with a full range of cpu capacity, i.e.
with at least 1 min capacity and 1 max capacity ?
or do you want to get at least 1 cpu of each capacity ?


>
> With the distinction between full and partial CPU capacity asymmetry,
> brought in by the newly introduced flag, the scope of the original
> SD_ASYM_CPUCAPACITY flag gets shifted, still maintaining the existing
> behaviour when one is detected on a given sched domain, allowing
> misfit migrations within sched domains that do not observe full range
> of CPU capacities but still do have members with different capacity
> values. It loses though it's meaning when it comes to the lowest CPU
> asymmetry sched_domain level per-cpu pointer, which is to be now
> denoted by SD_ASYM_CPUCAPACITY_FULL flag.
>
> Signed-off-by: Beata Michalska <beata.michalska@arm.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  include/linux/sched/sd_flags.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> index 34b21e9..57bde66 100644
> --- a/include/linux/sched/sd_flags.h
> +++ b/include/linux/sched/sd_flags.h
> @@ -91,6 +91,16 @@ SD_FLAG(SD_WAKE_AFFINE, SDF_SHARED_CHILD)
>  SD_FLAG(SD_ASYM_CPUCAPACITY, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
>
>  /*
> + * Domain members have different CPU capacities spanning all unique CPU
> + * capacity values.
> + *
> + * SHARED_PARENT: Set from the topmost domain down to the first domain where
> + *               all available CPU capacities are visible
> + * NEEDS_GROUPS: Per-CPU capacity is asymmetric between groups.
> + */
> +SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
> +
> +/*
>   * Domain members share CPU capacity (i.e. SMT)
>   *
>   * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
> --
> 2.7.4
>
