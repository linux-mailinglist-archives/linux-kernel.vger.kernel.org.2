Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09DE35247B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhDBAe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDBAe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:34:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA79C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 17:34:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i19so2822853qtv.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 17:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GH3plRryBuW9V2Hqcxc+vb+3ay6lNqrrq70AzxxfFQw=;
        b=dNo4Ue3as5uGsGZN7+CWxkErz4b7UGIaOMYLtzYfFYg2ybvHFcJZVo6kDRopgaEzBs
         4+P+NbvJDl4n3HyRh6F3JwVdp12m+Rks6IPRdRH2Xo1VFyDV+fp9AgSiJJrc7L9t2Z+u
         Kt/q4T1O/RJIhSeR6i8g0VX3eq6b4dO0/oJIXG8jdWscGU4AvcUqsyx1Xuoxi9EWQGYN
         j3xCzy1v4MQgmkNGNW9FxXpJBYSP8ddf+Vhe+OatJAj2q9S9SX10LxIU6LuCU5qk5we2
         2XhxC3pc8by94b95NFiFiG91lAtMW1urTD7TERjlYYyAjr4rip8SRhq50PNBssbp1fMH
         DiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GH3plRryBuW9V2Hqcxc+vb+3ay6lNqrrq70AzxxfFQw=;
        b=q4LMq1nzH14rCQf+eCqDibO8K7C40YRFqKE6McoqpyhcIN3oDwAlbLV2sWgunPHD9+
         OacQjJGSXe0HPJ2GEY1JszEYnkXkd8o+JzUyq4fCMHGsDXuxH/HvaeYuDN990b/w+euY
         D9CpDmJA8NMp6BK5axpXQ1CK1UfoJD0FNV5+xlvOKIOxqjmSm4PIJb5HPC3enMGeURqM
         kY85Uy/fUMqDtSdqcHuwpHLe/U67s4SYdEBJXdvKqayLDe1sR3t3GZHjeWU7qbyZLXEj
         6JS/b7xlUj+HVn9WvlItZsvF3RPlH+6BHEf7HWQzLPQQw9awCt2fUnAF3CFlvSwnN/mZ
         ILhA==
X-Gm-Message-State: AOAM533jig9lnywBB+dmkvpRKcOKTWcqQbx1ptvKJE4LUSvGayr7fwVZ
        +IibhakDQSje0Q0Hvy21yz0x5/mAyJohImCWbRIUQA==
X-Google-Smtp-Source: ABdhPJwsb46316pEr7F18AXZ94X7lfZXbWne4CKqxcN0Y+2yiAnatHWPKzsBr//fZ2DnAhaZ3p35hO4wPJyZM3X4cH4=
X-Received: by 2002:ac8:5554:: with SMTP id o20mr9650227qtr.143.1617323664744;
 Thu, 01 Apr 2021 17:34:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210401131012.395311786@infradead.org> <20210401133917.469929784@infradead.org>
In-Reply-To: <20210401133917.469929784@infradead.org>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 1 Apr 2021 17:34:13 -0700
Message-ID: <CABk29NuhhwPgFm9HQs=CgpPMKAiqVn4kOACwwEeTYmBTbw03Uw@mail.gmail.com>
Subject: Re: [PATCH 7/9] sched: Cgroup core-scheduling interface
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, allowing for multiple group cookies in a hierarchy is a nice
improvement.

> +               if (tgi != tg) {
> +                       if (tgi->core_cookie || (tgi->core_parent && tgi->core_parent != tg))
> +                               continue;
> +
> +                       tgi->core_parent = parent;
> +                       tgi->core_cookie = 0;

core_cookie must already be 0, given the check above.
