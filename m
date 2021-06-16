Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64B3A9290
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbhFPGbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231668AbhFPG3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BF9661407;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=7MNCqS85WVptZyVwk3d3+gKYM21WbnTb9lCPgJ99vFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNY0CxWBJ00fEby9PA8XQQNfmQ0G7QwKkAxXC1bY9wqFjeJl+KZDw4MAYZV+xVAMa
         bAy/LeRiw5KveHxgdeZIbL7Ah1MzwuPuyJ5R+cuQKH2ySjPT9ix7fa1I9VCRNJzKff
         LzeRDSk/vwqBmXlYpODdKBkjPRtGlp6qY/9aYCX49LTikHZI/2k4GdgJFTf5YKu47F
         tYkcwq5IWEB2wEoBVAXeXdV/+UyuidZu8Ue6wEd7qjGJ80c2jn/ALKJOqZltMTsDin
         sFnvrT+5iv3k+Zmf6DfQANamYWeQwDZWYzk6f7HYAgodJJrC9gLZx7w6HfEvjsV1jf
         joXHby27TDmJw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kJW-RV; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Pater <02joepater06@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/29] docs: kernel-hacking: hacking.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:34 +0200
Message-Id: <9537b74d897fab13552535d79337060a3b241b8c.1623824363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623824363.git.mchehab+huawei@kernel.org>
References: <cover.1623824363.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The :doc:`foo` tag is auto-generated via automarkup.py.
So, use the filename at the sources, instead of :doc:`foo`.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/kernel-hacking/hacking.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
index 451523424942..df65c19aa7df 100644
--- a/Documentation/kernel-hacking/hacking.rst
+++ b/Documentation/kernel-hacking/hacking.rst
@@ -601,7 +601,7 @@ Defined in ``include/linux/export.h``
 
 This is the variant of `EXPORT_SYMBOL()` that allows specifying a symbol
 namespace. Symbol Namespaces are documented in
-:doc:`../core-api/symbol-namespaces`
+Documentation/core-api/symbol-namespaces.rst
 
 :c:func:`EXPORT_SYMBOL_NS_GPL()`
 --------------------------------
@@ -610,7 +610,7 @@ Defined in ``include/linux/export.h``
 
 This is the variant of `EXPORT_SYMBOL_GPL()` that allows specifying a symbol
 namespace. Symbol Namespaces are documented in
-:doc:`../core-api/symbol-namespaces`
+Documentation/core-api/symbol-namespaces.rst
 
 Routines and Conventions
 ========================
-- 
2.31.1

