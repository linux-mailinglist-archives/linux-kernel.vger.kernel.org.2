Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AB03184FB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 06:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBKFkg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 11 Feb 2021 00:40:36 -0500
Received: from mailoutvs34.siol.net ([185.57.226.225]:47598 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229467AbhBKFkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 00:40:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id BBBF7522F77;
        Thu, 11 Feb 2021 06:39:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zympFg3kgA5V; Thu, 11 Feb 2021 06:39:46 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 71452521B94;
        Thu, 11 Feb 2021 06:39:46 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 754F6522B31;
        Thu, 11 Feb 2021 06:39:43 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <maxime@cerno.tech>, mturquette@baylibre.com,
        Stephen Boyd <sboyd@kernel.org>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Andre Heider <a.heider@gmail.com>
Subject: Re: [PATCH v3 1/5] clk: sunxi-ng: mp: fix parent rate change flag check
Date:   Thu, 11 Feb 2021 06:39:43 +0100
Message-ID: <44806885.xO3ZHcXyXd@jernej-laptop>
In-Reply-To: <161301048085.1254594.6786751472945742937@swboyd.mtv.corp.google.com>
References: <20210209175900.7092-1-jernej.skrabec@siol.net> <20210210102904.xyr6bftn4ueuu74z@gilmour> <161301048085.1254594.6786751472945742937@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 11. februar 2021 ob 03:28:00 CET je Stephen Boyd napisal(a):
> Quoting Maxime Ripard (2021-02-10 02:29:04)
> 
> > Hi Mike, Stephen,
> > 
> > On Tue, Feb 09, 2021 at 06:58:56PM +0100, Jernej Skrabec wrote:
> > > CLK_SET_RATE_PARENT flag is checked on parent clock instead of current
> > > one. Fix that.
> > > 
> > > Fixes: 3f790433c3cb ("clk: sunxi-ng: Adjust MP clock parent rate when
> > > allowed") Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > Tested-by: Andre Heider <a.heider@gmail.com>
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > This is a last minute fix for us, can you merge it into clk-fixes
> > directly?
> > 
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> 
> It's also fixing a problem that's been around since v5.0. Is something
> broken that needs fixing this late? The motivation could be added to the
> commit text because right now it looks like a typo fix spotted visually.

Yes, it's needed. Without this patch, 4k@60 doesn't work and probably some 
other resolutions too. That's why it's send with other display related fixes. 
This is part of solution for longstanding display issues.

Best regards,
Jernej



