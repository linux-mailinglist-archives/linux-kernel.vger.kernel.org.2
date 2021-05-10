Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1638737824D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbhEJKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:34:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231414AbhEJKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:30:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5EAB61919;
        Mon, 10 May 2021 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642443;
        bh=GsPr03fOaT4mhUHTjqTPtFZzHQfxI0qpOypuFt8WL1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TA2UjSRsnd6dAZoMs33bi0wvJ3sN3e4DfZIPWxfc2SIgeTbNVPlSa+jFW2UpxOHW3
         u3lV6KWWOs6JU/k2UMZJKqVCaqXcELxHdAWzD+1UFn1WPdYvjaQRGBDTGtjtyQWGr3
         nZ373BWmyfJdx2+L4oWi0SaghXMk1jleugvWZfI2VlmOOnFbUXlBp/G4zu8eJSdeoN
         mTlRP3pNif1Gvaq2raumyr40diLptwWgdAB6Yp5JlSf8RUMUU9eae2PpOh/8h/YXHk
         984gDFOMOFYaXkIgbhSbmqGaenGyEYmFQa6AtyPcB+4H7b/g5oqnN72MuEPjN0nZ8d
         3cPcayJTXcF3g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38C-000UP6-TU; Mon, 10 May 2021 12:27:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Drew Fustini <drew@beagleboard.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Michael Walle <michael@walle.cc>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/53] docs: driver-api: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:26:24 +0200
Message-Id: <77e554fee3df340349bc80e7adb8deb255df235f.1620641727.git.mchehab+huawei@kernel.org>
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
	- U+2014 ('—'): EM DASH

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/driver-api/index.rst | 2 +-
 Documentation/driver-api/ioctl.rst | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index f5a3207aa7fa..29eb9230b7a9 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -4,7 +4,7 @@ The Linux driver implementer's API guide
 
 The kernel offers a wide variety of interfaces to support the development
 of device drivers.  This document is an only somewhat organized collection
-of some of those interfaces — it will hopefully get better over time!  The
+of some of those interfaces - it will hopefully get better over time!  The
 available subsections can be seen below.
 
 .. class:: toc-title
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

