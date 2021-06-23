Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6D63B1AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhFWNRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 09:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhFWNRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 09:17:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A0FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:15:24 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j4so4031372lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 06:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOpcYe1VImC2Ru3j1mAesgD8NLFGduXso588+LnpwWE=;
        b=aQRnJM1yCclqTGVTvhmY4RFqBfzPYZy676af5RSeub5reF6XCYAf0su79QLyByJiIe
         PdkRgVBkhK4jrTsiY4W7iPqV2yQ1FyYQeS62scFfMRYW1xbBgK0X6FA6SyvzzU4pr2Ry
         2hFqc3zEFy9+6D6MCotRMNRJgP99c81d9fEJJPgUBY8yGwIcaxjjlm+Ux56OreZS0uKw
         EJx+FsTfX1IED7myoNgesZlohn62Mf6NJv2K94cHX2F9K2RzK6jfjY5rC/IOGck7NHac
         DWNXigHBSgfdNjX1yJVOKbgCLxk7hB+VXZW8RiwjS8+5gT3yJ2Zq+doEKTucGRdP24BN
         Ff4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOpcYe1VImC2Ru3j1mAesgD8NLFGduXso588+LnpwWE=;
        b=hpCu4JVsXc2r3Wv+0XY1mqp2oaGcoM6buQDm+jsxTzA3Ou+U8lWiQs6nXlVrAktgiy
         tywf7Wbb9hrfmbplxebZaTwv2pu+r/OMxuajE+PYhAd59X4oHZjxTLM2HXKm4JJaXu1p
         bfs/vwGvqW01hfUq3XBIVj2zIDHtOOVns5l5IUpkyBreLHhweTvHktdvsDQ31TJRjyjs
         A8+C+JNuGGhMpxndenBUKc57g6OJIBaF1G6WspYmR+Yx9yzynaHMhI1v+8UkH9c9y0Ku
         RZ0/44ckv09ua7yER6NOCecixrfRNE36mBKxpQ3DCb9mc8skNsiJXA2EGo8OBgzwZoWg
         Kg7w==
X-Gm-Message-State: AOAM530f8ZWXTPRXObjm/uZzZkJprMz99K519uJfyYIS6kNSoFajzJyE
        miWulYNqCFH2EfrBxZzrfECsMW59O45IFl6FN68=
X-Google-Smtp-Source: ABdhPJzjZgNJWxMYRIckLoI3N2BfkhWGRVxcQmTYv08rmlJfHjLQ9EjDl8TKrpYZ2UfzHHkgdXzOQL4ENANxeVfhHT8=
X-Received: by 2002:a19:4345:: with SMTP id m5mr6892671lfj.599.1624454122461;
 Wed, 23 Jun 2021 06:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210610122550.jnriewchqspdcrwk@gilmour> <20210623121311.qlbnije5gn7o7so7@gilmour>
In-Reply-To: <20210623121311.qlbnije5gn7o7so7@gilmour>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Wed, 23 Jun 2021 08:14:46 -0500
Message-ID: <CAPpdf58AmzQkAQBx8x_kjfREto9qugYS0jLV+0qfp+atDFRimA@mail.gmail.com>
Subject: Re: [GIT PULL] HDMI codec improvements, v2
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 7:13 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Thu, Jun 10, 2021 at 02:25:50PM +0200, Maxime Ripard wrote:
> > Hi,
> >
> > Here's a PR for the changes to hdmi-codec that need to be shared between
> > drm-misc-next and ASoC.
> >
> > This is the second iteration, fixing a bisection issue with compilation
> >
> > Thanks!
> > Maxime
>
> Merged into drm-misc-next
>
Not sure if its applicable - - - - - but - - - - I've been waiting
wanting to use a 4k monitor on hdmi for a number of months now. There
is a bug filed where I wasgiven to believe that my issues were likely quite
connected with hdmi.

I would be quite interested in seeing any hdmi fixes also added into 5.10.????
kernels not only the 5.13.??????? stream.

Would that be possible - - - please?

TIA
