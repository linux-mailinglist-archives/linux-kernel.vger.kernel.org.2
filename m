Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5579E3A7408
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFOCgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:36:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4086 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhFOCg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:36:28 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G3rvm3Fn4zXfRK;
        Tue, 15 Jun 2021 09:53:56 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:58:55 +0800
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 09:58:55 +0800
Subject: Re: [PATCH -next] coda: Remove set but not used variable 'err'
To:     <jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>,
        <codalist@coda.cs.cmu.edu>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>
References: <20210527090510.3874315-1-libaokun1@huawei.com>
From:   "libaokun (A)" <libaokun1@huawei.com>
Message-ID: <a38d0254-f555-0aa0-6e3f-f549a137f171@huawei.com>
Date:   Tue, 15 Jun 2021 09:58:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210527090510.3874315-1-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

在 2021/5/27 17:05, Baokun Li 写道:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> fs/coda/file.c: In function 'coda_release':
> fs/coda/file.c:241:6: warning:
>   variable ‘err’ set but not used [-Wunused-but-set-variable]
>
> It never used since introduction.
>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>   fs/coda/file.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/coda/file.c b/fs/coda/file.c
> index ef5ca22bfb3e..98eb543d4acc 100644
> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -238,12 +238,11 @@ int coda_release(struct inode *coda_inode, struct file *coda_file)
>   	struct coda_file_info *cfi;
>   	struct coda_inode_info *cii;
>   	struct inode *host_inode;
> -	int err;
>   
>   	cfi = coda_ftoc(coda_file);
>   
> -	err = venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
> -			  coda_flags, coda_file->f_cred->fsuid);
> +	venus_close(coda_inode->i_sb, coda_i2f(coda_inode),
> +		    coda_flags, coda_file->f_cred->fsuid);
>   
>   	host_inode = file_inode(cfi->cfi_container);
>   	cii = ITOC(coda_inode);
