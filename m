Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D0E3B957A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhGAR2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:28:06 -0400
Received: from mail-io1-f44.google.com ([209.85.166.44]:37395 "EHLO
        mail-io1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhGAR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:28:03 -0400
Received: by mail-io1-f44.google.com with SMTP id b15so8478375iow.4;
        Thu, 01 Jul 2021 10:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w6gTmvRwcI4PnriyuDthCbCWYTTLF9ew6XglrfShjWU=;
        b=YZFMY+Nxi/NS4z2uBu68ogLF9A5qU8wU3xKbY4eK6Vs51Zm+GT3MWaB8Mh19YK+dvH
         U5/WtbSPI5dfQi2Yygn6XCAgxxqTYBepzeX0jswTSZC5c5fmP2XToMFHzt0XgtWTpXJn
         Bh8eJIuiT9hsqTNCvpxvEzNTq+r3Wybq2pukMfDgn/ev6xOM4fhswSyzXeE9Wn803pss
         iGa6NnBFzzT0ufxdrLDZXM0Di9P+FgubIUHMHp0RqE2H8Psdyi+CeTJsvv1Mr+qO2333
         4ryLlKyNOZuV53RYKnq2Mfv/2kSWX+SxjM3dfJc4F8H5v6vxc4m5BfOYfN1h9oNBGpc1
         G66Q==
X-Gm-Message-State: AOAM531XHLI/qDm11kxOm/kGhkSzisXvElmTJu0/yRWYLMEYwMsDMf+/
        1/eIBhYVTDY3UtrBcV+RVQ==
X-Google-Smtp-Source: ABdhPJzVUV9TtPlXgeNsc5ysOOuVBhlUICgsvbPoIJOi3pjLqszdZrRPAZBviugbnCuPGPKk75paFA==
X-Received: by 2002:a02:9402:: with SMTP id a2mr843416jai.110.1625160331152;
        Thu, 01 Jul 2021 10:25:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id d6sm248649ioi.5.2021.07.01.10.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 10:25:30 -0700 (PDT)
Received: (nullmailer pid 2589752 invoked by uid 1000);
        Thu, 01 Jul 2021 17:25:27 -0000
Date:   Thu, 1 Jul 2021 11:25:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, drjones@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v5] Documentation, dt, numa: Add note to empty NUMA node
Message-ID: <20210701172527.GA2567910@robh.at.kernel.org>
References: <20210628093411.88805-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628093411.88805-1-gshan@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 05:34:11PM +0800, Gavin Shan wrote:
> The empty memory nodes, where no memory resides in, are allowed.
> For these empty memory nodes, the 'len' of 'reg' property is zero.
> The NUMA node IDs are still valid and parsed, but memory may be
> added to them through hotplug afterwards. I finds difficulty to
> get where it's properly documented.

This is already in use? If so, what platform(s)?

> So lets add a section for empty memory nodes in NUMA binding
> document. Also, the 'unit-address', equivalent to 'base-address'
> in the 'reg' property of these empty memory nodes is suggested to
> be the summation of highest memory address plus the NUMA node ID.

What purpose does this serve? The kernel won't do anything with it other 
than validate the numa-node-id range.

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v5: Separate section for empty memory node
> ---
>  Documentation/devicetree/bindings/numa.txt | 61 +++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> index 21b35053ca5a..230c734af948 100644
> --- a/Documentation/devicetree/bindings/numa.txt
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -103,7 +103,66 @@ Example:
>  		};
>  
>  ==============================================================================
> -4 - Example dts
> +4 - Empty memory nodes
> +==============================================================================
> +
> +Empty memory nodes, which no memory resides in, are allowed. The 'length'
> +field of the 'reg' property is zero, but the 'base-address' is a dummy
> +address and invalid. The 'base-address' could be the summation of highest
> +memory address plus the NUMA node ID. However, the NUMA node IDs and
> +distance maps are still valid and memory may be added into them through
> +hotplug afterwards.
> +
> +Example:
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +		numa-node-id = <0>;
> +	};
> +
> +	memory@0x80000000 {

unit-address should not have '0x'.

> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x80000000>;
> +		numa-node-id = <1>;
> +	};
> +
> +	/* Empty memory node */
> +	memory@0x100000002 {
> +		device_type = "memory";
> +		reg = <0x1 0x2 0x0 0x0>;
> +		numa-node-id = <2>;
> +	};
> +
> +	/* Empty memory node */
> +	memory@0x100000003 {
> +		device_type = "memory";
> +		reg = <0x1 0x3 0x0 0x0>;
> +		numa-node-id = <3>;
> +	};
> +
> +	distance-map {
> +		compatible = "numa-distance-map-v1";
> +		distance-matrix = <0 0  10>,
> +				  <0 1  20>,
> +				  <0 2  40>,
> +				  <0 3  20>,
> +				  <1 0  20>,
> +				  <1 1  10>,
> +				  <1 2  20>,
> +				  <1 3  40>,
> +				  <2 0  40>,
> +				  <2 1  20>,
> +				  <2 2  10>,
> +				  <2 3  20>,
> +				  <3 0  20>,
> +				  <3 1  40>,
> +				  <3 2  20>,
> +				  <3 3  10>;
> +	};
> +
> +==============================================================================
> +5 - Example dts
>  ==============================================================================
>  
>  Dual socket system consists of 2 boards connected through ccn bus and
> -- 
> 2.23.0
> 
> 
