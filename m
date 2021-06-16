Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E643A9355
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbhFPG5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231318AbhFPG5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BDA7613D0;
        Wed, 16 Jun 2021 06:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623826518;
        bh=XfaDbhyWTZnv4WQEdwoApJzDRlUwiFS9TASTuCgnwjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEHOtITyS9QTJ13JLBFmSz+a9sy/nYwN50DJSymhVLGJK2RX/o2Pf8BGI8eIpWbrV
         PRYgoIfgEqsS3NWkRZP7I4fMXBUJIC61CFWQTWZrxNT66wuXT5S6E43+fpHzQC2c7y
         XyAju6YeXaucYg8dnfNGWS4/BW0WvCghjA1OKuYj+CQRJMLzmpKw9UX6NPixDvzUKP
         0+eeRYGK6i/4Pos01dFYCZoQMEMyBM6oDsN9QqAT8Pt0mtzywKWW0fbzsXCyq1fL0U
         VQcunQfFe3Faf5NMh1C+jjdWh2PdRoXfUKAxjvL7KvMbZ8zuFNtns/GE8Y3Z5cRRp4
         EB/7Ej2BgR5Ag==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltPSG-004lCO-BS; Wed, 16 Jun 2021 08:55:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] docs: driver-api: ioctl.rst: replace some characters
Date:   Wed, 16 Jun 2021 08:55:09 +0200
Message-Id: <b2186e313f990488ded56d9b8d35a2d1fe479aa1.1623826294.git.mchehab+huawei@kernel.org>
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
2.31.1

