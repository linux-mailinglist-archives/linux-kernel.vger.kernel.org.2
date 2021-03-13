Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA6833A103
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 21:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhCMU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 15:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhCMUZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:25:58 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:25:58 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 184so11620847ljf.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 12:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nXwzLOYKpkiq1CLhD7qyOG97MFYVynskpPPG4YAoxy4=;
        b=K0kEop7CHc8u9qijPjvgU2L1W3jO1BD3jpACZXK2KiSoFCiGPk9zchyq5/6YfLjrG+
         ppGZUecH/5ysyVwQVIRK/QEWq3zmDSt5d1P6UDAhCNtLR7no89kZvstWKfs8NqLCOePu
         P/OJimCXQF/TPHY8AeLKs+F5aRJf8d4pJJWVARHv+P0W1r5dAcnQc8YbEv78z7GBAKZH
         DdI8swCdgYvNSkFIY4nlgEcwI/D8n5BsLJDfhK8AT+6Uun3WGhxOARrUDSO58qhuigKC
         W58suNOeVWIWk2hBC0OBl5zJqU1yHrgtfQV6sOKWjooi5UHOcAWpjEpQGVCnL7E/DVt/
         5bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nXwzLOYKpkiq1CLhD7qyOG97MFYVynskpPPG4YAoxy4=;
        b=JktBYt7jvS4s/Zkiix6AvV6hGBfC9VKlCbHviVJD3GAtrQwPKl/Fj5Pbj/NJxaxc7g
         /s0jkEBU9N2FxwxWWp2+HsSgOGeiWyX52N39IH0+7WchogxAE+cxFUVSimHx457dUuuW
         79SGSmRLm1Jm2K8rPZ6IB/bMx02/vpXgp8lGVRSPE1UaKqmM2UBc39gOTqWWz2zUVDdr
         ElFO2UKfY0VJT2IJvFdZc1bY8w4LuGpwx0RhtOS3LFVfQ9y8+XYvvFCtYBzFMjyxv2kH
         fT+CmtSRHXxUNOmRLVehlHuzxdbNBl99iZRIg45F4i1e10PnY97fCvsfGr9H6z5dVYT7
         CdmQ==
X-Gm-Message-State: AOAM533+KVbQsTt39zsn5ju3R2kBaajiVq5qKhQRM85Hwxe7BSUz+sjF
        Eko5uIZdood/Zakmst/KpYOL2pQgB525BONZVCo=
X-Google-Smtp-Source: ABdhPJw7Ss7EWBxQBvdRZ94nulcY04ujzJ00fZWur8s/HypB+wsz+o6b9J0bYTqO61ZQY6vOrDbXOXoteVmmI7NrjvE=
X-Received: by 2002:a2e:b8c3:: with SMTP id s3mr5944317ljp.264.1615667156726;
 Sat, 13 Mar 2021 12:25:56 -0800 (PST)
MIME-Version: 1.0
References: <1615623820-16592-1-git-send-email-wangqing@vivo.com>
In-Reply-To: <1615623820-16592-1-git-send-email-wangqing@vivo.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sat, 13 Mar 2021 17:25:44 -0300
Message-ID: <CAOMZO5BSxSo3TRAeZNhFiiF1r5PxecUGJc5p0ekF6709U3x_NQ@mail.gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Remove unnecessary THIS_MODULE
To:     Wang Qing <wangqing@vivo.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On Sat, Mar 13, 2021 at 5:25 AM Wang Qing <wangqing@vivo.com> wrote:
>
> As THIS_MODULE has been set in module_platform_driver(), so remove it.
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Thanks for the patch, but someone else has already sent the same.
