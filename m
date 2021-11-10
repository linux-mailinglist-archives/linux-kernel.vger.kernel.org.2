Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC12D44CCE4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbhKJWel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:32786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234180AbhKJWeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:34:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C61636117A;
        Wed, 10 Nov 2021 22:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636583508;
        bh=UwCljJlJEQxD0zk3IYhR6savwKvL1dc1xs7HcybGM4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dR5lb2Qd90aQipnOKCJQi/LqDKVsbIHSttHXJ2NbPj4tk8FQsUcJfkqg8EMe9yPJi
         8P0bDZWUpJvXBw3eDEh6DkTKSoHTqC15Of3jQlVgBnA+/59IIfEcrfniicRkoj8d33
         pikFEZUqXgCeM/CRXkE2u5OxLEg6fldKx5QSlNut/tx4S9WsUYDH4E8+M9C/RN7PsU
         5/lKWjxcWpVgIhVmMhYa0cWkkzu1rMFWEl/Gk1ZOtSFdaZeLjvwWroT8FSiE2HeRgD
         biA0W6mI1MrfFpeIWiX4fYlhbMh8AWiUbLHI3vyLZrAjNyore1CYPArJa/HAVqeQ4P
         kQQVcg2KvT9XQ==
Date:   Wed, 10 Nov 2021 14:31:47 -0800
From:   Mark Gross <markgross@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] platform/mellanox: mlxreg-lc: fix error code in
 mlxreg_lc_create_static_devices()
Message-ID: <20211110223147.GA16388@T470>
References: <20211110074346.GB5176@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110074346.GB5176@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 10:43:46AM +0300, Dan Carpenter wrote:
> This code should be using PTR_ERR() instead of IS_ERR().  And because
> it's using the wrong "dev->client" pointer, the IS_ERR() check will be
> false, meaning the function returns success.
> 
> Fixes: 62f9529b8d5c ("platform/mellanox: mlxreg-lc: Add initial support for Nvidia line card devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/platform/mellanox/mlxreg-lc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/mellanox/mlxreg-lc.c b/drivers/platform/mellanox/mlxreg-lc.c
> index 0b7f58feb701..c897a2f15840 100644
> --- a/drivers/platform/mellanox/mlxreg-lc.c
> +++ b/drivers/platform/mellanox/mlxreg-lc.c
> @@ -413,7 +413,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
>  				int size)
>  {
>  	struct mlxreg_hotplug_device *dev = devs;
> -	int i;
> +	int i, ret;
>  
>  	/* Create static I2C device feeding by auxiliary or main power. */
>  	for (i = 0; i < size; i++, dev++) {
> @@ -423,6 +423,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
>  				dev->brdinfo->type, dev->nr, dev->brdinfo->addr);
>  
>  			dev->adapter = NULL;
> +			ret = PTR_ERR(dev->client);
ret is only set on this error path.
can we get to the return without setting ret?

--mark

>  			goto fail_create_static_devices;
>  		}
>  	}
> @@ -435,7 +436,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
>  		i2c_unregister_device(dev->client);
>  		dev->client = NULL;
>  	}
> -	return IS_ERR(dev->client);
> +	return ret;
>  }
>  
>  static void
> -- 
> 2.20.1
> 
