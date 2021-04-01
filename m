Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BB2351CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbhDASTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:19:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:16319 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbhDASAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:00:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FB53m2Wdgz9vBf;
        Thu,  1 Apr 2021 22:22:12 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 22:24:15 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <rostedt@goodmis.org>, <mingo@redhat.com>
Subject: [PATCH -next] iocost: remove redundant semi-colon
Date:   Thu, 1 Apr 2021 22:27:27 +0800
Message-ID: <20210401142727.1689300-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/trace/events/iocost.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index e282ce02fa2d..6d1626e7a4ce 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -160,7 +160,7 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 
 	TP_fast_assign(
 		__assign_str(devname, ioc_name(ioc));
-		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
+		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
 		__entry->new_vrate = new_vrate;
 		__entry->busy_level = ioc->busy_level;
 		__entry->read_missed_ppm = missed_ppm[READ];
-- 
2.25.1

