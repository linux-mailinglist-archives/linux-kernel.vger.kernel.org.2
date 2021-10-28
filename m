Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA943DC97
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 09:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhJ1ICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 04:02:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:50965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhJ1IB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635407962;
        bh=jmSqqwsTmKlXEHUVDmzYrAqJX1kVbs9mcRUpYNGTweA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cVZ7YNWY0mvx2BhH7pIDHOixPNAqsGFIHTU0UORN/+LotTb91Qubs2lv1MiEY+Veb
         u3hbcLuLYyAPq24MsvboZTB35viRmPy95YJX/TDs1pr13L8INAApHKMrBa+bFB81eR
         hrKn8bDyfXic73Egyss3q8/08M3sOCdyiKyegjvg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.131]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M8ygY-1mc8xr1x4w-006APr; Thu, 28 Oct 2021 09:59:22 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id 2F5EA27FC40; Thu, 28 Oct 2021 00:59:15 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     richard@nod.at, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>
Subject: [PATCH] ubifs: document sysfs nodes
Date:   Thu, 28 Oct 2021 00:44:04 -0700
Message-Id: <20211028074404.9739-1-schaecsn@gmx.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jrw2wLUw4vnbpuLx6LVkh6aLNEeKDC0j/lA3eLQnyEl3bzpfbMo
 cYHcKPjRQQdehc4J7zv+tCNluHs1XcdKguzIp/DN8Pp4u80OalAOWyjMxvBYJtnrAixhqYg
 BNy4B/Tk3NKHYKZht6t7c3Fa0hDo1JHMegaGSwKMuMHPjJKI9b/fivXKFayEcW29NGaVnP5
 YnYluGMXJKR5n1J7Qg1BA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KP6gfw0l2A4=:ioIF4Tgg4ilz/G/7/eoSDS
 OiWyY4SR7zwrzNKZH5BiPzmnKWt+pPSZs3GK067+d83ku7CHtlugdCbVARj9XHwB4XNir/a9b
 Avq1qzSjM2rExvGKKcstL9UvT6p1HzCkpK6JVKgm+YO8uUswgj6THgGgUechuD3EmCfd0Ad8e
 aBP5X4h3tNb5arGEW5qJd30qhgOe1mTRuEw71hK8UARGOhf5SaYY2/IalzmiXMhTStTOz9fuu
 mRwnS9eM8aPqCSmu8oxDm5B6n5NW48LtSkED+NljYqL0tXOAptrf1s+FUHwPCdvnNDd75eDgm
 25jIu9w15Ife2Ho8afpYt+TXCD49EBiq9GtJHTNtrVwSMiEnfgxoODwVlXx3U/3ZhoCdSxbX1
 pdA/o2OpbA7krONhR3tLV/SNsTWSma6GZBQvQvpWxKk8nBarZS1ssg9jL9/hr042x0QNFZz3s
 BNv7/xJCejRjJbZr0jCPx7esowpI/RyZTN4/e5pgcttgS2WaYW50DBeio7ZA1XbK8qE1PyBQM
 TFkWbi9yeuadhke/pWvzRa1PYB2FZxNLM8d+Au2rayV0/TWa2cOO4dZfVRH2qKdqXLznF5d+v
 NYu8kEKYJTktL+55d3uiOMs59O06cAIUDZAmaHNyO1PR6BxVUgcghDUNZ+Limc25HoYKpbY0B
 R9IFkNSjuFhNkpbEDcZoGN+qBNKBT2dlpUqcaS1RgQ2osYVSg1s5Pdcxi9x+Bu/dNDF1MnQNG
 aTT9GBp2+N8+PR1VOIY4l+q71rYozX4ik3Oa0u4Bm9H+nyhCqy8w+MrtLE0KPUMxYE25bnibz
 5t/JDQGl8MJtnzvyqSLQulH8ffpLNVZHdZqM9qr3sNVrKYMsqNKJG5g8+O0W2mR0NCL/cQBoE
 uydkoD6qN/2L3LG6g1GxygBNjdfWKQq+rj1lLzuYRHiZlvdArSWT/Vciwek7XzWB/MwMLu79K
 wrJxu7a0qLCUUdFYF3jsN02kpDVFTii3T9OoBuruF1WPwPvtwG33ZWsT5rpqk/CiorehXZaVz
 jDNtP/nH021k3kGGxPA3FEKBhQf7A8hKb/NPzzIOioEossHKshmzm7b+XPwiiUkYdXVysiOJa
 2sZsB8/Ggi1KAo=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Schaeckeler <sschaeck@cisco.com>

Add documentation for the new sysfs nodes

 /sys/fs/ubifs/ubiX_Y/errors_magic
 /sys/fs/ubifs/ubiX_Y/errors_node
 /sys/fs/ubifs/ubiX_Y/errors_crc

Signed-off-by: Stefan Schaeckeler <sschaeck@cisco.com>
=2D--
 Documentation/ABI/testing/sysfs-fs-ubifs | 35 ++++++++++++++++++++++++
 MAINTAINERS                              |  1 +
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-fs-ubifs

diff --git a/Documentation/ABI/testing/sysfs-fs-ubifs b/Documentation/ABI/=
testing/sysfs-fs-ubifs
new file mode 100644
index 000000000000..19a8ebf7fe61
=2D-- /dev/null
+++ b/Documentation/ABI/testing/sysfs-fs-ubifs
@@ -0,0 +1,35 @@
+What:		/sys/fs/ubifsX_Y/error_magic
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	linux-mtd@lists.infradead.org
+Description:
+		Exposes magic errors: every node starts with a magic number.
+
+		This counter keeps track of the number of accesses of nodes
+		with a corrupted magic number.
+
+		The counter is reset to 0 with a remount.
+
+What:		/sys/fs/ubifsX_Y/error_node
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	linux-mtd@lists.infradead.org
+Description:
+		Exposes node errors. Every node embeds its type.
+
+		This counter keeps track of the number of accesses of nodes
+		with a corrupted node type.
+
+		The counter is reset to 0 with a remount.
+
+What:		/sys/fs/ubifsX_Y/error_crc
+Date:		October 2021
+KernelVersion:	5.16
+Contact:	linux-mtd@lists.infradead.org
+Description:
+		Exposes crc errors: every node embeds a crc checksum.
+
+		This counter keeps track of the number of accesses of nodes
+		with a bad crc checksum.
+
+		The counter is reset to 0 with a remount.
diff --git a/MAINTAINERS b/MAINTAINERS
index b43662a9a5f3..a8f0e3e38b2e 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19105,6 +19105,7 @@ S:	Supported
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git fixes
+F:	Documentation/ABI/testing/sysfs-fs-ubifs
 F:	Documentation/filesystems/ubifs-authentication.rst
 F:	Documentation/filesystems/ubifs.rst
 F:	fs/ubifs/
=2D-
2.33.0

