Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99D337BD52
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhELMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhELMwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9493C61438;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=Y2KVSxhah3pojp2XuakMiwzKqgZbNRAw0zXzRSJpvvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/eh0swUcaAz1kqzhgKEw75AMmPAfN3iPD4acrzPAhOvdBZdNUf4sO13OxNcy2TwM
         68hy1tqLakl4jCC5Ehu+rrIN+fjnHhpZatRWZFMgfB3Yls4xMsa6CIz/kEFn4io0gh
         e7xuhZKIp3gg5qtKH5KFrBvXk2Co1EkPV1xvzbNNd733VyGFnIoZLlk0xTmMsUD0xv
         3NiSR2ZYZoThD/49f1bEuHlTfgu5ve0jsSuuYvqH2Izj6+26/TtHQ9t55ZEVJAm3Ws
         EJYWXOOci7B1wPAC+Vp9C6jReqf4f1NH8BkqnakJ0LaA63sHisfaUN6K2l9pfR+umI
         LhMKQby1CVSMQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018ht-Oc; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/40] docs: vm: zswap.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:21 +0200
Message-Id: <fdcde66462ff29d6ee3d80e191b48091fd1e8bda.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

So, replace the occurences of the following UTF-8 characters:

	- U+00a0 (' '): NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/vm/zswap.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/zswap.rst b/Documentation/vm/zswap.rst
index d8d9fa4a1f0d..8edb8d578caf 100644
--- a/Documentation/vm/zswap.rst
+++ b/Documentation/vm/zswap.rst
@@ -10,7 +10,7 @@ Overview
 Zswap is a lightweight compressed cache for swap pages. It takes pages that are
 in the process of being swapped out and attempts to compress them into a
 dynamically allocated RAM-based memory pool.  zswap basically trades CPU cycles
-for potentially reduced swap I/O.  This trade-off can also result in a
+for potentially reduced swap I/O.  This trade-off can also result in a
 significant performance improvement if reads from the compressed cache are
 faster than reads from a swap device.
 
@@ -26,7 +26,7 @@ faster than reads from a swap device.
   performance impact of swapping.
 * Overcommitted guests that share a common I/O resource can
   dramatically reduce their swap I/O pressure, avoiding heavy handed I/O
-  throttling by the hypervisor. This allows more work to get done with less
+  throttling by the hypervisor. This allows more work to get done with less
   impact to the guest workload and guests sharing the I/O subsystem
 * Users with SSDs as swap devices can extend the life of the device by
   drastically reducing life-shortening writes.
-- 
2.30.2

