Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97F8430780
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 11:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241662AbhJQJjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 05:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234497AbhJQJjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 05:39:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 376EF60F23;
        Sun, 17 Oct 2021 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634463453;
        bh=TnThaLix6SFkYNB2+9atk2ZdBdQ0TC8TXqRaqicaHi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UF11qCPicbcA0HJPW0PLBaAkIKIYHVexVZimVnnT4rwkh/FATGQrEqOI9LLKkqgVl
         ZdXElZabCc/v+T65lcg0u6cH0YAsOwByFKz6cWwbWBQ1C/Vc3RJ5lyURGOK+XrA+FU
         sdwc06Sz6NLVxFYLzjNPyqfhicBq2gevOoNxHSR8=
Date:   Sun, 17 Oct 2021 11:37:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kushal-kothari <kushalkothari285@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        nsaenz@kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2] staging: vc04_services: replace msleep() by
 usleep_range()
Message-ID: <YWvu2mZutljJLBY7@kroah.com>
References: <20211017092900.134752-1-kushalkothari285@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017092900.134752-1-kushalkothari285@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 02:59:00PM +0530, Kushal-kothari wrote:
> Fixed the warning:-msleep < 20ms can sleep for up to 20ms by replacing
> msleep(unsigned long msecs) by usleep_range(unsigned long min, unsigned long max)

No need to put the parameters in a function call.

> in usecs as msleep(1ms~20ms) can sleep for upto 20 ms.
> 
> Signed-off-by: Kushal-kothari <kushalkothari285@gmail.com>

We need a "Legal" name here, is that how you sign documents?  Sorry, I
have to ask.

> ---
> 
> Changes from v1: Reword both the subject and the log message.
> 
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> index 6fbafdfe340f..80a7898c5331 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> @@ -857,7 +857,7 @@ vchiq_bulk_transmit(unsigned int handle, const void *data, unsigned int size,
>  		if (status != VCHIQ_RETRY)
>  			break;
>  
> -		msleep(1);
> +		usleep_range(1000, 2000);

You can not just randomly pick a range value here without lots of
testing and knowing that the hardware really can support this.

Have you done this here?

thanks,

greg k-h
