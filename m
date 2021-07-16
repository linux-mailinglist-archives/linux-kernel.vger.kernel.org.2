Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7B33CB8B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbhGPOef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbhGPOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 10:34:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D40C06175F;
        Fri, 16 Jul 2021 07:31:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k4so12316996wrc.8;
        Fri, 16 Jul 2021 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfyxvApAZ/QZvHM+p5Z7vY05jWEPB2D5W608SFXmszc=;
        b=BiNw4S/nNGbPkUa1crFEo2Y0/F8w8G9auWNhNskkQ7COnYo5wnECAN/07YJpoA15yp
         y1j9atMh+9ZcfZvkqJHZZOVVfWp3KAck8GXvy2t4Cg8JgCV1qh9XHgPSMAAce6YDMMex
         zdX5hA4MXqMe2/4AATppa3CQUBcLOfDByMDaXEOxz3LVoQ7oodrpxekThqZg1gfGXnVT
         MwlYcN5MFT1Wix931dlrsHnYz1bSjLs5wnni+fYiOoBnStHh5zm16QQZqBeizLfQq9xh
         BDPNNDT4b7isNLQ4nHiFOVmdSb3o6bE4XTxgspU+fsXx4J2tKfYpVM0NgMhxfU7avYK9
         vsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfyxvApAZ/QZvHM+p5Z7vY05jWEPB2D5W608SFXmszc=;
        b=VBfFuN9L8nAHgZTyhMsNNfRKtUBdrMkyAYTa0hxsND3JILMYhXxDfwvkaOn8mS45zM
         02aYEiWIFZ2Q7XN4v3iAI+W+lK8MC5gX/wKyrLamxYgKQnFBUx2cYIUGsSpB+C+zgMCA
         na2DI9w2pQI5yIR2jsLJis7RxezqhBSA+U9iz4N0v1n1LAYl8BYx5njt+rXvAGDmzCw+
         fgsUwi/Ksgc6wfQBtU8r3BE5Bq8q+0FLE/ulWFNpLoH3hkdobxFobVVFwyOfgL5C+UIe
         elWDQGwr0OFWL4eQfkEr+OX8Ditqtn+Q8zbll2kJzmnohwuDzUD19EbD3siUjnO0GyIm
         ZYnA==
X-Gm-Message-State: AOAM532d4A8STElkw1piAem1Uh11b9P1N279U+JPI0HscUzOihaXazJN
        FKgc9qTKVCH3CWs9NI/8KETupMkoBxukmSb3DHI=
X-Google-Smtp-Source: ABdhPJzNsznePTaYmquFe11N5cDdMdqdLLKPdxNodbRML7ppVKehpfYQUESzJxYsB3WikgGIRh1AkH3Y73mC/3yvNEY=
X-Received: by 2002:a5d:6481:: with SMTP id o1mr13127552wri.164.1626445897440;
 Fri, 16 Jul 2021 07:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com> <20210715143906.GD4590@sirena.org.uk>
In-Reply-To: <20210715143906.GD4590@sirena.org.uk>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 16 Jul 2021 17:31:25 +0300
Message-ID: <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: SOF: Parse fw/tplg filename from DT
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 5:39 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 15, 2021 at 05:18:00PM +0300, Daniel Baluta wrote:
>
> > Introduce two DT properties in dsp node:
> >       * fw-filename, optional property giving the firmware filename
> >       (if this is missing fw filename is read from board description)
> >       * tplg-filename, mandatory giving the topology filename.
>
> These sound entirely like operating system configuration which I'd
> expect to be inferred from the machine identification.  What happens if
> a system has multiple options for firmware files, or if the OS ships the
> topology and firmware bundled up in a single image to avoid them getting
> out of sync?  What's the benefit of putting them in the DT?

We thought that if a system has multiple options for firmware files
we could use different Device Tree files. But indeed this doesn't scale.

It would be awkward to create a new dts just to change the firmware name.

Similarly for topology files. We might have:

- different audio scenarios (e.g different audio pipeline with
different components, e.g Post Processing Components, etc)
- different hardware attached to a board (e.g i.MX8 can have a
baseboard attached which brings in more codecs).

I think the best way to specify the audio firmware is via the board
description structure which is already
used to provide a default value for firmware file name.

Then for the topology used we could make that as a module parameter.

For us it is important to be able to use different topologies without
recompiling the kernel. So, far we just
used a simbolic link to the default topology file and change the
symbolic link to the desired topology and then reboot.
