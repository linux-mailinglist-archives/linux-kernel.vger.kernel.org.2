Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3375377C59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 08:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhEJGhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 02:37:50 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:53210 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhEJGhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 02:37:41 -0400
Received: from grover.RMN.KIBA.LAB.jp (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 14A6YxH0003613;
        Mon, 10 May 2021 15:34:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 14A6YxH0003613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1620628499;
        bh=e/0+RGU/gXpjUsv0GjepNVE7UR1CxN1tEMFB6WK1yEI=;
        h=From:To:Cc:Subject:Date:From;
        b=ItzoS/KNLbulRESVJp4se9V73mqAUaShEXMuUTix0v+0tmLwV9dngxwcuFHnmcLM+
         ld/FUT3vd+DYoAX0g2yt58LrVRWcVHAViB/BxwujLd1EY57hD+A4X4YNdJOwnAtP1O
         qqaBK2qN247xeTsftaOC18DfEEJyIh/VhunYiNlryeC30B33KGXhkgUjfYpOdtSv33
         MWVu4z1ybsuFz34uqmKVb32fJPvzNTiWH3X+iAjSOO+bQXGJATsbfHyuUVewlYmUs1
         WoseLqnSkVRNH6ahdahfGG7u7rxS86Hm5rSFfzdA7/JByrN8TfQSxr9qYXKh5GCxus
         drE2pKxkN2Fiw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        Qiheng Lin <linqiheng@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] comedi: remove editor modelines and cruft (again)
Date:   Mon, 10 May 2021 15:34:50 +0900
Message-Id: <20210510063450.412055-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fa60ce2cb450 ("treewide: remove editor modelines and cruft")
is different from what I submitted.

My original patch [1] did treewide cleanups including the comedi driver.

Unfortunately, commit 8ffdff6a8cfb ("staging: comedi: move out of staging
directory") moved drivers/staging/comedi/ to drivers/comedi/ before my
patch landed on Linus' tree from akpm tree.

If Andrew Morton had used Git, 'git merge' would have resolved such file
moves properly without any manual intervention.

Patches in akpm tree often get broken in his quilt workflows, and then
people end up with sending fixup patches.

[1] https://lkml.kernel.org/r/20210324054457.1477489-1-masahiroy@kernel.org

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I really hope Andrew Morton will use Git.


 drivers/comedi/drivers/ni_routes.c                         | 1 -
 drivers/comedi/drivers/ni_routes.h                         | 1 -
 drivers/comedi/drivers/ni_routing/ni_device_routes.c       | 1 -
 drivers/comedi/drivers/ni_routing/ni_device_routes.h       | 1 -
 drivers/comedi/drivers/ni_routing/ni_device_routes/all.h   | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6220.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6221.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6229.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6251.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6254.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6259.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6534.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6602.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6713.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6723.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pci-6733.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c  | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c | 1 -
 .../comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c | 1 -
 drivers/comedi/drivers/ni_routing/ni_route_values.c        | 1 -
 drivers/comedi/drivers/ni_routing/ni_route_values.h        | 1 -
 drivers/comedi/drivers/ni_routing/ni_route_values/all.h    | 1 -
 .../comedi/drivers/ni_routing/ni_route_values/ni_660x.c    | 1 -
 .../comedi/drivers/ni_routing/ni_route_values/ni_eseries.c | 1 -
 .../comedi/drivers/ni_routing/ni_route_values/ni_mseries.c | 1 -
 drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c  | 1 -
 .../comedi/drivers/ni_routing/tools/convert_csv_to_c.py    | 7 -------
 .../comedi/drivers/ni_routing/tools/convert_py_to_csv.py   | 1 -
 drivers/comedi/drivers/ni_routing/tools/csv_collection.py  | 1 -
 drivers/comedi/drivers/ni_routing/tools/make_blank_csv.py  | 1 -
 drivers/comedi/drivers/ni_routing/tools/ni_names.py        | 1 -
 drivers/comedi/drivers/tests/comedi_example_test.c         | 1 -
 drivers/comedi/drivers/tests/ni_routes_test.c              | 1 -
 drivers/comedi/drivers/tests/unittest.h                    | 1 -
 40 files changed, 46 deletions(-)

diff --git a/drivers/comedi/drivers/ni_routes.c b/drivers/comedi/drivers/ni_routes.c
index c426a9286f15..1f2aa3b239a0 100644
--- a/drivers/comedi/drivers/ni_routes.c
+++ b/drivers/comedi/drivers/ni_routes.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routes.c
  *  Route information for NI boards.
diff --git a/drivers/comedi/drivers/ni_routes.h b/drivers/comedi/drivers/ni_routes.h
index b7680fd2afe1..036982315584 100644
--- a/drivers/comedi/drivers/ni_routes.h
+++ b/drivers/comedi/drivers/ni_routes.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routes.h
  *  Route information for NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes.c b/drivers/comedi/drivers/ni_routing/ni_device_routes.c
index 7b6a74dfe48b..58654c2b12d6 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes.h b/drivers/comedi/drivers/ni_routing/ni_device_routes.h
index b9f1c47d19e1..09e4e172c659 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes.h
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/all.h b/drivers/comedi/drivers/ni_routing/ni_device_routes/all.h
index 78b24138acb7..001dbb88a874 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/all.h
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/all.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/all.h
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
index f1126a0cb285..7d3064c92643 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6070e.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
index 74a59222963f..e2c462edb8ec 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6220.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
index 44dcbabf2a99..9e02ec0a66ad 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6221.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
index fa5794e4e2b3..33f7fff61f74 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6229.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
index 645fd1cd2de4..dde676b73624 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6251.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
index 056a240cd3a2..167a2da97c14 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6254.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
index e0b5fa78c3bc..ba990f98590c 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6259.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
index a2472ed288cf..f8d2a91b6c0a 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6534.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
index 91de9dac2d6a..2eee91f590eb 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6602.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
index d378b36d2084..c07ef3584a4b 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6713.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
index e0cc57ab06e7..c37373f8f0e1 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6723.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
index f6e1e17ab854..f252fbe19638 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pci-6733.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
index 9978d632117f..4ccba4fdf3bc 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6030e.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
index 1b89e27d7aa5..84fdfa2ef9a7 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6224.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
index 10dfc34bc87c..2b99ce0f87a4 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6225.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
index 25db4b7363de..1c5164c46306 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6251.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
index 27da4433fc4a..a3402b1ca6e8 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxi-6733.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
index 8354fe971d59..defcc4cfe1e4 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxie-6251.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
index 2ebb679e0129..d2013b9e6767 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxie-6535.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
index d88504314d7f..89aff39a4fc2 100644
--- a/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
+++ b/drivers/comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_device_routes/pxie-6738.c
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values.c b/drivers/comedi/drivers/ni_routing/ni_route_values.c
index 5901762734ed..54a740b39819 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values.c
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values.c
  *  Route information for NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values.h b/drivers/comedi/drivers/ni_routing/ni_route_values.h
index 80e0145fb82b..6e358efa6f7f 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values.h
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values.h
  *  Route information for NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values/all.h b/drivers/comedi/drivers/ni_routing/ni_route_values/all.h
index 7227461500b5..30761e55f746 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values/all.h
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values/all.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values/all.h
  *  List of valid routes for specific NI boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values/ni_660x.c b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
index f1c7e6646261..aace60e49507 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_660x.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values/ni_660x.c
  *  Route information for NI_660X boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
index d1ab3c9ce585..7a52f024cdbd 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values/ni_eseries.c
  *  Route information for NI_ESERIES boards.
diff --git a/drivers/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
index c59d8afe0ae9..d1ddd13b33b5 100644
--- a/drivers/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
+++ b/drivers/comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/ni_route_values/ni_mseries.c
  *  Route information for NI_MSERIES boards.
diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
index dedb6f2fc678..d55521b5bdcb 100644
--- a/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_c_to_py.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 
 #include <stdint.h>
 #include <stdbool.h>
diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
index 532eb6372a5a..90378fb50580 100755
--- a/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_csv_to_c.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 
 # This is simply to aide in creating the entries in the order of the value of
 # the device-global NI signal/terminal constants defined in comedi.h
@@ -123,7 +122,6 @@ class DeviceRoutes(CSVCollection):
 
   output_file_top = """\
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  List of valid routes for specific NI boards.
@@ -155,7 +153,6 @@ class DeviceRoutes(CSVCollection):
 
   extern_header = """\
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  List of valid routes for specific NI boards.
@@ -193,7 +190,6 @@ class DeviceRoutes(CSVCollection):
 
   single_output_file_top = """\
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  List of valid routes for specific NI boards.
@@ -299,7 +295,6 @@ class RouteValues(CSVCollection):
 
   output_file_top = """\
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  Route information for NI boards.
@@ -337,7 +332,6 @@ class RouteValues(CSVCollection):
 
   extern_header = """\
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  List of valid routes for specific NI boards.
@@ -375,7 +369,6 @@ class RouteValues(CSVCollection):
 
   single_output_file_top = """\
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/ni_routing/{filename}
  *  Route information for {sheet} boards.
diff --git a/drivers/comedi/drivers/ni_routing/tools/convert_py_to_csv.py b/drivers/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
index b3e6472bac22..a273b33edb8f 100755
--- a/drivers/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
+++ b/drivers/comedi/drivers/ni_routing/tools/convert_py_to_csv.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 
 from os import path
 import os, csv
diff --git a/drivers/comedi/drivers/ni_routing/tools/csv_collection.py b/drivers/comedi/drivers/ni_routing/tools/csv_collection.py
index 12617329a928..db977ecb4307 100644
--- a/drivers/comedi/drivers/ni_routing/tools/csv_collection.py
+++ b/drivers/comedi/drivers/ni_routing/tools/csv_collection.py
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 
 import os, csv, glob
 
diff --git a/drivers/comedi/drivers/ni_routing/tools/make_blank_csv.py b/drivers/comedi/drivers/ni_routing/tools/make_blank_csv.py
index 89c90a0ba24d..c00eaf803299 100755
--- a/drivers/comedi/drivers/ni_routing/tools/make_blank_csv.py
+++ b/drivers/comedi/drivers/ni_routing/tools/make_blank_csv.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 
 from os import path
 import os, csv
diff --git a/drivers/comedi/drivers/ni_routing/tools/ni_names.py b/drivers/comedi/drivers/ni_routing/tools/ni_names.py
index 5f9b825968b1..d4df5f29e3e5 100644
--- a/drivers/comedi/drivers/ni_routing/tools/ni_names.py
+++ b/drivers/comedi/drivers/ni_routing/tools/ni_names.py
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0+
-# vim: ts=2:sw=2:et:tw=80:nowrap
 """
 This file helps to extract string names of NI signals as included in comedi.h
 between NI_NAMES_BASE and NI_NAMES_BASE+NI_NUM_NAMES.
diff --git a/drivers/comedi/drivers/tests/comedi_example_test.c b/drivers/comedi/drivers/tests/comedi_example_test.c
index e5aaaeab7bdd..81d074bcdea5 100644
--- a/drivers/comedi/drivers/tests/comedi_example_test.c
+++ b/drivers/comedi/drivers/tests/comedi_example_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/tests/comedi_example_test.c
  *  Example set of unit tests.
diff --git a/drivers/comedi/drivers/tests/ni_routes_test.c b/drivers/comedi/drivers/tests/ni_routes_test.c
index 32073850d545..652362486ff6 100644
--- a/drivers/comedi/drivers/tests/ni_routes_test.c
+++ b/drivers/comedi/drivers/tests/ni_routes_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/tests/ni_routes_test.c
  *  Unit tests for NI routes (ni_routes.c module).
diff --git a/drivers/comedi/drivers/tests/unittest.h b/drivers/comedi/drivers/tests/unittest.h
index 2da3beea2479..b0b34e058aad 100644
--- a/drivers/comedi/drivers/tests/unittest.h
+++ b/drivers/comedi/drivers/tests/unittest.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* vim: set ts=8 sw=8 noet tw=80 nowrap: */
 /*
  *  comedi/drivers/tests/unittest.h
  *  Simple framework for unittests for comedi drivers.
-- 
2.27.0

