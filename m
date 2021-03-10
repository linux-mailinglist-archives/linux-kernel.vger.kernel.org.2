Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495E2334042
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCJOXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhCJOWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:22:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EDCB64FF3;
        Wed, 10 Mar 2021 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615386166;
        bh=fvRMVeiCybXoXRnQ1HMKD1A6w2E1RrFY453zPMPS9bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QeIzYFzS6U9XfE4gOSrLARyy1DuIahTNuflRn5jm+8YYlys39qkTxl/q3dgH9iNJG
         ndPLxX0aOZHbqQV2u+vMrelNkQHa7h74g3YakwLecNynq9dI2mPOhs9bKAllnN7UQy
         wQrydj2+NPncQiU6JwYe03wl3rIC2S3FRq8MLNvCNcRV75CnKw2dZoqyj12S5RErbh
         3fXrgoVOALucNo7FoNZHE9AxB9KA73w9gxxIiymZySOdXAy+aZ/cne6y2lu1mNBB1H
         yjvWULnVETMvPNN1zOeQ+D8TvmWsUBdd5L/Xg5P8J3Yxu/DzEjWs2k1aQEQLq1kC50
         WuyUONEhhNNiA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lJzjk-0008Fv-Qw; Wed, 10 Mar 2021 15:22:56 +0100
Date:   Wed, 10 Mar 2021 15:22:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] greybus/operation: Drop reference when message has
 been sent
Message-ID: <YEjWQObSkj6QbXZP@hovoldconsulting.com>
References: <20210310141736.3459-1-lyl2019@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310141736.3459-1-lyl2019@mail.ustc.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 06:17:36AM -0800, Lv Yunlong wrote:
> In gb_operation_response_send, get an extra reference
> before gb_message_send() with this comment "/* Reference will
> be dropped when message has been sent. */". Therefore, we
> should drop the got reference not only in the error branch,
> but also in the complete branch.
> 
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
> ---
>  drivers/greybus/operation.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/greybus/operation.c b/drivers/greybus/operation.c
> index 8459e9bc0749..500b3fe53a04 100644
> --- a/drivers/greybus/operation.c
> +++ b/drivers/greybus/operation.c
> @@ -855,6 +855,10 @@ static int gb_operation_response_send(struct gb_operation *operation,
>  	if (ret)
>  		goto err_put_active;
>  
> +	/*Drop reference after message send completes. */
> +	gb_operation_put_active(operation);
> +	gb_operation_put(operation);

No, this is broken.

The reference is dropped in greybus_message_sent().

Johan
