Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637DE358E09
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhDHUGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhDHUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:06:41 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9D2C061760;
        Thu,  8 Apr 2021 13:06:30 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y5so3570103qkl.9;
        Thu, 08 Apr 2021 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PPrSjEL34SZWCFDCoJONZ5T4WyumOzvu37Bt7qM0+cw=;
        b=NNr9twGUGlcAJhPvn085ynK117k83tj/dRyPeE6CHlXqX/Cr02Rg5laT6ATxUU6fut
         vnEIM8EfMgy7PaZaBo1FqcuL14ZdmVvZjc5liZP4ihgwJKOfSiw+zEgIkKviyqwhxrGQ
         hH6B6Z/qIGlmpExf5LlKzpLf8lJzKfLTcl390FCgN7Riy+zF6LFZF8gMnJCTOlTV6BiC
         hgEp8POAGfEVzK0nwIl6GtaXsPvPdmLfVzgTRmhh2k09cNtPJM6E5iS2u2njHmbyxzad
         So+Ce47a1UnNsRYy2x9b6Rm2dVxJRUAL8fuAOxTZb+QheSfvCOUNa9bjr6rtBcxi/Nb7
         A2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PPrSjEL34SZWCFDCoJONZ5T4WyumOzvu37Bt7qM0+cw=;
        b=BPJHHK3t5PZyTRnv777D12HWbn6cbAX4tNq+7+UYL9LwiEtr9mA1dq+Y2yB4o85Wo8
         8go1Eu2yXcWB1xE+dv40uSyBxRveJh9ZtlmJX5knJzYPEUwWrCx772FcsvFUQVGfgzZS
         f0BOEbFWLScibq8sL3Jm098KEo7i8+iQs1iYsNTAaLb+GtebN0dA8A/AJS7d30HUOi4W
         pn9dp9XBim/tdU+ajshD1ArLW1VUR3TZ6ujW0ZDOL5DZYHQwStdDCGXB2HZ+LThi1T81
         yVDHitjklILq0Vp0m6qvO5ShfExuiNcJxJxIo+SuPAlIUx7WWqXsHVCfZaruFhKga5uw
         AugA==
X-Gm-Message-State: AOAM533f0iCaPG3IhGBnvVgeKZAFNdE4JVwRE+RRx452ZiKoOJozeC2a
        RBeTufKSGG7ZdsD1MUOqkws=
X-Google-Smtp-Source: ABdhPJx1TptVBABbwjiAE1MJoK7+QfUM9mPrpjfwjJFnGI1HaFitGowgdgrupyWRIRObG4jSt4Juzw==
X-Received: by 2002:a05:620a:144d:: with SMTP id i13mr10704392qkl.263.1617912389347;
        Thu, 08 Apr 2021 13:06:29 -0700 (PDT)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id 84sm300082qkg.8.2021.04.08.13.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 13:06:28 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] of: unittest: overlay: ensure proper alignment of
 copied FDT
To:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
References: <20210408151736.2216238-1-frowand.list@gmail.com>
 <c49c026d-d168-68b5-35ec-80ce66857bca@roeck-us.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <baee7388-5183-cf98-2cf4-52cf338a0cbb@gmail.com>
Date:   Thu, 8 Apr 2021 15:06:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c49c026d-d168-68b5-35ec-80ce66857bca@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for the review!

On 4/8/21 10:32 AM, Guenter Roeck wrote:
> On 4/8/21 8:17 AM, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The Devicetree standard specifies an 8 byte alignment of the FDT.
>> Code in libfdt expects this alignment for an FDT image in memory.
>> kmemdup() returns 4 byte alignment on openrisc.  Replace kmemdup()
>> with kmalloc(), align pointer, memcpy() to get proper alignment.
>>
>> The 4 byte alignment exposed a related bug which triggered a crash
>> on openrisc with:
>> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
>> as reported in:
>> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>> ---
>>
>> changes since version 1:
>>   - use pointer from kmalloc() for kfree() instead of using pointer that
>>     has been modified for FDT alignment
>>
>> changes since version 2:
>>   - version 1 was a work in progress version, I failed to commit the following
>>     final changes
>>   - reorder first two arguments of of_overlay_apply()
>>
>>  drivers/of/of_private.h |  2 ++
>>  drivers/of/overlay.c    | 28 +++++++++++++++++-----------
>>  drivers/of/unittest.c   | 12 +++++++++---
>>  3 files changed, 28 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index d9e6a324de0a..d717efbd637d 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -8,6 +8,8 @@
>>   * Copyright (C) 1996-2005 Paul Mackerras.
>>   */
>>  
>> +#define FDT_ALIGN_SIZE 8
>> +
> 
> Use existing define ? Or was that local in libfdt ?

I don't see a define in libfdt.  If anyone finds one,
I'll switch to it.


> 
>>  /**
>>   * struct alias_prop - Alias property in 'aliases' node
>>   * @link:	List node to link the structure in aliases_lookup list
>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>> index 50bbe0edf538..cf770452e1e5 100644
>> --- a/drivers/of/overlay.c
>> +++ b/drivers/of/overlay.c
>> @@ -57,7 +57,7 @@ struct fragment {
>>   * struct overlay_changeset
>>   * @id:			changeset identifier
>>   * @ovcs_list:		list on which we are located
>> - * @fdt:		FDT that was unflattened to create @overlay_tree
>> + * @fdt:		base of memory allocated to hold aligned FDT that was unflattened to create @overlay_tree
>>   * @overlay_tree:	expanded device tree that contains the fragment nodes
>>   * @count:		count of fragment structures
>>   * @fragments:		fragment nodes in the overlay expanded device tree
>> @@ -719,8 +719,8 @@ static struct device_node *find_target(struct device_node *info_node)
>>  /**
>>   * init_overlay_changeset() - initialize overlay changeset from overlay tree
>>   * @ovcs:	Overlay changeset to build
>> - * @fdt:	the FDT that was unflattened to create @tree
>> - * @tree:	Contains all the overlay fragments and overlay fixup nodes
>> + * @fdt:	base of memory allocated to hold aligned FDT that was unflattened to create @tree
>> + * @tree:	Contains the overlay fragments and overlay fixup nodes
>>   *
>>   * Initialize @ovcs.  Populate @ovcs->fragments with node information from
>>   * the top level of @tree.  The relevant top level nodes are the fragment
>> @@ -873,7 +873,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   * internal documentation
>>   *
>>   * of_overlay_apply() - Create and apply an overlay changeset
>> - * @fdt:	the FDT that was unflattened to create @tree
>> + * @fdt:	base of memory allocated to hold *@fdt_align
>> + * @fdt_align:	the FDT that was unflattened to create @tree, aligned
>>   * @tree:	Expanded overlay device tree
>>   * @ovcs_id:	Pointer to overlay changeset id
>>   *
>> @@ -912,8 +913,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>>   * id is returned to *ovcs_id.
>>   */
>>  
>> -static int of_overlay_apply(const void *fdt, struct device_node *tree,
>> -		int *ovcs_id)
>> +static int of_overlay_apply(const void *fdt, const void *fdt_align,
> 
> fdt_align is not used in this function.

Thanks for catching that.  Left over from earlier version where I
saved both aligned and unaligned addresses in init_overlay_changeset().

Will remove.


> 
>> +		struct device_node *tree, int *ovcs_id)
>>  {
>>  	struct overlay_changeset *ovcs;
>>  	int ret = 0, ret_revert, ret_tmp;
>> @@ -953,7 +954,7 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>  	/*
>>  	 * after overlay_notify(), ovcs->overlay_tree related pointers may have
>>  	 * leaked to drivers, so can not kfree() tree, aka ovcs->overlay_tree;
>> -	 * and can not free fdt, aka ovcs->fdt
>> +	 * and can not free memory containing aligned fdt, aka ovcs->fdt
> 
> ovcs->fdt does not point to the aligned fdt, but to the allocated fdt.

Yes.  The comment is not clear enough about that, I will modify.


> 
>>  	 */
>>  	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
>>  	if (ret) {
>> @@ -1014,7 +1015,8 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
>>  int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>  			 int *ovcs_id)
>>  {
>> -	const void *new_fdt;
>> +	void *new_fdt;
>> +	void *new_fdt_align;
>>  	int ret;
>>  	u32 size;
>>  	struct device_node *overlay_root;
>> @@ -1036,18 +1038,22 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>>  	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
>>  	 * will create pointers to the passed in FDT in the unflattened tree.
>>  	 */
>> -	new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
>> +	size += FDT_ALIGN_SIZE;
>> +	new_fdt = kmalloc(size, GFP_KERNEL);
>>  	if (!new_fdt)
>>  		return -ENOMEM;
>>  
>> -	of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
>> +	new_fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
>> +	memcpy(new_fdt_align, overlay_fdt, size);
> 
> Still copies beyond end of buffer.

Will fix with separate variables "size" and "size_alloc".

> 
>> +
>> +	of_fdt_unflatten_tree(new_fdt_align, NULL, &overlay_root);
>>  	if (!overlay_root) {
>>  		pr_err("unable to unflatten overlay_fdt\n");
>>  		ret = -EINVAL;
>>  		goto out_free_new_fdt;
>>  	}
>>  
>> -	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
>> +	ret = of_overlay_apply(new_fdt, new_fdt_align, overlay_root, ovcs_id);
>>  	if (ret < 0) {
>>  		/*
>>  		 * new_fdt and overlay_root now belong to the overlay
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index eb100627c186..29081a8b32e6 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/device.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/kernel.h>
>>  
>>  #include <linux/i2c.h>
>>  #include <linux/i2c-mux.h>
>> @@ -1408,6 +1409,7 @@ static void attach_node_and_children(struct device_node *np)
>>  static int __init unittest_data_add(void)
>>  {
>>  	void *unittest_data;
>> +	void *unittest_data_align;
>>  	struct device_node *unittest_data_node, *np;
>>  	/*
>>  	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
>> @@ -1415,7 +1417,7 @@ static int __init unittest_data_add(void)
>>  	 */
>>  	extern uint8_t __dtb_testcases_begin[];
>>  	extern uint8_t __dtb_testcases_end[];
>> -	const int size = __dtb_testcases_end - __dtb_testcases_begin;
>> +	u32 size = __dtb_testcases_end - __dtb_testcases_begin;
>>  	int rc;
>>  
>>  	if (!size) {
>> @@ -1425,11 +1427,15 @@ static int __init unittest_data_add(void)
>>  	}
>>  
>>  	/* creating copy */
>> -	unittest_data = kmemdup(__dtb_testcases_begin, size, GFP_KERNEL);
>> +	size += FDT_ALIGN_SIZE;
>> +	unittest_data = kmalloc(size, GFP_KERNEL);
>>  	if (!unittest_data)
>>  		return -ENOMEM;
>>  
>> -	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
>> +	unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
>> +	memcpy(unittest_data_align, __dtb_testcases_begin, size);
> 
> Same as above.

Will fix with separate variables "size" and "size_alloc".

> 
>> +
>> +	of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
>>  	if (!unittest_data_node) {
>>  		pr_warn("%s: No tree to attach; not running tests\n", __func__);
>>  		kfree(unittest_data);
>>
> 

