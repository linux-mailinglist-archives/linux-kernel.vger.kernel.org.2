Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2769369AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbhDWTKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhDWTKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:10:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD87C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 12:10:01 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619204999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CfdWq7sxIYHSIUJRgs6eEDCymepNPtB5XuGEN2D2Fu8=;
        b=FCYwCmk2R2+uNhdhD6lqeIuih/SbsKMQ4T2dsho5l0a9jysrkC2G2zzd/AwinL9krsn98x
        C04Oo+yv3N5GDMtaMV1/otvyjP2SsQK27rUmtVC6qGlMT6l1l3ckdGZsgCevuITM4qi80L
        uMXqCq8XnMe4PbjjhsKE9kuHijckO/O0Oj3HKnGAsKAbzuu25k8j+GOVrtDJfveRB4vHg0
        O5mE/YSiVXTNo3U5F240E4lbGJOSylDT7Uju970Mxw0YaAj8AqcXG6VjVg5yO51PPcdIfe
        A+AYy12Vyc3fhOCqcSXzHoIxS3GB9ya6HwfETLPZ4gKqJshmXtgxi5Ah5+w3UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619204999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CfdWq7sxIYHSIUJRgs6eEDCymepNPtB5XuGEN2D2Fu8=;
        b=bhdFtftvFs9WP/CjlSwyDGG/qCwbmX6h8qLBZJgjFmcvw7wi0Tb2Hso6uwgzsT2m4VgZdY
        LIxJmSp+HWyoGVDw==
To:     Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        paulmck@kernel.org
Cc:     paulmck@kernel.org, John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec -14.4% regression
In-Reply-To: <20210422074126.GA85095@shbuild999.sh.intel.com>
References: <20210420064934.GE31773@xsang-OptiPlex-9020> <20210420134331.GM975577@paulmck-ThinkPad-P17-Gen-1> <20210420140552.GA3158164@paulmck-ThinkPad-P17-Gen-1> <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com> <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1> <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com> <20210422074126.GA85095@shbuild999.sh.intel.com>
Date:   Fri, 23 Apr 2021 21:09:58 +0200
Message-ID: <87wnssvmux.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22 2021 at 15:41, Feng Tang wrote:
> On Thu, Apr 22, 2021 at 02:58:27PM +0800, Xing Zhengjun wrote:
>> It happened during boot and before TSC calibration
>> (tsc_refine_calibration_work()), so on some machines "abs(cs_nsec - wd_nsec)
>> > WATCHDOG_THRESHOLD", WATCHDOG_THRESHOLD is set too small at that time.
>> After TSC calibrated, abs(cs_nsec - wd_nsec) should be very small,
>> WATCHDOG_THRESHOLD for here is ok. So I suggest increasing the
>> WATCHDOG_THRESHOLD before TSC calibration, for example, the clocks be skewed
>> by more than 1% to be marked unstable.
>
> As Zhengjun measuered, this is a Cascade Lake platform, and it has 2
> times calibration of tsc, the first one of early quick calibration gives
> 2100 MHz, while the later accurate calibration gives 2095 MHz, so there
> is about 2.5/1000 deviation for the first number, which just exceeds the
> 1/1000 threshold you set :)
>
> Following is the tsc freq info from kernel log
>
> [    0.000000] DMI: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> [    0.000000] tsc: Detected 2100.000 MHz processor
> ...
> [   13.859982] tsc: Refined TSC clocksource calibration: 2095.077 MHz

Right, that's because in 2021 we still use technology from the last
millenium to figure the correct TSC frequency out by doing a long time
measurement against some other timer where we assume to know the
frequeny it runs with.

Thanks,

        tglx
