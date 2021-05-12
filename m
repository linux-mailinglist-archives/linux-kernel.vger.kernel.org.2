Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3237BD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhELMxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:53:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhELMwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:52:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D2AB61177;
        Wed, 12 May 2021 12:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823902;
        bh=9ZrdEXP9uF/1gywNsqqqNVwR7m3JOM+kWEVqticTO7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8R6KfiuBdkQUoal0yj23vXyClXR3ungJ8ExFyoxj9nWavV4zFy9WoEJ850DV7/UM
         j6XWVapuxbuqoeKQb3FQsbdxndsLJrGr0gxvdSg2+m6764hmfhdEZmG1T5CO7GpDY/
         CP3pyQPXBLYY2w+tLFJ3CcZvq3vPlna3eNrZcUwrwOXniO6cTZXoMCwGetzvauhOJu
         a+l0np8gLr9oVAXowGJkN/951Xhv8DulMigdYNQh++VorgPtTDDzbXRD/SrxYhx2IN
         DwDJPhsLR7/MdRBU7X1OU1Lmg2BQcmF3EwUj4jVgDx5pCvqvWg3ma5NDE7q6TMAnNf
         e8niC4hc1yA/w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoKy-0018hF-AH; Wed, 12 May 2021 14:51:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/40] docs: driver-api: ioctl.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:11 +0200
Message-Id: <5cf0219649d914d5657adcc7fcda64e59f1aec12.1620823573.git.mchehab+huawei@kernel.org>
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

	- U+00a0 (' '): NO-BREAK SPACE

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/ioctl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/ioctl.rst b/Documentation/driver-api/ioctl.rst
index c455db0e1627..5b76e765827d 100644
--- a/Documentation/driver-api/ioctl.rst
+++ b/Documentation/driver-api/ioctl.rst
@@ -25,9 +25,9 @@ ioctl commands that follow modern conventions: ``_IO``, ``_IOR``,
 with the correct parameters:
 
 _IO/_IOR/_IOW/_IOWR
-   The macro name specifies how the argument will be used.  It may be a
+   The macro name specifies how the argument will be used.  It may be a
    pointer to data to be passed into the kernel (_IOW), out of the kernel
-   (_IOR), or both (_IOWR).  _IO can indicate either commands with no
+   (_IOR), or both (_IOWR).  _IO can indicate either commands with no
    argument or those passing an integer value instead of a pointer.
    It is recommended to only use _IO for commands without arguments,
    and use pointers for passing data.
@@ -200,10 +200,10 @@ cause an information leak, which can be used to defeat kernel address
 space layout randomization (KASLR), helping in an attack.
 
 For this reason (and for compat support) it is best to avoid any
-implicit padding in data structures.  Where there is implicit padding
+implicit padding in data structures.  Where there is implicit padding
 in an existing structure, kernel drivers must be careful to fully
 initialize an instance of the structure before copying it to user
-space.  This is usually done by calling memset() before assigning to
+space.  This is usually done by calling memset() before assigning to
 individual members.
 
 Subsystem abstractions
-- 
2.30.2

