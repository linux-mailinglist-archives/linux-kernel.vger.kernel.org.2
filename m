Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6C238B17F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbhETOQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 10:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241222AbhETOQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 10:16:02 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E5C061378
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:12:29 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v8so16290728qkv.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkHo3erLDZR+lieUBLhkTFtIEuk0AYkzrTrqjfDFe/U=;
        b=Ji12OY2herRL147Rn5utrZ6bxEgsoW+oMFn1Oo6O0TFyqHOToTwOatfNMiTI25U12x
         UF99oBYRzc/Swrh8fwOzhzIc0Lm7D2Q9HpzOlvr6c3Fwl5VLqIfTQJYZ0Cmig/fPrZl8
         rqoP9s8cua/wx9uL40CeQq+xYo+OVJddzgIIbLTNuw2sLKzxYMUxCkk6HTxd7Rgupwo+
         T2zPXcBMb3UlgbqegPcDfO/B/oXURBbL/7Y2pltmvncSIDXlLhtZyZrFPj5lK9ZX0IjV
         +w33TH45SJKuAS+1oZqOYd/FdDzBWZ8QnxYDF+8eT2KtZqhNIKCqsHJOWQ+sNJhwPjOi
         FfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkHo3erLDZR+lieUBLhkTFtIEuk0AYkzrTrqjfDFe/U=;
        b=AHRT+kbVGF36R1pklHDYY+WLj8qOpSbhIZUDvy1p0++jaNlPKiktDHw0EYJUPV8lrI
         cHvtGlduWmvFeJaOuAxaAf3rhWCWyyyCXBZ8mG5uoivOgSYcqQhL26rbulduBk8yq35Z
         pi6VPRll65eY8MPR0V5rD+50r+rRJltNLiGQn/HmS6e9lSq1T1VaZTrXw4QKIKAULi4R
         7aUFm0D80fw5M/RKES6K+N8ngWbuKlqqkzjiQD7enrr7eVx3NrtHEWzYt+99DdR3tKwB
         fZzvSafI10jI3IZp18RLbdPWnd/2wqV2g0OGXgwv1AcfKc/CC7D70+gKanMCN0dLui1+
         TFsg==
X-Gm-Message-State: AOAM533gr3J09+xGke9bQeVgQFdEojjX4EhPLQHYhHSY0yRo37aJof1G
        2/Jixl6cBmOLCimG4Dl14bsCpbbgNOHLwWXXYVPtOQ==
X-Google-Smtp-Source: ABdhPJxYPugnQQ2h6CEWDpZaht6OPYXf7g5wdLj9+ULaPm+69FQWOf8sIO107ngserLEhv8b7sPacnXOfKcVIqo9sac=
X-Received: by 2002:a37:e10e:: with SMTP id c14mr5258508qkm.209.1621519948988;
 Thu, 20 May 2021 07:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com> <20210520123419.8039-3-changhuaixin@linux.alibaba.com>
In-Reply-To: <20210520123419.8039-3-changhuaixin@linux.alibaba.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Thu, 20 May 2021 16:11:52 +0200
Message-ID: <CAFpoUr1GZspG1yKHf3D=+BZKfufWNNdu2Ccuj+YBo8EaJYRi8w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] sched/fair: Add cfs bandwidth burst statistics
To:     Huaixin Chang <changhuaixin@linux.alibaba.com>
Cc:     Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, pauld@redhead.com,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        shanpeic@linux.alibaba.com, Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am a bit sceptical about both the nr_burst and burst_time as they are now.

As an example; a control group using "99.9%" of the quota each period
and that is never throttled. Such group would with this patch with a burst of X
still get nr_throttled = 0 (as before), but it would get a nr_burst
and burst_time that
will keep increasing.

I think there is a big difference between runtime moved/taken from
cfs_b->runtime to cfs_rq->runtime_remaining and the actual runtime used
in the period. Currently, cfs bw can only supply info the first one, and
not the latter.

I think that if people see nr_burst increasing, that they think they _have_
to use cfs burst in order to avoid being throttled, even though that might
not be the case. It is probably fine as is, as long as it is explicitly stated
what the values mean and imply, and what they do not. I cannot see another
way to calculate it as it is now, but maybe someone else has some thoughts.

Thanks
Odin
