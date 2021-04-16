Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A21E3627E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244947AbhDPSow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:44:52 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34772 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhDPSou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:44:50 -0400
Received: by mail-ot1-f53.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so26616317otn.1;
        Fri, 16 Apr 2021 11:44:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ue4U2hx4gZY/OfTJKPiXwVwHVj/Jmgf89NK50uKXHBU=;
        b=bF4SxEqVIeKX/1H47nKGvwsBAX2RqB2EcFcMn2HPFju8hX/iKJiReGmDc0X8k+iNKY
         lTA52B2xD4kaM1M77+hV61GzH6B0xKI4nSsAZrm1vnqpGTP5Zz72RFwgqusfqNdtyqo+
         NGjZsfUiDzKYaJs0gfLJLBNml6JLNSmRL8YOh+ad6Jzl0S/FYXxHNKjEvV+9/4G70Un/
         ata/4uHV1BWTxv00xUqJXK1cy0MEsg6F3Yn8As4a2lQlfysDTeHVxEL2GakuZhjTE2Yc
         9WcuR2UbO1tvc0r1EDkyUDged1quWvU9+D9j0UpOgTAairvYImyNtpdzWJo/vOiMFVAt
         eWSw==
X-Gm-Message-State: AOAM533HDwDDBuRYUbFQYjJEEuQ6az1QmyEiZJX8eb0r4SVzquWdohPN
        j713ol8lz1xpRXMMHm8s8g==
X-Google-Smtp-Source: ABdhPJxNPTL5ESroEEmdFOQGYr1QURmiCb9UHAC1h/YFKMa6RSflMjttW9oHM1p5jnwbn/9BkOgxFg==
X-Received: by 2002:a9d:4d01:: with SMTP id n1mr4821124otf.336.1618598665577;
        Fri, 16 Apr 2021 11:44:25 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l5sm911863otr.72.2021.04.16.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:44:24 -0700 (PDT)
Received: (nullmailer pid 3730968 invoked by uid 1000);
        Fri, 16 Apr 2021 18:44:23 -0000
Date:   Fri, 16 Apr 2021 13:44:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 0/5] mtd: core: OTP nvmem provider support
Message-ID: <20210416184423.GA3715339@robh.at.kernel.org>
References: <20210416114928.27758-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416114928.27758-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:49:23PM +0200, Michael Walle wrote:
> The goal is to fetch a (base) MAC address from the OTP region of a SPI NOR
> flash.
> 
> This is the first part, where I try to add the nvmem provider support to
> the MTD core.
> 
> I'm not sure about the device tree bindings. Consider the following two
> variants:
> 
> (1)
>     flash@0 {
>         ..
> 
>         otp {
>             compatible = "mtd-user-otp";

mtd is a linuxism. Why not just 'nvmem-cells' here or as a fallback if 
we come up with a better name? 

>             #address-cells = <1>;
>             #size-cells = <1>;
> 
>             serial-number@0 {
>                 reg = <0x0 0x8>;
>             };
>         };
>     };
> 
> (2)
>     flash@0 {
>         ..
> 
>         otp {
>             compatible = "mtd-user-otp";
>             #address-cells = <1>;
>             #size-cells = <1>;
> 
> 			some-useful-name {
>                 compatible = "nvmem-cells";
> 
>                 serial-number@0 {
>                     reg = <0x0 0x8>;
>                 };
> 			};
>         };
>     };
> 
> Both bindings use a subnode "opt[-N]". We cannot have the nvmem cells as
> children to the flash node because of the legacy partition binding.
> 
> (1) seems to be the form which is used almost everywhere in the kernel.
> That is, the nvmem cells are just children of the parent node.
> 
> (2) seem to be more natural, because there might also be other properties
> inside the otp subnode and might be more future-proof.
> 
> At the moment this patch implements (1).

I think approach (1) seems fine.

Rob
