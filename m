Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D2C30F2DE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhBDMIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:08:50 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:39226 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbhBDMIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:08:48 -0500
Received: by mail-qt1-f178.google.com with SMTP id e11so2130385qtg.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2MnuWw/zsUlFQOtKqPMfK24NaxnUoxdjPMBpT4vbJs=;
        b=L1uqHqEe9R91FrGmDXSyDb4WIk2+L3PVKJsoqoxySl3ELNa5k+A45qVpDEFIbulCXv
         TmuoLmPEVe08vfhJuZssUqE7F9VA/FrS0Rs9fCrljDzASNtAzYnkN5ZCX6smpcEL/wbf
         cO5AKM1oeGKrWyadKfntISNNbEWvcnVpXFUNP6q4FuJrS7tMVDTIqIkiHgp/YOgOQmI4
         L72CMWq1hAscRHPnJvM8YPkf25Lq5oZvStpWB2FqWmJaP+P9ojRALPbq4ShJX6p7uWRR
         xMhnFSOOzURT9KFuMn6oAmYXn29lR2rHe1N4CavsRWIRoqxAu+gHzi8yGv/aEf+FYkoX
         ViBw==
X-Gm-Message-State: AOAM530hTm+Fgab6glC4aQmmdX7+yrMbPOi/BS6Tp1wUQWO0Etg4S26t
        eJX9X6wNJgQj2oSp5CkiDC33qbOSLHoHG9Nw4mmsoyGM
X-Google-Smtp-Source: ABdhPJyJJInEPbFfXwmnso2JjU7iDgdLOUHISORfK8EpR2ONmQW8yfxoWkO1AnG3GSrzIf+JSVJmOb5MkXtOguH+8dI=
X-Received: by 2002:ac8:7b89:: with SMTP id p9mr6831861qtu.276.1612440486825;
 Thu, 04 Feb 2021 04:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com> <20210203135830.38568-2-alexander.antonov@linux.intel.com>
In-Reply-To: <20210203135830.38568-2-alexander.antonov@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 4 Feb 2021 21:07:55 +0900
Message-ID: <CAM9d7ciCGd+mkLOyJciB4Oe6XEoFyKx_=zhnK1SDnDM3=0M5NQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] perf stat: Add AGGR_PCIE_PORT mode
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Feb 3, 2021 at 10:58 PM Alexander Antonov
<alexander.antonov@linux.intel.com> wrote:
>
> Adding AGGR_PCIE_PORT mode to be able to distinguish aggr_mode
> for root ports in following patches.

I'm not sure adding the AGGR_PCIE_PORT is the right way.
In my understanding, the aggr mode is to specify how we aggregate
counter values of a single event from different cpus.  But this seems
to aggregate counter values from different events.  Also the new
mode is basically the same as AGGR_GLOBAL.

As you will add stat_config.iostat_run to distinguish the iostat
command, probably we just want to use the global aggr mode
(and it's the default!) and get rid of the AGGR_PCIE_PORT.

Thoughts?

Thanks,
Namhyung
