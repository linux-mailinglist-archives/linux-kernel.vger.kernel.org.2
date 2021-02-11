Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92480319678
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBKXT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhBKXT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:19:26 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:18:46 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id s23so808687oot.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 15:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3TjKSEVHUCuYyh3OcPWvBxul+LPuyfEayRgdZEUem+4=;
        b=AdCz+zJeBhRM1ldCeGYNjIfs0hIYrhDGMgLvzyLTV0xYtLD5v40wAQs/kzBfVzOcJ9
         klndgb+X00mhlhyfdpckBCuFHDuYtBo9GfLCX+rdCY8ddTttGe21zvvp97kyPLDOPHmW
         RgPAb7IF6rJKxKYhVbqocsky2VLCGIWx31B913SRt5W7Uq5kgfylDC2y5DC/oK6PI50i
         BFd/X99hFeVNHEZXAZIFMluT7ARvC7j2+nFdV/O2mTJ9pE4dAMYsKnqTxWOs+4RE9dik
         aAzOJDCwAY7Es95He1aInqbyMh8gKcaFjJak6Ya44QaVqe2oYnECbNXld/CKDV6XjJ38
         aSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3TjKSEVHUCuYyh3OcPWvBxul+LPuyfEayRgdZEUem+4=;
        b=lR98ZQQXBI/APCHzYJpxPfAaYyQFLuf1SJFnm26460x58DCYCuGYvm92SpbjNAHnQ8
         B8HwtPjujVs2H69O1RMkBACeeyjyoBYHt3ezIZ09E/+8J6UxnTCIhl9kywSnIeatHfQW
         pLvq1D5v5AdXrjQs5soQy/VnM5SHbChcWhtu5MHeSZd0REbgFCz84jOpFJO/NPtsRgyi
         0jHo3I1x2TwfWh5NSsu+TupqppZ2kOQ0takW1Jtt/SYvX0Rd/+0dR/+xQVOvLVG1RThV
         LWvHP3asDJIyyYqyj55cIbCLqD/l+HOZjOqy52dEtflnaBMO5r+EKeY52+I+PTpQBqeV
         HRTg==
X-Gm-Message-State: AOAM532TZdzbCK9x/7TJKHUB/KAmZz67vhHUXzFSnlOHxshker8b/lWg
        c8AdCz3suuTrHiST46wsKx0PWR4fSJKNkbOm6Gm0HCPaQ2zI
X-Google-Smtp-Source: ABdhPJylMW05WemRZSV0gZB8kjtCXAnUiSDFYfY1tGXPRAnUkw8TfSw/M79EksvTO//yAvJ/rbNZT08oBLqozKZ0dN4=
X-Received: by 2002:a4a:c896:: with SMTP id t22mr201496ooq.8.1613085525473;
 Thu, 11 Feb 2021 15:18:45 -0800 (PST)
MIME-Version: 1.0
References: <20210131143033.7441-1-iwamatsu@nigauri.org> <dc9f110a-d998-2f79-aeaa-317ec6032891@xilinx.com>
In-Reply-To: <dc9f110a-d998-2f79-aeaa-317ec6032891@xilinx.com>
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date:   Fri, 12 Feb 2021 08:18:19 +0900
Message-ID: <CABMQnV+eUq5GVYJR98ZSgVHhQ84FCkzW+hVa6vUoMzcMF9o30w@mail.gmail.com>
Subject: Re: [PATCH] firmware: xilinx: Remove zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review.

2021=E5=B9=B42=E6=9C=881=E6=97=A5(=E6=9C=88) 19:08 Michal Simek <michal.sim=
ek@xilinx.com>:
>
> Hi,
>
> On 1/31/21 3:30 PM, Nobuhiro Iwamatsu wrote:
> > zynqmp_pm_get_eemi_ops() was removed in commit 4db8180ffe7c: "Firmware:=
 xilinx:
> > Remove eemi ops for fpga related APIs", but not in IS_REACHABLE(CONFIG_=
ZYNQMP_FIRMWARE).
> > This removed zynqmp_pm_get_eemi_ops() in IS_REACHABLE(CONFIG_ZYNQMP_FIR=
MWARE), and also
> > modify the documentation for this driver.
> >
> > Fixes: 4db8180ffe7c ("firmware: xilinx: Remove eemi ops for fpga relate=
d APIs")
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >  Documentation/driver-api/xilinx/eemi.rst | 27 +-----------------------
> >  include/linux/firmware/xlnx-zynqmp.h     |  5 -----
> >  2 files changed, 1 insertion(+), 31 deletions(-)
> >
> > diff --git a/Documentation/driver-api/xilinx/eemi.rst b/Documentation/d=
river-api/xilinx/eemi.rst
> > index 9dcbc6f18d75df..53416d25d309a8 100644
> > --- a/Documentation/driver-api/xilinx/eemi.rst
> > +++ b/Documentation/driver-api/xilinx/eemi.rst
> > @@ -19,32 +19,7 @@ device to issue or respond to power management reque=
sts.
> >  EEMI ops is a structure containing all eemi APIs supported by Zynq MPS=
oC.
> >  The zynqmp-firmware driver maintain all EEMI APIs in zynqmp_eemi_ops
> >  structure. Any driver who want to communicate with PMC using EEMI APIs
>
> The whole paragraph should be tuned. I would leave here just
>
> "Any driver who want to communicate with PMC using EEMI APIs
> use the functions provided for each function."
>
> Because there is no reference to any eemi ops structure.
>
> The rest looks good to me.

Thank you. I will add your point to the commit log and resend.
Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
