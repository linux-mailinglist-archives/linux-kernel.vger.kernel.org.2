Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9943601A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 07:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhDOFeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 01:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhDOFeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 01:34:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F029C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 22:33:52 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k26so5580692wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 22:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcxipN5cxSd0VM+cEvQ6NWIOLmc57Nk1DsdNT+GW7KA=;
        b=e0QLLuXiL/4lCdt6iFXdA71OTjsHKMqML07QdxGi37fdb0xY2T0TJ/+nFDlQfV/0G3
         SVspNpOpWJvTCS3LdwIGhbaJAbuid29eogP4KwFR/haLC2IFdpJ9nr5KjuSA+vd4AKqK
         9Gg6HuSFhqFUKjFTj94VZH2oiqeiefCksJ1SIaxhdreCEGRYXRqyr/U9rQKYKGDODf3O
         GsXIIr7898lvGKOXkgLoZ5M62Bb0snj6gwAMqc6+UrrIj011Fud7QSOxXJLIyOXoe1Cp
         /fszAHSmxQ/xXq4aHqDaGGvs2aWY6EMnTjxNI0ilNnt0pNbv7RHrwwKeKhwmcwqseeEs
         r17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcxipN5cxSd0VM+cEvQ6NWIOLmc57Nk1DsdNT+GW7KA=;
        b=AX0Zpf56gV1eek+NGYPDqL3M4nMxJqRU+KZDeN6luhh24IFHP4XQ39AduZN4Iyk6/v
         muvK9CPyQJIMLIs5F8LYyXe0hPrKajmzNUyII3buK7FPFsNzNgoJOMHlOupxcuC0o1A4
         Y5jhetHKh47ygIOm3Appt8H2v4Ly2vRkUXIX4OB8JWIP6IKQbWVp166Cx92yl/A89fl9
         HbcBXDkNzURQ4voBEWcx3phI/54hrZOgcZ2iuNiVdieoujfq7WMV9VU0VOYTI+Oo/A/W
         51ixcAGrNj5DOfrhE+BWFTHzSGEeu7J2HngeGvKubbl37LcXLZPVWmvm1p4Jp+y3Hue6
         zG6w==
X-Gm-Message-State: AOAM532oDfVOXYW0EuXcmQKrwWZghFCmP8v9zt7HnlR+zeWYKhGp02lz
        sAsSJPQ/nLk0AGxYaF5liwMlD59NrMuJuDPGGk6v4Q==
X-Google-Smtp-Source: ABdhPJwr7DViLtLjzXCMiLGgHdvYPmNn6emVUmWM5evE07PXfyadzlYTCSsmY72xkVEO0wkdFINhS4zFc1TVm6x0Fwk=
X-Received: by 2002:a5d:524e:: with SMTP id k14mr1397309wrc.282.1618464831026;
 Wed, 14 Apr 2021 22:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210414131628.2064862-1-acme@kernel.org>
In-Reply-To: <20210414131628.2064862-1-acme@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Apr 2021 22:33:38 -0700
Message-ID: <CAP-5=fVRFKnTJb4m6bzSQhC8sndSLFTom8Hak9PZQ=W75CK4Yg@mail.gmail.com>
Subject: Re: [RFC] Improve workload error in 'perf record'
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 6:16 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Hi,
>
>         Please take a look,
>
> Best regards,

Acked-by: Ian Rogers <irogers@google.com>

Having been confused by this for a case in the past, thanks! It'd be
nice for code coverage's sake to have a shell test on this.

Thanks,
Ian

> - Arnaldo
>
> Arnaldo Carvalho de Melo (2):
>   perf evlist: Add a method to return the list of evsels as a string
>   perf record: Improve 'Workload failed' message printing events + what
>     was exec'ed
>
>  tools/perf/builtin-record.c |  8 ++++++--
>  tools/perf/util/evlist.c    | 19 +++++++++++++++++++
>  tools/perf/util/evlist.h    |  2 ++
>  3 files changed, 27 insertions(+), 2 deletions(-)
>
> --
> 2.26.2
>
