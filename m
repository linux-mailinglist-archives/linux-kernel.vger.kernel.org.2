Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA92443B919
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbhJZSNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 14:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbhJZSNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 14:13:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0F4C061767;
        Tue, 26 Oct 2021 11:11:18 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id bi35so584157lfb.9;
        Tue, 26 Oct 2021 11:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ok/6IMhjWObzEGTvSkZe4AMKwm0LpNlb/4Kte4oUun0=;
        b=XYxQXf9vr1K88j0vZznYNkRdyV4d4xKn6hBNRnE4qxeGOJT6zFsJApBWWUeZxeOYbU
         qKpJy7Dr85HDb6jPAVymoOYDyCu4lmYznbo81zW4dTwN1DOCAeT52ECSjemvmFZdqRbb
         pI6AAEVrZ43jAeDnaOryFbFWXJvAVTixdfQ4lN+pZnL8QgpfgxrfXY9wXaNeEKUWAbWV
         QBkZneU1k5g5kp5WHDUalix2YeKkluV7r6JEKZTOmywtXTcgZxMNELoNjPkJ+K2iJgg8
         Jf9AKacGH63TKkn/aHbOJgulRUyKw8UaBYn7ScZtNmZgzayF3wiZVIVoHY7UEA4tgl0q
         3CAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ok/6IMhjWObzEGTvSkZe4AMKwm0LpNlb/4Kte4oUun0=;
        b=mx6I6k/4Qvu+FTllWx/UkqLgTGLLNrg0OQjkOhtO5uEvSrbLuM8bLePQsxtlIx9HhJ
         v+o9aUIdBRRwqVtKKbsq43ze5g85Ul9uPonnQlbPGV3UmoViQuxRFn+sfQ/CAi6RKmEO
         TwtAKijZnQbB7Kfa0lDeYvodkM78tDbhdaMmiVb6R4vdHDfLGyLInb/NzqOhzMuBbhyi
         5FS7vk0Ig/3C6Cf10cCgOwxrm9fMIj5mQvSc4oRb72mLzAnoihTo8mxDdJHcHY3/C58/
         t4bnl/+lQVnEQmwPWW3eKCm9m3B/PfUPJASybYSPs6ejKnGQzE/z03KOlwba800NxwiS
         2DxQ==
X-Gm-Message-State: AOAM533MRqgsoih6i/9moMyLhEV3MFLJGb8nCi1SfaJ8oizcFb7XQsqz
        UnMtcCkPDplSh5VhnjcbQd2NhcR/8kcbE1GRGrXTvHQkGmI=
X-Google-Smtp-Source: ABdhPJxTHUjTNieaDHYCHH3QCBBLFzO432EBunLJcLB5IrNdgNq5owdsB46QzeYRKQigWRq/JkD/IjMEbUEanorv96g=
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr23076108lfb.189.1635271876655;
 Tue, 26 Oct 2021 11:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211025163121.2189630-1-janusz.dziedzic@gmail.com> <39561c73-732e-bc38-e250-a0bdf51b09f9@linaro.org>
In-Reply-To: <39561c73-732e-bc38-e250-a0bdf51b09f9@linaro.org>
From:   Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date:   Tue, 26 Oct 2021 20:11:05 +0200
Message-ID: <CAFED-jkGhX=z49T0UrgqsttXXLFJDFyh8JmftwpWmW9zH9aVaA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: qmi: add a prompt to QCOM_QMI_HELPERS
To:     Alex Elder <elder@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 26 pa=C5=BA 2021 o 15:43 Alex Elder <elder@linaro.org> napisa=C5=82(a)=
:
>
> On 10/25/21 11:31 AM, Janusz Dziedzic wrote:
> > From: Alex Elder <elder@linaro.org>
> >
> > Add a prompt to the "tristate" attribute in the Kconfig file in
> > which QCOM_QMI_HELPERS is defined; I find it doesn't get selected
> > without it.
>
> This was a *long* time ago!
>    https://lore.kernel.org/all/20180427140358.30839-1-elder@linaro.org/
>
> The discussion that followed indicated that the thing that needs
> QCOM_QMI_HELPERS should *select* it rather than *depend on it.
>
> Will this not work for you?
>
This don't work, we can't run select from backports.
Backports drivers - ath11k for this case - build out of the tree as a
separate modules.
Eg. Today we are using kernel 5.10
and backports generated from kernel 5.15.
So our kernel 5.10 don't check CONFIG_ATH11K
This is what I see from our kernel:

Selected by [n]:
ATH11K [=3Dn] && NETDEVICES [=3Dy] && WLAN [=3Dy] && WLAN_VENDOR_ATH [=3Dn]=
 &&
MAC80211 [=3Dn] && HAS_DMA [=3Dy] && CRYPTO_MICHAEL_MIC [=3Dn]

But we build backports/ath11k module which has:
depends on QCOM_QMI_HELPERS


To enable backports/ath11k build we need kernel that have
QCOM_QMI_HELPERS enabled.
Because of that we need this configurable.

BR
Janusz


>                                         -Alex
>
> > We need it in OpenWRT project, when using WiFi backports
> > and build ath11k driver. While ath11k driver depends on
> > QCOM_QMI_HELPERS we need way to enable this option in
> > our kernel.
> >
> > Signed-off-by: Alex Elder <elder@linaro.org>
> > Signed-off-by: Janusz Dziedzic <janusz.dziedzic@gmail.com>
> > ---
> >   drivers/soc/qcom/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index fe3c486ae32d..16fb8e286015 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -92,7 +92,7 @@ config QCOM_PDR_HELPERS
> >       select QCOM_QMI_HELPERS
> >
> >   config QCOM_QMI_HELPERS
> > -     tristate
> > +     tristate "Qualcomm QMI Helpers"
> >       depends on NET
> >
> >   config QCOM_RMTFS_MEM
> >
>


--=20
Janusz Dziedzic
