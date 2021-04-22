Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C895C368852
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239647AbhDVU6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239499AbhDVU6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:58:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEC0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:57:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so37077458wrt.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qPJnxVIEMRL17vY4saKs+ZjepvAYDqLQ81lTbkjcV9c=;
        b=qohcsG17/PEUI6y6/1P7el67bOAnHZyqo58Fe+T8VOU1HqNTnbNTHRFFT6TwJSffaD
         HZhmBgC8+talqYkeCLKcuuPbfIOVQUsy9j8wpU/v1CUf2nqwCs56FwIQO1fd8Gs9RVfV
         AJzeBWWXblGz3tzs7go/G34WyGRVYcszD3h4gnmLPLuhQnPp0GYMtM4jYs1AQtXcw6tQ
         ij+N8tLsYv/vDIt/F6ApZ28cbxbdYaUWRFjtxuvwwM7FElTPzkDoiGj6XxdlGKfaWH/v
         41Itr9vSnK2gZBhpZ3rH7drGf13UBR+ROLloDj4Xsey3zO+5Lh+4MboB0MlSigulV7q9
         DazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qPJnxVIEMRL17vY4saKs+ZjepvAYDqLQ81lTbkjcV9c=;
        b=ckG7nw5RlOm8dxlWp3Cpj5Ev++iZBYAT25HIm/r37R239gplryMdoeuO86HlsWkfd8
         Bpk3kRVkIQQCIWGNDnnbsPeFiembd8ynEC8jK/NHn/WncM5v0Rh7UYJwjiAhU6qoT9ep
         9ZPP0Ir0jrzcXD4Z4BJkULN9vmisFXIx35I3mDTT3dQOGofGjwcTU/ZmHCsb8edWLaQk
         VpqUToVReprz2bOKZn5yqU4diY+ALwNhVcoEMbb7Qr3G+pHev2BkRvhil6T9knooS9GQ
         AjdxOhJtZTaqsbcMedQ8Pz/j6I9Moi1yBQQJJd/Kxkqs7kEL/J75CH6/T4QDS+0hIBjJ
         ebHQ==
X-Gm-Message-State: AOAM5312+J0Rz9ZhTXXy3LUt7mz/CAcwHods8qyw6PnUOAkg4Jh+tTnz
        SboN1kBtdr+yeMlNGeqHkNxpML4xj4sFOCYpOzwIHEMW+cE=
X-Google-Smtp-Source: ABdhPJy59nGOJlolqUk8q5RqI/T+Za+uX8bGC3+QzX4KWs7nlt+IQ/H3Fhx4l5gNSsW/yYfIJuTNIB4cSuGSKaqjDKI=
X-Received: by 2002:adf:9148:: with SMTP id j66mr345078wrj.124.1619125054685;
 Thu, 22 Apr 2021 13:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
 <a085478d-5118-cdff-c611-1649fce7a650@linux.intel.com> <CAOUHufbVmsvWQ-_PSn8CCanuJqRR6Tmj01s17WvKsc3pRa87xw@mail.gmail.com>
 <2ea3318a-b17c-ec4c-5425-cb93e079a994@linux.intel.com>
In-Reply-To: <2ea3318a-b17c-ec4c-5425-cb93e079a994@linux.intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 22 Apr 2021 14:57:22 -0600
Message-ID: <CAOUHufY_0WO5LJ13EL9-bQLvmNaaOpPFMVNUsRvYrefrLqS9aw@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn,
        Shakeel Butt <shakeelb@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 2:38 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
>
>
> On 4/22/21 1:30 PM, Yu Zhao wrote:
> >
> > HZ/10 is purely arbitrary but that's ok because we assume normally
> > nobody hits it. If you do often, we need to figure out why and how not
> > to hit it so often.
> >
>
> Perhaps Zhengjun can test the proposed fix in his test case to see if the timeout value
> makes any difference.

Shakeel has another test to stress page reclaim to a point that the
kernel can livelock for two hours because of a large number of
concurrent reclaimers stepping on each other. He might be able to
share that test with you in case you are interested.

Also it's Hugh who first noticed that migration can isolate many pages
and in turn block page reclaim. He might be able to help too, in case
you are interested in the interaction between migration and page
reclaim.

Thanks.
