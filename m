Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10D449B7B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhKHSOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234899AbhKHSOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:14:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 268DE61994
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636395101;
        bh=4miGct0x2e4uwPTJoDfwUndqCdd3VtKDYZ6yEFuB+us=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C4PBHKng8edDElM6qpjJtSddGmKofTG8dBANUlp2PpEfJZ1vatNwZDRHtnkfgaVSP
         QElhHm2JAwUS1PKz+KSV+JAt1s5t5g4x5UbqPJtg4Sk5JgT+FzSKe8WYicPu1G2MVm
         J86bqx62xfns8vUnetFXqUmE9DsHycSEWBbkgwjlnYWqvU4tQa2vZR06CKUryh6SVm
         2SIGrdA/A/vRqCoI3U+lN3hrobtuPBnBcJ+jaNEu9jrUa1Qdw15ufz9kzYrt64sUy2
         zRqY9XXy3wF9HxW2giV8PrNcsuhNRBwbGteoKJFmB9NwjQ3l1xlaYc2LmNuFefAN1B
         e/Gr7Z+JP+3bQ==
Received: by mail-wr1-f45.google.com with SMTP id c4so28462392wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:11:41 -0800 (PST)
X-Gm-Message-State: AOAM532si6MkuTPZH+xHGLhlmfa9lX+7Uq5GbuUR93qf2+WWmDKKn/cS
        g9nuyONBURWDqyScJ1FGYNFFdYAwUCXM9voP/hE=
X-Google-Smtp-Source: ABdhPJxbJNi7n8tAL3Jwa5ALZJw0iWi5JGBlyxbxQOoaZZN9HIADFmux1v0zDwJxQJ9u9Rv9zlt85oGm/j/OR8DXfXU=
X-Received: by 2002:a05:6000:18c7:: with SMTP id w7mr1242427wrq.411.1636395099591;
 Mon, 08 Nov 2021 10:11:39 -0800 (PST)
MIME-Version: 1.0
References: <20211108111132.3800548-1-arnd@kernel.org> <63c5b1fb-575e-f026-5a76-f08a366f7f38@linux.intel.com>
 <bae1a17c-af6e-d77a-19e7-f3f6408951fa@nxp.com> <CAK8P3a2-=-JM+p2b4v4F8O9O2ZhB-3Uhd_F+gcGAinAztSDH9A@mail.gmail.com>
 <948c8add-2a31-a7aa-f16c-8629dab690cc@linux.intel.com>
In-Reply-To: <948c8add-2a31-a7aa-f16c-8629dab690cc@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 8 Nov 2021 19:11:23 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2cmWe0G+Kyd=HZHdR0+eW=rktc6_i1PdRDBaBEYQOG4A@mail.gmail.com>
Message-ID: <CAK8P3a2cmWe0G+Kyd=HZHdR0+eW=rktc6_i1PdRDBaBEYQOG4A@mail.gmail.com>
Subject: Re: [Sound-open-firmware] [PATCH] ASoC: SOF: build compression
 interface into snd_sof.ko
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Daniel Baluta <daniel.baluta@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bud Liviu-Alexandru <budliviu@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 6:18 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 11/8/21 10:15 AM, Arnd Bergmann wrote:
> > On Mon, Nov 8, 2021 at 3:13 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> On a related note, with this randconfig we have a separate problem on an
> AMD patch on the SOF tree
>
> ERROR: modpost: "snd_amd_acp_find_config"
> [sound/soc/amd/snd-acp-config] is a static EXPORT_SYMBOL
>
> That wasn't detected earlier, any idea what Kconfig option I need to
> enable to filter this out?

I don't see that symbol on linux-next at all, so this must be a bug
that is specific to the
current SOF tree. The message tells you that snd_amd_acp_find_config should
not be exported at all since it's static, or it should not be marked
static because it
is used by other modules. IOW having a symbol that is both static and exported
means it's not usable from built-in drivers.

       Arnd
