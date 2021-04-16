Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0A03625E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbhDPQmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbhDPQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:42:34 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74036C061756
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:42:09 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id r5so15443184ilb.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 09:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j/densIO6lCILTUh7jZlg51NGZKmxtij9vX0sZYjwcE=;
        b=LOZ1xRvrz74oNLkm8XDgr9wAn6JTWPzg6eD+JHp2eH42LMlp+nRnewmfrhrpjFjhy8
         b8qGp94HHe0XusF6ja9l6oPVaQm9/0tm+q4tH0IYlPy57OaMKrrXrCRB9C360XCq5R7M
         iBasaHODg/O3/TW+dEMVcA+cI8lVUhpdEwrBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j/densIO6lCILTUh7jZlg51NGZKmxtij9vX0sZYjwcE=;
        b=XzWifk8UfmA9KsgkhnWkwU0e2MuVkHTnv1u01CCuSSCQXXNs8JiR734tw+Ar2js5+c
         nwkFD2kP7w3SbvQ4N/nNXoNG6umY7jyLI9suhn/VnJZMRQp6PDEplZ0l98LohyHJxhDj
         HBVOINAMjv7QVpqkYWprffbyYYb4me9mMIiHS79Per6+eR78BdoDa4o4Ac6hRyjDJXml
         aC2GG+PghV14dDxFzWQCLkTcjHh6QAMlqPNW+IymTWGkxXNwHq+ntRChkSHJTQ4HCZg3
         3RjvdzpxO+/NKv9y58wiQIQG+fUv4PMII06q0L/LsIhno0uz4ffD8yNzbHjnu/Swhjnv
         8fAQ==
X-Gm-Message-State: AOAM530vi1ISl/iyAB1So+ZebFWv6PBzN35D2NhDndHUSSgb8FiTDqw0
        6fzQtzMI+rozT8uAD9DMe212EKVt/f7GhdL767JfAA==
X-Google-Smtp-Source: ABdhPJxQLf+jzir4sF3vsmzfF2bdFIPUsjz8/woIId3VEBsUgBTg+HLcA+FeFoGMzcjnrrN4jHxA2FcjKw6WoiaAfSQ=
X-Received: by 2002:a05:6e02:1282:: with SMTP id y2mr7713435ilq.308.1618591328870;
 Fri, 16 Apr 2021 09:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210415093519.1920877-1-hsinyi@chromium.org> <20210415093519.1920877-4-hsinyi@chromium.org>
 <face0af7-8630-31fa-4975-a80311257d13@gmail.com>
In-Reply-To: <face0af7-8630-31fa-4975-a80311257d13@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Sat, 17 Apr 2021 00:41:43 +0800
Message-ID: <CAJMQK-h9YGmuDU5r+Ook=OODLK_n75+1o_Bs1KWrZOgMmyX0=Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: arm64: dts: mediatek: Add mt8183-kukui-jacuzzi-kenzo
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:42 PM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
>
>
> On 15/04/2021 11:35, Hsin-Yi Wang wrote:
> > Kenzo is known as Acer Chromebook 311.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > index 0870490aa350..39e4a99ebb37 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> > +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> > @@ -137,9 +137,11 @@ properties:
> >          items:
> >            - const: google,damu
> >            - const: mediatek,mt8183
> > -      - description: Google Juniper (Acer Chromebook Spin 311)
> > +      - description: Google Juniper (Acer Chromebook Spin 311) / Kenzo (Acer Crhomebook 311)
>
> Crhomebook -> Chromebook :)

Thanks. Fixed in v2.
>
> >          items:
> > -          - const: google,juniper-sku16
> > +          - enum:
> > +              - google,juniper-sku16
> > +              - google,juniper-sku17
> >            - const: google,juniper
> >            - const: mediatek,mt8183
> >        - description: Google Kakadu (ASUS Chromebook Detachable CM3)
> >
