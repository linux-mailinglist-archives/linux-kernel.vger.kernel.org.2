Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E1B378257
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhEJKeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231725AbhEJKah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:30:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E21A061924;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=LBi6AhTmHaBJf1LFIsgL//SvYHB4PUd2G5MRXtVej0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCyF56VIOGbfiYm6M51T+I4vBnqU1hFicNzrM4aQv2G3Z1IdkE/NyP1N0yyOOMCjW
         l1H8mU8BZk3JLJM8jn0qvWIOKyIJr/PfXKhhAizOOIECFoJKv4JnByVuTcMccN44RZ
         bIb/SF+adKkO/YI7sbXBch3TV3ocoen0vk+h3JhsMMrumkmC5Y5esWe1MuzYbTJYOO
         1MrOXO+Oa5hgckDGV9hZnHWYFYEz25orhvwpw/dOkeajCgYr7cOExTrsp5J7QqqaLs
         GMu0J4RRv90HX/NKVdmFnKy7EKweauTlsD7ozaBG/+Yg6mHRbG9H9J6m+X8xHb7hLx
         GJbYLxOOWBb/w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UPg-B4; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 21/53] docs: process: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:33 +0200
Message-Id: <dc751a6524cd959cb2674bc34cbb53846f64b373.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK
	- U+feff ('﻿'): ZERO WIDTH NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/process/code-of-conduct.rst              | 2 +-
 Documentation/process/kernel-enforcement-statement.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/code-of-conduct.rst b/Documentation/process/code-of-conduct.rst
index be50294aebd5..2060834b9cee 100644
--- a/Documentation/process/code-of-conduct.rst
+++ b/Documentation/process/code-of-conduct.rst
@@ -32,7 +32,7 @@ Examples of unacceptable behavior by participants include:
   advances
 * Trolling, insulting/derogatory comments, and personal or political attacks
 * Public or private harassment
-* Publishing others’ private information, such as a physical or electronic
+* Publishing others' private information, such as a physical or electronic
   address, without explicit permission
 * Other conduct which could reasonably be considered inappropriate in a
   professional setting
diff --git a/Documentation/process/kernel-enforcement-statement.rst b/Documentation/process/kernel-enforcement-statement.rst
index e5a1be476047..dc2d813b2e79 100644
--- a/Documentation/process/kernel-enforcement-statement.rst
+++ b/Documentation/process/kernel-enforcement-statement.rst
@@ -1,4 +1,4 @@
-﻿.. _process_statement_kernel:
+.. _process_statement_kernel:
 
 Linux Kernel Enforcement Statement
 ----------------------------------
-- 
2.30.2

