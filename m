Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2679E32A2C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381788AbhCBIcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376891AbhCBIRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:17:12 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EDFC06178B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:09:59 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g8so15557094otk.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Yp6IMdjr+fqwidy7ap2X/QWUwpISs2GQo/1YVRp7Ac=;
        b=qAkKQwplIRSYPFSBTkFqpPss5lNeOKxBF1YZUQSp7kYRXZUqWrVQsFn12dHZ+LogaK
         Mh6A+iegnW9TEbkFcua6807by2HnlA6kjS5zv37AiSb3lBibMdSfCTGRZhE/+lJgpyF3
         RUu0x8vhBF61bb1z4Dwh+hQ9zJplN9iQsrI6V3j8fI0JHMtQ0y0ulvjjAme22e8/p0AD
         y8ka3wOHtS/9jpqITKNEQM76IymEaSgsgCNVHbgWwRpoCadfJ2zONKNgnkJ1xYV+dJmH
         jBiZcEHBgQTauvhMo4xDyjUeFnNSRIYz9mgChPParMuLUa687M2RMGb6c1OzlMABG9YM
         20pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Yp6IMdjr+fqwidy7ap2X/QWUwpISs2GQo/1YVRp7Ac=;
        b=CfrMNxFP0hZtdnqrgVm7PERn19hoEsXbqryoQ49OBOpRjCRquRwe7vuLtJXaztjJk6
         EEF7oLf557jKLsHS1vhH7QM/th/h6bVc3TYHQ5gqltc3mzO+cQhBiohtI/wXUhFjMZ1t
         IPlj05z61Xj4CXL1E0bVyk/MhE9pY7a6oo5i83vBcH75/6RKc5UWCRXMxHFHsLHQ3Umf
         G/Su72a7D+aADJIV4omRdoaEgsNw3TkWXMFpFREynwLLcTB/pB0Ne/5GHNV05Hf06Fb+
         rz/Tj9Oo+cuS2DGtmZQbP52zwuyb+DFAZZ+angjWkcH3Cz6ba3ZNjx2Lh4eWHmiQATNr
         aXlw==
X-Gm-Message-State: AOAM530P6XujbS7u2sMMK4y+L3+xnLqD/O7mjQEHVZWHvGCK5PwaHLce
        XKnG3mcebBANIOzXc//vD1UOCspTx8bD+xtzq0v/
X-Google-Smtp-Source: ABdhPJycQAU4H6nnBzd35FvJRpJes9uYQ1qv/FXAqvovHsqD1ff/W8fUGoryH984ghEAgEUX/l3Rc0jaCsNxcZcB5Xs=
X-Received: by 2002:a9d:63ce:: with SMTP id e14mr16281721otl.347.1614672598987;
 Tue, 02 Mar 2021 00:09:58 -0800 (PST)
MIME-Version: 1.0
References: <1613131643-60062-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1613131643-60062-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <CABMQnVJ+hQ_sdXMdLzhv2Y65QW8Vi01VAjV=SCeOei-zOZ5dwQ@mail.gmail.com> <ecef1943-fec3-9b35-a326-87764512c691@monstr.eu>
In-Reply-To: <ecef1943-fec3-9b35-a326-87764512c691@monstr.eu>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Tue, 2 Mar 2021 17:09:33 +0900
Message-ID: <CABMQnVJLRZ18iZH4oQbZSaC6Bw4do9GnrAVH1sHh6hLa+B2b+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] firmware: xilinx: Add pinctrl support
To:     Michal Simek <monstr@monstr.eu>
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        saikrishna12468@gmail.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        git@xilinx.com, linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2021=E5=B9=B43=E6=9C=881=E6=97=A5(=E6=9C=88) 16:07 Michal Simek <monstr@mon=
str.eu>:
>
> Hi Noburiho,
>
> On 2/28/21 1:17 AM, Nobuhiro Iwamatsu wrote:
> > Hi,
> >
> > 2021=E5=B9=B42=E6=9C=8812=E6=97=A5(=E9=87=91) 21:10 Sai Krishna Potthur=
i
> > <lakshmi.sai.krishna.potthuri@xilinx.com>:
> >>
> >> Adding pinctrl support to query platform specific information (pins)
> >> from firmware.
> >>
> >> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xili=
nx.com>
> >> Acked-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>  drivers/firmware/xilinx/zynqmp.c     | 114 ++++++++++++++++++++++++++=
+
> >>  include/linux/firmware/xlnx-zynqmp.h |  90 +++++++++++++++++++++
> >>  2 files changed, 204 insertions(+)
> >>
> >> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilin=
x/zynqmp.c
> >> index efb8a66efc68..299c3d5a9ebd 100644
> >> --- a/drivers/firmware/xilinx/zynqmp.c
> >> +++ b/drivers/firmware/xilinx/zynqmp.c
> >> @@ -784,6 +784,120 @@ int zynqmp_pm_fpga_get_status(u32 *value)
> >>  }
> >>  EXPORT_SYMBOL_GPL(zynqmp_pm_fpga_get_status);
> >>
> >
> > <snip>
> >
> >> @@ -125,6 +131,12 @@ enum pm_query_id {
> >>         PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS,
> >>         PM_QID_CLOCK_GET_PARENTS,
> >>         PM_QID_CLOCK_GET_ATTRIBUTES,
> >> +       PM_QID_PINCTRL_GET_NUM_PINS =3D 6,
> >> +       PM_QID_PINCTRL_GET_NUM_FUNCTIONS =3D 7,
> >> +       PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS =3D 8,
> >> +       PM_QID_PINCTRL_GET_FUNCTION_NAME =3D 9,
> >> +       PM_QID_PINCTRL_GET_FUNCTION_GROUPS =3D 10,
> >> +       PM_QID_PINCTRL_GET_PIN_GROUPS =3D 11,
> >
> > These do not have to have values, Because PM_QID_INVALID is 0.
> >
> >>         PM_QID_CLOCK_GET_NUM_CLOCKS =3D 12,
> >
> > And you can drop value from this.
>
> Please take a look at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/include/linux/firmware/xlnx-zynqmp.h?h=3Dv5.12-rc1&id=3D1077d4367ab3b97f6d=
b2f66c87289af863652215
>
> We are using explicit values as was recommended by Greg.

Oh, sorry.
I didn't see this comment. Thank you for this information.

>
> Thanks,
> Michal
>

Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
