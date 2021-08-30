Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2022E3FB6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 15:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbhH3N0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 09:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbhH3N0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 09:26:03 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D1EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:25:09 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a10so15489154qka.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 06:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exvJuGKtr25W/uSVhVmLJ9dDndSizQ5pyVnZeMKPf6U=;
        b=mms14newKPS84RVgPulnIhvgz8tMtpuRypQwgTY51AnAijLWncUJabtEiBlVoTN2zW
         3La+fBT4bRu5jdAP5UumDBl8kAE6qewY4pjP76Cpn3e5PKWq1Bg+lQK/1HscAXA5Cf9+
         KjCXmdXlXxS3A6PFj6UYj7HcfZRe0h1vWv2wXwgQyWUT3iUFsqyERgT1uizU7kvg5RE0
         DAwyxjvkDSaViDtIEI6oQX5qjwriesD2pGB0quveq31AmYLAJnpOu67pUioRufojTDnp
         ta0OajqFszqYnhSHmAIDdU3vuAI7adD0jZihCKzKybnFoqQBTqNREQp+eiqSk0U1g9gW
         Jb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exvJuGKtr25W/uSVhVmLJ9dDndSizQ5pyVnZeMKPf6U=;
        b=rc0I82plrW7jIWb+84YVO3Fxyk7zrW1bCaoBZX/EVHHPB8t55eaMpJrowjsC8qLoCb
         KPW7gujhCV967rpZBBM+xUxX70SekS3fyU7XGzY93Q7IdGMpglo6Q8K592BBzHIZ1FWg
         mNDeCAJPjBcqOy55I9KLk5wfTVmZHHg3YbctfnPn/5SnBThc4SoyFDtaQ7HsXR+XWLu6
         QN5YdE/2txCEn4WmyMN07wgtMU9iilnBc+mMbfuKPvAsDAk+XJFBsNdPY/QvMkWI4fFY
         imlSGfcxgvMkedZ7ZbgDSDyFOBEv/maiWzZgwS45vuCIXSKTs4EBItKh4Nuc5M4Lyabh
         05Qw==
X-Gm-Message-State: AOAM531fJVGLPx2n3qH5YY+dmxzQ4kG+b4CvfA4/Zs5j5IkDsYBkuGmG
        xWY63jYsKd4jLbSZoPFVa8gwaBG6t6zX2q/OnDp3ew==
X-Google-Smtp-Source: ABdhPJyQrSmYGVRpojLW5kEYAkle9dDkeFrhLBy8INWatlvC+AvXupu8xjM/hefniOjkmj7yvU8Hg3Uvuh7N4naBPko=
X-Received: by 2002:a05:620a:941:: with SMTP id w1mr21668872qkw.434.1630329908857;
 Mon, 30 Aug 2021 06:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210829203027.276143-1-marijn.suijten@somainline.org>
 <20210829203027.276143-2-marijn.suijten@somainline.org> <CAA8EJprQ03ipZzO+1vgt9W7jFbLXgsYR0n-oJxVB-142x8dgRA@mail.gmail.com>
 <17d19b93-dbe5-cc85-f302-b52cd8eeed56@somainline.org>
In-Reply-To: <17d19b93-dbe5-cc85-f302-b52cd8eeed56@somainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 30 Aug 2021 16:24:58 +0300
Message-ID: <CAA8EJpqd7_5510TodALnX13Wo0MufYm2G=r6vw9sy=VURrewyw@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm: dts: qcom: apq8064: Use 27MHz PXO clock as DSI
 PLL reference
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Pavel Dubrova <pashadubrova@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2021 at 11:28, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Dmitry,
>
> On 8/30/21 3:18 AM, Dmitry Baryshkov wrote:
> > On Sun, 29 Aug 2021 at 23:30, Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> >>
> >> The 28NM DSI PLL driver for msm8960 calculates with a 27MHz reference
> >> clock and should hence use PXO, not CXO which runs at 19.2MHz.
> >>
> >> Note that none of the DSI PHY/PLL drivers currently use this "ref"
> >> clock; they all rely on (sometimes inexistant) global clock names and
> >> usually function normally without a parent clock.  This discrepancy will
> >> be corrected in a future patch, for which this change needs to be in
> >> place first.
> >>
> >> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > Checked the downstream driver, it always uses 27 MHz clock in calculations.
>
>
> Given our concerns for msm8974 not updating DT in parallel with the
> kernel (hence the need for a global-name fallback because "ref" is
> missing from the DT), should we worry about the same for apq8064?  That
> is, is there a chance that the kernel but not the firmware is upgraded
> leading to the wrong parent clock being used?  The msm8960 variant of
> the 28nm PLL driver uses parent_rate in a few places and might read
> cxo's 19.2MHz erroneously instead of using pxo's 27MHz.

Checked the code. It uses .parent_names =  "pxo", so changing ref
clock should not matter. We'd need to fix ref clocks and after that we
can switch parent names to fw_name.

>
> - Marijn



-- 
With best wishes
Dmitry
