Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49ED377159
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 13:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhEHLMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhEHLMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 07:12:18 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DD2C061574;
        Sat,  8 May 2021 04:11:15 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c11so8445971qth.2;
        Sat, 08 May 2021 04:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfDuILVJ/qrRaqU8xHoH2Xwtecz2dupT4Jbb53C42Yk=;
        b=Ni+FkHxQ5UDdVFDKXHv70m55YzCQW5Wexb2/Mt8KAgEzMEg81c/6zElDN0EHYdFNc7
         GTj3fwc2wpxevfQNbFUym2Ac+Hy+JnDvYMWjKV6jNjo8+vhod+bP+V6q7ZnGiJKidlOg
         psAH9gYK/UzDdRy/5j/blUNcU7DRpA2nhzofTJxZKMH4s6NLI8Etr0weALwYJX2ryVyC
         2Lmu7ebHjumSK7e3I2/aJfc7O+yFVc1HpUJaFK6ZbQy8IjSfJKgHALIbA7KugiLMxTFT
         nxe0yA7tnGbrkY4bYtcnaK5YEcG2MNjmUdq0n6Cup85+o+B3pPmzUGTGEv6oRabZec8z
         rZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfDuILVJ/qrRaqU8xHoH2Xwtecz2dupT4Jbb53C42Yk=;
        b=aAPHXabRPz0V3/k0PQJ2XEnrmv0qeUG3gJe1Vqyku+6qfDhqyt6khQokRTT3yj3mIK
         xlZ6SpVDxwEcS70P/sv+QYMXIw05kEeCqxTuChyeift2OFqRvoO9tXaNKWzCPDEo2EJP
         Cx0zjFt3pHU/S5gM6ge/TmZk+wqA5FsPbHSCM3+IrfohCuP4WlISfWbDfJSD4lmohybh
         9fKcLzubABP2YQ6JI+ElXEGYRaxEyy/sNSgOh7dFFzC3PtSMMrVr6BSMmOL4VCyZJDQD
         OcPB3AQV2pFXsvnoABjzOL7hzD6lJn0O9oc8S1gUi342mHN0LGcD7jjC94yLeB1+ZYUy
         2nUQ==
X-Gm-Message-State: AOAM533/BCWvKk7TrSUL81FGy7acjrFaKvExSdi5/xPFdkRHO2qKLl4O
        j93defExQ1F4fQ9BIEl30LGZtpogot+ZzUF8byw=
X-Google-Smtp-Source: ABdhPJxoEslillAXm4KdMahYQZppkAGITUmkSjIpfL9o/fSNmiaqygZFF7zP3VcYAKQyGtzP0pX6x86BuieDRgbJ2x4=
X-Received: by 2002:ac8:47da:: with SMTP id d26mr13176229qtr.292.1620472275009;
 Sat, 08 May 2021 04:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <1619157107-3734-1-git-send-email-shengjiu.wang@nxp.com> <20210504065736.bcnatgmy2gczynsr@pengutronix.de>
In-Reply-To: <20210504065736.bcnatgmy2gczynsr@pengutronix.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Sat, 8 May 2021 19:11:04 +0800
Message-ID: <CAA+D8AMzfj1QY-uXd6Ew7wCXomyDSdokHa-ReP6ucZjVnvYHGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: imx-akcodec: Add imx-akcodec machine driver
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, May 4, 2021 at 2:59 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> On 21-04-23 13:51, Shengjiu Wang wrote:
> > Add machine driver for i.MX boards that have
> > AK4458/AK5558/AK4497/AK5552 DAC/ADC attached to
> > SAI interface.
>
> Why? Does simple-audio-card don't fit?

No.  We need to support asrc->sai->codec case,
but simple-audio-card don't support it. simple-audio-card
needs the cpu dai is dummy on BE. And we need to
support the DSD format, this driver help to switch
the dai fmt from pdm to i2s according to the DSD or non-DSD.

best regards
wang shengjiu
