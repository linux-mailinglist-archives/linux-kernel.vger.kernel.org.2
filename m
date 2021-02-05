Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB9D3116C2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbhBEXMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:12:08 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39825 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhBEObN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:31:13 -0500
Received: by mail-ot1-f51.google.com with SMTP id d7so5083938otq.6;
        Fri, 05 Feb 2021 08:08:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5BRKM6m1G8jCHmWPk/p4NoJLu5lrM6XNxY2Am/U+Ay4=;
        b=SD0+wAFS1Pagj62rapulYqoZGGKeggbDwDqPjT1JHAko94Z5SnuYicW+ANWebw136C
         dnZOYs9SAaNspjfZGA++x0tg2aucHeHpe2kCDYC6PLp1dEtBK0LI36cU0CDxG6PqOQBA
         WS7/khkZO0ufkCg2o9TVsK1SbiSGHuE77dp1zZqkC0FS9t2ctMT43ois7Hl9XPb3UDy3
         0St2UFlzV/McEPXI43jB6YgEMDXVfAEzLf56oGw4sZnfa7VC5HnGehgquGsv8KV5BGUY
         tUBW55wLC9UGXvoaSuS7aYbIa00hBZ5Trgw5Q1gxbdc7G06S+2nwGygCWI+r2hNFVjnw
         vT5A==
X-Gm-Message-State: AOAM531p0GSvwWhR63k2uCC83rNwWG3nIcHMVl/+WqluMPi7Z0DWfehz
        q4So7w4Ehf3riHLateW/6tRJfE6wTg==
X-Google-Smtp-Source: ABdhPJzgpseoww0GbKtxA4oUNmoyVQDNbUB9bioWqchv0MrmT+y8lv8T9HoSpmnszZsFRwkafoxDTg==
X-Received: by 2002:a05:6830:1410:: with SMTP id v16mr3556521otp.347.1612539519314;
        Fri, 05 Feb 2021 07:38:39 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y66sm971759oig.46.2021.02.05.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 07:38:38 -0800 (PST)
Received: (nullmailer pid 3112099 invoked by uid 1000);
        Fri, 05 Feb 2021 15:38:37 -0000
Date:   Fri, 5 Feb 2021 09:38:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dwc3-xilinx: Add missing comma in example
Message-ID: <20210205153837.GA3108557@robh.at.kernel.org>
References: <8fa5edcaa6b93859cfda97d080aad378e89c1b44.1611232967.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa5edcaa6b93859cfda97d080aad378e89c1b44.1611232967.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 01:42:49PM +0100, Michal Simek wrote:
> Trivial example fix.

I see this is already applied, but in the future please convert to 
schema rather than doing trivial fixes.

> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  Documentation/devicetree/bindings/usb/dwc3-xilinx.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> index 4aae5b2cef56..a668f43bedf5 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> @@ -19,7 +19,7 @@ Example device node:
>  			#address-cells = <0x2>;
>  			#size-cells = <0x1>;
>  			compatible = "xlnx,zynqmp-dwc3";
> -			clock-names = "bus_clk" "ref_clk";
> +			clock-names = "bus_clk", "ref_clk";
>  			clocks = <&clk125>, <&clk125>;
>  			ranges;
>  
> -- 
> 2.30.0
> 
