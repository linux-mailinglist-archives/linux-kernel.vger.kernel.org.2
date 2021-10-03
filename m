Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C46042046E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 01:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhJCXNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 19:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhJCXNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 19:13:48 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E8CC0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 16:12:00 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id y28so3711843vsd.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mMQIV6iy/YcB5GjonDB7HSdfPpKfOSD7BW3xn+YP/DU=;
        b=QkXTiIR3+QNbtk78cJbJtsNqnJQf1vPk3ReN5Z/IsCuN+ld/6Y8+SyjR/sSNObHrvy
         LuwIIfiTgyLmDaVPkhz88u8/lmQxA27XGwZcsb0S0nOHIx8h1yFrgLaurz5EJtxUxH+Z
         kDtuPH/tB7mrtMZB0/2saB1PT3ODQNBwlUAyfdI6Rbi5qDdWhK59KNV8ElrjleNny4aL
         JYefwlQ2doHpniLrfKl03S/vFCtOPJfxz/pUOw/bPcXaXIIxh4wGelE/u0M90x8qXTYU
         YGnandWgE7gO/FTbroftj6bhHtNiQiqlPCWQY7DaczTEDmgAeWhzWNkQdQNjclseSgA3
         Cv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mMQIV6iy/YcB5GjonDB7HSdfPpKfOSD7BW3xn+YP/DU=;
        b=qscXBWfzb+ZgiXJHMZk7JVrr538pHqzgHk4uaogUf08VCjA8vxugUXRVd/vtsugTu1
         r6LXcgVFNU5YL8om3/l56WAexR6CP48q5MMI4fszJNuX88uq2i8I4yJUXNTJ8Q6NWZzR
         F5uQow7dPOisoceYrjob/V8mC8WViR4qv2Poae+FouAJ3sHGl5TDDo1388S4vd4YbRR/
         8oHRS5IR9rMkcUi+Y2Mc3Qqej8Pn0W6HKVlxxgeTKFwGpj6QaiVK5HdnF4O3QM574Xps
         U9JMH8vjuJ82Md3uVm1TH1npf6lj2whtLBcqeSekq2KI2GGZgoBaq6S+js21YSAy6fX4
         Q/jA==
X-Gm-Message-State: AOAM531oPMt5YIL2erueW7WxSlis9tMHRw5CelBLM7zK+6uh4FFkh5Lr
        Lf/C+kPnHZaeDbjHpH0D7fU=
X-Google-Smtp-Source: ABdhPJxZFZJ00cfx/JjWexY4Yi9Z65BWyW0WPxPc+6iP9/jByvYrihDArkBL5WNBLxsnACqlUzbi6g==
X-Received: by 2002:a67:d00d:: with SMTP id r13mr10866961vsi.23.1633302719105;
        Sun, 03 Oct 2021 16:11:59 -0700 (PDT)
Received: from geday ([2804:7f2:8280:9a0f:98f0:31ff:fe93:2dc7])
        by smtp.gmail.com with ESMTPSA id t5sm6100912vsk.24.2021.10.03.16.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 16:11:58 -0700 (PDT)
Date:   Sun, 3 Oct 2021 20:11:54 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 0/1] ASoC: meson: aiu: HDMI codec control
 questions and issues
Message-ID: <YVo4uuKJy2QIQ77n@geday>
References: <20211002234313.3209294-1-martin.blumenstingl@googlemail.com>
 <1j35pivzho.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1j35pivzho.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 03, 2021 at 05:57:34PM +0200, Jerome Brunet wrote:
> 
> On Sun 03 Oct 2021 at 01:43, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
> 
> > Hello Jerome et al.,
> >
> > on Amlogic Meson SoCs which use the AIU audio controller we have the
> > so-called "machine gun noise" (MGN) issue, reproducible for example in
> > Kodi. So far nobody was able to identify the cause of this issue. My
> > idea was to at least narrow down the issue so we can categorize it. For
> > that I wanted to get the SPDIF output from AIU to the HDMI controller
> > working.
> 
> Ok, I'll clarify (again) about this issue.
> 
> This issue is on AIU only (not the AXG series), on the i2s encoder
> regardless of the output (HDMI, internal and external codec)
> 
> This encoder support either 2ch or 8ch mode, nothing else.
> As long as only 2ch was supported, there was no problem.
> In order to switch between 2ch and 8ch mode.  AIU_RST_SOFT_I2S_FAST and
> AIU_I2S_SYNC shall be "poked" (check iu-fifo-i2s.c and
> aiu-encoder-i2c.c). Without this, the switch is not done.
> 
> What these do, how and when it should be done is unclear. I tried
> several combination. At the time I found something stable-ish but it was
> not perfect.
> 
> At the time, It was completely new driver. Even if was not rock solid,
> it was still progress and I opted to upstream it with an imperfect 8ch
> support so people could help debug it. This was mentioned in the
> original submission.
> 
> The other solution is to restrict to 2ch mode and remove
> AIU_RST_SOFT_I2S_FAST and AIU_I2S_SYNC pokes. There will be no noise
> anymore.
> 

Hi, Jerome,

Thanks for the extensive clarification. I have compiled 5.15-rc3
commenting out the pokes for 8ch as you have suggested, both for
AIU_RST_SOFT_I2S_FAST and AIU_I2S_SYNC in both aiu-fifo-i2s.c
and aiu-encoder-i2c.c.

It works, the bug is gone just like you said it would be.

My suggestion is that, for the time being, until someone can solve
this properly, you restrict enablement of 8ch configuration under
an EXPERIMENTAL kernel option, with a big fat warning in the help
description, saying it will break 2ch.

Last but no least, thanks for helping Martin out.

Thank you,
Geraldo Nascimento
