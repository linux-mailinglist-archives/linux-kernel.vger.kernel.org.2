Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D928D3DB373
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhG3GVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhG3GVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:21:49 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D519C061765;
        Thu, 29 Jul 2021 23:21:45 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id f11so10117793ioj.3;
        Thu, 29 Jul 2021 23:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jRTUEqbao4IoCd5MtQKnQeYXbNJraxqvBMtXhFY36g=;
        b=gn1ZuNQTiAX0wweGCWpGvaj+Kd7Cbh3c/JrHfJZ7Cv/lictBPpSuKOpZ8ieth2Q3ZS
         eTL1CZzZ81fD6FNISG8Iw68x/PSV0RcRD9dwVVj6vIOoGHQyzspyKnyQhkqTYCPCQTEZ
         4TUvEQE9iaSjkGhJPL04urdQeD0OIkPboAPltuehaqFay7ZgkpAKZUPWr3V6JMCc5rhd
         hZEG+48qy6tF25a63zn1rOUL9fyUhXWWzajbrveujbG9RwF+tBFHc7qincjQqCuFYpK1
         sWG147T4R9Qm5M50Z0IuJdeefVpaqyYMGeJmgBm7LNIGSuzAWgsfAveMFgKpWCijc6R7
         edgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jRTUEqbao4IoCd5MtQKnQeYXbNJraxqvBMtXhFY36g=;
        b=udYPiMkrVFRVQZasPBUEeMRpmGT9TApzygYtaFjmcoa5azSaC98pAbmWqxW+DO76pF
         ByPZ0S2JdJ9n+xQCVAIdQLyVkq6+DFAIdJABSpzlYR7TskW5JuhkLQ7cl2nYSrDVlnoj
         GYKoePWQQfTlgGoJw8zMGHsEFz1mle5McsPyKk0ZrP9Q/vAKsYlyFjJbjpZZlbsGu2kg
         GT537hIcpsi8nu3gOLudtcM9tyeC/Hm7jUIUhm2dMLwJv1uiBCvbDXZDyxzTu3n4/uqd
         fGAJdM8Q1lOWoGfifqqa9Kq+asQQjSpA6wWIYST4SiuNbF3/D927HkB1cKgLaW+OEkAj
         pJCw==
X-Gm-Message-State: AOAM531jOKCek8sUvSN6J9vOrUOX1GCVv3DJ6Be2wWabtnDflYizGHKq
        Cboj7cuUa77SKBn+VQ2sdBFmfMViL6Hry94Oq7U=
X-Google-Smtp-Source: ABdhPJwmJ4MnS45OOCpPvnsZIv/wX2oShFQBVukbf9XsGRae3NvLMx4rpHaQEi327sHAgLLUVN/kpMopD+hcVyfhMEc=
X-Received: by 2002:a6b:490d:: with SMTP id u13mr1148667iob.176.1627626104912;
 Thu, 29 Jul 2021 23:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210708115804.212-1-alistair@alistair23.me> <YPbjZdu7T9wFcvNz@google.com>
 <20210720152351.GC5042@sirena.org.uk> <YPb1Hs0EoZ1MikuX@google.com> <20210720202639.GE5042@sirena.org.uk>
In-Reply-To: <20210720202639.GE5042@sirena.org.uk>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Fri, 30 Jul 2021 16:21:18 +1000
Message-ID: <CAKmqyKNUBzWuLSvLTqaCNhDpuficctvCgpk3ZEBVFuKeCrx86w@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] mfd: sy7636a: Initial commit
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alistair Francis <alistair@alistair23.me>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 6:26 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 20, 2021 at 05:09:02PM +0100, Lee Jones wrote:
> > On Tue, 20 Jul 2021, Mark Brown wrote:
>
> > > At least the regulator probably shouldn't be - this is just a Linux
> > > specific grouping of devices, it's not really directly a block in the
> > > hardware in a way that's platform independent.
>
> > I've seen (and authored) regulator support in DT before.
>
> > What's changed?  They're controlled by registers, right?
>
> Nothing's changed, I routinely push back on regulator drivers that have
> a compatible string for a MFD subfunction like this.  I do miss them
> sometimes but try not to.

Sorry, I just want to clarify what I should do.

Are you saying that I shouldn't add the regulator to the device tree?
Should I leave it as part of `sy7636a_cells` then?

Alistair

>
> > Is the problem that the registers are usually split?
>
> It's just not really describing the hardware, it's encoding the way
> Linux splits things up into the DT that adds no descriptive information.
> We're not getting any information about where the IPs are in the device
> or anything from the compatible, and typically it's describing a set of
> disjoint IPs with minimal overlap in their configuration.  If it's a
> binding for something like an individual LDO or DCDC and we've got
> multiple instances of that within a single chip then it starts to get
> more useful but that's not what something like this is doing.  We're not
> gaining anything by putting a compatible string in there, all it does is
> make the DT bigger and add some ABI.
>
> Similar issues exist with CODEC subfunctions - those are usually
> describing huge piles of different IPs but we happen to want to pull
> them together for Linux, typically including some clocking which if we
> were going down to the level of describing components of the MFD in the
> DT should be being described using their own bindings.
