Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77353D740E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhG0LLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 07:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235837AbhG0LLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 07:11:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A074619E3;
        Tue, 27 Jul 2021 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627384302;
        bh=nLjsVAhgwlSBCitmpN1IJ3bBHD3/LEZ6ErBjEHj2UQw=;
        h=From:To:Cc:Subject:Date:From;
        b=s6xDQ0oL5EWAtn4dknetElPbNaqnWbE3OLRM2RXVr9HiiKkdRlyBQpxVKs+V/GWiV
         N6niSIpgS8PVUhJ6KfNEVFVAOYhP+JqcLWBZqJ22EVxqalfP4/KV4vEtTYauVVSqd2
         wStzCadeDRfnG2mPzAcrpZK2pE26PjIfeV+IFKqI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     willy@infradead.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jordy Zomer <jordy@pwning.systems>,
        David Howells <dhowells@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] mm: change fault_in_pages_* to have an unsigned size parameter
Date:   Tue, 27 Jul 2021 13:11:36 +0200
Message-Id: <20210727111136.457638-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776; h=from:subject; bh=nLjsVAhgwlSBCitmpN1IJ3bBHD3/LEZ6ErBjEHj2UQw=; b=owGbwMvMwCRo6H6F97bub03G02pJDAn/Xz7Tj+Sbt3ZNnPGjct+/N4tP1DwsT+49WXmcbZ/qOpc1 p/YIdcSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBEovgYFjR875v86eZhj9IbxmsvH1 R0brk4r41hfoSvQIv9lsf7V2WcMrOYcK3xls23EwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fault_in_pages_writeable() and fault_in_pages_readable() treat the size
parameter as unsigned, doing pointer math with the value, so make this
explicit and set it to be a size_t type which all callers currently
treat it as anyway.

This solves the issue where static checkers get nervous seeing pointer
arithmetic happening with a signed value.

Reported-by: Jordy Zomer <jordy@pwning.systems>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>
Cc: William Kucharski <william.kucharski@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/pagemap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ed02aa522263..5dcf446f42e5 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -736,7 +736,7 @@ extern void add_page_wait_queue(struct page *page, wait_queue_entry_t *waiter);
 /*
  * Fault everything in given userspace address range in.
  */
-static inline int fault_in_pages_writeable(char __user *uaddr, int size)
+static inline int fault_in_pages_writeable(char __user *uaddr, size_t size)
 {
 	char __user *end = uaddr + size - 1;
 
@@ -763,7 +763,7 @@ static inline int fault_in_pages_writeable(char __user *uaddr, int size)
 	return 0;
 }
 
-static inline int fault_in_pages_readable(const char __user *uaddr, int size)
+static inline int fault_in_pages_readable(const char __user *uaddr, size_t size)
 {
 	volatile char c;
 	const char __user *end = uaddr + size - 1;
-- 
2.32.0

