Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF2378267
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhEJKfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231812AbhEJKbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:31:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 125AF61936;
        Mon, 10 May 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=5giq++LuKCXxL/BQ/69vufLPCq9f3cyBXLlXE0kLETU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAu58lxF7wN9fYjM1tMOj2ym3ygTuADYwLlenOFj3yJACRloMHDzUSHdvreErnZz3
         jw59TQ3/Mb0UyaVaiH38+AXps1BivXWg2BE9i/oJ+vBafnQSJWcZjZObb2csMrL11z
         oGhNWjyiCESxQ0Izbbd88T3krbW6scEVhFAX6u9S8dNdiyTgMP8bsSwe/rijHo/zBE
         lZRfRxmUOLiEYLcxthB1shSraGfxymY041dYGDA9fIgP414eT/DGqIpiY+/maoI16E
         6VD9bZNlckylKM3N14+RqKcm/+eewMXUlxgC+kdUpMGSr/11SlLI+fpa2h9ezqRIZy
         bLgzuQ0LnhODQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38E-000UQq-7E; Mon, 10 May 2021 12:27:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 39/53] docs: dev-tools: testing-overview.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:51 +0200
Message-Id: <1591224255d095d14ff3bc2bf4e7796dcc55c77d.1620641727.git.mchehab+huawei@kernel.org>
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

	- U+2014 ('—'): EM DASH

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/dev-tools/testing-overview.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index b5b46709969c..8adffc26a2ec 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -18,8 +18,8 @@ frameworks. These both provide infrastructure to help make running tests and
 groups of tests easier, as well as providing helpers to aid in writing new
 tests.
 
-If you're looking to verify the behaviour of the Kernel — particularly specific
-parts of the kernel — then you'll want to use KUnit or kselftest.
+If you're looking to verify the behaviour of the Kernel - particularly specific
+parts of the kernel - then you'll want to use KUnit or kselftest.
 
 
 The Difference Between KUnit and kselftest
-- 
2.30.2

