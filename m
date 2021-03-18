Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A69340765
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhCROHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:07:16 -0400
Received: from mout01.posteo.de ([185.67.36.65]:60718 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229745AbhCROG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:06:57 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id EE853160062
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 15:06:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1616076415; bh=L+TrlYsIZIC9UcHK7uCJaRSUZ6c2Z/GwHu8kU6KJLfo=;
        h=Date:From:To:Cc:Subject:From;
        b=hM15uqg6rA95wNqYDq6dOG7wi29YeD3FJZsGMFdRJi+bHikLrgtCeKDwlQ73Xm53c
         7NZeKg5XpoWyYwqzOZLxsYTraFt4wD9M4vEbK2UPa0bSumJW8W7Hk7r9y2Q/FKVmQ2
         OONon3mTeUFoEvVAin+LoiSzm7me+cp+YFGEETOA9MwkNPlc0jMhJtyxfreu79rHMC
         p8BjIhnCzP+srDYD3WTfCO/f9igVxFooeWRO3pdi/hGn4RJnic8q4HIHZSva/Bc488
         DwmTzgpy9iWmenoTJUV7tfkpGz+juxsO5agMsjkjDR2S58Qq13pAEG4yrbYOLecRor
         PISnJh/kfPgHQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4F1TNY0Rlcz6tmV;
        Thu, 18 Mar 2021 15:06:52 +0100 (CET)
Date:   Thu, 18 Mar 2021 15:06:52 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v7 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210318150652.6f961b38@monster.powergraphx.local>
In-Reply-To: <20210315161220.sxjkam7bqli5fk5y@gilmour>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
        <bfd2b97307c2321b15c09683f4bd5e1fcc792f13.1615713499.git.wilken.gottwalt@posteo.net>
        <20210315161220.sxjkam7bqli5fk5y@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 17:12:20 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> On Sun, Mar 14, 2021 at 10:31:13AM +0100, Wilken Gottwalt wrote:
> > Adds the sun6i_hwspinlock driver for the hardware spinlock unit found in
> > most of the sun6i compatible SoCs.
> > 
> > This unit provides at least 32 spinlocks in hardware. The implementation
> > supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> > reading a register and released by writing a 0 to it. This driver
> > supports all 4 spinlock setups, but for now only the first setup (32
> > locks) seem to exist in available devices. This spinlock unit is shared
> > between all ARM cores and the embedded companion core. All of them can
> > take/release a lock with a single cycle operation. It can be used to
> > sync access to devices shared by the ARM cores and the companion core.
> > 
> > There are two ways to check if a lock is taken. The first way is to read
> > a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> > is returned, the caller has to try again. Which means the lock is taken.
> > The second way is to read a 32bit wide status register where every bit
> > represents one of the 32 first locks. According to the datasheets this
> > status register supports only the 32 first locks. This is the reason the
> > first way (lock read/write) approach is used to be able to cover all 256
> > locks in future devices. The driver also reports the amount of supported
> > locks via debugfs.
> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> 
> Acked-by: Maxime Ripard <maxime@cerno.tech>

Ah nice ... totally forgot to thank you for the patience and steady reviews. :-)

> Maxime

