Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE72A459A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 04:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhKWDP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 22:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhKWDP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 22:15:57 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B31DC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 19:12:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id o4so17955970pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 19:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x2hw3oGQCKQYUHt6V/jeij7qOnZntnAL24E56nojTHg=;
        b=gIujpSdtAknKwM2DSCD5wuUpkhhrH097yVr1sWa5jsFkkwO6U/TMS7VEQfHoKjLGL6
         PtpPhqkX1Z7hbVNjcxu5DJd9GOmfEfVT6Y9r2uZvBxgEZPk7Hn1NmP/l+gM3W3dOBQ3x
         6vZ6SxFMdjJew9B39sgKA6TfPpnGdtqBqCme6ZdYPXOImU4zYFMu5EXhfTihw7hujNeo
         9yOb2ntl1hkTeiwd+VvHEFxRw5ul7ni5R36VPr5MjQDIDYi3ZHd6CNHZbM0+juKYrnj8
         BofEsJR2zzFmZGqrLL9fU3Fh8Bj/P/pFWHNsUpcISaU861PnqmjmVI5Y5+yWM0SqbgAW
         Sj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x2hw3oGQCKQYUHt6V/jeij7qOnZntnAL24E56nojTHg=;
        b=YtxW5m62HigTNZPkVcFfRbPndFNqqeTBz9/MYki61fCt1FXyIL7EBeufcZoKT7WevH
         lDZ2y/D9PIFCI07Y06rmKXM+kMwhHA/74AwuLNUnz5DjkIitPyrVQfwk87H/gKAMDzjI
         ahWQ96ybVftYzrJn0HUD/bIkzgF453oOYYIB0PGaYYsF64igtqkRESRmBKcVSwT8wpV9
         ysRK+k7oJOL3WsV1o2q8X4MCOk2+zHUo2jWGW0l0zuteLINmx0+I65l7zGqDL9JeCfu+
         AZ1J9js5h9q0/pcIixY1hy4fCw5TIayCJbhlvA8I5d7dsThfqs2onFELd7p4Ok0J+Uzf
         L9dQ==
X-Gm-Message-State: AOAM532flifO5B4Ul7yrdoMpYbcmxD+qbCA+fNcmGS/XFuGz2C1Ggjz8
        bjnVeD4aCGn22ItFD/284JRVM+YzX6EiJdgylZ11sA==
X-Google-Smtp-Source: ABdhPJwMXvJBc/Q+TZQf5i18d92jX/IrYo7Qd/Ip5lemBkmdtvpN1+Uh02bMi2Upj+gk5gH0ickdapbkQ+WCbMkkrCM=
X-Received: by 2002:a05:6a00:84c:b0:494:6d40:ed76 with SMTP id
 q12-20020a056a00084c00b004946d40ed76mr1974231pfk.65.1637637169565; Mon, 22
 Nov 2021 19:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20211122164644.19442-1-jiaxin.yu@mediatek.com> <20211122164644.19442-2-jiaxin.yu@mediatek.com>
In-Reply-To: <20211122164644.19442-2-jiaxin.yu@mediatek.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Tue, 23 Nov 2021 11:12:38 +0800
Message-ID: <CA+Px+wWeV=9DF7wdSyjaZKS=XCJjri1Dmpf-kfNVZOqm5fV33w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mt8192: remove unnecessary CONFIG_PM
To:     Jiaxin Yu <Jiaxin.Yu@mediatek.com>
Cc:     broonie@kernel.org, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:48 AM Jiaxin Yu <jiaxin.yu@mediatek.com> wrote:
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>
Acked-by: Tzung-Bi Shih <tzungbi@google.com>

Could you also submit another series for the cleanup?

At least for sound/soc/mediatek/:
$ rg --files-with-matches CONFIG_PM sound/soc/mediatek/
sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c
sound/soc/mediatek/mt8173/mt8173-rt5650.c
sound/soc/mediatek/mt8173/mt8173-max98090.c
sound/soc/mediatek/mt8173/mt8173-rt5650-rt5514.c
sound/soc/mediatek/mt6797/mt6797-afe-pcm.c
sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
sound/soc/mediatek/mt8192/mt8192-afe-pcm.c
sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
