Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6E3E3F42
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 07:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhHIFLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 01:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhHIFLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 01:11:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B8FC061764
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 22:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HLf8PoIJibroJH9ILzgnnI7TE136EGEXZWGHfBBEBaM=; b=j7vbNFeoK4N0dfWwEz7wmmgPPP
        6GAYlcYPd4gu96qorg0k3ZLunnKvrY7vRE4r9DRJqznPewKIRYqVqPWsI2MEylNYqYjxM8AsRHQyS
        OFJp23rEdxsUzGSX3JrlJuZQPyHWLVf+wwsD0LAHuJYaVJBKIiyDbVlmaMzU+3r8j5WHulo/Mg3Y7
        oxb+3lLjNIqVh6ZGW5y41lWqEvvdYjMfHUncyaVPIvGyYxQMCDBFE74NwJ26Ozu98Bz+UgyQ5d8xb
        GCsRN0BWb4vq4pxRDYDLJnoM+oIrv9NVVB/dmfnOKMlZ2ynNk7LaFNDa8ZJycywWEvHDSZ2IvxObD
        kEsTtvCg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCxYr-00H8jI-RU; Mon, 09 Aug 2021 05:10:54 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/iov_iter.c: fix kernel-doc warnings
Date:   Sun,  8 Aug 2021 22:10:53 -0700
Message-Id: <20210809051053.6531-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all kernel-doc warnings in lib/iov_iter.c:

lib/iov_iter.c:695: warning: Function parameter or member 'i' not described in '_copy_mc_to_iter'
lib/iov_iter.c:695: warning: Excess function parameter 'iter' description in '_copy_mc_to_iter'
lib/iov_iter.c:695: warning: No description found for return value of '_copy_mc_to_iter'
lib/iov_iter.c:758: warning: Function parameter or member 'i' not described in '_copy_from_iter_flushcache'
lib/iov_iter.c:758: warning: Excess function parameter 'iter' description in '_copy_from_iter_flushcache'
lib/iov_iter.c:758: warning: No description found for return value of '_copy_from_iter_flushcache'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/iov_iter.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-next-20210806.orig/lib/iov_iter.c
+++ linux-next-20210806/lib/iov_iter.c
@@ -672,7 +672,7 @@ static size_t copy_mc_pipe_to_iter(const
  * _copy_mc_to_iter - copy to iter with source memory error exception handling
  * @addr: source kernel address
  * @bytes: total transfer length
- * @iter: destination iterator
+ * @i: destination iterator
  *
  * The pmem driver deploys this for the dax operation
  * (dax_copy_to_iter()) for dax reads (bypass page-cache and the
@@ -690,6 +690,8 @@ static size_t copy_mc_pipe_to_iter(const
  * * ITER_KVEC, ITER_PIPE, and ITER_BVEC can return short copies.
  *   Compare to copy_to_iter() where only ITER_IOVEC attempts might return
  *   a short copy.
+ *
+ * Return: number of bytes copied (may be %0)
  */
 size_t _copy_mc_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -744,7 +746,7 @@ EXPORT_SYMBOL(_copy_from_iter_nocache);
  * _copy_from_iter_flushcache - write destination through cpu cache
  * @addr: destination kernel address
  * @bytes: total transfer length
- * @iter: source iterator
+ * @i: source iterator
  *
  * The pmem driver arranges for filesystem-dax to use this facility via
  * dax_copy_from_iter() for ensuring that writes to persistent memory
@@ -753,6 +755,8 @@ EXPORT_SYMBOL(_copy_from_iter_nocache);
  * all iterator types. The _copy_from_iter_nocache() only attempts to
  * bypass the cache for the ITER_IOVEC case, and on some archs may use
  * instructions that strand dirty-data in the cache.
+ *
+ * Return: number of bytes copied (may be %0)
  */
 size_t _copy_from_iter_flushcache(void *addr, size_t bytes, struct iov_iter *i)
 {
