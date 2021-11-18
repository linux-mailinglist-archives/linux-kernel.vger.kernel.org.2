Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C5456207
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 19:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhKRSOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 13:14:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46691 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234327AbhKRSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 13:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637259095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gtO9f9wMH7XMAgr69Sqq/ALOOvo4PzU6z/sVRo8aNSU=;
        b=FIOTKiJOev7kWamQFSRoxW/hJ3tFacJ1nRlEFgOqcehObcnPIaTtnzIV+vi8HYEYeBeiwm
        gf4OaK+f6TUmKYQT0Ed4jj4dMoXhIx3SB67dx0BAcs7EZ2gZSX0RqRanHDvyW2pHPE6S+w
        ++LYUEEJRHgOA2RLxbQIXW5P5x0jxfA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-ybRe6V3oPH678MpH4akbJA-1; Thu, 18 Nov 2021 13:11:32 -0500
X-MC-Unique: ybRe6V3oPH678MpH4akbJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4F3F1006AA1;
        Thu, 18 Nov 2021 18:11:30 +0000 (UTC)
Received: from dqiao.bos.com (unknown [10.22.10.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C28F760BF1;
        Thu, 18 Nov 2021 18:11:29 +0000 (UTC)
From:   Donghai Qiao <dqiao@redhat.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, guro@fb.com,
        dqiao@redhat.com
Subject: [PATCH] mm/page_counter: remove an incorrect call to propagate_protected_usage()
Date:   Thu, 18 Nov 2021 13:11:25 -0500
Message-Id: <20211118181125.3918222-1-dqiao@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function propagate_protected_usage() is called to propagate the usage
change in the page_counter structure. But there is call to this function
from page_counter_try_charge() when there is actually no usage change.
Hence this call should be removed.

Signed-off-by: Donghai Qiao <dqiao@redhat.com>
---
 mm/page_counter.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index 7d83641eb86b..eb156ff5d603 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -120,7 +120,6 @@ bool page_counter_try_charge(struct page_counter *counter,
 		new = atomic_long_add_return(nr_pages, &c->usage);
 		if (new > c->max) {
 			atomic_long_sub(nr_pages, &c->usage);
-			propagate_protected_usage(c, new);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt which is only used
-- 
2.27.0

