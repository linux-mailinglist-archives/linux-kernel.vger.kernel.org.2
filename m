Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1622F3DCEF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 05:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhHBDkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 23:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhHBDkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 23:40:45 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CDBC061796
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 20:40:37 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y9so18775702iox.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 20:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xr7X3INp68/aHb+fLfHEXT7brOPsJnQpWqh+BxS2toY=;
        b=LiuyPDjOiqxtQJsSBVLxKaDvy1dlayZ3PKlzxW9wtrimEOAXzoDfElSfvrSXHhPTkz
         hYJObO8siTOJ4u0JjoUfq0HR0pJvLUhQK2UyghUCg8sLfzZTF+FZRQ8eSVvZ6ZoWmxhB
         zyeBD5scfDVbWAiJ89ygyqR2eRNcbf1DRaLJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xr7X3INp68/aHb+fLfHEXT7brOPsJnQpWqh+BxS2toY=;
        b=qZI2kRjcTVTnBx9aMd9xOq67u6cmrxFBwb1t6q57RFWi2B5G1Fv6D0YRamWeuGTSFj
         VAW98wez/LSzFoxto47CGy1MxT0HNNts5JAuIWoLGDhmFfne7XaD1wm0BZxMunC+4V5g
         IYJaOBPoviUeKoZQLRX4U90uur/M5UgGzPJdp4niZTOQrxR3IZETtfFb7+LBZCHatOoL
         NksfRM2Yb8SY6l0t3rfn5rcc1DfxGSxlNfdHELQPp5+en1LrDq97lDNPk9K94VL2A6IJ
         jPKgDWbBE+gJ4PQ5RNFjlCyXvmqjvqWkHm5OPlk2upNUA9TWeK4IqQ8JWOk9yBeiTUwy
         5ewQ==
X-Gm-Message-State: AOAM532Z+JK/18QDaQojjU1w1j59yfEYNwzOPufzc/INxM3OR7Y3hLIA
        cvPvrMPSHw+V5gMY4OgOvGefsZf/HR0Nz+oFRGpMWw==
X-Google-Smtp-Source: ABdhPJwItvPct0QYddbjn/ZBRIlrhozZ9+0sIdd0TxqCVOowtY1O3c/Tt8Q3jSQWg6Ujnb4bjYO9KHe4YuO8OMslZZw=
X-Received: by 2002:a02:aa8b:: with SMTP id u11mr12823631jai.43.1627875636594;
 Sun, 01 Aug 2021 20:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210802030023.1748777-1-linux@roeck-us.net> <YQdmCaySpW4Dpz0t@google.com>
In-Reply-To: <YQdmCaySpW4Dpz0t@google.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 2 Aug 2021 11:40:10 +0800
Message-ID: <CAJMQK-jxYAUjT4g08Ctt0=NTdFoKMnHBqE9-Kgj94ymc8XOrCw@mail.gmail.com>
Subject: Re: [PATCH] spi: mediatek: Fix fifo transfer
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-spi@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Hess <peter.hess@ph-home.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Yi Wang <hsinyi@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 11:27 AM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Sun, Aug 01, 2021 at 08:00:23PM -0700, Guenter Roeck wrote:
> > Fixes: 3a70dd2d0503 ("spi: mediatek: fix fifo rx mode")
> > Cc: Peter Hess <peter.hess@ph-home.de>
> > Cc: Frank Wunderlich <frank-w@public-files.de>
> > Cc: Tzung-Bi Shih <tzungbi@google.com>
> > Cc: Hsin-Yi Wang <hsinyi@google.com>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>
> Tested-by: Tzung-Bi Shih <tzungbi@google.com>
Tested-by: Hsin-Yi Wang <hsinyi@google.com>

tested on a mt8183 device.
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
