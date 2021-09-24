Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F05416CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244398AbhIXHoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244368AbhIXHoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 03:44:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7361C061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 00:42:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id t28so11125350wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 00:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BBAd8fkMceztBjAtolBY+N3vN1kqGZCk7vffXjVFyyw=;
        b=lI4AkeDOM+xZJOobC3Y+DWU/frUKH2+B93ekBGI50eraV0g9q691WSkzujuEP0nHqL
         5WTxxpIdsIcax7M0QAOXdhFIHs70HhDapuBbGGOcK2ddRxo7xWA2FfAPXrVpfZYUzzHz
         nAjiN5pgphtzYdNU93GJu8+w4kjHUCg2LVAHoWHH9SuboXixA3T/+BGoUF7WGZRXDsyG
         SVytETOVISme8eQwc9As1u31cbb2fOFIjshRPhz22cJKeYzyFZQfCgfOR5fQzgcpvzPp
         UdrWOLEflGAWeKzepSyEDYIpqBlMz4pblDZOs8xCfYDgXtVfC0nvReG97sAzAo88gUNk
         Uz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BBAd8fkMceztBjAtolBY+N3vN1kqGZCk7vffXjVFyyw=;
        b=b3mfROLYxC0QeHaS0MDXt1aoEoDAbIHXensgFeuZhwSWx4JHkFU7+b7EGuds3kP+p+
         tvitr2CkmXMPPL22AMK2tyKW4zHLKU6MOkxBfzVtLzm/dpDTYzDxB8SSs7Ihz1F7PInd
         fBUuTIcc6bg/KWCe4t/kFbA92XYHzvTEbR/Zi2Myegu1TqlnO9ezra18fpUIImDlANuY
         /rZvrWQmadL3xwCO91T0M7RMfFeyAILsnYzMj0lyxv897ruRj/aK7m2NG4a+ab/tXJGb
         1eIzF7XrDUbxSB6ZcTB3VVFoqEhVAeKhKLp9RTsLaow83t8WCHvcStCV04SNy+S4xKxZ
         rZuQ==
X-Gm-Message-State: AOAM530n+cqtsDH+MWrsduCHUgsNbt+OO95UdQgJTYQyCaYyxU3OE7hS
        Jh4KLQDwnWXf13BiwUeNumA+f10J+dAWdnGDGxW3SkUn
X-Google-Smtp-Source: ABdhPJxaXrfNpQGZX/DyzRVCa4s8UJYwiDGtNrK6e7v5FPo6xZ5cL9n0XnRxzQwfglrPgO3Xd5a81wQRulojrAK6zSY=
X-Received: by 2002:adf:e649:: with SMTP id b9mr9775010wrn.309.1632469346307;
 Fri, 24 Sep 2021 00:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210917143659.401102-1-daniel.baluta@oss.nxp.com>
 <20210917143659.401102-11-daniel.baluta@oss.nxp.com> <203bf6cd-6407-f01d-52c3-e399d06cb3f6@linux.intel.com>
 <b90eff84-b56c-7764-a5bb-f1e07db57cc3@linux.intel.com> <ab4ea50f-9149-3468-ce2b-7cd421095b40@linux.intel.com>
In-Reply-To: <ab4ea50f-9149-3468-ce2b-7cd421095b40@linux.intel.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 24 Sep 2021 10:42:13 +0300
Message-ID: <CAEnQRZDmubE9aLG+7YtTeRTB2euqGpRh8FWqtgV5+h3H3M8JGA@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] ASoC: SOF: Intel: hda: make sure DAI widget is
 set up before IPC
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 4:04 PM P=C3=A9ter Ujfalusi
<peter.ujfalusi@linux.intel.com> wrote:
>
>
>
> On 23/09/2021 15:58, Pierre-Louis Bossart wrote:
> >
> >>> +static struct sof_ipc_dai_config *hda_dai_update_config(struct snd_s=
oc_dapm_widget *w,
> >>> +                                                   int channel)
> >>>  {
> >>> +   struct snd_sof_widget *swidget =3D w->dobj.private;
> >>>     struct sof_ipc_dai_config *config;
> >>>     struct snd_sof_dai *sof_dai;
> >>> -   struct sof_ipc_reply reply;
> >>> -   int ret =3D 0;
> >>>
> >>> -   list_for_each_entry(sof_dai, &hda_stream->sdev->dai_list, list) {
> >>> -           if (!sof_dai->cpu_dai_name)
> >>> -                   continue;
> >>> +   if (!swidget) {
> >>> +           dev_err(swidget->scomp->dev, "error: No private data for =
widget %s\n", w->name);
> >>
> >> NULL pointer dereference, just return NULL without the print. The call=
er
> >> is printing anyways.
> >
> > yes good catch, we need a v3 with the fixes suggested by Peter in
> > https://github.com/thesofproject/linux/pull/3171/ applied.
>
> Only the second patch in the PR is applicable for upstream, but it
> should be squashed in for v3.

Thanks Peter, will squash this in and send v3.
