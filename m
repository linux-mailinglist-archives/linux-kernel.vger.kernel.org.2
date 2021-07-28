Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4EB3D89F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhG1Irf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhG1Ire (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:47:34 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D7AC061757;
        Wed, 28 Jul 2021 01:47:33 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o2-20020a9d22020000b0290462f0ab0800so1312439ota.11;
        Wed, 28 Jul 2021 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mj+6onJ5YCrGEwa+OUlRe/rsn1CusgezZwhDmz7NI9g=;
        b=QbywKMqDBE2vyLGvddwKLvEEqPYtYiP3KuLnBqSbk/reeT/yJKLmp+2pGPy1CzN2tU
         YosFnFUjFJnJiVu2bZ2PHFo1VbGF+xD7bgcTdyX9tN0iCiy0PDPbMSD5MeqYdz8uTBY9
         zbAGxVhPOAuyXVCN5l2rBNacN9h8QsmrEEo3jf8CXyvKbCuXnMIez7YF/nWdu5i5STdI
         Niy4RYY6GsSIFn5wg8E5h7B3v7lQhY27ggHOwZjd38aaDUY8Jq0Vo+N25s1LPJcGKTC/
         fTodhzcfijSudfAaxvR+CHbWYv55iNEbxOeuSZAkKreFiX6SozBK2M+4NN3dTuHh17NY
         T1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mj+6onJ5YCrGEwa+OUlRe/rsn1CusgezZwhDmz7NI9g=;
        b=ZoeAElpB0CiGi0+qSUS5ruofnzEU/J3iDeL6cpbvHb1IMTMaCBXAz7/7dLgaeiXCpU
         gee7o9HZx6PUiZboOitGzjBbDOXnqrlaImIT+Kdg8YcUnEkcAL16wTCpeNiT1MU0rWKi
         nfMdJ1E1P9CiMRHROBbgNvbiANN2Uf+QwNSvqwe90s5vXdkyFNfrpBMAL4fk/0yu0WLL
         GSy/YUuWVxAJw+dlsiMW0B4SpWLStxBw1Oe6/tSam/Nndcos0ncDFHZjJh654KcjD+s8
         JqZ47JSVaW0WIrhlgi1u2hDgfs3Rqh5sQ2j1p6hYTQ0O48QlYov2GZmoxCVZKGi7eQLi
         T7cA==
X-Gm-Message-State: AOAM531/StrHinsvgOFT42u7zVQk0oOzQNphOAJnPfcXWpHp169lWnJJ
        nmYeKQrux1Xy2YTMi4X2nl0XtcBfUvefKqmXhF0=
X-Google-Smtp-Source: ABdhPJyTdb7oER2azfgjeqt4WdAGg6eOms+MJ2WoWxr9GEQkVXuK60ACrXuJ/QqNL6CNBrr6qYi+l1txUCDAqqvnjjQ=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr18699138otb.281.1627462053217;
 Wed, 28 Jul 2021 01:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210726105719.15793-1-chun-jie.chen@mediatek.com>
 <20210726105719.15793-3-chun-jie.chen@mediatek.com> <162740843452.2368309.13157283201271440368@swboyd.mtv.corp.google.com>
In-Reply-To: <162740843452.2368309.13157283201271440368@swboyd.mtv.corp.google.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 28 Jul 2021 10:47:21 +0200
Message-ID: <CAFqH_51D0A_Oht785cxvWjuNFYgLL25-qX1QEpLhWBARtTgVMA@mail.gmail.com>
Subject: Re: [v14 02/21] dt-bindings: ARM: Mediatek: Add mmsys document
 binding for MT8192
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Jie and Stephen,

Missatge de Stephen Boyd <sboyd@kernel.org> del dia dt., 27 de jul.
2021 a les 19:54:
>
> Quoting Chun-Jie Chen (2021-07-26 03:57:00)
> > This patch adds the mmsys document binding for MT8192 SoC.
> >
> > Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> > Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
>
> Applied to clk-next
>

This will conflict in linux-next as the binding was already converted
to yaml. See

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml?id=63e1125e6bb8eae3cd20292f6a10ee421dd574ae

Thanks,
  Enric

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
