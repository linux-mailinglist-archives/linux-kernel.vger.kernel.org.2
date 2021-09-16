Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E21040DF06
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbhIPQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 12:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240563AbhIPQF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 12:05:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D67A61251;
        Thu, 16 Sep 2021 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631808246;
        bh=N18S5Tvi29WFXYbMLSY9EpfDhlRStKbfYDG3j4ASmK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nk476Fsjs4BjF60m0On60bzrFQpTORnj/jGrf9EngKHDqRBiQqK0VwlrdtIUB6FnW
         I2DlxwfHFchArI7FpR3h5KioCIxYe7LxQP406tIqLu5heQdbOQLs3Q8NHfc/u4kIE4
         HMXxpE63hIsvXgQKr7zgSV53GzfoZOPB6IjEzSxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.10 015/306] ceph: fix dereference of null pointer cf
Date:   Thu, 16 Sep 2021 17:56:00 +0200
Message-Id: <20210916155754.443185441@linuxfoundation.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916155753.903069397@linuxfoundation.org>
References: <20210916155753.903069397@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 05a444d3f90a3c3e6362e88a1bf13e1a60f8cace upstream.

Currently in the case where kmem_cache_alloc fails the null pointer
cf is dereferenced when assigning cf->is_capsnap = false. Fix this
by adding a null pointer check and return path.

Cc: stable@vger.kernel.org
Addresses-Coverity: ("Dereference null return")
Fixes: b2f9fa1f3bd8 ("ceph: correctly handle releasing an embedded cap flush")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/caps.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1755,6 +1755,9 @@ struct ceph_cap_flush *ceph_alloc_cap_fl
 	struct ceph_cap_flush *cf;
 
 	cf = kmem_cache_alloc(ceph_cap_flush_cachep, GFP_KERNEL);
+	if (!cf)
+		return NULL;
+
 	cf->is_capsnap = false;
 	return cf;
 }


