Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EC83F7EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhHYXF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 19:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhHYXFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 19:05:55 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD5C061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:05:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id b4so2225977lfo.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5dYfTfFoEwQ2ICJl8SbDnguBvvNuF7k4gO0Z6GR4+UM=;
        b=g/m4ReYERQ60sWtKULs1pWrY8SBQexh9FfmV5YpThCdAz2L1kLRRduThW9cjrksS3+
         IFEAIIYkruJsn5oosvTHtZTNmTwMy1mYwBIFTNkBMgR/yn1/bZ1Dp7L6JZK/rbH8ClI8
         KK0o/FeRxPO6SsOnrukQ7rrD1LLt6J5iS5qEjZOUJUZUWbB5enosavl7TBLCSne840YR
         fTE5RDDvYp+sduuImvjS2HE0L5AATnJvIk2QjEYBi4dkSaTKH2y26KQCBoDFxiv1vG4N
         tTxpiUvwGaqkQWoshHsfmzWCHubpbqK89Xs65iWcWJV2Evz/gkpvuDE64vhUUn2/ll5o
         BqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5dYfTfFoEwQ2ICJl8SbDnguBvvNuF7k4gO0Z6GR4+UM=;
        b=iHbTYibubtGezsWFw+ahH2c0HHaDJpfrlRvNJdnIaE1u8q5bWESyKyv/kF4FeR177A
         uniMtdQ1Uhf3XSnhhG/xDhvqJ3f+GZ4gGUpff2l1DItXrWoskC79+Nsai9uuIFCTQx1R
         4zFOhboT+jHZYN2TMxL2zUxpnkb7GEgbKTeBQjj7hRYm1V0Oo8r0CgGw2iQ98UrSbmCD
         BHU1L8i/dYVIiuOpVA8Y4yzyxbPi/dejI9X5M7ZEP+8Mj9iZe8VUwxlbiDjm+st+9NMR
         OZNnPHN86VEHzSClFyPLk3wIh2kGKVOUS29eZf63YxKrcKBjqdPYKH4PNmxxlR1ePAfU
         d9WQ==
X-Gm-Message-State: AOAM530xlfz0vTsoyf3b5v2wUZlk7ldifudNIeGhjpaRFhQEtM/b4QOL
        yfVkgv4IlcdZIVG/6P5C9us9V6+fcKjxTxquSThMrg==
X-Google-Smtp-Source: ABdhPJwSnZtx/HfebEdviL7/cv+ShoseoKsJ2jhLLJ8/O582m6ZCtLffQRwT1ToFRuBUMeoSuaYhu80DydU/OY0rgQ0=
X-Received: by 2002:a19:7117:: with SMTP id m23mr374169lfc.73.1629932707242;
 Wed, 25 Aug 2021 16:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <202108241301.UdSncTEq-lkp@intel.com> <77ba5fc1-2bfa-0e9f-525c-dc260642c7ab@linux.intel.com>
In-Reply-To: <77ba5fc1-2bfa-0e9f-525c-dc260642c7ab@linux.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Aug 2021 16:04:56 -0700
Message-ID: <CAKwvOdm9-O=qcaexQ1+quRCXg6HZsABhDm=XQTfD841FL2m4Zg@mail.gmail.com>
Subject: Re: sound/soc/sof/intel/hda-dai.c:265:22: warning: Value stored to
 'sdev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Bard Liao <bard.liao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 9:53 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> Thanks for the report, I am not sure it's a real issue?
> >>> sound/soc/sof/intel/hda-dai.c:265:22: warning: Value stored to 'sdev' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
> >            struct snd_sof_dev *sdev =
> >                                ^~~~
> >    sound/soc/sof/intel/hda-dai.c:265:22: note: Value stored to 'sdev' during its initialization is never read
> >            struct snd_sof_dev *sdev =
> >                                ^~~~
> > fdd961e37e47f2 Keyon Jie         2019-04-12  259
> > fdd961e37e47f2 Keyon Jie         2019-04-12  260  static int hda_link_pcm_prepare(struct snd_pcm_substream *substream,
> > fdd961e37e47f2 Keyon Jie         2019-04-12  261                              struct snd_soc_dai *dai)
> > fdd961e37e47f2 Keyon Jie         2019-04-12  262  {
> > ed3baacd76baa0 Ranjani Sridharan 2019-04-30  263      struct hdac_ext_stream *link_dev =
> > ed3baacd76baa0 Ranjani Sridharan 2019-04-30  264                              snd_soc_dai_get_dma_data(dai, substream);
> > fdd961e37e47f2 Keyon Jie         2019-04-12 @265      struct snd_sof_dev *sdev =
> > fdd961e37e47f2 Keyon Jie         2019-04-12  266                              snd_soc_component_get_drvdata(dai->component);
> > 1205300af9dba3 Kuninori Morimoto 2020-07-20  267      struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> > fdd961e37e47f2 Keyon Jie         2019-04-12  268      int stream = substream->stream;
> > fdd961e37e47f2 Keyon Jie         2019-04-12  269
> > a3ebccb52efdfb Kai Vehmanen      2019-07-22  270      if (link_dev->link_prepared)
> > fdd961e37e47f2 Keyon Jie         2019-04-12  271              return 0;
> > fdd961e37e47f2 Keyon Jie         2019-04-12  272
> > ed3baacd76baa0 Ranjani Sridharan 2019-04-30  273      dev_dbg(sdev->dev, "hda: prepare stream dir %d\n", substream->stream);
> > fdd961e37e47f2 Keyon Jie         2019-04-12  274
> > fdd961e37e47f2 Keyon Jie         2019-04-12  275      return hda_link_hw_params(substream, &rtd->dpcm[stream].hw_params,
> > fdd961e37e47f2 Keyon Jie         2019-04-12  276                                dai);
> > fdd961e37e47f2 Keyon Jie         2019-04-12  277  }
> > fdd961e37e47f2 Keyon Jie         2019-04-12  278
>
> The sdev variable is used in the dev_dbg() log, this looks legit to me?

Perhaps that depends on a config that was not set? The log does say
this is a randconfig build.

-- 
Thanks,
~Nick Desaulniers
