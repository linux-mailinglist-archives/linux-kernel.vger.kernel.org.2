Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7432BE36
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385344AbhCCRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355216AbhCCNBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:01:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A151C061788;
        Wed,  3 Mar 2021 05:00:28 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h4so28341844ljl.0;
        Wed, 03 Mar 2021 05:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dOy9ZppsbqJ8d9Vw/01DvHHDmX6JevAG3/in+sKRFV0=;
        b=CoqsHLxvwbr7yA9q9zfeV9RH6ggxFdA2zDK/DbxJmgWB8Opk3GkcmtDJ2Tdo2Ow+O8
         7NVdv1mHwj9lNcP5AjB2zWnpNGj2ATseP7Qjk1RDLL6NcOfR0q7Qjpgj8/tcmJQwjozR
         y+YYwtdAnqMo084syy2ZfDlAKLFNGKSNV/oW+lXe4meuaHbTTms5xRA6MNBwOUV8RFp5
         0ylzRt79azux2P7JKmBlSMknntiLT+2Fr0LAZkt3yNTupdhnYsVYfhckQ6QOo7pSE2sS
         KwmQFSURMDOivA/qOV9EWOn0G0bh9+CNnULz0Ji5dEoZiZhXlskasFZFx20dKiOiYBK8
         b/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dOy9ZppsbqJ8d9Vw/01DvHHDmX6JevAG3/in+sKRFV0=;
        b=XVRANtIkcYYFR9i3qcuHaF+gtoELQDosmNLooOAt38K72ryr+UjeyiamgNygYzIL1F
         H0HHgB+3ZVrIMO7PFWWtCVzbFN/AcEI2R2fsdXmqFd24eaAiMidzFTETNhh0E5deJK29
         Ziis+t8X8ovOZiuH+SozSd5TFmk0ydY0vavZovxSlMqrXSy0F+612dD1hgVdYpXoGZf9
         CM7u3kGlg0DKEThuCNqvdcbLQ/avyj7KjDM7SPoOivXm5xbtqyRc0zCGMem3JPorSe4K
         IGkcUH4IST7D/O1v+a7U9VxtyYxDBrRjGUwuRYfBqzQJmPOVm6k3tFHwqqb1uudpHZd1
         mIxw==
X-Gm-Message-State: AOAM531BDuyWQ7k/V2LFc3vo90ldO3MDxIEbqjLdQB5/b9wCAFDGNCPm
        xiyz+4uJFdPJtddR8r8Qfft8jfPRO0KrjubbFqg=
X-Google-Smtp-Source: ABdhPJy/vKnaX4CJ0cGGsM1LwtY6tY0tSeDOcU8iV8x233uqYUnrs2z76/qKbL8A6k9nsBu2g8msCvCPTfOIO3Vi1W8=
X-Received: by 2002:a2e:9a4e:: with SMTP id k14mr12688149ljj.116.1614776427143;
 Wed, 03 Mar 2021 05:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20210222140756.713-1-heiko.thiery@gmail.com> <20210222140756.713-3-heiko.thiery@gmail.com>
 <CAOMZO5C4bL72mksHG4GfikgLOxib-A659rac7VkpjGsm150O_A@mail.gmail.com> <CAEyMn7akV6G4PkS266pMwi+nro6-Tffc0Zt6LN9sV7Kgi2dKcg@mail.gmail.com>
In-Reply-To: <CAEyMn7akV6G4PkS266pMwi+nro6-Tffc0Zt6LN9sV7Kgi2dKcg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 3 Mar 2021 10:00:15 -0300
Message-ID: <CAOMZO5AdNjr46JYyVDRWemjsCunb6NxUy5hpuRndB9gvgaNqdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: fsl: add support for Kontron
 pitx-imx8m board
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Wed, Mar 3, 2021 at 9:54 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:

> > reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
>
> I used the same name as used on imx8mq-evk. Do you think a better name
> is the one you proposed?

Yes, the way I proposed is the preferred one. Thanks
