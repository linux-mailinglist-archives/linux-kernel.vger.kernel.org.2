Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78D3545C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhDERCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbhDERC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:02:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09632C061756;
        Mon,  5 Apr 2021 10:02:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id x2so12243616oiv.2;
        Mon, 05 Apr 2021 10:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ABRbsCX1jEMC1SjlaLIus8yukReuvU1jzZ48riQcml4=;
        b=pHNrb0HKjA4iJCZYAaU2LkN2lkpDnQu1YBt+GInagTvEa4lP7ZRgdVjp2rlrKXhPMg
         A8L/yMmJ+6tU3BAGlViUfxa2ncoqC4D5KugKlKJS5KV/JEqYmbwmYbPzet4lrC9RDCam
         hj9dHHmNbLMKSxXkl6OhzEsD4j2Pe+jPT25Z4ZAtofdqYQe4IoqbkRjnnwKBXNpnwiDD
         aIhjrx2TyXR6NV+DlFum1UQjjMIgO7In89T7zt36ObFYUzzocwz8NTuMAEKmbTnNbS3r
         wJBWU18eKFPeQxdXNMSBGXN8Tl3M+kMpCByPzj1AUal5Qt8u6BpSrFadFQ3Q/SY0A75F
         k4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=ABRbsCX1jEMC1SjlaLIus8yukReuvU1jzZ48riQcml4=;
        b=RcaZ8mJ/HJV70h8y2s3vHWBJ80vPIosKbJHEvO1doHlIeHiXsWpjw6CgWCFu82/Ofl
         f4QK4SffGVRxHFP4bBQeXLVNJh8dKgm6D32vJYzfGu0ZW4FKmTMrVCE8ypAkuYOCxDJm
         0HB3huJ+OtqU76u+S3Ghb3MjTxatT97lDuc+IVjp7gPiFKPI4LJE5hJzL6Pnjhx08o8i
         ByRtG6Vz0EPyRaA5+vgKZEHvOP0CyXo9w/1TE9KSSMK6+sJX1GLTFS0ICJwZQ4eeLV1q
         VeUssVlApNtJpofQeh4eXgkaojrg582P4N0yT2iEDwVxoO2B2BhNXXBkWk6jo8DdEr4I
         00mg==
X-Gm-Message-State: AOAM530Xk1IfW3yOgYrsfekbQ7QImleKqWJQt+0mH5joAb2kCerruXCj
        4pAM9rUne31YPeWGW+RK6u8=
X-Google-Smtp-Source: ABdhPJxTzhcIw/kcBA44VLmacyEq8LHk1n0j+YPzcPx8UKAn9zKMyrJVL4LSYOA7KWIToi2jYUnVZg==
X-Received: by 2002:aca:4487:: with SMTP id r129mr84141oia.106.1617642142356;
        Mon, 05 Apr 2021 10:02:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22sm4204736otf.25.2021.04.05.10.02.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Apr 2021 10:02:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Apr 2021 10:02:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     frowand.list@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] of: properly check for error returned by
 fdt_get_name()
Message-ID: <20210405170220.GA52569@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 10:28:45PM -0500, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> fdt_get_name() returns error values via a parameter pointer
> instead of in function return.  Fix check for this error value
> in populate_node() and callers of populate_node().
> 
> Chasing up the caller tree showed callers of various functions
> failing to initialize the value of pointer parameters that
> can return error values.  Initialize those values to NULL.
> 
> The bug was introduced by
> commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use libfdt")
> but this patch can not be backported directly to that commit
> because the relevant code has further been restructured by
> commit dfbd4c6eff35 ("drivers/of: Split unflatten_dt_node()")
> 
> The bug became visible by triggering a crash on openrisc with:
> commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> as reported in:
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> 
> Fixes: commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> 

With this patch applied, the kernel no longer crashes, and the log message
is as expected:

### dt-test ### start of unittest - you will see error messages
### dt-test ### unittest_data_add: unflatten testcases tree failed

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
> 
> This patch papers over the unaligned pointer passed to
> of_fdt_unflatten_tree() bug that Guenter reported in
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> 
> I will create a separate patch to fix that problem.
> 
>  drivers/of/fdt.c      | 36 +++++++++++++++++++++++-------------
>  drivers/of/overlay.c  |  2 +-
>  drivers/of/unittest.c | 15 ++++++++++-----
>  3 files changed, 34 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index dcc1dd96911a..adb26aff481d 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -205,7 +205,7 @@ static void populate_properties(const void *blob,
>  		*pprev = NULL;
>  }
>  
> -static bool populate_node(const void *blob,
> +static int populate_node(const void *blob,
>  			  int offset,
>  			  void **mem,
>  			  struct device_node *dad,
> @@ -214,24 +214,24 @@ static bool populate_node(const void *blob,
>  {
>  	struct device_node *np;
>  	const char *pathp;
> -	unsigned int l, allocl;
> +	int len;
>  
> -	pathp = fdt_get_name(blob, offset, &l);
> +	pathp = fdt_get_name(blob, offset, &len);
>  	if (!pathp) {
>  		*pnp = NULL;
> -		return false;
> +		return len;
>  	}
>  
> -	allocl = ++l;
> +	len++;
>  
> -	np = unflatten_dt_alloc(mem, sizeof(struct device_node) + allocl,
> +	np = unflatten_dt_alloc(mem, sizeof(struct device_node) + len,
>  				__alignof__(struct device_node));
>  	if (!dryrun) {
>  		char *fn;
>  		of_node_init(np);
>  		np->full_name = fn = ((char *)np) + sizeof(*np);
>  
> -		memcpy(fn, pathp, l);
> +		memcpy(fn, pathp, len);
>  
>  		if (dad != NULL) {
>  			np->parent = dad;
> @@ -295,6 +295,7 @@ static int unflatten_dt_nodes(const void *blob,
>  	struct device_node *nps[FDT_MAX_DEPTH];
>  	void *base = mem;
>  	bool dryrun = !base;
> +	int ret;
>  
>  	if (nodepp)
>  		*nodepp = NULL;
> @@ -322,9 +323,10 @@ static int unflatten_dt_nodes(const void *blob,
>  		    !of_fdt_device_is_available(blob, offset))
>  			continue;
>  
> -		if (!populate_node(blob, offset, &mem, nps[depth],
> -				   &nps[depth+1], dryrun))
> -			return mem - base;
> +		ret = populate_node(blob, offset, &mem, nps[depth],
> +				   &nps[depth+1], dryrun);
> +		if (ret < 0)
> +			return ret;
>  
>  		if (!dryrun && nodepp && !*nodepp)
>  			*nodepp = nps[depth+1];
> @@ -372,6 +374,10 @@ void *__unflatten_device_tree(const void *blob,
>  {
>  	int size;
>  	void *mem;
> +	int ret;
> +
> +	if (mynodes)
> +		*mynodes = NULL;
>  
>  	pr_debug(" -> unflatten_device_tree()\n");
>  
> @@ -392,7 +398,7 @@ void *__unflatten_device_tree(const void *blob,
>  
>  	/* First pass, scan for size */
>  	size = unflatten_dt_nodes(blob, NULL, dad, NULL);
> -	if (size < 0)
> +	if (size <= 0)
>  		return NULL;
>  
>  	size = ALIGN(size, 4);
> @@ -410,12 +416,16 @@ void *__unflatten_device_tree(const void *blob,
>  	pr_debug("  unflattening %p...\n", mem);
>  
>  	/* Second pass, do actual unflattening */
> -	unflatten_dt_nodes(blob, mem, dad, mynodes);
> +	ret = unflatten_dt_nodes(blob, mem, dad, mynodes);
> +
>  	if (be32_to_cpup(mem + size) != 0xdeadbeef)
>  		pr_warn("End of tree marker overwritten: %08x\n",
>  			be32_to_cpup(mem + size));
>  
> -	if (detached && mynodes) {
> +	if (ret <= 0)
> +		return NULL;
> +
> +	if (detached && mynodes && *mynodes) {
>  		of_node_set_flag(*mynodes, OF_DETACHED);
>  		pr_debug("unflattened tree is detached\n");
>  	}
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 50bbe0edf538..e12c643b6ba8 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -1017,7 +1017,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
>  	const void *new_fdt;
>  	int ret;
>  	u32 size;
> -	struct device_node *overlay_root;
> +	struct device_node *overlay_root = NULL;
>  
>  	*ovcs_id = 0;
>  	ret = 0;
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index eb100627c186..f9b5b698249f 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1408,7 +1408,7 @@ static void attach_node_and_children(struct device_node *np)
>  static int __init unittest_data_add(void)
>  {
>  	void *unittest_data;
> -	struct device_node *unittest_data_node, *np;
> +	struct device_node *unittest_data_node = NULL, *np;
>  	/*
>  	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
>  	 * created by cmd_dt_S_dtb in scripts/Makefile.lib
> @@ -1417,10 +1417,10 @@ static int __init unittest_data_add(void)
>  	extern uint8_t __dtb_testcases_end[];
>  	const int size = __dtb_testcases_end - __dtb_testcases_begin;
>  	int rc;
> +	void *ret;
>  
>  	if (!size) {
> -		pr_warn("%s: No testcase data to attach; not running tests\n",
> -			__func__);
> +		pr_warn("%s: testcases is empty\n", __func__);
>  		return -ENODATA;
>  	}
>  
> @@ -1429,9 +1429,14 @@ static int __init unittest_data_add(void)
>  	if (!unittest_data)
>  		return -ENOMEM;
>  
> -	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
> +	ret = of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
> +	if (!ret) {
> +		pr_warn("%s: unflatten testcases tree failed\n", __func__);
> +		kfree(unittest_data);
> +		return -ENODATA;
> +	}
>  	if (!unittest_data_node) {
> -		pr_warn("%s: No tree to attach; not running tests\n", __func__);
> +		pr_warn("%s: testcases tree is empty\n", __func__);
>  		kfree(unittest_data);
>  		return -ENODATA;
>  	}
> -- 
> Frank Rowand <frank.rowand@sony.com>
> 
