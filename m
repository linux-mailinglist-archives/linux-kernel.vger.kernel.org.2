Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADE7400174
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349135AbhICOrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhICOrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:47:05 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36CC061575;
        Fri,  3 Sep 2021 07:46:05 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id s3so9946927ljp.11;
        Fri, 03 Sep 2021 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iNqobfro7OKzCHlE+ueste6F4lAQYDNz3YZQNe0s7dU=;
        b=FbgW7NwtvajiLnGoaMmhlDH5/uBbf1qmObSH5E/hHzIFvyikRu51F1trXnepspUoJT
         yJb+hOYC81u7xYkr5eNzAZLLA+d4HPbjlfbNNESBDYuh3LfnihT8i/S/Y+eKIKDbhtf5
         g+8hsfPQ4gdjGurrJAWTspoUIPw6hcid2lOjQrmG2GInWQShCaHzXk5au3RUCmm3Vhkn
         nLzPCWHkqPkNZ7ynuGU6wD1Z5/aCfuMQqBCpHZoqVm/nCep7x6pcGU5pO9vjOhn0wqCk
         h109089zTIRx6o9hh4CFKQTfgg+4C8DM2iBnUaa1laUKDZJW/v2ajkSyJyM99n8/AEKs
         znGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iNqobfro7OKzCHlE+ueste6F4lAQYDNz3YZQNe0s7dU=;
        b=J0SNoTA5Tk/u+3Un9P19hjclpQneQyKEBRD93Hohql80OBHdh/wjgzEfFPqJq/khs0
         t8OjhfUJS17/jExioDb8f+Qg/0RwcX8gIXmJyUcqwqptuB51QnkNf20sbqsivnOq9Cu3
         Tr1z0cT5g0AbMatp45JVicZiokl9jAyYmxgkzY4vkYxpbijhWYNQxSqW+H7cdZ3u1lzY
         r3FCxlWZa+8huGgUYfu79YpWgMatlBgpZ8tnnIStITwtkHhWRFey/5OQGR58DdEo2yzf
         Fdj0Al1+wX0y/rOjL8zqPabVu/IPw1dyrg5xZQ5zA8Zm1j9v7PFA3r8KZ+rjYIl1NIk3
         MWdg==
X-Gm-Message-State: AOAM530nyFx9OOqs/2x3h4uzG9D4SBcZKaEYscCkgm4hCrmsYrA5EDEO
        etBJ42fFj4WkNdpceJXf+lpKAD9LgbeDcQ==
X-Google-Smtp-Source: ABdhPJy9LfCNoBvM62pq4as9H3XZW5V4z2XdwFa4/LA49+UUyWD8Gc9+AHU04fT21rTFWQ1hQAQ3mA==
X-Received: by 2002:a05:651c:54c:: with SMTP id q12mr3261368ljp.369.1630680363432;
        Fri, 03 Sep 2021 07:46:03 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id f20sm644300ljc.81.2021.09.03.07.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 07:46:02 -0700 (PDT)
Date:   Fri, 3 Sep 2021 17:46:01 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] fs/ntfs3: Remove redundant initialization of
 variable err
Message-ID: <20210903144601.jrqsjeaetxm3bcr3@kari-VirtualBox>
References: <20210903132458.14342-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903132458.14342-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021 at 02:24:58PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable err is being initialized with a value that is never read, it
> is being updated later on. The assignment is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

Please note Konstantin that you should not yet, put this to master. You
can collect these already, but if ntfs3 get merged to 5.15 we will start
start master again later. You could but these in example devel if you
want.

Then we also need branch just for bug fixes. Example this will have to
go to 5.16 because it is not bug fix. Our master is our for-next branch
so this will go there when time comes.

> ---
>  fs/ntfs3/index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 0daca9adc54c..b1175542d854 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1401,7 +1401,7 @@ int indx_find_raw(struct ntfs_index *indx, struct ntfs_inode *ni,
>  static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
>  				CLST *vbn)
>  {
> -	int err = -ENOMEM;
> +	int err;
>  	struct ntfs_sb_info *sbi = ni->mi.sbi;
>  	struct ATTRIB *bitmap;
>  	struct ATTRIB *alloc;
> -- 
> 2.32.0
> 
