Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD14392E43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhE0MvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhE0MvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:51:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71B1C061760
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:49:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e11so586372ljn.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPDKpeQP85lIS4gYU8UwCGKlha6ptbLg1ETtgq9iJMw=;
        b=Ouf7cM44WCMGrm8fB7veWn15pNkwVEiXKb0QxbC/6bj4dPtrlIsZS6zoutiY35TfzI
         097B1D3YFkZQHZXtjwhlPzC7cnD/hcK6Gx76hJSk5ndux2q8TKdfmr/2rKgU+JCq5NAa
         +GaUfLpKW3nyxIqagUzfXa/jw4H5busK3vFCzgxEl0I0auWr0J5HUinZofrnBMWE5y4W
         hGRAAXGOtKWEIlygch53DVVQy9oVM9rxXKCQ7MXY0oJcmGjMEITpWB15GeMYmjKMkgxR
         4zx3LshbFTI5tj2f4NtzO2jfN7lCeQF83EC0Os2tkkbgr9N0opi955P1EZIa0/u6tKVu
         QUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPDKpeQP85lIS4gYU8UwCGKlha6ptbLg1ETtgq9iJMw=;
        b=iVI2OO2CxgmeGfWKmqL3br3C55JNsEhXClzw/apxpSBP+ToTWrePljCBR0Z4Nl3jFd
         fgvRNsdvEvd+8viceWqCauJy5hNBOODSwm6W8prUF58BQAffCFdGYTMrNS5PuiroETbo
         yByDm0iC4bykekjx3V7awzwLJRDE6BDnwzJwlDZUrcPCA1bG9DCknme/WSuVhPpbN7x0
         fR/EvaH9Hg39IIVRWKlFos87bfwjIQgk6W7C8IXFgu9MnpvTjUqA4KsiBGCXvMOaKfC1
         YMWKrL+4AKgg8Wph0PqmsmaKivBRXLLvOH9D7iDkmk+Yj6TuZt/IEI5yTQ/R3ie4szhP
         rTCQ==
X-Gm-Message-State: AOAM531N6gf2RMmW7teoLSL98vAB3hCGyonKPlYxJpa4ptxgru84Fj/v
        HX+ONxJ3UUOBnEhETqBMYwZqoC01NLh1TGyqjUrBS6i6smY=
X-Google-Smtp-Source: ABdhPJy6E1hwcPnCbYx4uzIR9f/0MRVEBTzZQDezVp1GRC7qp2MOnioF0GkK5BSepkqjHk9K4LAvMcDr7Gx32vB6nr0=
X-Received: by 2002:a05:651c:1408:: with SMTP id u8mr2394954lje.401.1622119778226;
 Thu, 27 May 2021 05:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210518125202.78658-1-odin@uged.al> <20210518125202.78658-2-odin@uged.al>
 <CAKfTPtCCZhjOCZR6DMSxb9qffG2KceWONP_MzoY6TpYBmWp+hg@mail.gmail.com>
 <CAFpoUr0f50hKUtWvpTy221xT+pUocY7LXCMCo3cPJupjgMtotg@mail.gmail.com>
 <CAKfTPtCaZOSEzRXVN9fTR2vTxGiANEARo6iDNMFiQV5=qAA4Tw@mail.gmail.com>
 <CAKfTPtAFn3=anfTCxKTDXF0wpttpEiAhksLvcEPdSiYZTj38_A@mail.gmail.com>
 <CAFpoUr1zGNf9vTbWjwsfY9E8YBjyE5xJ0SwzLebPiS7b=xz_Zw@mail.gmail.com>
 <CAKfTPtDRdFQqphysOL+0g=befwtJky0zixyme_V5eDz71hC5pQ@mail.gmail.com>
 <CAFpoUr0SOqyGifT5Lpf=t+A+REWdWezR-AY2fM_u1-CCs8KFYQ@mail.gmail.com>
 <CAKfTPtArj_XkgPXRJKZxN0MM2+v=3+RjAVVkmbpB1gBLCuzJvA@mail.gmail.com> <CAFpoUr2NM9RHE=jdbi5aNj2LeVr4iKJ3thMPUNhp_SnCe7tnfg@mail.gmail.com>
In-Reply-To: <CAFpoUr2NM9RHE=jdbi5aNj2LeVr4iKJ3thMPUNhp_SnCe7tnfg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 May 2021 14:49:27 +0200
Message-ID: <CAKfTPtC50AkBcm-AQf63XQOFE3w5ZbRS7Sh=yDDSG1hM1wBhvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] sched/fair: Add tg_load_contrib cfs_rq decay checking
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 at 14:38, Odin Ugedal <odin@uged.al> wrote:
>
> Hi again,
>
> Saw your patchset now, and that is essentially the same as I did. I
> guess you want to keep that patchset instead of me updating this
> series then?

yes

>
> Also, could you take a look at patch 2 and 3 in this series? Should I

Yes, I'm going to have a look at patch 2 and 3

> resend those in a new series, or?
>
> Odin
