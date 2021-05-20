Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A95389B02
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhETBpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230062AbhETBpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621475026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CmPGuPaEus3bom0R7HRQ4kJr/YdcxqC6Aohkp7TcPvM=;
        b=MX4A4lVtUO2SsbZ47HnIUr37W02cgauUo2uTpLeNXnM9ciUNsWDi2ygSnqFCQ/JjSfMXv5
        SwNeh68gBWF2+1ei70vKyoT7E0SAkOdRtlInd65WapqlAlMvZwpbSZsCvxkaIqQl0ODtEW
        SzKN/J+8NXn+nAJ0E7lEfxNxc6kXX1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-oec969U1PGSbsHKGKR-cKA-1; Wed, 19 May 2021 21:43:44 -0400
X-MC-Unique: oec969U1PGSbsHKGKR-cKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40F891883521;
        Thu, 20 May 2021 01:43:43 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-222.pek2.redhat.com [10.72.12.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0553B60BF1;
        Thu, 20 May 2021 01:43:40 +0000 (UTC)
Date:   Thu, 20 May 2021 09:43:37 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Kevin Mitchell <kevmitch@arista.com>
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: i386 kexec-tools for x86_64 kdump kernels
Message-ID: <20210520014337.GA10223@dhcp-128-65.nay.redhat.com>
References: <YKNFQnJ5JbqQ/OqI@chmeee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKNFQnJ5JbqQ/OqI@chmeee>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,
On 05/17/21 at 09:40pm, Kevin Mitchell wrote:
> Hi,
> 
> As a space-saving strategy for our embedded boot environment, we use an i386
> kexec binary to load our x86_64 kdump kernel from an x86_64 system kernel. This
> worked great up until linux-5.2, which included the commit
> 
> 9ca5c8e632ce ("x86/kdump: Have crashkernel=X reserve under 4G by
> default")
> 
> Sure enough, according to /proc/iomem, the "Crash kernel" area went from
> starting at 0x34000000 to 0x7b000000, which is above the 896M
> limit. Unfortunately, since i386 kexec seems to use
> kexec/arch/i386/kexec-bzImage.c even to load an x86_64 kernel, the
> DEFAULT_BZIMAGE_ADDR_MAX = 0x37FFFFFF 896M limit is still enforced when loading
> the panic kernel:
> 
> # kexec32 --load-panic bzImage64
> Could not find a free area of memory of 0x8000 bytes...
> locate_hole failed
> 
> I can work around this by patching kexec-tools to raise that limit to
> DEFAULT_BZIMAGE_ADDR_MAX = 0xFFFFFFFF which allows loading the x86_64 kdump
> bzImage. This does in fact kexec fine from that position if I trigger a panic.
> 
> However, this doesn't appear to be a general solution since the 896M does still
> apply if either of the kernels is i386. In that case, attempting to kexec from
> the higher address will just hang with no console output. In this case, it
> probably is better to continue to fail to load the kdump image rather than wait
> until the panic to find out something is wrong.

I'm not sure if you can try to detect the kernel type and special case
this in kexec-tools, eg. if the 2nd kernel is 64-bit kernel then just
bump the addr max otherwise go original logic.  If this is doable then
it would be a good way IMO.

See if Eric, Baoquan and other X86 people have more idea.

> 
> Fortunately, while 9ca5c8e632ce allows an i386 kernel to reserve a "Crash
> kernel" region > 896M, it doesn't actually do that by default - I have to force
> it to go there with crashkernel=@. I am not sure if this is just a fluke or if
> there is something actually ensuring it defaults to a working
> location. Nevertheless, it appears the restriction removed by this commit is
> still required by i386 kernels. Its enforcement has just moved to userspace.
> 
> So it seems that the largest fallout of the commit is restricted to the
> admittedly niche combination linux-x86_64 -> kexec-i386 -> linux-x86_64(kdump),
> which no longer works out of the box without pinning the crashkernel address or
> patching kexec.
> 
> Is this just something we need to live with or is it worth looking into how to
> better support this combination?

This is the case I missed, but I would think it as not a common use
case. It would be better to leave it as is in kernel and try to fix in
kexec-tools or just use the workaround.

> 
> Thanks,
> Kevin
> 

Thanks
Dave

