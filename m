Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF76378248
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhEJKdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231834AbhEJKaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:30:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C55266190A;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=F8nZoWzH89/rBepWAsXTSR/Xntv7YEnimf4HW1jZedc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9LiZUbici3PrWQ7dTN+D+h5UEi/+51sD4hfQcIkvJceyQPcGrKzu6afxA9al8LxF
         pJ2TJpXHB8EQ1t1Ci+VIjQz373nHMIonKRjNSoL9gcnFeAYTod3m2in4LQxQaRTEFV
         7y9D3EytyMvmOpnoYjarq12GvLDG9LG8tTGcPMC//9RBs9Mt2Q8nIvXUmS59NtRTUy
         3V4R/J8EeS2l60w5Gew7cS3B2o4p404wpzk+pmWyVnZ9K7O2gO2kz4ODpF7rAWZngU
         hdobAX8u3oHayrjjwtGUDjIy10RgfyBUWfToLtga8gA3INLkhxkULaG6k+nFdfez9B
         owPwSP03UC5OQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38D-000UPY-7h; Mon, 10 May 2021 12:27:21 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/53] docs: fault-injection: nvme-fault-injection.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:31 +0200
Message-Id: <197d802b2a5f4fe0b651b8577aa79b8b8f2c90fb.1620641727.git.mchehab+huawei@kernel.org>
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

	- U+2018 ('‘'): LEFT SINGLE QUOTATION MARK
	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/fault-injection/nvme-fault-injection.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fault-injection/nvme-fault-injection.rst b/Documentation/fault-injection/nvme-fault-injection.rst
index 1d4427890d75..d372ce66a244 100644
--- a/Documentation/fault-injection/nvme-fault-injection.rst
+++ b/Documentation/fault-injection/nvme-fault-injection.rst
@@ -25,7 +25,7 @@ Example 1: Inject default status code with no retry
 
 Expected Result::
 
-  cp: cannot stat ‘/mnt/a.file’: Input/output error
+  cp: cannot stat '/mnt/a.file': Input/output error
 
 Message from dmesg::
 
-- 
2.30.2

