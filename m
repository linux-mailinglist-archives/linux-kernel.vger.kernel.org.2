Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B3C432FED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbhJSHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhJSHpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:45:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 198BD6136F;
        Tue, 19 Oct 2021 07:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634629376;
        bh=HfzBxbwvlGACvGlHDYJHMxVKdFA+2m32c4s7O2PDMvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqVM1lwfZT2zUVbA54MVbz2u67PXB726G/KUKI8X8q1fiJzE/ajBFkkJ8oN/OxHSo
         FcUBvMk+lYV5bAnNN1p7apvsDOqRvC0iEQL0GYsmLhLKKQ2KG4vhTlM6ey5o8/1saN
         Asypa0nFpN1wpyP/IioMzIGm1CmfNT5kEGWCbKB3uZSThDIXhOCJ0JscGozLvO9CwJ
         z9TZKupoexJcSA0vErG3OjN0xnB9XqXLCzaWPPeEvlySnFa8t3pXi/OSsL35eLHmm5
         JE65nJ3KpJhHNYl1iG5bi1i6+qdIWs6mybTV6COVcGtuFWRfMW+ZwG7GP3HW/8b+Lu
         1FhRztElMFu4A==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mcjlt-001nLh-7t; Tue, 19 Oct 2021 08:42:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scripts: documentation-file-ref-check: ignore hidden files
Date:   Tue, 19 Oct 2021 08:42:50 +0100
Message-Id: <dd0125a931b4fecf8fab6be8aa527faa18f78e43.1634629094.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634629094.git.mchehab+huawei@kernel.org>
References: <cover.1634629094.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a warning there from a .gitignore file:

	tools/perf/.gitignore: Documentation/doc.dep

This is not really a cross-reference type of warning, so
no need to report it.

In a matter of fact, it doesn't make sense at all to even
parse hidden files, as some text editors may create such
files for their own usage.

So, just ignore everything that matches this pattern:

	/\.*

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/2] at: https://lore.kernel.org/all/cover.1634629094.git.mchehab+huawei@kernel.org/

 scripts/documentation-file-ref-check | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
index 7187ea5e5149..6865d8e63d5c 100755
--- a/scripts/documentation-file-ref-check
+++ b/scripts/documentation-file-ref-check
@@ -94,6 +94,9 @@ while (<IN>) {
 	# Makefiles and scripts contain nasty expressions to parse docs
 	next if ($f =~ m/Makefile/ || $f =~ m/\.sh$/);
 
+	# It doesn't make sense to parse hidden files
+	next if ($f =~ m#/\.#);
+
 	# Skip this script
 	next if ($f eq $scriptname);
 
-- 
2.31.1

