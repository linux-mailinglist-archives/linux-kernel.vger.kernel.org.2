Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC73836F6EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhD3ILF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:11:05 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54763 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhD3ILE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:11:04 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C710E1BF20F;
        Fri, 30 Apr 2021 08:10:14 +0000 (UTC)
Date:   Fri, 30 Apr 2021 10:10:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alarmtimer: check RTC features instead of ops
Message-ID: <YIu7ZqowGScElHBr@piout.net>
References: <20210429214902.2612338-1-alexandre.belloni@bootlin.com>
 <877dkkfdif.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dkkfdif.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2021 09:16:40+0200, Thomas Gleixner wrote:
> On Thu, Apr 29 2021 at 23:49, Alexandre Belloni wrote:
> > Test RTC_FEATURE_ALARM instead of relying on ops->set_alarm to know whether
> > alarms are available.
> >
> > Fixes: 7ae41220ef58 ("rtc: introduce features bitfield")
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
> > Hello,
> >
> > This doesn't seem much but this solve an issue where following a change in the
> > RTC driver, this part of the code will think the RTC is alarm capable while it
> > is not, then breaking the alarmtimer functionnality.
> 
> So a driver has the set_alarm() callback but does not advertise
> RTC_FEATURE_ALARM for whatever reason and why ever this makes sense.
> 

No, it would be the other way around. The issue happens when you have
two RTCs, rtc0 is not alarm capable and rtc1 has alarms.

The driver for rtc0 used to not have .set_alarm() to signal it didn't
support alarms, it then switched to RTC_FEATURE_ALARM, making the
alarmtimer code select that RTC instead of rtc1, breaking suspend/resume
on the platform.

> I don't mind the patch, but the changelog is a bit meager in explaining
> the WHY.
> 
> Thanks,
> 
>         tglx

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
