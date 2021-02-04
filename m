Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D05C30F341
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbhBDMfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:35:54 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:37005 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbhBDMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:35:53 -0500
Received: by mail-qk1-f176.google.com with SMTP id s77so3074356qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:35:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LsxIO7rN8pPMLftt4vg+scMkX8uPN+d+hAtN2umy2Fk=;
        b=bYVmBzs8EekQiDm+izycnlPb/PuPVKbDZv5/hCwRyBZySnDutzDPg87PxB2LetEbxJ
         WPSbTv8W9BjdNA0GvJAyJs62LyiBcgVTaGOzsooAyoJ/a4Yechr+zoWe6eDcnQatCr0c
         uVHEGbzdwnyHaxor5WtDI8U2rC1Fp5wCIUxyYxNZ5C6QptpTh9Uu3Atfm0sTcipN/g5l
         xVEgDTv+1UikEwW+Iv/5MefSdAvyZ8ubzEBGnnS5I65k6Hs7k7rTNDMBbui1TWeMaANW
         bPTlgeT7hV1AezVJX5zG3GOY3MTQ5DKtVQakBBUT7prh5bQ1GspxGYFEfzwWCpVt1bkv
         DaOw==
X-Gm-Message-State: AOAM530/bgws3S6kwhbZ3i1lgwHTc07JrWh3TB96vsrrcxSFXbG1vs64
        +9YoV+4ZR13BWYnwnt+UkOQXyCNcXykbueIR7Rc=
X-Google-Smtp-Source: ABdhPJyxevox6VkVEd3RoV6dEdkEUhauF4RxUxTGpd+3BLz828q8W4boqTHVG/LZN8JyTE09FrGDUc16hJYS5F+a4DU=
X-Received: by 2002:a37:648e:: with SMTP id y136mr7202461qkb.148.1612442112944;
 Thu, 04 Feb 2021 04:35:12 -0800 (PST)
MIME-Version: 1.0
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com> <20210203205502.GN854763@kernel.org>
In-Reply-To: <20210203205502.GN854763@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 4 Feb 2021 21:35:01 +0900
Message-ID: <CAM9d7chNh5vS3vOVT+d7U4L=YCRB5W6FgbtvdWnh3t2vdAMhww@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] perf stat: Introduce iostat mode to provide I/O
 performance metrics
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Thu, Feb 4, 2021 at 5:55 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Feb 03, 2021 at 04:58:25PM +0300, Alexander Antonov escreveu:
> > The previous version can be found at:
> > v3: https://lkml.kernel.org/r/20210126080619.30275-1-alexander.antonov@linux.intel.com/
> > Changes in this revision are:
> > v3 -> v4:
> > - Addressed comment from Namhyung Kim:
> >    1. Removed NULL-termination of root ports list
>
> Hi Namhyung,
>
>         Are you ok with this patchkit now?

I've left some more comments.

Thanks,
Namhyung
