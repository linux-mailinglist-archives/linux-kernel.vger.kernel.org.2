Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96B38C6B7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhEUMpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229915AbhEUMpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:45:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09852613AC;
        Fri, 21 May 2021 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621601055;
        bh=+8u7Bzk+pS7SnmB3/zgIbs1kB0ko1X+1PDv2zvMy5rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OAQBjQk781hK2nAwCB91P9kZUJVu9pWgJhBFj6bHcnhrGAAWY9i9WR7K96pHMnaYX
         CpIuL/Luwr4NGHULMNN9VzIyMalC0GzBFiruF/JdJQh5kyRE3yIT6uYogSy2J/asRk
         xhuqwAJ/koOQjIokjKVccDpA1CKHMgRztopYACXc=
Date:   Fri, 21 May 2021 14:44:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v4] misc: alcor_pci: fix null-ptr-deref when there is no
 PCI bridge
Message-ID: <YKerHVMuqnRQmhMz@kroah.com>
References: <cb099c69-0d59-7a12-b0bc-2ce71264363e@canonical.com>
 <20210518192820.181500-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518192820.181500-1-ztong0001@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 03:28:18PM -0400, Tong Zhang wrote:
> There is an issue with the ASPM(optional) capability checking function.
> A device might be attached to root complex directly, in this case,
> bus->self(bridge) will be NULL, thus priv->parent_pdev is NULL.
> Since alcor_pci_init_check_aspm(priv->parent_pdev) checks the PCI link's
> ASPM capability and populate parent_cap_off, which will be used later by
> alcor_pci_aspm_ctrl() to dynamically turn on/off device, what we can do
> here is to avoid checking the capability if we are on the root complex.
> This will make pdev_cap_off 0 and alcor_pci_aspm_ctrl() will simply
> return when bring called, effectively disable ASPM for the device.
> 
> [    1.246492] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> [    1.248731] RIP: 0010:pci_read_config_byte+0x5/0x40
> [    1.253998] Call Trace:
> [    1.254131]  ? alcor_pci_find_cap_offset.isra.0+0x3a/0x100 [alcor_pci]
> [    1.254476]  alcor_pci_probe+0x169/0x2d5 [alcor_pci]
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> Co-developed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Co-developed-by: Colin Ian King <colin.king@canonical.com>
> ---
> v2: check before calling alcor_pci_find_cap_offset()
> v3: Add comment. Enable the dev_dbg() output when priv->parent_pdev is NULL.
> v4: fix inverted if statement, thanks to Colin <colin.king@canonical.com>

Please just send a fix-up patch instead, I don't want to revert and then
add this, that doesn't make any sense...

thanks,

greg k-h
