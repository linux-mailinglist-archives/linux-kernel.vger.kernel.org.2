Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D053D957E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbhG1Sq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhG1Sqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:46:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6BD56056C;
        Wed, 28 Jul 2021 18:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627498013;
        bh=4pYDQiXD1f15dcdtVWaMSRnaxJqMqA5JSOuuTmecDlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jr3JnTCbrw0xAzoeLMwfkhfCHjG9QY5Q+S0FytPjPllEBbNNkH8yU7dTNdYCGQAZL
         0OA1WutivUX891vzWTVUMQ3IUpRyk/4q2mu3sH3fREc3uQJ0BIxZWauJomd4Gyhg7C
         NRr2lvWHJQdgZZDjGTaMRqRxo0c5MddK4hBxoMJk=
Date:   Wed, 28 Jul 2021 20:46:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ojaswin Mujoo <ojaswin98@gmail.com>
Cc:     nsaenz@kernel.org, stefan.wahren@i2se.com,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vchiq: Add details to $CONFIG_VCHIQ_CDEV
 help text
Message-ID: <YQGmG6nwk+pOyAdu@kroah.com>
References: <cover.1627495116.git.ojaswin98@gmail.com>
 <9c9c128b41e31d6bebe646e052aa05c44b19eb83.1627495116.git.ojaswin98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c9c128b41e31d6bebe646e052aa05c44b19eb83.1627495116.git.ojaswin98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 12:07:17AM +0530, Ojaswin Mujoo wrote:
> Add some details to the Kconfig definition of $CONFIG_VCHIQ_CDEV to help
> make the motive behind it a bit more clear.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin98@gmail.com>
> ---
>  drivers/staging/vc04_services/Kconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
> index 2b70c37cdd09..cb02d8a4cb74 100644
> --- a/drivers/staging/vc04_services/Kconfig
> +++ b/drivers/staging/vc04_services/Kconfig
> @@ -25,8 +25,12 @@ config VCHIQ_CDEV
>  	bool "VCHIQ Character Driver"
>  	default y
>  	help
> -		Enable the creation of VCHIQ character driver to help
> -		communicate with the Videocore platform.
> +		Enable the creation of VCHIQ character driver to help communicate
> +		with the VideoCore platform. The cdev exposes ioctls used by
> +		userspace libraries and testing tools to interact with VideoCore.
> +		This can be set to 'N' if the VideoCore communication is not needed
> +		by userspace but only by other kernel modules (like bcm2835-audio).
> +		If not sure, set this to 'Y'.

I still do not understand if I need this driver or not, and I have this
hardware!  What functionality does this driver accomplish?  What is
VideoCore?

thanks,

greg k-h
