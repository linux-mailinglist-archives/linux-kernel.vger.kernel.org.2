Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC6D3BACBA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 12:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhGDKcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 06:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGDKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 06:32:14 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F561C061762;
        Sun,  4 Jul 2021 03:29:38 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a11so14440796ilf.2;
        Sun, 04 Jul 2021 03:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQoR4QISuapGKpauC178uaj75KbY/vGpOxEXEM7G76o=;
        b=HVOnclRtG4IAOhine7xprF5Y0qsYY8NRMEg8kTJjJqNVJH7o8MCTpVIBajLwaPxlEE
         IPu3pWL2IMMHC3lG32PaXBQbPWTLFBJV35PMS92JNxr/C9pAZ0S5zqaIlRJ072G9qL0m
         kF9Q1YWd6PEzv558ovO0UsTxYRq6JKOKl46IoXSiOa89FuY38TSOzXfoeCc69AVlhwo9
         hJQyfEV8plIdboPSD7vcn49vSerQldYQ23IBP25MiY3WjQQJ4/1oo7fWpLh4yxX1/yYW
         W2WFO5H29TmEYMssk0gRvcVr80KnsHM9Eh9ViXM00RCRo+jX8qVTF9pcfPCdwvzSs/qf
         t0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQoR4QISuapGKpauC178uaj75KbY/vGpOxEXEM7G76o=;
        b=jfkpK54cx7+hBh61Si3ZZIJeQEwdmOKQy/g2h6qh40NZhcx1DhimJ828Bp0Km8kgec
         wL3+6FEOlOJD8Mrdty9bpKCuvNnV4xJNgI1Xi6yf6/pWnM6xGanTgyd+M+11xPuGAMDT
         t0vP/ZbI7erhqhe6R8ozYMs/6JjeVdA12Z0X738GpxJe8eRyNb2vMdSKPuMcw0cAu9lu
         kLFz7Ri+PlPVJ2fKUkGcWoUg68cfQ/hobWiSEf4fn3Zu8/qZrIH0XAai9PlAkecu/kzH
         wjkF08yTDLEPfyKTSNzqSfZtHfGNDAsUhJ1AQIEMfnNJFJGRdqO1BeqVRFdib6RQG4SC
         2RnQ==
X-Gm-Message-State: AOAM531SUytX2tY6Y15qVCKwiAElCX18RckyFcwl29ZIrrVSj0Cy9TQ3
        FLTPwE57ML8OJcEjcM/z+VEXIm10nvGnwheyyLY=
X-Google-Smtp-Source: ABdhPJzYVVVgO1l5ee+G35ToqBgV6W1VLg1yzwFPGoT3eURjFCINmhI8FyoxCHV3g75JMGJwB1kUeUoFLK1o2XIjf54=
X-Received: by 2002:a92:c886:: with SMTP id w6mr6465707ilo.227.1625394577542;
 Sun, 04 Jul 2021 03:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210615103312.872-1-alistair@alistair23.me> <20210615103312.872-2-alistair@alistair23.me>
 <20210624205229.GA1966800@robh.at.kernel.org>
In-Reply-To: <20210624205229.GA1966800@robh.at.kernel.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Sun, 4 Jul 2021 20:29:08 +1000
Message-ID: <CAKmqyKPHG9o_Ntm6h38Q2L7FdNjOjo6zZyBNR-Raq4gTw=P11Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: Add support for E Ink VB3300-KCA
To:     Rob Herring <robh@kernel.org>
Cc:     Alistair Francis <alistair@alistair23.me>,
        thierry.reding@gmail.com, sam@ravnborg.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, daniel@0x0f.com,
        linux@rempel-privat.de, kuninori.morimoto.gx@renesas.com,
        max.Merchel@tq-group.com, geert+renesas@glider.be,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 6:52 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Jun 15, 2021 at 08:33:12PM +1000, Alistair Francis wrote:
> > Add support for the 10.3" E Ink panel described at:
> > https://www.eink.com/product.html?type=productdetail&id=7
> >
> > Signed-off-by: Alistair Francis <alistair@alistair23.me>
> > ---
> > v2:
> >  - Fix build warning
> >  - Document new string
> >
> >  .../bindings/display/panel/panel-simple.yaml  |  2 ++
> >  drivers/gpu/drm/panel/panel-simple.c          | 29 +++++++++++++++++++
> >  2 files changed, 31 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > index b3797ba2698b..799e20222551 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > @@ -128,6 +128,8 @@ properties:
> >          # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
> >        - edt,etm0700g0dh6
> >        - edt,etm0700g0edh6
> > +        # E Ink VB3300-KCA
> > +      - eink,vb3300-kca
>
> Combining this with patch 1 would be preferrable. Either way,
>
> Acked-by: Rob Herring <robh@kernel.org>

This should be ready to merge.

Let me know if you want me to squash the patches and send a v3.

Alistair
