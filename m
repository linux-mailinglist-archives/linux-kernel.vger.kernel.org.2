Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9EE3B6AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 00:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhF1WJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 18:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbhF1WJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 18:09:21 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A356EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:06:54 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id x6so10088091qvx.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jcq/hdU8FtBDL0LhhuBTnqNe3arqNOFmBPel6E2TbbY=;
        b=wFOZvFygswM6iCjB0leZ3gKdj9QSe/sMsQsLOSJ3BgMaxFIxMZw5OLY3S/lM8TYN+4
         F6wQyPrGlhMiyu07L1D+bcUEEGff7b7lY2LFsu0Jd7ayp9ZpI2iu2kEVc+vAwvMoXCyC
         Cz99MBd0i0faS6BB0aNwDKuWyDPtIjTT8tpaL+M+aaribJqEud6BOY9EANrsA9cjk7uL
         eFWViBHvyri+4ORayIUaUsi1+zed/m0i+zJw1Z2gfyE+ufRiFdBlSVcH+br0ts5WW0vv
         yM/VZTsURWHt5/KvcJxifS+zSiIl533aPI87N8ZrOn2k/myh6flfW8Em/lWk5txXjA1r
         LwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jcq/hdU8FtBDL0LhhuBTnqNe3arqNOFmBPel6E2TbbY=;
        b=TfunBgnysNhMrdE740AmeiaZ/4NJ7VPAaN6dEdnG1k0Nj89RmolFjeIYLoIInBwv7R
         pcRzWrXi8vIbT2ET3UF0HrWS2xctiKk32ZWAr1KvRk9LvrY4NVRwxVQOV7eJGBM2mv5c
         YW4YiFwohDL1IWRlAcYf1U5v0+LEx4uLJW1TH0fbByFsHyzhuHqeuGhlrYwvT3ukP1xw
         xn+fk6xUTKmrJxlgil7D9QB6D2Bmwib6mMMOAoQ9PMzR3uiblw69Ns5Av/M1y0RnXI+F
         wx5BCzr+Gu8N0PI7+macL0ZipgA9bGT4y1UloA47hFcxCuJorQ+kqXbk7PoHaYN3nDLz
         I4NA==
X-Gm-Message-State: AOAM531A/QAcEZlrO6sw2BXBNBbudlwjbNylH0JgQBGdy1a/M+juXSaD
        wxZf9M0bMkuaqNrQ0d4c3OYklz5DuhQOdZYCBCCnlQ==
X-Google-Smtp-Source: ABdhPJzlqSC7LidZu3Vzdce3XMdQrcR76aWc7WQeGFXeqqIhywxqoS8WZCtNnPTE9vrwoCkmEBNKI/zu4sQi0QO2/Ko=
X-Received: by 2002:a05:6214:1cb:: with SMTP id c11mr27668985qvt.47.1624918013874;
 Mon, 28 Jun 2021 15:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210513151800.1059435-1-dmitry.baryshkov@linaro.org> <CAL_JsqLtaJ43Y5ySEK5OraScigEO_OD3TMoy6DYFREK7kh=uFg@mail.gmail.com>
In-Reply-To: <CAL_JsqLtaJ43Y5ySEK5OraScigEO_OD3TMoy6DYFREK7kh=uFg@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 29 Jun 2021 01:06:42 +0300
Message-ID: <CAA8EJppSTwrm=8d54OfgagNH7Q8i1uZHko9fZU2gRNZUe23-WA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: allow checking single device tree file
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, 19 May 2021 at 16:43, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, May 13, 2021 at 10:18 AM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Add support for testing single device tree file by running
> > 'make tree.dt.yaml', e.g. 'make ARCH=arm64 qcom/qrb5165-rb5.dt.yaml'.
> > This looks useful for checking idividual changes to dts files.
>
> typo
>
> I'd rather not expose .*.dt.yaml as I want to make checking not
> optional and I have some plans of integrating the schema checks into
> dtc which would eliminate .dt.yaml files. Instead, I think %.dtb
> targets should run the checks always.
>
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 53d09c414635..b36a3d48eb68 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1383,6 +1383,10 @@ ifneq ($(dtstree),)
> >  %.dtbo: include/config/kernel.release scripts_dtc
> >         $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> >
> > +%.dt.yaml: include/config/kernel.release scripts_dtc
> > +       $(Q)$(MAKE) $(build)=Documentation/devicetree/bindings Documentation/devicetree/bindings/processed-schema.json
>
> I don't think we should expose this detail (processed-schema.json) to
> the top-level makefile. This will be built if 'dt_binding_check' is a
> dependency with CHECK_DTBS=y set.
>
> > +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@ CHECK_DTBS=y
>
> CHECK_DTBS here doesn't work. It has to be exported.
>
> So here's my modified patch (%.dtbo should probably be included too,
> but I'm not yet sure how well the schema checks will work on them):

Please excuse me for letting this float for some time. Do you plan to
submit your patch?
Would you like me to do it instead?

> 8<---------------------------------------------------------
> diff --git a/Makefile b/Makefile
> index 53d09c414635..a1e246956d65 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1377,12 +1377,18 @@ endif
>
>  ifneq ($(dtstree),)
>
> -%.dtb: include/config/kernel.release scripts_dtc
> +%.dtb: %.dt.yaml
>         $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>
>  %.dtbo: include/config/kernel.release scripts_dtc
>         $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
>
> +ifneq ($(filter %.dtb, $(MAKECMDGOALS)),)
> +export CHECK_DTBS=y
> +endif
> +%.dt.yaml: dt_binding_check include/config/kernel.release scripts_dtc
> +       $(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
> +



-- 
With best wishes
Dmitry
