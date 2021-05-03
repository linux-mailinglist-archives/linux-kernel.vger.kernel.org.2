Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30950371805
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhECPaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhECPaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:30:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B773C06174A;
        Mon,  3 May 2021 08:29:24 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so6706182edt.13;
        Mon, 03 May 2021 08:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4X7uf9sLw2LlIz1sJKu9KjMmCuee+1oBT6AFDo3JZs4=;
        b=YHBmCP2QAl4UzlJRUwELp0pRtUuuTgj9SePAQgh6pBzUlMqEIihvB/BnB1ISLD9XLJ
         BKxUpaoPLwvUtbfqSpzQ/OXJsxEad60XDz0+ZwLOnvVdOBwqg0akGN0T3UAdj81O1MGb
         lIQo/4UkudtSN5Sdlf35N7rSNnQPusUK5hWxlHRouDNKkJtogwtERshwV9kGrAgpQMrU
         VRF8fN52dZcTuDK9d/xIg9A1CJyBZmilowV2bpXD7Z++CmFeqNWk2m2YT3JmYpoKP4R1
         kvZov44AQrurIsljnM251Lr+rTJR621Y+BKwWdA1mOF/yQDBs5L1PqYUeZD7thjgiPNy
         2vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4X7uf9sLw2LlIz1sJKu9KjMmCuee+1oBT6AFDo3JZs4=;
        b=pwpSstIDKp9LPvNesDH1JLWRxv4UmNZP/hw4HOmLPJu7bgkCmVmNW6SDlL7eEUzcX5
         Z6O1ZlNguRCb92377I9TrSosbeA72Pe5hfgmk3pU40A3lEt9j+Dlx9N+dtahn1VuVq7D
         tE06XgZvuB/tDAm/2EmV4+Ut9p3Zq9LADS9BdcUPMLRNes8MTKfVa8imsBH+pvs4FsP+
         PrYSHp8TU1oFvSMnyvHr8QfZRmXr79aOg3w39hNZle0tnTk2LsjETnRVsjl7MvFDSVTk
         opBtH9bK2C4VKsxNkrwYJmMDlwmbsISzfBpe5X60Ft0kgCMpsX8TNHDfFSbNDjYG7mQ2
         kSQQ==
X-Gm-Message-State: AOAM5313l2os1xOPtiYtN6DwQuvrCb5/FggC8iYQA9TeI0w789xHLYth
        kKVjX8nXGVT5DVMwGcMsH7ie28MwiPp4xCI5QK0=
X-Google-Smtp-Source: ABdhPJxfMfM7a1H/LJS5Afi+r7tTgt7hvt2NboGd9ad2yL60vbFwa1WMHRpQW6zegP4+XVp6V1klfNeWf455cXNzcXI=
X-Received: by 2002:a05:6402:2548:: with SMTP id l8mr1073099edb.208.1620055762146;
 Mon, 03 May 2021 08:29:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210503145503.1477-1-linux.amoon@gmail.com> <20210503145503.1477-4-linux.amoon@gmail.com>
 <CAFBinCCxMvomKt9E0jT_XXpyL1_-qXH4=zVDMNdbDCnZCsnT=A@mail.gmail.com>
In-Reply-To: <CAFBinCCxMvomKt9E0jT_XXpyL1_-qXH4=zVDMNdbDCnZCsnT=A@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 3 May 2021 20:59:10 +0530
Message-ID: <CANAwSgTdFHwtKd-sgQq0Jp8WP55fZG3wsn7feCGo257yqiFkpw@mail.gmail.com>
Subject: Re: [PATCHv1 3/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain
 Meson g12a SoCs
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Mon, 3 May 2021 at 20:37, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Mon, May 3, 2021 at 4:58 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > As per the S922X datasheet add hdmi power domain
> > controller for Meson g12a and g12b SoCs.
> >
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> >  drivers/soc/amlogic/meson-ee-pwrc.c          | 5 +++++
> >  include/dt-bindings/power/meson-g12a-power.h | 1 +
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
> > index 2e07ddf2d6a6..ec402c4ab931 100644
> > --- a/drivers/soc/amlogic/meson-ee-pwrc.c
> > +++ b/drivers/soc/amlogic/meson-ee-pwrc.c
> > @@ -154,6 +154,10 @@ static struct meson_ee_pwrc_mem_domain gxbb_pwrc_mem_vpu[] = {
> >         VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
> >  };
> >
> > +static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_hdmi[] = {
> > +       { HHI_MEM_PD_REG0, GENMASK(15, 8) },
> > +};
> > +
> the VPU power domain already includes:
>   VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
> whereas VPU_HHI_MEMPD is bits[15:8]
>
> Having two power domains which are managing the same registers sounds
> like it'll be causing some trouble
> So for now this is (as I am not even sure what the goal here is):
> NACKed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>

Ok, thanks. On the line of Ethernet PD, I tried to add this accordingly.
whenever I try something new it fails. Please ignore this series.

> Best regards,
> Martin

Thanks
-Anand
