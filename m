Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D51D356070
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 02:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245390AbhDGAqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 20:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbhDGAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 20:46:29 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA91C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 17:46:21 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g38so18236509ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 17:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yzE3zFamcB5Vea5iRk340rFBBLcaLHSo0Qjk+jIwcaY=;
        b=IVFTBdU8wEyJMoUOfBeYw5+mDRNg/H/qAuZ6J+HGgy4SI3mufq5Ce2mvpnlxX1fmh6
         Jvy57xrcxAAJ154Z6J77rxmoi5NtzgNinXrbzH68a+vaC5Og9hxRcdVk73nrkCuvZpVG
         sN/RrSXN+UW7ptxNV5DHrNp8JRp74e7DK4Cv0Rjl/ho1mJT2nBsMHzte8ZaQT6yAYLuR
         Z36n4E2g1lvfuZWXn5FG234L53Y9OgIs49ZH3stjIhpx3/V2oj59zNzEV2SI1kQAbLY9
         5odNPnAg5EEuvTEzyL46UT9JKg/y6aQg6rk2oH5A9pHWawTTXx/wUe8yqzLznUAm6KSb
         IaBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzE3zFamcB5Vea5iRk340rFBBLcaLHSo0Qjk+jIwcaY=;
        b=FFwIzcV31mqVS86ta0FWKAT8y9wasf+MO/QuMOc+s3hJVqgYovREyWdRo+A2Ibco/I
         gR6gl971YDAzUPYn3P/jLDp3SvJIIB36MIJpw8EO449PyCidZsxCDynqvPuu3iQZVXXu
         +gHjmCybAYvcb23dQdLlFevr6KQauPFC//ZJVSZNawpvkmqCnTvQsEuPbcihEwxfNxxB
         KJCatrbljI+yhZX49bwhbQZNkRbzNANgFjtgBgGTyBlsyFkLqSd1YA7Mr4hL1FEsAnBT
         SUix+8MHF6CKnpjpIEui1Ywy8jtT5xGKkIMrYohrRPR+kLohBKlo566efKu6RVkPJV6D
         rJdA==
X-Gm-Message-State: AOAM5327g/zx/n1LwyKcZJ+QFdgGQJz3hUDYnCoai4TbZB8U0VLZaYWP
        qpQxOlZXIVdSudc/24sRwZ6kJTmsBF8M8D+rLQDQ/g==
X-Google-Smtp-Source: ABdhPJwFWGqErirKSpNke7Mjm25xK0JWqXYgdx87+sYF8CgL/Nl1kTt4k2ohsbMR53V5iVTr7+sbuDnS92Z3v+qDXwc=
X-Received: by 2002:a25:3854:: with SMTP id f81mr1063840yba.466.1617756379625;
 Tue, 06 Apr 2021 17:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210405031436.2465475-1-ilya.lipnitskiy@gmail.com>
 <20210405222540.18145-1-ilya.lipnitskiy@gmail.com> <CAGETcx-gF4r1TeY2AA4Vwb5e+5O+_O3E2ENo5tKhh=n_EOJnEQ@mail.gmail.com>
 <20210407003408.GA2551507@robh.at.kernel.org>
In-Reply-To: <20210407003408.GA2551507@robh.at.kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 6 Apr 2021 17:45:43 -0700
Message-ID: <CAGETcx8=sSWj_OmM1GPXNiLcv3anEkJnb_C7NoO9mNwS-O0KhQ@mail.gmail.com>
Subject: Re: [PATCH v2] of: property: fw_devlink: do not link ".*,nr-gpios"
To:     Rob Herring <robh@kernel.org>
Cc:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 5:34 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 06, 2021 at 04:09:10PM -0700, Saravana Kannan wrote:
> > On Mon, Apr 5, 2021 at 3:26 PM Ilya Lipnitskiy
> > <ilya.lipnitskiy@gmail.com> wrote:
> > >
> > > [<vendor>,]nr-gpios property is used by some GPIO drivers[0] to indicate
> > > the number of GPIOs present on a system, not define a GPIO. nr-gpios is
> > > not configured by #gpio-cells and can't be parsed along with other
> > > "*-gpios" properties.
> > >
> > > nr-gpios without the "<vendor>," prefix is not allowed by the DT
> > > spec[1], so only add exception for the ",nr-gpios" suffix and let the
> > > error message continue being printed for non-compliant implementations.
> > >
> > > [0]: nr-gpios is referenced in Documentation/devicetree/bindings/gpio:
> > >  - gpio-adnp.txt
> > >  - gpio-xgene-sb.txt
> > >  - gpio-xlp.txt
> > >  - snps,dw-apb-gpio.yaml
> > >
> > > [1]:
> > > Link: https://github.com/devicetree-org/dt-schema/blob/cb53a16a1eb3e2169ce170c071e47940845ec26e/schemas/gpio/gpio-consumer.yaml#L20
> > >
> > > Fixes errors such as:
> > >   OF: /palmbus@300000/gpio@600: could not find phandle
> > >
> > > Fixes: 7f00be96f125 ("of: property: Add device link support for interrupt-parent, dmas and -gpio(s)")
> > > Signed-off-by: Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
> > > Cc: Saravana Kannan <saravanak@google.com>
> > > Cc: <stable@vger.kernel.org> # 5.5.x
> > > ---
> > >  drivers/of/property.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > > index 2046ae311322..1793303e84ac 100644
> > > --- a/drivers/of/property.c
> > > +++ b/drivers/of/property.c
> > > @@ -1281,7 +1281,16 @@ DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
> > >  DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
> > >  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
> > >  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
> > > -DEFINE_SUFFIX_PROP(gpios, "-gpios", "#gpio-cells")
> > > +
> > > +static struct device_node *parse_gpios(struct device_node *np,
> > > +                                      const char *prop_name, int index)
> > > +{
> > > +       if (!strcmp_suffix(prop_name, ",nr-gpios"))
> > > +               return NULL;
> >
> > Ah I somehow missed this patch. This gives a blanked exception for
> > vendor,nr-gpios. I'd prefer explicit exceptions for all the instances
> > of ",nr-gpios" we are grandfathering in. Any future additions should
> > be rejected. Can we do that please?
> >
> > Rob, you okay with making this list more explicit?
>
> Not the kernel's job IMO. A schema is the right way to handle that.

Ok, that's fine by me. Btw, let's land this in driver-core? I've made
changes there and this might cause conflicts. Not sure.

-Saravana
