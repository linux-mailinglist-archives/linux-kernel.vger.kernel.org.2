Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A71336561E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 12:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhDTK1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 06:27:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:36992 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231422AbhDTK0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 06:26:53 -0400
IronPort-SDR: i4vrUQI6w3W+cT3+g5UScXTDiRdp22aB+II57UEFWdtpxBJYZLElsblCqj9CZ8m/oqUTGyVuUL
 ibeZEvmKR2zA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182974761"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="182974761"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 03:26:21 -0700
IronPort-SDR: lMtk/TmtSSIcQ3IY937vjdmvWwJJ0t7d10Dqnpub8PYmM04tgk4Z8sHnpp5F8vMQ7e6F8oIe69
 yur9HOW3SdKQ==
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="400952551"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 03:26:20 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lYnaD-005iK6-UX; Tue, 20 Apr 2021 13:26:17 +0300
Date:   Tue, 20 Apr 2021 13:26:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Vesa =?iso-8859-1?B?SuTkc2tlbORpbmVu?= 
        <vesa.jaaskelainen@vaisala.com>
Subject: Re: [PATCH] optee: use export_uuid() to copy client UUID
Message-ID: <YH6sSUyFZd8uva6Q@smile.fi.intel.com>
References: <20210420082547.3542261-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420082547.3542261-1-jens.wiklander@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 10:25:47AM +0200, Jens Wiklander wrote:
> Prior to this patch optee_open_session() was making assumptions about
> the internal format of uuid_t by casting a memory location in a
> parameter struct to uuid_t *. Fix this using export_uuid() to get a well
> defined binary representation and also add an octets field in struct
> optee_msg_param in order to avoid casting.

Wonderful! Thanks for fixing this!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A bit of off-topic, have you know by any chance who may consider applying this
one?
https://lore.kernel.org/linux-mips/20210121183741.45333-1-andriy.shevchenko@linux.intel.com/

> Fixes: c5b4312bea5d ("tee: optee: Add support for session login client UUID generation")
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c      | 6 ++++--
>  drivers/tee/optee/optee_msg.h | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 7a77e375b503..6b52f0c526ba 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -216,6 +216,7 @@ int optee_open_session(struct tee_context *ctx,
>  	struct optee_msg_arg *msg_arg;
>  	phys_addr_t msg_parg;
>  	struct optee_session *sess = NULL;
> +	uuid_t client_uuid;
>  
>  	/* +2 for the meta parameters added below */
>  	shm = get_msg_arg(ctx, arg->num_params + 2, &msg_arg, &msg_parg);
> @@ -236,10 +237,11 @@ int optee_open_session(struct tee_context *ctx,
>  	memcpy(&msg_arg->params[0].u.value, arg->uuid, sizeof(arg->uuid));
>  	msg_arg->params[1].u.value.c = arg->clnt_login;
>  
> -	rc = tee_session_calc_client_uuid((uuid_t *)&msg_arg->params[1].u.value,
> -					  arg->clnt_login, arg->clnt_uuid);
> +	rc = tee_session_calc_client_uuid(&client_uuid, arg->clnt_login,
> +					  arg->clnt_uuid);
>  	if (rc)
>  		goto out;
> +	export_uuid(msg_arg->params[1].u.octets, &client_uuid);
>  
>  	rc = optee_to_msg_param(msg_arg->params + 2, arg->num_params, param);
>  	if (rc)
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 81ff593ac4ec..e3d72d09c484 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -9,7 +9,7 @@
>  #include <linux/types.h>
>  
>  /*
> - * This file defines the OP-TEE message protocol used to communicate
> + * This file defines the OP-TEE message protocol (ABI) used to communicate
>   * with an instance of OP-TEE running in secure world.
>   *
>   * This file is divided into two sections.
> @@ -144,9 +144,10 @@ struct optee_msg_param_value {
>   * @tmem:	parameter by temporary memory reference
>   * @rmem:	parameter by registered memory reference
>   * @value:	parameter by opaque value
> + * @octets:	parameter by octet string
>   *
>   * @attr & OPTEE_MSG_ATTR_TYPE_MASK indicates if tmem, rmem or value is used in
> - * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value,
> + * the union. OPTEE_MSG_ATTR_TYPE_VALUE_* indicates value or octets,
>   * OPTEE_MSG_ATTR_TYPE_TMEM_* indicates @tmem and
>   * OPTEE_MSG_ATTR_TYPE_RMEM_* indicates @rmem,
>   * OPTEE_MSG_ATTR_TYPE_NONE indicates that none of the members are used.
> @@ -157,6 +158,7 @@ struct optee_msg_param {
>  		struct optee_msg_param_tmem tmem;
>  		struct optee_msg_param_rmem rmem;
>  		struct optee_msg_param_value value;
> +		u8 octets[24];
>  	} u;
>  };
>  
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


