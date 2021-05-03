Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D9D371815
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhECPfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:35:00 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:14047 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhECPe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:34:59 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 04632240007;
        Mon,  3 May 2021 15:34:03 +0000 (UTC)
Date:   Mon, 3 May 2021 17:34:03 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alarmtimer: check RTC features instead of ops
Message-ID: <YJAX60DSp/imRstL@piout.net>
References: <20210429214902.2612338-1-alexandre.belloni@bootlin.com>
 <877dkkfdif.ffs@nanos.tec.linutronix.de>
 <YIu7ZqowGScElHBr@piout.net>
 <871rasf8qe.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rasf8qe.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 30/04/2021 10:59:53+0200, Thomas Gleixner wrote:
> On Fri, Apr 30 2021 at 10:10, Alexandre Belloni wrote:
> > On 30/04/2021 09:16:40+0200, Thomas Gleixner wrote:
> >> On Thu, Apr 29 2021 at 23:49, Alexandre Belloni wrote:
> >> > Test RTC_FEATURE_ALARM instead of relying on ops->set_alarm to know whether
> >> > alarms are available.
> >> >
> >> > Fixes: 7ae41220ef58 ("rtc: introduce features bitfield")
> >> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> >> > ---
> >> > Hello,
> >> >
> >> > This doesn't seem much but this solve an issue where following a change in the
> >> > RTC driver, this part of the code will think the RTC is alarm capable while it
> >> > is not, then breaking the alarmtimer functionnality.
> >> 
> >> So a driver has the set_alarm() callback but does not advertise
> >> RTC_FEATURE_ALARM for whatever reason and why ever this makes sense.
> >> 
> >
> > No, it would be the other way around. The issue happens when you have
> > two RTCs, rtc0 is not alarm capable and rtc1 has alarms.
> >
> > The driver for rtc0 used to not have .set_alarm() to signal it didn't
> > support alarms, it then switched to RTC_FEATURE_ALARM, making the
> > alarmtimer code select that RTC instead of rtc1, breaking suspend/resume
> > on the platform.
> 
> I'm even more confused. So RTC0 does not have .set_alarm() but why does
> it turn on RTC_FEATURE_ALARM? I'm obviously misinterpreting the above...
> 

I'm sorry for not being clear.

With RTC0 not having alarms and RTC1 having alarms:

The previous situation was:

The driver for RTC0 didn't have any .set_alarm() to signel it doesn't
support alarms.
On registration, alarmtimer_rtc_add_device finds out it doesn't have the
.set_alarm() callback and doesn't select that RTC.
On registration of RTC1, alarmtimer_rtc_add_device finds .set_alarm()
and RTC1 is now the alarmtimer rtcdev.

The new situation is:

The driver for RTC0 always have .set_alarm() but clears
RTC_FEATURE_ALARM to signal it doesn't support alarms.
On registration, alarmtimer_rtc_add_device finds .set_alarm() and RTC0
is now the alarmtimer rtcdev, leading to an error when rtc_timer_start()
is called.

I hope this is clearer.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
