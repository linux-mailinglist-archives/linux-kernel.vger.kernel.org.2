Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8050354338
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241470AbhDEPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241483AbhDEPOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:14:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86330613B5;
        Mon,  5 Apr 2021 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617635646;
        bh=zRfiGdxaxGKhC+P8+qCZ7/d+Qo78jzl5Bn4x91UWe/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jraADJMs/I45gvQDGfWMvfie21JUkhPVGkukgtl/dIpde3R6Qoa7c3yaBm3a75W5M
         5HWmcm8xDqRhANlgS1CLUzcYcqpRwpqDONQjA070L7di4l57Q1NPv3BghN6DYbHmdf
         6s8dj1NboFmBPARzvBaZv0jS7X3R7n3CaoxnSU0hLhuDL0RFHn44BGQ3Kw1t+8V2gl
         SwYRpUKaZEvhQ5BUDOQq+FBVTDs8cMM63WktunFMJCQs58/pQJ8YwG8vrb3j7d5M88
         yxWw2JyJ2z5uiF6ScTpGDoi6uh2lFUkc36k1K6ZtBkSje8hWPcAxhhC2LmPgvnB2ds
         STdBHhGnMqlzA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] include/linux/mm.h: remove duplicated declaration of page_mapping()
Date:   Mon,  5 Apr 2021 18:13:55 +0300
Message-Id: <20210405151355.9867-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210405151355.9867-1-rppt@kernel.org>
References: <20210405151355.9867-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There are two declarations of page_mapping() in include/linux/mm.h a dozen
lines apart.

Remove the older one with unnecessary "extern".

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 74a05dbdcc19..d831ca0fcfa1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1619,8 +1619,6 @@ void page_address_init(void);
 #define page_address_init()  do { } while(0)
 #endif
 
-extern struct address_space *page_mapping(struct page *page);
-
 extern struct address_space *__page_file_mapping(struct page *);
 
 static inline
-- 
2.28.0

