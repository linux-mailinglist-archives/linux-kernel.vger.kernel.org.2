Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD25375D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 01:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhEFXUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 19:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhEFXUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 19:20:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDFCC061574;
        Thu,  6 May 2021 16:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=/IDrYv+WVlbIk8z5IXS/+Bzh2FwJWGRkdhrJyEjigS8=; b=nmAUQPtV/secjAI9Qc2ggIQzcP
        VPWiwvP2gOJQKdWE7leQxtiwjeuFmVQgMTt6JGP83WSssnH0vr04H4cpaxUWAPcvE24fR5h7SGST5
        8nbAd4hjafe6zCfIkEqD1+wMPXWlHISp4hnwnjFBU92rzqrU184YlIt3LcblutSN7zU6gNIfEaIuE
        5SOQ2w1g8FG4nDz6cl1WdoTPK8oZn5yJI/+bEH0s4v6Q7E7e0hzTPrKDDnAgiDSL6UT7f9jB8ISS3
        YR/4m6ZbHxf8UkAMirBN/ziGFeNK3xaQu8F+Pz3Detl6EUD1Bi8tEybeMnZXza3uCX7VQeDtiLOg3
        ze9Sx/ZA==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lenGv-006RpI-Es; Thu, 06 May 2021 23:19:09 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] Documentation: drop optional BOMs
Date:   Thu,  6 May 2021 16:19:07 -0700
Message-Id: <20210506231907.14359-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few of the Documentation .rst files begin with a Unicode
byte order mark (BOM). The BOM may signify endianess for
16-bit or 32-bit encodings or indicate that the text stream
is indeed Unicode. We don't need it for either of those uses.
It may also interfere with (confuse) some software.

Since we don't need it and its use is optional, just delete
the uses of it in Documentation/.

https://en.wikipedia.org/wiki/Byte_order_mark

Fixes: 898bd37a9206 ("docs: block: convert to ReST")
Fixes: edba5eecfd6e ("doc:it_IT: add some process/* translations")
Fixes: 675aaf05d898 ("docs: xen-tpmfront.txt: convert it to .rstX")
Fixes: 458f69ef3665 ("docs: timers: convert docs to ReST and rename to *.rst")
Fixes: d80b5005c5dd ("docs: usb: convert documents to ReST")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
---
 Documentation/block/data-integrity.rst                 |    2 +-
 Documentation/process/kernel-enforcement-statement.rst |    2 +-
 Documentation/security/tpm/xen-tpmfront.rst            |    2 +-
 Documentation/timers/no_hz.rst                         |    2 +-
 Documentation/usb/mtouchusb.rst                        |    2 +-
 Documentation/usb/usb-serial.rst                       |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20210506.orig/Documentation/block/data-integrity.rst
+++ linux-next-20210506/Documentation/block/data-integrity.rst
@@ -1,4 +1,4 @@
-﻿==============
+==============
 Data Integrity
 ==============
 
--- linux-next-20210506.orig/Documentation/process/kernel-enforcement-statement.rst
+++ linux-next-20210506/Documentation/process/kernel-enforcement-statement.rst
@@ -1,4 +1,4 @@
-﻿.. _process_statement_kernel:
+.. _process_statement_kernel:
 
 Linux Kernel Enforcement Statement
 ----------------------------------
--- linux-next-20210506.orig/Documentation/timers/no_hz.rst
+++ linux-next-20210506/Documentation/timers/no_hz.rst
@@ -1,4 +1,4 @@
-﻿======================================
+======================================
 NO_HZ: Reducing Scheduling-Clock Ticks
 ======================================
 
--- linux-next-20210506.orig/Documentation/usb/mtouchusb.rst
+++ linux-next-20210506/Documentation/usb/mtouchusb.rst
@@ -1,4 +1,4 @@
-﻿================
+================
 mtouchusb driver
 ================
 
--- linux-next-20210506.orig/Documentation/usb/usb-serial.rst
+++ linux-next-20210506/Documentation/usb/usb-serial.rst
@@ -1,4 +1,4 @@
-﻿==========
+==========
 USB serial
 ==========
 
--- linux-next-20210506.orig/Documentation/security/tpm/xen-tpmfront.rst
+++ linux-next-20210506/Documentation/security/tpm/xen-tpmfront.rst
@@ -1,4 +1,4 @@
-﻿=============================
+=============================
 Virtual TPM interface for Xen
 =============================
 
