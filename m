Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1406310A00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhBELLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:11:49 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:43852 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhBELJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:09:27 -0500
Received: by mail-lf1-f52.google.com with SMTP id d3so9267738lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:09:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmQbZfgniFPVo4cnL/FxCHbKgto6MyJ0Gub2LwVH6po=;
        b=QMvxP+GsgxdnW3Y2Kh8inaWNXQ0Bdhpjl+hDWVsZw1ZJLIj0uKBb2PCAtEhFFZhaqq
         xjeS8SAz6TUCndupnowwxVgkiYQdsONtkEGfV9Kmhyj7SukERZ+JyeCljmvAHXsSaVzr
         N7oxTK7WUGbRvz5Zdz0jp62S3gbivI+cQbjFjBKBU29569pJMMf4DcnmdJCTxkwBCUbS
         hH/YsDax7NDfMh6nXps6vljMqOKwR9Xl8x/8kcDizQg03esx3Tc2XwXMVtcTBNaxnKIP
         2t55SUiJs/vJK6V3bj2enEXvpLhje/vFt2GVM5aJhp6ZOM7jZlppAs3FMB9vzzYhPGN2
         lxwg==
X-Gm-Message-State: AOAM532Y2GAYeNcwvgOVfD8Jj2xlpdNUyiwBfKpA5jh8gWjDAdqtvLvY
        K/n06iRiLR8QfEReO9yFNOgfXkMeiiJLHxQ/508=
X-Google-Smtp-Source: ABdhPJwqAmIpzzYLK1lns2ycHWwolOvAiNiqr0QY76s/MaW44h4mT0jP66JbAsSY15h0xu3Pyo9UgLfHyI2zaJ9ZUxw=
X-Received: by 2002:a05:6512:2342:: with SMTP id p2mr2270439lfu.509.1612523324921;
 Fri, 05 Feb 2021 03:08:44 -0800 (PST)
MIME-Version: 1.0
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com> <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1612296553-21962-7-git-send-email-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 5 Feb 2021 20:08:33 +0900
Message-ID: <CAM9d7chGxZc0MA4nqVeJRDXLEzWsQ-ceJ+xgMVmEbQbDVDf72w@mail.gmail.com>
Subject: Re: [PATCH 6/9] perf report: Support instruction latency
To:     Kan Liang <kan.liang@linux.intel.com>
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

On Wed, Feb 3, 2021 at 5:14 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The instruction latency information can be recorded on some platforms,
> e.g., the Intel Sapphire Rapids server. With both memory latency
> (weight) and the new instruction latency information, users can easily
> locate the expensive load instructions, and also understand the time
> spent in different stages. The users can optimize their applications
> in different pipeline stages.
>
> The 'weight' field is shared among different architectures. Reusing the
> 'weight' field may impacts other architectures. Add a new field to store
> the instruction latency.
>
> Like the 'weight' support, introduce a 'ins_lat' for the global
> instruction latency, and a 'local_ins_lat' for the local instruction
> latency version.

Could you please clarify the difference between the global latency
and the local latency?

Thanks,
Namhyung


>
> Add new sort functions, INSTR Latency and Local INSTR Latency,
> accordingly.
>
> Add local_ins_lat to the default_mem_sort_order[].
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
