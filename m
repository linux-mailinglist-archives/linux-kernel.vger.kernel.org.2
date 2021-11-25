Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0825A45D25C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347619AbhKYBPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347737AbhKYBNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:13:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7391260EB5;
        Thu, 25 Nov 2021 01:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637802593;
        bh=W6nLin1+LvBCgJkpYXar9Oqp+/QHlRQYFRxdQA/dIjo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Ka5imFAgS53mPJWlrVRyDatvOeLWfpQWUYakqO9s0gOpjC/l1M3/SVntiV1zJ2XBL
         T9AUvvgEwnJC1qIt2ZkRsN+QTgZVE++SbWy16Qp/6W83gPCAQ3MOuVIVF2cqMRVb5p
         nqqyN52DYXUa3tD0T3FyYmBEwJmo0Sk1BZO6grgrx0V7nDPNJQuezDM3mkNRlvuRXd
         +/d2nT1SMocHLfJOFIH37nUBR6DaIAVzpc7SarEDXh6CpZjQU8Z0bozSDvF24zjMns
         cov5Slx/hqPf1gmMOKwSHQu1Dp7aEcm3brzS6deAWmYDW1xoVPvDWjI2HBifUzpvuB
         iPglqefMTPz+Q==
Date:   Wed, 24 Nov 2021 17:09:52 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>
Subject: Re: [PATCH V3 6/6] dt-bindings: xen: Clarify "reg" purpose
In-Reply-To: <1637787223-21129-7-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111241708170.1412361@ubuntu-linux-20-04-desktop>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com> <1637787223-21129-7-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Xen on Arm has gained new support recently to calculate and report
> extended regions (unused address space) safe to use for external
> mappings. These regions are reported via "reg" property under
> "hypervisor" node in the guest device-tree. As region 0 is reserved
> for grant table space (always present), the indexes for extended
> regions are 1...N.
> 
> No device-tree bindings update is needed (except clarifying the text)
> as guest infers the presence of extended regions from the number
> of regions in "reg" property.
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> According to the recent update to Xen's guest.txt:
> https://xenbits.xen.org/gitweb/?p=xen.git;a=blob_plain;f=docs/misc/arm/device-tree/guest.txt;hb=refs/heads/master
> 
> Changes V2 -> V3:
>    - new patch
> ---
>  Documentation/devicetree/bindings/arm/xen.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xen.txt b/Documentation/devicetree/bindings/arm/xen.txt
> index db5c56d..156fe10b 100644
> --- a/Documentation/devicetree/bindings/arm/xen.txt
> +++ b/Documentation/devicetree/bindings/arm/xen.txt
> @@ -7,10 +7,14 @@ the following properties:
>  	compatible = "xen,xen-<version>", "xen,xen";
>    where <version> is the version of the Xen ABI of the platform.
>  
> -- reg: specifies the base physical address and size of a region in
> -  memory where the grant table should be mapped to, using an
> -  HYPERVISOR_memory_op hypercall. The memory region is large enough to map
> -  the whole grant table (it is larger or equal to gnttab_max_grant_frames()).
> +- reg: specifies the base physical address and size of the regions in memory
> +  where the special resources should be mapped to, using an HYPERVISOR_memory_op
> +  hypercall.
> +  Region 0 is reserved for mapping grant table, it must be always present.
> +  The memory region is large enough to map the whole grant table (it is larger
> +  or equal to gnttab_max_grant_frames()).
> +  Regions 1...N are extended regions (unused address space) for mapping foreign
> +  GFNs and grants, they might be absent if there is nothing to expose.
>    This property is unnecessary when booting Dom0 using ACPI.

I would remove the last sentence about ACPI as the initialization is not
done via the xen,xen device tree node in that case anyway.

With that change:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
