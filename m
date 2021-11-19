Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0344566EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 01:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhKSAgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 19:36:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231190AbhKSAgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 19:36:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA54661A81;
        Fri, 19 Nov 2021 00:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637281981;
        bh=1fElwPn9R/HfyDXXTOVjYSsM9qGxrjhRRiHKHxPiRHg=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=H79BP+nXY7Vd+LpvrYVXo2XSIYYUFqgHn5NKOnbOmdQc4FgnfDz6y1VvQ0edmM73P
         D+YQjTs+47xsBttsQcbVFazUX4ibDtazzmRgDw0FRqQIyHHeGp7hIJOhw72IRekPnK
         e3aSgGDDxfNFCA80WNvvhtCsiYs+iMuvVDWNlxUJwULxS/I6n4rNOYw914aTkFupg5
         bSaUEF4B21m/Z8Pa+j64dmyb1GtBVvKjVDLYXBMAmPfojsE0sUh30kJu4Tf0AsRJNh
         /QP7T0rcExFyO2ylxs1yYwaARaM2dG25a2L0ifUDY9t/52S8+Rw48x8CLGdGTdtTvG
         vN7qAlEYS3qrw==
Date:   Thu, 18 Nov 2021 16:32:58 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr <olekstysh@gmail.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien@xen.org>
Subject: Re: [PATCH V2 2/4] arm/xen: Switch to use gnttab_setup_auto_xlat_frames()
 for DT
In-Reply-To: <60cc5b07-5935-aa26-8690-353c779bbab5@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2111181631020.1412361@ubuntu-linux-20-04-desktop>
References: <1635264312-3796-1-git-send-email-olekstysh@gmail.com> <1635264312-3796-3-git-send-email-olekstysh@gmail.com> <alpine.DEB.2.21.2110271754400.20134@sstabellini-ThinkPad-T480s> <60cc5b07-5935-aa26-8690-353c779bbab5@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Nov 2021, Oleksandr wrote:
> On 28.10.21 04:28, Stefano Stabellini wrote:
> 
> Hi Stefano
> 
> I am sorry for the late response.
> 
> > On Tue, 26 Oct 2021, Oleksandr Tyshchenko wrote:
> > > From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > 
> > > Read the start address of the grant table space from DT
> > > (region 0).
> > > 
> > > This patch mostly restores behaviour before commit 3cf4095d7446
> > > ("arm/xen: Use xen_xlate_map_ballooned_pages to setup grant table")
> > > but trying not to break the ACPI support added after that commit.
> > > So the patch touches DT part only and leaves the ACPI part with
> > > xen_xlate_map_ballooned_pages().
> > > 
> > > This is a preparation for using Xen extended region feature
> > > where unused regions of guest physical address space (provided
> > > by the hypervisor) will be used to create grant/foreign/whatever
> > > mappings instead of wasting real RAM pages from the domain memory
> > > for establishing these mappings.
> > > 
> > > The immediate benefit of this change:
> > > - Avoid superpage shattering in Xen P2M when establishing
> > >    stage-2 mapping (GFN <-> MFN) for the grant table space
> > > - Avoid wasting real RAM pages (reducing the amount of memory
> > >    usuable) for mapping grant table space
> > > - The grant table space is always mapped at the exact
> > >    same place (region 0 is reserved for the grant table)
> > > 
> > > Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> > > ---
> > > Changes RFC -> V2:
> > >     - new patch
> > > ---
> > >   arch/arm/xen/enlighten.c | 32 +++++++++++++++++++++++++-------
> > >   1 file changed, 25 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> > > index 7f1c106b..dea46ec 100644
> > > --- a/arch/arm/xen/enlighten.c
> > > +++ b/arch/arm/xen/enlighten.c
> > > @@ -59,6 +59,9 @@ unsigned long xen_released_pages;
> > >   struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS]
> > > __initdata;
> > >     static __read_mostly unsigned int xen_events_irq;
> > > +static phys_addr_t xen_grant_frames;
> > __read_mostly
> 
> ok
> 
> 
> > 
> > 
> > > +#define GRANT_TABLE_INDEX   0
> > >     uint32_t xen_start_flags;
> > >   EXPORT_SYMBOL(xen_start_flags);
> > > @@ -303,6 +306,7 @@ static void __init xen_acpi_guest_init(void)
> > >   static void __init xen_dt_guest_init(void)
> > >   {
> > >   	struct device_node *xen_node;
> > > +	struct resource res;
> > >     	xen_node = of_find_compatible_node(NULL, NULL, "xen,xen");
> > >   	if (!xen_node) {
> > > @@ -310,6 +314,12 @@ static void __init xen_dt_guest_init(void)
> > >   		return;
> > >   	}
> > >   +	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
> > > +		pr_err("Xen grant table region is not found\n");
> > > +		return;
> > > +	}
> > > +	xen_grant_frames = res.start;
> > > +
> > >   	xen_events_irq = irq_of_parse_and_map(xen_node, 0);
> > >   }
> > >   @@ -317,16 +327,20 @@ static int __init xen_guest_init(void)
> > >   {
> > >   	struct xen_add_to_physmap xatp;
> > >   	struct shared_info *shared_info_page = NULL;
> > > -	int cpu;
> > > +	int rc, cpu;
> > >     	if (!xen_domain())
> > >   		return 0;
> > >     	if (!acpi_disabled)
> > >   		xen_acpi_guest_init();
> > > -	else
> > > +	else {
> > >   		xen_dt_guest_init();
> > >   +		if (!xen_grant_frames)
> > > +			return -ENODEV;
> > maybe we can avoid this, see below
> > 
> > 
> > > +	}
> > > +
> > >   	if (!xen_events_irq) {
> > >   		pr_err("Xen event channel interrupt not found\n");
> > >   		return -ENODEV;
> > > @@ -370,12 +384,16 @@ static int __init xen_guest_init(void)
> > >   	for_each_possible_cpu(cpu)
> > >   		per_cpu(xen_vcpu_id, cpu) = cpu;
> > >   -	xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
> > > -	if (xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
> > > -					  &xen_auto_xlat_grant_frames.vaddr,
> > > -					  xen_auto_xlat_grant_frames.count)) {
> > > +	if (!acpi_disabled) {
> > To make the code more resilient couldn't we do:
> > 
> > if (!acpi_disabled || !xen_grant_frames) {
> I think, we can.
> 
> On the one hand, indeed the code more resilient and less change.
> From the other hand if grant table region is not found then something weird
> happened as region 0 is always present in reg property if hypervisor node is
> exposed to the guest.
> The behavior before commit 3cf4095d7446 ("arm/xen: Use
> xen_xlate_map_ballooned_pages to setup grant table") was exactly the same in
> the context of the failure if region wasn't found.
> 
> ...
> 
> Well, if we want to make code more resilient, I will update. But, looks like
> we also need to switch actions in xen_dt_guest_init() in order to process
> xen_events_irq before xen_grant_frames, otherwise we may return after failing
> with region and end up not initializing xen_events_irq so xen_guest_init()
> will fail earlier than reaches that check.
> What do you think?
 
Yes, you are right. I was re-reading the patch to refresh my memory and
I noticed immediately that xen_dt_guest_init also need to be changed so
that xen_events_irq is set before xen_grant_frames.
 
I think it is a minor change that doesn't add complexity but make the
code more robust so I think it is a good idea

 
> > > +		xen_auto_xlat_grant_frames.count = gnttab_max_grant_frames();
> > > +		rc =
> > > xen_xlate_map_ballooned_pages(&xen_auto_xlat_grant_frames.pfn,
> > > +
> > > &xen_auto_xlat_grant_frames.vaddr,
> > > +
> > > xen_auto_xlat_grant_frames.count);
> > > +	} else
> > > +		rc = gnttab_setup_auto_xlat_frames(xen_grant_frames);
> > > +	if (rc) {
> > >   		free_percpu(xen_vcpu_info);
> > > -		return -ENOMEM;
> > > +		return rc;
> > >   	}
> > >   	gnttab_init();

