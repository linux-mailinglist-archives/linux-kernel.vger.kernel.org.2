Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03DF312B3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 08:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhBHHrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 02:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBHHrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 02:47:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D8DC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 23:46:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t142so9546154wmt.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 23:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VBGn5N2PWVERSgqsZWGAhtPQYhD6ApL/aUSxl/jARz0=;
        b=YSvY04+lbWpVcY6yhIfrL8hH2CaElLUp2Wak55sU1KF9bCYN3aFKyAcXp3mHY+l+Lg
         s/+0nRgueX9txsiPBvRb8X7gYyStdIW2+9pgPU54uB9kj+wQ8Pe7peHR4d0+8RSHsjMg
         611Yr/8YunIPAgZctApAmN6/c/OYxqmzka9/z+UDId1kKGWFH6bizaRkjNTFpO14LTov
         N2OVNjWCp0jS93m1fuZFtAEGhGy55G4Ialm96pywIXIgP6Gy6utDwD5FbtIKp7xCkwph
         VCS0VRgVhScdfwATb1XPFk0ddtBAfi3iisIZTQxa4ZH4ib3RUblxeMd1SRzGkDi/eqnS
         c/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VBGn5N2PWVERSgqsZWGAhtPQYhD6ApL/aUSxl/jARz0=;
        b=IwP7L7aGyT/1+KfszUbJXE1xWH64GS0nUGPEewEWLkmYyAXuSqCkf9HjWK9ZJjiCGN
         2wG5DRvmzh2SbqJwmqy38AnerYeFVfyJHOO71JvUTCFozvAdwNPOTtXzlhgfQqpgG98N
         VRcpx/0bSRTgIQsVG7xNVtk9lzHcwwx208dvZ+dBprviaCtEUOuYQBhs//b+iAZsvFzt
         golALCcmbjYkET83gQglVxRHI/azASNZpiCnX/gJiHPl1tmQQDcMgoLcXrF1ThLnCZpU
         H8E6+MjCWlXIaeTQ6fJh/sCkcmtRG9Y2KZOUspYpKv0MIr/w64PILaFhXrIgG92+lO/Z
         zZaQ==
X-Gm-Message-State: AOAM531ejuwM6nBp++foaO7mEsDwTBvDUxsAEr6Ba+hpTak8DJC1N73e
        jShoGxouKz4rImJDekvhIBb+4A==
X-Google-Smtp-Source: ABdhPJw1Jl2DWtfavvyRgL2esgSl11F6AVPlGcPbM33WLTZ8tF8QeDX0Zm4aP+QQQg79amGbGuy2GQ==
X-Received: by 2002:a1c:c6:: with SMTP id 189mr7096615wma.128.1612770393014;
        Sun, 07 Feb 2021 23:46:33 -0800 (PST)
Received: from trex (182.red-79-146-86.dynamicip.rima-tde.net. [79.146.86.182])
        by smtp.gmail.com with ESMTPSA id l1sm28039211wrp.40.2021.02.07.23.46.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Feb 2021 23:46:32 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Mon, 8 Feb 2021 08:46:31 +0100
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optee: simplify i2c access
Message-ID: <20210208074631.GA27508@trex>
References: <20210125113758.2430680-1-arnd@kernel.org>
 <CAHUa44GwSRB=7tFpXi2ZW-SXGipp7ErDkB2_4iGQfyH_ECAU8A@mail.gmail.com>
 <CAHUa44Fa4oCjpGQj-52nei1M+KkyxPYBsX5TDmgA3ekRPqg8GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHUa44Fa4oCjpGQj-52nei1M+KkyxPYBsX5TDmgA3ekRPqg8GQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/21, Jens Wiklander wrote:
> Hi Jorge,
> 
> On Wed, Jan 27, 2021 at 11:41 AM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Hi Arnd,
> >
> > On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Storing a bogus i2c_client structure on the stack adds overhead and
> > > causes a compile-time warning:
> > >
> > > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
> > > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> > >
> > > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > > open-code the i2c_transfer() call, which makes it easier to read
> > > and avoids the warning.
> > >
> > > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
> > >  1 file changed, 16 insertions(+), 15 deletions(-)
> >
> > Looks good to me.
> > Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> 
> Would you mind testing this?

sure, doing it this morning.

btw what Arnd has done - removing the unnecessary level of indirection
- was pretty much my initial though but I thought it was easier to
read the way I wrote it (I guess I was wrong and I obviously missed
the stack size increase)

but yes, will test

> 
> Thanks,
> Jens
