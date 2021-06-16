Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628333A9359
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbhFPG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:57:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231400AbhFPG5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10776613C2;
        Wed, 16 Jun 2021 06:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623826518;
        bh=k6NTNp63lzWLLXxRP68+OTKIkex+SaEUw6CMpvbd8gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VdmCExCcU4NX8miOD5KFN1SAdvmsPXrhXsRf5aQh+0RR9pJsNt8hHByxo+NOFnmso
         hFMMe5jLl+02aRvg7mpH/LcfRs97W9y8Bt4W2HDcfZ0Lx58FKwK5DQPiG+c+WhOTbC
         S7PCpXlhfEODVBdvFkuxQFl3gPZadNdl4U8UOdQrkCPijd1QQ8SIgeyWfS0ibuVEB7
         deo0IRjYq1DKuWHs4wP+aVY0Nn2ArX3+PrsMcgksUhD+RgViOwZxRCduTtD5UbU/l+
         mA+WZBszn7wsHZtUTFKkhTpme/85wZypOHpdNZLwNd1Hihb8UGJPVsy6d+MvGxo2Ed
         vIgMfa5zrq+Yw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltPSG-004lCS-Cq; Wed, 16 Jun 2021 08:55:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 4/8] docs: usb: replace some characters
Date:   Wed, 16 Jun 2021 08:55:10 +0200
Message-Id: <0a4b0c38a9cd1133402a04a7ff60fefd9682d42e.1623826294.git.mchehab+huawei@kernel.org>
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

