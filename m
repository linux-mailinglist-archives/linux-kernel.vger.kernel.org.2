Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C13FAF79
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 03:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbhH3BSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 21:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhH3BSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 21:18:37 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C1C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 18:17:44 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d2so10451876qto.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 18:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfXFIu2YP/cyEtXqUoY+pbv5W2e1wSkIPAhVHrp+0/4=;
        b=W1ici69Kt2rAChENIXMHZGGffeOYJlATguvIpNwgAHVB7g5juXF2AiTxCQ6wfYSrFA
         PDa+pXiZVHWIgyW/S7pjve7GPhyvwpUz5M1ZNMF1e9dW21JQy7ZLuO59I53+J8wT3gpB
         1SC+YO+ue2sAQKcWXpif7QJhykrUotm96p4T56hDFOYsi0KlRpuOPI1N/rJXugV1dSNU
         Z2itCS+9uIhP/9XHFxX4EzJmD3ObKjuwkF0rNFtLwStYcnPx8QFp5jYPmL8IZuLQMdyS
         3H5fMitmMhO8ddUQPHreyR4Z+yEoBB+NgWgKoecdEhbWYz2HSttqszHbANPbPAEeiyaB
         Rh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfXFIu2YP/cyEtXqUoY+pbv5W2e1wSkIPAhVHrp+0/4=;
        b=UgEwMwsGMIeBDs4cLPm78EKIOEsDETX5sUr2e+2b0aKYwK4deCFCx5M+H0BeHBa0Hj
         1EWUYLrnQzp1WBTac3VdOMFD0RRvnpr2Ywy3MP5F1oxW0uld9p+DtS/2HThd5OoG1AxA
         XvzE/sJF7Wf9Zoetu4jHeunwiEnQ9sGKB2Ptus08SJ3UzbGE0vaF3sZLEKeDGtNvpRBb
         Frf8FAc0hh3tFfdUolP1gTO15d3DK2ic3Aqoy0EXcZZhryF/TQXv2FhxLMWXpkKZNJkj
         BcEN+gicTH/djnAT35Ztp+vMNB409NwnPVp1UcXaW22TrNozJbo+xSvvirXlWmUIlEPp
         jJsg==
X-Gm-Message-State: AOAM532NTKshoegc5eIFjvq8GDQYIRcPEEHgKVBS893zVO/D3KfC9aZB
        ZxHgcXjf+oXPosQZEHawi3qE0zFXb+lepTB84eZu2g==
X-Google-Smtp-Source: ABdhPJx8aZaQ2hRtqSFrECAuYeiv3KsLCobfsAE1chhz9/GxB0w+F/Ai49RdNUU/F53c3wne99H6s6bjr/joVRjQkpU=
X-Received: by 2002:ac8:66da:: with SMTP id m26mr18703305qtp.273.1630286263447;
 Sun, 29 Aug 2021 18:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210829203027.276143-1-marijn.suijten@somainline.org>
 <20210829203027.276143-3-marijn.suijten@somainline.org> <CAA8EJppmBvohk3CC87N_P3m+CP=bRLWWknS7esDrYb-xArJFvg@mail.gmail.com>
 <a27b4e74-3856-8c5c-73af-05e976430ea2@somainline.org>
In-Reply-To: <a27b4e74-3856-8c5c-73af-05e976430ea2@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 30 Aug 2021 04:17:32 +0300
Message-ID: <CAA8EJpp38fRff+j-+iG2pATSQ9e_R4zRxepmbGqpKP=gcOZotA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/dsi: Use "ref" fw clock instead of global
 name for VCO parent
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 00:53, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Dmitry,
>
> On 8/29/21 10:39 PM, Dmitry Baryshkov wrote:
> > Hi,
> >
> > On Sun, 29 Aug 2021 at 23:30, Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> >>
> >> All DSI PHY/PLL drivers were referencing their VCO parent clock by a
> >> global name, most of which don't exist or have been renamed.  These
> >> clock drivers seem to function fine without that except the 14nm driver
> >> for the sdm6xx [1].
> >>
> >> At the same time all DTs provide a "ref" clock as per the requirements
> >> of dsi-phy-common.yaml, but the clock is never used.  This patchset puts
> >> that clock to use without relying on a global clock name, so that all
> >> dependencies are explicitly defined in DT (the firmware) in the end.
> >
> > msm8974 (28nm-hpm) does not define the "ref" clock. So you'd have to:
> > 1) add ref clock to the dtsi (should come in a separate patch).
>
>
> Thanks for double-checking and noticing this!  I've queued up this patch
> for v2.
>
> > 2) add .name = "xo" as a fallback to the 28nm driver (to be compatible
> > with older devices)
>
>
> Are there msm8974 devices out there that might upgrade kernels, but not
> firmware (DT)?  On other boards (sdm630) I'm removing these from various
> drivers as to not have any possibility of relying on global names, in
> favour of having the clock dependencies fully specified in the DT.

IIUC it is a general policy of trying to be (somewhat)
backwards-compatible. For example because your dts might come from a
different source/be a part of different build process/etc.

>
> > Other than that this looks good to me.
>
>
> Any r-b/a-b/t-b I can pick up for the next round?

Let's get those issues fixed and I'll respond with R-B tags


-- 
With best wishes
Dmitry
