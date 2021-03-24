Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42F03476A3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 11:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhCXK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 06:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbhCXK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 06:56:54 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012EC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:56:51 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h10so27050982edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ToRLObeEBgXor/SnBvKlxaQPAAiDt0hrFEbYVfvSCnc=;
        b=elEEkbDKetS27RjdVzzPaXDGsWXC+eCWLe3lSxMWM24U6+BEsf71pQbbPS1MT7tRVG
         A11IyB0kOvl0ZedJAPzv7uOAcohiuwGf+cR4Lq4sSe3DuLfgcrQ83b82UDPHNZp97OIm
         OkrH/eL56i/9orrRl05h7Rtshwdl5b169LGfxXmkdl+QumjUpoOL9fs8wPsZ8crvT7dL
         DDHUoHkYlbATU4Ejvkk33BGXkVVlzhnnf7jqfCpzrr/8OG9mLv02MBV8MVz0cmvNohaW
         5BrsHEkA1Tc/P/7DvXKJHMygW3zrDzrQGTtMpkjytmu8YyhjqXr9m5fbm6KPMCsODWIR
         A1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ToRLObeEBgXor/SnBvKlxaQPAAiDt0hrFEbYVfvSCnc=;
        b=JwtABDQ479SGDP5ar+gTPzqWFvMeGk2l6bfLwrx8PadjYCEYRvLe9ZEzN5EI/LfKHr
         eca+93bXltplB5wjCojaTTm4xg9pXz/XNSPT7VLxlsqM3LjOm39re0SjUcHxfuV+OAu8
         FYX7awFdPJI910XnCV4A6UbNcnOi7+yzDo9Q/QOVVxp/sbBhXquuDWNMDfnCFdq6QL9I
         fpMuhLBnsncIjrDe4gNsqKmAZNl973tfIIF5tVmXyFU9ytFrIAJRyUqQAxrKDWgKplug
         m9wAYIHGtGFfLdM8NwLX+oEY0o03Q9V0Dfp/gszP80NzmhTr2v1tsO8w9gtKWI1aD7lz
         WKpA==
X-Gm-Message-State: AOAM531jFLVPIpEOYBghT87JlqB0fyT3Qfo6wRqECe0DcFRcQdeJ0PaO
        Sv+9mIZBsSqv517Q0DL/RCqRZyGxizAciLCfq+E0PQ==
X-Google-Smtp-Source: ABdhPJwqlN1J15VG53NhAXyIjEDLmkLNi34PUF7ymALe3cIm19hNqrcFqLDjhEU7wQtAJnwdTKimHEfqlIOTdSRbOiY=
X-Received: by 2002:a05:6402:42c9:: with SMTP id i9mr2771463edc.35.1616583410353;
 Wed, 24 Mar 2021 03:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210323125458.1825564-1-arnd@kernel.org>
In-Reply-To: <20210323125458.1825564-1-arnd@kernel.org>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 24 Mar 2021 11:56:39 +0100
Message-ID: <CAMGffEnahDx9cR+GUmvXZT0ztq+uLC+Yn-_nMVOf452uwx8Q6A@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: avoid -Wrestrict warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Viswas G <Viswas.G@microchip.com>,
        Ruksar Devadi <Ruksar.devadi@microchip.com>,
        Joe Perches <joe@perches.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee.jones@linaro.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 1:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> On some configurations, gcc warns about overlapping source and
> destination arguments to snprintf:
>
> drivers/scsi/pm8001/pm8001_init.c: In function 'pm8001_request_msix':
> drivers/scsi/pm8001/pm8001_init.c:977:3: error: 'snprintf' argument 4 may overlap destination object 'pm8001_ha' [-Werror=restrict]
>   977 |   snprintf(drvname, len, "%s-%d", pm8001_ha->name, i);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/pm8001/pm8001_init.c:962:56: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
>   962 | static u32 pm8001_request_msix(struct pm8001_hba_info *pm8001_ha)
>       |                                ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
>
> I first assumed this was a gcc bug, as that should not happen, but
> a reduced test case makes it clear that this happens when the loop
> counter is not bounded by the array size.
>
> Help the compiler out by adding an explicit limit here to make the
> code slightly more robust and avoid the warning.
>
> Link: https://godbolt.org/z/6T1qPM
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index bd626ef876da..a268c647b987 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -963,6 +963,7 @@ static u32 pm8001_request_msix(struct pm8001_hba_info *pm8001_ha)
>  {
>         u32 i = 0, j = 0;
>         int flag = 0, rc = 0;
> +       int nr_irqs = pm8001_ha->number_of_intr;
>
>         if (pm8001_ha->chip_id != chip_8001)
>                 flag &= ~IRQF_SHARED;
> @@ -971,7 +972,10 @@ static u32 pm8001_request_msix(struct pm8001_hba_info *pm8001_ha)
>                    "pci_enable_msix request number of intr %d\n",
>                    pm8001_ha->number_of_intr);
>
> -       for (i = 0; i < pm8001_ha->number_of_intr; i++) {
> +       if (nr_irqs > ARRAY_SIZE(pm8001_ha->intr_drvname))
> +               nr_irqs = ARRAY_SIZE(pm8001_ha->intr_drvname);
> +
> +       for (i = 0; i < nr_irqs; i++) {
>                 snprintf(pm8001_ha->intr_drvname[i],
>                         sizeof(pm8001_ha->intr_drvname[0]),
>                         "%s-%d", pm8001_ha->name, i);
> --
> 2.29.2
>
