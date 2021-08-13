Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7C53EAE0D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 03:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238034AbhHMBJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 21:09:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233641AbhHMBJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 21:09:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DEC960EE5;
        Fri, 13 Aug 2021 01:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628816925;
        bh=cZnNtsiOMmc0YunlGSU9luW8T3Bv8V4gCes8aen3ifY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ELnzOUixwczaEi1gRSz+1oQ0nz66qYjwy+ojdpwNq1n1/kRljnWHW0OMH/UeSiuzk
         UQPVuyshpIceQmmAgubQflRDYx+6lnNpfoLEvckeygqz+pLt5uruNOegJvcN1SwcmJ
         8/AdkdtXMR02REXHmK5QEFJv3AX1dS7XSFXQBUOylI73jp8evNrhHO/wZ+W6i0Rtpu
         zMWxDQqoQO/dKm2nQ/hgDrnbFWL7prESJV8Tyib/yzfFsChHyA6AbdBV/Nl4/NH54u
         Nl2XuyZOypfpwhqioErLrtVVt3Tr6mMZQ9E74rVfvRx+v7QE0IKdTfqdY00zsDwiXj
         YkK12EbVhtkdA==
Subject: Re: [PATCH v2] f2fs: compress: do sanity check on cluster
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
References: <20210806000250.39728-1-chao@kernel.org>
 <YRWJan4JTXHN3RFr@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <f957a9a4-8c59-2df7-147a-1cd5887246e8@kernel.org>
Date:   Fri, 13 Aug 2021 09:08:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRWJan4JTXHN3RFr@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/13 4:49, Jaegeuk Kim wrote:
> On 08/06, Chao Yu wrote:
>> This patch adds f2fs_sanity_check_cluster() to support doing
>> sanity check on cluster of compressed file, it will be triggered
>> from below two paths:
>>
>> - __f2fs_cluster_blocks()
>> - f2fs_map_blocks(F2FS_GET_BLOCK_FIEMAP)
>>
>> And it can detect below three kind of cluster insanity status.
>>
>> C: COMPRESS_ADDR
>> N: NULL_ADDR or NEW_ADDR
>> V: valid blkaddr
>> *: any value
>>
>> 1. [*|C|*|*]
>> 2. [C|*|C|*]
>> 3. [C|N|N|V]
>>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> v2:
>> - cover all map_block cases
>> - give EFSCORRUPTED only when CHECK_FS is enabled for fiemap()
>>   fs/f2fs/compress.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/f2fs/data.c     |  9 ++++++++
>>   fs/f2fs/f2fs.h     |  1 +
>>   3 files changed, 63 insertions(+)
>>
>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>> index 7dbfd6965b97..f25b32a6893a 100644
>> --- a/fs/f2fs/compress.c
>> +++ b/fs/f2fs/compress.c
>> @@ -898,6 +898,54 @@ static bool cluster_has_invalid_data(struct compress_ctx *cc)
>>   	return false;
>>   }
>>   
>> +bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
>> +{
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
>> +	unsigned int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
>> +	bool compressed = dn->data_blkaddr == COMPRESS_ADDR;
>> +	int cluster_end = 0;
>> +	int i;
>> +	char *reason = "";
>> +
>> +	if (!compressed)
>> +		return false;
>> +
>> +	/* [..., COMPR_ADDR, ...] */
>> +	if (dn->ofs_in_node % cluster_size) {
>> +		reason = "[*|C|*|*]";
>> +		goto out;
>> +	}
>> +
>> +	for (i = 1; i < cluster_size; i++) {
>> +		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
>> +							dn->ofs_in_node + i);
>> +
>> +		/* [COMPR_ADDR, ..., COMPR_ADDR] */
>> +		if (blkaddr == COMPRESS_ADDR) {
>> +			reason = "[C|*|C|*]";
>> +			goto out;
>> +		}
>> +		if (compressed) {
>> +			if (!__is_valid_data_blkaddr(blkaddr)) {
>> +				if (!cluster_end)
>> +					cluster_end = i;
>> +				continue;
>> +			}
>> +			/* [COMPR_ADDR, NULL_ADDR or NEW_ADDR, valid_blkaddr] */
>> +			if (cluster_end) {
>> +				reason = "[C|N|N|V]";
>> +				goto out;
>> +			}
>> +		}
>> +	}
>> +	return false;
>> +out:
>> +	f2fs_warn(sbi, "access invalid cluster, ino:%lu, nid:%u, ofs_in_node:%u, reason:%s",
>> +			dn->inode->i_ino, dn->nid, dn->ofs_in_node, reason);
>> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
>> +	return true;
>> +}
>> +
>>   static int __f2fs_cluster_blocks(struct inode *inode,
>>   				unsigned int cluster_idx, bool compr)
>>   {
>> @@ -915,6 +963,11 @@ static int __f2fs_cluster_blocks(struct inode *inode,
>>   		goto fail;
>>   	}
>>   
>> +	if (f2fs_sanity_check_cluster(&dn)) {
>> +		ret = -EFSCORRUPTED;
>> +		goto fail;
>> +	}
>> +
>>   	if (dn.data_blkaddr == COMPRESS_ADDR) {
>>   		int i;
>>   
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index df5e8d8c654e..d4c9aeba0842 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -1552,6 +1552,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>>   			map->m_flags |= F2FS_MAP_NEW;
>>   			blkaddr = dn.data_blkaddr;
>>   		} else {
>> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> 
> I tried to remove ifdef. Please check f2fs/dev branch.

It's fine to me.

Thanks,

> 
>> +			if (f2fs_compressed_file(inode) &&
>> +					f2fs_sanity_check_cluster(&dn) &&
>> +					(flag != F2FS_GET_BLOCK_FIEMAP ||
>> +					IS_ENABLED(CONFIG_F2FS_CHECK_FS))) {
>> +				err = -EFSCORRUPTED;
>> +				goto sync_out;
>> +			}
>> +#endif
>>   			if (flag == F2FS_GET_BLOCK_BMAP) {
>>   				map->m_pblk = 0;
>>   				goto sync_out;
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index e97b4d8c5efc..3b368bcbc4d7 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -4074,6 +4074,7 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
>>   							block_t blkaddr);
>>   bool f2fs_cluster_is_empty(struct compress_ctx *cc);
>>   bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
>> +bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
>>   void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
>>   int f2fs_write_multi_pages(struct compress_ctx *cc,
>>   						int *submitted,
>> -- 
>> 2.22.1
