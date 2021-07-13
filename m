Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856CC3C7280
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhGMOqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 10:46:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236721AbhGMOqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 10:46:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD0DA61288;
        Tue, 13 Jul 2021 14:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626187403;
        bh=hNJ0K9HFDPahs5ikGtSTAtYOsLP5Ts1mMnq8Pa1WmIo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YmMW05JJ2p+flTzE4h6asnE4AD++Px9zIojyYVAJa/K3Rmh8in58S8PWxSTnVsvnW
         IQuo4p+ouMwoE4aW4+vCvc7v17opnMkW+SNDX9kD8XfJ58S08oSQBHa7OVhHiGuS8P
         y6gvdrj79IGKT3dODIa3TQqUc6CMJXeGkc+pYytoAogD2kgS6038X/Whd6okws7J02
         ol40/280xIDL3u/KmjdHWddpQzj5FKkItMCXZvbZWDSAzZyL77lPNW7JsB3faUMduP
         AKgf/NIzgAsxamyaDvoYF6Izk1VnEaMZhdKIwbiA+9liK9mRCrYtYSz0J8hK0EI3rS
         PzolSBkLKtMkg==
Received: by mail-ej1-f44.google.com with SMTP id nd37so41943222ejc.3;
        Tue, 13 Jul 2021 07:43:23 -0700 (PDT)
X-Gm-Message-State: AOAM530j9oxwslh3A435xgwvsZ/zHr2DI4G5zp9ltohQkk7sLX06K24X
        F4IN2tWHCHbYWHndsJ4JVM7t7uhN/zVDCL9WVQ==
X-Google-Smtp-Source: ABdhPJx8KJ89U2wFb6/w4b8mDik94hL/0OpgIBrKt+puc53ZwqPRiRVGHPqg6EkQ0zFCw2FsgUdbVEEOb7mGJCY/4Cw=
X-Received: by 2002:a17:906:8158:: with SMTP id z24mr6166850ejw.359.1626187402270;
 Tue, 13 Jul 2021 07:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626173013.git.viresh.kumar@linaro.org> <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
In-Reply-To: <aa4bf68fdd13b885a6dc1b98f88834916d51d97d.1626173013.git.viresh.kumar@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 13 Jul 2021 08:43:10 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
Message-ID: <CAL_Jsq+SiE+ciZfASHKUfLU1YMPfB43YmSciT_+gQHvL99_wUA@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: virtio: mmio: Add support for device subnode
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 4:50 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Allow virtio,mmio nodes to contain device specific subnodes. Since each
> virtio,mmio node can represent a single virtio device, each virtio node
> is allowed to contain a maximum of one device specific subnode.

Doesn't sound like we need 2 nodes here. Just add I2C devices as child
nodes. You could add a more specific compatible string, but the
protocol is discoverable, so that shouldn't be necessary.

BTW, what's the usecase for these protocols? A standard interface to
firmware controlled I2C, GPIO, etc.?

> The device subnode must have the "reg" property, and its value must
> match the virtio device ID used by the virtio mmio node.
>
> A phandle to this device subnode can then be used by the users of the
> virtio device.
>
> Also add a symbolic link to uapi/linux/virtio_ids.h in order to use the
> definitions here.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/virtio/mmio.yaml      | 41 +++++++++++++++++++
>  include/dt-bindings/virtio/virtio_ids.h       |  1 +
>  2 files changed, 42 insertions(+)
>  create mode 120000 include/dt-bindings/virtio/virtio_ids.h
>
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> index d46597028cf1..e5f9fe6ecb5e 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -31,6 +31,31 @@ title: virtio memory mapped devices
>      description: Required for devices making accesses thru an IOMMU.
>      maxItems: 1
>
> +  "#address-cells":
> +    const: 1
> +    description:
> +      The cell is the device ID if a device subnode is used.
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  '^[a-z0-9]+-virtio@[0-9]+$':
> +    type: object
> +    description: |
> +      Exactly one node describing the virtio device. The name of the node isn't
> +      significant but its phandle can be used to by an user of the virtio
> +      device.
> +
> +    properties:
> +      reg:
> +        description:
> +          Must contain the Virtio ID of the device.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    required:
> +      - reg
> +
>  required:
>    - compatible
>    - reg
> @@ -57,4 +82,20 @@ additionalProperties: false
>          #iommu-cells = <1>;
>      };
>
> +  - |
> +    #include <dt-bindings/virtio/virtio_ids.h>
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
> +
>  ...
> diff --git a/include/dt-bindings/virtio/virtio_ids.h b/include/dt-bindings/virtio/virtio_ids.h
> new file mode 120000
> index 000000000000..6e59ba332216
> --- /dev/null
> +++ b/include/dt-bindings/virtio/virtio_ids.h
> @@ -0,0 +1 @@
> +../../uapi/linux/virtio_ids.h

This will break the devicetree-rebasing tree I think. DT files
shouldn't reference kernel files.

Rob
