Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0235EF98
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbhDNI21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 04:28:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229467AbhDNI2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 04:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8AA19613C4;
        Wed, 14 Apr 2021 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618388874;
        bh=bsj0yTP1PFUb/V2oR3gLTK6H+GD+8Hj8YaUWcNDooNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nbu5hnKaG5FnRqZMHYvaz7PTjFo2kSpnEfqclxIHjWqDW1x4SJ/SVKhLFH9VLOU0z
         JYva32lguS00R+s0lc9C3lri+fFuoS21sAZAQm5GYBZxRllBrYioOwrMSP4YZWn1BZ
         DYAipfmpJiHAC/p7rI4HiD9no8R00M5PXfoV+V1k=
Date:   Wed, 14 Apr 2021 10:27:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove sdio_drv_priv structure
Message-ID: <YHanh+kO3Z6qi9Wx@kroah.com>
References: <20210413171124.174008-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413171124.174008-1-hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 05:11:39PM +0000, Bryan Brattlof wrote:
> The sdio_drv_priv structure is a small wrapper around sdio_driver in
> linux/mmc/sdio_func.h with an added drv_registered integer.
> 
> drv_registered is never used anywhere in the driver and only assigned to
> during the sdio registering and unregistering process. We can safely
> remove sdio_drv_priv and use the sdio_driver structure directly.
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 32 ++++++--------------
>  1 file changed, 9 insertions(+), 23 deletions(-)

Does not apply to my tree :(

Please rebase and resend.

thanks,

greg k-h
