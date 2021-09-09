Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8B405BD5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 19:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240539AbhIIRRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 13:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237002AbhIIRRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 13:17:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4636061179;
        Thu,  9 Sep 2021 17:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631207758;
        bh=6MPSHzZT+wdjZOpnQ7K70UGKNWNw78Qt+uaALoiNHzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ur2rhy1GxLjo187czO/UhbKA71WUYOuDssPXJbRQzb9xWT3LfpTZ3XwCFqaKDqm21
         4vwEfcqbHjO+0SEwiwon8XkmM12vYOYvFu/WVOwLz40QfscvgnJCyIjEyCEs7Q/g9K
         gnLnvGikDuTbyDA8V+H5Dvk9oMHLyeRTPifrwfd4xyx9Y3LRDvx9rPpCWbLyu7xPaE
         nQKp9uyAJy4hZL4ovU+mbbwvd6SYbqeJOMrwhfx5Qm7WVk9rFYhZ7xOJliTXAgYAwX
         0GCZjXlnfeRsVxcgvNJrMULFHMCtH/UqvYqSYGaiOfYlbq2HaVZdPOKaeEwZ7yISo1
         FsT0I6dGJtk2A==
Received: by mail-ed1-f42.google.com with SMTP id i6so3654863edu.1;
        Thu, 09 Sep 2021 10:15:58 -0700 (PDT)
X-Gm-Message-State: AOAM533aCY2h7c1aXJMQY3yuM1X2xoL10YJRE7PHQWh2C+n2v0MrYV6p
        kJ0mciOYemNwMdv7+uoi/IIVLX2F1hUlvDeIMQ==
X-Google-Smtp-Source: ABdhPJyM7KZ4cekZmGbkuYORGG988NU14THUy9AbIjOQ+isB8C7xXq78QJxJ1PLPFyvKtKN/u+ZYoeTozdmbIK+obJQ=
X-Received: by 2002:a05:6402:1703:: with SMTP id y3mr4266246edu.355.1631207756787;
 Thu, 09 Sep 2021 10:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210903145340.225511-1-daniel.baluta@oss.nxp.com>
 <20210903145340.225511-3-daniel.baluta@oss.nxp.com> <YTJTF5VMOyG2iZb0@robh.at.kernel.org>
 <CAEnQRZC-GN9iEPk6-A_oKPHcCYj8_WeQC0TT_NpK_QntkmAqiQ@mail.gmail.com>
 <CAL_JsqK_DGqYQxKBHDS7PyviF35V-OP7__KRmmTePn9ZHhiz_w@mail.gmail.com> <CAEnQRZBmruc8GNfJTm99=0K7PyGrEiB1CxY3c2RSZhLFLR-nhQ@mail.gmail.com>
In-Reply-To: <CAEnQRZBmruc8GNfJTm99=0K7PyGrEiB1CxY3c2RSZhLFLR-nhQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 9 Sep 2021 12:15:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJd2AvBxRjHj=VZV2DH26tSNSX=5eEpc-HoFrc=dLxEFQ@mail.gmail.com>
Message-ID: <CAL_JsqJd2AvBxRjHj=VZV2DH26tSNSX=5eEpc-HoFrc=dLxEFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: dsp: fsl: Add DSP optional clocks documentation
To:     Daniel Baluta <daniel.baluta@gmail.com>
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

On Thu, Sep 9, 2021 at 6:21 AM Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> > > The H/W block is controlled by the DSP firmware. So, we don't want
> > > to use the Linux kernel driver (thus the H/W block device tree node).
> >
> > 'status' is how you disable a device to not be used by the OS.
> >
> > The information about that device's resources are already in DT, we
> > don't need to duplicate that here. If you want a list of devices
> > assigned to the DSP here, that would be okay.
>
> Thanks! This is a very good idea. I was thinking at a totally different thing.
>
> So having something like this:
>
> dsp {
>
>
> hw-block-list = <&sai1>, <&sai2>;
>
> }

Yes.

> And then inside the DSP driver we can get access to sai1 clocks. Do
> you know of any standard property name?

There isn't. So it needs a vendor prefix.

There's been some discussions around 'system devicetree' where all
processors (like the DSP) view of the system get represented. Device
assignment is one of the issues to solve with that, but it's not
anywhere close to having something to help here.

Rob
