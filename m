Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB37367BDB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhDVIOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235004AbhDVION (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:14:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF17AC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:13:38 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n4-20020a05600c4f84b029013151278decso2595546wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y+2orF1pTAhlEapNdeXUHEPMIxuWbRepsrCfwxwKqPQ=;
        b=gHnwqNUV9ImgCFezmiVa76pK8wVFkRrxerF84m3fGkLrmxRPS22ANeM2+wardiWMau
         TIACxgmBON1oew/9mDWdVzRInBo7wiaCjCKjux8OlAWeeO77boWwGStL+p6m1yNjeC3R
         wCI3YUFG5nSBBAvTADfTufzcNHi3gNchFusrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=y+2orF1pTAhlEapNdeXUHEPMIxuWbRepsrCfwxwKqPQ=;
        b=DUXogvyes+6paQpeyG42sDYxoOmk6JVYgQf7/ONLdDxzvTzvTutVufKlafAUZx6318
         66sqwVHlpgRlD0NfAMiBf5FBXGc7Reu/xpDTlumJHn0unzd9SSfQEb4wBVmxjyygfeNT
         UERdWW1yWRIcliveb9bcBBMqMRd3JhkaNRzCAygSjB7xZ5gMsM/F0ABsS/aYzvUcwFcM
         XKZ9ZszTq2pbUF3oWylURNjP9fLY+rQbK8k1Hecu192QSvVuegPgoFptL38GNw3ATN2D
         yE2qM9ltXsR+A3AcIAE4NL9PiVWnxj9BEMvpIf6yDbgiM4fnIjpf6+jkbQuLyyvIz0V4
         F0LA==
X-Gm-Message-State: AOAM533xnjpbXDCj3Mzoj5CDlqVR7fFVBGBjQpCKa7cshMKPdDvEcVI0
        vbBxng94lTBlfTvE5CIpCuNGDw==
X-Google-Smtp-Source: ABdhPJxj8Wjmw9peJ0Dkkr6S5qwG/1RIJTJQvvdMp6AsnTRfP/VbwnRDvQEbFil5LrRoQEP2bPFE4A==
X-Received: by 2002:a1c:4b11:: with SMTP id y17mr2401274wma.72.1619079217522;
        Thu, 22 Apr 2021 01:13:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b12sm20494903wmj.1.2021.04.22.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 01:13:37 -0700 (PDT)
Date:   Thu, 22 Apr 2021 10:13:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu, dri-devel@lists.freedesktop.org,
        jgg@ziepe.ca, jaharkes@cs.cmu.edu, akpm@linux-foundation.org,
        miklos@szeredi.hu, coda@cs.cmu.edu
Subject: Re: [PATCH 2/2] ovl: fix reference counting in ovl_mmap error path
Message-ID: <YIEwL09isbCIM82+@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu, dri-devel@lists.freedesktop.org,
        jgg@ziepe.ca, jaharkes@cs.cmu.edu, akpm@linux-foundation.org,
        miklos@szeredi.hu, coda@cs.cmu.edu
References: <20210421132012.82354-1-christian.koenig@amd.com>
 <20210421132012.82354-2-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210421132012.82354-2-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 03:20:12PM +0200, Christian König wrote:
> mmap_region() now calls fput() on the vma->vm_file.
> 
> Fix this by using vma_set_file() so it doesn't need to be
> handled manually here any more.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: 1527f926fd04 ("mm: mmap: fix fput in error path v2")
> CC: stable@vger.kernel.org # 5.11+
> ---
>  fs/overlayfs/file.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index dbfb35fb0ff7..3847cdc069b5 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -430,20 +430,11 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (WARN_ON(file != vma->vm_file))
>  		return -EIO;
>  
> -	vma->vm_file = get_file(realfile);
> +	vma_set_file(vma, realfile);

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  
>  	old_cred = ovl_override_creds(file_inode(file)->i_sb);
>  	ret = call_mmap(vma->vm_file, vma);
>  	revert_creds(old_cred);
> -
> -	if (ret) {
> -		/* Drop reference count from new vm_file value */
> -		fput(realfile);
> -	} else {
> -		/* Drop reference count from previous vm_file value */
> -		fput(file);
> -	}
> -
>  	ovl_file_accessed(file);
>  
>  	return ret;
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
