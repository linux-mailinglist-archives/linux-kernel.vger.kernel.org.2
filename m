Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7DD328048
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhCAOIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:08:00 -0500
Received: from mout01.posteo.de ([185.67.36.65]:56351 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234389AbhCAOHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:07:14 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 298DD160061
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 15:06:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1614607574; bh=P/n0/GTf5ttMdaVwkEGnOKWl5yd5jMp5SfQxZ+33fVw=;
        h=Date:From:To:Cc:Subject:From;
        b=VS496EfUUVKLLK/uAmbqb/CcCVOEyFGMJz/95UdloTNXe6dMly/I7Ujdji4jxkB+B
         kt367YYh/kTQyUOCCARO0CvFhqoxsSHJd81Jm0QgAhUWSDTM5GbQvnWFlh+IfypJaZ
         eDjgpFkP8xlj7T4Z0Yusq2cH8j/KGSTZCPwZ1cydqQmK6QJ4KXjwR4Y96ODxE3CjST
         yzrVSOR6HSVkQXO4Rs37psfj5gs6Zh/0T7COv0TdK6kCz6aEngx6sq6rBGGF3cWmrC
         4zzdViO8H7YnJh+TFul5yc5c3i8/IdPrkcrEiuuGPR7QQ6cpBPLa6IgBv0aeq/LvSx
         gvmfwFR6Ylu8g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Dq29c2jVlz6tmM;
        Mon,  1 Mar 2021 15:06:12 +0100 (CET)
Date:   Mon, 1 Mar 2021 15:06:08 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210301150608.014b807b@monster.powergraphx.local>
In-Reply-To: <20210301131305.wrsonoqwcm6ua2e2@hendrix>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
        <d7c7bb2adac0ad9171a407b29b33b384724172ab.1614430467.git.wilken.gottwalt@posteo.net>
        <20210301131305.wrsonoqwcm6ua2e2@hendrix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 14:13:05 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Sat, Feb 27, 2021 at 02:03:54PM +0100, Wilken Gottwalt wrote:
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

Nope, I had to replace the devm_hwspin_lock_register function by the
hwspin_lock_register function because like Bjorn pointed out that it can
fail and needs to handled correctly. And having a devm_* function does not
play well with the non-devm clock/reset functions and winding back if an
error occurs. It also messes with the call order in the remove function. So
I went back to the classic way where I have full control over the call order.

> Didn't I review this one already?
> Maxime
