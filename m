Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1F43CD21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 17:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhJ0PMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbhJ0PMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 11:12:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6AEC061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:10:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id k13so5172270ljj.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CLKCt4ozxElbnzSZjxsFLN7ur/ju/mKMQO+9ROBwfA=;
        b=R5qxY7fb3ayRyca952OvZ4iWjQqSjp2/77ZZXbji8xbdJqscOw6KZ9Pk+k7D8mHXi2
         2EWEzXbrkTHNTfGRkyxMItChdczfvMcNw1T5BWi+b6tFP0rZy1eNKF3CzRo/5/78GVcs
         hRlzFXUTlcNncCdJeCxThkGmggPl5xZabaquHxGGNO7W1WR1XNrchc33M4vEGsComHZA
         tLYWD6GAsqkbCP6ECxqmtKj5pEbX58e0sfnghXJev7eWPMRVaSfel81PLIofzwUTZ9v5
         /ATAzPgkYv53M/tDfRUqqay9lv2zMENvSL3i3CdqoaITBkQiNOGiqNEUHiJVW06D66/f
         Xehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CLKCt4ozxElbnzSZjxsFLN7ur/ju/mKMQO+9ROBwfA=;
        b=5+sNNE9e1qnI8koYbML6UnjDzYCcIdwklCbqftSYh49hJH9QuWsZecajk7KsG5ErT3
         ZcHAKdVbZ8VHUvwbZS5RUzCYfwwkB3FeFCcY/tCwLX1/4M0NM3t1XNhhZQTwoZHTgRDk
         pUwtE7Tz8f8K+B+RCRZn8HrnTAmt+0tp2X0MkFmIZ1iCHM/UdT6kRppJWbJ/ReQFEs7d
         YFZkzwUcsL+Og3lLN3s3Bc+XQQ9eDtS0kLsqf72mjPQyvpbb0W4+RE1m6ukRgIbq4j4A
         P7QqY322p0PGZ5I6whYjv01mlbm/7aKEA23Z1Ku8kDvU7ayss/G2WUClIqWW5Z49xTBC
         KGYA==
X-Gm-Message-State: AOAM533sXNYmWV73hQGWRu5jwNObsf2T6AWYvmJmp3+JxU5+hntg0wsW
        df1DHoDB+9iaQL2amD+S6SJyxgJg+BCYebOvBLK4NsHE8Kyk8Q==
X-Google-Smtp-Source: ABdhPJxEId8JXtqsIcTwSZWJAiHzSaAvFARVIPb0iV3NsiaqSCXwha06DmMy6vMKM1vw0zhSQz94MXWjmXjF0lDCF8c=
X-Received: by 2002:a2e:bf18:: with SMTP id c24mr33289636ljr.408.1635347419423;
 Wed, 27 Oct 2021 08:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
 <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com> <alpine.DEB.2.22.394.2110261658440.3825@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110261658440.3825@hadrien>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Wed, 27 Oct 2021 08:10:12 -0700
Message-ID: <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 8:13 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> The problem is illustrated by the attached graphs.  These graphs on the
> odd numbered pages show the frequency of each core measures at every clock
> tick.  At each measurement there is a small bar representing 4ms of the
> color associated with the frequency.  The percentages shown are thus not
> entirely accurate, because the frequency could change within those 4ms and
> we would not observe that.
>
> The first graph, 5.9schedutil_yeti, is the normal behavior of schedutil
> running.  The application mostly uses the second highest turbo mode, which
> is the appropriate one given that there are around 5 active cores most of
> the time.  I traced power:cpu_frequency, which is the event that occurs
> when the OS requests a change of frequency.  This happens around 5400
> times.
>
> The second graph, 5.15-schedutil_yeti, is the latest version of Linus's
> tree.  The cores are almost always at the lowest frequency.  There are no
> occurrences of the power:cpu_frequency event.
>
> The third graph, 5.9schedutil_after_yeti, it what happens when I reboot
> into 5.9 after having changed to passive mode in 5.15.  The number of
> power:cpu_frequency drops to around 1100.  The proper turbo mode is
> actually used sometimes, but much less than in the first graph.  More than
> half of the time, an active core is at the lowest frequency.
>
> This application (avrora from the DaCapo benchmarks) is continually
> stopping and starting, both for very short intervals.  This may discourage
> the hardware from raising the frequency of its own volition.

Agreed. This type of workflow has long been known to be a challenge
for various CPU frequency scaling governors. It comes up every so
often on the linux-pm email list. Basically, the schedutil CPU frequency
scaling governor becomes somewhat indecisive under these conditions.
However, if for some reason it gets kicked up to max CPU frequency,
then often it will stay there (depending on details of the workflow,
it stays up for my workflows).

Around the time of the commit you referenced in your earlier
email, it was recognised that proposed changes were adding
a bit of a downward bias to the hwp-passive-scheutil case for
some of these difficult workflows [1].

I booted an old 5.9, HWP enabled, passive, schedutil.
I got the following for my ping-pong test type workflow,
(which is not the best example):

Run 1: 6234 uSecs/loop
Run 2: 2813 uSecs/loop
Run 3: 2721 uSecs/loop
Run 4: 2813 uSecs/loop
Run 5: 11303 uSecs/loop
Run 6: 13803 uSecs/loop
Run 7: 2809 uSecs/loop
Run 8: 2796 uSecs/loop
Run 9: 2760 uSecs/loop
Run 10: 2691 uSecs/loop
Run 11: 9288 uSecs/loop
Run 12: 4275 uSecs/loop

Then the same with kernel 5.15-rc5
(I am a couple of weeks behind).

Run 1: 13618 uSecs/loop
Run 2: 13901 uSecs/loop
Run 3: 8929 uSecs/loop
Run 4: 12189 uSecs/loop
Run 5: 10338 uSecs/loop
Run 6: 12846 uSecs/loop
Run 7: 5418 uSecs/loop
Run 8: 7692 uSecs/loop
Run 9: 11531 uSecs/loop
Run 10: 9763 uSecs/loop

Now, for your graph 3, are you saying this pseudo
code of the process is repeatable?:

Power up the system, booting kernel 5.9
switch to passive/schedutil.
wait X minutes for system to settle
do benchmark, result ~13 seconds
re-boot to kernel 5.15-RC
switch to passive/schedutil.
wait X minutes for system to settle
do benchmark, result ~40 seconds
re-boot to kernel 5.9
switch to passive/schedutil.
wait X minutes for system to settle
do benchmark, result ~28 seconds

... Doug

>  I also tried
> a simple spin loop (for(;;);) with the 5.15 rc version, and it does go to
> the highest frequency as one would expect.  But there are again no
> power:cpu_frequency events.
>
> julia

[1] https://www.spinics.net/lists/kernel/msg3775304.html
