Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86B36B6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 18:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234514AbhDZQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 12:20:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234108AbhDZQU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 12:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C510261007;
        Mon, 26 Apr 2021 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619453984;
        bh=pXOm3mpkM87VRnOck5FnxWr0aW3uAQxL5gPGaepgaoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xr9Zsce1RJ8rpj5TsF5/fqDNg6NG3pCbsGXcae/CWd4vr6rJJheqgqepNIOseL4BS
         jSbXoMAtiNnA3LzOg8tDtivJhieT7/j15DW7UpcZdaAgcuc8SwDLbTwVUmyKiDHKWn
         wsDbl5m8FaRbOOoasG4Ubm6eIPaA3FgLnj8hblN8=
Date:   Mon, 26 Apr 2021 18:19:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     firas ashkar <firas.ashkar@savoirfairelinux.com>
Cc:     mst@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uio: uio_pci_generic: add missing memory mappings
Message-ID: <YIboHEAW/bmMIkSx@kroah.com>
References: <67ab377328e1acc2374a43fff774be26018c5b3d.camel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67ab377328e1acc2374a43fff774be26018c5b3d.camel@savoirfairelinux.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:29:48AM -0400, firas ashkar wrote:
> Hi,
> pls find attached a trivial but necessary patch, this change is based on [drivers/uio/uio_pdrv_genirq.c], 
> it adds missing memory resources/mappings from the underlying pci device, thus the userspace applications
> can memory map and directly access them. This patch also includes minor style changes.
> 
> The change was tested on following hardware: AltaData ARINC 429 MiniPCIE module on imx8qm-apalis-ixora-v1.2
> board.
> 
> Signed-off-by: Firas Ashkar <firas.ashkar@savoirfairelinux.com>

My bot previously stated what needed to be changed here so that the
patch could be accepted.  It doesn't look like much changes from the
first submission, and for the same reasons I can not take this one
(hint, look at how other patches are submitted on the mailing list, not
as attachments...)

thanks,

greg k-h
