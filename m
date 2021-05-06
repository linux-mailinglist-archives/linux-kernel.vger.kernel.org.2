Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF55437525C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhEFKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231863AbhEFKcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:32:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B52C261177;
        Thu,  6 May 2021 10:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620297117;
        bh=DGaMudpSfyRVHwDiiNsIt1ng3NHfsNT0O7xi2SKKAJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3gHVQ1pBbvAJqF/IyOhA8Zf+pV6Ou39O2UDwMGD5LpskEMQMZV9lNbKLwDZrmYac
         PNUB9cvFiJ9RYmJDp7/gpj0J4tTQJISFV+ee7VHiI2zDspOVAjyWVG9TRdS+j5q+/E
         9aDxVmnftcMpuGrZdj6fGAeuC77f13xasVZJum0Q=
Date:   Thu, 6 May 2021 12:31:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH] usb: musb: remove unused function argument
Message-ID: <YJPFmjo7DolqPa0q@kroah.com>
References: <20210505190254.GA10896@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505190254.GA10896@user>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 12:32:54AM +0530, Saurav Girepunje wrote:
> Remove unused function argument from musb_tx_dma_set_mode_cppi_tusb()
> in musb_host.c
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>  drivers/usb/musb/musb_host.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

This has the same identical subject line as your previous patch, yet it
does something different.

Please fix up both of these patches and resubmit them as a patch series,
with unique subject lines.

thanks,

greg k-h
