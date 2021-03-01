Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DF9328052
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbhCAOJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:09:25 -0500
Received: from mout01.posteo.de ([185.67.36.65]:58043 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234950AbhCAOHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:07:36 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 733EE16005C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 15:06:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1614607599; bh=K44YApsqHwvMN5i7Ti1VW/ra08Wa2N37xaxS1NrZsng=;
        h=Date:From:To:Cc:Subject:From;
        b=ZH6bEtXsI9dY7pBozT4GAD9CZqaYSnsQ0R7ZUrWTfQ1ZtolYW0PjOkFoUBDZo7fyo
         30NpexvTtJeuizzMtPNoWNGeGmMpima4BQogCfvM2hlqQXQFc5KeMv8NmwjyIKYAjJ
         OIXf2u0KwSC9ktbodYht5FqrRkeqcKVpJNTNj4wdDaZSCWivs4wVZVSFqt2veNz1oq
         Pjsdu0Krx/RPayf1OMviBmeQH1ExOdtDg79WwDaaUW36gkYIKnzMzHs8o3si2nosFG
         ldv9YSY47pM4G9n/yw4nWiZlo7GdF1w64VKP4mXZ+95/hYHL4tG9bM5sTT+03uAwPP
         zR2h5LsmIWwAw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Dq2B515LJz6tmr;
        Mon,  1 Mar 2021 15:06:37 +0100 (CET)
Date:   Mon, 1 Mar 2021 15:06:35 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210301150635.480934a8@monster.powergraphx.local>
In-Reply-To: <20210301131244.otn7vzhgstufjts2@hendrix>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
        <98f75101bbd7d6637aa596a9f43d0ea6372e57c8.1614430467.git.wilken.gottwalt@posteo.net>
        <20210301131244.otn7vzhgstufjts2@hendrix>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2021 14:12:44 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Sat, Feb 27, 2021 at 02:03:28PM +0100, Wilken Gottwalt wrote:
> > Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> > compatible series SoCs.
> >
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > ---
> > Changes in v6:
> >   - fixed formating and name issues in dt documentation
> >
> > Changes in v5:
> >   - changed binding to earliest known supported SoC sun6i-a31
> >   - dropped unnecessary entries
> >
> > Changes in v4:
> >   - changed binding to sun8i-a33-hwpinlock
> >   - added changes suggested by Maxime Ripard
> >
> > Changes in v3:
> >   - changed symbols from sunxi to sun8i
> >
> > Changes in v2:
> >   - fixed memory ranges
> > ---
> >  .../hwlock/allwinner,sun6i-hwspinlock.yaml    | 45 +++++++++++++++++++
> 
> The name of the file doesn't match the compatible, once fixed:
> Acked-by: Maxime Ripard <mripard@kernel.org>

This is something that still confuses me. What if you have more than one
compatible string? This won't be solvable. See the qcom binding for example,
there are two strings and none matches. In the omap bindings are also two
strings and only one matches. In all cases, including mine, the bindings
check script is fine with that.

So, you basically want it to be called "allwinner,sun6i-a31-hwspinlock.yaml"?

Sorry if I come up with this, but I don't want to just do it, I want to
understand it.

> Maxime

