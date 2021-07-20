Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8853CFCFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhGTOZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 10:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbhGTORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:17:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D89C0613DF;
        Tue, 20 Jul 2021 07:54:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l7so26314921wrv.7;
        Tue, 20 Jul 2021 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNycMokbRMwikeyoAHQCESJsyNbzXAEXdH5RzfLsN2g=;
        b=sq2GfwkWgtJq/voM2yYyIl7B/T50wwQz6OkFIUVoW7ectnZBqU5cN2ZcHwAz+Q8DGg
         Bqj9MCkHHHDcuj9KvjhrYo8zMX5ojzQ+CEU84XO3QVgYnuoPDbPWoP9U21nAfRAjKxg4
         h23La1DzhffCKKGrhWgI91rYjBDrPd3W8Eu5jS7P2GcIZWvmLsYzU5g6B9MgT8aQg8hF
         Ce/Ebju8OXMaHnlYM4EIRMun8RPfBgifdOayq2CJiF1Bz5TJQ91cgDl/edzf6V3jGZwP
         3hDbXX/9MFDyOvSe/F5TvkinRowcv22n3fvinaduJfTVLds/gVpU4iexOExmiWAJPmmD
         ugyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNycMokbRMwikeyoAHQCESJsyNbzXAEXdH5RzfLsN2g=;
        b=Wf/i/19ELOWn2+DCWfPKJs3OBYEVkGDrZ/2Z5Ibc3Ud9ACOiqeFUa6PTe1KRB8dsRl
         2uhZylmCueGFQkBX1JR6jmV39ErNYVO4MgdQx2ifNgWAwnSYQ0CbRiworI+BAOq84yJr
         kin3Incvjp/0O1jVhULDYyBDMqEKZstREyN06JYkFdNhMi27fMpJYHIRpYHDIImIioDK
         NvuBd0aYl55erpEx2umGWEss84oUlBwLuPjkYwx3FVD1X2OlMwvoiC9munQaB0MvLmhh
         bk6mG1/e1uM3na3vRgh++jhUXJXSsnFugetwO9SiqdMdLHOhIkAH/Lt7uCLFYr54204U
         lmHA==
X-Gm-Message-State: AOAM532bflsE8V3t8/8gEnln1yAbrck8l5SKOQojgMF3hon1Kx6HhEUd
        97lIj+MGQ/iLrvZfT0RNnxJj+C+D6vmfIQbKIuc=
X-Google-Smtp-Source: ABdhPJxUiK8/9zrhS7PhJr1vPsN8q52xT9V3GHC5gkdRzBXAs0Hlk0laq2XNR2wQYxS7ypkuk0cvkTtEGHp3+4IUY2c=
X-Received: by 2002:adf:ed0f:: with SMTP id a15mr1877095wro.78.1626792863772;
 Tue, 20 Jul 2021 07:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141802.880911-1-daniel.baluta@oss.nxp.com>
 <20210715141802.880911-2-daniel.baluta@oss.nxp.com> <20210715143906.GD4590@sirena.org.uk>
 <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
In-Reply-To: <CAEnQRZCdSLoaLVZ7-jtufgZCG6QshMwdfyJy_4oE6cXRbA5H8A@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 20 Jul 2021 17:54:11 +0300
Message-ID: <CAEnQRZCiC5aGK6AsD0TN5fzN6AxFn6=f8hCrd2B9fhCYfCFOSg@mail.gmail.com>
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

Hi Pierre, Liam, Mark,

On Fri, Jul 16, 2021 at 5:31 PM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Thu, Jul 15, 2021 at 5:39 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Jul 15, 2021 at 05:18:00PM +0300, Daniel Baluta wrote:
> >
> > > Introduce two DT properties in dsp node:
> > >       * fw-filename, optional property giving the firmware filename
> > >       (if this is missing fw filename is read from board description)
> > >       * tplg-filename, mandatory giving the topology filename.
> >
> > These sound entirely like operating system configuration which I'd
> > expect to be inferred from the machine identification.  What happens if
> > a system has multiple options for firmware files, or if the OS ships the
> > topology and firmware bundled up in a single image to avoid them getting
> > out of sync?  What's the benefit of putting them in the DT?

Can you help me with this, specifically for selecting topology name.

I think I'm fine selecting a default value for SOF firmware name. It
looks like even
for Intel platforms there is no way of changing the firmware name.

But how about selecting topology name? We have lots of audio scenarios
that can run on the exact same hardware:
- e.g
   - Audio PCM playback + Post Processing
   - Audio Compress playback
   - Keyword detection


So, we need to use different topologies to select the scenario we want
to demonstrate.

Would it be acceptable to add tplg_name as a module parameter?

thanks,
Daniel.
