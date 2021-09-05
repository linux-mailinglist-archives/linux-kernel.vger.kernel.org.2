Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F4C40115D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhIET2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbhIET2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:28:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59B4C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 12:27:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s12so7588099ljg.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8GB7YhVw4I1lPBw5iEYwKcJSJkJXzzk2ALEpsWj50AQ=;
        b=d4ueszfQ1ChFjZO2aea6b+E01wkxIgHE+pSGmW46ZDORJ+bEbGdJ/41SX0ogREEFtP
         CM8M9osKCmWe3C9S+idgR1EmTVczhP/XXxe3d3l6Ni2gUB4zKM57dpE3XGbNnxKKyfol
         G7zFB2dH6nDWpOnyLRqs0z7A89oxk1GDTRSEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8GB7YhVw4I1lPBw5iEYwKcJSJkJXzzk2ALEpsWj50AQ=;
        b=K5ngviw9hHKrkmZrZI9YGBJ2tGogu15yS4KiJuzyg5wi9Tqpsm/d2HA6HUV5dU8vsL
         sejDQ9s8tEgx+CISda04u85fIlORfzPh2sg6ZaCb1Cdpq+xjHG8O7Xsdjz9Ay9Hb0Dgj
         d9jJrDypXOfOyDLtXXb8oZox+v1gDZRUYKSeuZGNkAkz26b3cqBE1J9qPCL9gDghkzNj
         kfKxAnjdM6iXbL+3e5+XVAyUQLOqVm7m7NItQVNpd27whTpGgSY2DUuSo115Qv/GGArP
         q5UzaUG1nfwF2fY38wAi48tMC6Lk1vEwc/BqrAQf+qiVye+WrsVPkzjeFy7pF2leQm0G
         laFQ==
X-Gm-Message-State: AOAM531LgtVmSrb3OfVJjOGoScWD5j8V93OvwBzKVPXPsOCrihhYfINj
        2Jed7wQwxLbUYqMT0QUDl4TENc1X0UvwOO1QpF0=
X-Google-Smtp-Source: ABdhPJzLsDsP+rS3r3+pnojNBcn0friB/TXBEMVOIK2CNtHoZkSgtjjcAlZgeKoLp+6WgHQambzhyA==
X-Received: by 2002:a2e:824e:: with SMTP id j14mr7719590ljh.65.1630870023497;
        Sun, 05 Sep 2021 12:27:03 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y35sm545318lfa.107.2021.09.05.12.27.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 12:27:02 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x27so9072133lfu.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 12:27:01 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr7080170lfv.655.1630870021592;
 Sun, 05 Sep 2021 12:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210904184924.16279-1-acme@kernel.org>
In-Reply-To: <20210904184924.16279-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Sep 2021 12:26:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=9gNaQpZ3ChKfW-=9in7yGwP-sg5M75GVdSmMPEJC9Q@mail.gmail.com>
Message-ID: <CAHk-=wj=9gNaQpZ3ChKfW-=9in7yGwP-sg5M75GVdSmMPEJC9Q@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.15
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alyssa Ross <hi@alyssa.is>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Colin King <colin.king@canonical.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Eirik Fuller <efuller@redhat.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Joshua Martinez <joshuamart@google.com>,
        Leo Yan <leo.yan@linaro.org>, Li Huafei <lihuafei1@huawei.com>,
        Nghia Le <nghialm78@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 11:49 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.15-2021-09-04

Hmm. I don't usually build the perf tools except after a pull, and I
might have missed this before, so it's not necessarily new..

But the perf build leaves this stale file around:

        tools/perf/Documentation/doc.dep

which should either be ignored, or it should be renamed to one of the
names we already do ignore (make it a dot-file?)

              Linus
