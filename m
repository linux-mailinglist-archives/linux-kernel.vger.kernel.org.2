Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A72C3F9E49
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 19:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbhH0Rs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 13:48:29 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:39395 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236883AbhH0RsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:48:23 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 485D08221E;
        Fri, 27 Aug 2021 20:47:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630086448;
        bh=cQHGVALsR0wITXNG82rls7Ltz5TIhHWjctlfp9KdpL0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=laIFR4i5oregS0eTBrhg8j22S1NlqhDlfjJP0n0L+30rksGU3LS9A2uD0CQxcrLEe
         4Jy1rMkhIubwvkzpazqphNmVoTdsJ/TwQOQoTy+4KCZ97mRzqx33zzdDWGIdN/Hj+i
         TlgUuf738m/x5Rx0sVdjnIhBRI/r9xtgU+X6lF0I=
Received: from [192.168.211.135] (192.168.211.135) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 27 Aug 2021 20:47:27 +0300
Subject: Re: [PATCH 3/3] fs/ntfs3: Fix error handling in
 indx_insert_into_root()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <ntfs3@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20210824075103.GC13096@kili>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <a154fe47-8634-415c-2f53-8dcd3ee67665@paragon-software.com>
Date:   Fri, 27 Aug 2021 20:47:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210824075103.GC13096@kili>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.135]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.08.2021 10:51, Dan Carpenter wrote:
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
> ---
>  fs/ntfs3/index.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 489e0fffbc75..4f2d24010386 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c
> @@ -1554,12 +1554,12 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
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
>  		put_indx_node(n);
>  		fnd_clear(fnd);
>  		err = indx_insert_entry(indx, ni, new_de, ctx, fnd);
> -		goto out;
> +		goto out_free_root;
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
> 

Hi, Dan!

Applied all 3 patches, thanks!
