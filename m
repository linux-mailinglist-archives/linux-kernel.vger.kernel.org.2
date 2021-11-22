Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF4459028
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 15:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbhKVO2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 09:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239182AbhKVO2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 09:28:01 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7B8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 06:24:54 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id b4so15408237pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 06:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnxeGymcCEbfmTiuZXDKf3tgkMXvkQvRUy5uTOBjZyQ=;
        b=ZV4YU+sUroW88Mme81TaD5ulHL5j6+arntSxDBIGSMkagUNi+Z+vYqeQeJPjZeTfRJ
         epUxzyLTLrOCNL026yHaMOUxDY5f8JuZEsfsV163LokQokZXnDskBqZMT1qRY0TNPDNj
         Pe8/YWGeDgZOK5SK+Dm96Ygve5v8P2/Kowrhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnxeGymcCEbfmTiuZXDKf3tgkMXvkQvRUy5uTOBjZyQ=;
        b=j0YmB/JrcBxuKmPtoDhYuPONpacOondfMispWqonBCcGZHBqiz95VWJ6IgnURN/5bn
         A9OT6frne4TmxrV+vMP+RpOlTRQtaL9ORvAtcntKkS6qgV6SYqy0F1xPLumK59Ad+Kol
         z/18tNtl2k2XRb+mNzIJLq8Eq9qc2WxMNSZQnF80D5nZcUKpdEmAa7eDbJQeyesoN16H
         2bkLZH0dSpIvIal2B4S1PRSyAWxIZwZFQazNthAv1nWUe8ZZOqoMwiHMm8QhrfH/s9IF
         P4I2sLyzhd3aeQSILfUnG0AMpx1UyVBoWAAIGB2Wa5d/JZs29ThCNc3dC7/J9mxQAD6w
         mIgg==
X-Gm-Message-State: AOAM533J0ZN4qms8DAlDIZcHHh3nXFVfKxSmK6QQfAG9FBR++/fLbfBX
        o0+QQE2bzYejbmRCVhkcNSWblA6LNh9y6vm0QaBasQ==
X-Google-Smtp-Source: ABdhPJwwnqKrt1uvX/kQIgmqdkM5eb/Z+4p3ejfkShcIYuNGlTkwcMUE82oN+F/w6i8Rc08gaFoGx+bildiyDfDae+w=
X-Received: by 2002:a63:6c49:: with SMTP id h70mr34108131pgc.368.1637591094319;
 Mon, 22 Nov 2021 06:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20211119153248.419802-1-ariel.dalessandro@collabora.com>
 <20211119153248.419802-3-ariel.dalessandro@collabora.com> <YZunmnHqemZRJ6JK@sirena.org.uk>
In-Reply-To: <YZunmnHqemZRJ6JK@sirena.org.uk>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Mon, 22 Nov 2021 15:24:42 +0100
Message-ID: <CAOf5uwnrUdF4fOVGvp8GmuUL6SpsyjPq46WBP7hcY7bYbw7RHA@mail.gmail.com>
Subject: Re: [RFC patch 2/5] ASoC: tlv320aic31xx: Add support for pll_r coefficient
To:     Mark Brown <broonie@kernel.org>
Cc:     "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bkylerussell@gmail.com, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, shengjiu.wang@gmail.com,
        tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark

On Mon, Nov 22, 2021 at 3:22 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Nov 19, 2021 at 12:32:45PM -0300, Ariel D'Alessandro wrote:
> > When the clock used by the codec is BCLK, the operation parameters need
> > to be calculated from input sample rate and format. Low frequency rates
> > required different r multipliers, in order to achieve a higher PLL
> > output frequency.
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>
> Did Michael write this code (in which case there should be a From: from
> him) or did he work on the code with you?  The signoffs are a little
> confusing.

It's fine. We are working together

Michael
