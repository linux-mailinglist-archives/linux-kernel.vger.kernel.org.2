Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34593D91B9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhG1PUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235574AbhG1PUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:20:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706D4C061757;
        Wed, 28 Jul 2021 08:20:34 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w17so4502046ybl.11;
        Wed, 28 Jul 2021 08:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o9J+anRamv6ZCWPr2DTuO0dYhbRAoT47jmndMUGMGBQ=;
        b=UggwyPzjXdcBMG8TySoKOtZjIhO8R7LZQMde0mv/Gh+M/kY52rug4sfyhs4EJ3Acmn
         vkO9JOmwfywaRhuqBidq7oQb9C1iv9OY+559Io/YjxITg/Yrjm9fhkpFz1gQyxMyeePz
         Rie0EgTdmG/NeVFLZBxbX9TbcSeTiEEGJFiEpuWzEnlEJp+LOrV9AgNeeSS4Sel/blEK
         GpK1msonPpPyX0gwWSHgJiMcOzniahcpCNu3se0JmcmqSZuoGCqMbieqSkhRz2NQC7zp
         mQWYSZD84d93iU7awOz5YNASVssf7jhaLLIAjRFRW5C35lCHwMjUQWvbcNJ+H7DHzNSM
         xHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o9J+anRamv6ZCWPr2DTuO0dYhbRAoT47jmndMUGMGBQ=;
        b=Fhhz6j/RbOC7Gc8AthgNs7tKIdCgXvR/UFfahx3Djslvzv03CDMIex0PgmsdGnQPGW
         U9Tc0xwZ7L7+ar+a/GiQypxD+O+t7yzYwR3Y/o5LVZmdk5BdmbqmWC+hhu4vYEK+quM1
         1KB2ZTy/jHCZryAwEgb0sgceF9/gWoLuKk3dEfDNsBL+Kw7YwgKquM/3TYEHUVX7NSM4
         q0LXjMR7uzewl5iZRphY3z9aRSz0BcyWzkmH50CulloMeRRcHvlK9lvEOa2hO7ym686V
         XzffcNw4QYqd2IJg2wE0fTvb14YGElVWMNl1uOjcPEeoFpa2yRmneZF+J3Py4OR5O+53
         mmyQ==
X-Gm-Message-State: AOAM532kqMgEsrad58SmG6GCvfX3z7GeYBB+kDoucuzaYLXV7UOYt31d
        c7t6H06ht31y0HcDSnkQtxDBovFkb6nnfhgw8lQ=
X-Google-Smtp-Source: ABdhPJwHvxq0H0nZe5Ndm0BwQ5cEN3PjYE0YO7anNFQzBR78w7F1CnBqZGfrYvOK7HLhsRcHm3GfAYkaLn2SJYAY+TQ=
X-Received: by 2002:a25:808b:: with SMTP id n11mr293584ybk.141.1627485633743;
 Wed, 28 Jul 2021 08:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210728122606.697619-1-pgwipeout@gmail.com> <20210728122606.697619-2-pgwipeout@gmail.com>
 <fc6d5b02-707b-aa0e-9ef0-2984bbb1f5b8@gmail.com>
In-Reply-To: <fc6d5b02-707b-aa0e-9ef0-2984bbb1f5b8@gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 28 Jul 2021 11:20:21 -0400
Message-ID: <CAMdYzYoB0t6dB7BuZv7AFOQ7oYLbbPVQNybRxM_2y8MDTfXmyA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] dt-bindings: soc: rockchip: add rk3568-usb2phy-grf
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 10:36 AM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Hi Peter,
>
> On 7/28/21 2:25 PM, Peter Geis wrote:
> > Add the documentation for the rk3568-usb2phy-grf node, which is separate
> > from the usb2phy node on this chip.
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > index fa010df51a5c..3b0e06b6ea61 100644
> > --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > @@ -16,6 +16,7 @@ properties:
> >            - enum:
> >                - rockchip,rk3288-sgrf
>
> >                - rockchip,rv1108-usbgrf
> > +              - rockchip,rk3568-usb2phy-grf
>
> Could you sort this in alphabetical order?

Will do, thanks.

>
> >            - const: syscon
> >        - items:
> >            - enum:
> >
