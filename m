Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6559940F6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242303AbhIQLv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344034AbhIQLvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:51:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C029AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:50:13 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so12982558wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zh4y3yYp5KK3lr75X4zbnPk1B/CwLrGMoLkLYmrR1gI=;
        b=iPgDO7EsA/atP+gM8ulA5dhg9BKm6GfVZi/cI93K8fPebyy5nLpZzPdFci+qmdNHcQ
         GCFflkJ+U5ux5aU5h9O6nHwMS1R0H+AduKuIFUTWZx1vFg+qsVBPBS2/0UDm7XVx60le
         IJ3YDbpWUsdQ8+xcharkL9a4NittPzRej54bYEqrXeR3+S8RAUQ/SwlFVJjb2KsbqBz5
         TZ7KhCVW7TxtkZQTi6qWev24khX0SbtAK7oQapdZ+Vb95fhIXTjObRDRb9rPlIjissod
         Fl0W3YpoL0B3vRXLhIJZjblztgKJFeX6irb/cy3wxkvL4lB/s73XFgrGXKuwI3p5JIq4
         9whQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zh4y3yYp5KK3lr75X4zbnPk1B/CwLrGMoLkLYmrR1gI=;
        b=3HUn7cKIclRYBQn1h5Pw0QrB7YYsf9mmORVD1pqsNL3R1QcjOQbwplJxVa8Y/pcRxO
         MNcazIC7HGvdqxDLYRFA1ofmlDwY46occ0ka92RXc6/gL7hJ+makOzHkcHxA6QY4IXI5
         Lcb7EZUcZLZwwFuiijarX5S3ZVMIEUe/Z2q8eihDLtEYWt5l3FxS3s3GuAE7nz70iY5I
         64xrGNq5kh8oJ8v2KwNUMe5caUIgGLcILNq66QVFeI3tqdIF+wp6SYbIbDhQzp076I+X
         bjKyyDy13DxBk80OqOsqWB8SJaXGPEqv+pdSHECiT1PF1kfPUtokPRNVMKr6oBVM8aCE
         4r7Q==
X-Gm-Message-State: AOAM530u81pTRP+veMqeluRKFvAeHeSbtWP1tL4Er++dqLA1H7M9kTpQ
        UpqKXPt9NtmzAV7nzPnkX/tUms1VOCXqgTvjmkk=
X-Google-Smtp-Source: ABdhPJwJ9sdCFor0+VHLEPoXS/4JhRf09MVVcnOGywjnb+OfsOd3e4tKC3yjTVMN7tv6F8OP7Cyo+YNiV5bAYH3zdEU=
X-Received: by 2002:adf:d193:: with SMTP id v19mr11734422wrc.377.1631879412107;
 Fri, 17 Sep 2021 04:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210916111646.367133-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20210916111646.367133-1-daniel.baluta@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 17 Sep 2021 14:49:59 +0300
Message-ID: <CAEnQRZDr0BK=kX2D5Cnr5kvGMj8wYfNzAU6xMDn2RoNsYM9S-Q@mail.gmail.com>
Subject: Re: [PATCH 00/12] Add support for on demand pipeline setup/destroy
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Will send v2 for this. I got informed that I forgot my S-o-b tag.


On Thu, Sep 16, 2021 at 2:18 PM Daniel Baluta <daniel.baluta@oss.nxp.com> wrote:
>
> From: Daniel Baluta <daniel.baluta@nxp.com>
>
> This patchseries implements the new feature to setup/teardown pipeline
> as needed when a PCM is open/closed.
>
> Review with SOF community at https://github.com/thesofproject/linux/pull/2794
>
> Ranjani Sridharan (12):
>   ASoC: topology: change the complete op in snd_soc_tplg_ops to return
>     int
>   ASoC: SOF: control: Add access field in struct snd_sof_control
>   ASoC: SOF: topology: Add new token for dynamic pipeline
>   ASoC: SOF: sof-audio: add helpers for widgets, kcontrols and dai
>     config set up
>   AsoC: dapm: export a couple of functions
>   ASoC: SOF: Add new fields to snd_sof_route
>   ASoC: SOF: restore kcontrols for widget during set up
>   ASoC: SOF: Don't set up widgets during topology parsing
>   ASoC: SOF: Introduce widget use_count
>   ASoC: SOF: Intel: hda: make sure DAI widget is set up before IPC
>   ASoC: SOF: Add support for dynamic pipelines
>   ASoC: SOF: topology: Add kernel parameter for topology verification
>
>  include/sound/soc-dpcm.h               |   1 +
>  include/sound/soc-topology.h           |   2 +-
>  include/uapi/sound/sof/tokens.h        |   1 +
>  sound/soc/intel/skylake/skl-topology.c |   6 +-
>  sound/soc/soc-dapm.c                   |   2 +
>  sound/soc/soc-pcm.c                    |   4 +-
>  sound/soc/soc-topology.c               |  10 +-
>  sound/soc/sof/intel/hda-dai.c          | 176 +++---
>  sound/soc/sof/intel/hda.c              | 177 ++++--
>  sound/soc/sof/intel/hda.h              |   5 +
>  sound/soc/sof/ipc.c                    |  22 +
>  sound/soc/sof/pcm.c                    |  58 +-
>  sound/soc/sof/pm.c                     |   4 +-
>  sound/soc/sof/sof-audio.c              | 709 +++++++++++++++++++------
>  sound/soc/sof/sof-audio.h              |  32 +-
>  sound/soc/sof/sof-priv.h               |   1 +
>  sound/soc/sof/topology.c               | 362 +++++--------
>  17 files changed, 1034 insertions(+), 538 deletions(-)
>
> --
> 2.27.0
>
