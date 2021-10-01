Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E383541F139
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbhJAPan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhJAPam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:30:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E40661A6F;
        Fri,  1 Oct 2021 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633102138;
        bh=niK2N0n5hIFSNGOKBWBl+J6uRun5yG+bcgN8gmYM7Vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SyK+OXYcQH6Wu+IUyJxCMR2ZWu1juVPrb3ea9UOVZDOOpROfob9jNNaA+8fYyV+Cv
         6o3VzanXkwB27G4TBqHFvvFW/wZYrzziqcnqGnF7rbafo40YlnXkB+Yh9sYtN6dvlB
         CtNrCP/W8ZfGE6Gu0rJw5761qvZXLCTVvz1ylZ9A=
Date:   Fri, 1 Oct 2021 17:28:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v5 0/3] xen, usb: support pvUSB frontend driver
Message-ID: <YVcpNwTtnm2KAnP+@kroah.com>
References: <20211001150039.15921-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001150039.15921-1-jgross@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 05:00:36PM +0200, Juergen Gross wrote:
> This series adds XEN guest pvUSB support. With pvUSB it is possible to
> use physical USB devices from a XEN domain.
> 
> Since V4 a lot of time (several years) has passed. This is a revived
> attempt to get the frontend into the kernel.
> 
> The support consists of a frontend in form of a virtual hcd driver in
> the unprivileged domU passing I/O-requests to the backend in a driver
> domain (usually Dom0). The backend is not part of this patch series,
> as it is supported via qemu.
> 
> The code is taken (and adapted) from the original pvUSB implementation
> done for Linux 2.6 in 2008 by Fujitsu.
> 
> Normal operation of USB devices by adding and removing them dynamically
> to/from a domain has been tested using various USB devices (USB 1.1,
> 2.0 and 3.0) using the qemu based backend.
> 
> Changes in V5:
> - added interface documentation to patch 1
> - frontend no longer trusts backend to return only sane values

You forgot to send patch 3/3 to the linux-usb list :(
