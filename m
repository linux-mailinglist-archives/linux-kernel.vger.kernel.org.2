Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB32378295
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhEJKg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhEJKcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:32:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48DF261956;
        Mon, 10 May 2021 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642444;
        bh=eN7xiGZZQN2FpK3NcbYjhE6KRTVAMVNM7g7NqkcJ9OM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmFcmFX6rPxaEZgzLVjNQfegRJIiCSk36oNk4aoDpbVDSNKsWywUnxHP15JqZpAVV
         mZtEDxrwllZ+eHQcf1Q1W+ZHxCPxy6sQFlqvTjkzIhJDJ2iSpHFtbyZEX9Rexzz1EO
         9hbkgb5qJdBrjuH9vImHjz5xV7rD62cB8E5x0l2Wv50d3VPKukn7fAMZgR7/jzJaWf
         7RZ2jO2LEts5bqH2fPfbL6GsYPPrp6PYywFkpZ48Axe0PwVUjoqOQnlVTpSTNy4Uou
         9EJ0UHCZEBx2So/ctY15/zb4FrlmVUVLAYcSCtZNWVuHFf4SOFElm/9Xo4Vjq3qoaI
         urZdx22a6f/Ug==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38E-000UR2-BB; Mon, 10 May 2021 12:27:22 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 42/53] docs: doc-guide: contributing.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:54 +0200
Message-Id: <33c1b299d8868c6943a19598f90c609ca7bc6ccf.1620641727.git.mchehab+huawei@kernel.org>
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
 Documentation/doc-guide/contributing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/contributing.rst b/Documentation/doc-guide/contributing.rst
index 67ee3691f91f..c2d709467c68 100644
--- a/Documentation/doc-guide/contributing.rst
+++ b/Documentation/doc-guide/contributing.rst
@@ -76,7 +76,7 @@ comments that look like this::
 
 The problem is the missing "*", which confuses the build system's
 simplistic idea of what C comment blocks look like.  This problem had been
-present since that comment was added in 2016 — a full four years.  Fixing
+present since that comment was added in 2016 - a full four years.  Fixing
 it was a matter of adding the missing asterisks.  A quick look at the
 history for that file showed what the normal format for subject lines is,
 and ``scripts/get_maintainer.pl`` told me who should receive it.  The
-- 
2.30.2

