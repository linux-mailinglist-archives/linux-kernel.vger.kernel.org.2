Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC003A9358
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhFPG5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230515AbhFPG5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5C5761246;
        Wed, 16 Jun 2021 06:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623826517;
        bh=qVFGdhd3RiCLKZC/IOh05kkJiYS3/3QY2KmfYni5bpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkuafyYCr0ttnuzFV5+KTqo+QHac83k2fdVUduAheZ3CiW+Ze8wD5WAaITAKzGkm0
         g/ZsJQd/XOwB/FYafS3glV+SNTvUgCNMw3G7IPbcl8TaUqWye1f49qHoA4oZHpJdPe
         02afUiEvT1vk3yLfkfaB1QwY/CZrnlVRZCoHe5mCJfU/0B3+5XvGrtR49PafvnclH+
         kI1V7HDY+bs2AgxMt1FhCiSV6bk9o28MvhhucC7+qtbOMFMQ2p78hFRDErf+2eOIW1
         U8IIEmtIKZ59mKIeVJL855OwuQt6dERe7BD7vvJo4p+rBo5hRvxzVwNy5KDfb4s10/
         Z7tuwCKdPKxTg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltPSG-004lCG-8Q; Wed, 16 Jun 2021 08:55:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] docs: admin-guide: reporting-issues.rst: replace some characters
Date:   Wed, 16 Jun 2021 08:55:07 +0200
Message-Id: <551a2af0e654226067e5c376d3e2d959cc738f39.1623826294.git.mchehab+huawei@kernel.org>
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
 Documentation/admin-guide/reporting-issues.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 18d8e25ba9df..d7ac13f789cc 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -1248,7 +1248,7 @@ paragraph makes the severeness obvious.
 
 In case you performed a successful bisection, use the title of the change that
 introduced the regression as the second part of your subject. Make the report
-also mention the commit id of the culprit. In case of an unsuccessful bisection,
+also mention the commit id of the culprit. In case of an unsuccessful bisection,
 make your report mention the latest tested version that's working fine (say 5.7)
 and the oldest where the issue occurs (say 5.8-rc1).
 
-- 
2.31.1

