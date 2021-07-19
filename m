Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDCB3CCBE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 03:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhGSBGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 21:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbhGSBGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 21:06:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13ECC061762;
        Sun, 18 Jul 2021 18:03:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s18so17372984pgg.8;
        Sun, 18 Jul 2021 18:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MRCpTY3XLrkorIsL4Kd4E8S+WPJpKt1Ijbch/c1mGOQ=;
        b=pLeL5RFZQiIgbIb2XQoVgv8uvI77if3Uj5JFRnwbFAlDIvZ6DVgb92hr749pQ3rTu4
         K+f0/0I4BhRB6RAOIgcb/034/r0I4L92qWznyCKnSYv0bSWd3avYuiP3x9Pj7M/f/XE9
         FL32Zw3JcnHg3kbmeSxIsYKbxIliwRd0I4BJKdK7GQXPnCaL3cZNlxgquVE+IZ6XGiJC
         mjU8+GyNBkCPgX4p7j1zrXrC1VtK9MhqMyXKAjZI3MrFH010qXXWoLeGb57IW3N78jyF
         VA8LVoj3pNz/5+vt23j0jLm2coyI4xHbbHhPlMp/DX/dsSYDUL3tvqVaIOTGoDKxaYIU
         TP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MRCpTY3XLrkorIsL4Kd4E8S+WPJpKt1Ijbch/c1mGOQ=;
        b=F+WwGi3Ij6/+Fn0qvtOZxuVb3xdixjhkYaUbfPBcXgCEs84xnYQ57eIM41S17NXjB6
         2QHM+9LKAXBmd2kZ/26V4ITKatpyZklvSFdx9OjNrTI5ZG6IoOiub6wh4ywItXMm9da3
         z4wtGf0ElKnxe9NMXvwJe6z2+LLnWwq8IpYlUtC3a/VwU7UyJMRQmnB+s+8baUr9hNEL
         AO3gB6h5MZuN43rto+ArbZhbafAD1iZLA2AbkWssXqB571mZz4XUbpEZgwVX8F6rhL17
         UzMuxm1zkFyoHdq8zCYhg2a6kTSn9ce9PVuMCT1dSsw9Dw3ZRHx1C+x1JWXWraBg7t7Z
         ikuA==
X-Gm-Message-State: AOAM5300L+23iT3tNtgANM1Gw2y3AyyRmSGCrz6KvkMp7pnnxK3Db60z
        VbSaJgbT0FMbMYEsSDvkbFE=
X-Google-Smtp-Source: ABdhPJzrBWV4/Ba2hzqbP4/NkJLwwHvjBXXwfmNYZnM46wPk4JxF6EfjTOKcrVuXzaMYqz1kTACCcg==
X-Received: by 2002:a65:6217:: with SMTP id d23mr22426920pgv.105.1626656633335;
        Sun, 18 Jul 2021 18:03:53 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91 (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id il13sm11365330pjb.7.2021.07.18.18.03.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Jul 2021 18:03:53 -0700 (PDT)
Date:   Sun, 18 Jul 2021 18:03:46 -0700
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Tao Ren <taoren@fb.com>
Subject: Re: [PATCH 0/4] ARM: dts: aspeed: Enable ADC for wedge100 BMC
Message-ID: <20210719010346.GA6817@taoren-ubuntu-R90MNF91>
References: <20210719001724.6410-1-rentao.bupt@gmail.com>
 <CACPK8Xdgp50KbVvhSbhrwUiTB6MJ5PoBzV9n18ubZAAOprOGiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8Xdgp50KbVvhSbhrwUiTB6MJ5PoBzV9n18ubZAAOprOGiw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:21:20AM +0000, Joel Stanley wrote:
> On Mon, 19 Jul 2021 at 00:17, <rentao.bupt@gmail.com> wrote:
> >
> > From: Tao Ren <rentao.bupt@gmail.com>
> >
> > The patch series enables ADC for Facebook Wedge100 BMC platform.
> >
> > Patch #1 enables ADC in Facebook AST2400 common dtsi because ADC is used
> > on all the Facebook AST2400 Network BMC platforms.
> >
> > Patch #2 removes the redundant ADC entry from Wedge40 dts.
> >
> > Patch #3 removes the redundant ADC entry from Galaxy100 dts.
> >
> > Patch #4 enables the ADC voltage sensoring channels in Wedge100 dts.
> 
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> 
> Thanks Tao, I will apply these for v5.15.

Thanks Joel!


Cheers,

Tao
