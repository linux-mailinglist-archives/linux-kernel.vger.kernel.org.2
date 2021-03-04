Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931E432D4AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 14:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbhCDNzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 08:55:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241721AbhCDNzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614866039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NyEIHSiKDUNn/tCXcKmevRHZ06HwkCwpqNQZWo0MOs=;
        b=Yw7eb/A1WwbR/WMZsThiHfgo2fOB0TwtQgyGZpSSeAzuVcE9vFG+W8A01szYZxQAwOOjsx
        /yQkAUG7vPbC/lyL47NzdFAOxl/GfFNSM9L5yzzTReChqvUad3mZ3J5Y1E1iVpSMNtkrxw
        VibH5AlkA8UIJPwlc/zM6wTCoUIFONE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-w5KiYuy6N-GvLJRYnlDmIw-1; Thu, 04 Mar 2021 08:53:58 -0500
X-MC-Unique: w5KiYuy6N-GvLJRYnlDmIw-1
Received: by mail-qk1-f198.google.com with SMTP id b78so19593741qkg.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 05:53:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0NyEIHSiKDUNn/tCXcKmevRHZ06HwkCwpqNQZWo0MOs=;
        b=KoCZMhYWVs3gCGkDwFi8yAOutaldCwOYvLWjsV9HouaY68FrGoMr3iAKWyJt/Fluq6
         BwKi5VKz1t1IBssUCxgdisLj6MfaKL8mUsipW4LOYpUuuSCPEVxQL72W9y5RbcBP7nUB
         F28kjIP+8/eP2xIbgs0mysSuXl35/4AVBLR5sptDFcf9qBWBwlxSdvfTUjI1X0cCXsvf
         kIknrvIW0KxZZTypqq0KRNiPvWdcWz43vYwsw2K/molHy3zWHsequNdd8srJReuPBhyD
         0L0CUK8chnS4pG9gbdM1P/WVE4ZacMHxSLm1+KgjYxs0yJVasn0cg3C0OWZaVoPUESC6
         FhyA==
X-Gm-Message-State: AOAM533R0FwOzRPXHD19u1c9AaVJpfzcUwArKWKPjZ/xUkitL1sBUm4e
        NBS9GgYEvAgScuZS1kmYp8rFtC2TqNgg2Z5MtXD/ygx/9D9O3Q8b9E6TCwO4VjT+qUmOaQhaatI
        piTZrx8p3E2OA0t6a8vSWKUsW
X-Received: by 2002:a37:d82:: with SMTP id 124mr3866722qkn.311.1614866037896;
        Thu, 04 Mar 2021 05:53:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGT3yF5xUm79/kr9yt0qZJDs+VrBzXgEskqAkFZtHf49K/GDpC2+i20jQQkNyx9ISwcuGWRA==
X-Received: by 2002:a37:d82:: with SMTP id 124mr3866701qkn.311.1614866037696;
        Thu, 04 Mar 2021 05:53:57 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m5sm10426198qtu.45.2021.03.04.05.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 05:53:57 -0800 (PST)
Subject: Re: [PATCH v2 1/2] dt-bindings: fpga: Add compatible value for Xilinx
 DFX AXI shutdown manager
To:     Nava kishore Manne <nava.manne@xilinx.com>, mdf@kernel.org,
        robh+dt@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        chinnikishore369@gmail.com
Cc:     git@xilinx.com
References: <20210211051148.16722-1-nava.manne@xilinx.com>
 <20210211051148.16722-2-nava.manne@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6e4ff0b7-7f63-46f8-e713-ca07f532336d@redhat.com>
Date:   Thu, 4 Mar 2021 05:53:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210211051148.16722-2-nava.manne@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/10/21 9:11 PM, Nava kishore Manne wrote:
> This patch Adds compatible value for Xilinx Dynamic Function eXchnage(DFX)
> AXI Shutdown manager IP.
>
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
> Changes for v2:
>                 -Modified the doc and added DFX axi shutdown manager node
>                  example node as suggested by Tom Rix.
>
>  .../bindings/fpga/xilinx-pr-decoupler.txt     | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> index 4284d293fa61..0acdfa6d62a4 100644
> --- a/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> +++ b/Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
> @@ -7,13 +7,24 @@ changes from passing through the bridge.  The controller can also
>  couple / enable the bridges which allows traffic to pass through the
>  bridge normally.
>  
> +Xilinx LogiCORE Dynamic Function eXchange(DFX) AXI shutdown manager
> +Softcore is compatible with the Xilinx LogiCORE pr-decoupler.
> +
> +The Dynamic Function eXchange AXI shutdown manager prevents AXI traffic
> +from passing through the bridge. The controller safely handles AXI4MM
> +and AXI4-Lite interfaces on a Reconfigurable Partition when it is
> +undergoing dynamic reconfiguration, preventing the system deadlock
> +that can occur if AXI transactions are interrupted by DFX
> +
>  The Driver supports only MMIO handling. A PR region can have multiple
>  PR Decouplers which can be handled independently or chained via decouple/
>  decouple_status signals.
>  
>  Required properties:
>  - compatible		: Should contain "xlnx,pr-decoupler-1.00" followed by
> -                          "xlnx,pr-decoupler"
> +                          "xlnx,pr-decoupler" or
> +                          "xlnx,dfx-axi-shutdown-manager-1.00" followed by
> +                          "xlnx,dfx-axi-shutdown-manager"
>  - regs			: base address and size for decoupler module
>  - clocks		: input clock to IP
>  - clock-names		: should contain "aclk"
> @@ -22,6 +33,7 @@ See Documentation/devicetree/bindings/fpga/fpga-region.txt and
>  Documentation/devicetree/bindings/fpga/fpga-bridge.txt for generic bindings.
>  
>  Example:
> +Partial Reconfig Decoupler:
>  	fpga-bridge@100000450 {
>  		compatible = "xlnx,pr-decoupler-1.00",
>  			     "xlnx-pr-decoupler";
> @@ -30,3 +42,13 @@ Example:
>  		clock-names = "aclk";
>  		bridge-enable = <0>;
>  	};
> +
> +Dynamic Function eXchange AXI shutdown manager:
> +	fpga-bridge@100000450 {
> +		compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
> +			     "xlnx,dfx-axi-shutdown-manager";
> +		regs = <0x10000045 0x10>;
> +		clocks = <&clkc 15>;
> +		clock-names = "aclk";
> +		bridge-enable = <0>;
> +	};

Thanks for the example.

Reviewed-by: Tom Rix <trix@redhat.com>

