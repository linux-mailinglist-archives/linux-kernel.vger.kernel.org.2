Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6C44FB4B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 20:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbhKNTu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 14:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236725AbhKNTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 14:47:23 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF38C06121D;
        Sun, 14 Nov 2021 11:41:09 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a11so7956414qkh.13;
        Sun, 14 Nov 2021 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B0aLeVClI5MOAHXGhwAkD7MiTSI2ENeGUFmzYV+zPro=;
        b=fG3vbKA4jcSGeGmYEzDIXCyZdrQ6mQnbbgyUdc0AMBunLgAZj9Dv1GveUH/agOS4GC
         zmo1wD/6U2ytukqm3JpjlOuuLtTxD1Fla3l6jkjrtJIF9irLm71xmnEFLQPKuIEjiHLa
         rESTkgYlpHG7n5dEYvFa9tHjOpj1JPuTo8ifighJ3Q2pJetqd9HbSD4MxWPRixByEIdV
         qMQrmUNU4HHmQlWlo94TmOIYB3CrP5yHwQLpCNISTGNwWXE4jKHBiM36BK/l4SgV4M+c
         iCV8XfFwKeLbh2+uNmqjyf82iYmnLvYcWLrq/u/KQK732dhkLA3x+RhHbmJ8dY1fxSOW
         YBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0aLeVClI5MOAHXGhwAkD7MiTSI2ENeGUFmzYV+zPro=;
        b=jX1qHXHR0wQoLeGXcFRdoTWQk/erX+g+JWkCbFGXGgzCmVwfYBttGJqhhrV7LXEZY5
         GPcZIqhyrIarOVJ0kKJQA144/XsVVeEViuVYmMK4gBAqI6Kih752sBTAOFe2zcOzmvrZ
         LjsqsI8YhF+k4lroy+UgGEl01i+SCNx6X1f4RbhicfKjwu03hOWYb2I5kuEzP684RVHS
         E89r5sSvn21N5bbN5S7TbivLLM2qcAsF/QvNCa+t/UsEpHJPCOg3BSE0huEIr1cNTzvm
         2UaTtuEa6Rcik0l+lnQHx2GzDJz0D5tAZjnSb1VLKiErpknLDu2K70gzZjkWJCEZqQui
         6DoA==
X-Gm-Message-State: AOAM533EIxpLnhWL0Y75noXaqV3zztTMWaMK+XvShccmPLivDQWsuAIf
        HjG6TMkDB4Uh0tV2Qb8j/eY=
X-Google-Smtp-Source: ABdhPJy2DFyPkjUspGEAGgKuo+EAVFyDEqhuLbTPI38qGyL83PHA3bi5nRucpKO0jvOnGtIUflHrpA==
X-Received: by 2002:a37:ae83:: with SMTP id x125mr25430688qke.37.1636918868794;
        Sun, 14 Nov 2021 11:41:08 -0800 (PST)
Received: from [192.168.43.249] ([107.87.137.168])
        by smtp.gmail.com with ESMTPSA id k19sm1357136qko.73.2021.11.14.11.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 11:41:08 -0800 (PST)
Subject: Re: [PATCH] of: base: Skip CPU nodes with non-"okay"/"disabled"
 status
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211108084804.13474-1-matthias.schiffer@ew.tq-group.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7b4afaa7-13df-513a-5986-e1a9f5f5d7ed@gmail.com>
Date:   Sun, 14 Nov 2021 14:41:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108084804.13474-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/8/21 3:48 AM, Matthias Schiffer wrote:
> Allow fully disabling CPU nodes using status = "fail". Having no status
> property at all is still interpreted as "okay" as usual.
> 
> This allows a bootloader to change the number of available CPUs (for
> example when a common DTS is used for SoC variants with different numbers
> of cores) without deleting the nodes altogether, which could require
> additional fixups to avoid dangling phandle references.
> 
> References:
> - https://www.lkml.org/lkml/2020/8/26/1237
> - https://www.spinics.net/lists/devicetree-spec/msg01007.html
> - https://github.com/devicetree-org/dt-schema/pull/61
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/of/base.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 61de453b885c..4e9973627c8d 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -650,6 +650,32 @@ bool of_device_is_available(const struct device_node *device)
>  }
>  EXPORT_SYMBOL(of_device_is_available);
>  
> +/**
> + *  __of_device_is_disabled - check if a device has status "disabled"
> + *
> + *  @device: Node to check status for, with locks already held
> + *
> + *  Return: True if the status property is set to "disabled",
> + *  false otherwise
> + *
> + *  Most callers should use __of_device_is_available() instead, this function
> + *  only exists due to the special interpretation of the "disabled" status for
> + *  CPU nodes.
> + */
> +static bool __of_device_is_disabled(const struct device_node *device)
> +{
> +	const char *status;
> +
> +	if (!device)
> +		return false;
> +
> +	status = __of_get_property(device, "status", NULL);
> +	if (status == NULL)
> +		return false;
> +
> +	return !strcmp(status, "disabled");
> +}
> +
>  /**
>   *  of_device_is_big_endian - check if a device has BE registers
>   *
> @@ -817,6 +843,9 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
>  		of_node_put(node);
>  	}
>  	for (; next; next = next->sibling) {

> +		if (!__of_device_is_available(next) &&
> +		    !__of_device_is_disabled(next))

Shouldn't that just be a check to continue if the device is disabled?

If adding a check for available, then all of the callers of for_each_of_cpu_node()
need to be checked.  There is at least one that is suspicious - arch/arm/mach-imx/platsmp.c
has a comment:

 * Initialise the CPU possible map early - this describes the CPUs
 * which may be present or become present in the system.

-Frank

> +			continue;
>  		if (!(of_node_name_eq(next, "cpu") ||
>  		      __of_node_is_type(next, "cpu")))
>  			continue;
> 

