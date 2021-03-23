Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD4F3455EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCWDG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:06:29 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:49940 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhCWDGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:06:10 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 790CA4002C9;
        Tue, 23 Mar 2021 11:06:06 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] mm/page_alloc: Duplicate include linux/vmalloc.h
Date:   Mon, 22 Mar 2021 20:05:51 -0700
Message-Id: <1616468751-80656-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGkxOSU9MHRoeQx1NVkpNSk1PTUNMTU1NT01VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxw6ESo4PD8JQzo4FgwYMA8O
        Nj0wCi1VSlVKTUpNT01DTE1MTkxNVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpJTU43Bg++
X-HM-Tid: 0a785d0bef6bd991kuws790ca4002c9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/vmalloc.h is repeatedly in the file page_alloc.c

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c53fe4f..5adf9c1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -72,8 +72,6 @@
 #include <linux/padata.h>
 #include <linux/khugepaged.h>
 #include <linux/buffer_head.h>
-#include <linux/vmalloc.h>
-
 #include <asm/sections.h>
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
-- 
2.7.4

