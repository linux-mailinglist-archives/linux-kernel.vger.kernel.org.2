Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28FC536F143
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236819AbhD2UtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 16:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236737AbhD2UtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 16:49:00 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD486C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:48:13 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id a18so26424245qtj.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 13:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFc2H/uuDNG6mhR7R+crmY+ptoL0P1RcjoOttIU6eIY=;
        b=qabzS5m9gj1GEL2TvdC78tTot/7F3iPVfyyWrV+VuOSkCUCVa2Vogt/gv+PFTFhOsO
         kv0ZzJGAcWlfdJ6YhH7clJSZ0tUwD6McMOJtzSLu6o436UpCYggWaUkSoUP85idJqvIA
         8lVHkx5nC3BtPnKwAKPQjl3vaS4dlGQtmIeEQpKbQmyHQbuegusUjASy4mF6IwKtsuyV
         LwpIZordeLPeYi4/jfbxiGwMao3v/4ypT3zx7r0OPkWDQ6/Us82DJcxYvcMGXmwYYlZO
         xx44NOSUmNi/S1cslX/eC8MMqr2bXspPNvIyUTIwGzwIQ1dPHPyn6LMraO/boZh/dQWF
         DoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFc2H/uuDNG6mhR7R+crmY+ptoL0P1RcjoOttIU6eIY=;
        b=Ho+zkMZ+b/MQkh7dEDcUFLqe5lPQgNdW/GCctLdPKG1REHwWEv/Qapef5upCTNcybl
         2ISehKpxzj+RDF4dUErszDL0R4OCYDxD2eHAFZWpyWYezVlImKMfraLgHoousTEHYAGp
         F+XttYh9atS2L1Gwa2OtIp5e7TRtRrncucL02H0sxE5DRYoihPmhU9ic8XL9SR819HSD
         1S67a1PGy7Kf+P13/JnZEuSb8Ipm5q6oSemYv3Fbph6MGWAwItH57gFhsvOStc9xSssE
         lmqs2wM2FjTbWM/Ynmma6H6ITvaqu9VvWnu9pMxs7O+dwafv0fAn5UqQLHevbwPG37US
         pBNA==
X-Gm-Message-State: AOAM531F7qxlzUb8C2krQFSgHeBDiFazJTF/+snRDXHfuzjnICjh1iON
        kOqbhu8KEtWrBi5G5ZSiXKcVu8NYoBCAkpfotqkZfA==
X-Google-Smtp-Source: ABdhPJxj/Y6dadoRniiAgYeHloz7Nu/aZPXFISYFljo/JngdamCEoqCLsGPlR5JbvP1mzAfMruIjzYU81em3NHzCHoc=
X-Received: by 2002:a05:622a:c8:: with SMTP id p8mr1286166qtw.145.1619729292799;
 Thu, 29 Apr 2021 13:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210422120459.447350175@infradead.org> <20210422123308.196692074@infradead.org>
 <CABk29Ntop2nX+z1bV7giG8ToR_w3f_+GYGAw+hFQ6g9rCZunmw@mail.gmail.com>
 <YIZ6ZpkrMGQ9A9x2@hirez.programming.kicks-ass.net> <CABk29NvicqM_c2ssYnDrEy_FPsfD5GH38rB_XHooErALOabe5g@mail.gmail.com>
 <CAOY2WoyTq0AYMz+z=USxSpdcJqWMjkq-FDkuLN++brwhAkwTaQ@mail.gmail.com>
 <CABk29Nuz-FDCk23ajcr9gS4KD-wMpwyn=ASu+yuTTT445rwTvw@mail.gmail.com>
 <CAERHkrvU2Xzi5p9Dph3zZ7zkoYjSV1krK-UhqE7+Qb80FodEGg@mail.gmail.com>
 <5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com> <CAERHkrsoCR7d3N2rhwKCeFDDBv4-S4HzD567mOaV_pngXn_Hkg@mail.gmail.com>
 <CAOY2WowOR6HhoKMsGrg+2VFD6ySY67E7Kr1s2GCuO4LdyusyUw@mail.gmail.com>
In-Reply-To: <CAOY2WowOR6HhoKMsGrg+2VFD6ySY67E7Kr1s2GCuO4LdyusyUw@mail.gmail.com>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 29 Apr 2021 13:48:01 -0700
Message-ID: <CABk29Nt_xBaoawiyMv1RG+Yzg_a9w5RMc6Zy0ggmS5K-9LzrUA@mail.gmail.com>
Subject: Re: [PATCH 04/19] sched: Prepare for Core-wide rq->lock
To:     Don Hiatt <dhiatt@digitalocean.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 9:41 AM Don Hiatt <dhiatt@digitalocean.com> wrote:
>
> I'm still seeing hard lockups while repeatedly setting cookies on qemu
> processes even with
> the updated patch. If there is any debug you'd like me to turn on,
> just let me know.
>
> Thanks!
>
> don

Thanks for the added context on your repro configuration. In addition
to the updated patch from earlier, could you try the modification to
double_rq_lock() from
https://lkml.kernel.org/r/CABk29NuS-B3n4sbmavo0NDA1OCCsz6Zf2VDjjFQvAxBMQoJ_Lg@mail.gmail.com
? I have a feeling this is what's causing your lockup.

Best,
Josh
