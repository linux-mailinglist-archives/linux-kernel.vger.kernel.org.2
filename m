Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819CD3B4B76
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 02:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFZAUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 20:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFZAUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 20:20:40 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171F2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:18:18 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id m9so7320382ybo.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 17:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NcRcSgdUzoVBFryBJ5U6vhpNHs8/PcmbXBm/viWxP0A=;
        b=HkCJ6SJLDGjowPzQEwEYI7OgD0qUJXPeP1i3ZnO8SB49/ZRzUOzLQFTPhn/C6cHrJ7
         e8v1Yza/TChKIWzXQoxR1UodssIS1LlkoOs3Rdc+UWaeWrTmj2MFDt6Lh1ZQgzlqlLla
         DmoP7BqUC2rRhb2pa0HLmaqM0C6utF9/AqPuJ8+EMD0V7GW+0PM0rut28FDKvUWiq1Ts
         aS3hkekanADiJwCcgm4WaNe87B31kPUpjoBMxA5d2EuWsjviI8Ly6G5VwEeZUq+efr7V
         yHghmE1CJVNZnDlJvg3lAl+Efbr1MRKydyMM4R/9AoJGLU9lB0eiG6pYOeAssbaLMtPQ
         BtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcRcSgdUzoVBFryBJ5U6vhpNHs8/PcmbXBm/viWxP0A=;
        b=A8r5k+lHjFPU8oBTYPwNMZ6KDNemnY3QAb3BCB4BIQSs8qqotASFoK3QL+DBg0AwFa
         VRZofYfACQKnRszL0JlY1eGY4cv5nNoKw837GtIzXptnRxhDynlixoC011C93XPigdKw
         5jiJW4DLpEYvRUNy5MzBcME7hfHSgIrmCBV+E0Fu5tY+WXuCLvPg6F7DKJnL9tvb8d/Z
         vGHNmElvlc5CKtA+YrR6anlKXAyGVi6rlFUYHPYGQn/h8ERbpeJbn9+7UdbSbgSIv08E
         87aWW7li/64QJLjG/Xsz2BhgKdZIhaPZdfIM3wiiSCYiVmtkXHLhXq+l8I51z8zi+AUf
         JupQ==
X-Gm-Message-State: AOAM532vp2LayCH6w8D5GJfJ9uCx/oyq7KSbUxX/bx8sRiBGk8c/emtg
        cgj5aYG1k+KigYIKH2EdS1k6vxnrX2N+ah6CcUnAbw==
X-Google-Smtp-Source: ABdhPJxMJOR3AE7+rAJmnIzp0K/DhA96qhf+z2kvkGttPZjlEsYXh2CEnkV/WvxcscFhcJ7oPNxPR2xT/OBVxboo2Yw=
X-Received: by 2002:a25:bb91:: with SMTP id y17mr15844019ybg.177.1624666697107;
 Fri, 25 Jun 2021 17:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210608231132.32012-1-joshdon@google.com> <YNWQfZfMNyEsiKTb@hirez.programming.kicks-ass.net>
In-Reply-To: <YNWQfZfMNyEsiKTb@hirez.programming.kicks-ass.net>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 25 Jun 2021 17:18:05 -0700
Message-ID: <CABk29Ntv_BhG3veC1KdFEoaZ4UWohKAO5GdxoaVD+iOmMGw1_Q@mail.gmail.com>
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 1:15 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> You should probably also make cpu_weight_*write_?64() return -EINVAL when
> IDLE. Similar to how SCHED_IDLE doesn't do nice.

sched_group_set_shares() returns -EINVAL when called on an idle group.
