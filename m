Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212B33FB7B1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhH3ORA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:17:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52266 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbhH3OQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:16:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630332964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=073eqyzHweFONwPKlUX6YC53nwom5iKA5BNznEMqcYA=;
        b=efdIncqPOcSTFwwXsw6lO5YK8kZTGZvW7y8+PTDq/2MNfrORcd/EgJZf3C1FGXPNTNCKVo
        YW7uw5N4onek3nJpe/Mz213ZZJlxl/KeFXAyQC/5zF+BHJCV/bt28R/K660/earMt/jwCY
        NBxdKUiL5Q+QJOhQsjzTjHKpnPd6yeZ39iOI2G7vlkeM3Zumsj9wVM6y2yR85ckEoQK1vA
        5coTixyAC2ZaLYPYdl/lxpEzByWTmR6N3cLEw/qS1+uYfJ64xfBlFuLjSs7BW6UmenNIBm
        7/2GrZr4TguHIN5njgYXmXBHhCfXJHL4Tczd51tyVs2PTqDFRyoQD/TySQOlAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630332964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=073eqyzHweFONwPKlUX6YC53nwom5iKA5BNznEMqcYA=;
        b=KaSts1bYuZ9YLgrXvfIVa5RSimOBgB2ufh3ZcVI+4uwlZAwsa3OVu2j2LtN4XE/HCuZyPn
        bfNI4MwyrF00smAg==
To:     Mark Brown <broonie@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
In-Reply-To: <YSzM5S3VKOBXniRu@sirena.org.uk>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com> <875yvr3j5c.ffs@tglx>
 <YSzM5S3VKOBXniRu@sirena.org.uk>
Date:   Mon, 30 Aug 2021 16:16:04 +0200
Message-ID: <87bl5fggrf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 13:19, Mark Brown wrote:
> On Fri, Aug 27, 2021 at 01:01:35AM +0200, Thomas Gleixner wrote:
>> On Wed, Aug 25 2021 at 23:50, Vladimir Oltean wrote:
>
>> > It seems reasonable for regmap to have an option use a raw spinlock too,
>> > so add that in the config such that drivers can request it.
>
>> What's reasonable about that?
>
>> What exactly prevents the regmap locking to use a raw spinlock
>> unconditionally?
>
> We definitely can't use a raw spinlock unconditionally since we
> support register maps on devices connected via buses which can't
> be accessed atomically so we need the option of doing mutexes.

The mutex part is fine. For slow busses this is obviously required.

>> Even for the case where the regmap is not dealing with irq chips it does
>> not make any sense to protect low level operations on shared register
>> with a regular spinlock. I might be missing something though...
>
> That probably does make sense, I think we're just using regular
> spinlocks for spinlocks mainly because they're the default rather
> than because anyone put huge amounts of thought into it.  IIRC
> the first users were using spinlocks for their locking when they
> were converted.

So if the actual spinlock protected operations are not doing any other
business than accessing preallocated cache memory and a few MMIO
operations then converting them to raw spinlocks should have no real
impact on RT.

One way to do that is obviously starting with the patch from Vladimir
and then convert them one by one, so the assumption that they are not
doing anything nasty (in the RT sense) can be validated.

Thanks,

        tglx
