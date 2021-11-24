Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2CE45D14B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 00:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhKXXjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 18:39:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231165AbhKXXjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:39:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE98160F12;
        Wed, 24 Nov 2021 23:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637796952;
        bh=nPrNItrkZzgIB91C/Xwr4wBRunHOMHdNFSsrBmYafok=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pv91MMp2Xx+Nhh0KE08I0gNIJ8WemEh04U5gPK2vCVKhQAT6zmyAEGfbrMU2mOE+F
         xM086wsWEmFcTjPU/iequRzWftoTYVPFPNv6Q9N+5XaKikbjl5TQS+9nD7j+lQhLHr
         YQjOihNB4c2Ivrd8kjfoQkj+Wg3nayp397fNw8j0wCci3BR0hcAUjVfOX6fVv2pQ2f
         gAmIcaLpK2Vl6G8C78yqp/VdCK/gUWajeT0/TIyoBNwBDBi6hBTEbEor0xkZVjOmjm
         rNVNvkOzNwv5Sh6itjd5EL5ugVvl6IC8ZrY371061/YhO5Texk9eo/MetOOqbkDAtb
         y93ZQFGdXtIaA==
Date:   Wed, 24 Nov 2021 15:35:50 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>
cc:     xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
Subject: Re: [PATCH V3 2/6] arm/xen: Switch to use gnttab_setup_auto_xlat_frames()
 for DT
In-Reply-To: <1637787223-21129-3-git-send-email-olekstysh@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111241534090.1412361@ubuntu-linux-20-04-desktop>
References: <1637787223-21129-1-git-send-email-olekstysh@gmail.com> <1637787223-21129-3-git-send-email-olekstysh@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021, Oleksandr Tyshchenko wrote:
> From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> 
> Read the start address of the grant table space from DT
> (region 0).
> 
> This patch mostly restores behaviour before commit 3cf4095d7446
> ("arm/xen: Use xen_xlate_map_ballooned_pages to setup grant table")
> but trying not to break the ACPI support added after that commit.
> So the patch touches DT part only and leaves the ACPI part with
> xen_xlate_map_ballooned_pages(). Also in order to make a code more
> resilient use a fallback to xen_xlate_map_ballooned_pages() if grant
> table region wasn't found.
> 
> This is a preparation for using Xen extended region feature
> where unused regions of guest physical address space (provided
> by the hypervisor) will be used to create grant/foreign/whatever
> mappings instead of wasting real RAM pages from the domain memory
> for establishing these mappings.
> 
> The immediate benefit of this change:
> - Avoid superpage shattering in Xen P2M when establishing
>   stage-2 mapping (GFN <-> MFN) for the grant table space
> - Avoid wasting real RAM pages (reducing the amount of memory
>   usuable) for mapping grant table space
> - The grant table space is always mapped at the exact
>   same place (region 0 is reserved for the grant table)
> 
> Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> ---
> Changes RFC -> V2:
>    - new patch
> 
> Changes V2 -> V3:
>    - add __read_mostly specifier to xen_grant_frames
>    - retain a fallback to xen_xlate_map_ballooned_pages() if
>      xen_grant_frames is invalid
>    - process xen_events_irq before xen_grant_frames in
>      xen_dt_guest_init()
>    - update patch description
> ---
>  arch/arm/xen/enlighten.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 7619fbf..3fb3384 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -59,6 +59,9 @@ unsigned long xen_released_pages;
>  struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
>  
>  static __read_mostly unsigned int xen_events_irq;
> +static __read_mostly phys_addr_t xen_grant_frames;
> +
> +#define GRANT_TABLE_INDEX   0
>  
>  uint32_t xen_start_flags;
>  EXPORT_SYMBOL(xen_start_flags);
> @@ -303,6 +306,7 @@ static void __init xen_acpi_guest_init(void)
>  static void __init xen_dt_guest_init(void)
>  {
>  	struct device_node *xen_node;
> +	struct resource res;
>  
>  	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
>  	if (!xen_node) {
> @@ -311,13 +315,19 @@ static void __init xen_dt_guest_init(void)
>  	}
>  
>  	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
> +
> +	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
> +		pr_err("Xen grant table region is not found\n");
> +		return;
> +	}
> +	xen_grant_frames = res.start;
>  }
>  
>  static int __init xen_guest_init(void)
>  {
>  	struct xen_add_to_physmap xatp;
>  	struct shared_info *shared_info_page = NULL;
> -	int cpu;
> +	int rc, cpu;
>  
>  	if (!xen_domain())
>  		return 0;
> @@ -370,12 +380,16 @@ static int __init xen_guest_init(void)
>  	for_each_possible_cpu(cpu)
>  		per_cpu(xen_vcpu_id, cpu) = cpu;
>  
> -	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
> -	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
> -					  &xen_auto_xlat_grant_frames.vaddr,
> -					  xen_auto_xlat_grant_frames.count)) {
> +	if (!acpi_disabled || !xen_grant_frames) {

I realize now that we only need:

    if (!xen_grant_frames) {

with that:

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>



> +		xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
> +		rc = xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
> +										   &xen_auto_xlat_grant_frames.vaddr,
> +										   xen_auto_xlat_grant_frames.count);
> +	} else
> +		rc = gnttab_setup_auto_xlat_frames(xen_grant_frames);
> +	if (rc) {
>  		free_percpu(xen_vcpu_info);
> -		return -ENOMEM;
> +		return rc;
>  	}
>  	gnttab_init();
