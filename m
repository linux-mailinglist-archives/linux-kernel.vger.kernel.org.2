Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567243FF152
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbhIBQ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:27:27 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:39221 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346171AbhIBQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:27:26 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 229E182139;
        Thu,  2 Sep 2021 19:26:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1630599987;
        bh=HtXc0ToNMP0KeKMCLl8V8/IXeJ7O/Wq5sp9TlfYLLJk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qDMfQwdLcLzXt/gJpxqRsSZwoY7dUkIIayaLpYxfjL/WyNIwC6qjZr4+h5/gwpe+i
         23bazWUHcdAfuzuC4Ahj3M21CJIXX+F/nBvdbncB5X0vsKdiN7/Vq73vDt8WYv8ZHB
         Zo0hrn3MuBB6jIJO0+cjOc7LR+6NTzFZd/90849E=
Received: from [192.168.211.59] (192.168.211.59) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 2 Sep 2021 19:26:26 +0300
Subject: Re: [PATCH] fs/ntfs3: Remove unnecessary condition checking from
 ntfs_file_read_iter
To:     Kari Argillander <kari.argillander@gmail.com>,
        <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210825182522.1367594-1-kari.argillander@gmail.com>
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Message-ID: <cfd1ba66-ba28-274e-bd5e-e8525020cdc0@paragon-software.com>
Date:   Thu, 2 Sep 2021 19:26:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825182522.1367594-1-kari.argillander@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.59]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.08.2021 21:25, Kari Argillander wrote:
> This check will be also performed in generic_file_read_iter() so we do
> not want to check this two times in a row.
> 
> This was founded with Smatch
> 	fs/ntfs3/file.c:803 ntfs_file_read_iter()
> 	warn: unused return: count = iov_iter_count()
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
> ---
> I cc Dan also because I am happy that I finally managed to install
> Smack and straight away I found something with it. Thank you for
> this great tool.
> 
> Next step is to integrate Smack to CI system. But will probanly take
> a moment.
> ---
>  fs/ntfs3/file.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index cb736701f2cc..5d41b84067ee 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -799,8 +799,6 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  
>  static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  {
> -	ssize_t err;
> -	size_t count = iov_iter_count(iter);
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file->f_mapping->host;
>  	struct ntfs_inode *ni = ntfs_i(inode);
> @@ -829,9 +827,7 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>  		return -EOPNOTSUPP;
>  	}
>  
> -	err = count ? generic_file_read_iter(iocb, iter) : 0;
> -
> -	return err;
> +	return generic_file_read_iter(iocb, iter);
>  }
>  
>  /* returns array of locked pages */
> 

Applied, thanks!
