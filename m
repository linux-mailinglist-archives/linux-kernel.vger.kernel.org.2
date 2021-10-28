Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6098843DAB5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 07:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhJ1FZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 01:25:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhJ1FZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 01:25:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D57660E78;
        Thu, 28 Oct 2021 05:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635398573;
        bh=Aznlr7Iqs31knJ/shNpJZTG2LVNF9rkzq+tM0FuBX+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJdwC8NnxdOqbIl+QnJ+RnuJ2RSsCC1/XiyIba4hPq3IvLFKWvzMubi4ZZTE6SHZH
         FPTou70QxGdskxGHnLPxWV+0iNTzhs1q4g7fObJ9o8DeH5I8uMgVjJpNqT9CFV900t
         IIoM/+x+LbXahtzgy77vD/UI6raHJYNM5JtAthJU=
Date:   Thu, 28 Oct 2021 07:22:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     vaatsalya shrivastava <shrivastavavaatsalya@gmail.com>
Cc:     manohar.vanga@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: Cleaned a bit of code that was not
 required
Message-ID: <YXozqK1elRwpK0qf@kroah.com>
References: <20211027193235.5927-1-shrivastavavaatsalya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027193235.5927-1-shrivastavavaatsalya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 03:32:34PM -0400, vaatsalya shrivastava wrote:
> Warning found by checkpatch.pl script.

Please be specific as to what you did.

> 
> Signed-off-by: vaatsalya shrivastava <shrivastavavaatsalya@gmail.com>

"V" and "S"?

> ---
>  drivers/comedi/drivers/dt2815.c        | 2 +-
>  drivers/staging/vme/devices/vme_user.h | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/dt2815.c b/drivers/comedi/drivers/dt2815.c
> index 5906f32aa01f..2be240630bbd 100644
> --- a/drivers/comedi/drivers/dt2815.c
> +++ b/drivers/comedi/drivers/dt2815.c
> @@ -17,7 +17,7 @@
>   * contrary, please update.
>   *
>   * Configuration options:
> - * [0] - I/O port base base address
> + * [0] - I/O port base address

The original is correct.

>   * [1] - IRQ (unused)
>   * [2] - Voltage unipolar/bipolar configuration
>   *	0 == unipolar 5V  (0V -- +5V)
> diff --git a/drivers/staging/vme/devices/vme_user.h b/drivers/staging/vme/devices/vme_user.h
> index 19ecb05781cc..3c1564fd9b20 100644
> --- a/drivers/staging/vme/devices/vme_user.h
> +++ b/drivers/staging/vme/devices/vme_user.h

This is not a comedi driver.

> @@ -14,11 +14,11 @@ struct vme_master {
>  	__u32 aspace;		/* Address Space */
>  	__u32 cycle;		/* Cycle properties */
>  	__u32 dwidth;		/* Maximum Data Width */
> -#if 0
> +

You can not just remove these lines, please realize what you are doing.

thanks,

greg k-h
