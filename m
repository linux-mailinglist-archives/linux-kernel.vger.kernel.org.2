Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 177593782A7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbhEJKgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:36:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231374AbhEJKcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:32:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68F876195B;
        Mon, 10 May 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=ZLCX4dRWRX3OQsCf8RA5tIRwPfjnTyhzpWsAYNd3C+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GR4UTeBfp+Lnuos2yj9vMy1bbQw3BVbxS/FLxLiRh9tugDQZVW4iEdz4cCDmW8OxE
         VgDS3Qge4so9VWAcwS8Otm9hzuX+LY8p0cruMrX3gc4IltJ0XwyOIYGAxqMeXf5CVM
         TP2ecwtJ445otpC6hfloPEiE+3y0HZHvOO1UsRv4VvH3hrc/Pl4lTYb3zAwSctB5bj
         TsghM6iEKUKpWD9qxLPtjVOtPTZ9v+aFq5SChtnzG9zs9Y0k6Gvr3mW2MiCWZEPawn
         smgDl5TxC0be69t3p4LCicA3g87ASnpiV2fyi5EjiAitf8NiS5hmKnLAptXs8ztROv
         6pp80k8g5nh3Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UQ0-JI; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 26/53] docs: vm: zswap.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:38 +0200
Message-Id: <725f9130eced1b12c8a8630478a291ebe46dea2f.1620641727.git.mchehab+huawei@kernel.org>
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

