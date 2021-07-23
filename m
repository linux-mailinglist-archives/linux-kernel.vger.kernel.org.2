Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E2A3D3932
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhGWKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhGWK3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:29:53 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2038C061575;
        Fri, 23 Jul 2021 04:10:26 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so1617827oto.12;
        Fri, 23 Jul 2021 04:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItsRsZ0+rGylQYA+RELfRwpVcM273u0/L6xue3YIFTA=;
        b=mgZxllDJunjoK3CtlARUlfLQNAlHIMceNdssna93H1gvGsVkjbKCjeXwfaKALFHizP
         +Y1XZcKvjH1iQnJ0/Ky5KHtTGpXSvz9a4yB31+JlI9uF3CHnUEVO1K2oEON+GxU4rCkI
         L0wstpPWTGcGN3ukpI4x1nmdMQaYvvW8wHQbsFxP47E/bxFXJ4AF5QvtFeKtSnuJBKfg
         MjUE2uePwDC+tZXum5IbjSHP8qOVpr5oXCFRJaxZXEyyxD8GK7q7EeAoC/fzug6goK73
         mGfo5Lz8KQNUMm3jwzRPh5K0HgVo8KfnWG58LKxGV0f2KFcDCBE0PMNzrJHv6r/LAKNh
         fCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItsRsZ0+rGylQYA+RELfRwpVcM273u0/L6xue3YIFTA=;
        b=aXeozuwZVcjmPTlwopTas3S75qk0Di6Qcx6DDlFiaO/O5BZm7+zz1e0CO2PvChg2G1
         bhnCUfX9KXuKhxCO22KcdZbxZyibWXCIuuHpp2ZX98TnequCzDSSfl5taM5qDi+im1bf
         GxYtXcM7828OrglNPchlpGn1JZJdEMvTWAs6HFWf6/gZTQiCepkr+6ieJDhYa2pqQshI
         s76lyEDMc0HnNkLgU8HvGuKcMEQ2YCJ63jkIS6ANy+c24Ba/YBOrbzuk8YqwNFof6UhE
         NxR7gLwfqFW35mkluM1VGXqxmqRGrfLYmE70gGJbMltDGna2BdW0JiHo+pcVR1vgcMn6
         JzwQ==
X-Gm-Message-State: AOAM533zyJwCIamlDVviZDsXp3FJ8yNvSQA6JaQXeeUJ4V/S49vE4HCk
        wGdKFzmzN9/msS/Uz5stokESTOocKtnTaVaz+TI=
X-Google-Smtp-Source: ABdhPJyTbyPS7OPxgzkKeQ0xejJgwTXa3EwT7cNdLuCl25tp5G3mArCVKEQZIg8TwboZwxHRabaGbXKTcoVEzwUnzvo=
X-Received: by 2002:a9d:491:: with SMTP id 17mr2724546otm.184.1627038626371;
 Fri, 23 Jul 2021 04:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210722094551.15255-1-nancy.lin@mediatek.com> <20210722094551.15255-5-nancy.lin@mediatek.com>
In-Reply-To: <20210722094551.15255-5-nancy.lin@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 23 Jul 2021 13:10:14 +0200
Message-ID: <CAFqH_50qC985oTcPWDLRJt6yVvwtHsizPOTnTMBh84m6Hy6hFQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] dt-bindings: reset: mt8195: Move reset
 controller constants into common location
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        singo.chang@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nancy,

Thank you for your patch

Missatge de Nancy.Lin <nancy.lin@mediatek.com> del dia dj., 22 de jul.
2021 a les 11:46:
>
> The DT binding includes for reset controllers are located in
> include/dt-bindings/reset/. Move the Mediatek reset constants in there.
>

I think that the patch that introduces mt8195-resets.h into the
reset-controller directory didn't land yet, please sync with the
author of that patch and just put it in the correct place the first
time.

Thanks,
  Enric

> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>  include/dt-bindings/{reset-controller => reset}/mt8195-resets.h | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename include/dt-bindings/{reset-controller => reset}/mt8195-resets.h (100%)
>
> diff --git a/include/dt-bindings/reset-controller/mt8195-resets.h b/include/dt-bindings/reset/mt8195-resets.h
> similarity index 100%
> rename from include/dt-bindings/reset-controller/mt8195-resets.h
> rename to include/dt-bindings/reset/mt8195-resets.h
> --
> 2.18.0
>
