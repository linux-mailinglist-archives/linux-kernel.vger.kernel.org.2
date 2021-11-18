Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E64F455824
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 10:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245184AbhKRJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 04:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbhKRJiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 04:38:00 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4BC061200
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:34:53 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so4283666wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 01:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2DiSr4GR4f0kjFqr84VgVUga2wtQ7vPvvBID6YBxB0=;
        b=CiErSrtGCWUEyZLfMvqTPhoO+PVvYr8F4A/5/etcwClx83yVS+uPMJHMAV81hFpwuL
         ijJni+mNbJahK2jRN4xnBWN4RDUl03g5k3nH81jW+Bi8+N+mZcdxgjBQw6ggUb5/Lv+T
         25/OlDXEoVqx+yw1VvwE1F6vhzIew79cm+7RpMypbiXuB91wHPxhurB5VblAa8iz0yBZ
         IEi6YXy2yKHdrHNXqrB6GADYDqg3tqovdTywZD5Be7MGQ8iC05jQKTj7UPC8wAxUGJ7p
         49GezO1MH3RV148uGhPaQZcUy30h5v8dOsxT/JT3vV8g/MHDIzuwS8hcP423hBk7FE46
         El2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2DiSr4GR4f0kjFqr84VgVUga2wtQ7vPvvBID6YBxB0=;
        b=SeUp/fZT5IPfAWjwO+oeRwYkOa48Mvp6gGQxcdqIv39b2W8wq/FVV+LmQLppp5LfHI
         RVCtdghcn7aFh1ECLkYfnENJB8DR9r6VBVbeaIG3i52vz/fGiIHn8s53jUwvVsi3vFOG
         Zd9TxwGhKB6AOnqggzoSsKf21OZHU2K7Nc+OKHgyE+5jg0gaMn7Yu+f7mRlk/EbDqMOL
         2vaZl39CcGubi/npisZnyhdXlWvRSYKEVO7xX740eqdOJH7REdxufnOZ61TMpvk7UXyE
         r3XHGUKdNEBSbkHlAu4KJEacOJGRLmDvpaF6Hwu6iOq81h/5bVQb+im8YZ1fcxjOLwoy
         Ne3g==
X-Gm-Message-State: AOAM532bvyF5TVj7pcHIgKacviPPYuTVRovF8SqBmfX/kr1V1OytqAiQ
        cnxL2RDaRGIDyIUavUX+zJXEnvoMxQtPp02anY4=
X-Google-Smtp-Source: ABdhPJxAyZQQg4jwIc6CPnTIVq1jJ9tsO++0Yd/XdFFaJWYGlAjIir88iOm9kpfeZWiCt8G3ActVocgcY5UV2vySexI=
X-Received: by 2002:a05:600c:500a:: with SMTP id n10mr8907382wmr.136.1637228091333;
 Thu, 18 Nov 2021 01:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20211117093734.17407-1-daniel.baluta@oss.nxp.com>
 <20211117093734.17407-17-daniel.baluta@oss.nxp.com> <YZU75B2JHbYHy40l@sirena.org.uk>
 <e918b4c4-dc85-dcf5-2781-5edfcd1bf1a5@nxp.com>
In-Reply-To: <e918b4c4-dc85-dcf5-2781-5edfcd1bf1a5@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 18 Nov 2021 11:34:38 +0200
Message-ID: <CAEnQRZBCc4bhX-sT43KT6Tb-=RK=J9poxRvEM_H=1oXh0_AsPA@mail.gmail.com>
Subject: Re: [PATCH 16/21] ASoC: SOF: topology: Add support for Mediatek AFE DAI
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>, AjitKumar.Pandey@amd.com,
        Balakishore.pati@amd.com, vsreddy@amd.com,
        Julian.Schroeder@amd.com, vishnuvardhanrao.ravulapati@amd.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?WUMgSHVuZyAo5rSq5aCv5L+KKQ==?= <yc.hung@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

I noticed that you already applied this. Should I resend the entire
series or just a fixup?

On Wed, Nov 17, 2021 at 7:32 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
>
> On 11/17/21 7:29 PM, Mark Brown wrote:
> > On Wed, Nov 17, 2021 at 11:37:29AM +0200, Daniel Baluta wrote:
> >> From: YC Hung <yc.hung@mediatek.com>
> >>
> >> Add new sof dai and config to pass topology file configuration
> >> to SOF firmware running on Mediatek platform DSP core.
> >> Add mediatek audio front end(AFE) to the list of supported sof_dais
> > This breaks an x86 allmodconfig build:
> >
> > /mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c: In function 'mt8195_run':
> > /mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c:207:2: error: implicit declaration of function 'sof_hifixdsp_boot_sequence' [-Werror=implicit-function-declaration]
> >    207 |  sof_hifixdsp_boot_sequence(sdev, adsp_bootup_addr);
> >        |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > At top level:
> > /mnt/kernel/sound/soc/sof/mediatek/mt8195/mt8195.c:201:12: error: 'mt8195_run' defined but not used [-Werror=unused-function]
> >    201 | static int mt8195_run(struct snd_sof_dev *sdev)
> >        |            ^~~~~~~~~~
> > cc1: all warnings being treated as errors
> >
> > _boot_sequence is added in "ASoC: SOF: mediatek: Add fw loader and
> > mt8195 dsp ops to load firmware" which is later in the series.
> >
> > mt8195_run should be either global, a static inline or not declared in
> > the header at all.
>
>
> YC,
>
> Please send a fix for this on top of topic/sof-dev. I will take care of
> the squash and resend.
>
>
>
