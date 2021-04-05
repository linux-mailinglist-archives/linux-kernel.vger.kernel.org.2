Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A16354919
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 01:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238490AbhDEXDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 19:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbhDEXDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 19:03:32 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079D1C06174A;
        Mon,  5 Apr 2021 16:03:25 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w70so13213610oie.0;
        Mon, 05 Apr 2021 16:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y+p0RVFehlysYEnFiLjkKOdw7puwGbfB/6u7YdDDhaY=;
        b=cKsLDLsLBQFUBCFYdmOMzMdt+et1jwifAT7EwzKERqjFR05h+4okc5hansbwQgNAqe
         yOJ7/JXYP+jRzM0sfZB1EvarilXEYIIXU4Ub17On/9HUUiq9TGJcKUyn6qwO7upSBEWq
         VzogwVmqH+N22CXxe3Gk1TsI0Xa1D9xqSdQEh3N/Tn+V46cXihCRMR4eMLiFKw/dFoTw
         FECPSCjgd1qm1RNJTyTRQj3s4JbxLch72pGLKJaafWiNkr1Z0TyERUmRmuyTRS+I5/4a
         dDPmY2Uq+8acIlXkyjFZNYgnAfi3Uf4oaAI8a0UbrkGQelvhISnzg3mB4Nhi3NUh2yid
         BsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=y+p0RVFehlysYEnFiLjkKOdw7puwGbfB/6u7YdDDhaY=;
        b=rDKqyMkaXIZV07WRhOpbBxX45+ZRuhj9wX4/OELwW/bEoumDxUxFAfux+U6TDoe2lP
         oe9S1pn0onNuMI3vlkeHd30Z2kHzxWhYzZ8POLubBxmfyNLNue2de2jQ8M/8YHSNLiT2
         QSOnV//25Fb8C7rdDQQXhEekZdEdeBPpHMsXjH/GfF0I0itWq3Fu6cVpyi3RfECwPstQ
         lIJwWM3uSbDkIV4PnwdVDQ6ibH4pryjjbH++TPbzlXTjJebcIHKXBAbo/P+Hrn6f1Yzi
         jxMkWUh12VGEshaJ9WuQ1WUUxa8VmO5QoPTyoqA1Xq6KYgPS8EgWLEILipYNw99H8mgL
         jTOQ==
X-Gm-Message-State: AOAM532SqPQ/M2hftB/wDNFl6GB3+B9kf3H74VnsFQIcsM/nN60nzdg+
        Ah0Zby64pAQBkKOFfqWFuoYRpq4FHPA=
X-Google-Smtp-Source: ABdhPJx+wmBnt0DHPw31PgrBtNx54pXklA3A/rvc8NDRi5lV+sK8jE2ItRJpFLrdZk/PqppgGzPHmw==
X-Received: by 2002:aca:1919:: with SMTP id l25mr1044219oii.24.1617663804177;
        Mon, 05 Apr 2021 16:03:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c12sm3703557oou.26.2021.04.05.16.03.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Apr 2021 16:03:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 5 Apr 2021 16:03:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] of: properly check for error returned by
 fdt_get_name()
Message-ID: <20210405230322.GA249231@roeck-us.net>
References: <20210405032845.1942533-1-frowand.list@gmail.com>
 <8b16b504-83b5-9d36-eade-f7b375c0535b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b16b504-83b5-9d36-eade-f7b375c0535b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2021 at 10:37:35PM -0500, Frank Rowand wrote:
> Hi Guenter,
> 
> Can you please test this patch to see if it prevents the crash on
> openrisc that you reported in
> https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> 
> Just after start of unittest you should see a warning about
> testcases.
> 

Trying again:

With this patch applied, the kernel no longer crashes, and the log message
is as expected:

### dt-test ### start of unittest - you will see error messages
### dt-test ### unittest_data_add: unflatten testcases tree failed

Tested-by: Guenter Roeck <linux@roeck-us.net>

> Thanks,
> 
> Frank
> 
> 
> On 4/4/21 10:28 PM, frowand.list@gmail.com wrote:
> > From: Frank Rowand <frank.rowand@sony.com>
> > 
> > fdt_get_name() returns error values via a parameter pointer
> > instead of in function return.  Fix check for this error value
> > in populate_node() and callers of populate_node().
> > 
> > Chasing up the caller tree showed callers of various functions
> > failing to initialize the value of pointer parameters that
> > can return error values.  Initialize those values to NULL.
> > 
> > The bug was introduced by
> > commit e6a6928c3ea1 ("of/fdt: Convert FDT functions to use libfdt")
> > but this patch can not be backported directly to that commit
> > because the relevant code has further been restructured by
> > commit dfbd4c6eff35 ("drivers/of: Split unflatten_dt_node()")
> > 
> > The bug became visible by triggering a crash on openrisc with:
> > commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> > as reported in:
> > https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> > 
> > Fixes: commit 79edff12060f ("scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> > 
> > ---
> > 
> > This patch papers over the unaligned pointer passed to
> > of_fdt_unflatten_tree() bug that Guenter reported in
> > https://lore.kernel.org/lkml/20210327224116.69309-1-linux@roeck-us.net/
> > 
> > I will create a separate patch to fix that problem.
> > 
> >  drivers/of/fdt.c      | 36 +++++++++++++++++++++++-------------
> >  drivers/of/overlay.c  |  2 +-
> >  drivers/of/unittest.c | 15 ++++++++++-----
> >  3 files changed, 34 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index dcc1dd96911a..adb26aff481d 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -205,7 +205,7 @@ static void populate_properties(const void *blob,
> >  		*pprev = NULL;
> >  }
> >  
> > -static bool populate_node(const void *blob,
> > +static int populate_node(const void *blob,
> >  			  int offset,
> >  			  void **mem,
> >  			  struct device_node *dad,
> > @@ -214,24 +214,24 @@ static bool populate_node(const void *blob,
> >  {
> >  	struct device_node *np;
> >  	const char *pathp;
> > -	unsigned int l, allocl;
> > +	int len;
> >  
> > -	pathp = fdt_get_name(blob, offset, &l);
> > +	pathp = fdt_get_name(blob, offset, &len);
> >  	if (!pathp) {
> >  		*pnp = NULL;
> > -		return false;
> > +		return len;
> >  	}
> >  
> > -	allocl = ++l;
> > +	len++;
> >  
> > -	np = unflatten_dt_alloc(mem, sizeof(struct device_node) + allocl,
> > +	np = unflatten_dt_alloc(mem, sizeof(struct device_node) + len,
> >  				__alignof__(struct device_node));
> >  	if (!dryrun) {
> >  		char *fn;
> >  		of_node_init(np);
> >  		np->full_name = fn = ((char *)np) + sizeof(*np);
> >  
> > -		memcpy(fn, pathp, l);
> > +		memcpy(fn, pathp, len);
> >  
> >  		if (dad != NULL) {
> >  			np->parent = dad;
> > @@ -295,6 +295,7 @@ static int unflatten_dt_nodes(const void *blob,
> >  	struct device_node *nps[FDT_MAX_DEPTH];
> >  	void *base = mem;
> >  	bool dryrun = !base;
> > +	int ret;
> >  
> >  	if (nodepp)
> >  		*nodepp = NULL;
> > @@ -322,9 +323,10 @@ static int unflatten_dt_nodes(const void *blob,
> >  		    !of_fdt_device_is_available(blob, offset))
> >  			continue;
> >  
> > -		if (!populate_node(blob, offset, &mem, nps[depth],
> > -				   &nps[depth+1], dryrun))
> > -			return mem - base;
> > +		ret = populate_node(blob, offset, &mem, nps[depth],
> > +				   &nps[depth+1], dryrun);
> > +		if (ret < 0)
> > +			return ret;
> >  
> >  		if (!dryrun && nodepp && !*nodepp)
> >  			*nodepp = nps[depth+1];
> > @@ -372,6 +374,10 @@ void *__unflatten_device_tree(const void *blob,
> >  {
> >  	int size;
> >  	void *mem;
> > +	int ret;
> > +
> > +	if (mynodes)
> > +		*mynodes = NULL;
> >  
> >  	pr_debug(" -> unflatten_device_tree()\n");
> >  
> > @@ -392,7 +398,7 @@ void *__unflatten_device_tree(const void *blob,
> >  
> >  	/* First pass, scan for size */
> >  	size = unflatten_dt_nodes(blob, NULL, dad, NULL);
> > -	if (size < 0)
> > +	if (size <= 0)
> >  		return NULL;
> >  
> >  	size = ALIGN(size, 4);
> > @@ -410,12 +416,16 @@ void *__unflatten_device_tree(const void *blob,
> >  	pr_debug("  unflattening %p...\n", mem);
> >  
> >  	/* Second pass, do actual unflattening */
> > -	unflatten_dt_nodes(blob, mem, dad, mynodes);
> > +	ret = unflatten_dt_nodes(blob, mem, dad, mynodes);
> > +
> >  	if (be32_to_cpup(mem + size) != 0xdeadbeef)
> >  		pr_warn("End of tree marker overwritten: %08x\n",
> >  			be32_to_cpup(mem + size));
> >  
> > -	if (detached && mynodes) {
> > +	if (ret <= 0)
> > +		return NULL;
> > +
> > +	if (detached && mynodes && *mynodes) {
> >  		of_node_set_flag(*mynodes, OF_DETACHED);
> >  		pr_debug("unflattened tree is detached\n");
> >  	}
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index 50bbe0edf538..e12c643b6ba8 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -1017,7 +1017,7 @@ int of_overlay_fdt_apply(const void *overlay_fdt, u32 overlay_fdt_size,
> >  	const void *new_fdt;
> >  	int ret;
> >  	u32 size;
> > -	struct device_node *overlay_root;
> > +	struct device_node *overlay_root = NULL;
> >  
> >  	*ovcs_id = 0;
> >  	ret = 0;
> > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > index eb100627c186..f9b5b698249f 100644
> > --- a/drivers/of/unittest.c
> > +++ b/drivers/of/unittest.c
> > @@ -1408,7 +1408,7 @@ static void attach_node_and_children(struct device_node *np)
> >  static int __init unittest_data_add(void)
> >  {
> >  	void *unittest_data;
> > -	struct device_node *unittest_data_node, *np;
> > +	struct device_node *unittest_data_node = NULL, *np;
> >  	/*
> >  	 * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
> >  	 * created by cmd_dt_S_dtb in scripts/Makefile.lib
> > @@ -1417,10 +1417,10 @@ static int __init unittest_data_add(void)
> >  	extern uint8_t __dtb_testcases_end[];
> >  	const int size = __dtb_testcases_end - __dtb_testcases_begin;
> >  	int rc;
> > +	void *ret;
> >  
> >  	if (!size) {
> > -		pr_warn("%s: No testcase data to attach; not running tests\n",
> > -			__func__);
> > +		pr_warn("%s: testcases is empty\n", __func__);
> >  		return -ENODATA;
> >  	}
> >  
> > @@ -1429,9 +1429,14 @@ static int __init unittest_data_add(void)
> >  	if (!unittest_data)
> >  		return -ENOMEM;
> >  
> > -	of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
> > +	ret = of_fdt_unflatten_tree(unittest_data, NULL, &unittest_data_node);
> > +	if (!ret) {
> > +		pr_warn("%s: unflatten testcases tree failed\n", __func__);
> > +		kfree(unittest_data);
> > +		return -ENODATA;
> > +	}
> >  	if (!unittest_data_node) {
> > -		pr_warn("%s: No tree to attach; not running tests\n", __func__);
> > +		pr_warn("%s: testcases tree is empty\n", __func__);
> >  		kfree(unittest_data);
> >  		return -ENODATA;
> >  	}
> > 
> 
