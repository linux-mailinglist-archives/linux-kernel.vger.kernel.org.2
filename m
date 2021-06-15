Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CFE3A843C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhFOPoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 11:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhFOPoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 11:44:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46FE561002;
        Tue, 15 Jun 2021 15:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623771716;
        bh=yJTopbixleB7kemFb4eatmN34SwffsvKgGcIbjW8pJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8s6Uc8FjQLM826adqQpx0iX2PKuHcIdo5BUSHFpxE6N7UpHh/O0iW/NFuizSZCQZ
         yefzKMuMlcGlvNkVdgcd8ASHchTAPtZVMoYpyz6fR+x+r3ZpnXzMCbiLeZPaEWY3/a
         Mhy/EIlNHUuFd77RHBHadIkdURJqZMvNC8oR0g+Q=
Date:   Tue, 15 Jun 2021 17:41:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: Re: [PATCH 2/3] mcb: fix error handling in mcb_alloc_bus()
Message-ID: <YMjKQnFRi0feSYiI@kroah.com>
References: <cover.1623768541.git.johannes.thumshirn@wdc.com>
 <b2fa90594069aa3f61d4658603d922f097ce2bde.1623768541.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2fa90594069aa3f61d4658603d922f097ce2bde.1623768541.git.johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 11:55:29PM +0900, Johannes Thumshirn wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
> 
> There are two bugs:
> 1) If ida_simple_get() fails then this code calls put_device(carrier)
>    but we haven't yet called get_device(carrier) and probably that
>    leads to a use after free.
> 2) After device_initialize() then we need to use put_device() to
>    release the bus.  This will free the internal resources tied to the
>    device and call mcb_free_bus() which will free the rest.
> 
> Fixes: 5d9e2ab9fea4 ("mcb: Implement bus->dev.release callback")
> Fixes: 18d288198099 ("mcb: Correctly initialize the bus's device")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Johannes Thumshirn <jth@kernel.org>
> ---
>  drivers/mcb/mcb-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Shouldn't this go to the stable kernels?  Why not cc: stable in the
signed-off-by lines?

thanks,

greg k-h
