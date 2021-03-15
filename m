Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6667533AED1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhCOJ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhCOJ3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:29:16 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F2AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 02:29:14 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f16so15336724ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B8Aa8lz5vqDixgsqdBPA8Vaji+a7pHZ5fvg+I7+Hzec=;
        b=YAJMVMZvlDvkaMIAD7nrUVaewUy2ctlWscYWLL0bpQlEqgK5WsCQUuPLXLaxESSzRy
         qWqQsMAJ34ErAx0ibQfTBdkU692dphPO4qMYKVokB7yBw/10KwoZhEv8luBvEIp1x8kE
         VbUlRqVZHxYqNxKJhVeMcmsCLcPJiO+vjLcFAhWFk7IUq55XbphahpKghC5h7FTHFo9f
         fgd8VdOzXB58CApA2OY2y7/VPajWXAr0ywlqB9XlZzyXG8WWAHfWXOO7HilhGkv6uXV4
         C3e3tgdGWNWoejpB6ml3S3+M8qMScENXVAhfJjzCwSTdw/8S/6DJlmZi7Spq/rgTrx2c
         DdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B8Aa8lz5vqDixgsqdBPA8Vaji+a7pHZ5fvg+I7+Hzec=;
        b=UZ+qy6bU8rj4VRxKpqN1pUfVSmOv536BzdMDtu/igZhlgd7HhGv+48mxwioPZESxTy
         KUJrawC3YZeEDHoYZ/vBOJOgg6qCm7/7UeuY6nvZ1ugIi17EVVgiI8g6QW2RKUG0Oa9C
         P6AQxfo6ufs/kIZYj9XEpU3lhQoyjAJmI6Z8nWCJfEqMU+v4EJHYzJJao5T3m1+wjdof
         JbNazt/NNERvSTaNNWX9+A2sMJNgPo9PKL9N4X/w+xvyDDWfizdfZxESJsrHucB18ORM
         2qK3u6ij1Xm3GXciv/pKnPJVX0WsCB686j3dIuUjvIh2p+6uWbbnx6sYkQzQOywbJ/RV
         JVPA==
X-Gm-Message-State: AOAM5310r6/MjYTmiavXbSSlLRR8GGT8HNxrHO4AQS+9pHblcxsidpws
        O/psiuRu7J+0g4w6/38WKqC4woLDt2XGTNGU
X-Google-Smtp-Source: ABdhPJxlMKmnJSBLyzc/X4B6st8P8BsLgnU4Xt5hA4hWOHTjMCISELdZmvVFQSqZ8IizplLu08Vqxw==
X-Received: by 2002:a05:651c:30c:: with SMTP id a12mr10036262ljp.194.1615800552610;
        Mon, 15 Mar 2021 02:29:12 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id d14sm2559989lfg.128.2021.03.15.02.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 02:29:12 -0700 (PDT)
Date:   Mon, 15 Mar 2021 10:29:10 +0100
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tee: amdtee: unload TA only when its refcount becomes 0
Message-ID: <20210315092910.GA1707987@jade>
References: <4fafc43b8b6bb779fea87ecc5579afaab8a5f3ad.1615097779.git.Rijo-john.Thomas@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fafc43b8b6bb779fea87ecc5579afaab8a5f3ad.1615097779.git.Rijo-john.Thomas@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2021 at 12:05:01PM +0530, Rijo Thomas wrote:
> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
> 
> If it is a single instance TA, the TA should not get unloaded from AMD
> Secure Processor, while it is still in use in another TEE context.
> 
> Therefore reference count TA and unload it when the count becomes zero.
> 
> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
> ---
>  drivers/tee/amdtee/amdtee_private.h | 13 +++++
>  drivers/tee/amdtee/call.c           | 73 +++++++++++++++++++++++++++--
>  drivers/tee/amdtee/core.c           | 15 +++---
>  3 files changed, 92 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/tee/amdtee/amdtee_private.h b/drivers/tee/amdtee/amdtee_private.h
> index 337c8d82f74e..6d0f7062bb87 100644
> --- a/drivers/tee/amdtee/amdtee_private.h
> +++ b/drivers/tee/amdtee/amdtee_private.h
> @@ -21,6 +21,7 @@
>  #define TEEC_SUCCESS			0x00000000
>  #define TEEC_ERROR_GENERIC		0xFFFF0000
>  #define TEEC_ERROR_BAD_PARAMETERS	0xFFFF0006
> +#define TEEC_ERROR_OUT_OF_MEMORY	0xFFFF000C
>  #define TEEC_ERROR_COMMUNICATION	0xFFFF000E
>  
>  #define TEEC_ORIGIN_COMMS		0x00000002
> @@ -93,6 +94,18 @@ struct amdtee_shm_data {
>  	u32     buf_id;
>  };
>  
> +/**
> + * struct amdtee_ta_data - Keeps track of all TAs loaded in AMD Secure
> + *			   Processor
> + * @ta_handle:	Handle to TA loaded in TEE
> + * @refcount:	Reference count for the loaded TA
> + */
> +struct amdtee_ta_data {
> +	struct list_head list_node;
> +	u32 ta_handle;
> +	u32 refcount;
> +};
> +
>  #define LOWER_TWO_BYTE_MASK	0x0000FFFF
>  
>  /**
> diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
> index 096dd4d92d39..e10601417ea3 100644
> --- a/drivers/tee/amdtee/call.c
> +++ b/drivers/tee/amdtee/call.c
> @@ -121,15 +121,69 @@ static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
>  	return ret;
>  }
>  
> +static DEFINE_MUTEX(ta_refcount_mutex);
> +static struct list_head ta_list = LIST_HEAD_INIT(ta_list);
> +
> +static u32 get_ta_refcount(u32 ta_handle)
> +{
> +	struct amdtee_ta_data *ta_data;
> +	u32 count = 0;
> +
> +	/* Caller must hold a mutex */
> +	list_for_each_entry(ta_data, &ta_list, list_node)
> +		if (ta_data->ta_handle == ta_handle)
> +			return ++ta_data->refcount;
> +
> +	ta_data = kzalloc(sizeof(*ta_data), GFP_KERNEL);
> +	if (ta_data) {
> +		ta_data->ta_handle = ta_handle;
> +		ta_data->refcount = 1;
> +		count = ta_data->refcount;
> +		list_add(&ta_data->list_node, &ta_list);
> +	}
> +
> +	return count;
> +}
> +
> +static u32 put_ta_refcount(u32 ta_handle)
> +{
> +	struct amdtee_ta_data *ta_data;
> +	u32 count = 0;
> +
> +	/* Caller must hold a mutex */
> +	list_for_each_entry(ta_data, &ta_list, list_node)
> +		if (ta_data->ta_handle == ta_handle) {
> +			count = --ta_data->refcount;
> +			if (count == 0) {
> +				list_del(&ta_data->list_node);
> +				kfree(ta_data);
> +				break;
> +			}
> +		}
> +
> +	return count;
> +}
> +
>  int handle_unload_ta(u32 ta_handle)
>  {
>  	struct tee_cmd_unload_ta cmd = {0};
> -	u32 status;
> +	u32 status, count;
>  	int ret;
>  
>  	if (!ta_handle)
>  		return -EINVAL;
>  
> +	mutex_lock(&ta_refcount_mutex);
> +
> +	count = put_ta_refcount(ta_handle);
> +
> +	if (count) {
> +		pr_debug("unload ta: not unloading %u count %u\n",
> +			 ta_handle, count);
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
>  	cmd.ta_handle = ta_handle;
>  
>  	ret = psp_tee_process_cmd(TEE_CMD_ID_UNLOAD_TA, (void *)&cmd,
> @@ -137,8 +191,12 @@ int handle_unload_ta(u32 ta_handle)
>  	if (!ret && status != 0) {
>  		pr_err("unload ta: status = 0x%x\n", status);
>  		ret = -EBUSY;
> +	} else {
> +		pr_debug("unloaded ta handle %u\n", ta_handle);
>  	}
>  
> +unlock:
> +	mutex_unlock(&ta_refcount_mutex);
>  	return ret;
>  }
>  
> @@ -357,14 +415,23 @@ int handle_load_ta(void *data, u32 size, struct tee_ioctl_open_session_arg *arg)
>  	cmd.low_addr = lower_32_bits(blob);
>  	cmd.size = size;
>  
> +	mutex_lock(&ta_refcount_mutex);
> +
>  	ret = psp_tee_process_cmd(TEE_CMD_ID_LOAD_TA, (void *)&cmd,
>  				  sizeof(cmd), &arg->ret);
>  	if (ret) {
>  		arg->ret_origin = TEEC_ORIGIN_COMMS;
>  		arg->ret = TEEC_ERROR_COMMUNICATION;
> -	} else {
> -		set_session_id(cmd.ta_handle, 0, &arg->session);
> +	} else if (arg->ret == TEEC_SUCCESS) {
> +		ret = get_ta_refcount(cmd.ta_handle);
> +		if (!ret) {

If this occurs, how is the TA unloaded from secure world?

Thanks, 
Jens

> +			arg->ret_origin = TEEC_ORIGIN_COMMS;
> +			arg->ret = TEEC_ERROR_OUT_OF_MEMORY;
> +		} else {
> +			set_session_id(cmd.ta_handle, 0, &arg->session);
> +		}
>  	}
> +	mutex_unlock(&ta_refcount_mutex);
>  
>  	pr_debug("load TA: TA handle = 0x%x, RO = 0x%x, ret = 0x%x\n",
>  		 cmd.ta_handle, arg->ret_origin, arg->ret);
> diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
> index 8a6a8f30bb42..da6b88e80dc0 100644
> --- a/drivers/tee/amdtee/core.c
> +++ b/drivers/tee/amdtee/core.c
> @@ -59,10 +59,9 @@ static void release_session(struct amdtee_session *sess)
>  			continue;
>  
>  		handle_close_session(sess->ta_handle, sess->session_info[i]);
> +		handle_unload_ta(sess->ta_handle);
>  	}
>  
> -	/* Unload Trusted Application once all sessions are closed */
> -	handle_unload_ta(sess->ta_handle);
>  	kfree(sess);
>  }
>  
> @@ -224,8 +223,6 @@ static void destroy_session(struct kref *ref)
>  	struct amdtee_session *sess = container_of(ref, struct amdtee_session,
>  						   refcount);
>  
> -	/* Unload the TA from TEE */
> -	handle_unload_ta(sess->ta_handle);
>  	mutex_lock(&session_list_mutex);
>  	list_del(&sess->list_node);
>  	mutex_unlock(&session_list_mutex);
> @@ -238,7 +235,7 @@ int amdtee_open_session(struct tee_context *ctx,
>  {
>  	struct amdtee_context_data *ctxdata = ctx->data;
>  	struct amdtee_session *sess = NULL;
> -	u32 session_info;
> +	u32 session_info, ta_handle;
>  	size_t ta_size;
>  	int rc, i;
>  	void *ta;
> @@ -259,11 +256,14 @@ int amdtee_open_session(struct tee_context *ctx,
>  	if (arg->ret != TEEC_SUCCESS)
>  		goto out;
>  
> +	ta_handle = get_ta_handle(arg->session);
> +
>  	mutex_lock(&session_list_mutex);
>  	sess = alloc_session(ctxdata, arg->session);
>  	mutex_unlock(&session_list_mutex);
>  
>  	if (!sess) {
> +		handle_unload_ta(ta_handle);
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> @@ -277,6 +277,7 @@ int amdtee_open_session(struct tee_context *ctx,
>  
>  	if (i >= TEE_NUM_SESSIONS) {
>  		pr_err("reached maximum session count %d\n", TEE_NUM_SESSIONS);
> +		handle_unload_ta(ta_handle);
>  		kref_put(&sess->refcount, destroy_session);
>  		rc = -ENOMEM;
>  		goto out;
> @@ -289,12 +290,13 @@ int amdtee_open_session(struct tee_context *ctx,
>  		spin_lock(&sess->lock);
>  		clear_bit(i, sess->sess_mask);
>  		spin_unlock(&sess->lock);
> +		handle_unload_ta(ta_handle);
>  		kref_put(&sess->refcount, destroy_session);
>  		goto out;
>  	}
>  
>  	sess->session_info[i] = session_info;
> -	set_session_id(sess->ta_handle, i, &arg->session);
> +	set_session_id(ta_handle, i, &arg->session);
>  out:
>  	free_pages((u64)ta, get_order(ta_size));
>  	return rc;
> @@ -329,6 +331,7 @@ int amdtee_close_session(struct tee_context *ctx, u32 session)
>  
>  	/* Close the session */
>  	handle_close_session(ta_handle, session_info);
> +	handle_unload_ta(ta_handle);
>  
>  	kref_put(&sess->refcount, destroy_session);
>  
> -- 
> 2.17.1
> 
