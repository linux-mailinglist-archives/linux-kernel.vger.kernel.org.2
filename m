Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770F143F4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 04:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhJ2CXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 22:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhJ2CXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 22:23:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5F8C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 19:20:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 83so8378197pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 19:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mhB6LkCbsKUbE+bUIvR/Nrpsu2M4JaioKKngIejiLhc=;
        b=jlVG+VO1wHjL5B0Hkj2SEVVcUAGh7PrcbCyhNPcuXTVpP/NRyZrpYh2RlHOO6oYrTW
         PbR1GOeMbg8NcIQgJRX5w78F9Knr93d2yQFXq2kJM0zWiWhnU9TgrsBNd9bFt+d6Nk2r
         GjFs3JECWpH3fOdXFBWqqYTy/2L2M2iH/srfKEogAcW+JqlnBw8bFWlF5HgnlTIy44Wy
         YFfHhdrDo4URqFGKHh0fb3WB2p3WUxS0Nk9QTXO4kNy3r2hmmJixp8x2tDyOhL1bPYfD
         epKiICmzzvtTja91yNZDRFSpqL4TrY3h3VbVAcFNy1UHxrZUIbzek9ezqph5ss7aJmGj
         vKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mhB6LkCbsKUbE+bUIvR/Nrpsu2M4JaioKKngIejiLhc=;
        b=67AzDivtI+IsEf15pSXOMEG5HjLOk0zWbUy8+xMCKOIEUC8/QswIUoEm4akCVw+mbM
         C1eaHpNKIi3U9RlTEEVmSEBp6SA3cIuHNj+yiXKycGL1MhTGWtUdn+qBEYf/hNY0EG4k
         KqV1ZtTDpWDcbBzxyMFLM2I0E9N41veehdJJvKSOggm9eC86zkGrjnGITb16mS7w69kA
         A0KEXr6ha0QvPBeX+yjZA+LB+DccgqdzpHueE1V4g8S12zyw1tGU6aJCnFXl7TYoCmk8
         lWVNB3VEWBGHqZndKqjGXm+3FilGioyariZSwpKN9CtTXEWTmTmIHLKBi6JsNp/B38+8
         BT9A==
X-Gm-Message-State: AOAM533KGcEOigjMif6JobYz4nRJo3QY5wbhpjUfqOUu/6DlTfd4Z6H2
        6pZyQE9gZ3VUNvj4pUp6phZZV1M3lQsVBwPVU4146A==
X-Google-Smtp-Source: ABdhPJwRHndRNkI7bhtBce/eYA5HiHNlGa+O3E5HB7Z9RmPlWNKvOeozIVu/Q5CdowIzhda3z/o19UtPjQ3coB7P6Gk=
X-Received: by 2002:a63:7418:: with SMTP id p24mr6095486pgc.204.1635474044247;
 Thu, 28 Oct 2021 19:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211029001225.27218-1-julianbraha@gmail.com>
In-Reply-To: <20211029001225.27218-1-julianbraha@gmail.com>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Fri, 29 Oct 2021 10:20:33 +0800
Message-ID: <CA+Px+wUi6t3n64EPWqX0Q3vMUkBw7UrRBK_5RwnVtNsa-ZuLGw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fix unmet dependencies on GPIOLIB for SND_SOC_RT1015P
To:     Julian Braha <julianbraha@gmail.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        Jiaxin.Yu@mediatek.com, arnd@arndb.de, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fazilyildiran@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2021 at 8:12 AM Julian Braha <julianbraha@gmail.com> wrote:
> WARNING: unmet direct dependencies detected for SND_SOC_DMIC
>   Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
>   Selected by [y]:
>   - SND_SOC_MT8192_MT6359_RT1015_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8192 [=y] && MTK_PMIC_WRAP [=y]
The block is not for RT1015P but it can also be fixed by the patch.

[...]

> This is because these config options select SND_SOC_RT1015P
> without selecting or depending on GPIOLIB, despite
> SND_SOC_RT1015P depending on GPIOLIB.
>
> These unmet dependency bugs were detected by Kismet,
> a static analysis tool for Kconfig. Please advise if this
> is not the appropriate solution.
>
> Signed-off-by: Julian Braha <julianbraha@gmail.com>
Acked-by: Tzung-Bi Shih <tzungbi@google.com>
