Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB3434ACC6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhCZQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:45:19 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57683 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhCZQpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:45:10 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MTzve-1lGaCf0udG-00R4FF for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021
 17:45:07 +0100
Received: by mail-ot1-f48.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so5780606otk.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:45:06 -0700 (PDT)
X-Gm-Message-State: AOAM533iijlYiDHDXwsW+poA+ri7u2R8sXMdAw0kRSw8zylPEc53rq46
        0wFAHqXL29Ctt9d5s9FVM9nAwWuuOpk9wci+Cxc=
X-Google-Smtp-Source: ABdhPJwI2Qsw1sWTOFhkHH3uplM9/Zbn4oxxxmqJ1LvEGTO2EKJkU2GG1NEpUCYJ/hXdG9knvq0hYYTsIszKxXiGQpM=
X-Received: by 2002:a05:6830:14c1:: with SMTP id t1mr12487281otq.305.1616777105952;
 Fri, 26 Mar 2021 09:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <1616777074-5151-1-git-send-email-Vijendar.Mukunda@amd.com> <1616777074-5151-2-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1616777074-5151-2-git-send-email-Vijendar.Mukunda@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Mar 2021 17:44:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0aM4GRZ62TvNpwtMY0Bw7JGJNVs55UkpdBVYeKgWhMaQ@mail.gmail.com>
Message-ID: <CAK8P3a0aM4GRZ62TvNpwtMY0Bw7JGJNVs55UkpdBVYeKgWhMaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: amd: fix acpi dependency kernel warning
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:l6P7bzd03MjR1Tz7h6pvFFdJCrQ55kyD8FYWIYiE8lUdpbztEk9
 80RtsZRaL4N4KQZ/viQXTzrAzFJHswkwJJnpc/tSH1+US+wfA3l3n0BqtIHxSUSizvSaQVF
 WKtxvR+Zc8TnKQYClfR8tYTI7lg92Jnu82hkihguZV0OM2FbB+J33o7ckP5nYeIqdSA/NKW
 FMQkKYBN6EToMJo7gMjfg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hiQhe9+vVoU=:42phf3I5qxiOI/BX/vYISd
 8O/rEFxiHRVFg9YjtTxq1Pr0O+TFWlgjzKcse2fJMGyqVu8PRI+N8vc4KeSXfUVncynJMDG92
 1fS4QXMBTgvUkVh8HqAeT31rsrekgud9dtMwiI/EHKFQ1yrqvTjh9S436ZO8a20inIawPtUnq
 +NMFaS3Res+1Qc+YbuFDzWQNEpMIYc+kuLhA7zIAb8AdIM0C4m5ny/pP6VsiHPw0f8X5DkZVb
 yV7D7SQUTu5laSuRcXOihxQ1/fWgSFQLyoGbDBat2mm/oLMSykGUfUAiRFFZ90D9SUjC4wKVo
 O3t8Cp/vet1zGUIkINr8B9ox+agFqmegAjetWRVMLr2KYZcZcuPYUn5ZmoCIkAugp62WSAWkr
 Tjru0iwegmindC3w6IJ13P5KogUjcvVPOEBCjgKkENxhQJfj0De3ETB1CmR9MsGoDW7OHuUby
 ZHc7ERylLLQSccTCd08ctaX8tSMVpul86v0TyGbSt6VcUX/93CFyEGcY/JBHWMQBH5bZMGyyA
 ia6Kf6/BRDV0sMQnUmaBv9O5b5sibIni0ZCx0/ACRg+VLYd+yQ8XP02Wvw6IYjNjdUaSHWXn/
 +CgATO9YWbvcRRFAu/Dh2C+s2Lpg9YTAcK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 5:44 PM Vijendar Mukunda
<Vijendar.Mukunda@amd.com> wrote:
>
> Fix ACPI dependency kernel warning produced by powerpc
> allyesconfig.
>
> sound/soc/amd/acp-da7219-max98357a.c:684:28: warning:
> 'cz_rt5682_card' defined but not used [-Wunused-variable]
>
> sound/soc/amd/acp-da7219-max98357a.c:671:28: warning: 'cz_card'
> defined but not used [-Wunused-variable]

I would suggest simply dropping the unnecessary #ifdef and
ACPI_PTR() guard.

It might be helpful to hide the Kconfig submenu under
'depends on X86 || COMPILE_TEST'.

       Arnd
