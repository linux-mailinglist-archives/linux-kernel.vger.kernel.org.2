Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C59F311EA0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 17:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhBFQ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 11:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229508AbhBFQ0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 11:26:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A197964EAC;
        Sat,  6 Feb 2021 16:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612628734;
        bh=PmjOTQ3v9jEJF1iLslj3snl6KrZBzFHxgXdhaKrTmU8=;
        h=Date:From:To:Cc:Subject:From;
        b=DgTtYtw2sXh5ULtd0cKpuabxxwqVBpHDzCxQLLkwcSYXjSV4m1wynTKERdy5OO14b
         BsnJM3Dteh4Gleh9vNoPwx2AJPT9u1m5IKc9icf93U8z6tDdQQiajDXFt6vfT1H6wN
         0RLk41aB9OrlZPuqmzQfGKLTz6SP6hLv5WukjVkEt0/7n0FCLZ7XEEhvlSYiCn0Kj0
         Ud48ne9uPMIqVr0KHGRxzgalt5p89zWc5dqPu8c9FWNoGdnzRiOKTwu3UQ4oBsrcE2
         BNoUVgnCPwaglXhXCE4QJMWzrGcBNNs45OGosPQaDbkkkvpkHhxgahtBft794Q2Omu
         L9XEaZNg0r+6A==
Date:   Sat, 6 Feb 2021 17:25:24 +0100
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] treewide: update my contact info
Message-ID: <20210206162524.GA11520@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 .mailmap                                            |  1 +
 CREDITS                                             |  9 +++------
 Documentation/admin-guide/auxdisplay/cfag12864b.rst |  2 +-
 Documentation/admin-guide/auxdisplay/ks0108.rst     |  2 +-
 MAINTAINERS                                         | 12 ++++++------
 drivers/auxdisplay/cfag12864b.c                     |  4 ++--
 drivers/auxdisplay/cfag12864bfb.c                   |  4 ++--
 drivers/auxdisplay/ks0108.c                         |  4 ++--
 include/linux/cfag12864b.h                          |  2 +-
 include/linux/ks0108.h                              |  2 +-
 samples/auxdisplay/cfag12864b-example.c             |  2 +-
 11 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/.mailmap b/.mailmap
index cc4e91d3075e..132580897fbc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -232,6 +232,7 @@ Maxime Ripard <mripard@kernel.org> <maxime.ripard@free-electrons.com>
 Mayuresh Janorkar <mayur@ti.com>
 Michael Buesch <m@bues.ch>
 Michel Dänzer <michel@tungstengraphics.com>
+Miguel Ojeda <ojeda@kernel.org> <miguel.ojeda.sandonis@gmail.com>
 Mike Rapoport <rppt@kernel.org> <mike@compulab.co.il>
 Mike Rapoport <rppt@kernel.org> <mike.rapoport@gmail.com>
 Mike Rapoport <rppt@kernel.org> <rppt@linux.ibm.com>
diff --git a/CREDITS b/CREDITS
index 9add7e6a4fa0..e8eaf9b373d7 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2841,14 +2841,11 @@ S: Subiaco, 6008
 S: Perth, Western Australia
 S: Australia
 
-N: Miguel Ojeda Sandonis
-E: miguel.ojeda.sandonis@gmail.com
-W: http://miguelojeda.es
-W: http://jair.lab.fi.uva.es/~migojed/
+N: Miguel Ojeda
+E: ojeda@kernel.org
+W: https://ojeda.dev
 D: Author of the ks0108, cfag12864b and cfag12864bfb auxiliary display drivers.
 D: Maintainer of the auxiliary display drivers tree (drivers/auxdisplay/*)
-S: C/ Mieses 20, 9-B
-S: Valladolid 47009
 S: Spain
 
 N: Peter Oruba
diff --git a/Documentation/admin-guide/auxdisplay/cfag12864b.rst b/Documentation/admin-guide/auxdisplay/cfag12864b.rst
index 18c2865bd322..da385d851acc 100644
--- a/Documentation/admin-guide/auxdisplay/cfag12864b.rst
+++ b/Documentation/admin-guide/auxdisplay/cfag12864b.rst
@@ -3,7 +3,7 @@ cfag12864b LCD Driver Documentation
 ===================================
 
 :License:		GPLv2
-:Author & Maintainer:	Miguel Ojeda Sandonis
+:Author & Maintainer:	Miguel Ojeda <ojeda@kernel.org>
 :Date:			2006-10-27
 
 
diff --git a/Documentation/admin-guide/auxdisplay/ks0108.rst b/Documentation/admin-guide/auxdisplay/ks0108.rst
index c0b7faf73136..a7d3fe509373 100644
--- a/Documentation/admin-guide/auxdisplay/ks0108.rst
+++ b/Documentation/admin-guide/auxdisplay/ks0108.rst
@@ -3,7 +3,7 @@ ks0108 LCD Controller Driver Documentation
 ==========================================
 
 :License:		GPLv2
-:Author & Maintainer:	Miguel Ojeda Sandonis
+:Author & Maintainer:	Miguel Ojeda <ojeda@kernel.org>
 :Date:			2006-10-27
 
 
diff --git a/MAINTAINERS b/MAINTAINERS
index d3e847f7f3dc..11542312e4e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3018,7 +3018,7 @@ F:	include/uapi/linux/audit.h
 F:	kernel/audit*
 
 AUXILIARY DISPLAY DRIVERS
-M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
+M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
 F:	drivers/auxdisplay/
 F:	include/linux/cfag12864b.h
@@ -4123,13 +4123,13 @@ F:	scripts/extract-cert.c
 F:	scripts/sign-file.c
 
 CFAG12864B LCD DRIVER
-M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
+M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
 F:	drivers/auxdisplay/cfag12864b.c
 F:	include/linux/cfag12864b.h
 
 CFAG12864BFB LCD FRAMEBUFFER DRIVER
-M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
+M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
 F:	drivers/auxdisplay/cfag12864bfb.c
 F:	include/linux/cfag12864b.h
@@ -4299,7 +4299,7 @@ S:	Supported
 F:	drivers/infiniband/hw/usnic/
 
 CLANG-FORMAT FILE
-M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
+M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
 F:	.clang-format
 
@@ -4441,7 +4441,7 @@ S:	Maintained
 F:	drivers/platform/x86/compal-laptop.c
 
 COMPILER ATTRIBUTES
-M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
+M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
 F:	include/linux/compiler_attributes.h
 
@@ -9903,7 +9903,7 @@ F:	include/linux/kprobes.h
 F:	kernel/kprobes.c
 
 KS0108 LCD CONTROLLER DRIVER
-M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
+M:	Miguel Ojeda <ojeda@kernel.org>
 S:	Maintained
 F:	Documentation/admin-guide/auxdisplay/ks0108.rst
 F:	drivers/auxdisplay/ks0108.c
diff --git a/drivers/auxdisplay/cfag12864b.c b/drivers/auxdisplay/cfag12864b.c
index 7eebae7e322c..fd430e6866a1 100644
--- a/drivers/auxdisplay/cfag12864b.c
+++ b/drivers/auxdisplay/cfag12864b.c
@@ -5,7 +5,7 @@
  * Description: cfag12864b LCD driver
  *     Depends: ks0108
  *
- *      Author: Copyright (C) Miguel Ojeda Sandonis
+ *      Author: Copyright (C) Miguel Ojeda <ojeda@kernel.org>
  *        Date: 2006-10-31
  */
 
@@ -376,5 +376,5 @@ module_init(cfag12864b_init);
 module_exit(cfag12864b_exit);
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>");
+MODULE_AUTHOR("Miguel Ojeda <ojeda@kernel.org>");
 MODULE_DESCRIPTION("cfag12864b LCD driver");
diff --git a/drivers/auxdisplay/cfag12864bfb.c b/drivers/auxdisplay/cfag12864bfb.c
index 2002291ab338..d66821adf453 100644
--- a/drivers/auxdisplay/cfag12864bfb.c
+++ b/drivers/auxdisplay/cfag12864bfb.c
@@ -5,7 +5,7 @@
  * Description: cfag12864b LCD framebuffer driver
  *     Depends: cfag12864b
  *
- *      Author: Copyright (C) Miguel Ojeda Sandonis
+ *      Author: Copyright (C) Miguel Ojeda <ojeda@kernel.org>
  *        Date: 2006-10-31
  */
 
@@ -171,5 +171,5 @@ module_init(cfag12864bfb_init);
 module_exit(cfag12864bfb_exit);
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>");
+MODULE_AUTHOR("Miguel Ojeda <ojeda@kernel.org>");
 MODULE_DESCRIPTION("cfag12864b LCD framebuffer driver");
diff --git a/drivers/auxdisplay/ks0108.c b/drivers/auxdisplay/ks0108.c
index abfe3fa9e6f4..03c95ad4216c 100644
--- a/drivers/auxdisplay/ks0108.c
+++ b/drivers/auxdisplay/ks0108.c
@@ -5,7 +5,7 @@
  * Description: ks0108 LCD Controller driver
  *     Depends: parport
  *
- *      Author: Copyright (C) Miguel Ojeda Sandonis
+ *      Author: Copyright (C) Miguel Ojeda <ojeda@kernel.org>
  *        Date: 2006-10-31
  */
 
@@ -182,6 +182,6 @@ module_init(ks0108_init);
 module_exit(ks0108_exit);
 
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>");
+MODULE_AUTHOR("Miguel Ojeda <ojeda@kernel.org>");
 MODULE_DESCRIPTION("ks0108 LCD Controller driver");
 
diff --git a/include/linux/cfag12864b.h b/include/linux/cfag12864b.h
index 4060004968c8..6617d9c68d86 100644
--- a/include/linux/cfag12864b.h
+++ b/include/linux/cfag12864b.h
@@ -4,7 +4,7 @@
  *     Version: 0.1.0
  * Description: cfag12864b LCD driver header
  *
- *      Author: Copyright (C) Miguel Ojeda Sandonis
+ *      Author: Copyright (C) Miguel Ojeda <ojeda@kernel.org>
  *        Date: 2006-10-12
  */
 
diff --git a/include/linux/ks0108.h b/include/linux/ks0108.h
index 0738389b42b6..1a37a664f915 100644
--- a/include/linux/ks0108.h
+++ b/include/linux/ks0108.h
@@ -4,7 +4,7 @@
  *     Version: 0.1.0
  * Description: ks0108 LCD Controller driver header
  *
- *      Author: Copyright (C) Miguel Ojeda Sandonis
+ *      Author: Copyright (C) Miguel Ojeda <ojeda@kernel.org>
  *        Date: 2006-10-31
  */
 
diff --git a/samples/auxdisplay/cfag12864b-example.c b/samples/auxdisplay/cfag12864b-example.c
index bfeab44f81d0..2e3bb7375c99 100644
--- a/samples/auxdisplay/cfag12864b-example.c
+++ b/samples/auxdisplay/cfag12864b-example.c
@@ -4,7 +4,7 @@
  *     Version: 0.1.0
  * Description: cfag12864b LCD userspace example program
  *
- *      Author: Copyright (C) Miguel Ojeda Sandonis
+ *      Author: Copyright (C) Miguel Ojeda <ojeda@kernel.org>
  *        Date: 2006-10-31
  */
 
-- 
2.17.1

