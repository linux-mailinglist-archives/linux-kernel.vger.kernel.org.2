Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF95381E00
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhEPKUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231336AbhEPKTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:19:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77FFB611F0;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=fMr8KefFV1oiO0umnN9TstGa5i+97O0wPSkwr8OS2Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+eVedEueBQRoj47Nyf1fm8giAGYWpSkCi9a8VC8tXjNOW7ZhyHgGd8EffPKQ1ctM
         ZwRt60VRJRC3nRSaeHiTokmCWuTNDE7dhNxYfNtM1reZo3txdtj7LEDC795uKLCtXw
         cf80dls1US29YeVv9hDlAombtz8siLh3minPzvsjluVgzh/PA+EpjlFXb2JmDTjoK0
         0RqXy6P1AOPPt/ItnErz7O//BckaoUFbOv2UGNsNARrfMMALoKF2N8nsChIgW6IRUf
         LJKQBMvBiqOj/cuwwlBVJkoRS0XfSz7Zfg6eAhNKIeeAAJ8DezZiEG1NrTiYJLjRs0
         gUcCCKfgLSZCw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o8i-Gm; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/16] docs: vm: zswap.rst: replace some characters
Date:   Sun, 16 May 2021 12:18:26 +0200
Message-Id: <22eafb9660fc19b42eb2b57895fcf7ceae33e35b.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+00a0 (' '): NO-BREAK SPACE
	  as it can cause lines being truncated on PDF output

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
2.31.1

