Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CEC446CDD
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 08:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhKFHeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Nov 2021 03:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhKFHeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Nov 2021 03:34:07 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD46C061570
        for <linux-kernel@vger.kernel.org>; Sat,  6 Nov 2021 00:31:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d21so9258428qtw.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Nov 2021 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/ummrva1xlq9iGvRWMrNIPoFCsus9LqyFn/FezC6P4=;
        b=iumb/8rt941EHWijq74V2+87i25j70EbMcaf6mhBWRSmOniAamFXOqMCxk+iDdeLqR
         lC7tRc1BTNRozN5A1lvWRFerIK1pzvCHM9A0Fit3Dz3vYPmGXFlZUn79G5QAm49WHQMw
         EHlmaKjMYM6bpHJ2EyV8kVuz1mfisvf5k7lCqSqDH4w81lI4MsOGzSxTiBGYYeioLdkG
         5IMYi7HUDvA1ka9edmX6a8y6F5hGdBtluHou8belKdFQlWIvl1Kn92auD9BUNJBVixI8
         R4MTmWDxHFtILYZda0xqRLmqWggu2U5+F93st7i9h4OhVovDA32YhJL4OOay/guOno8b
         tzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/ummrva1xlq9iGvRWMrNIPoFCsus9LqyFn/FezC6P4=;
        b=Q6VNlAyvnUW/GlU1goWhCfAM0/j+ZglHoJH+LU3NyhsEBNqTb/d+vvT/11v5twWhvn
         vO5sL9z4wfTRwwOtzTb1iIL1i45WRyfS70g6CE9V1OuWQmhdD7YhDmZ/b6Ze1Pt/6JNG
         Prmv2ywOoEo0n7Oze0pE4Go2YXA93gKkFIuzizyexjT2I+aIQHFmhoPdhrw4J/6uuVb5
         Z/4HTzuRLs/qu64hvq5HDKFSiYV2XXNHv+AKoZQPO1wR7T6yZZYWhD6LIKs/BM0QMBTX
         zpPssUquwVSuaUr61W74gh0Gz5m6bsAdiL1tL62Rg80DchYK8PaMcthvCck1eiINg+t/
         g/aA==
X-Gm-Message-State: AOAM533oGsaf7OJ1FTCIdaGrRYfzNB56qBeYGMcfDcXtSHMN0ceDsGcu
        f/fJgRj/bJ0xXEDFQREsRBqQCJT20WJJBzj5fiQ=
X-Google-Smtp-Source: ABdhPJweWnxvnI2HXQlphizPPgfCreDArC7DXNDKFR33BnN/38tieHB1X3u7huHsjGnkDrWvnWqdmYnnlEEUBXKpYgw=
X-Received: by 2002:a05:622a:1388:: with SMTP id o8mr51901638qtk.160.1636183885425;
 Sat, 06 Nov 2021 00:31:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211104145713.4419-1-laoar.shao@gmail.com> <20211104145713.4419-2-laoar.shao@gmail.com>
 <87bl2ytu45.mognet@arm.com>
In-Reply-To: <87bl2ytu45.mognet@arm.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 6 Nov 2021 15:30:49 +0800
Message-ID: <CALOAHbArZ90h8yn4mzQhBDEwStA6eNffXx1K=E=Wro61AvDkGA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] stop_machine: Move cpu_stop_done into stop_machine.h
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 6, 2021 at 1:01 AM Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 04/11/21 14:57, Yafang Shao wrote:
> > Move struct cpu_stop_done into the stop_machine.h, then it can be resued
> > by the functions outside of stop_maichine.c.
> >
>
> The nr_todo & ret faff is only required for multi_stop scenarios, which
> isn't your use-case. AFAICT you don't need to export this, you just need a
> struct completion somewhere (and maybe a ret, but I'm not even sure about
> that).

Right. nr_todo is for stopping two and more cpus.  We really don't
need it if we only support stopping one cpu.
I will change it.

-- 
Thanks
Yafang
