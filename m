Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2E13C7051
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 14:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236167AbhGMMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 08:35:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236042AbhGMMfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 08:35:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDE496128D;
        Tue, 13 Jul 2021 12:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626179573;
        bh=lQp1qM+OVyA5FA6UPEdx5FsD+VtYMugCp7+F/oQsaoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZSMIw01tEJU40SKiEza24NlYBPkARoTSCOyKBrG0JqaXcIHhoi/FhOKa0c4VHtKyo
         55VbXAHxc6KyDOljE+3lvNPqUwThsgBE54iLc8kRWwXumv493ZmZM1m7R/BgGJsYjH
         OCm3ZBYmz1jchBfFwo1KbDn6/Nnxr/1ObX09cij9mW3i+RsGi7sx0afo+jfylf7uQO
         9J+jba7/zkpW26hNLbfQZGsxIKDSHInXsH3HBpmczNGgnJHkwYEkEld2KpFa/+9VTk
         4g3Rc3mXdXZEa/+4H2dABEXJCCDaCcB2cSC1A7zCM74yuGzGYfRikY5jPoq0qanTDE
         Vbd/2mZWRIwwA==
Received: by mail-wr1-f48.google.com with SMTP id m2so19218737wrq.2;
        Tue, 13 Jul 2021 05:32:53 -0700 (PDT)
X-Gm-Message-State: AOAM533UVpKepGKdA3R+Hk7x8i3Ei1MnIIDvAqUVdBauHNPDJegNzJMb
        HwC5NBk3NGUfzlWUkcds2l14NfiDRqpUCbtpeEY=
X-Google-Smtp-Source: ABdhPJx9RwE0XshtFGDOb24uoTXnlhF2YGa9zQx+0CrqHbI1W6ijkWABjqwHiug/MNPjA/e3t0qUIAzdtUG9agunZTg=
X-Received: by 2002:adf:e107:: with SMTP id t7mr5382577wrz.165.1626179572293;
 Tue, 13 Jul 2021 05:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626173013.git.viresh.kumar@linaro.org> <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
In-Reply-To: <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 13 Jul 2021 14:32:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2MZzTpdp8rb1rUEXpx9OChLJJX5Sq+e=hc8hs25iQMsg@mail.gmail.com>
Message-ID: <CAK8P3a2MZzTpdp8rb1rUEXpx9OChLJJX5Sq+e=hc8hs25iQMsg@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device subnode
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 12:51 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:

> +
> +    virtio@3200 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3200 0x100>;
> +        interrupts = <43>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        i2c-virtio@0 {
> +            reg = <VIRTIO_ID_I2C_ADAPTER>;
> +        };
> +    };

This works, but it seems oddly inconsistent with the way we do the same thing
for PCI, USB and MMC devices that normally don't need device tree properties but
can optionally have those.

All of the above use the "compatible" property to identify the device,
rather than
using the "reg" property. Neither of them is actually great here,
since we already
know what the device is and how to talk to it, but I'd still prefer doing this
with

       compatible = "virtio,34";

or similar, where 34 is the numerical value of VIRTIO_ID_I2C_ADAPTER.
This would then be required in the virtio-i2c binding.
I think you can skip the #address-cells/#size-cells then.

       Arnd
