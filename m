Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA4F35A1E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 17:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhDIPWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhDIPWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 11:22:17 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285A5C061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 08:22:04 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id g20so3107594vst.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 08:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3s5iM0DDtutXCX2CW4Fk02eYIx8aYsLaJtdlto8nJPE=;
        b=G4wrRJhals2S4TjgcKsiTJsyA42YcY65w3HJYq0XZf/exUD4l9dN8DLs3Lf4l4uEZW
         r+lhWBYLZ8h69qf8p5HuPR1WrXxgvwYTqpi8L1VjwX6BmTaTsBuLkkCOO2deNVXOJaGZ
         wRnTyIPFXF7G7Sw0vGk0FD23+S/FAsPtABsf+Kew9aelHZWKuE2fzrWBAHVK3EpN7uwJ
         0mpu4aVambDs60rl1skyVuV/HTHMlC3jWsuo6xEulxmVF1p4FxlN9zFD09qoGxPwBtr9
         E9CYoTtcsVxOX898Pk5FfQvIl/iFTLgy9AKUQiZCWLDiN/JO+uvI1HX6e6/IZZJ1MaES
         Za3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3s5iM0DDtutXCX2CW4Fk02eYIx8aYsLaJtdlto8nJPE=;
        b=MDYmf/5nPTdj4NhT3HkjyGwqNFIjUuRx/lWwSCk3tvxqMw/ZMjKnFBGmuH43PrdYcx
         VRcph8VbP+jgLUwgykq445m5bLXgpCfctAASWUT9T3dC/4CPN7yp776lmyHHeiZ0Ukcj
         xThzW/bi5m19CNrEqaa3eWelIo+8jK4uz/Ugg2cz8wtWHjY1yCrXk5ZJnDpuW79eKUFb
         DWW2Ftiqsplymr4NhgCaR/xMSFIFdMsWfaCu+pRFvH7mBFOttWIDMTa1UwMe8LCq4Hw2
         WBRZBVSe8WHXWhvKIqJAdfi8LGXvvLDe2fmwqZigRQjpFj3ene7ELbnuEONmM/p62EpM
         MnrQ==
X-Gm-Message-State: AOAM532nt9V3lFcNEs9Naxzw5AvsyW3D5mrd3xvk4RuNIximXWHM3UTS
        71O7nkSKX+W0YQuUdbvE/pisR4YIdQsfxkPe64M=
X-Google-Smtp-Source: ABdhPJwYrqbTO+toHceKeBWFha82OgtSQjsuKppLIZhszG27iDCJgqD0OJhNgbIISMnlNTxQrt/pp+m7P4CZUTxsEX8=
X-Received: by 2002:a67:e15c:: with SMTP id o28mr8648918vsl.9.1617981723139;
 Fri, 09 Apr 2021 08:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122231.8391-1-linqiheng@huawei.com>
In-Reply-To: <20210409122231.8391-1-linqiheng@huawei.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Fri, 9 Apr 2021 17:21:52 +0200
Message-ID: <CAH9NwWfkug1dN2sSMEpJ2JuKNG=wJ7mCcNejgEFKihwviuAbcw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/etnaviv: remove unneeded if-null-free check
To:     Qiheng Lin <linqiheng@huawei.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr., 9. Apr. 2021 um 14:23 Uhr schrieb Qiheng Lin <linqiheng@huawei.com>:
>
> Eliminate the following coccicheck warning:
>
> drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:616:2-8: WARNING:
>  NULL check before some freeing functions is not needed.
> drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:618:2-8: WARNING:
>  NULL check before some freeing functions is not needed.
> drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:620:2-8: WARNING:
>  NULL check before some freeing functions is not needed.
> drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:622:2-8: WARNING:
>  NULL check before some freeing functions is not needed.
>
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

Reviewed-by: Christian Gmeiner <christian.gmeiner@gmail.com>

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
