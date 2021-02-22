Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C70321A10
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhBVOSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhBVNse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:48:34 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE92C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:47:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t15so19081993wrx.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DkB8TTAK1lLO99nzMEfxUHcuDNMKeOkqhURiMPq3j0Y=;
        b=jiV+jaD982bwgugJwuqis1dzzxy/lcL0mHW1tSFhHR/NblI9dVOTQ+vyCgVCt7S55Y
         EDH/FxPyJVspwE9ToCB837JBWllB4tilyoUgEE4oecMDNP0w2PMHClISgivmYP4dnLCu
         cTH0zXrQmNvHRxw1+UBftERDsSqFPFGWxm5AlmXEzXb648KpAE0xGBKV+Y1d5XaSy6fj
         sFdHsdUY6TWAEQJrHUvnsvugFUMx8Zhm2UZ/BtMrJ8ovLb6MRL+ufQfl5M27I9o2VL3r
         bh6f7tnSA8s8xjynn8vX+AChClDaOZqDxSapwhwFUb43V1pY2ZRmvjT3dQhvQauvlUed
         9Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DkB8TTAK1lLO99nzMEfxUHcuDNMKeOkqhURiMPq3j0Y=;
        b=N+edPqzsPESBtCjJPRjUR7lgfUGG5kib1/xbpC+FyFdf4iZ8shADOXf8AO88BVg3sx
         nL4O3ZuPZrqK5WZq3lYOlMGP1c5fHFGpsiQwIgpYk6kEgZrz6orFl2dxrLffBlvsWcK5
         TZw6VZ28c7i/Mc142qhMre0tK1+lcPfitXKzEjiksRLC3NtnuQQP++Nu3jORQKPLCChZ
         4Fja3aWdZ8ktY7xF4vAIZUaXC6tW6mHcULnsn5V5SQiuNn79jYLNeC5XPXcmiVQv3ukt
         +Y0uUhWQ+Cmq4uDq7aYycMakt6yEolxJ8y7ljAmO4FyGKRMzlLLeM8YXPjtjQZ2UT6xT
         LuBw==
X-Gm-Message-State: AOAM533L5OR1why89DAIrpgo2Tz68KWBQkVmKT/nmRMipmAi6NgO6vZb
        ODYpLVRTcmQGleJhn3ThnV4MxA==
X-Google-Smtp-Source: ABdhPJxnK6s18FTgmgFvQ9jKE29v5BWKGW51c04mCg/ZeGVGqdURrJ+4m1p/0hsR+UVinxN5wx/5NQ==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr21405266wrw.96.1614001672655;
        Mon, 22 Feb 2021 05:47:52 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id y4sm22550575wrs.66.2021.02.22.05.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 05:47:51 -0800 (PST)
Date:   Mon, 22 Feb 2021 13:47:50 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] kdb: Simplify kdb commands registration
Message-ID: <20210222134750.zc473zz42bz4teu3@maple.lan>
References: <1613650198-27437-1-git-send-email-sumit.garg@linaro.org>
 <20210222120502.phazkmskgqvpe4yy@maple.lan>
 <CAFA6WYNiaeyFHrcTSp6x4ur5VjZAoJ=NfMPsa__dH2VK9ze7vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYNiaeyFHrcTSp6x4ur5VjZAoJ=NfMPsa__dH2VK9ze7vQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 06:33:18PM +0530, Sumit Garg wrote:
> On Mon, 22 Feb 2021 at 17:35, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Thu, Feb 18, 2021 at 05:39:58PM +0530, Sumit Garg wrote:
> > > Simplify kdb commands registration via using linked list instead of
> > > static array for commands storage.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >
> > > Changes in v4:
> > > - Fix kdb commands memory allocation issue prior to slab being available
> > >   with an array of statically allocated commands. Now it works fine with
> > >   kgdbwait.
> >
> > I'm not sure this is the right approach. It's still faking dynamic usage
> > when none of the callers at this stage of the boot actually are dynamic.
> >
> 
> Okay, as an alternative I came across dbg_kmalloc()/dbg_kfree() as well but ...

Last time I traced these functions I concluded that this heap can be
removed if the symbol handling code is refactored a little. I'd be
*seriously* reluctant to add any new callers... which I assume from your
later comments you can live with ;-) .


Daniel.
