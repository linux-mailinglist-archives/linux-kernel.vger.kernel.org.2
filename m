Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A99D3940DD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhE1K3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235972AbhE1K3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 06:29:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:27:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so4209778pjp.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hcEHP5lbyUaIDoAJdZRGuAuvH9SN0j6HsI/OD+kTgf8=;
        b=Ern2TC5DD/zOgm1HTsmKET7+vQygjHf+XZmiWrvA3JZWIP3Gal6cQiZBInx3/enbTB
         yWRcq0jwzlWK5BS8LBAECwZ9+AH5TJY9l1Z5BeqiLRTdd96BaPkkv6pw7qPw5obglH9A
         zPaifVDJqu0OlnEt2vciqn7HOESVDgpaefUSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hcEHP5lbyUaIDoAJdZRGuAuvH9SN0j6HsI/OD+kTgf8=;
        b=RS0hgCQEwT9bpudHCKSxoMVGiYYWhlJO5izZUI8ELF6VRmlxM0TiplwlM0QmGltx1x
         7owHYip2Mc6fLNLo2RusOoVvYR5ulTEcFlBb74TfzC/SL/sLHTrNT+XUgIciElbrUhwK
         vPfSAGfKarum+RAo2Gq+vUT48QTXrGfkOdCJ405k/UHf9kuqEVXX1oWHdPOScCxmkrNH
         XDk3jOQFC/deZGgrt9vqXfrXU4MpYW2JC2nILbDrkJOrDBcL6Vy9EvailbbDoJDMkIrU
         j0uT1uyogPs/5kopDe/abZgQI9V9cJL2Vk0wUic9hLVDG7Z+nTpEmOeROHMeVRmWpdR9
         hZwg==
X-Gm-Message-State: AOAM533QFxFQLlUk0LzJ7iHUo1NpNnLAyn5jrxt2kJqxSAQd/rKp51P9
        gYaDb+/mb8OiEurhivjQbN+97Q==
X-Google-Smtp-Source: ABdhPJyrvHQGd03xFvYWWLFEZL7c/6jXwPw7GphxisL5MQyYC79GqmhFLOh0ltDvn6Y6bGidAy+NMA==
X-Received: by 2002:a17:90a:5b17:: with SMTP id o23mr3578804pji.14.1622197668237;
        Fri, 28 May 2021 03:27:48 -0700 (PDT)
Received: from 96e513df87d1 ([124.170.34.40])
        by smtp.gmail.com with ESMTPSA id c16sm3965550pfd.206.2021.05.28.03.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 May 2021 03:27:47 -0700 (PDT)
Date:   Fri, 28 May 2021 10:27:41 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        chenjh@rock-chips.com
Subject: Re: [PATCH] regulator: fan53555: add back tcs4526
Message-ID: <20210528102737.GA418788@96e513df87d1>
References: <20210526162342.GA20@8bbba9ba63a4>
 <CAMdYzYpZoKs3P62j02RW-+5BEpqC9JL3apjucTWLWmvNFrOrCg@mail.gmail.com>
 <20210527105943.GA441@7698f5da3a10>
 <462b8d80447efb6c00e93704914169bceb5adc4d.camel@collabora.com>
 <YK+ZMdD+7uqQwCow@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+ZMdD+7uqQwCow@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

I have submiited the v2 patch. Thanks for the feedback too.

On Thu, May 27, 2021 at 02:05:53PM +0100, Mark Brown wrote:
> On Thu, May 27, 2021 at 08:51:27AM -0300, Ezequiel Garcia wrote:
> > On Thu, 2021-05-27 at 10:59 +0000, Rudi Heitbaum wrote:

> > > +       /delete-property/ operating-points-v2;

> > Removal of the operating points kind of makes the gpu regulator moot,
> > don't you think?

> It's still better to say what the supply is even if it can't be
> changed - that stops you getting warnings about substituting in a
> dummy regulator and allows the consumer to read the current state
> of the regulator in case that's useful.

I'll look into this.
Thank you all for the feedback and direction on the dts.

> > > +???????????????regulator-compatible = "fan53555-reg";
> 
> > I can be wrong, but I think regulator-compatible is deprecated.
> 
> Yes.

will action

> > > +???????????????regulator-boot-on;
> 
> > Just out of curiosity, is regulator-boot-on really needed for the GPU?
> 
> It should only be used if it's not possible to read the state of
> the regulator enable from the hardware.

will do further testing
