Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A4330E26C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 19:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbhBCSXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 13:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhBCSX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:23:26 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD37AC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 10:22:46 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d15so373874qtw.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 10:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVuZ2ToAi2wJaDBY4uBWAsbbv7FYhDuwXoMEVKtaX50=;
        b=kt9gvntHnsgph4IePrJjeMd5T/Z0hFLfadxsM9Zx6DIko11WejgpeFhf+uxhGE7xQx
         exygpc9awXY1Z4MJ2hC1nfrWHH12EcTBQ2qx+IY7fnGHc1bkpXPvd+SF8PQxm2+Y+Xbh
         FKNMwOBbVbgVHzuuBIMDxTJkPAVG67dlK9kpPUb1Pt2MDdXp6EGlsAHt7DgT1nTykGHK
         hdosQ8PusoL2PZ3ysZBeXvdeKNnv+CAjlXECi758zOYkDvDcnHtd983W4Whu0nM0E+I2
         CgpOzhiMDgFMIyxDomLN4de9SgOLKWLsc9qAswUPb+zJ7tY+SvcHcaLtwK/DyBAlA/K+
         RcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVuZ2ToAi2wJaDBY4uBWAsbbv7FYhDuwXoMEVKtaX50=;
        b=AfBpK8Zjw9t3stMobWXuLY0lbDJ2tPRgqqFAwaoOf0w9g1byI6MpaYbZmsg31rcFpt
         kLnv8l4NLXZn31hdUYDA0xDUN58UjKuI+Vmmj0C47WyW99ThqOOXyhwF6nq/xp3m9g81
         /uFtaoaXQx6hYBUlkSRwhhjjkEthDIIak85D6f90a+xBOLxignJoBdedRzhq1SreD1Hs
         Py2DHxa4UvWhyHMUwnYX8p9fhenbTI0qEqdnD8FwhjQXXaRB3a3hELHkzCKYSu9SKEQW
         mQPznOXdPteK5I+DGKFyHqlPslGkqhHZckT67z2OrJgPP+y8XlrzDSS/I/LGJufE8Nzy
         HgOw==
X-Gm-Message-State: AOAM532/7cAzOezCAoWYsafB99xXPSb5ZJyzo9ICNC0xOvu4EihB7oDu
        /atDyUvmdE6BefOdv2MrZsr4VTwUK4DccCnDo6MA7g==
X-Google-Smtp-Source: ABdhPJzpQYizDiF/DtT99RZLiZIESuBNe9bf+IuZNplJY4FcPoEPNwmeoK3j0y7ZV9Xo0vCljWKoZyfW6uzYDZTTZ6g=
X-Received: by 2002:a05:622a:c9:: with SMTP id p9mr3541176qtw.337.1612376565582;
 Wed, 03 Feb 2021 10:22:45 -0800 (PST)
MIME-Version: 1.0
References: <CACT4Y+YytChe9Tv5etacBL4snEDu+A2fNzF4zKiKtfmH0C0roQ@mail.gmail.com>
 <20210203160543.GA19512@duo.ucw.cz> <20210203172834.GA3943@mipc>
In-Reply-To: <20210203172834.GA3943@mipc>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 3 Feb 2021 19:22:34 +0100
Message-ID: <CACT4Y+bkQOAwAwEnRoZVwKM2sDpHW3bzeWdga4MhxhERvZKT+Q@mail.gmail.com>
Subject: Re: syzbot reporting less duplicates
To:     bobwxc <bobwxc@email.cn>
Cc:     Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 6:39 PM bobwxc <bobwxc@email.cn> wrote:
>
> On Wed, Feb 03, 2021 at 05:05:43PM +0100, Pavel Machek wrote:
> > On Mon 2021-02-01 11:52:12, Dmitry Vyukov wrote:
> > Could we please get common prefix (like syzbot: KASAN:....) so that
> > the bulk of emails is easier to remove?
> There are several bots testing on the kernel, maybe we should give a prefix
> format for all bot.
> Also we can use mail-address to fliter email, but it's still a little
> inconvenient.

Hi Pavel, bobwxc,

Yes, I was wondering if syzbot in From/To/CC can be used for
filtering? I assume email clients that can filter based on subject can
also filter based on From/To/CC.
Does anybody filter syzbot emails? Maybe you can share what works best?

I am not sure a common prefix for all bots is useful because it
supports only all or nothing. There are also some bots that
maintainers use now that seem to be fundamental to the process, if one
is ignoring them, then they are effectively ignoring what the
maintainer is saying.
