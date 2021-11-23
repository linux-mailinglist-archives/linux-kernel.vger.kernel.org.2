Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBC145A808
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238991AbhKWQiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:38:14 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:39909 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbhKWQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:38:08 -0500
Received: by mail-io1-f45.google.com with SMTP id c3so28780920iob.6;
        Tue, 23 Nov 2021 08:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=yYYt+ix5GvwhmluknOGd0aBPI6f93zM1qLdWjhXIntY=;
        b=0mOzVlwBgGg5S0Ee7t0j8ElImOynp3dxscLCkYbbo2nte3vK4193gixH8ATLPH1tSL
         SJ+Si0ZuyfLetGA859wCQP6ww+IobZV2fmqPU/IDcHUfp1MBfXP9Iyn6nHbzy3JP3Efm
         CCboaWFT9gYTD0CDzamjGJMNs+ROdONNjySOD82/9+sRINMIBs58qOCjAeKpcO3JKNUB
         CuE40/YVbr5m4hoOjL1+Mm+WVHybtqLCyZic3za/DsiAGXJB8f86fBJR3WTWXqhdoYjA
         aK6m7lFJVoOe9XRuUabe2swl2/Bv/DI8Y3i3BTOuxCJf3xx+sKeJT11NZJLyc9PN3LQi
         boOA==
X-Gm-Message-State: AOAM5305LT956OkAdLMB2Wtb3jxCSEvWZrT7QFyju7xCO5qRqz/DTPev
        VFstg3RkcFo1MIEx0ZKpWw==
X-Google-Smtp-Source: ABdhPJxqMjr96NKnejyHd4tiNPOz0rfN4GaOlVHtNeEYUn525+gahVmalu8W9G5viA/1mp1bE0/S+w==
X-Received: by 2002:a05:6638:1311:: with SMTP id r17mr7758029jad.69.1637685299874;
        Tue, 23 Nov 2021 08:34:59 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z6sm9764623ioq.35.2021.11.23.08.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:34:58 -0800 (PST)
Received: (nullmailer pid 3442916 invoked by uid 1000);
        Tue, 23 Nov 2021 16:34:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
In-Reply-To: <20211123134425.3875656-1-michael@walle.cc>
References: <20211123134425.3875656-1-michael@walle.cc>
Subject: Re: [RFC PATCH] dt-bindings: nvmem: add transformation support
Date:   Tue, 23 Nov 2021 09:34:29 -0700
Message-Id: <1637685269.676888.3442915.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 14:44:25 +0100, Michael Walle wrote:
> This is my second attempt to solve the use case where there is only the
> base MAC address stored in an EEPROM or similar storage provider. This
> is the case for the Kontron sl28 board and multiple openwrt supported
> boards.
> 
> The first proposal [1] didn't find much appreciation and there wasn't
> any reply to my question or new proposal [2]. So here we are with my new
> proposal, that is more flexible and doesn't fix the ethernet mac only.
> This is just an RFC for the device tree representation for now to see if
> this is the correct way to tackle this.
> 
> I'm also aware of the latest post process hook support [3]. This doesn't
> fix the base mac address issue, but I think it also doesn't solve the
> case with swapped ethernet addresses in the general case. That hook will
> involve the driver to do the swapping, but how would the driver know
> if that swapping is actually required. Usually the interpretation of the
> content is opaque to the driver, after all it is the user/board
> manufacturer who does program the storage device. We might be lucky in
> the imx-ocotp case because the IMX reference manual actually states
> where and in which format the mac address is programmed.
> 
> Introduce a transformation property. This is intended to be just an
> enumeration of operations. If there will be a new operation, support for
> it has to be added to the nvmem core.
> 
> A transformation might have multiple output values, like in the base mac
> address case. It reads the mac address from the nvmem storage and
> generates multiple individual addresses, i.e. on our board we reserve 8
> consecutive addresses. These addresses then can be assigned to different
> network interfaces. To make it possible to reference different values we
> need to introduce an argument to the phandle. This additional argument
> is then an index into a list of values.
> 
> Example:
>   mac_addresses: base-mac-address@10 {
>     #nvmem-cell-cells = <1>;
>     reg = <10 6>;
>     transformation = <NVMEM_T_ETH_OFFSET 0 1 7>;
>   }
> 
>   &eth0 {
>     nvmem-cells = <&mac_addresses 0>;
>     nvmem-cell-names = "mac-address";
>   };
> 
>   &eth1 {
>     nvmem-cells = <&mac_addresses 2>;
>     nvmem-cell-names = "mac-address";
>   };
> 
> The NVMEM_T_ETH_OFFSET transformation takes N additional (dt) cells and
> will generate N values. In this example BASE_MAC+0, BASE_MAC+1, BASE_MAC+7.
> An nvmem consumer can then reference the nvmem cell with an index. So eth0
> will get BASE_MAC+0 and eth1 will get BASE_MAC+7.
> 
> This should be sufficient flexible for many different transformations
> without having to touch the bindings except for adding documentation and
> checks for new transformations.
> 
> I do have one question regarding "#nvmem-cell-cells" (aside from the
> awkward naming): is it allowed to have that property optional if there
> is no additional argument to the phandle?
> 
> [1] https://lore.kernel.org/all/20210414152657.12097-2-michael@walle.cc/
> [2] https://lore.kernel.org/linux-devicetree/362f1c6a8b0ec191b285ac6a604500da@walle.cc/
> [3] https://lore.kernel.org/lkml/20211013131957.30271-1-srinivas.kandagatla@linaro.org/
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../devicetree/bindings/nvmem/nvmem.yaml      | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/nvmem/nvmem.example.dts:53.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/nvmem/nvmem.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1558545

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

