Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83055327F40
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 14:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbhCANQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 08:16:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235500AbhCANNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:13:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A6864E22;
        Mon,  1 Mar 2021 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614604388;
        bh=7VQhDQHBN69eYudYHQ45S6nSPODMEqDA9oTA2ks0k84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZF28LG/JYAVNOczO0ZBbuPPmbMa7fPuYGu+Bip9RKfHDJUYFIXZjsweYBgSJUUkJP
         L+roho3iN1cTjv94tLIzHvxwNU0JnTJSTCRpnZHCZwxVCas8srkVObI5tiGnflbomN
         Jdv+jZYWgIPoz0unGoApdYCMKAIz1Qh/JrMgFXJQy8yDOxJaBsrrBaeNovuqtQKfWA
         KWZXtwUg5kGLtvUrUKwbQF6oil+J0Hom/K7CCRshQcgQo2BtT4Dewu0zMs0XV3ebWy
         j8GQydQf8U9yPTLInP6U6yAkRg7avel6w1NAdSggKF1bdmSAdaUUPWCr97WF0KG49A
         BUvfR1BpvLysw==
Date:   Mon, 1 Mar 2021 14:13:05 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 2/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210301131305.wrsonoqwcm6ua2e2@hendrix>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
 <d7c7bb2adac0ad9171a407b29b33b384724172ab.1614430467.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7c7bb2adac0ad9171a407b29b33b384724172ab.1614430467.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 27, 2021 at 02:03:54PM +0100, Wilken Gottwalt wrote:
> Adds the sun6i_hwspinlock driver for the hardware spinlock unit found in
> most of the sun6i compatible SoCs.
>
> This unit provides at least 32 spinlocks in hardware. The implementation
> supports 32, 64, 128 or 256 32bit registers. A lock can be taken by
> reading a register and released by writing a 0 to it. This driver
> supports all 4 spinlock setups, but for now only the first setup (32
> locks) seem to exist in available devices. This spinlock unit is shared
> between all ARM cores and the embedded companion core. All of them can
> take/release a lock with a single cycle operation. It can be used to
> sync access to devices shared by the ARM cores and the companion core.
>
> There are two ways to check if a lock is taken. The first way is to read
> a lock. If a 0 is returned, the lock was free and is taken now. If an 1
> is returned, the caller has to try again. Which means the lock is taken.
> The second way is to read a 32bit wide status register where every bit
> represents one of the 32 first locks. According to the datasheets this
> status register supports only the 32 first locks. This is the reason the
> first way (lock read/write) approach is used to be able to cover all 256
> locks in future devices. The driver also reports the amount of supported
> locks via debugfs.
>
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Didn't I review this one already?
Maxime
