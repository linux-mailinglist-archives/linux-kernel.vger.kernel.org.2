Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E0C32F9A3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 12:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCFLHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 06:07:38 -0500
Received: from mout02.posteo.de ([185.67.36.66]:34235 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230413AbhCFLHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 06:07:07 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id C1CE52400FE
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 12:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1615028823; bh=YerMKm7F3oyRKPJToY5a9OhMY3r1cZ8DGu6Xeydaolo=;
        h=Date:From:To:Cc:Subject:From;
        b=ehV7IdPgi7u4coVZR1fF3QitbmDg2G1NsdZbN5kVurZSK0/584dhOYJBHS91Ljocb
         7dOIG8QATaI7wpoveGncIRkKpmIfrG4Lv7oF1rnF/nWSfhhklsge34l0LZ71G75rHF
         YxzTRgtKiloWVDtgSvYBByoJwEt8tnbfLR9DVi44PbJCIFMkVi4UgJOrEGKosTbQmH
         1KAB1Ej2ecsQ4TOPFgDk7QcbH7qrblX0BxMxl9Qxx5XYRCj/I9H+Ia4RpyQN/8SmhO
         YwZSn8AOaO66jR8+7/GpkZRI5Cm/SdYg4nXFKERF4mYc72i+PpjsrB/uLFkIsImIvJ
         pwJ1i0blC4nkQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Dt1yZ51GKz6tmJ;
        Sat,  6 Mar 2021 12:07:02 +0100 (CET)
Date:   Sat, 6 Mar 2021 12:07:02 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v6 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <20210306120702.4d347663@monster.powergraphx.local>
In-Reply-To: <20210302172233.yn6iharipua5ykct@gilmour>
References: <cover.1614430467.git.wilken.gottwalt@posteo.net>
        <98f75101bbd7d6637aa596a9f43d0ea6372e57c8.1614430467.git.wilken.gottwalt@posteo.net>
        <20210301131244.otn7vzhgstufjts2@hendrix>
        <20210301150635.480934a8@monster.powergraphx.local>
        <20210302172233.yn6iharipua5ykct@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2021 18:22:33 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

> On Mon, Mar 01, 2021 at 03:06:35PM +0100, Wilken Gottwalt wrote:
> > On Mon, 1 Mar 2021 14:12:44 +0100
> > Maxime Ripard <mripard@kernel.org> wrote:
> > 
> > > On Sat, Feb 27, 2021 at 02:03:28PM +0100, Wilken Gottwalt wrote:
> > > > Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
> > > > compatible series SoCs.
> > > >
> > > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> > > > ---
> > > > Changes in v6:
> > > >   - fixed formating and name issues in dt documentation
> > > >
> > > > Changes in v5:
> > > >   - changed binding to earliest known supported SoC sun6i-a31
> > > >   - dropped unnecessary entries
> > > >
> > > > Changes in v4:
> > > >   - changed binding to sun8i-a33-hwpinlock
> > > >   - added changes suggested by Maxime Ripard
> > > >
> > > > Changes in v3:
> > > >   - changed symbols from sunxi to sun8i
> > > >
> > > > Changes in v2:
> > > >   - fixed memory ranges
> > > > ---
> > > >  .../hwlock/allwinner,sun6i-hwspinlock.yaml    | 45 +++++++++++++++++++
> > > 
> > > The name of the file doesn't match the compatible, once fixed:
> > > Acked-by: Maxime Ripard <mripard@kernel.org>
> > 
> > This is something that still confuses me. What if you have more than one
> > compatible string?
> 
> In this case, it's fairly easy there's only one :)
> 
> But we're following the same rule than the compatible: the first SoC
> that got the compatible wins 
> 
> > This won't be solvable. See the qcom binding for example,
> > there are two strings and none matches. In the omap bindings are also two
> > strings and only one matches. In all cases, including mine, the bindings
> > check script is fine with that.
> 
> If other platforms want to follow other rules, good for them :)
> 
> > So, you basically want it to be called
> > "allwinner,sun6i-a31-hwspinlock.yaml"?
> 
> Yes

Is it okay if I provide only the fixed bindings? I assume the v6 driver is
fine now.

greetings,
Will
