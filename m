Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467DA3CA174
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 17:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbhGOPbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 11:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238380AbhGOPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 11:31:35 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE0DC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:28:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g12so4808121qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x8cGYGCY2zQSDvn5vpIzgSX6qyZmQETA7Emhi1DRz4c=;
        b=E1jYT9jj2dmVutO4/3vY/UTq2NafPGvPfEsDQlQqPr7MMhYfzSQb5tiYEjEimMzcSp
         2ASmS2t+EB02zx+tvS6ICQgrDG5lIUAnd7gEt/bKV7c1Wo3d8APyL0oF+FRjjyJEeHgA
         eDMaXdmojzzvJZijrLbF8vLLpGUAFT2ZRToh3x6FXhJfCf91+88Q9eNZOc95ppRJsu+F
         QQkpbP2VCQhaeQAhQPcB66NWycBsyOzRcwH/DVj1nanJJK4SSfFy+UERGdABCPo2Rp3g
         oC/fGOEY6f9RWdVcO52onEuUBOZkaxRM0vrw5TYJHuFKcYrIywjDPuTapcU0Hvvsnf2Q
         wU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8cGYGCY2zQSDvn5vpIzgSX6qyZmQETA7Emhi1DRz4c=;
        b=jtwO0hZHiX9i0Kjs9oS1KIV1BzZKgXUYg5I5Yck6MWXuD+mFcFckgeGg5Nhllv5l4d
         ITbk5NzEfJiz7IWxMQcIQlT73VHFjTKwdrgqy03b4qNFVi8S4/qcI6AS1s0LAIkRZ0ke
         VCmuPrjXH5ycZkVxzKAYGVi+c3m151iUdjhDYlKF8tZ9I6uh01T+CnjEl644zEJZtRlm
         9A0ar1TSU/1atO5vN9jn3cN6qdE/W/HfYUHczQUTHUtOSOVSqWaMi56mqCk0E5LJFnoA
         jk6FdSWbevWFJ78eOfckGQ8T8cx42YMqjRKmWZce5GeZxSryTA2Yq6QVfAOztJL6JxN0
         ZT6w==
X-Gm-Message-State: AOAM530303WOHKmCKJ0NwqRmiAjPRaQkeDCXVXkHbE4owDTyXVIRrlos
        pnnGnJf3VaeJGgf7H9uqs5c=
X-Google-Smtp-Source: ABdhPJzqGOkIDjfsb+Z0H82Zg3u5LoXqQ9qJkkFSFdeJ1MCe8j11vWbId9qEA81FT4GBXi3rxEerSg==
X-Received: by 2002:a05:622a:89:: with SMTP id o9mr4397805qtw.339.1626362920218;
        Thu, 15 Jul 2021 08:28:40 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id c197sm2638141qke.33.2021.07.15.08.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:28:39 -0700 (PDT)
Date:   Thu, 15 Jul 2021 08:28:38 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH v7 1/4] cpumask: introduce cpumap_print_to_buf to support
 large bitmask and list
Message-ID: <YPBUJmqk4akuX8cv@yury-ThinkPad>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <20210715115856.11304-2-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715115856.11304-2-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:58:53PM +1200, Barry Song wrote:
> (10.1.198.147)
> X-CFilter-Loop: Reflected
> Status: O
> Content-Length: 10263
> Lines: 252
> 
> From: Tian Tao <tiantao6@hisilicon.com>

[...]

> +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> +		int nmaskbits, loff_t off, size_t count)
> +{
> +	const char *fmt = list ? "%*pbl\n" : "%*pb\n";
> +	ssize_t size;
> +	void *data;
> +
> +	data = kasprintf(GFP_KERNEL, fmt, nmaskbits, maskp);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	size = memory_read_from_buffer(buf, count, &off, data, strlen(data) + 1);
> +	kfree(data);
> +
> +	return size;
> +}
> +EXPORT_SYMBOL(bitmap_print_to_buf);

In discussion to v4 of this series I've pointed out inefficiency of
this approach. Now it's v7, but the problem is still there.

1. You make user of your API guess aboout proper @count without any
   hint. This is worse than how it works now with pure vsnprintf().
2. For big bitmaps and small @count, your code will make enormous
   amount of unneeded work. For example, if the full length of string
   representation of bitmap is 1M, and length of the output buffer is
   1k, one will have to call bitmap_print_to_buf() 1000 times.  With
   current design it assumes that you allocate the full amount of memory
   1000 times, free it 1000 times and print huge bitmap 1000 times to
   just return small part of it.

NAK for this, and please stop submitting wrong approach again and
again.
