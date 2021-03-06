Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E33C32F996
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhCFLGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:06:02 -0500
Received: from mout01.posteo.de ([185.67.36.65]:50009 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhCFLFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:05:31 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 89441160062
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 12:05:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1615028725; bh=3lFsvNtqRkWfrCAk8Np/tkLZyeQIHcNn7r2wpS+Xo3c=;
        h=Date:From:To:Cc:Subject:From;
        b=on7iB8Bd3E91URtkUt4SRZyPvLDYECX0RnDm/ThuS5QhbdzliUZaEKvSbL1+A7raw
         dJAhOa+q6BRA0F9ijVOTmI5Q7/XpliLJi3oc95uO5yQWU39jyIgQ+tlEfOpvwhFJZt
         CKAiHdgmSo4ANAdldpOItdZ4qEqlDtbxeWJrWVkK+A38jNgmSujnQkM5fo+0JU7PIG
         G/xAGZJdp3qN9DhJ1js10XU2xTSpalGRJAclDH6V65eDZEavHLz/qFlfi9+/Ha0x/M
         coAnIBiF0MSwvCu6fmjvHcCAt9Y2WJqrKkA2GgPxuaTp8vb9Irma0urTZdTeKVmwQq
         k08H1YK56LAMw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Dt1wg5Ch7z6tm6;
        Sat,  6 Mar 2021 12:05:23 +0100 (CET)
Date:   Sat, 6 Mar 2021 12:05:22 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210306120522.7e8f98e5@monster.powergraphx.local>
In-Reply-To: <20210302172002.4yygufnrmrbultk5@gilmour>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
        <d7c7bb2adac0ad9171a407b29b33b384724172ab.1614430467.git.wilken.gottwalt@posteo.net>
        <20210301131305.wrsonoqwcm6ua2e2@hendrix>
        <20210301150608.014b807b@monster.powergraphx.local>
        <20210302172002.4yygufnrmrbultk5@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 18:20:02 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> Hi,
> 
> On Mon, Mar 01, 2021 at 03:06:08PM +0100, Wilken Gottwalt wrote:
> > On Mon, 1 Mar 2021 14:13:05 +0100
> > Maxime Ripard <mripard@kernel.org> wrote:
> > 
> > > On Sat, Feb 27, 2021 at 02:03:54PM +0100, Wilken Gottwalt wrote:
> > > > Adds the sun6i_hwspinlock driver for the hardware spinlock unit found in
> > > > most of the sun6i compatible SoCs.
> > > >
> > > > This unit provides at least 32 spinlocks in hardware. The implementation
> > > > supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> > > > reading a register and released by writing a 0 to it. This driver
> > > > supports all 4 spinlock setups, but for now only the first setup (32
> > > > locks) seem to exist in available devices. This spinlock unit is shared
> > > > between all ARM cores and the embedded companion core. All of them can
> > > > take/release a lock with a single cycle operation. It can be used to
> > > > sync access to devices shared by the ARM cores and the companion core.
> > > >
> > > > There are two ways to check if a lock is taken. The first way is to read
> > > > a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> > > > is returned, the caller has to try again. Which means the lock is taken.
> > > > The second way is to read a 32bit wide status register where every bit
> > > > represents one of the 32 first locks. According to the datasheets this
> > > > status register supports only the 32 first locks. This is the reason the
> > > > first way (lock read/write) approach is used to be able to cover all 256
> > > > locks in future devices. The driver also reports the amount of supported
> > > > locks via debugfs.
> > > >
> > > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > 
> > Nope, I had to replace the devm_hwspin_lock_register function by the
> > hwspin_lock_register function because like Bjorn pointed out that it can
> > fail and needs to handled correctly. And having a devm_* function does not
> > play well with the non-devm clock/reset functions and winding back if an
> > error occurs. It also messes with the call order in the remove function. So
> > I went back to the classic way where I have full control over the call order.
> 
> If you're talking about the clock and reset line reassertion, I don't
> really see what the trouble is. Sure, it's not going to be in the exact
> same order in remove, but it's still going to execute in the proper
> order (ie, clock disable, then reset disable, then clock put and reset
> put). And you can use devm_add_action if you want to handle things
> automatically.

See, in v5 zje result of devm_hwspin_lock_register was returned directly. The
remove callback or the bank_fail/clk_fail labels would not run, if the registering
fails. In v6 it is fixed.

+	platform_set_drvdata(pdev, priv);
+
+	return devm_hwspin_lock_register(&pdev->dev, priv->bank, &sun6i_hwspinlock_ops,
+					 SPINLOCK_BASE_ID, priv->nlocks);
+bank_fail:
+	clk_disable_unprepare(priv->ahb_clk);
+clk_fail:
+	reset_control_assert(priv->reset);
+
+	return err;
+}

So, is v6 fine for you even if it uses a more classic approach?

greetings,
Will
