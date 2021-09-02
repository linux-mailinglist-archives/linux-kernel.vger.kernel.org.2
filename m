Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314103FF149
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346141AbhIBQYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:24:47 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:46678 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345998AbhIBQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:24:46 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id D5B5E1D99;
        Thu,  2 Sep 2021 19:23:46 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630599826;
        bh=Ww11h+RqvvW0Iq61oMI/lISDSXkK62zLJ93tmQ65jEY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jSVGSMhMduReMykkJZ6OHHyRFffjSs2Qwxa3mZfSZMyStbaA5LrANd+o0+SOrv43/
         x72czLV9plqMZYKAptKMtDJeIk17qrlgGHXwh7MncFAr7i5h2L0WAf0+XUNwUB8PBj
         m9zYDacpnrtp3POPJAj3TkOvLs1O3tLIqbUDnSDM=
Received: from [192.168.211.59] (192.168.211.59) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 2 Sep 2021 19:23:46 +0300
Subject: Re: [PATCH] fs/ntfs3: Fix integer overflow in ni_fiemap with
 fiemap_prep()
To:     Kari Argillander <kari.argillander@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <ntfs3@lists.linux.dev>
References: <20210825182435.1367530-1-kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <a0ada3ee-3666-17c4-bb4c-12c29121fc54@paragon-software.com>
Date:   Thu, 2 Sep 2021 19:23:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825182435.1367530-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.59]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.2021 21:24, Kari Argillander wrote:
> Use fiemap_prep() to check valid flags. It also shrink request scope
> (@len) to what the fs can actually handle.
> 
> This address following Smatch static checker warning:
> 	fs/ntfs3/frecord.c:1894 ni_fiemap()
> 	warn: potential integer overflow from user 'vbo + len'
> 
> Because fiemap_prep() shrinks @len this cannot happened anymore.
> 
> Reported-by Dan Carpenter <dan.carpenter@oracle.com>
> Link: lore.kernel.org/ntfs3/20210825080440.GA17407@kili/
> 
> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
>  fs/ntfs3/file.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 59344985c2e8..cb736701f2cc 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -1210,8 +1210,9 @@ int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	int err;
>  	struct ntfs_inode *ni = ntfs_i(inode);
>  
> -	if (fieinfo->fi_flags & FIEMAP_FLAG_XATTR)
> -		return -EOPNOTSUPP;
> +	err = fiemap_prep(inode, fieinfo, start, &len, ~FIEMAP_FLAG_XATTR);
> +	if (err)
> +		return err;
>  
>  	ni_lock(ni);
>  
> 

Hello, Dan, Kari!

Thanks for finding and fixing this issue. Applied patch.
