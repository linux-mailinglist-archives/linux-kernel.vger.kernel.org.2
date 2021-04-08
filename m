Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268F33587F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhDHPN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhDHPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:13:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220AC061760;
        Thu,  8 Apr 2021 08:13:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j7so1650624qtx.5;
        Thu, 08 Apr 2021 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUFbYhqpg3uGI/VMdWM4eOH2z/XWcHzqEy7dtXUuuIQ=;
        b=RWAWl5jdF9sKXQz0yhsL1oUodSRQibaQIqlG7QXbkbIIG/VQ6TLSNrPD9Zs/Kjz9+X
         7lQDktSGCY0HXHKySPMQ1NePd58ndCG1uyJG3ByoccHwH9yK8XKo+PFP2APh3eJrhbuY
         N6cpIIebaHeK8dmVaWTJxLhR0/7flJ/LKecKWJFtItF98E5LmzCZlrHrjPegNYMNyH2H
         MCghBwanhhApM07HqdanQZR0RG93QPMp+R0ZbcjC60x95UopKQHLngF8KWCU1Z/F++5Q
         rcMBxdv1uTQsh3PtI+CCrGSsUi0kWGbHvaimMnzPYexCzGzYC7t9jSqInIMth7lTYN3I
         MGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUFbYhqpg3uGI/VMdWM4eOH2z/XWcHzqEy7dtXUuuIQ=;
        b=tMpGjyVXBqZE5fx7+eSOXzG0vv+9jJ8v0KOyP74kVECkLUQN6KcUfIFm+IBwdrdeIr
         OP7u0misauMCjfYpxWVXavTyy/5/ekEd6b1JlNKdnF3+6Ll5m2Y0c3/ngnjiZEKlL4hf
         nTMUODFELUmLsZetwthzQI5suC5CpctNBqp2B5Oo+ZnuAwTHrlDvRm3MA1ixCtuz2yPS
         QYHCqmmFI/j8E1IVZ1FfTAlBgtwTHaTm6KFg6i868hzj4WxSpdc43oOcSb8oUVvtBCmH
         Gbvk+S1W9bEsxNVnzyXKcqRnDAUy7ZijhW1WB0eM3ukrRGOWXDsmk0lbZA8xQAJpwWAU
         tOTA==
X-Gm-Message-State: AOAM532kdtXzamQ0NC5pXNAz/+nGO7shB6bsX6i0+cdFjM9eD+OgpGcI
        jrKf5AN+HmXVsIzFK8ZRVqc=
X-Google-Smtp-Source: ABdhPJzbncFDbswrBK62FKo5Lq4bOgjFAWEb+L6onwkogQCx/6RHoamy4DJLdEWt70u8cWoB5YBzAw==
X-Received: by 2002:a05:622a:134f:: with SMTP id w15mr7759136qtk.162.1617894821481;
        Thu, 08 Apr 2021 08:13:41 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id a28sm13361qtd.7.2021.04.08.08.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 08:13:41 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20210408144349.2215143-1-frowand.list@gmail.com>
Message-ID: <95a29b32-0ab6-7c70-71d3-d27fb514e68d@gmail.com>
Date:   Thu, 8 Apr 2021 10:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210408144349.2215143-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I had a git hiccup, this is not the version I meant to send.  v3 coming shortly.

-Frank

On 4/8/21 9:43 AM, frowand.list@gmail.com wrote:
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
> 
> ---
> 
> Please review carefully, I am not yet fully awake...
> 
> changes since version 1:
>   - use pointer from kmalloc() for kfree() instead of using pointer that
>     has been modified for FDT alignment
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
>  /**
>   * struct alias_prop - Alias property in 'aliases' node
>   * @link:	List node to link the structure in aliases_lookup list
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 50bbe0edf538..e0397d70d531 100644
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
> + * @fdt_align:	the FDT that was unflattened to create @tree, aligned
> + * @fdt:	base of memory allocated to hold *@fdt_align
>   * @tree:	Expanded overlay device tree
>   * @ovcs_id:	Pointer to overlay changeset id
>   *
> @@ -912,8 +913,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>   * id is returned to *ovcs_id.
>   */
>  
> -static int of_overlay_apply(const void *fdt, struct device_node *tree,
> -		int *ovcs_id)
> +static int of_overlay_apply(const void *fdt_align, const void *fdt,
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
> +
> +	of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
>  	if (!overlay_root) {
>  		pr_err("unable to unflatten overlay_fdt\n");
>  		ret = -EINVAL;
>  		goto out_free_new_fdt;
>  	}
>  
> -	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
> +	ret = of_overlay_apply(new_fdt_align, new_fdt, overlay_root, ovcs_id);
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
> +
> +	of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
>  	if (!unittest_data_node) {
>  		pr_warn("%s: No tree to attach; not running tests\n", __func__);
>  		kfree(unittest_data);
> 

