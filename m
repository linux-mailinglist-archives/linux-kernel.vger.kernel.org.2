Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E803EA6CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 16:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238155AbhHLOuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbhHLOuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 10:50:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9434AC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 07:49:42 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628779781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t7QfrgkfBcYFUetsP5IAsMFhEXMWAQKKKsPElvr4FwI=;
        b=wsI73nLFgphtRRp7SrdpozgtWnHvgq+xV+XlIwREh3LmPL7b42jgSVFDdfYMCd52BAKs6j
        UX6ahaNAd3a1kJycDTWFIAicrYoCqwX/ACqT8U5Iy8eGgxM/qukuDl18tM3DTM3Xabh99X
        LAvTwa7oBn2YaWcvXiyoPEkBQme6WKOpr+cYla++ZE+B1q1wYsRIhYOG+RZjnNZjn+tEl+
        xCo5BQL4F9YBk4z59N+zizsdceC1KkojHend3PEJbqrLjEpJqNnDqGYEpiREB2nlC0BexX
        AzZB7My+rkFMu26IGtDGybQtQfS/cVpQ/nvOd7W5JOG6BTxGET0Z/+BU1bad6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628779781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t7QfrgkfBcYFUetsP5IAsMFhEXMWAQKKKsPElvr4FwI=;
        b=boOwQLba3Ml1bWH2oILNTuYFg3GeU9zhRq/XmOumRhRxaNWKLcMPyWbRDBo0a5/RLbHN/h
        tBPHc0jkqKLGtLCw==
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] drivers/clocksource/timer-of: Remove __init
 markings
In-Reply-To: <CAAfSe-vY9bkLb7Q2Tn=2ug6pau9VHkfZyvmoQNMqeKmxfquOHg@mail.gmail.com>
References: <20210715065455.392923-2-zhang.lyra@gmail.com>
 <202108011431.Nx7sS0uY-lkp@intel.com>
 <CAAfSe-vY9bkLb7Q2Tn=2ug6pau9VHkfZyvmoQNMqeKmxfquOHg@mail.gmail.com>
Date:   Thu, 12 Aug 2021 16:49:40 +0200
Message-ID: <874kbuiupn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12 2021 at 14:39, Chunyan Zhang wrote:
> On Sun, 1 Aug 2021 at 14:18, kernel test robot <lkp@intel.com> wrote:
>> >> s390x-linux-gnu-ld: timer-of.c:(.text+0x306): undefined reference to `iounmap'
>
> Seems TIMER_OF should depend on HAS_IOMEM, but this error is not
> related with changes in the above patch?

Right, it's not caused by your patch, but if you already analyzed the
problem, then why are you not sending a fix for this?

Thanks,

        tglx
