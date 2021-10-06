Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A24247B9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 22:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbhJFUJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 16:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhJFUJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 16:09:31 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071D5C061746
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 13:07:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id p4so3839719qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 13:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdJ09V/pcQE6r3HiadtvxvIguyjALgPrkh/XKOwV7Jk=;
        b=Yic4R7P/hfuCQhHrbkUgWVJS89QccJE249K19g3fzSPI4hTMrWOZ2lxkWwE5NY7hQ/
         t5kl2K2VTy5LkXfREvMJTBt6lkxVIKEnRwzUsM4mz28ZyOPo60Fc6gtYV+ya0ZZ2LBdE
         FIcfsrvB/70ElBECtyZ/FXg7iDQVsFcamXc3fdZv7XhaTLlX9uu4/5/MRHqNY9EIJIMZ
         XnuPxNR1tYCKrUTY2TRDOQf4pYa6mmiD0SdvgyqR53AghrTii4QY6V2sX3lvlwJyrEN+
         KZG8Jik+Vzx++AtwcQC2PuiP4Ybzub3x3Fw2y+o78dAhpRDYqLJB0Pa1bhb6+zD+UQZ9
         UWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdJ09V/pcQE6r3HiadtvxvIguyjALgPrkh/XKOwV7Jk=;
        b=lUFmTHh3Uyqe7upqIUjCOkJeAYgoFbz+aJpOYVdtV6yfseM8RBCtw1XEONkp4T5EjV
         L2sea+JmKZo41/jHxq9/PY6fHlFLd3VL573zwXtI/wCOBNcpEJJHZw/FKRTaqEpHXjjb
         jXjPz4qVyHPitg7smRKjECs6FzzXv8K9cyYt/R/vPl2ITBP173k7/LaNzXQUJ7I2ZDMf
         451wE4y/fitwPdvmVOvYY7BGV8iXJmHbu/8GE4jEC5p8mZzFr6ZeBUHER1FAa/CAJLv7
         ELR5xnX13hnnj8Z5EKqcDsW1xpAnvxM0wCx7Wzf9b+PMgboLpEkcZdEdE+7uPWNBMwti
         7NjA==
X-Gm-Message-State: AOAM531f/+KqvVw9f0wLV3N6SU18328gzM95tun/+mFtztdUOBsBsbmA
        mkuHfVaxVpdIMgFmoVoYG46ymmYSndmQeZ3Zsr8FTg==
X-Google-Smtp-Source: ABdhPJwXdoCb5tl7ZEp7CnIq1HAWDaj0IstOTAg0lznv3mEsLUPCwmAmCxkokdL/lnD30jYUW8BSJPEYZFLPEHJuhTY=
X-Received: by 2002:a05:620a:638:: with SMTP id 24mr73965qkv.333.1633550856863;
 Wed, 06 Oct 2021 13:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211006161805.938950-1-brent.lu@intel.com> <20211006161805.938950-4-brent.lu@intel.com>
 <CAOReqxjGX6fwqNjX0i31JiQJ+vRCMNTTFBhn7L=iPzYvVMk9mQ@mail.gmail.com>
 <0482534d-46c4-5cee-25bd-8739e80a00f0@linux.intel.com> <CAOReqxisH_9TuP_v77JzdQ+v+duPvvyHNHBxXzGJZ3dMoyMczQ@mail.gmail.com>
 <dfd23e78-b7c8-fa77-035e-19c9af595719@linux.intel.com>
In-Reply-To: <dfd23e78-b7c8-fa77-035e-19c9af595719@linux.intel.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Wed, 6 Oct 2021 13:07:25 -0700
Message-ID: <CAOReqxjAO0DpOvfpUwXH4ad+7Bx22TBxQUopBJKAwO8DpGJ20Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: Intel: sof_rt5682: use id_alt to enumerate rt5682s
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Brent Lu <brent.lu@intel.com>,
        ALSA development <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <bard.liao@intel.com>,
        Malik_Hsu <malik_hsu@wistron.corp-partner.google.com>,
        Libin Yang <libin.yang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Gongjun Song <gongjun.song@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 12:58 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> > I don't see an issue with still using a struct since we are using the
> > same list across multiple machines, but this makes me wonder if maybe
> > we should refactor this into another layer, having the ids at a top
> > structure and then the speaker matches a layer down. E.g.
> >
> >  struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
> >         {
> >                 .drv_name = "adl_mx98373_rt5682",
> >                 .machine_quirk = snd_soc_acpi_codec_list,
> >                 .quirk_data = &adl_max98373_amp,
> >         },
> >         {
> >                 .drv_name = "adl_mx98357_rt5682",
> >                 .machine_quirk = snd_soc_acpi_codec_list,
> >                 .quirk_data = &adl_max98357a_amp,
> >         },
> >         {
> >                 .drv_name = "adl_mx98360_rt5682",
> >                 .machine_quirk = snd_soc_acpi_codec_list,
> >                 .quirk_data = &adl_max98360a_amp,
> >         }
> > }
> >
> > struct machine_driver adl_rt5682_driver_match {
> >   .id = { "10EC5682", "RTL5682" }
> >   .instances = &adl_rt5682_machines
> > }
>
> We probably need to experiment various options, on one hand the proposal
> removes duplication but in a lot of cases outside of Chromebooks/rt5640
> there is none, so that table rework adds an indirection with no real
> benefit.

Fair point, given the current situation this would benefit RTK boards
only. I have no idea if we will end up in the same boat with any other
boards, but given the current supply chain status I would expect this
(multi-sourcing) to be a way of the future. So maybe an idea we pocket
for now and deploy when we end up in this situation  with more
drivers.
