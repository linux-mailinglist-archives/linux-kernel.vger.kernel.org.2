Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC16404930
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhIILWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhIILWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:22:14 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE42EC061575;
        Thu,  9 Sep 2021 04:21:04 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u16so2021987wrn.5;
        Thu, 09 Sep 2021 04:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=boyHz0uurKLDf0rs+5Mtb8FIKhFhQqkLeE6SMQCQ7Mw=;
        b=XnCBIstlrTZ42iymgvoBMiytRwCAZOvCGFqcobFEjL6BQGw42EonvQXM5RgMH9LTJ7
         AYF9hLzT6IJOSg0HNMbCOr4NidieAAdYQyDATpCiOZ8aq9RLs4vJ0jIM7NdtcmqYLgmF
         CT7DnEwASSFwTDZ8t5c+SM9hH3SovzxrY8IhfdhBnlycryy+clKHd4XnIP1uEce5eYqL
         nNDBylJX6e+ass/kk2XEXn6HhL2W8vKn+zeqADxoRttdR32Mff3FzRko+qVD7wixQW2d
         l7ea+rb6xQ7n8p6VmUjo74NJqq/B4jTzOA+Qk5b7yicP/zHXg4bcLCO8GYmp1JBtiQtW
         JjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=boyHz0uurKLDf0rs+5Mtb8FIKhFhQqkLeE6SMQCQ7Mw=;
        b=pVopGbQh8hBMV3VWTkiTW+m3e/pbcTUi28JPIfwkOzLmpvnR0hCuFuKzEFDe7i0ePq
         do81TM9QTtJPN0PEZV1OT8vVkv8Fn8D/GxU3YU8658u+Girznqomeu/Ujm85dclMahHZ
         EYtkjSXw9Gi2867d/hHdpDflrC8qLGAf8+9hp+d/xR2SvFW4zN8D8VWHbzmUs7foDZ46
         LE4grIne9o0zHpMhj4J1vhy4TRnPeuKChZycJz3D2STf/pdbUuuHZbLAqk6aAuMD+/Wx
         2r2qUAZd0LjEe8CewDRGCUp246nUJ929BwlNgpuE1afuvuFiLTwtMp0yzW4Nf3Ue/rup
         xn1A==
X-Gm-Message-State: AOAM532Z6HCarrTNrj5htbLPkC/AgHy/1QF3v0SgFaMQ1g80ld6FvPoN
        Re2/jiPH+afQ51jr0jC0/4JLr6+NSb+77yHMR8s=
X-Google-Smtp-Source: ABdhPJyWEp4sWX1UjZpYHyCBI2jXJGww22+s01hZJHFPIzOhSQ5OOQWblTaDxzYLJN7KUGOTHPIGmmBBAlGPubdqG9Y=
X-Received: by 2002:adf:d20f:: with SMTP id j15mr2922294wrh.255.1631186463282;
 Thu, 09 Sep 2021 04:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
 <20210903145340.225511-3-daniel.baluta@oss.nxp.com> <YTJTF5VMOyG2iZb0@robh.at.kernel.org>
 <CAEnQRZC-GN9iEPk6-A_oKPHcCYj8_WeQC0TT_NpK_QntkmAqiQ@mail.gmail.com> <CAL_JsqK_DGqYQxKBHDS7PyviF35V-OP7__KRmmTePn9ZHhiz_w@mail.gmail.com>
In-Reply-To: <CAL_JsqK_DGqYQxKBHDS7PyviF35V-OP7__KRmmTePn9ZHhiz_w@mail.gmail.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Thu, 9 Sep 2021 14:20:51 +0300
Message-ID: <CAEnQRZBmruc8GNfJTm99=0K7PyGrEiB1CxY3c2RSZhLFLR-nhQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: dsp: fsl: Add DSP optional clocks documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Baluta <daniel.baluta@oss.nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > The H/W block is controlled by the DSP firmware. So, we don't want
> > to use the Linux kernel driver (thus the H/W block device tree node).
>
> 'status' is how you disable a device to not be used by the OS.
>
> The information about that device's resources are already in DT, we
> don't need to duplicate that here. If you want a list of devices
> assigned to the DSP here, that would be okay.

Thanks! This is a very good idea. I was thinking at a totally different thing.

So having something like this:

dsp {


hw-block-list = <&sai1>, <&sai2>;

}

And then inside the DSP driver we can get access to sai1 clocks. Do
you know of any standard property name?


>
> > The only thing that we cannot control from the DSP firmware are the clocks
> > hence we handle them in the DSP node.
> >
> > We moved the DAI clocks under the DSP node as I think you suggested here:
> >
> > https://www.lkml.org/lkml/2020/3/12/969
>
> No, that's certainly not what I was suggesting. The resources in the
> DSP node should be the h/w resources of the DSP itself.

I see thanks!
