Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384FF40D544
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhIPJB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235297AbhIPJBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:01:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14BFF6120C;
        Thu, 16 Sep 2021 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631782802;
        bh=+z6dw7Tog78+7mQUP8MykHTfS8BskbmMD+pw4Idm0Jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpQQDYRuhK6bjt57SKrRlHde8CXA+5oHzjkVJDQJykYhJQgnO+LLjSETStrufNfXj
         iREFQZqU/HevOgSYB1opdoyutfrv13vISJ/SSRoLrLehVb1QWi5x46iKjb8w0XGYjD
         t5cExtQREXP6XcgafQ4ySWk5IUcjOf5jUC5Z6Z6zVxDn7GXkdasn7RDE7VdTnBexKq
         KrS0ipi1ZydFUIeAXC+iXXK64f/2WIDkeWSfQiYIxQmGqzjgLFO3iqZ4SvylLPPrvy
         IMMZcGmKtcRNT47+S3aRA4PLb646c8b8ajL5ABSb9I78tKfMuXBOViWfLJ/NUi4QnE
         xbZFbgOOGL29Q==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQnFQ-001qjd-BC; Thu, 16 Sep 2021 11:00:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/30] ABI: sysfs-tty: better document module name parameter
Date:   Thu, 16 Sep 2021 10:59:29 +0200
Message-Id: <6280edfacdbcbf8db1aeb7bf11e899187c11ac4c.1631782432.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631782432.git.mchehab+huawei@kernel.org>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On almost all ABI documents, variable arguments are declared
as <foo_bar>. Change it here too, in order to allow replacing
such wildcards by regexes on a scriptable way.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-tty | 32 ++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
index e157130a6792..820e412d38a8 100644
--- a/Documentation/ABI/testing/sysfs-tty
+++ b/Documentation/ABI/testing/sysfs-tty
@@ -9,7 +9,7 @@ Description:
 		 The file supports poll() to detect virtual
 		 console switches.
 
-What:		/sys/class/tty/tty0/active
+What:		/sys/class/tty/tty<x>/active
 Date:		Nov 2010
 Contact:	Kay Sievers <kay.sievers@vrfy.org>
 Description:
@@ -18,7 +18,7 @@ Description:
 		 The file supports poll() to detect virtual
 		 console switches.
 
-What:		/sys/class/tty/ttyS0/uartclk
+What:		/sys/class/tty/ttyS<x>/uartclk
 Date:		Sep 2012
 Contact:	Tomas Hlavacek <tmshlvck@gmail.com>
 Description:
@@ -29,7 +29,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/type
+What:		/sys/class/tty/ttyS<x>/type
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -38,7 +38,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/line
+What:		/sys/class/tty/ttyS<x>/line
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -47,7 +47,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/port
+What:		/sys/class/tty/ttyS<x>/port
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -56,7 +56,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/irq
+What:		/sys/class/tty/ttyS<x>/irq
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -65,7 +65,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/flags
+What:		/sys/class/tty/ttyS<x>/flags
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -74,7 +74,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/xmit_fifo_size
+What:		/sys/class/tty/ttyS<x>/xmit_fifo_size
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -83,7 +83,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/close_delay
+What:		/sys/class/tty/ttyS<x>/close_delay
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -92,7 +92,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/closing_wait
+What:		/sys/class/tty/ttyS<x>/closing_wait
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -101,7 +101,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/custom_divisor
+What:		/sys/class/tty/ttyS<x>/custom_divisor
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -110,7 +110,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/io_type
+What:		/sys/class/tty/ttyS<x>/io_type
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -120,7 +120,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/iomem_base
+What:		/sys/class/tty/ttyS<x>/iomem_base
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -129,7 +129,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/iomem_reg_shift
+What:		/sys/class/tty/ttyS<x>/iomem_reg_shift
 Date:		October 2012
 Contact:	Alan Cox <alan@linux.intel.com>
 Description:
@@ -139,7 +139,7 @@ Description:
 		 These sysfs values expose the TIOCGSERIAL interface via
 		 sysfs rather than via ioctls.
 
-What:		/sys/class/tty/ttyS0/rx_trig_bytes
+What:		/sys/class/tty/ttyS<x>/rx_trig_bytes
 Date:		May 2014
 Contact:	Yoshihiro YUNOMAE <yoshihiro.yunomae.ez@hitachi.com>
 Description:
@@ -155,7 +155,7 @@ Description:
 		 16550A, which has 1/4/8/14 bytes trigger, the RX trigger is
 		 automatically changed to 4 bytes.
 
-What:		/sys/class/tty/ttyS0/console
+What:		/sys/class/tty/ttyS<x>/console
 Date:		February 2020
 Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 Description:
-- 
2.31.1

