Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B5F34E227
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhC3H1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:27:09 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:33315 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhC3H1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:27:01 -0400
Received: by mail-lj1-f182.google.com with SMTP id 15so18841310ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 00:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMl0C2b5ebpTnwdNSaTT+Ok9a/oj9pc9s8BQ0TZhX2Y=;
        b=p+SIqhWsCzHL9v0DgOOFgywYKhM7cSGgM0KoBlNg2rEUpO34sOdrI6TRCJABmH3NuU
         PO88f7nSY+7CS8l0hpePe7Ut9fDPVwBjqO7nrjaLMPPgNH2/Vz/ZUKCs2cCnksJc6uqJ
         WeEybXWkoOBVN6EsM0IDO4p0JQSQ/l0msPFbcfjpTZBsx4o/ceM2uqPTJ91tBVPZIuOA
         HvO1dOgpNX4zorDnOILk8dscVl0qrEgfozvVoka5ODnDVkbQ4S61KR6On6q+1Cqidns9
         o2j8by6Fnm7tpt8T4nNoJOL5UzlLSqe/dd91MHSmm0bhqatFLlRP8xcqGHFgtFlZMNVP
         1oaA==
X-Gm-Message-State: AOAM532Q6ACWPQLW9hwY7MSxwkZPU/WVPY1E5tbxidnnxE+2hJqR/Xo9
        MBwOBgNLzFr9qCQGvdp7ojaE4EtQ486NKIXQV9c=
X-Google-Smtp-Source: ABdhPJzHXD1jkXu6wpwSOpRqV8k8ceYfNtd2iohTZb1CphSS2cEukPXqGYoemRKmM16Y7OvvNy72npTw/ykq35YbHgI=
X-Received: by 2002:a2e:b008:: with SMTP id y8mr19219630ljk.233.1617089220361;
 Tue, 30 Mar 2021 00:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210319123527.173883-1-yangjihong1@huawei.com>
 <33ba152e-b8ef-3057-744a-51cb8c478ff2@huawei.com> <CAM9d7cjT-Q8RBprzG=hwdxrgVpzf3RwECuJ1UvbQYpQ47migbg@mail.gmail.com>
 <YF3OXfzl7FEV50Ir@kernel.org> <27703989-e510-c964-2af7-ef0a5611f8cf@huawei.com>
In-Reply-To: <27703989-e510-c964-2af7-ef0a5611f8cf@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 30 Mar 2021 16:26:49 +0900
Message-ID: <CAM9d7chhFnYyUv++RzJRXomHq0vZN2LrbCAOBPg67MDeg6saOw@mail.gmail.com>
Subject: Re: [PATCH v7] perf annotate: Fix sample events lost in stdio mode
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Yao Jin <yao.jin@linux.intel.com>, gustavoars@kernel.org,
        mliska@suse.cz, linux-kernel <linux-kernel@vger.kernel.org>,
        zhangjinhao2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang and Arnaldo,

On Sat, Mar 27, 2021 at 11:16 AM Yang Jihong <yangjihong1@huawei.com> wrote:
> On 2021/3/26 20:06, Arnaldo Carvalho de Melo wrote:
> > So it seems to be working, what am I missing? Is this strictly non
> > group related?
> >
> Yes, it is non group related.
> This problem occurs only when different events need to be recorded at
> the same time, i.e.:
> perf record -e branch-misses -e branch-instructions -a sleep 1
>
> The output results of perf script and perf annotate do not match.
> Some events are not output in perf annotate.

Yeah I think it's related to sort keys.  The code works with a single
hist_entry for each event and symbol.  But the default sort key
creates multiple entries for different threads and it causes the
confusion.

Thanks,
Namhyung
