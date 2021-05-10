Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59D8379365
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhEJQLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhEJQK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:10:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78ED96108B;
        Mon, 10 May 2021 16:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620662993;
        bh=OeMcOYr8TZ/o6MhIlP2/j3/CcS6n961yxSdIDXmvodI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+0D1TxUJGcewnlne7UdPyqxTkt+b4C6AX9EoG0X22OZvUHeaD3lh84zEHdt1dLkj
         545rmDbAAeHQCSl8/J/HvuBD54SFgIw+3t5pW1CdbIW3PK0xC+b/peCgTgfCyyh+mo
         N1bXUF1c2x3FEj76lGhK87BIFOWHbWn7a+diyBtz+4J3qzBsXew+OV7gmV2BpNeH/j
         4oPAQXlWgMszQJ5N2mMSGKUXwk3YX8aSNfhQ3bkVgv/x6GJVGQ6KycfStolZ3isX6O
         HppxZH5bznmqvzZNWhH+tmCZyPlAmV4kDxyqze2prsMT4qa90vViPYxp83dIC7lFlh
         Sc1weUMravF6g==
Date:   Mon, 10 May 2021 09:09:51 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/3] f2fs: compress: fix to assign cc.cluster_idx
 correctly
Message-ID: <YJlaz20Atq+TUnHu@google.com>
References: <20210510093032.35466-1-yuchao0@huawei.com>
 <20210510093032.35466-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510093032.35466-3-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10, Chao Yu wrote:
> In f2fs_destroy_compress_ctx(), after f2fs_destroy_compress_ctx(),
> cc.cluster_idx will be cleared w/ NULL_CLUSTER, f2fs_cluster_blocks()
> may check wrong cluster metadata, fix it.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 340815cd0887..30b003447510 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1066,6 +1066,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  			f2fs_put_rpages(cc);
>  			f2fs_unlock_rpages(cc, i + 1);
>  			f2fs_destroy_compress_ctx(cc);
> +			cc->cluster_idx = index >>
> +					F2FS_I(cc->inode)->i_log_cluster_size;

I didn't test tho, how about this?

From 904abb77e82ea982f68960148b75d0a12f771c2e Mon Sep 17 00:00:00 2001
From: Chao Yu <yuchao0@huawei.com>
Date: Mon, 10 May 2021 17:30:32 +0800
Subject: [PATCH] f2fs: compress: fix to assign cc.cluster_idx correctly

In f2fs_destroy_compress_ctx(), after f2fs_destroy_compress_ctx(),
cc.cluster_idx will be cleared w/ NULL_CLUSTER, f2fs_cluster_blocks()
may check wrong cluster metadata, fix it.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/compress.c | 17 +++++++++--------
 fs/f2fs/data.c     |  6 +++---
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 79348bc56e35..925a5ca3744a 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -145,13 +145,14 @@ int f2fs_init_compress_ctx(struct compress_ctx *cc)
 	return cc->rpages ? 0 : -ENOMEM;
 }
 
-void f2fs_destroy_compress_ctx(struct compress_ctx *cc)
+void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
 {
 	page_array_free(cc->inode, cc->rpages, cc->cluster_size);
 	cc->rpages = NULL;
 	cc->nr_rpages = 0;
 	cc->nr_cpages = 0;
-	cc->cluster_idx = NULL_CLUSTER;
+	if (!reuse)
+		cc->cluster_idx = NULL_CLUSTER;
 }
 
 void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page)
@@ -1034,7 +1035,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 		ret = f2fs_read_multi_pages(cc, &bio, cc->cluster_size,
 					&last_block_in_bio, false, true);
 		f2fs_put_rpages(cc);
-		f2fs_destroy_compress_ctx(cc);
+		f2fs_destroy_compress_ctx(cc, true);
 		if (ret)
 			goto out;
 		if (bio)
@@ -1061,7 +1062,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 release_and_retry:
 			f2fs_put_rpages(cc);
 			f2fs_unlock_rpages(cc, i + 1);
-			f2fs_destroy_compress_ctx(cc);
+			f2fs_destroy_compress_ctx(cc, true);
 			goto retry;
 		}
 	}
@@ -1094,7 +1095,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 unlock_pages:
 	f2fs_put_rpages(cc);
 	f2fs_unlock_rpages(cc, i);
-	f2fs_destroy_compress_ctx(cc);
+	f2fs_destroy_compress_ctx(cc, true);
 out:
 	return ret;
 }
@@ -1130,7 +1131,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 		set_cluster_dirty(&cc);
 
 	f2fs_put_rpages_wbc(&cc, NULL, false, 1);
-	f2fs_destroy_compress_ctx(&cc);
+	f2fs_destroy_compress_ctx(&cc, false);
 
 	return first_index;
 }
@@ -1350,7 +1351,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	f2fs_put_rpages(cc);
 	page_array_free(cc->inode, cc->cpages, cc->nr_cpages);
 	cc->cpages = NULL;
-	f2fs_destroy_compress_ctx(cc);
+	f2fs_destroy_compress_ctx(cc, false);
 	return 0;
 
 out_destroy_crypt:
@@ -1512,7 +1513,7 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 	err = f2fs_write_raw_pages(cc, submitted, wbc, io_type);
 	f2fs_put_rpages_wbc(cc, wbc, false, 0);
 destroy_out:
-	f2fs_destroy_compress_ctx(cc);
+	f2fs_destroy_compress_ctx(cc, false);
 	return err;
 }
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 96f1a354f89f..33e56ae84e35 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2287,7 +2287,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 							max_nr_pages,
 							&last_block_in_bio,
 							rac != NULL, false);
-				f2fs_destroy_compress_ctx(&cc);
+				f2fs_destroy_compress_ctx(&cc, false);
 				if (ret)
 					goto set_error_page;
 			}
@@ -2332,7 +2332,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 							max_nr_pages,
 							&last_block_in_bio,
 							rac != NULL, false);
-				f2fs_destroy_compress_ctx(&cc);
+				f2fs_destroy_compress_ctx(&cc, false);
 			}
 		}
 #endif
@@ -3033,7 +3033,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		}
 	}
 	if (f2fs_compressed_file(inode))
-		f2fs_destroy_compress_ctx(&cc);
+		f2fs_destroy_compress_ctx(&cc, false);
 #endif
 	if (retry) {
 		index = 0;
-- 
2.31.1.607.g51e8a6a459-goog


>  			goto retry;
>  		}
>  	}
> -- 
> 2.29.2
