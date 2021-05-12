Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3201137BD55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhELMyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhELMw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF70A6143C;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=tgsrpZJ6N5rETloYOqMrjBzRY130AS2XXGVAZv8/Jvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KV+dVnVDnD3G1y0R+h/Mzw61N5k1bmqkUdAMA1duPn/9iPtAmmd2EIqoLmmV+7njT
         d+jGTmcV5F9kCXU1TviCtYQabgr+LAyaKeqaI35M/e1qJgMbscwLOQxZsycjLF1/fV
         FYmntF/Nx17TSf6kx4tuI8Iui7iPOBPdKjltmp+HcwBNewpXuNjT39nONfRJ/GSBLL
         aDh76zAA47XQOtQgeOhdy3uogMWrpW9oM/1l4F5V80X9NwJF1dF8UaxIDHYI5EuQ9S
         MNdcuGKvdvUlrmDUC25aPSjlcaRLW5OCqrgcuWe9hj5aYSJCa1DSVJ/RNWp7gd4vQm
         nLLcQ8BLOUcRQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018hx-QS; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, Chao Yu <chao@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2 18/40] docs: filesystems: f2fs.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:22 +0200
Message-Id: <a649acf2e85c739b9c26338c2f96cf9eacbdb1d6.1620823573.git.mchehab+huawei@kernel.org>
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

	- U+201c ('“'): LEFT DOUBLE QUOTATION MARK
	- U+201d ('”'): RIGHT DOUBLE QUOTATION MARK

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/f2fs.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 992bf91eeec8..f0ae49a7606b 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -86,8 +86,8 @@ Flash Awareness
 
 Wandering Tree Problem
 ----------------------
-- Use a term, “node”, that represents inodes as well as various pointer blocks
-- Introduce Node Address Table (NAT) containing the locations of all the “node”
+- Use a term, "node", that represents inodes as well as various pointer blocks
+- Introduce Node Address Table (NAT) containing the locations of all the "node"
   blocks; this will cut off the update propagation.
 
 Cleaning Overhead
-- 
2.30.2

