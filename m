Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4B36FDBA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhD3PZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:25:50 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:44830 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhD3PZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 11:25:49 -0400
Received: by mail-ot1-f47.google.com with SMTP id z25-20020a9d65d90000b02902a560806ca7so6022324oth.11;
        Fri, 30 Apr 2021 08:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=/7eEsvMEZJ47hg8IvqdZUreNggO3ds++/YXgQWY8CIw=;
        b=niAvB/c9IgNCggQ/BnVzrOxIJsznXPRS5X62PR/alpd4NIQLJ/xrucfgHWK3LPqXwj
         M5gRT15N0DhT5SR9b/nohPeq+uqAWDqQRj5trtqliS7tVnIM0ND5Z4+GScfzZ301v/ib
         cgfyzZ0HM0jMHwHcEXMA/2Qqhr/9GTZjFovG2ssjFLUyx5F9vRkCStdR214iN7AfVntf
         MC7cNwXPGFy/ghTx6xmFQySBhNs+wrB768PRJzAH+L8nW7l8DJSH25H3/ma2tO1sJMTw
         YR9uw8x4i2Fd7OdbuVoa8awoUHW4Yp27wru9Bsf+fBfvWvVhhLb3PwjC6oi84DvD0EoM
         RzMQ==
X-Gm-Message-State: AOAM531u4bJDMSFOe52eebHrHHIyiu/C+dt4/dxOewsDnGRleTImh6mX
        iMJy3QaL4C5E9ajBSAtYEw==
X-Google-Smtp-Source: ABdhPJzgxL4fyp7PZwgduyI/n2iPxYyF0MKR4LhThPwz/lhf1+JZjnF5p7RzxxJWkyZbMwnq+hbgMg==
X-Received: by 2002:a9d:615a:: with SMTP id c26mr4037878otk.54.1619796299799;
        Fri, 30 Apr 2021 08:24:59 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u185sm837557oie.12.2021.04.30.08.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 08:24:59 -0700 (PDT)
Received: (nullmailer pid 3353975 invoked by uid 1000);
        Fri, 30 Apr 2021 15:24:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-sunxi@lists.linux.dev,
        Felipe Balbi <balbi@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
In-Reply-To: <20210430031912.42252-2-samuel@sholland.org>
References: <20210430031912.42252-1-samuel@sholland.org> <20210430031912.42252-2-samuel@sholland.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Document the Allwinner H6 DWC3 glue
Date:   Fri, 30 Apr 2021 10:24:53 -0500
Message-Id: <1619796293.743748.3353974.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 22:19:11 -0500, Samuel Holland wrote:
> The RST_BUS_XHCI reset line in the H6 affects both the DWC3 core and the
> USB3 PHY. This suggests the reset line controls the USB3 IP as a whole.
> Represent this by attaching the reset line to a glue layer device.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../usb/allwinner,sun50i-h6-dwc3.yaml         | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.example.dts:23.27-50.11: Warning (unit_address_vs_reg): /example-0/usb@5200000: node has a unit name, but no reg or ranges property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.example.dt.yaml: usb@5200000: usb@5200000:phy-names:0: 'usb2-phy' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/allwinner,sun50i-h6-dwc3.example.dt.yaml: usb@5200000: phy-names:0: 'usb2-phy' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/usb/snps,dwc3.yaml

See https://patchwork.ozlabs.org/patch/1471948

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

