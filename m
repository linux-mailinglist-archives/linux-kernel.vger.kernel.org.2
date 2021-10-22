Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8DA437441
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 11:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhJVJFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 05:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232492AbhJVJFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 05:05:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D785610CB;
        Fri, 22 Oct 2021 09:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634893399;
        bh=wBt0RHWClbt72frsvbmUUSjVQ8XNDqz5p5C/hDX7wtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ojXlHThVutx6b4V1jCNTh267YZOd3P9koJV30EmyJ+B4Cs3djEnozI5jQvRlKzNnY
         gwzRGHiU81avWvnZwESJ2N+OwymDEOskbzj0491HcsVr0suEL6+xY4CFyCw3lOsmMq
         p5ndn7lHSWCHf+9rrB4BV4uqVSa0cmyqs4iayH3jejBRJeKr96LuxkbmjCXeACzpcS
         XYdLn3BRqAZ727SHdq24uNn6AI36FRAmnk37qyLNKrLhBkNdD/d5knT/XUZAG2iED2
         2x0uFHoINRLwwK93EwSkwpDKsgH8yXo35fQOM1bCSatDv7jcmXxJYLjwm+Fdll0CBz
         MYzjVMmWrJohg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     peterx@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/4] Docs/admin-guide/mm/damon/start: Fix a wrong link
Date:   Fri, 22 Oct 2021 09:03:09 +0000
Message-Id: <20211022090311.3856-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022090311.3856-1-sj@kernel.org>
References: <20211022090311.3856-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'Getting Started' of DAMON is providing a link to DAMON's user
interface document while saying about its user space tool's detailed
usages.  This commit fixes the link.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index 3ad8bbed9b18..5f3b22cafc76 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -6,7 +6,9 @@ Getting Started
 
 This document briefly describes how you can use DAMON by demonstrating its
 default user space tool.  Please note that this document describes only a part
-of its features for brevity.  Please refer to :doc:`usage` for more details.
+of its features for brevity.  Please refer to the usage `doc
+<https://github.com/awslabs/damo/blob/next/USAGE.md>`_ of the tool for more
+details.
 
 
 TL; DR
-- 
2.17.1

