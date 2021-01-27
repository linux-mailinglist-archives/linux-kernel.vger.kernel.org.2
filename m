Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AE1305C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbhA0M7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:59:47 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:36228 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbhA0M5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:57:52 -0500
Received: by mail-lj1-f175.google.com with SMTP id l12so1964393ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:57:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc
         :in-reply-to:references:mime-version:date:user-agent
         :content-transfer-encoding;
        bh=hkkEQ5LxAIAG697moZ6W1KLytp5WEJ6lVkLYP4iGbjY=;
        b=jHUf2f5Vx0g52BZO9G8PM8/DKtCWId+2wQhbEIqizeaoLp1Uvhb7CYCifm+h7tjn6l
         3U2T1yioP9l4GpvtGkKy8THwVB+x1d4WO3VYu9ynhXzG8aEFF3+3zx6juydLmcXwBGA3
         KuXHJf2msiq61eaf3zdoSrV9IBUWBrWWcxm7xKTPpXdkxHehEMWJW2twLiS1qTBcvUQg
         W7Z2MWpk58lEtmfW0nMWkE96Q3nyw0vJ/kBZDoqewpYhfp8CzXN4DDRKxXEU/xGLBY27
         t5SbTnonbQUHKZYkcHkQZdA+Dk4FkcxJjMKhoR8E/1rUHHZV+WalC3J4zncGUiFgK4JQ
         TZgw==
X-Gm-Message-State: AOAM533PCt7DyOqsQwt1IRn8QTQbjnEb7fQtJbDBu7uz/ozHBv4UdLNj
        KgsaNPXKt79mSxm0fiMO7DE=
X-Google-Smtp-Source: ABdhPJxw2y8RtzAqRXP2urfRcgpmvZfgaYE3x/Tt8XXZjEesN30YIuqP4/KXCCcuROlT7p59jaJaTw==
X-Received: by 2002:a2e:9594:: with SMTP id w20mr4482316ljh.417.1611752227718;
        Wed, 27 Jan 2021 04:57:07 -0800 (PST)
Received: from localhost.localdomain ([62.78.225.252])
        by smtp.gmail.com with ESMTPSA id 192sm469576lfn.232.2021.01.27.04.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 04:57:06 -0800 (PST)
Message-ID: <6d60af3516161bd04332cd60b50aa4becf92e17a.camel@fi.rohmeurope.com>
Subject: Re: short-circuit and over-current IRQs
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Reply-To: matti.vaittinen@fi.rohmeurope.com
To:     Mark Brown <broonie@kernel.org>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "angelogioacchino.delregno@somainline.org" 
        <angelogioacchino.delregno@somainline.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20210127122733.GC4387@sirena.org.uk>
References: <6046836e22b8252983f08d5621c35ececb97820d.camel@fi.rohmeurope.com>
         <20210127122733.GC4387@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 27 Jan 2021 14:56:47 +0200
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

Nice to hear from you. :)

On Wed, 2021-01-27 at 12:27 +0000, Mark Brown wrote:
> On Wed, Jan 27, 2021 at 12:01:55PM +0000, Vaittinen, Matti wrote:
> 
> > Anyways - I was wondering if this is common thing amongst many
> > PMICs?
> > If yes - then, perhaps some generally useful regulator helper could
> > be
> > added to help implementing the IRQ disabling + scheduling worker to
> > check status and re-enable IRQs? I think it *might* save some time
> > in
> > the future - and help making same mistakes many times :]
> 
> If we've got two that's enough for a helper.  TBH I'm a bit surprised
> that people are implementing hardware that leaves the outputs enabled
> when it detects this sort of error, it's something that's usually an
> emergency that needs shutting off quickly to prevent hardware damage.

I can only speak for BD9576MUF - which has two limits for monitored
entity (temperature/voltage). One limit being 'warning' limit (or
'detection' as data-sheet says), the other being 'protection' limit.

I don't know guys who designed HW - I am located to a remote spot on
the other side of the world and on top of that I am the odd "SW guy" so
it's better to keep me out of the HW R&D decisions and especially the
customers ;) - but I *guess* the idea has been that consumer driver(s)
could do some 'recovery action' at 'warning' limit (which might make
sense for example when temperature is increased to 'high' but not yet
'damaging' - I guess there is something that can be done with
over/under voltages too...) and only kill the power if that doesn't
help and situation (with temperature/voltage) gets worse.

What I don't like is the fact that HW keeps IRQ asserted instead of
having a state machine which would only generate IRQ when condition
changes + status register to read current condition.

I will see if I can cook-up something decent - but as I said, I would
appreciate any/all testing if I get patch crafted :)

Best Regards
	Matti

