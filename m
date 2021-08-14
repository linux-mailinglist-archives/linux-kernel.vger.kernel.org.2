Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497243EC5EF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 01:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbhHNXWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 19:22:48 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51973 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhHNXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 19:22:46 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id E15C8E0005;
        Sat, 14 Aug 2021 23:22:15 +0000 (UTC)
Date:   Sun, 15 Aug 2021 01:22:15 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Paul Fertser <fercerpav@gmail.com>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] rtc: pch-rtc: add Intel Series PCH built-in
 read-only RTC
Message-ID: <YRhQJ4kdyu1Xs1Rb@piout.net>
References: <20210810154436.125678-1-i.mikhaylov@yadro.com>
 <20210814224215.GX15173@home.paul.comp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814224215.GX15173@home.paul.comp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2021 01:42:15+0300, Paul Fertser wrote:
> On Tue, Aug 10, 2021 at 06:44:34PM +0300, Ivan Mikhaylov wrote:
> > Add RTC driver with dt binding tree document. Also this driver adds one sysfs
> > attribute for host power control which I think is odd for RTC driver.
> > Need I cut it off and use I2C_SLAVE_FORCE? I2C_SLAVE_FORCE is not good
> > way too from my point of view. Is there any better approach?
> 
> Reading the C620 datasheet I see this interface also allows other
> commands (wake up, watchdog feeding, reboot etc.) and reading statuses
> (e.g Intruder Detect, POWER_OK_BAD).
> 
> I think if there's any plan to use anything other but RTC via this
> interface then the driver should be registered as an MFD.
> 

This is not the current thinking, if everything is integrated, then
there is no issue registering a watchdog from the RTC driver. I'll let
you check with Lee...

However, I'm not sure what is the correct interface for poweroff/reboot
control.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
