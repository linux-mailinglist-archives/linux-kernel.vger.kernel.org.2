Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B77A3A9286
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhFPGaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:30:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231513AbhFPG3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:29:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05B13613EE;
        Wed, 16 Jun 2021 06:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623824868;
        bh=ZpDN1jUp26cBVjHDeaaWZT1WhCWUTgEqEOlOYOFr4J8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHDzNCO8PU/IoEth+i7Ys77KDBfK5TgPPTzqaakGhfVSdOLvf4VOfMP/8t1SoxAhK
         t46NRGozPlZgXKbAk9iLJZkBuNoh+meYZemCUfOJ5jqgIbDq/ukgcW3Cb0rSXOn9xs
         YwyFgIa2MQXTSexHBEAHC1Do2otgRbLkPFoa6/Tj0fhitp7bMAA44lL8+gxVo3pQj3
         c1x/GzRc7M3YAeG9IWBux7ptQUF3WzKeOUgL88kNql6bKKpbpEb3Xx6uhKEWc6a2jm
         ByN/yALjktj0/SXb2gJ+DNU9NqJkho88rekT/xjOTjeY0Xs4/IFTQpw/x73iCJ25xD
         Us6hYg06qQdug==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltP1e-004kIs-9l; Wed, 16 Jun 2021 08:27:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        David Gow <davidgow@google.com>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/29] docs: dev-tools: testing-overview.rst: avoid using ReST :doc:`foo` markup
Date:   Wed, 16 Jun 2021 08:27:24 +0200
Message-Id: <6bbecd4170ee08f36f8060b0719a46c64a21aefc.1623824363.git.mchehab+huawei@kernel.org>
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

