Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CC04308AC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245660AbhJQMcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:32:02 -0400
Received: from mail-ua1-f44.google.com ([209.85.222.44]:40776 "EHLO
        mail-ua1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245651AbhJQMbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:31:55 -0400
Received: by mail-ua1-f44.google.com with SMTP id e2so2241330uax.7;
        Sun, 17 Oct 2021 05:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNQrmeLcRYkhU7gSap9RiYo7RaZ8Ovh5R/DJnqwEvKY=;
        b=AJ1DOCof6SmlDUlOwDeP6loJP/W58A1GoYVytgix/yVypJAFFZBnrnKxO0tJ4yErWW
         LkCwnfvdZhgvSJap8TPDbQnfMA/DIM8dBx9jUO1YccatLsl5Lj30bzgU2hrqMpse7Qes
         znmfbEGejqg/zicXnyVUoo5pivOsfzW6sypEdS81YDYlZKaibBnSeDHvoYjM3DjfNLJc
         cnGj1x2oeeN+ojAPRN81DCZPm5zb+61MQclOonS7Z3VM2NcP3M/d7bOYIIrBucsPZwqd
         dnQUNZ1IiJYE9varwHu+A5PvRFj0UEwi788slSA0vrZpVfSKUO3hehiyoYi4FYIIFsPo
         K2Pw==
X-Gm-Message-State: AOAM530GEITODQC5CmIBu484NCaOwQ7zEIcKXugDhlD86rSoaj0/IPUt
        AgEq0hab6NyoHYPRQY7Aso/VrOh7gtjijw==
X-Google-Smtp-Source: ABdhPJxLg0q3sxr2Bpd51F2wvK+Dxosx3ycnWqy03AsVO7lzQ6X4K141M2ibwJQ/1Ri7ezP4QLb6zA==
X-Received: by 2002:ab0:45c4:: with SMTP id u62mr21063253uau.69.1634473785574;
        Sun, 17 Oct 2021 05:29:45 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id s6sm7593694vkh.45.2021.10.17.05.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 05:29:45 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id h19so1702834uax.5;
        Sun, 17 Oct 2021 05:29:45 -0700 (PDT)
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr23567811vsl.9.1634473784867;
 Sun, 17 Oct 2021 05:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-2-zhang.lyra@gmail.com>
 <CAMuHMdWq3M3i+5yATeGEUxupU6Gb5ZnJeNsn9czX6tukEbHQng@mail.gmail.com> <CAAfSe-sQB4wXGwGSPYpoF_YmzJjT=dFLTz36haJ6orE_=zai-Q@mail.gmail.com>
In-Reply-To: <CAAfSe-sQB4wXGwGSPYpoF_YmzJjT=dFLTz36haJ6orE_=zai-Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 17 Oct 2021 14:29:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV8=5p8bdSaw0U+=OdzsQW-Te68XR1o8W_p7oPWjyhGUQ@mail.gmail.com>
Message-ID: <CAMuHMdV8=5p8bdSaw0U+=OdzsQW-Te68XR1o8W_p7oPWjyhGUQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunyan,

On Sat, Oct 16, 2021 at 10:42 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> On Wed, 13 Oct 2021 at 22:23, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Sep 23, 2021 at 8:42 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > Add a new bindings to describe ums512 clock compatible strings.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >
> > > +  clock-names:
> > > +    minItems: 1
> > > +    maxItems: 4
> >
> > After applying this to my local tree, as it is a dependency for 2/4 in
> > for-mfd-next:
> >
> >     Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml:
> > properties:clock-names: {'required': ['maxItems']} is not allowed for
> > {'minItems': 1, 'maxItems': 4, 'items': [{'const': 'ext-26m'},
> > {'const': 'ext-32k'}, {'const': 'ext-4m'}, {'const': 'rco-100m'}]}
> >     hint: "maxItems" is not needed with an "items" list
> >     from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> >
> > so please drop the maxItems 4.
>
> Ok, I will, but I don't have this compile error on my side, how do you
> get this error report?
>
> I use the command below:
> make -k dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> and,
> make -k dt_binding_check

Do you have the latest dt-schema?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
