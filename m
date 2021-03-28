Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2581534BC74
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 14:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1M6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 08:58:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhC1M5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 08:57:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B18DC6196D;
        Sun, 28 Mar 2021 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616936262;
        bh=pOX4+0NYh2O97DU5Xq26+Hfg1PTnO3nPtyGDd7KAqB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zCIvCtYWJAgYrjqHB/5AwPVZFSGb94Zc1+d1dmbyBmIZcX6QCLpWlth944DRlBDqL
         6EHJk7/wUWsEvI6+nMeyGep2UYyFuZdF1OpQIcK2YnB7WTE4OnkfI0f3wIPgw+M1Ph
         I1Kezx0bDsWCZVXucupccSwz7fQ0pkwclE5bINrM=
Date:   Sun, 28 Mar 2021 14:57:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v8] add support for pci in the pvpanic driver
Message-ID: <YGB9Q4bejSnNlxkv@kroah.com>
References: <1616597356-20696-1-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616597356-20696-1-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 04:49:13PM +0200, Mihai Carabas wrote:
> This patchset adds support for PCI in the pvpanic driver. The device already
> got in qemu [1].
> 
> v2:
> - mmio -> MMIO, pci -> PCI suggested by Randy Dunlap.
> - group pvpanic-common.c and mmio.c in the same module. The intention was to
>   have only one module and the common code splitted up to be re-used by the
>   pvpanic-pci module in the next patch.
> - add a new patch where add the licenses for the new files (when I moved the
>   code to mmio.c I preserved the original licenses there)
> - properly clean-up PCI device when driver removed.
> 
> v3:
> - drop patch 3 with licenses and add them when creating files
> - create a new patch (2/3) which allowes multiple pvpanic instances
> 
> v4:
> - fix Makefile in patch 1/3 and 3/3 for pvpanic.o as suggested by Arnd
> 
> v5:
> - rebase on 5.12
> - fix a warning caused by one of the patches
> 
> v6:
> - remove pr_fmt as were not used
> - "remove" functions of type void
> - moved events/capability per-device structure
> 
> v7:
> - rebased on char-misc-next
> 
> v8:
> - fixed build error while compiling only the first patch (accept
>   my apologizes Greg)
> - build and tested pvpanic functionality after each applied patch

Much better, now queued up, thanks for sticking with it.

greg k-h
