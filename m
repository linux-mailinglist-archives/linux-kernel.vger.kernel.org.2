Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED693C9D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241735AbhGOLBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbhGOLBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:01:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2FC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:58:18 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q4so8113321ljp.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TBy0uciWgzBnyRgveHH1MFBpO9T+N0y7vThNEqm5Wtc=;
        b=V03s5RT19tk7odrYfvtdPvpVkHs6NYLb0eeZazurQZ0uvvwUdwYw8yDKZG3Fp468qB
         oyhlIJdU6B/oOwp4zFuYW7CqZUdGtcYaw4mZz0x64UUdxYU5x8xcwm8TX+y0WXlCMRc+
         vKuBX5ySPyfnvvTu6awoVFyuJ5paxQtC9wynkQJO0nwfvjzUhKWTzPIDxVvHeyicc3tj
         8XgqArocvS2xthQriJQ0jM4tgoWj2MT0t6wa15jqSlEhAtsPVvDEuCPRvz9oRqkhHCr/
         qHCB4VVWaQV0Zgxc3cHjcIerkZypzbfx9DwjSFlcNZtePcJJlkBSobLU1xNJi1yoQjMl
         6FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TBy0uciWgzBnyRgveHH1MFBpO9T+N0y7vThNEqm5Wtc=;
        b=KO6xhTUWBJDnwyeHp7Jc3PBa65oGIK/XkKd/HGhHnA8dHeWtW58S6k8KNDHWW8ZoKa
         hPuLEyPJ+Q1pYUjjxuVR4DKan7bqqkyQGEOgJTMTyl9J9ko3QPPsa+MufDGBArRkMGOS
         5KCw3vMgpJ8uaVRCO8W3Hbm35V85a5+g5iYcYVI6mDaBpSie3m5ib15O0T/AUpTkxcqx
         sIWKNd+Flsl9uvjOmRXNyfn3mJGOt9Kpk64dln9vYN/npKh8WfC12xSengVEMf2Z72ri
         FmTeOh1YjRC45+de65fTr6DAUdPcEU8iVfs99KBKWRES7ynMt+uQakKvp2odqKvw5gMu
         fsMA==
X-Gm-Message-State: AOAM5302DovL9MmfRTseytRlPva2cWxEQXZ0LErOy+ZNb52HZRVtWmEa
        sfTZll3m4J7JqARuRfZ+K/E=
X-Google-Smtp-Source: ABdhPJwY91OrmT7/Ca0tvRe1D2yeHL/J1nyou/l/Ohcf7WKS1LBZsGrqpQQOtXmz6ldNOGTWjINCdA==
X-Received: by 2002:a2e:bd06:: with SMTP id n6mr3402863ljq.95.1626346696594;
        Thu, 15 Jul 2021 03:58:16 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id q15sm373739lfp.157.2021.07.15.03.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 03:58:15 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 15 Jul 2021 12:58:13 +0200
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, serapheim.dimitro@delphix.com,
        urezki@gmail.com, wangkefeng.wang@huawei.com,
        weiyongjun1@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] mm/vmalloc: fix wrong behavior in vread
Message-ID: <20210715105813.GA1879@pc638.lan>
References: <20210714015959.3204871-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714015959.3204871-1-chenwandun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 09:59:59AM +0800, Chen Wandun wrote:
> commit f608788cd2d6 ("mm/vmalloc: use rb_tree instead of list for vread()
> lookups") use rb_tree instread of list to speed up lookup, but function
> __find_vmap_area is try to find a vmap_area that include target address,
> if target address is smaller than the leftmost node in vmap_area_root,
> it will return NULL, then vread will read nothing. This behavior is
> different from the primitive semantics.
> 
> The correct way is find the first vmap_are that bigger than target addr,
> that is what function find_vmap_area_exceed_addr does.
> 
> Fixes: f608788cd2d6 ("mm/vmalloc: use rb_tree instead of list for vread() lookups")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  mm/vmalloc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index d5cd52805149..47c3a551b6dc 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -787,6 +787,28 @@ unsigned long vmalloc_nr_pages(void)
>  	return atomic_long_read(&nr_vmalloc_pages);
>  }
>  
> +static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
> +{
> +	struct vmap_area *va = NULL;
> +	struct rb_node *n = vmap_area_root.rb_node;
> +
> +	while (n) {
> +		struct vmap_area *tmp;
> +
> +		tmp = rb_entry(n, struct vmap_area, rb_node);
> +		if (tmp->va_end > addr) {
> +			va = tmp;
> +			if (tmp->va_start <= addr)
> +				break;
> +
> +			n = n->rb_left;
> +		} else
> +			n = n->rb_right;
> +	}
> +
> +	return va;
> +}
> +
Can we combine pvm_find_va_enclose_addr() with your new function
making it as one function? The aim is to reduce copy-paste and
not create such new "find" functions.

The pvm_find_va_enclose_addr() seems does the same but only in
reverse order. So something like:

find_vmap_area_exceed_addr(bool reverse)

Thanks!

--
Vlad Rezki
