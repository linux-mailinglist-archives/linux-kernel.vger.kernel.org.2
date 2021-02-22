Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52FE3221EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 23:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBVWFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 17:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbhBVWFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 17:05:09 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:04:28 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a22so60759986ljp.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBkjWiCKDwxxyhkLkU0CXVeC0iCvJ041DtGGGn17nrk=;
        b=Q+vHXymAuG0dmicU7e8Sv9nKyrbu3R1a5j7rcu8wI/vlsV07t3962X9ArHRNmm3Ny9
         8YDpq8h1Fwgc7iqpjMeC2DwLWKLApEpisfWe2e1mQzfO83B5ZTgDZ0iRiOTMScLLhcSA
         4t/I8p1eh/zpEr/RbKweUg0vSrEipqwu8t4Bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBkjWiCKDwxxyhkLkU0CXVeC0iCvJ041DtGGGn17nrk=;
        b=Ilv6MKrvcbboghFP6NSsy8Ofa4eFemjLrSQzwADSs1TOMHe64aQ4w3s0eDfpUo/DYK
         aUY/sQSNJgAXQoTFQyGFWa/z2hKhXy8rNZvYluC1j6hbBX9fmmtlLKSHXyivJI+5wgwH
         3u9mqADixYdJGkCUKBVjvLB0U4GMl5I12bswjWVl0oWnsPnrmIBhLAwKbUCL1e24xbv/
         Yq51JqIw7Lk8NR5d3vnnjMpR97XIyS5V5yYt/Z0Rzdp8XH4S2hzOTy2AncV8deks9YPQ
         o+AL2UWVxjSXYl2wke/E2KxIkUjjD1ENchx56H10mo1LrhdJ4sv6FjgLQJIJcpafpVak
         NdJw==
X-Gm-Message-State: AOAM533oX6844ONU6EtAAMfWgSqIo1EMpY+nJxlZjqLDpcfxiIoZi3RA
        hFnv9AQOpR1AFAI5u/47sAdw0mCvK3smMA==
X-Google-Smtp-Source: ABdhPJxejBYdc0yJ9RGCMYwe0EqMo6hAWLdm0NTiqY3hNbIA+tp/cSFsjexuVfnpHcgsxnEiXP1bcA==
X-Received: by 2002:a2e:90c5:: with SMTP id o5mr5820691ljg.496.1614031467183;
        Mon, 22 Feb 2021 14:04:27 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id v26sm950207lfd.6.2021.02.22.14.04.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 14:04:26 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id v5so8108009lft.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 14:04:25 -0800 (PST)
X-Received: by 2002:a19:8186:: with SMTP id c128mr14681033lfd.377.1614031465521;
 Mon, 22 Feb 2021 14:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20210219194619.1780437-1-acme@kernel.org>
In-Reply-To: <20210219194619.1780437-1-acme@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Feb 2021 14:04:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgmx7FLSoYu0+6TnFjex_uYMN9=15m=6BkZn0HyREisA@mail.gmail.com>
Message-ID: <CAHk-=whgmx7FLSoYu0+6TnFjex_uYMN9=15m=6BkZn0HyREisA@mail.gmail.com>
Subject: Re: [GIT PULL] perf tools changes for v5.12
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Dmitry Safonov <dima@arista.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jianlin Lv <Jianlin.Lv@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kees Kook <keescook@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>,
        Mike Leach <mike.leach@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:46 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Test results at the end of this message.

Thanks, I appreciate the changed format,

              Linus
