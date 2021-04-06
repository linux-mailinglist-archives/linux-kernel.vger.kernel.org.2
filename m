Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B335550B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344388AbhDFN1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 09:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344389AbhDFN1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 09:27:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C38E1613B8;
        Tue,  6 Apr 2021 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617715631;
        bh=ERIs1PjdZ/cIW7cJ6sgd5HHiOD7kYmFgFIqyjegciDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BeHOw+5imr42Mr7A1F1IAPLNlzoJaHsfiUSIdV4qBVCr4HEfwYPlUTxElZPwoh7H1
         xOg8aOO8eILR+pZrXLP01u/nJWowJzIKjfwSU/cgte6qUJqScS7Lx/8L4x8lMBpZJG
         wj7ycXtK97NOKfKiD9cPeq4gM/jLwSDskSt+G9SI=
Date:   Tue, 6 Apr 2021 15:27:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: greybus: Match parentheses alignment
Message-ID: <YGxhrLZPIPjILWUH@kroah.com>
References: <20210406124259.GA96537@zhans>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406124259.GA96537@zhans>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:42:59PM +0600, Zhansaya Bagdauletkyzy wrote:
> Match next line with open parentheses by adding tabs/spaces
> to conform with Linux kernel coding style.
> Reported by checkpatch.
> 
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> ---
>  drivers/staging/greybus/camera.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/greybus/camera.c b/drivers/staging/greybus/camera.c
> index cdbb42cd413b..5dca585694c0 100644
> --- a/drivers/staging/greybus/camera.c
> +++ b/drivers/staging/greybus/camera.c
> @@ -220,7 +220,7 @@ static int gb_camera_operation_sync_flags(struct gb_connection *connection,
>  }
>  
>  static int gb_camera_get_max_pkt_size(struct gb_camera *gcam,
> -		struct gb_camera_configure_streams_response *resp)
> +				      struct gb_camera_configure_streams_response *resp)
>  {
>  	unsigned int max_pkt_size = 0;
>  	unsigned int i;
> @@ -378,8 +378,8 @@ struct ap_csi_config_request {
>  #define GB_CAMERA_CSI_CLK_FREQ_MARGIN		150000000U
>  
>  static int gb_camera_setup_data_connection(struct gb_camera *gcam,
> -		struct gb_camera_configure_streams_response *resp,
> -		struct gb_camera_csi_params *csi_params)
> +					   struct gb_camera_configure_streams_response *resp,
> +					   struct gb_camera_csi_params *csi_params)

And now you violate another coding style requirement, which means
someone will send another patch to fix that up and around and around it
goes...

Sorry, not going to take this.

greg k-h
