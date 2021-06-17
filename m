Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2603AB3A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 14:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhFQMfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbhFQMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 08:35:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B88C061574;
        Thu, 17 Jun 2021 05:33:30 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id f30so10295344lfj.1;
        Thu, 17 Jun 2021 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TMY0Ris0xd33XDNMtO1/OKA7wTGbckkTFlmfjUs+FE=;
        b=kzt09qghuwhLJ3PcfTreWVxftuSH4+tHY17/B7ivG8/W3IkO7elVr21a+bptTYgrdY
         t7LV8WdmltahPuIngeIOj8jXa97K9Dt6IFTLdwTXI7I1XilrK/LI20MMpL6nM0xxxPNN
         1wouV5RrKYCyZBth23A/sPKJHMHQcnYoFDbSpzB6lGZk64HuCes8iwUFZMIbFAc/aBFu
         kW/Epmtttg0KzM4T/fYogRwIJB3w/KKfDAY1sFhlTtTkiXha9j2sXOuIchYQnCvUeo72
         wIZ8Kj/uZ2g1eWl2saAFF/rgbdt6tL4V635B1qIhF04YCk+7LW8bYElDs9XRZkPCFTTA
         xpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TMY0Ris0xd33XDNMtO1/OKA7wTGbckkTFlmfjUs+FE=;
        b=Fom8rvUAVE2ujJqGDxnO9KYjlI9GWO0Hhol0UFJvlyPOEemFgZK56kkOFuMHt0r941
         XBzfpDjkvUeFmnM+ywGOJFqNknDJmyd11Hv3vgXFQx5qfV3rm0o9cdl8GuL35L372ZZO
         fJcTOJiv4tWAnTX2/OM5ABQuE7SBRcR72Y1tKEmlSvHoyk+ODoY7v8uTLN5T69WAfbSB
         RnxOPw9tddVNTAoSMezNE6eszvt9YmtdXCQkx9wM2+S+6zBfmjsRmW3VzJSDQDYi5KQk
         svI+8zmWMZjavIzOcNIXV0wsT9XAZVjL3sEjBPVFHIJjLZ8Mn1rgVKxp9wq5rF8Rrq2F
         nTqw==
X-Gm-Message-State: AOAM530epgKAYp9JOvPd2KRzeh4OCMqGaxFR2icfLSlGYhCzap+uab5p
        QkyAlwI8PJ8C2rVRkTqIwmIAW+VX5cInIyUplmQ=
X-Google-Smtp-Source: ABdhPJytaoOBIJu7cplCFpCp5urwyT83v0QuIL1KQKleC7kLlJy8GqijZr6F3pLRtGXj35sPSihLMmvQPsZpOIsbhc8=
X-Received: by 2002:a05:6512:15a4:: with SMTP id bp36mr3321981lfb.539.1623933208976;
 Thu, 17 Jun 2021 05:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210612133134.2738-1-peng.fan@oss.nxp.com> <20210612133134.2738-5-peng.fan@oss.nxp.com>
 <CAHCN7x+bCVcfgb-MmOApBgM=69rz0G8WhsU171SHF3H-12wSfw@mail.gmail.com>
 <CAHCN7xK86pdcx_BouriGTchnBdamNN1Cjjh-UuF-Oy=abq7rrw@mail.gmail.com>
 <7683ab0b-f905-dff1-aa4f-76ad638da568@oss.nxp.com> <CAHCN7xLZZSwbjrUTb6uBOqWYWJdS_+nSr+iPDnh+dNLFSQOuLQ@mail.gmail.com>
 <AM5PR0402MB2756584781B774A75378D28F880E9@AM5PR0402MB2756.eurprd04.prod.outlook.com>
 <CAHCN7xL3CtNN9qY_gCt-pZhqjNf1YMhwTqRBQOWXuj_D2no9cg@mail.gmail.com>
In-Reply-To: <CAHCN7xL3CtNN9qY_gCt-pZhqjNf1YMhwTqRBQOWXuj_D2no9cg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Jun 2021 09:33:17 -0300
Message-ID: <CAOMZO5A770tLF5snNCpWs9-5gA0WGE-k7GyN_SfdMdQv6n+53w@mail.gmail.com>
Subject: Re: [PATCH V7 4/4] soc: imx: Add blk-ctl driver for i.MX8MM
To:     Adam Ford <aford173@gmail.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Thu, Jun 17, 2021 at 9:25 AM Adam Ford <aford173@gmail.com> wrote:

> Even with USB disabled, I was still having issues resuming from
> suspend-to-ram.  I'll enable these and try again.

Could this be ATF version-related?

Peng, could you please share the ATF version you used in your tests?

Cheers
