Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2443AD646
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 02:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbhFSAfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 20:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhFSAft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 20:35:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56270C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 17:33:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id w4so7504538ior.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 17:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dZ10QAktHB0VeE10rkvtL4By2SOCAcxAk+zpfYz46hQ=;
        b=aNQfHil6++umZJsUm28W1mpTv1MPSJAw/WryoNpU5YsSa6TDv9yJid3s1bH3fGmD1S
         prRuAjXBMfoUVxHKph0Vn53MVzoe6fS9PDc2qDqJy7887IPuCmxHBLhLcya8zVDEJ6IB
         TkEXaWAvZob/jKSvcHlbCgr8pEkVlvQ6AJKHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dZ10QAktHB0VeE10rkvtL4By2SOCAcxAk+zpfYz46hQ=;
        b=P27Ng5luyr2Wt5dQ8WOWVG7OQMbZf1lOxBfXd7PqAAJdnbH3zAVmFmwdsoGgTDq1TJ
         L4vF9KZOHR1xexiTwmzSqdKoCtfGgKIzT8U9APUOoFdwEJgJea5CFILQHXPEBSjqpOSF
         w1IsbqK33GQWI2BrrJd5io1yPAcIPo/bZr/3PKCIi5MEHIGQHsPNn/B/bglUYy+a3pj+
         7XCiImm4SxvgRpbFX5rOPbi3nyJ60WPLdq3AFhtJGGF2WCItyWbi90O9TbW1jfrg3PsT
         6LtFH5vUOREZfDCZsjI0a1eiSXVyD7KUkX5wtFZp4h3RAVB4Z8xVCpYNdw3X9w4h0qN2
         NXVw==
X-Gm-Message-State: AOAM532NXexXXMALiKGsnFOPOGnTey+8iEEkH7L+q1Nqs+1ZRPYsDVsO
        YJIAMp6NMbOz8c1fgwQMgkAJNBOVh1hTz7BqTOTAiA==
X-Google-Smtp-Source: ABdhPJwGrDLT4DtzNkow1Jj/UV9TSUkK/vh8nsq7UAyEQVevk4vNJCfLyE+RhGaL4nQ1wSyX13RiXiQnocLLRA2RLLI=
X-Received: by 2002:a5d:8154:: with SMTP id f20mr4884694ioo.89.1624062817664;
 Fri, 18 Jun 2021 17:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210618040639.3113489-1-joel@joelfernandes.org> <YMxagWy/Ioj3aere@hirez.programming.kicks-ass.net>
In-Reply-To: <YMxagWy/Ioj3aere@hirez.programming.kicks-ass.net>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 18 Jun 2021 20:33:27 -0400
Message-ID: <CAEXW_YQVu9rN04voYUSWiRrzNxa+nQyNMaTyreOuBn96B8yNSg@mail.gmail.com>
Subject: Re: [RFC] schedutil: Fix iowait boost issues for slow I/O devices
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Josh Don <joshdon@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 4:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Aside from everything else:
>
> On Fri, Jun 18, 2021 at 12:06:39AM -0400, Joel Fernandes (Google) wrote:
>
> > +unsigned int sysctl_iowait_reset_ticks = 20;
> > +unsigned int sysctl_iowait_apply_ticks = 10;
>
> Never expose HZ to userspace. we even have USER_HZ (no new usage please)
> that fixed existing problems with that.
>
> If you expose a knob, make it in sane time units and convert internally
> to whatever you need. That said; less is more with knobs.

Sorry, you are right and good idea. I will look into making such a
modification while I wait for comments from others as well on rest of
the patch.

thanks,

-Joel
