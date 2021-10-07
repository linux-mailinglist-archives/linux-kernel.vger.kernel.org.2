Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FA424E27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 09:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240403AbhJGHjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 03:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232512AbhJGHjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 03:39:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B83760F22;
        Thu,  7 Oct 2021 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633592236;
        bh=EeaDISX4nx0CukTLIziNpZxMI2I7MdtAi3qldQDb+ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGt3VR213kXy//b4+APJwNkKQv2k0VvCeoLnXnMgqEEP4ycnXc96fo7EFRCNm9yn8
         iBZDt4mkYgEZup1PPBdyMm/f7WpZcmY+j9LGfMvYyT18xqoIrFHCGNLIABym13fHZV
         lYIYkYbXbddv/7DE///K2Q0phL860mAxoR09rYo6cJwsmbmES2DmTODAC2sgGgCCBd
         /+8P0aMDC1AzyYEvLfytFxr6Ovv6gJebEFxvEwa+Wa97FQAhY2dJWULS+8y3nxkIW6
         fbXkvHIaGGrErHKdu5EnIkMYRON4nvEO/0Q6B7N/oGAX4rWI5WP/CrmHJ1W+tR6GTr
         0N0Bw68QP9g7w==
Date:   Thu, 7 Oct 2021 10:37:10 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 3/3] memory-hotplug.rst: document the "auto-movable"
 online policy
Message-ID: <YV6jpoVERotn/New@kernel.org>
References: <20210930144117.23641-1-david@redhat.com>
 <20210930144117.23641-4-david@redhat.com>
 <YVzvYmf4xWC1DORO@kernel.org>
 <4bab9000-0b49-a852-d574-1c8b2fe10de1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bab9000-0b49-a852-d574-1c8b2fe10de1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 10:01:39AM +0200, David Hildenbrand wrote:
> On 06.10.21 02:35, Mike Rapoport wrote:
> > On Thu, Sep 30, 2021 at 04:41:17PM +0200, David Hildenbrand wrote:
> > > In commit e83a437faa62 ("mm/memory_hotplug: introduce "auto-movable" online
> > > policy") we introduced a new memory online policy to automatically
> > > select a zone for memory blocks to be onlined. We added a way to
> > > set the active online policy and tunables for the auto-movable online
> > > policy. In follow-up commits we tweaked the "auto-movable" policy to also
> > > consider memory device details when selecting zones for memory blocks to
> > > be onlined.
> > > 
> > > Let's document the new toggles and how the two online policies we have
> > > work.
> > > 
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > >   .../admin-guide/mm/memory-hotplug.rst         | 128 +++++++++++++++---
> > >   1 file changed, 108 insertions(+), 20 deletions(-)
> > > 
> > > diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> > > index ee00b70dedde..c20a2c0031cf 100644
> > > --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> > > +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> > > @@ -165,9 +165,8 @@ Or alternatively::
> > >   	% echo 1 > /sys/devices/system/memory/memoryXXX/online
> > > -The kernel will select the target zone automatically, usually defaulting to
> > > -``ZONE_NORMAL`` unless ``movable_node`` has been specified on the kernel
> > > -command line or if the memory block would intersect the ZONE_MOVABLE already.
> > > +The kernel will select the target zone automatically, depending on the
> > > +configured ``online_policy``.
> > >   One can explicitly request to associate an offline memory block with
> > >   ZONE_MOVABLE by::
> > > @@ -198,6 +197,9 @@ Auto-onlining can be enabled by writing ``online``, ``online_kernel`` or
> > >   	% echo online > /sys/devices/system/memory/auto_online_blocks
> > > +Similarly to manual onlining, with ``online`` the kernel will select the
> > > +target zone automatically, depending on the configured ``online_policy``.
> > > +
> > >   Modifying the auto-online behavior will only affect all subsequently added
> > >   memory blocks only.
> > > @@ -393,9 +395,11 @@ command line parameters are relevant:
> > >   ======================== =======================================================
> > >   ``memhp_default_state``	 configure auto-onlining by essentially setting
> > >                            ``/sys/devices/system/memory/auto_online_blocks``.
> > > -``movable_node``	 configure automatic zone selection in the kernel. When
> > > -			 set, the kernel will default to ZONE_MOVABLE, unless
> > > -			 other zones can be kept contiguous.
> > > +``movable_node``	 configure automatic zone selection in the kernel when
> > > +			 using the ``contig-zones`` online policy. When
> > > +			 set, the kernel will default to ZONE_MOVABLE when
> > > +			 onlining a memory block, unless other zones can be kept
> > > +			 contiguous.
> > 
> > The movable_node main purpose is to allow unplugging an entire node. Zone
> > selection is a consequence of this. You may want to cite the description of
> > movable_node in kernel-paramenters.txt here.
> 
> Right, I only document the effects of these parameters on memory
> hot(un)plug.
> 
> What about:
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst
> b/Documentation/admin-guide/mm/memory-hotplug.rst
> index c20a2c0031cf..f8976ded0863 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -402,6 +402,9 @@ command line parameters are relevant:
>                          contiguous.
>  ========================
> =======================================================
> 
> +See Documentation/admin-guide/kernel-parameters.txt for a more generic
> +description of these command line parameters.
> +

Ok.

>  Module Parameters
>  ------------------
> 
> 
> > 
> > And, pardon my ignorance, how movable_node will play with auto-movable
> > policy?
> 
> It's essentially ignored with the auto-movable policy for memory hotplugged
> after boot (!MEMBLOCK_HOTPLUG). That's why only the description of
> "contig-zones" below describes how it interacts with the ``movable_node``,
> and we make it clear here that it's restricted to the "contig-zones" policy
> as well.
> 
> <details>
> Bare metal, where we care about reliably unplugging hotplugged memory
> usually configures auto-onlining to "online_movable": for example, that's
> the case on RHEL. auto-movable doesn't make too much sense for bare metal:
> the nature of "movable_node" is to essentially online anything that might
> get hotunplugged MOVABLE, especially after hotplugging memory and rebooting:
> that is highly dangerous especially in virtualized environments.
> 
> "auto-movable" is valuable in virtualized environments, where we add memory
> via:
> * add_memory_driver_managed() like virtio-mem, whereby such memory is
>   never part of the firmware provided memory-map, so the policy is
>   always in control even after a reboot.
> * Hotplugged virtual DIMMs, such as provided by x86-64/arm64, whereby we
>   don't include these DIMMs in the firmware-provided memory map, but
>   ACPI code adds them after early boot, making it behave similar to
>   add_memory_driver_managed() -- the policy is always in control even
>   after a reboot.
> </details>
 
Do you want to put it somewhere in Documentation/ ?
It's already written anyway ;-)

-- 
Sincerely yours,
Mike.
