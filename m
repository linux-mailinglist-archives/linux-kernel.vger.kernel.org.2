Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B134304FF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhA0DgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbhAZVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:42:38 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A76C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:41:52 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p21so19658534lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 13:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/Vi9m5vDMcQhvtdSeiGhhy16BWAAWglEKpVzpaRcYQ=;
        b=AtJkZ20qGRwi9S0UDfhqoa7TJyTIqEhQqHKaFxXetsRDyJw7snT2DYWLAL8y3Jm1fK
         8C27Ht+/w0HXxp/Qz2z4ZJguX+fskzgX4IrQE/GxkEnpTFmsuo/v+hGAU/DvUtGrAk7T
         +Z/UypBIiEP++3KjJX+K81vHgQakOJ9t2lbFzANhGpC+2cYAhcjNPfasplpJ2WBpNybS
         hC0LkzRKZO+dVkspFwwcE6dRkkpQzQADHnPvL+nJ0Rx2dMBIAIVC0jLEo1OvSWmuY3Hk
         QjSFVrjEO93Iug0QIjh9Edh07GwToqjo6JTHuhsQegC6G2sE4UFZvMeHVME4g5yV+uON
         NUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/Vi9m5vDMcQhvtdSeiGhhy16BWAAWglEKpVzpaRcYQ=;
        b=tOthoXmqS5yTCdy9ZNSZELtZR2EBif2inuvpqZKZPSXS6wPaTZDu1BbcnZiGnLec+Y
         kv4+zd96U3a311Cb9n5PrhX1xWXSFSUmMrZqynTPJ9MKtaLGIJh9E2FT1cJhv2pPGCxS
         4liViPXXBGdMmTsGwJyUpI6etjCcDadJ7chtaeaW6wWN/y5hEVSrv20G7yJ1OgtUwBTS
         PseiTefyQ2t4cQWpGBU+Yh7NGIlU2xrBFiwm2bERu4Q6pH+OWe/2cvmDOiyk98kM9mKt
         O7FADKW7daOMb00FvDZ/tcOd38k2lqorGIQHIXiNoJDvysgpMK/xonK+Pm7Kou/P3M8F
         0qhw==
X-Gm-Message-State: AOAM531vzZ9eUa6lWIIib4+JnDant8aKyq8Q7lOVTCyAP7yY1W+kPFjL
        vcGwii8uWcZX7kYwkSEq6q0wZ23orZ8JMRyGrK9rrA==
X-Google-Smtp-Source: ABdhPJy9O3Rh3trgW57Sya7HyNwF6MpmRA7IxNBkApJqiFErZigh7ASuWSthGIIX4/4DO434vbFXPW+mxmDDrI03n7Y=
X-Received: by 2002:a19:3849:: with SMTP id d9mr1676584lfj.157.1611697310713;
 Tue, 26 Jan 2021 13:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20210125045631.2345-1-lorenzo.carletti98@gmail.com> <20210125045631.2345-2-lorenzo.carletti98@gmail.com>
In-Reply-To: <20210125045631.2345-2-lorenzo.carletti98@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Jan 2021 22:41:39 +0100
Message-ID: <CACRpkdZE4ktDosOU=xxt9XG7L8Bf=y0ahHcifjEO6K8B3AutTg@mail.gmail.com>
Subject: Re: [PATCH 1/1] net: dsa: rtl8366rb: standardize init jam tables
To:     Lorenzo Carletti <lorenzo.carletti98@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 5:56 AM Lorenzo Carletti
<lorenzo.carletti98@gmail.com> wrote:

> In the rtl8366rb driver there are some jam tables which contain
> undocumented values.
> While trying to understand what these tables actually do,
> I noticed a discrepancy in how one of those was treated.
> Most of them were plain u16 arrays, while the ethernet one was
> an u16 matrix.
> By looking at the vendor's droplets of source code these tables came from,
> I found out that they were all originally u16 matrixes.
>
> This commit standardizes the jam tables, turning them all into
> u16 matrixes.
> This change makes it easier to understand how the jam tables are used
> and also makes it possible for a single function to handle all of them,
> removing some duplicated code.
>
> Signed-off-by: Lorenzo Carletti <lorenzo.carletti98@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
