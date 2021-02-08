Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3371312BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 09:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhBHIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 03:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhBHIeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:34:19 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 00:32:53 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f16so11781331wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 00:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries.io; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSU/G1l+Y54In+pRZdaVmq31hPui20B+x8ZAbeeJbPM=;
        b=cTszrBadmvqVfGr4GE94pFVu3W/vguoltOxdJ6CLYs5lBGtY1/3i1sYdRQLP0rpNlQ
         Q36CZa/ozGdOBfR2gruh8FeHw9ajEFJzRp6WepZT4lDyjy287m9AMekkL188MItNcmhg
         BkenBP5Tt4j+0Rt6SS3dyEe7GaH52zvZ5S/7jCDwH0DrlHhxnOeZLFAnAJTyakhvvhf1
         4XGwzqgLT/po7/h822Es67I/D2psCo++DWoRQ0ynUnXxHQ46Mhvqacl+tZ6kUn38geqc
         7owLYaG5LQwSzL7zDlxzonUHbgkcqNOPnmyJSHdM05HEQsbQbEeARwRdTroeHyYfgiY8
         yVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSU/G1l+Y54In+pRZdaVmq31hPui20B+x8ZAbeeJbPM=;
        b=Dif66iw8BMon/Lb1u8ZyTF7whN8Pn5+pWPx3JGVZ9xS02Ac2IG3Qs80tvLHUaQzLkl
         A0vz0Gw1EIIqS4fuAuk+4GhJmnnHBOU/6uWU72CbL3xWNFKoUxO19nn5LExomt5v94Ps
         uCdMNUgJ8GBm2Z6eNQviqCryPJKMIzC2alrKbzV6zfe3gaBE8Pws314wVYjuI81AVOT/
         LDWLp/D38lQzNFZTJPinMjnBUKbR2bK+hqPkxjSmM+IfyfS1KDUFBakLBRnlkyBe8HHB
         qKfmiOSkhmDQrLzeJbu5nIMI/okIx0VH0jnp3l88YZ92kwGEjP5wm4nrgdSK59UM66jX
         5UFg==
X-Gm-Message-State: AOAM533xggr93m79P7GwN0zVS5apsW+uR+4TuTpFQqqvQ7DLVvvWjw3l
        I9wHpR8MXh8NWynJODck6MrIEmwI8xaMDg==
X-Google-Smtp-Source: ABdhPJzO9rYC4GK/53VOZnTNAE5T4ZPGZv6mXanFj/EFXfP57EBZmjTolyz3LmYlJqxSvkyBGYewPA==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr13693056wma.26.1612773172314;
        Mon, 08 Feb 2021 00:32:52 -0800 (PST)
Received: from trex (182.red-79-146-86.dynamicip.rima-tde.net. [79.146.86.182])
        by smtp.gmail.com with ESMTPSA id x13sm14134642wmc.27.2021.02.08.00.32.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Feb 2021 00:32:51 -0800 (PST)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Mon, 8 Feb 2021 09:32:50 +0100
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        op-tee@lists.trustedfirmware.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optee: simplify i2c access
Message-ID: <20210208083250.GB27508@trex>
References: <20210125113758.2430680-1-arnd@kernel.org>
 <CAHUa44GwSRB=7tFpXi2ZW-SXGipp7ErDkB2_4iGQfyH_ECAU8A@mail.gmail.com>
 <CAHUa44Fa4oCjpGQj-52nei1M+KkyxPYBsX5TDmgA3ekRPqg8GQ@mail.gmail.com>
 <20210208074631.GA27508@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208074631.GA27508@trex>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/21, Jorge Ramirez-Ortiz, Foundries wrote:
> On 08/02/21, Jens Wiklander wrote:
> > Hi Jorge,
> > 
> > On Wed, Jan 27, 2021 at 11:41 AM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > Hi Arnd,
> > >
> > > On Mon, Jan 25, 2021 at 12:38 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > >
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > Storing a bogus i2c_client structure on the stack adds overhead and
> > > > causes a compile-time warning:
> > > >
> > > > drivers/tee/optee/rpc.c:493:6: error: stack frame size of 1056 bytes in function 'optee_handle_rpc' [-Werror,-Wframe-larger-than=]
> > > > void optee_handle_rpc(struct tee_context *ctx, struct optee_rpc_param *param,
> > > >
> > > > Change the implementation of handle_rpc_func_cmd_i2c_transfer() to
> > > > open-code the i2c_transfer() call, which makes it easier to read
> > > > and avoids the warning.
> > > >
> > > > Fixes: c05210ab9757 ("drivers: optee: allow op-tee to access devices on the i2c bus")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  drivers/tee/optee/rpc.c | 31 ++++++++++++++++---------------
> > > >  1 file changed, 16 insertions(+), 15 deletions(-)
> > >
> > > Looks good to me.
> > > Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
> > 
> > Would you mind testing this?
> 
> sure, doing it this morning.
> 
> btw what Arnd has done - removing the unnecessary level of indirection
> - was pretty much my initial though but I thought it was easier to
> read the way I wrote it (I guess I was wrong and I obviously missed
> the stack size increase)
> 
> but yes, will test

Tested on imx6ull.

Tested-by: Jorge Ramirez-Ortiz <jorge@foundries.io>

> 
> > 
> > Thanks,
> > Jens
