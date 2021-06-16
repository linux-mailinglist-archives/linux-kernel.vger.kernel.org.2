Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9993A935A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhFPG5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231490AbhFPG5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21522613DC;
        Wed, 16 Jun 2021 06:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623826518;
        bh=fMr8KefFV1oiO0umnN9TstGa5i+97O0wPSkwr8OS2Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYToWSsGLdQXe2nm3vrPaxbyD91GHvhQqbQdTG/GGEEg11IjZNJKYhJmBjaNKQNCd
         kwV8605xFZT8ATYThJCbTl0OpAP0eBLE0vTFNigRPVUFEyCDcO0hg/BbiJMQ7PXvRa
         fYQK8If5Tr5K9j4jJV7tT4KLG29WzPoWexOK+6fn9blvAP2KjiB0SwhO2WALbDRvkF
         lNCLGyZDYlbw95gpj+/oYeGnjl5Dm7YlD1LJf4oZikzJ7euGImlK7A6uTiuGsR0edb
         rWQSHmvhZh+27re9QiIZso7OHlJE1zHzcLIo68KKb6PnnxORAbvyMTiICRCmbsaQUE
         ZsVkQCj+yiesg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltPSG-004lCW-E9; Wed, 16 Jun 2021 08:55:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] docs: vm: zswap.rst: replace some characters
Date:   Wed, 16 Jun 2021 08:55:11 +0200
Message-Id: <9a93b72f99f8f3328269076ceff50248ac9c5af5.1623826294.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623826294.git.mchehab+huawei@kernel.org>
References: <cover.1623826294.git.mchehab+huawei@kernel.org>
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

