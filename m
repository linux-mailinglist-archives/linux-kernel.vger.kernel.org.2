Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6D3B7E33
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhF3Hfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:35:43 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:30195 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhF3Hfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:35:42 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210630073312epoutp02587ecf1a3887ca6a2855f137f4db5bf5~NS87ifpWu1463014630epoutp023
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:33:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210630073312epoutp02587ecf1a3887ca6a2855f137f4db5bf5~NS87ifpWu1463014630epoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625038392;
        bh=kZD68hF5HfwSBBloxCZBL0CP/ddYm0s+HoovDVTMGPs=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=f/LHC7HgtqykRmlEriFRT7H/9fofoHyIetE1RZxDPAF/m2JE3xk0xa3bKbsebcMjW
         4UqpQhqUy4SSADNim6Chzp3BXRaqpzpZVKOVAbP4kW5UuWn5DJfGCcI3lO1pDw+AJf
         /oGQa3m6Foq706Pg9Kg8jJAb3Wwra294gyjRd60U=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210630073311epcas1p4ee79ed8378fa1dcd66ce6aa639d806e4~NS86xGvF52808028080epcas1p4c;
        Wed, 30 Jun 2021 07:33:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GFCkH0cyFz4x9Py; Wed, 30 Jun
        2021 07:33:11 +0000 (GMT)
X-AuditID: b6c32a35-447ff700000026e0-82-60dc1e3637b6
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.99.09952.63E1CD06; Wed, 30 Jun 2021 16:33:10 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] mm: cleancache: fix potential race in cleancache apis
Reply-To: ohoono.kwon@samsung.com
Sender: =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
From:   =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     =?UTF-8?B?6raM7Jik7ZuI?= <ohoono.kwon@samsung.com>,
        "ohkwon1043@gmail.com" <ohkwon1043@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
Date:   Wed, 30 Jun 2021 16:33:10 +0900
X-CMS-MailID: 20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQNdM7k6Cwb3HNhZz1q9hs2hevJ7N
        Ytnip4wWl3fNYbO4t+Y/q8Xe/b4Wu36uYHZg99g56y67x6ZPk9g9Tsz4zeKxf+4ado+PT2+x
        ePRtWcXo8XmTXAB7VI5NRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2S
        i0+ArltmDtA9SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCQ4MCveLE3OLSvHS9
        5PxcK0MDAyNToMqEnIwTD3vZCq4bVKxv+srewPhErYuRk0NCwETi8IRFjF2MXBxCAjsYJdbd
        62fuYuTg4BUQlPi7QxikRljATWLvpmMsIGEhAUWJbafdIMJWEtP6/jGB2GwCFhLP1/5kBbFF
        BNYySvybXAFiMwtcZZQ49FAfYhWvxIz2pywQtrTE9uVbGSFsUYmbq9+yw9jvj82HiotItN47
        ywxhC0o8+LkbKi4pcbPtLgvIyRIC/YwS99e1QDkTGCWWPJnEBlFlLvFsQwvYVF4BX4n9e/eD
        xVkEVCXufX0Dtc1FYtLrzawQl8pLbH87B+x3ZgFNifW7oI5WlNj5ey4jRAmfxLuvPawwz+yY
        94QJpFwCaOSy3x4wf/VNvwx1gYfE0SvfwO4XEgiUeLV6P/MERvlZiMCdhWTvLIS9CxiZVzGK
        pRYU56anFhsWGCLH5yZGcHLUMt3BOPHtB71DjEwcjIcYJTiYlUR4o3beThDiTUmsrEotyo8v
        Ks1JLT7EaAr08URmKdHkfGB6ziuJNzQ1MjY2tjAxMzczNVYS593JdihBSCA9sSQ1OzW1ILUI
        po+Jg1OqgYlV7LyZxqYP5vnRyavuzjT91epg+fTG0qA/p5vendLytL7/cOGio/rORX6HE/7v
        PD3j1eaulzF93z6ePLxrJ4fg+sq0C+ud7l1ZEaH1RzCTV2Z2XQO3t/bs/Tkb+2QqfKKcRXnt
        qha6PLKoTfLKvqXndsGBY9b0QwpCeSGZxTtlBBKfG+sVCV5XfbhJ/FK3aW1h9IZNG5NE1PvW
        fJRZkbphY9PMpVareRptTy1kUG394qy5JMzH76HdpopYh/leCYrbZ+us9go63tX3+diU7nV6
        r7fGyN1UX2WxKFLnq4hPzJTL/k51O778V3kRpOiVe+hMmkbLx+/u4W19knO9Gq9w6QkumBw5
        3YO37I3XZyWW4oxEQy3mouJEAKVKMeQXBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da
References: <CGME20210630073310epcms1p2ad6803cfd9dbc8ab501c4c99f799f4da@epcms1p2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current cleancache api implementation has potential race as follows,
which might lead to corruption in filesystems using cleancache.

thread 0                thread 1                        thread 2

                        in put_page
                        get pool_id K for fs1
invalidate_fs on fs1
frees pool_id K
                                                        init_fs for fs2
                                                        allocates pool_id K
                        put_page puts page
                        which belongs to fs1
                        into cleancache pool for fs2

At this point, a file cache which originally belongs to fs1 might be
copied back to cleancache pool of fs2, which might be later used as if
it were normal cleancache of fs2, and could eventually corrupt fs2 when
flushed back.

Add rwlock in order to synchronize invalidate_fs with other cleancache
operations.

In normal situations where filesystems are not frequently mounted or
unmounted, there will be little performance impact since
read_lock/read_unlock apis are used.

Signed-off-by: Ohhoon Kwon <ohoono.kwon@samsung.com>
---
 fs/super.c         |  1 +
 include/linux/fs.h |  1 +
 mm/cleancache.c    | 29 ++++++++++++++++++++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 11b7e7213fd1..6810b685490c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -261,6 +261,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
 	s->cleancache_poolid = CLEANCACHE_NO_POOL;
+	rwlock_init(&s->cleancache_pool_lock);
 
 	s->s_shrink.seeks = DEFAULT_SEEKS;
 	s->s_shrink.scan_objects = super_cache_scan;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c3c88fdb9b2a..f61008c9e8fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1501,6 +1501,7 @@ struct super_block {
 	 * Saved pool identifier for cleancache (-1 means none)
 	 */
 	int cleancache_poolid;
+	rwlock_t cleancache_pool_lock;
 
 	struct shrinker s_shrink;	/* per-sb shrinker handle */
 
diff --git a/mm/cleancache.c b/mm/cleancache.c
index db7eee9c0886..10b436a28219 100644
--- a/mm/cleancache.c
+++ b/mm/cleancache.c
@@ -114,12 +114,14 @@ void __cleancache_init_fs(struct super_block *sb)
 {
 	int pool_id = CLEANCACHE_NO_BACKEND;
 
+	write_lock(&sb->cleancache_pool_lock);
 	if (cleancache_ops) {
 		pool_id = cleancache_ops->init_fs(PAGE_SIZE);
 		if (pool_id < 0)
 			pool_id = CLEANCACHE_NO_POOL;
 	}
 	sb->cleancache_poolid = pool_id;
+	write_unlock(&sb->cleancache_pool_lock);
 }
 EXPORT_SYMBOL(__cleancache_init_fs);
 
@@ -128,12 +130,14 @@ void __cleancache_init_shared_fs(struct super_block *sb)
 {
 	int pool_id = CLEANCACHE_NO_BACKEND_SHARED;
 
+	write_lock(&sb->cleancache_pool_lock);
 	if (cleancache_ops) {
 		pool_id = cleancache_ops->init_shared_fs(&sb->s_uuid, PAGE_SIZE);
 		if (pool_id < 0)
 			pool_id = CLEANCACHE_NO_POOL;
 	}
 	sb->cleancache_poolid = pool_id;
+	write_unlock(&sb->cleancache_pool_lock);
 }
 EXPORT_SYMBOL(__cleancache_init_shared_fs);
 
@@ -185,6 +189,7 @@ int __cleancache_get_page(struct page *page)
 	}
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	read_lock(&page->mapping->host->i_sb->cleancache_pool_lock);
 	pool_id = page->mapping->host->i_sb->cleancache_poolid;
 	if (pool_id < 0)
 		goto out;
@@ -198,6 +203,7 @@ int __cleancache_get_page(struct page *page)
 	else
 		cleancache_failed_gets++;
 out:
+	read_unlock(&page->mapping->host->i_sb->cleancache_pool_lock);
 	return ret;
 }
 EXPORT_SYMBOL(__cleancache_get_page);
@@ -223,12 +229,14 @@ void __cleancache_put_page(struct page *page)
 	}
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	read_lock(&page->mapping->host->i_sb->cleancache_pool_lock);
 	pool_id = page->mapping->host->i_sb->cleancache_poolid;
 	if (pool_id >= 0 &&
 		cleancache_get_key(page->mapping->host, &key) >= 0) {
 		cleancache_ops->put_page(pool_id, key, page->index, page);
 		cleancache_puts++;
 	}
+	read_unlock(&page->mapping->host->i_sb->cleancache_pool_lock);
 }
 EXPORT_SYMBOL(__cleancache_put_page);
 
@@ -244,12 +252,15 @@ void __cleancache_invalidate_page(struct address_space *mapping,
 					struct page *page)
 {
 	/* careful... page->mapping is NULL sometimes when this is called */
-	int pool_id = mapping->host->i_sb->cleancache_poolid;
+	int pool_id;
 	struct cleancache_filekey key = { .u.key = { 0 } };
 
 	if (!cleancache_ops)
 		return;
 
+	read_lock(&mapping->host->i_sb->cleancache_pool_lock);
+	pool_id = mapping->host->i_sb->cleancache_poolid;
+
 	if (pool_id >= 0) {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		if (cleancache_get_key(mapping->host, &key) >= 0) {
@@ -258,6 +269,7 @@ void __cleancache_invalidate_page(struct address_space *mapping,
 			cleancache_invalidates++;
 		}
 	}
+	read_unlock(&mapping->host->i_sb->cleancache_pool_lock);
 }
 EXPORT_SYMBOL(__cleancache_invalidate_page);
 
@@ -272,14 +284,19 @@ EXPORT_SYMBOL(__cleancache_invalidate_page);
  */
 void __cleancache_invalidate_inode(struct address_space *mapping)
 {
-	int pool_id = mapping->host->i_sb->cleancache_poolid;
+	int pool_id;
 	struct cleancache_filekey key = { .u.key = { 0 } };
 
 	if (!cleancache_ops)
 		return;
 
+	read_lock(&mapping->host->i_sb->cleancache_pool_lock);
+	pool_id = mapping->host->i_sb->cleancache_poolid;
+
 	if (pool_id >= 0 && cleancache_get_key(mapping->host, &key) >= 0)
 		cleancache_ops->invalidate_inode(pool_id, key);
+
+	read_unlock(&mapping->host->i_sb->cleancache_pool_lock);
 }
 EXPORT_SYMBOL(__cleancache_invalidate_inode);
 
@@ -292,11 +309,17 @@ void __cleancache_invalidate_fs(struct super_block *sb)
 {
 	int pool_id;
 
+	if (!cleancache_ops)
+		return;
+
+	write_lock(&sb->cleancache_pool_lock);
 	pool_id = sb->cleancache_poolid;
 	sb->cleancache_poolid = CLEANCACHE_NO_POOL;
 
-	if (cleancache_ops && pool_id >= 0)
+	if (pool_id >= 0)
 		cleancache_ops->invalidate_fs(pool_id);
+
+	write_unlock(&sb->cleancache_pool_lock);
 }
 EXPORT_SYMBOL(__cleancache_invalidate_fs);
 
-- 
2.17.1
