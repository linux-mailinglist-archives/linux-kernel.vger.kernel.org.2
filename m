Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0731FF7A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 20:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBSTds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 14:33:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBSTdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 14:33:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F062464E86;
        Fri, 19 Feb 2021 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613763185;
        bh=OlYQXP3dqUSDbZmjknWzUSYSrE2pfvSs23Pmh52NLO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EVe8nd7JPREE3C1UU+aIlturXg9562K6GlwwviEhDVmKyzEJyJ6fqQHXTDZ+eSVHy
         UG5OWZ5Lq8akMmYR3MLrw/uOYZBZ0+zAfjswKwhi4ZbsZHaP7HXN0t+c2AdDYGo7et
         Tm2itE3aFZCpDaHBZKS8UQVMr1CLn/VAQklBGp6v0ZfVhsp35SCeV6iqi6FiNnQh6d
         LLifGbx4rNxbio8mIA5lQRLZrLwiQrgbR3n6NU9i6nOnim4fd8DAkzVrYBWS5PckBz
         OQLsqqlKO2xhxyJX4Dy9ljZ52bkZgC6qIPIkLGVoht0tX1xrCO7PQUiccSPR4yR6Ws
         6oKwfJUuuEuxw==
Received: by pali.im (Postfix)
        id B29157F6; Fri, 19 Feb 2021 20:33:02 +0100 (CET)
Date:   Fri, 19 Feb 2021 20:33:02 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     nnet <nnet@fastmail.fm>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, a.heider@gmail.com,
        andrew@lunn.ch, gerald@gk2.net, gregory.clement@bootlin.com,
        kostap@marvell.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        luka.perkov@sartura.hr, miquel.raynal@bootlin.com,
        mturquette@baylibre.com, rmk+kernel@armlinux.org.uk,
        sboyd@kernel.org, tmn505@gmail.com, vladimir.vid@sartura.hr
Subject: Re: [PATCH mvebu v2 00/10] Armada 37xx: Fix cpufreq changing base
 CPU speed to 800 MHz from 1000 MHz
Message-ID: <20210219193302.odcjcaukxxjaedd5@pali>
References: <20210211195559.n2j4jnchl2ho54mg@pali>
 <1ad78446-4a40-4c3e-8680-6dbf19616515@www.fastmail.com>
 <20210211234445.hbv2diphmgbir76u@pali>
 <000b92cc-9b54-4af9-b95c-d1317fb6f97f@www.fastmail.com>
 <20210213100139.ckrscepg72zjkj4f@pali>
 <c0b02aa0-1789-43a3-8d73-057890f703f1@www.fastmail.com>
 <20210214123310.d6armpep7kxbymbu@pali>
 <675b7a74-066b-4dc0-8dcb-f11c5606ae52@www.fastmail.com>
 <20210216104141.umy6zrrkal3dlj5j@pali>
 <d057d7f7-27a5-45ec-88f0-a653572a8ca6@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d057d7f7-27a5-45ec-88f0-a653572a8ca6@www.fastmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 February 2021 08:27:10 nnet wrote:
> > Therefore I'm thinking if the correct way is instead to use L1 := L0 voltage value for 1/1.2 GHz mode.
> 
> This latest 04/10 works fine for me going 600MHz <-> 1.2GHz under with and without load.

Ok, thanks for testing! Just to note that typical documented value for
1.2GHz mode is 1.155V, so it would be useful to know if this value could
be stable for L1 with 1.2GHz mode.

I'm thinking that for 1GHz variant it would be better to rather use
1.108V like in my original patch as this is already tested by lot of
people, nobody complained yet and it can be lower value as L0 (so there
is benefit to decrease CPU frequency when CPU is idle).

For 1.2GHz variant I still do not know. You wrote that 1.132V is
unstable, so it cannot be used for sure. Documented typical value 1.155V
is bigger, so maybe it can be stable but needs testing. And stable seems
to be L0 value... But then I do not see a benefit for downclocking CPU
from 1.2 GHz frequency in L0 to 600 MHz freq. in L1 if it use same CPU
voltage... But it is still better than unstable CPU with crashes!

Could you test if 1.155V voltage for L1 is stable on 1.2 GHz variant?
