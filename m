Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15E93E9F68
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbhHLHZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234686AbhHLHZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:25:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4DDF6103A;
        Thu, 12 Aug 2021 07:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628753084;
        bh=EwIrU90Iyan+k9RsNBKZ0gRybIeyH+v6cfuZeVPl0fI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0hwkZyWBR5Ep5rk4tHGMjPtbEDl2w9149gwqk5hMIOxPcszYnLc9lnyYmbPntFj7
         Ni8XTQvWfPpKD2L8KqXg/OAaAhjSOpquJnSI8uRTNE1hGZbK9pQFUd15Xp82SRr++x
         OryrwHjt40niZ/OtkKsyS+KGaAqcvAGlQYyCAfng=
Date:   Thu, 12 Aug 2021 09:24:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        rafael@kernel.org, robin.murphy@arm.com,
        song.bao.hua@hisilicon.com, wangzhou1@hisilicon.com,
        will@kernel.org
Subject: Re: [PATCH] platform-msi: Add ABI to show msi_irqs of platform
 devices
Message-ID: <YRTMuU4dE9RqyDC+@kroah.com>
References: <YRO5R0/N9KITjyY9@kroah.com>
 <20210812041930.28931-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812041930.28931-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 04:19:30PM +1200, Barry Song wrote:
> > But why isn't this all handled by the MSI core code?  Why would each bus
> > need to have this logic in it?
> 
> i think i can extract some common code for sysfs populate/destroy to msi core from pci and platform.
> but we still need some pci/platform specific code in pci-msi and platform-msi cores. for example,
> pci-msi has specific data which will be accessed in its show() entry.
> 
> struct msi_desc {
>         ...
>         union {
>                 /* PCI MSI/X specific data */
>                 struct {
>                         u32 masked;
>                         struct {
>                                 u8      is_msix         : 1;
>                                 u8      multiple        : 3;
>                                 u8      multi_cap       : 3;
>                                 u8      maskbit         : 1;
>                                 u8      is_64           : 1;
>                                 u8      is_virtual      : 1;
>                                 u16     entry_nr;
>                                 unsigned default_irq;
>                         } msi_attrib;
>                         union {
>                                 u8      mask_pos;
>                                 void __iomem *mask_base;
>                         };
>                 };
> 
>                 ...
>                 struct platform_msi_desc platform;
>                 ...
>         };
> };
> 
> in addition, they are quite different in initialization/release and also need different places to save sysfs groups.
> so probably i can let msi cores provide msi_populate_sysfs() and msi_destroy_sysfs() APIs. And ask pci and platform
> to call msi_populate_sysfs() in their init code and save the groups in their specific pointers,  and then they can
> free sysfs in their release paths by calling msi_destroy_sysfs()

Ok, if this isn't easy then I guess it's not a big deal, but you should
go through the MSI developers first.

Why does a platform device have MSI interrupts?  I thought they were
only for PCI devices.

thanks,

greg k-h
