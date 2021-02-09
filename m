Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A90315B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhBJAXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhBIUwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:52:02 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24739C061B3F
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 11:49:42 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u4so23992986ljh.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 11:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tg9bvJW7KURZqSvHpoxoxZZgRlsW1CD6yJ8HTgIrTEI=;
        b=MSEMrSW7JE1XKfLGcssMplSx3dkONIFuFJZaQh96MU2irMExdNDlb2UUV9hJFNXJXJ
         XGdzYXPyEcHNxCQyb5IDoshruLqD49zhqfhDRSZbRSO4+qZlUjrnqe6W88WirVg6CQ8A
         J3g8IUxKQSM3vuI5YIU56JfXlWypqngBVxK/1Y7YSsgD/aacJfxvLfrUNftmAqvjQ8RM
         tZ7Lkqn2hKle/1srmexZPkEtEHG64broojVHPswm8U6ydtCyja7tLY9rnI8xY0Ryr7ur
         HV7DqWDlmCEi2HGkRIKB5Jvq/S4WuX/lPI1T/V98x0BQgyebOz5jz+kj1VVRE7jRTF4k
         gQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tg9bvJW7KURZqSvHpoxoxZZgRlsW1CD6yJ8HTgIrTEI=;
        b=Q1oz82b02p1ilFD2LtdOYyfLKQh/kz9sZoO6UNOZ34o/xdwurHNfXQC5yZkBUGDKzA
         HcRCf1Zhd0DTSe+/eTUyKYlTPYB9YAlQE1gKqQ0E1tJQsvzECE1Vt33ltmRRSJPAoh7e
         raQuMbz0oWs/OowGB8RRqcs0katxg+H5Na0R3cjXjiooVvEL7i1sc9olix/NZ/7bkp8z
         xno5grmed28dyfvDPi7gcICHZ8KVFN7ayBYff8BETsyWEksy4oFLG4vvEBxc4yg4RrTm
         DiRdkLhR/7cJ25aJuo5nSPrJubNjMMzVIBOQcwD8b3ygqBndVG5GBQJbMa8PJKcHoM8k
         b4LQ==
X-Gm-Message-State: AOAM531RU5vLxAY11d/kEXw8qe/A3khGI3XxDWUsoFAmGkxQR2/gY5PW
        4i+0lS9MvK+3b6upiqYPxFY=
X-Google-Smtp-Source: ABdhPJzvKlxSM2JZPmKZkX9/m1E5b8uJM4DG7ktOz4CK0yp3WohrsTQ8lv7SF8/LEPXl+YNGcag89g==
X-Received: by 2002:a2e:8712:: with SMTP id m18mr3861223lji.60.1612900180561;
        Tue, 09 Feb 2021 11:49:40 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id q24sm2782098ljg.117.2021.02.09.11.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:49:39 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 9 Feb 2021 20:49:37 +0100
To:     Serapheim Dimitropoulos <serapheim.dimitro@delphix.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, osandov@osandov.com,
        urezki@gmail.com, serapheim@delphix.com
Subject: Re: [PATCH v2] mm/vmalloc: use rb_tree instead of list for vread()
 lookups
Message-ID: <20210209194937.GA2452@pc638.lan>
References: <20210209190253.108763-1-serapheim@delphix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209190253.108763-1-serapheim@delphix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> vread() has been linearly searching vmap_area_list for looking up
> vmalloc areas to read from. These same areas are also tracked by
> a rb_tree (vmap_area_root) which offers logarithmic lookup.
> 
> This patch modifies vread() to use the rb_tree structure instead
> of the list and the speedup for heavy /proc/kcore readers can
> be pretty significant. Below are the wall clock measurements of
> a Python application that leverages the drgn debugging library
> to read and interpret data read from /proc/kcore.
> 
> Before the patch:
> -----
> $ time sudo sdb -e 'dbuf | head 3000 | wc'
> (unsigned long)3000
> 
> real	0m22.446s
> user	0m2.321s
> sys	0m20.690s
> -----
> 
> With the patch:
> -----
> $ time sudo sdb -e 'dbuf | head 3000 | wc'
> (unsigned long)3000
> 
> real	0m2.104s
> user	0m2.043s
> sys	0m0.921s
> -----
> 
> Signed-off-by: Serapheim Dimitropoulos <serapheim@delphix.com>
> ---
> Changed in v2:
> 
> - Use __find_vmap_area() for initial lookup but keep iteration via
>   va->list.
> 
>  mm/vmalloc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 49ab9b6c001d..eb133d000394 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2860,7 +2860,10 @@ long vread(char *buf, char *addr, unsigned long count)
>  		count = -(unsigned long) addr;
>  
>  	spin_lock(&vmap_area_lock);
> -	list_for_each_entry(va, &vmap_area_list, list) {
> +	va = __find_vmap_area((unsigned long)addr);
> +	if (!va)
> +		goto finished;
> +	list_for_each_entry_from(va, &vmap_area_list, list) {
>  		if (!count)
>  			break;
>  
> -- 
> 2.17.1
> 
Much better :)

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
