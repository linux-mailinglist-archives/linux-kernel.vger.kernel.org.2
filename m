Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3E341404
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhCSEL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhCSELA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:11:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DB4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:11:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y5so91124qkl.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaqZ5Xka3NFx+U71V6vC4ru0MXh/qF63OiW6ltUtrL4=;
        b=NI0jLE++PD268TEUsgTuwXAQEtQ0DqWORhgI3TDVqilngZgb2T7BzCI67g1UWdZe/7
         OzmvhEbfa+AfFzDtEx0knv8QT1ESOaaPMc/cYIoaSy34gTlFrT8Qv852alxW3Q+lcXJx
         LQDa9dJlw1iqfBK2+zWUq/5cLb30A+nOlfkFhnl0sqXC7v7sU+MumB803mAy9VRrFCDI
         kvWOnjTBj4CeFsPP3BiBGNq1KEHly/IeS8Yjhj+SPwjyPXuAAG8LsZl16S/v53lL0TEN
         9plCewyCIZcBR6i0iazU6D3yd8uYE0mFaZpjsx5l6TMFTy9ztlZf6DxouOTPzldIhzx7
         LyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaqZ5Xka3NFx+U71V6vC4ru0MXh/qF63OiW6ltUtrL4=;
        b=kYuRSN5I+WdsK9t1z8ruKt8GSEiqlMHTZ1gNkRN0w1VBQ1RodujkHnyO9EU3ruv0uO
         SmDvOXysrumU9bUNTAuOqJstN9cpTuqJ2iQiSJyLAJdl7mgvvj2Du6nLJ9mq6LNk4zEy
         TNcRu7Or/5TlDiijJwHbM8zx720xut/QwK59v9yXosIalXC6j8deBXDx5sTFDFLNeQvC
         SqDX+quG3qayI7DCD609b7GK81dHrlDr0dwXGIfotBkb3exEn/N8JOFOJhakKx7sQ8Ax
         W21b1utNcyjTPQ7+QKWaRf6bWaK1j/j7O+Xm0gk4FOTZ7moFHYIJeC/DArBpzhRN039X
         zi2A==
X-Gm-Message-State: AOAM530yl/kEeRonbjQJd2jkJubowwOf29J/RVReFQDj5XM3u0nSLlAA
        0AQFC3SiFSxmCdD3hn4waJA3pown8TvZNRvTyXc=
X-Google-Smtp-Source: ABdhPJzSglnF+PloSPSyO4A9pea+8tGafdjSrifWXMts+rIqOZ1H55BiTRHYe1r1wfNKoEJ/HxJR8YAxSIn9uipM6Ms=
X-Received: by 2002:a05:620a:102c:: with SMTP id a12mr7643841qkk.450.1616127059424;
 Thu, 18 Mar 2021 21:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <1615886826-30844-1-git-send-email-shengjiu.wang@nxp.com>
 <20210316125839.GA4309@sirena.org.uk> <VI1PR0401MB22721D0D266207472B3C7829926B9@VI1PR0401MB2272.eurprd04.prod.outlook.com>
 <20210316134915.GB4309@sirena.org.uk>
In-Reply-To: <20210316134915.GB4309@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 19 Mar 2021 12:10:48 +0800
Message-ID: <CAA+D8ANuUWne1nzGH6=V4nj7YMRczuZ+pH--eJ+ghiGWfo_0sQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: remove reset code from dai_probe
To:     Mark Brown <broonie@kernel.org>
Cc:     Viorel Suman <viorel.suman@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On Tue, Mar 16, 2021 at 9:51 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Mar 16, 2021 at 01:42:40PM +0000, Viorel Suman wrote:
>
> > To me it makes sense to manage the clocks and reset from the same place.
> > Currently we have the clocks management moved completely into runtime PM
> > fsl_sai_runtime_resume and fsl_sai_runtime_suspend callbacks.
>
> Usually the pattern is to have probe() leave everything powered up then
> let runtime PM power things down if it's enabled, you can often do the
> power up by having an open coded call to the resume callback in probe().

It seems some drivers very depend on runtime PM, if the CONFIG_PM=n,
the drivers should not work.  What's the strategy for this?
Do we need to support both cases, or only one case is also acceptable?

Best regards
Wang Shengjiu
