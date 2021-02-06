Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF75311C17
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBFIK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 03:10:29 -0500
Received: from mail-lf1-f50.google.com ([209.85.167.50]:38445 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBFIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 03:10:26 -0500
Received: by mail-lf1-f50.google.com with SMTP id m22so13888725lfg.5
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 00:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdCKUOOvLRKqJGcBf3726MN35cQVH7doyHjReo+krxc=;
        b=FjoyiF1iT0zPW38EBJssMC7qZbCId+n8lZc3uWgSAJ1XXVIBKUCpz/0ExEsysKosvv
         Dyfn+d9SaadIOyA3Mrjb6YqrPo8FCEjwrWJ6xvEyujugbtXYLRGkx2L43/STejG3vCZ3
         7co28H0Vk7BjN8A7AMbE0JSDAulnWkyRqCvaXMlaQtUeeQixHMtlDmoLdhJkaDEc3gr8
         PYc7UWTb2HwNe7inq7IP1GTUY+1bpxp+pejPSfCZscQ57MUilSIk3fqvAxxZxbj9yEED
         VC/Zob5ywB527yFXEaZQP5t9dpIjNrrjOybcce8k+ZQ5B6MBE39EJCvMaP6hDQckri/3
         M2gw==
X-Gm-Message-State: AOAM532ezLnMPw1EfTSJ4NO9Ji+hQS0ABjlh886lquU7/vZQivZhehVo
        M8PBVr16atZ2bggQ0EdsXWzqq/ujcBFJs+6YklKMGoDw
X-Google-Smtp-Source: ABdhPJz28O9q0FX0mYMELzOFp5gTGOaJgIRn34erZZGXR26ypWU1EUiRZm2tOXeEb4EEYIp2j43vzSPoVZyCgTMuELc=
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr4524653lfu.112.1612598984926;
 Sat, 06 Feb 2021 00:09:44 -0800 (PST)
MIME-Version: 1.0
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
 <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
 <CAM9d7chGxZc0MA4nqVeJRDXLEzWsQ-ceJ+xgMVmEbQbDVDf72w@mail.gmail.com> <a1e837a6-9c6a-c613-d7b9-8e6547dfcf67@linux.intel.com>
In-Reply-To: <a1e837a6-9c6a-c613-d7b9-8e6547dfcf67@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 6 Feb 2021 17:09:33 +0900
Message-ID: <CAM9d7ci1qQy+oeOvKJE4N8nZxm6h+=vBP_wp_WXOhPnUphpJ-Q@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Yao Jin <yao.jin@linux.intel.com>, maddy@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 11:38 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
> On 2/5/2021 6:08 AM, Namhyung Kim wrote:
> > On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The instruction latency information can be recorded on some platforms,
> >> e.g., the Intel Sapphire Rapids server. With both memory latency
> >> (weight) and the new instruction latency information, users can easily
> >> locate the expensive load instructions, and also understand the time
> >> spent in different stages. The users can optimize their applications
> >> in different pipeline stages.
> >>
> >> The 'weight' field is shared among different architectures. Reusing the
> >> 'weight' field may impacts other architectures. Add a new field to store
> >> the instruction latency.
> >>
> >> Like the 'weight' support, introduce a 'ins_lat' for the global
> >> instruction latency, and a 'local_ins_lat' for the local instruction
> >> latency version.
> >
> > Could you please clarify the difference between the global latency
> > and the local latency?
> >
>
> The global means the total latency.
> The local means average latency, aka total / number of samples.

Thanks for the explanation, but I think it's confusing.
Why not call it just total_latency and avg_latency?

Thanks,
Namhyung
