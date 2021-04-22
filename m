Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3F367BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhDVIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhDVIMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:12:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F5C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:11:39 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u187so4098220wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YzUSYaOgN9hxojeW0mU7pzbBG2m7ss1xHFD86VpZnFw=;
        b=SQBU2KUkg8eg+N+tMN7haZLLtl7EyaXi5aA3ujHphx/jCYBCM14EfIxYNwUyfBHKb4
         snU8IimoDnaoZJp5mAhiDqj430JufITSFQ4+HLTMZ3NXHi3TPOIkxL3m6gWEwikhLUrz
         t3K6p6XAEM+uZ19sV6Ln7bgwAmV/FiGMvgtls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=YzUSYaOgN9hxojeW0mU7pzbBG2m7ss1xHFD86VpZnFw=;
        b=AKcMdX39ZaBKtprddgu1LY3pfLsGILj3uZJzq2oWVYyhunFTT69lRnCuOv+E4n5Y+B
         I8SZO9PTbdIUFSjT37ancH2PeDao1e8M4m3SU+kyNuZdYctGVJP1Bg2UeJLz2GGgS6U1
         krNMEM6WlLqD1ciJ2Xb90J/qoUCjoGcplGvN06KgBUrJ9sYxrP+Iq9vGY1UgdaN5RUK2
         KqoToeTgWb+fyohH9ozIx6XtJjPE7kapu95/J6HI90d065vw24kO4IFNm6m1crpErMHw
         mhXfzlVW31pvA916PkHWGSrDXhxpXJiXR5rS/f8n7WDrAZf9VCZhdaM5YHdssqNfv+kf
         TghA==
X-Gm-Message-State: AOAM533vMiasSJjTnm2wrjU2sWyJ2X7k1+T1VGRxEt3ExvZSw0bLmE+i
        bbeMejo1cRClRbeGorNlEggiuA==
X-Google-Smtp-Source: ABdhPJzQpl8oyp8JKOUGIeroE+P/ggioIzwSyjJLJwYdLC/3EQSRErDjzwQT8eDoqpZqalDMXfPETw==
X-Received: by 2002:a1c:1dd0:: with SMTP id d199mr2436011wmd.54.1619079098208;
        Thu, 22 Apr 2021 01:11:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l20sm2249188wmg.33.2021.04.22.01.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 01:11:37 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:11:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu, dri-devel@lists.freedesktop.org,
        jgg@ziepe.ca, jaharkes@cs.cmu.edu, akpm@linux-foundation.org,
        miklos@szeredi.hu, coda@cs.cmu.edu
Subject: Re: [PATCH 1/2] coda: fix reference counting in coda_file_mmap error
 path
Message-ID: <YIEvt01bQkKhxDSJ@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu, dri-devel@lists.freedesktop.org,
        jgg@ziepe.ca, jaharkes@cs.cmu.edu, akpm@linux-foundation.org,
        miklos@szeredi.hu, coda@cs.cmu.edu
References: <20210421132012.82354-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421132012.82354-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:20:11PM +0200, Christian König wrote:
> mmap_region() now calls fput() on the vma->vm_file.
> 
> So we need to drop the extra reference on the coda file instead of the
> host file.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: 1527f926fd04 ("mm: mmap: fix fput in error path v2")
> CC: stable@vger.kernel.org # 5.11+

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  fs/coda/file.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index 128d63df5bfb..ef5ca22bfb3e 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -175,10 +175,10 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
>  	ret = call_mmap(vma->vm_file, vma);
>  
>  	if (ret) {
> -		/* if call_mmap fails, our caller will put coda_file so we
> -		 * should drop the reference to the host_file that we got.
> +		/* if call_mmap fails, our caller will put host_file so we
> +		 * should drop the reference to the coda_file that we got.
>  		 */
> -		fput(host_file);
> +		fput(coda_file);
>  		kfree(cvm_ops);
>  	} else {
>  		/* here we add redirects for the open/close vm_operations */
> -- 
> 2.25.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
