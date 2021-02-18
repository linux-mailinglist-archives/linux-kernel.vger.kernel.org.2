Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6062B31E84A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBRJyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:54:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhBRIll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:41:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 343A960238;
        Thu, 18 Feb 2021 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613637660;
        bh=y1uZixkc/Teji98Qqjp10uO3bpz5x0IaskLw4jV+MyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fedan8NayLvVSPabiYyb1K4vttKD/LAOxtKOMnbM8/e6gFo/kAMF57PfrlUatDJcb
         MFcSFAAQzDpccOcW6giD1hjmNdCnxU2OEtRO12Plbzl5WtDZ3ihwWcPPRQ4y0Z10PS
         dId7/kchTZAfbz6G6o/OWBTG7ZvM7ADeesW67sQE=
Date:   Thu, 18 Feb 2021 09:40:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] irqdomain: remove debugfs_file from struct irq_domain
Message-ID: <YC4oGsBTyMJrGJ9C@kroah.com>
References: <YCvYV53ZdzQSWY6w@kroah.com>
 <20210217195717.13727-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217195717.13727-1-michael@walle.cc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 08:57:17PM +0100, Michael Walle wrote:
> Hi Greg,
> 
> > There's no need to keep around a dentry pointer to a simple file that
> > debugfs itself can look up when we need to remove it from the system.
> > So simplify the code by deleting the variable and cleaning up the logic
> > around the debugfs file.
> 
> This will generate the following oops on my board (arm64,
> freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts). In debugfs_lookup()
> debugfs_mount is NULL.
> 
> [    0.000000] Linux version 5.11.0-next-20210217-00014-g41e0e92a2d05 (mwalle@mwalle01) (aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0, GNU ld (GNU Binutils for Debian) 2.31.1) #69 SMP PREEMPT Wed Feb 17 20:47:10 CET 2021
> [..]
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> [    0.000000] Mem abort info:
> [    0.000000]   ESR = 0x96000004

<snip>

Back to this log, do you see:
	"Unable to pin filesystem for file "
anywhere before this crash?

thanks,

greg k-h
