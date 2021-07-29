Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603823DA0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhG2J6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235134AbhG2J6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 05:58:34 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7F0C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:58:30 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id a7so6763272ljq.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5KPMH+AygWZEXcn3xe7p9376dbY996l7aWe2Z4Eu6Fo=;
        b=hIThC7Wnj8zQqP1im1k2UypoMmNZ6oHXlheP9MP6Qi1qLa+9eoxUXi4Llr1q2Uaztq
         P4hAywuOyH1DuSWQJ7LiL/o9mnbWUoT3IzzJO77vYgh8hPY8qCcDZ80QbxqHYQ7gLyuq
         Cs+2bfpL4pbTwdW9hHQEZaXs2JNDsnGZXfaog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5KPMH+AygWZEXcn3xe7p9376dbY996l7aWe2Z4Eu6Fo=;
        b=nyi/5ptufS7tU2+JmkxiXFV7zhno5CJfDY4tl14ebREmKpbUiYEOqt+CBehIecKUAw
         tM46ZI/JhRQsn13/ntY5iy4Rl/fh2Ke3+ExGjWsl7eMzBdTe41CzMkT+JVnFOiNUoUyK
         lF0Jpk+UK7mDy2ThYWAClRsz1is7ah2sU/NzbgeZ6hWfOcphH9jgpce8WftQVD5NVDU9
         VNI9QourTu9NV1Y1zZD4GWYIMZCKlqXSrwcO1N+MCEnioMIknqsAZ3SzFApOxq1bjoPh
         ZemHtBALMloVNcHHD3z2LrkwIXDZOwz1m1WZPdkDICJcPSa2/rPhtW+ixzBrBaGWQzqh
         XBhg==
X-Gm-Message-State: AOAM532cxCe2YBoM37h93vb+JHfVyDAtxsu9t4gcyIWxMU6JF1t6e92i
        YI+85BAF2uoPpAUrR8grexEmYpTzyQuOzFBhronnlg==
X-Google-Smtp-Source: ABdhPJwMxLLuvn7mala9hBDJn6qhU6W72vuZFml3Zm2YdFBSpUIQVM85iFq3c1hiUGEN8pVvVdMK/LRL7Cgcsacf3mo=
X-Received: by 2002:a2e:760d:: with SMTP id r13mr2454128ljc.437.1627552709362;
 Thu, 29 Jul 2021 02:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210728040710.2891955-1-hsinyi@chromium.org>
In-Reply-To: <20210728040710.2891955-1-hsinyi@chromium.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 29 Jul 2021 17:58:18 +0800
Message-ID: <CAGXv+5EVcSyfG1Fk6PZOnWUZo85brf_cneW7iob4Z5gnjFca7Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: mt8183: kukui: Use aliases to mmc nodes
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 12:07 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> With commit 1796164fac7e ("dt-bindings: mmc: document alias support"),
> a way to specify fixed index numbers was provided. This patch use aliases
> to mmc nodes so the partition name for eMMC and SD card will be consistent
> across boots.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> v3->v4: change commit message based on review in v3.

Thanks for following up. My reviewed-by is still valid for both patches.

ChenYu
