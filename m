Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD3381DDB
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhEPKTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:19:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229437AbhEPKTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:19:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F4606117A;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=k6NTNp63lzWLLXxRP68+OTKIkex+SaEUw6CMpvbd8gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWsAXi/FqUV3SVOfGzk/ct7+0k/vItc1TquE8dMSb0MAjWTnhkbAQntuuHgaqEcPc
         S0au+FDVyjnHEefE31wtMU3h3RAnKkEfDP9tvbGXZJj0w9LJ0KUV01TZGsybNmYnYH
         WCOacSH3hphyRC9NOnO6TSab+9PW+aydBTSJx0ltCx0OIlb41j3IytcsYiSd6udL0+
         EwcuTGwNaofdHNBFVzyqa3K7/8kPgGonkuvi0/pPwP/CKCTLInRlM6n+WGNwRYPV+Z
         aMTziKxnQd9cGRzo5q7+JgzFqUlKhGwgL1n6EfIysQPBMKQ21nlttQGsOWioQIVR+x
         ho21nbOikw1lA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o8W-DI; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH v3 06/16] docs: usb: replace some characters
Date:   Sun, 16 May 2021 12:18:23 +0200
Message-Id: <aeec057e6e9e00e5c8f9813749ee1fabb27366ac.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
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

	- U+feff ('﻿'): BOM
	  as it is not needed on UTF-8

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/usb/ehci.rst           | 2 +-
 Documentation/usb/gadget_printer.rst | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/usb/ehci.rst b/Documentation/usb/ehci.rst
index 31f650e7c1b4..76190501907a 100644
--- a/Documentation/usb/ehci.rst
+++ b/Documentation/usb/ehci.rst
@@ -1,4 +1,4 @@
-﻿===========
+===========
 EHCI driver
 ===========
 
diff --git a/Documentation/usb/gadget_printer.rst b/Documentation/usb/gadget_printer.rst
index 5e5516c69075..e611a6d91093 100644
--- a/Documentation/usb/gadget_printer.rst
+++ b/Documentation/usb/gadget_printer.rst
@@ -1,4 +1,4 @@
-﻿===============================
+===============================
 Linux USB Printer Gadget Driver
 ===============================
 
-- 
2.31.1

