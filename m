Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E77C39C8B0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhFENUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 09:20:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhFENU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 09:20:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB0D661428;
        Sat,  5 Jun 2021 13:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622899117;
        bh=ZpDN1jUp26cBVjHDeaaWZT1WhCWUTgEqEOlOYOFr4J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q6q/isLairrzvTRkyp7StDM7+MIFHLBGMDTm50wUQXI8cTrKJ8HcFDE3b1PTMoQ+L
         lutLM8SN4J1XRRmrQI7MGtow+r7jYVXASfCWZ/cL1wS0xcgufLeR80IctsrBSZ+Y96
         AKuPf7b80TMvUYNYH4RF4BUarTRB11wEj9EIZGOXd+6Ps9p8yrj1/4jhK1olNadQrV
         HybabO+iuBuooQc1De8lXGRCGpS1At6sXLsI8iJ3fGIK7ebutcG02nGVj7uPAHFKvl
         LGVcryIo5ok9jDkHDf8xGaUjgvUycKx4iZMz3rsdD8eZvxOBEYpQtwH8OD5x1y92Fb
         6U7mnBp8hSFyQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lpWCB-008GFJ-R5; Sat, 05 Jun 2021 15:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/34] docs: dev-tools: testing-overview.rst: avoid using ReSt :doc:`foo` markup
Date:   Sat,  5 Jun 2021 15:18:12 +0200
Message-Id: <63fe86c8de5cced00a1bb5d18d6c7f087268565a.1622898327.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622898327.git.mchehab+huawei@kernel.org>
References: <cover.1622898327.git.mchehab+huawei@kernel.org>
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
 Documentation/dev-tools/testing-overview.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index b5b46709969c..65feb81edb14 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -71,15 +71,15 @@ can be used to verify that a test is executing particular functions or lines
 of code. This is useful for determining how much of the kernel is being tested,
 and for finding corner-cases which are not covered by the appropriate test.
 
-:doc:`gcov` is GCC's coverage testing tool, which can be used with the kernel
-to get global or per-module coverage. Unlike KCOV, it does not record per-task
-coverage. Coverage data can be read from debugfs, and interpreted using the
-usual gcov tooling.
+Documentation/dev-tools/gcov.rst is GCC's coverage testing tool, which can be
+used with the kernel to get global or per-module coverage. Unlike KCOV, it
+does not record per-task coverage. Coverage data can be read from debugfs,
+and interpreted using the usual gcov tooling.
 
-:doc:`kcov` is a feature which can be built in to the kernel to allow
-capturing coverage on a per-task level. It's therefore useful for fuzzing and
-other situations where information about code executed during, for example, a
-single syscall is useful.
+Documentation/dev-tools/kcov.rst is a feature which can be built in to the
+kernel to allow capturing coverage on a per-task level. It's therefore useful
+for fuzzing and other situations where information about code executed during,
+for example, a single syscall is useful.
 
 
 Dynamic Analysis Tools
-- 
2.31.1

