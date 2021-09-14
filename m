Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1301440B8B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhINUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:09:06 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D84C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:07:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a10so780990qka.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2K42Cco3VEzvh5/q/0m2XAwxpLXefoWzF9vdOC1B4Gw=;
        b=BJhND6MG+JUZihcXSCVNsVkdDkscbXLe8kths9jHgjS4SLgYrqGaQp9OPqfXejdGA/
         ZIntkKlQZztXJwl/c/22qlX12SBrSu9xI7kd5YDbYcDWkLHLSQisKoAr972kYDUnT241
         jPCyXtIrFjVVOZz3sqJrKkZeNMO/myXFIEVEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2K42Cco3VEzvh5/q/0m2XAwxpLXefoWzF9vdOC1B4Gw=;
        b=Lemw6+bSl4nsvf1RDQ5bf4f7qX3ruhhCcCytMj8m8xRg8JADYmxHGKIkQ8sI1lvQpi
         tCYGnAIZR0mheOGiQMBljuECskEdHiIAIVXnl4OPJGWKgLMnzLpgitr4Qyx/uI1SiU7G
         WDTOEtvxrhZRfncsaroRw3NWEBm+l/eOkteFbHB8gxsPlOTxR3Lr7QtakO5+MdXetBMt
         X6ikFIVxlpT7Bq5YK3WR+aV8P561CtWDyZxTclBYyyy6BtQMGTjPt7YhtEflzB1UumZ4
         UnqVOCtTpv1uBvSwn09zrU+X/35Mo6ph/VhVoofu05qYSSYq4hxQj4PnMLDkzjNceDB4
         hs1g==
X-Gm-Message-State: AOAM5337CfrEHWU/y5E91goZY0s7i9IJP/ICZvR9xoOT3h3HKL+PFv82
        2dgGcV6v1ZwXfc4WmO1a3/5cI4sfEUKAzg==
X-Google-Smtp-Source: ABdhPJzrx5Bk5WIdkB2N5adsGPsAFCOof8sE3XmBcbxXDGTdzNkLvxiQiBzGrLuTH0Z8V8dqaDFHNQ==
X-Received: by 2002:a37:741:: with SMTP id 62mr6768249qkh.490.1631650067422;
        Tue, 14 Sep 2021 13:07:47 -0700 (PDT)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id v14sm8296004qkb.88.2021.09.14.13.07.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 13:07:47 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id y144so825558qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:07:47 -0700 (PDT)
X-Received: by 2002:a05:6638:dc8:: with SMTP id m8mr16281460jaj.93.1631649751964;
 Tue, 14 Sep 2021 13:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210909210032.465570-1-dianders@chromium.org>
 <20210909135838.v4.4.I6103ce2b16e5e5a842b14c7022a034712b434609@changeid>
 <87ee9r10qw.fsf@intel.com> <CAD=FV=XgLcOBOOp9kgShE4+T8g8UZcO_Ff3hhAbGTyLkdE7HNA@mail.gmail.com>
 <CGME20210914185943eucas1p145cf1b087572ec1c4da1f1e269c6f11b@eucas1p1.samsung.com>
 <87y27zyodw.fsf@intel.com> <5af6cd50-0ed3-1a70-d7d0-66ca18a83d65@samsung.com>
In-Reply-To: <5af6cd50-0ed3-1a70-d7d0-66ca18a83d65@samsung.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Sep 2021 13:02:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XHvFq5+Rtax7WNq2-BieQr-BM4UnmOcma_eTzkX2ZtNA@mail.gmail.com>
Message-ID: <CAD=FV=XHvFq5+Rtax7WNq2-BieQr-BM4UnmOcma_eTzkX2ZtNA@mail.gmail.com>
Subject: Re: [PATCH v4 04/15] drm/edid: Use new encoded panel id style for
 quirks matching
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linus W <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 14, 2021 at 12:36 PM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> W dniu 14.09.2021 o 20:59, Jani Nikula pisze:
> > On Tue, 14 Sep 2021, Doug Anderson <dianders@chromium.org> wrote:
> >> Hi,
> >>
> >> On Tue, Sep 14, 2021 at 11:16 AM Jani Nikula
> >> <jani.nikula@linux.intel.com> wrote:
> >>> On Thu, 09 Sep 2021, Douglas Anderson <dianders@chromium.org> wrote:
> >>>> In the patch ("drm/edid: Allow the querying/working with the panel ID
> >>>> from the EDID") we introduced a different way of working with the
> >>>> panel ID stored in the EDID. Let's use this new way for the quirks
> >>>> code.
> >>>>
> >>>> Advantages of the new style:
> >>>> * Smaller data structure size. Saves 4 bytes per panel.
> >>>> * Iterate through quirks structure with just "==" instead of strncmp()
> >>>> * In-kernel storage is more similar to what's stored in the EDID
> >>>>    itself making it easier to grok that they are referring to the same
> >>>>    value.
> >>>>
> >>>> The quirk table itself is arguably a bit less readable in the new
> >>>> style but not a ton less and it feels like the above advantages make
> >>>> up for it.
> >>> I suppose you could pass vendor as a string to EDID_QUIRK() to retain
> >>> better readability?
> >> I would love to, but I couldn't figure out how to do this and have it
> >> compile! Notably I need the compiler to be able to do math at compile
> >> time to compute the final u32 to store in the init data. I don't think
> >> the compiler can dereference strings (even constant strings) and do
> >> math on the result at compile time.
> > Ah, right.
>
>
> What about:
>
> +#define drm_edid_encode_panel_id(vend, product_id) \
> +       ((((u32)((vend)[0]) - '@') & 0x1f) << 26 | \
> +        (((u32)((vend)[1]) - '@') & 0x1f) << 21 | \
> +        (((u32)((vend)[2]) - '@') & 0x1f) << 16 | \
> +        ((product_id) & 0xffff))

Wow, I _swear_ I tried exactly that syntax, but clearly I didn't. It
works great and it looks _sooo_ much nicer now. Thanks! I'll send out
a v5 shortly with this.

-Doug
