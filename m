Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709F5330ABF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhCHKAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhCHJ7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:59:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A386C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 01:59:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id e6so6091389pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 01:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7OUVsgAjiB+xDwzGsbQ6h02XcyQkfh8Xc+CH7pI70w=;
        b=eODQfLN/4GzASFEmcAojvKQ9NdJQMP60td45sCkfisPo+KcHFX97VEmB/mPKN2FGLR
         r4KHvAQGOo5CNAb84FZDWDCQRBYo1FOeifo8WZBYH5zRpUiTcN5h3Zj1q+ajjF0HxJOJ
         qr8Terk/eeuEKCudXvZ8t2N1Pqgkbu5Q7K0pMiCpQtqvHAcw3uHUy0ZAn0FO1b/0m6JR
         BT5oNiAEUbmU0tRF8QqufLNYxut74ZF47EqZx6tJrCxJ8aq2+gTNo+NEHEctYYf2zdh1
         yTU84L3d8JtzyLO9eCPMP83ziWqItbUKpIZxWaeLihl5SAP1FYt4jyj2kFwXoi3eZ6iO
         M/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7OUVsgAjiB+xDwzGsbQ6h02XcyQkfh8Xc+CH7pI70w=;
        b=tBs85JDZnJrWFdd9btc81ghtlaklemZk2mpFoPJRW2lCCsjqXnOWCBSjlgf+NOnN+0
         fj3LQdfbdjPkdeLDxPhh4oi3BG9X7gLiF6dGcSUJ/ilot0saG2L8zMnqIV/iTDV7ze1O
         V2l6Dw4oEa+P4zn550OYJQxTyKa7KDip5EiEdPcPGiyCOWyp7ZxARPhW5HukQxKaIG8T
         AmkSC27vKAaJ5oYf9/V7p8t39YecfchipFMoSoO8OT8m/BWXBS06dcs1FtWKxXlrEr8B
         JAwm9n35STdCwatbehJtyXQu3gaZK4traWVUzFWy5wC0MkpW0pPrFsilpiSuTfnB3gAh
         DjPQ==
X-Gm-Message-State: AOAM532E7mrEy5w50AgQ3fIGUKaX4yNf0p3pDIP1basFIZFdGlw2+j03
        zyY7hlpAUqNqrc8Jhb6z4+GdGLfFUuyp6UEHavxuWZubSu/zxw==
X-Google-Smtp-Source: ABdhPJzWPh4R94QYxCvfdHfiY9KPdu5SgpCEYdbMqcq8h2iqUt5KaluQpgLPnjoTzZMg8fx14l60t5Dol8dofA+AuD0=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr4839478pfb.7.1615197591129; Mon, 08
 Mar 2021 01:59:51 -0800 (PST)
MIME-Version: 1.0
References: <20210305183948.37738-1-andriy.shevchenko@linux.intel.com> <20210305221951.GC2896@zn.tnic>
In-Reply-To: <20210305221951.GC2896@zn.tnic>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Mar 2021 11:59:34 +0200
Message-ID: <CAHp75VdoGShdAQFkx5PR-H6=csRA_ReaerDg6iy54AMJF+kaOg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] scripts/decodecode: Decode 32-bit code correctly
 on x86_64
To:     Borislav Petkov <bp@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 12:25 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Fri, Mar 05, 2021 at 08:39:48PM +0200, Andy Shevchenko wrote:
> > On x86_64 host the objdump uses current architecture which is 64-bit
> > and hence decodecode shows wrong instructions.
> >
> > Fix it by supplying '-M i386' in case of ARCH i?86 or x86.
>
> At the beginning of the script says:
>
> # e.g., to decode an i386 oops on an x86_64 system, use:
> # AFLAGS=--32 decodecode < 386.oops
>
> What kind of oops are you decoding such that that doesn't work for you?

It works, but... The question here is why the script behaviour depends
so much on the architecture in question (by environment). ARM stuff is
using traditional ARCH (and that's what I have expected to work),
while x86 has a set of other variables.
So, I have to rephrase the commit message then and do actually an
alias when ARCH is set in a certain way, Would it be better?

-- 
With Best Regards,
Andy Shevchenko
