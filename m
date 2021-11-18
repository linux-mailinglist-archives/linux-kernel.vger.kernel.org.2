Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32502455246
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 02:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242296AbhKRBja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 20:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242280AbhKRBj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 20:39:28 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F70C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:36:28 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso8039651otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 17:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=9klc8dAWLIAubPklXVyh2fWbEFTP2hyfnLgaBXBCupk=;
        b=gm/ER4diKPKHKzcanyuOyKFEAaBC80UL4emy4g9pwIdas+tID4z4DofaLSACBAdJWJ
         6eRAFc9WkfAGEDe7dAvKWPMYK/nsGr8bKEGuynfyPQdM/1DXAxHU3WdSFGUPBq688mE8
         r8dsWUGLcqGMnGoiENXgHzTSocHtwot/CugYM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=9klc8dAWLIAubPklXVyh2fWbEFTP2hyfnLgaBXBCupk=;
        b=LUgjE5Rx3Me7TaRVrHHg4lylEUAxvzNRomHiVloAHS6/wsxWc9QcqaG47jOp5YTtWm
         yYJ9ULfBSnvnB73lf1eALNwPTSwp6zkGd6kSXLc2xxUDSNXXM+1fntK0htO5cjAusciC
         GE4pTDqe+6iCHtGwTTeE8kue5vvmxCzsKA6M1xULAg/ID4xNELyEi2OEixrvhkohIuG8
         L+acF22Pt1JfD15TGGb1c4p5L0hERL1Vk79fgzIbSSuw8MRnPtk23pioDjO9geEtvIzs
         DuL6DNXnGvTPGdQezca0c7lngpofFrWiBTuKkUBvUsDgWvT9Btw/uXpRBJ17QC7WNEgV
         WAiw==
X-Gm-Message-State: AOAM533CUaLNA+r4xnNtAESC19YSZcFYgNAxaV1JdsTwb/Kfq72luo7j
        EjdSyZNL1Nr6Z7ArqIRsNBoKu6brWSEF4Ql0n+m05g==
X-Google-Smtp-Source: ABdhPJxKd82uGdEAMk68vFffNMn/X25qk2e/DsVmbx5gTcvbt9QWX11Tks6gt8LfLbpB/OZhMEehjVPDGZs8hMou7WU=
X-Received: by 2002:a9d:2243:: with SMTP id o61mr5815934ota.126.1637199388369;
 Wed, 17 Nov 2021 17:36:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Nov 2021 17:36:28 -0800
MIME-Version: 1.0
In-Reply-To: <20211118010453.843286-2-robdclark@gmail.com>
References: <20211118010453.843286-1-robdclark@gmail.com> <20211118010453.843286-2-robdclark@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 17 Nov 2021 17:36:27 -0800
Message-ID: <CAE-0n52AAfNqYP5MM1CUntkM15ftskuPVRNyCbBdCbp8mFHL2Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: rt5682s: Fix crash due to out of scope stack vars
To:     Rob Clark <robdclark@gmail.com>, alsa-devel@alsa-project.org
Cc:     Derek Fang <derek.fang@realtek.com>, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Clark (2021-11-17 17:04:53)
> From: Rob Clark <robdclark@chromium.org>
>
> Move the declaration of temporary arrays to somewhere that won't go out
> of scope before the devm_clk_hw_register() call, lest we be at the whim
> of the compiler for whether those stack variables get overwritten.
>
> Fixes a crash seen with gcc version 11.2.1 20210728 (Red Hat 11.2.1-1)
>
> Fixes: bdd229ab26be ("ASoC: rt5682s: Add driver for ALC5682I-VS codec")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
