Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6206C3F5BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhHXKX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 06:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbhHXKX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2C0C061757;
        Tue, 24 Aug 2021 03:22:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j4so9517961lfg.9;
        Tue, 24 Aug 2021 03:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3W1xdoehyf4t4+YBmZDr+1dBA3rDa3UkltsorCMol7k=;
        b=ddnCZOAS3Wo8OipZfYJJuvS2YXvmHX+Cdn78WN4kJM+plWe+dGDDJNW4C3uBOfl8b7
         6itn+dB8ZjqkQGlFTo2nABgJUki15P+L/qFOXKfO1kOK6CBr0cgArav5zkVBbpuvldxJ
         7ZeTy5NCb0H4YVq+23RGtSFnUyZdEpKpFJ48W7fhEu/27NbUwgIh4xFcEFki2yoJ1F9g
         z6RfuPtwW5Hg1fQGQzhjkhuuaA8ypdmhV3b1Uc6NeQNEvA1PzCuecNb5tioTs7ED/uDC
         w6IRWdTEvms2fHwOIhs+/z+CymZIDsNr5UgeFaYLLliAzCj3S8cr5yZ/XjFEFEe+wU6f
         dCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3W1xdoehyf4t4+YBmZDr+1dBA3rDa3UkltsorCMol7k=;
        b=fLAzdjlGjbxD98cu8nMQcCzT+CEEBBZ2whifuMhaslbODsOZLe3auvqz1H3rxdRlBH
         LsoQb2TnpFoMKHeki2sHyg6wS7Oxyr6gYUurypoufMO+oZGzaw/O9LLaHcJM62F1Hx6B
         eQC1iFiZ+CVd348ikJ7t8w+9meYl3GDEl/wQP4trtE1eQWa2wT1W6vIM5wISfg/tKT4i
         fjNDCRhDTW80mEa83Jxeuierq+RciTP5WTrbCo9dU2nyqdtr51xQ2CYG7UiEsbLoH9I1
         K6FycjYQVsFPvygoxGy3Rz/Ym6Hi9SRPNoXurRpLP7KEPmaHnueOIP9toQdP6zdHoHiO
         SETQ==
X-Gm-Message-State: AOAM531XrT3zZxNXkQG532Bn11a0PMdv/SSd7/rHizbHusH+9bIkQfJE
        kVDQdD5ttvu3M7DDsSZFQ34=
X-Google-Smtp-Source: ABdhPJw3pCLmmDVNHPZK0n8tNAg+seiilW+FZe41WVWztfBf1SQVLyGtYmvruA6jBEQUYCu7cIm0Bg==
X-Received: by 2002:a05:6512:358c:: with SMTP id m12mr8884498lfr.413.1629800560906;
        Tue, 24 Aug 2021 03:22:40 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id y35sm478697lfa.107.2021.08.24.03.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 03:22:40 -0700 (PDT)
Date:   Tue, 24 Aug 2021 13:22:38 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] fs/ntfs3: Fix error handling in
 indx_insert_into_root()
Message-ID: <20210824102238.a73zhglpqsj5xnf5@kari-VirtualBox>
References: <20210824074932.GA13096@kili>
 <20210824075103.GC13096@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824075103.GC13096@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:51:04AM +0300, Dan Carpenter wrote:
> There are three bugs in this code:
> 1) If indx_get_root() fails, then return -EINVAL instead of success.
> 2) On the "/* make root external */" -EOPNOTSUPP; error path it should
>    free "re" but it has a memory leak.
> 3) If indx_new() fails then it will lead to an error pointer dereference
>    when we call put_indx_node().
> 
> I've re-written the error handling to be more clear.
> 
> Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Minor things in comments. With or without they being made:

Reviewed-by: Kari Argillander <kari.argillander@gmail.com>

> ---
>  fs/ntfs3/index.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 489e0fffbc75..4f2d24010386 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1554,12 +1554,12 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,


	int err = 0;

No need to initiliaze err anymore.

>  	u32 root_size, new_root_size;
>  	struct ntfs_sb_info *sbi;
>  	int ds_root;
> -	struct INDEX_ROOT *root, *a_root = NULL;
> +	struct INDEX_ROOT *root, *a_root;
>  
>  	/* Get the record this root placed in */
>  	root = indx_get_root(indx, ni, &attr, &mi);
>  	if (!root)
> -		goto out;
> +		return -EINVAL;
>  
>  	/*
>  	 * Try easy case:
> @@ -1591,10 +1591,8 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  
>  	/* Make a copy of root attribute to restore if error */
>  	a_root = ntfs_memdup(attr, asize);
> -	if (!a_root) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	if (!a_root)
> +		return -ENOMEM;

a_root could be moved little further but maybe it makes sense to live
here. Not effecting your patch but I wonder if attr should be restored
in more situatations. attr is restored only in one place. But you do
not have to check any of this if not intrested. Just thinking out loud
here.

>  
>  	/* copy all the non-end entries from the index root to the new buffer.*/
>  	to_move = 0;
> @@ -1604,7 +1602,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	for (e = e0;; e = hdr_next_de(hdr, e)) {
>  		if (!e) {
>  			err = -EINVAL;
> -			goto out;
> +			goto out_free_root;
>  		}
>  
>  		if (de_is_last(e))
> @@ -1612,14 +1610,13 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		to_move += le16_to_cpu(e->size);
>  	}
>  
> -	n = NULL;
>  	if (!to_move) {
>  		re = NULL;
>  	} else {
>  		re = ntfs_memdup(e0, to_move);
>  		if (!re) {
>  			err = -ENOMEM;
> -			goto out;
> +			goto out_free_root;
>  		}
>  	}
>  
> @@ -1636,7 +1633,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	if (ds_root > 0 && used + ds_root > sbi->max_bytes_per_attr) {
>  		/* make root external */
>  		err = -EOPNOTSUPP;
> -		goto out;
> +		goto out_free_re;
>  	}
>  
>  	if (ds_root)
> @@ -1666,7 +1663,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  		/* bug? */
>  		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
>  		err = -EINVAL;
> -		goto out1;
> +		goto out_free_re;
>  	}
>  
>  	if (err) {
> @@ -1677,7 +1674,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  			/* bug? */
>  			ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
>  		}
> -		goto out1;
> +		goto out_free_re;
>  	}
>  
>  	e = (struct NTFS_DE *)(root + 1);
> @@ -1688,7 +1685,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	n = indx_new(indx, ni, new_vbn, sub_vbn);
>  	if (IS_ERR(n)) {
>  		err = PTR_ERR(n);
> -		goto out1;
> +		goto out_free_re;
>  	}
>  
>  	hdr = &n->index->ihdr;
> @@ -1715,7 +1712,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,


		ntfs_free(re);

Take this off

>  		put_indx_node(n);

and this off

>  		fnd_clear(fnd);
>  		err = indx_insert_entry(indx, ni, new_de, ctx, fnd);
> -		goto out;
> +		goto out_free_root;

and call out_put_n here. Right?

>  	}
>  
>  	/*
> @@ -1725,7 +1722,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  	e = hdr_insert_de(indx, hdr, new_de, NULL, ctx);
>  	if (!e) {
>  		err = -EINVAL;
> -		goto out1;
> +		goto out_put_n;
>  	}
>  	fnd_push(fnd, n, e);
>  
> @@ -1734,12 +1731,11 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
>  
>  	n = NULL;
>  
> -out1:
> +out_put_n:
> +	put_indx_node(n);
> +out_free_re:
>  	ntfs_free(re);
> -	if (n)
> -		put_indx_node(n);
> -
> -out:
> +out_free_root:
>  	ntfs_free(a_root);
>  	return err;
>  }

Overall lot cleaner now. Thanks.

> -- 
> 2.20.1
> 
> 
