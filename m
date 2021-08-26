Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0203F8415
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 11:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbhHZJCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 05:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhHZJCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 05:02:22 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA8C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:01:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c12so3823228ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3Gk/DPLq+9WBqls06L23UyFghT+SV27ENQpnXR8aV7I=;
        b=MeCtTW/2zRAArxNe50jvEL6XX/NqAUSxEWBxOvmPVi8rJ+5kKh8VwXiLtGrqFqKtB7
         maRgjZb0tDoNJdAvRK4VjTQRpzmKw9+8Oq8IE1NjKLcJQLKSIle8nlYLAXn+Xko3mbV7
         0wxKdspeROgTps091ZiTJiuNq+Q+q9StlWXFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3Gk/DPLq+9WBqls06L23UyFghT+SV27ENQpnXR8aV7I=;
        b=uYkCsCFL2DvLTplu07EgerkItw69zo1zLUBCz5wcz6ncEnwnScVL6N51eyUG/O1+9A
         V4NcXdemA/vRzIx6o4nJk8kutEC4OC24Y/m9xgLu7Q1tt8O2wAkQt7QmTfyRgsZSg84U
         XdFbsf5ikXlnh911/dqRpoNBLK6mnND8/KPh01SN49SyRIn3PfMppXJzJjfo0CHccUtW
         lMYsGVc3QSdABrwggaWidC75GhoyN8YBfTcADVErH50Juyp41EvAcv0hD3mbdJ2zYR29
         sWoQqnZbqRWnW1LP6A5WJRAM6tm/vs/kIM1015ve1DUY1GFz5qzHOHdKmo9DTSomeooX
         YOcA==
X-Gm-Message-State: AOAM5317sL71+kfMCNk9oD6NZ3aUPtmeUY9dzaKBWuclTKBd4fc/hl2g
        sJKtstZZBDPuE8mX/JRVDrKDRA==
X-Google-Smtp-Source: ABdhPJxuQx7A1Ih6dpVy/NuDhZr5VoqMfB7v5tRM4spfYhcbbkmgogNRQcLp2mlUUGfw1fX0JSsSWA==
X-Received: by 2002:a05:651c:3dd:: with SMTP id f29mr2162081ljp.69.1629968492890;
        Thu, 26 Aug 2021 02:01:32 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r12sm273418ljp.15.2021.08.26.02.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 02:01:32 -0700 (PDT)
Subject: Re: "BUG: Invalid wait context" in ls_extirq_set_type
To:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
References: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
Cc:     Esben Haabendal <esben@geanix.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <26de7b85-e466-e9af-077a-9d1dc087e061@rasmusvillemoes.dk>
Date:   Thu, 26 Aug 2021 11:01:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825135438.ubcuxm5vctt6ne2q@skbuf>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2021 15.54, Vladimir Oltean wrote:
> Hi,
> 
> Apologies for my novice level of understanding. I see a stack trace on
> my system and would like to understand what is the correct way to get
> rid of it.
> 
> I have a consumer of the drivers/irqchip/irq-ls-extirq.c driver which
> calls request_threaded_irq.
> 
> struct irq_desc has a lock which is a raw spinlock.
> The __setup_irq function takes this desc->lock raw spinlock, then calls
> __irq_set_trigger. Finally this calls chip->irq_set_type which is
> implemented by ls_extirq_set_type.
> 
> The problem is that ls_extirq_set_type uses regmap_update_bits, which
> ends up taking a non-raw spin lock, the kind that becomes sleepable on RT
> (this system is not RT, but still).
> So that's kind of bad, and this is what the stack trace below is saying:
> 

So, we've been using the irq-ls-extirq driver for years, on an RT
kernel, without seeing something like that. Does it require certain
debug knobs in .config? Or perhaps the sanity checks have been added
later, we've mostly been using it on 4.14.y and 4.19.y.

I don't know what the right fix is. Am I right when a say that for !RT,
spinlock==raw_spinlock? If so, switching regmap's spinlock to
raw_spinlock would be nop for !RT and fix this issue, but would of
course have quite far-reaching effects on RT kernels.

Perhaps it's silly for the driver to use syscon's regmap to access that
single register, maybe it should just iomap it itself, and protect
access with a raw_spinlock of its own. While syscon's regmap would cover
that intpcr register, nobody else would ever access it, so that should
work fine.

Then there's your suggestion. While there's nothing wrong with adding
raw_spinlock lock support in regmap, the fact that nobody has needed
that till now suggests that one should at least pause and think about
other options. And you point out the weaknesses of basing the
.use_raw_spinlock on a .compatible string yourself.

> What to do?

TL;DR: I don't know.

Rasmus
