Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8CD36F774
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 11:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhD3JAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 05:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhD3JAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 05:00:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656DEC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:59:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619773194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHDXZNRd4tsaMqS5i74+1PSaitlFlgyCrsOa9AiRqvc=;
        b=NNML5AdCGPQzurQyjRs/4XJjMZ//nw+vSLbVnbqG/GDhBUI0hGUUTZVksTUC8GqTkpfnd6
        zNgqfnjLcze/Vf18Ws0wPgphxMmVRGEBT77YZBhd3U0mp1g42y9WAh8sQ/Q89d9p0zJYm+
        F5tLzwSCIWPqdetaJPsh8QE7/bK3uSG8ppDkOSyQW+OPSlhVhW0dhjhcTVzb5G94zkWMhq
        fD+H5tJNxaK9BLRGj0m50y1iRkBOJpIxBZORhSgrNjWz5+qmekH7lxhh7DB/YVunyRdcux
        7Ca8taGuoyntjLKMfFsM51Bhx8qLlIZ0TAh1sQWhgTg5Ffdr2fJcBDRRTrFhug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619773194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHDXZNRd4tsaMqS5i74+1PSaitlFlgyCrsOa9AiRqvc=;
        b=eJzxLDro/zdeiFmiHXQ/e5nQOv/Y0E52G6a1q+ViQDm8vTIYrQModU8o1FB3sdkuZtnGvt
        qMN1wjistVtnlADA==
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alarmtimer: check RTC features instead of ops
In-Reply-To: <YIu7ZqowGScElHBr@piout.net>
References: <20210429214902.2612338-1-alexandre.belloni@bootlin.com> <877dkkfdif.ffs@nanos.tec.linutronix.de> <YIu7ZqowGScElHBr@piout.net>
Date:   Fri, 30 Apr 2021 10:59:53 +0200
Message-ID: <871rasf8qe.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30 2021 at 10:10, Alexandre Belloni wrote:
> On 30/04/2021 09:16:40+0200, Thomas Gleixner wrote:
>> On Thu, Apr 29 2021 at 23:49, Alexandre Belloni wrote:
>> > Test RTC_FEATURE_ALARM instead of relying on ops->set_alarm to know whether
>> > alarms are available.
>> >
>> > Fixes: 7ae41220ef58 ("rtc: introduce features bitfield")
>> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
>> > ---
>> > Hello,
>> >
>> > This doesn't seem much but this solve an issue where following a change in the
>> > RTC driver, this part of the code will think the RTC is alarm capable while it
>> > is not, then breaking the alarmtimer functionnality.
>> 
>> So a driver has the set_alarm() callback but does not advertise
>> RTC_FEATURE_ALARM for whatever reason and why ever this makes sense.
>> 
>
> No, it would be the other way around. The issue happens when you have
> two RTCs, rtc0 is not alarm capable and rtc1 has alarms.
>
> The driver for rtc0 used to not have .set_alarm() to signal it didn't
> support alarms, it then switched to RTC_FEATURE_ALARM, making the
> alarmtimer code select that RTC instead of rtc1, breaking suspend/resume
> on the platform.

I'm even more confused. So RTC0 does not have .set_alarm() but why does
it turn on RTC_FEATURE_ALARM? I'm obviously misinterpreting the above...

Thanks,

        tglx
