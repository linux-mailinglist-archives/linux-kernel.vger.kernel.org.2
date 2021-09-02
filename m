Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB69E3FF74C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347795AbhIBWmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347748AbhIBWmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:42:14 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D3EC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 15:41:15 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso4501872oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9OI7EwEg4bDroABc7i6v1b7AuK/nGIEjGgaB0f1jaNM=;
        b=B7cjnkU+8NntK8G8D7wEZxHOHhEpR08gzpDiID1faXrffZ+Fj1cRFRoI21vOW1uDQD
         kQ89WVooOLmUbKxGGQOVBnh/mdh7hn5/trX2650NWEqm1p+xsHnk2WemuSh+kCf9bwd9
         TF02pvPhDPz8XLk0RBTG4QeoFBFya8igJ/jIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9OI7EwEg4bDroABc7i6v1b7AuK/nGIEjGgaB0f1jaNM=;
        b=C5AUaWStfGMfiE0C1+o8SbgGwm/e1E1qyGeVqhQ+DTZ8XORSaTD6a1Ari8MROWstPK
         7pDER9WgyjIu/Y1FomCNWFHGEzHCNS26AzZp931iZQYkIe0GpNgTSR9cXLYpLdThpR0E
         ziI+YG90BMBlH29C5i5lMUHMMq1A6WMT3+7Y9SmzIcqzdZrKgdO7ShxDHYFVgUxbkZ4O
         RnBbezFrtDLuKSfC0bV2/86IzIc+vUiOVvcJ68uH7JtTOtqIt2HFiF4Znaaq9qDOfIAJ
         3gsPyxe78fT0bcUiDowZtWQeoD4M9fx/AhM9CdvXYQect5fdKsX8hH95AsT6at5G9T5r
         vKww==
X-Gm-Message-State: AOAM5314Ca+CchjeaVSB6AzVfe7WzjF2IBhCFX7r7ct6LuYdaA7Y4O0P
        iv9dTjuE5a7Ja8hkUcFkIAhGRYqmwG2K2w==
X-Google-Smtp-Source: ABdhPJxVYS56YaiZhIMWmv+jmXWByLIqD0aquqfdsYy5IAi6xt84XYqwShZ8QTF5Ggf+0zY4BCzgoQ==
X-Received: by 2002:a9d:6f0a:: with SMTP id n10mr469531otq.190.1630622474844;
        Thu, 02 Sep 2021 15:41:14 -0700 (PDT)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com. [209.85.210.42])
        by smtp.gmail.com with ESMTPSA id w15sm663552oiw.19.2021.09.02.15.41.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 15:41:14 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id a20-20020a0568300b9400b0051b8ca82dfcso4514543otv.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 15:41:13 -0700 (PDT)
X-Received: by 2002:a9d:6310:: with SMTP id q16mr462107otk.203.1630622473341;
 Thu, 02 Sep 2021 15:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210826124015.1.Iab79c6dd374ec48beac44be2fcddd165dd26476b@changeid>
 <20210901150840.GF5976@sirena.org.uk> <CA+ASDXMLBpF6bQLCoxkN-+CqjxOX-ujzYBTV1f=zU1J7fFNuDA@mail.gmail.com>
 <20210902170613.GG11164@sirena.org.uk>
In-Reply-To: <20210902170613.GG11164@sirena.org.uk>
From:   Brian Norris <briannorris@chromium.org>
Date:   Thu, 2 Sep 2021 15:41:02 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPJO=F+fa2zE4LDdRzMjgiugJfuzZKnZ-pndagVtw++Ug@mail.gmail.com>
Message-ID: <CA+ASDXPJO=F+fa2zE4LDdRzMjgiugJfuzZKnZ-pndagVtw++Ug@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: resolve supply voltage deferral silently
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 10:06 AM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Sep 01, 2021 at 01:06:28PM -0700, Brian Norris wrote:
> > On Wed, Sep 1, 2021 at 8:09 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > This doesn't make sense to me.  Why are we getting as far as trying to
> > > read the voltage if we've been told to defer probe?  This suggests that
> > > we ought to be doing this earlier on.  I see that the logic is already
> > > there to handle a deferral being generated here but it looks off.
>
> > Take a look at the commit this "Fixes":
>
> > 21e39809fd7c ("regulator: vctrl: Avoid lockdep warning in enable/disable ops")
>
> That driver change is at most tangentially related to the code that's
> being updated,

It introduced another case where we hit a spurious error log. And
below, you admit that you didn't understand what this is fixing
without that pointer. I guess we disagree.

> > Frankly, I'm not sure if we're abusing regulator framework features
> > (particularly, around use of ->supply) in commit 21e39809fd7c, or if
> > this is just a lacking area in the framework. I'm interested in
> > whether you have thoughts on doing this Better(TM).
>
> That's definitely an abuse of the API, the hardware design is pretty
> much a gross hack anywhere as far as I remember.  As Chen-Yu says I'd
> only expect this to be possible in the case where the supply is in
> bypass mode and hasn't got its own parent.  In any case I can see why
> it's happening now...

Well the hardware exists, the driver exists, and it all worked OK
until somewhat recently (and now it works again, thanks to Chen-Yu).
What should we do here, then? Just leave the "abuse" in place?

We *did* attempt some kind of alternative solution here, but it's
really not that easy. AFAICT, there isn't a good way for one regulator
to lock another, without exposing quite a bit more regulator-core
features to drivers. I think either the driver would need to access to
the |struct ww_acquire_ctx| in some way, or else we'd need to teach
the regulator core about the vctrl dependency, such that
regulator_lock_dependent() can handle the locking properly for us.

Brian
