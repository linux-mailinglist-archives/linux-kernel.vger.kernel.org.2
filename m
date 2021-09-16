Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1740D0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 02:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbhIPAXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 20:23:42 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45938 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhIPAXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 20:23:41 -0400
Received: by mail-lf1-f45.google.com with SMTP id g1so11288900lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 17:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBgGHg/l8QaB9IPlY4W0UCEBHvw9BjW5zk1zFZIoOr4=;
        b=rvWQwKfKnqlGySjZj578WhSBlEOkP+dKt3xEkFHvuq4VoB704AFvLLwW7dnhiSpxoZ
         Wo44IB40jM9r0rHg86fP8sipTuopevMzKosxZepYALegQ5EFFsAw6oDHTz7hv1si4DMJ
         3OuwJhgq9guXvi2YZqY1ugJzfzsuXrBg8L9ix6ygHKLb6KSVEh7ILw6j9x+9HfinELHh
         jfCzqL1HBg+ywRbvyyc9OoaXTCq5d6yNAgbdYSXU2EgwB1HpNqB3OgWshKmxK/YNXVO4
         7IIJXStQmMu0TKUqDVRtj/JzX5KvdTQXflV90+YKgTsnUmf9gIXdKkEAufI4gNLqT69e
         hvUA==
X-Gm-Message-State: AOAM530O5JYsKoBfZTqP+n8utp57vrU4+iO1n+zSN+41tUk6UCptDsss
        674qSFlKmYoOug+ToDk8Uy2z0+Up9kPKFS1/xPw=
X-Google-Smtp-Source: ABdhPJzMBOFkV2JZ6Xjt9mK2DcYx1lQAPiF54f35TygfBqwSOiMuiFoQRkDyiCodyOR6GqiuH94b9Rf3u8rOhWybpn0=
X-Received: by 2002:a05:6512:1296:: with SMTP id u22mr1984370lfs.454.1631751740841;
 Wed, 15 Sep 2021 17:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210811044658.1313391-1-namhyung@kernel.org> <YRTmshairdxxiFo2@krava>
In-Reply-To: <YRTmshairdxxiFo2@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 15 Sep 2021 17:22:09 -0700
Message-ID: <CAM9d7ci-jbWCjud-tzk5A899iSfe1JmWmMCqi3XWNfCpeZ3F1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf tools: Allow to control synthesize during record
To:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stephane Eranian <eranian@google.com>,
        Jin Yao <yao.jin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Aug 12, 2021 at 2:15 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Aug 10, 2021 at 09:46:57PM -0700, Namhyung Kim wrote:
> > Depending on the use case, it might require some kind of synthesize
> > and some not.  Make it controllable to turn off heavy operations like
> > MMAP for all tasks.
> >
> > Currently all users are converted to enable all the synthesis by
> > default.  It'll be updated in the later patch.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> for both patches
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Could you please take these patches?

Thanks,
Namhyung
