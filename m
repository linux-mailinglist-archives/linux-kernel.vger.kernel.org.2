Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827BE3D5C83
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhGZORl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:17:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:55972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234762AbhGZORi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:17:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88D5360F51;
        Mon, 26 Jul 2021 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627311487;
        bh=0qF0Vz3MazY904U0HR1NZXSQgySYJWbeHNONYEffRY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qp5vKlIP2r6iVWq4GuDh8CS4jyYF+H4u+Rh3ffwgiBZPqk9x6Pk9PWEIU9zA056Yf
         w6T/rJ6tWcu1d8Vj2KYLzd2iyqALV2eJlxonboskuZlGI2Y1VovtQbFxBGS5qY7wv3
         SwMOzJFsBqgiHK1uz5JrZkuBKwxaY8Aet0hM+n6uNWc1uKFXzKsXENCnoFLeQageCT
         6BAHPGAAFFZFd9hgUjo2mn3Hp6y06UxNIZC+w95aVYHrZjn/WyytRlHqwwXIwjA8Mz
         DiOjQeKW1LfqeZfJcbvS6Ka2ieiZ9AtjVg3x+jl1qJIek2Za2Zm0P7oC9o3sYe5nGz
         oGBYLaVkM3TAA==
Received: by mail-ed1-f45.google.com with SMTP id x14so6153157edr.12;
        Mon, 26 Jul 2021 07:58:07 -0700 (PDT)
X-Gm-Message-State: AOAM5328TnTPvmmqbMRN/axvRkoRDPdjxriuh4QdS6etEWla2o3NQGA3
        hoG9u76c9M1hXwW7eOywCrN/MXUTx4xrPV3tbQ==
X-Google-Smtp-Source: ABdhPJzTiDkxSgrhPUX6HVFGWQ6NBHJXfNpeHFEettRTT0Af+nT7OyyVs51oAy00niCXbs42B2E1B49veAv8Q89s8ss=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr22336914edt.194.1627311486141;
 Mon, 26 Jul 2021 07:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627273794.git.viresh.kumar@linaro.org> <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
In-Reply-To: <fced2f2b9dcf3f32f16866d7d104f46171316396.1627273794.git.viresh.kumar@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 26 Jul 2021 08:57:54 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
Message-ID: <CAL_Jsq+XXhe2g0Rmda1v_Ws4-E_-UE6X5HUsSk-GcAETqQZiCQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/5] dt-bindings: virtio: Add binding for virtio devices
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

On Sun, Jul 25, 2021 at 10:52 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Allow virtio device sub-nodes to be added to the virtio mmio or pci
> nodes. The compatible property for virtio device must be of format
> "virtio,<DID>", where DID is virtio device ID in hexadecimal format.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  .../devicetree/bindings/virtio/mmio.yaml      |  2 +-
>  .../bindings/virtio/virtio-device.yaml        | 47 +++++++++++++++++++
>  2 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/virtio/virtio-device.yaml
>
> diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/virtio/mmio.yaml
> index d46597028cf1..1b91553f87c6 100644
> --- a/Documentation/devicetree/bindings/virtio/mmio.yaml
> +++ b/Documentation/devicetree/bindings/virtio/mmio.yaml
> @@ -36,7 +36,7 @@ title: virtio memory mapped devices
>    - reg
>    - interrupts
>
> -additionalProperties: false
> +additionalProperties: true

That just allows for any random property. What you want is child nodes only:

addtionalProperties:
  type: object

Or you could reference virtio-device.yaml here.

>
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/virtio/virtio-device.yaml b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
> new file mode 100644
> index 000000000000..15cb6df8c98a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/virtio/virtio-device.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/virtio/virtio-device.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Virtio device bindings
> +
> +maintainers:
> +  - Viresh Kumar <viresh.kumar@linaro.org>
> +
> +description:
> +  These bindings are applicable to virtio devices irrespective of the bus they
> +  are bound to, like mmio or pci.
> +
> +# We need a select here so we don't match all nodes with 'virtio,mmio'
> +properties:
> +  $nodename:
> +    pattern: '^[a-z0-9]+-virtio(-[a-z0-9]+)?$'

Node names aren't based on the bus they are on, but their class.
You'll need to drop this.

> +    description: |
> +      Exactly one node describing the virtio device. The name of the node isn't
> +      significant but its phandle can be used to by a user of the virtio device.
> +
> +  compatible:
> +    pattern: "^virtio,[0-9a-f]+$"

DID is only 4 chars? If so, "^virtio,[0-9a-f]{1,4}$"

> +    description: Virtio device nodes.
> +      "virtio,DID", where DID is the virtio device id. The textual
> +      representation of DID shall be in lower case hexadecimal with leading
> +      zeroes suppressed.
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    virtio@3000 {
> +        compatible = "virtio,mmio";
> +        reg = <0x3000 0x100>;
> +        interrupts = <43>;
> +
> +        i2c-virtio {
> +            compatible = "virtio,22";
> +        };
> +    };
> +...
> --
> 2.31.1.272.g89b43f80a514
>
