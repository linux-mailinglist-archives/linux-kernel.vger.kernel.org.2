Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E035888B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhDHPcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbhDHPc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:32:29 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823FC061762;
        Thu,  8 Apr 2021 08:32:17 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so2678718otr.4;
        Thu, 08 Apr 2021 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0/obrCGG+MryKWs4NHbEbM0SKq6VvWHkVgj7y1EP3I=;
        b=aoDBiEwcdR5MqUl1iTh23Jotww+JOXh4rrwwKWGtOSghAdCOz5waZPeLLlS/JCs3CU
         THJ2Fjngw8kAHiWpfIAnoxSy6OenUgZ6hfpA0dyJnE+9775KMpl67JJRt3rDnI7iNzv5
         NtelwmQMWPgxcNPEDuYsEe3o/DuhYH8VAu5ONd7J88y4ozzHATPgKhjAQm8NuZOO2UHQ
         h2gl+afmQ+Ye0Xgwb+hWYwLhNHYq2Yj5zJCxERNDhnVYozfCbqkxwk8i87/GyS81jYT+
         OBm+FUYoObK43EMTym9zdwARdj56yjbjRtqytmpp7iDG/UkwAzNntN/A461y6Hmh4t1P
         Eyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B0/obrCGG+MryKWs4NHbEbM0SKq6VvWHkVgj7y1EP3I=;
        b=UZ/TxBdZ+mNPFTtKB9XknuHurndETxPZMjaIzf0ABN9effPxVVQTwv6NkNk3nX7KYu
         JRrOO1tKfQtmIoGnx0aSgac+4096OQQJdt8jVNLkG7/F4wMD55/N1Kv88IBQT4aD1D63
         HWlD6mYZWsmgiZnBSrWHjh/F5cJH5U+8SqTm1MyxPIfI+c6px2vz1sm1xmEC9bnzplW8
         9qxxNuKmWd4FI/RgyX9FQxaN04AXiUiS4MtcPDMWZyQa4hFNsuZ+BVFN3pgRaZmLCFtP
         qclJ4ADS3jAy1DOnit1vXkjfKgiX5qM2LyippcfzcDsTUXHkqHKm0Sq2X+FhnMd/DKxG
         OfyQ==
X-Gm-Message-State: AOAM53253il1MdayTczX60dETjtg4SnnqogdD5W76+3UYmaQhrl2/jSq
        ikN/xL9qVsNUQQ6UP1K88Bdpj53iw78=
X-Google-Smtp-Source: ABdhPJyPhFtFbXEF37bUBgAddTDvUbqnoOPOheRBnX4Os8RVBrG54WfnAKlbAllsEaqQNPvTVzsFYQ==
X-Received: by 2002:a9d:6389:: with SMTP id w9mr8012922otk.242.1617895936658;
        Thu, 08 Apr 2021 08:32:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c26sm6276752otm.51.2021.04.08.08.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:32:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v3 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     frowand.list@gmail.com, Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20210408151736.2216238-1-frowand.list@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c49c026d-d168-68b5-35ec-80ce66857bca@roeck-us.net>
Date:   Thu, 8 Apr 2021 08:32:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210408151736.2216238-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/21 8:17 AM, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The Devicetree standard specifies an 8 byte alignment of the FDT.
> Code in libfdt expects this alignment for an FDT image in memory.
> kmemdup() returns 4 byte alignment on openrisc.  Replace kmemdup()
> with kmalloc(), align pointer, memcpy() to get proper alignment.
> 
> The 4 byte alignment exposed a related bug which triggered a crash
> on openrisc with:
> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> as reported in:
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> ---
> 
> changes since version 1:
>   - use pointer from kmalloc() for kfree() instead of using pointer that
>     has been modified for FDT alignment
> 
> changes since version 2:
>   - version 1 was a work in progress version, I failed to commit the following
>     final changes
>   - reorder first two arguments of of_overlay_apply()
> 
>  drivers/of/of_private.h |  2 ++
>  drivers/of/overlay.c    | 28 +++++++++++++++++-----------
>  drivers/of/unittest.c   | 12 +++++++++---
>  3 files changed, 28 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index d9e6a324de0a..d717efbd637d 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -8,6 +8,8 @@
>   * Copyright (C) 1996-2005 Paul Mackerras.
>   */
>  
> +#define FDT_ALIGN_SIZE 8
> +

Use existing define ? Or was that local in libfdt ?

>  /**
>   * struct alias_prop - Alias property in 'aliases' node
>   * @link:	List node to link the structure in aliases_lookup list
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 50bbe0edf538..cf770452e1e5 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -57,7 +57,7 @@ struct fragment {
>   * struct overlay_changeset
>   * @id:			changeset identifier
>   * @ovcs_list:		list on which we are located
> - * @fdt:		FDT that was unflattened to create @overlay_tree
> + * @fdt:		base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
>   * @overlay_tree:	expanded device tree that contains the fragment nodes
>   * @count:		count of fragment structures
>   * @fragments:		fragment nodes in the overlay expanded device tree
> @@ -719,8 +719,8 @@ static struct device_node *find_target(struct device_node *info_node)
>  /**
>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>   * @ovcs:	Overlay changeset to build
> - * @fdt:	the FDT that was unflattened to create @tree
> - * @tree:	Contains all the overlay fragments and overlay fixup nodes
> + * @fdt:	base of memory allocated to hold aligned FDT that was unflattened to create @tree
> + * @tree:	Contains the overlay fragments and overlay fixup nodes
>   *
>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>   * the top level of @tree.  The relevant top level nodes are the fragment
> @@ -873,7 +873,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * internal documentation
>   *
>   * of_overlay_apply() - Create and apply an overlay changeset
> - * @fdt:	the FDT that was unflattened to create @tree
> + * @fdt:	base of memory allocated to hold *@fdt_align
> + * @fdt_align:	the FDT that was unflattened to create @tree, aligned
>   * @tree:	Expanded overlay device tree
>   * @ovcs_id:	Pointer to overlay changeset id
>   *
> @@ -912,8 +913,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * id is returned to *ovcs_id.
>   */
>  
> -static int of_overlay_apply(const void *fdt, struct device_node *tree,
> -		int *ovcs_id)
> +static int of_overlay_apply(const void *fdt, const void *fdt_align,

fdt_align is not used in this function.

> +		struct device_node *tree, int *ovcs_id)
>  {
>  	struct overlay_changeset *ovcs;
>  	int ret = 0, ret_revert, ret_tmp;
> @@ -953,7 +954,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  	/*
>  	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
>  	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
> -	 * and can not free fdt, aka ovcs->fdt
> +	 * and can not free memory containing aligned fdt, aka ovcs->fdt

ovcs->fdt does not point to the aligned fdt, but to the allocated fdt.

>  	 */
>  	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>  	if (ret) {
> @@ -1014,7 +1015,8 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>  int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  			 int *ovcs_id)
>  {
> -	const void *new_fdt;
> +	void *new_fdt;
> +	void *new_fdt_align;
>  	int ret;
>  	u32 size;
>  	struct device_node *overlay_root;
> @@ -1036,18 +1038,22 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
>  	 * will create pointers to the passed in FDT in the unflattened tree.
>  	 */
> -	new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
> +	size += FDT_ALIGN_SIZE;
> +	new_fdt = kmalloc(size, GFP_KERNEL);
>  	if (!new_fdt)
>  		return -ENOMEM;
>  
> -	of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
> +	new_fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
> +	memcpy(new_fdt_align, overlay_fdt, size);

Still copies beyond end of buffer.

> +
> +	of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
>  	if (!overlay_root) {
>  		pr_err("unable to unflatten overlay_fdt\n");
>  		ret = -EINVAL;
>  		goto out_free_new_fdt;
>  	}
>  
> -	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
> +	ret = of_overlay_apply(new_fdt, new_fdt_align, overlay_root, ovcs_id);
>  	if (ret < 0) {
>  		/*
>  		 * new_fdt and overlay_root now belong to the overlay
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index eb100627c186..29081a8b32e6 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
> +#include <linux/kernel.h>
>  
>  #include <linux/i2c.h>
>  #include <linux/i2c-mux.h>
> @@ -1408,6 +1409,7 @@ static void attach_node_and_children(struct device_node *np)
>  static int __init unittest_data_add(void)
>  {
>  	void *unittest_data;
> +	void *unittest_data_align;
>  	struct device_node *unittest_data_node, *np;
>  	/*
>  	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
> @@ -1415,7 +1417,7 @@ static int __init unittest_data_add(void)
>  	 */
>  	extern uint8_t __dtb_testcases_begin[];
>  	extern uint8_t __dtb_testcases_end[];
> -	const int size = __dtb_testcases_end - __dtb_testcases_begin;
> +	u32 size = __dtb_testcases_end - __dtb_testcases_begin;
>  	int rc;
>  
>  	if (!size) {
> @@ -1425,11 +1427,15 @@ static int __init unittest_data_add(void)
>  	}
>  
>  	/* creating copy */
> -	unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
> +	size += FDT_ALIGN_SIZE;
> +	unittest_data = kmalloc(size, GFP_KERNEL);
>  	if (!unittest_data)
>  		return -ENOMEM;
>  
> -	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
> +	unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
> +	memcpy(unittest_data_align, __dtb_testcases_begin, size);

Same as above.

> +
> +	of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
>  	if (!unittest_data_node) {
>  		pr_warn("%s: No tree to attach; not running tests\n", __func__);
>  		kfree(unittest_data);
> 

