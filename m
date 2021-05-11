Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BCB379C26
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhEKBjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:39:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:2620 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhEKBju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:39:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FfL9r42TpzkldC;
        Tue, 11 May 2021 09:36:32 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 11 May
 2021 09:38:38 +0800
Subject: Re: [PATCH 3/3] f2fs: compress: fix to assign cc.cluster_idx
 correctly
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20210510093032.35466-1-yuchao0@huawei.com>
 <20210510093032.35466-3-yuchao0@huawei.com> <YJlaz20Atq+TUnHu@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0b1ec8ef-6861-1fe9-16ac-bba6e673659a@huawei.com>
Date:   Tue, 11 May 2021 09:38:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YJlaz20Atq+TUnHu@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/11 0:09, Jaegeuk Kim wrote:
> On 05/10, Chao Yu wrote:
>> In f2fs_destroy_compress_ctx(), after f2fs_destroy_compress_ctx(),
>> cc.cluster_idx will be cleared w/ NULL_CLUSTER, f2fs_cluster_blocks()
>> may check wrong cluster metadata, fix it.
>>
>> Fixes: 4c8ff7095bef ("f2fs: support data compression")
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>   fs/f2fs/compress.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 340815cd0887..30b003447510 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -1066,6 +1066,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>>   			f2fs_put_rpages(cc);
>>   			f2fs_unlock_rpages(cc, i + 1);
>>   			f2fs_destroy_compress_ctx(cc);
>> +			cc->cluster_idx = index >>
>> +					F2FS_I(cc->inode)->i_log_cluster_size;
> 
> I didn't test tho, how about this?

Looks more clean. :)

Thanks,

> 
>>From 904abb77e82ea982f68960148b75d0a12f771c2e Mon Sep 17 00:00:00 2001
> From: Chao Yu <yuchao0@huawei.com>
> Date: Mon, 10 May 2021 17:30:32 +0800
> Subject: [PATCH] f2fs: compress: fix to assign cc.cluster_idx correctly
> 
> In f2fs_destroy_compress_ctx(), after f2fs_destroy_compress_ctx(),
> cc.cluster_idx will be cleared w/ NULL_CLUSTER, f2fs_cluster_blocks()
> may check wrong cluster metadata, fix it.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/compress.c | 17 +++++++++--------
>   fs/f2fs/data.c     |  6 +++---
>   2 files changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 79348bc56e35..925a5ca3744a 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -145,13 +145,14 @@ int f2fs_init_compress_ctx(struct compress_ctx *cc)
>   	return cc->rpages ? 0 : -ENOMEM;
>   }
>   
> -void f2fs_destroy_compress_ctx(struct compress_ctx *cc)
> +void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
>   {
>   	page_array_free(cc->inode, cc->rpages, cc->cluster_size);
>   	cc->rpages = NULL;
>   	cc->nr_rpages = 0;
>   	cc->nr_cpages = 0;
> -	cc->cluster_idx = NULL_CLUSTER;
> +	if (!reuse)
> +		cc->cluster_idx = NULL_CLUSTER;
>   }
>   
>   void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page)
> @@ -1034,7 +1035,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>   		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
>   					&last_block_in_bio, false, true);
>   		f2fs_put_rpages(cc);
> -		f2fs_destroy_compress_ctx(cc);
> +		f2fs_destroy_compress_ctx(cc, true);
>   		if (ret)
>   			goto out;
>   		if (bio)
> @@ -1061,7 +1062,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>   release_and_retry:
>   			f2fs_put_rpages(cc);
>   			f2fs_unlock_rpages(cc, i + 1);
> -			f2fs_destroy_compress_ctx(cc);
> +			f2fs_destroy_compress_ctx(cc, true);
>   			goto retry;
>   		}
>   	}
> @@ -1094,7 +1095,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>   unlock_pages:
>   	f2fs_put_rpages(cc);
>   	f2fs_unlock_rpages(cc, i);
> -	f2fs_destroy_compress_ctx(cc);
> +	f2fs_destroy_compress_ctx(cc, true);
>   out:
>   	return ret;
>   }
> @@ -1130,7 +1131,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
>   		set_cluster_dirty(&cc);
>   
>   	f2fs_put_rpages_wbc(&cc, NULL, false, 1);
> -	f2fs_destroy_compress_ctx(&cc);
> +	f2fs_destroy_compress_ctx(&cc, false);
>   
>   	return first_index;
>   }
> @@ -1350,7 +1351,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>   	f2fs_put_rpages(cc);
>   	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
>   	cc->cpages = NULL;
> -	f2fs_destroy_compress_ctx(cc);
> +	f2fs_destroy_compress_ctx(cc, false);
>   	return 0;
>   
>   out_destroy_crypt:
> @@ -1512,7 +1513,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
>   	err = f2fs_write_raw_pages(cc, submitted, wbc, io_type);
>   	f2fs_put_rpages_wbc(cc, wbc, false, 0);
>   destroy_out:
> -	f2fs_destroy_compress_ctx(cc);
> +	f2fs_destroy_compress_ctx(cc, false);
>   	return err;
>   }
>   
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 96f1a354f89f..33e56ae84e35 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2287,7 +2287,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>   							max_nr_pages,
>   							&last_block_in_bio,
>   							rac != NULL, false);
> -				f2fs_destroy_compress_ctx(&cc);
> +				f2fs_destroy_compress_ctx(&cc, false);
>   				if (ret)
>   					goto set_error_page;
>   			}
> @@ -2332,7 +2332,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
>   							max_nr_pages,
>   							&last_block_in_bio,
>   							rac != NULL, false);
> -				f2fs_destroy_compress_ctx(&cc);
> +				f2fs_destroy_compress_ctx(&cc, false);
>   			}
>   		}
>   #endif
> @@ -3033,7 +3033,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
>   		}
>   	}
>   	if (f2fs_compressed_file(inode))
> -		f2fs_destroy_compress_ctx(&cc);
> +		f2fs_destroy_compress_ctx(&cc, false);
>   #endif
>   	if (retry) {
>   		index = 0;
> 
