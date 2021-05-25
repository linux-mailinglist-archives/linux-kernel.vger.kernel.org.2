Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197D7390634
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhEYQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:09:20 -0400
Received: from mout01.posteo.de ([185.67.36.65]:56637 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231810AbhEYQJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:09:19 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CEA41240026
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 18:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1621958867; bh=xt/SopiWlESxzNwmc3NPZy2Luzt/f001p+eAUG5rr1o=;
        h=Date:From:To:Cc:Subject:From;
        b=Y31x9xhfN0sByjHP/00JXAVZaR7cJ6bnNPAvuTQhZMkYSFCLRMyKIWZ8v526ml7Sy
         thD+/pZdqjA3JBEY+mqoTGeA7LtOftwtykJQAnYH6SOSdbwvvFyg4vV4+PfjvtwE0N
         +Fll5chsETJ5zl/qQQ76n0m/EKycg9VTLnmS0WNm63Zum1rOp9Wixbjl38zpJCaLe/
         i+PbYYKJ8QmGWH9VMbqicDSd58bK5jhxKMpu19e5YASM+bSolVpO6Z4cW4oLWh6hDD
         uysoo2n1knq8qMYo0W19J0Nl0C2iPlhSrwyMVB0ueZFJWLqPDRakVmflAfQmnuqifs
         CKrLNfA4LX2xA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4FqJrd28pDz6tmQ;
        Tue, 25 May 2021 18:07:45 +0200 (CEST)
Date:   Tue, 25 May 2021 16:07:44 +0000
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v7 0/2] hwspinlock: add sun6i hardware spinlock support
Message-ID: <20210525180744.24187bb1@monster.powergraphx.local>
In-Reply-To: <95e93676-cfcf-1aed-1741-d69b72286033@sholland.org>
References: <cover.1615713499.git.wilken.gottwalt@posteo.net>
        <95e93676-cfcf-1aed-1741-d69b72286033@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 23:33:31 -0500
Samuel Holland <samuel@sholland.org> wrote:

> On 3/14/21 4:30 AM, Wilken Gottwalt wrote:
> > Wilken Gottwalt (2):
> >   dt-bindings: hwlock: add sun6i_hwspinlock
> >   hwspinlock: add sun6i hardware spinlock support
> > 
> >  .../allwinner,sun6i-a31-hwspinlock.yaml       |  45 ++++
> >  MAINTAINERS                                   |   6 +
> >  drivers/hwspinlock/Kconfig                    |   9 +
> >  drivers/hwspinlock/Makefile                   |   1 +
> >  drivers/hwspinlock/sun6i_hwspinlock.c         | 210 ++++++++++++++++++
> >  5 files changed, 271 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
> >  create mode 100644 drivers/hwspinlock/sun6i_hwspinlock.c
> > 
> 
> Thanks for the very thorough testing!

So when will this end up in mainstream? Or do I have to somehing to get this
triggered? This is not my first driver and back then it was included into
mainline without anything special on my side. I'm a bit confused. Did I miss
something?

greetings,
Will

> For both patches:
> Reviewed-by: Samuel Holland <samuel@sholland.org>

