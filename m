Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8724195BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhI0OCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234707AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51EBD610FC;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=Dy6yJbWGfU8oB93VTtRBfZ0kl+qSmY3j7H3gVwdQRZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEzlXLR8gr1Yz4WcvnjIN69EI/N4AQBoFurgrOLvq2ychYRNYyIIHIAZO8IK7/J9G
         OStPM6aR7dIvRwxsZ7n+9NBow3r956aIZsjXkn5VfB5kwTgdFI5IDAa9ATYHIv/uiv
         gMhqA1enLs7kzYGXIWUVOu1nF26e0DywN4ImXLr1ztzloJ7LZVz/dneLHn4oGjhXkp
         MO2etskUxH19DrRhe3Lpl87kEyKs8p6nB8obbZ/7rImGTRzUEpAdvBX7Ks7H93lSzd
         +4hA41D5lLTWXI3maVwJvX/ob8AdDOY+nZg65nfR907OIM+l8mM0+atcgQ7xii0pU8
         in1sNcjr1lhRg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000AuA-LL; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/17] ABI: sysfs-bus-pci: add a alternative What fields
Date:   Mon, 27 Sep 2021 15:59:43 +0200
Message-Id: <15ba8c07f1b0fd7359106920c8e34a7b9af7aea6.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some PCI ABI that aren't shown under:

	/sys/bus/pci/drivers/.../

Because they're registered with a different class. That's
the case of, for instance:

	/sys/bus/i2c/drivers/CHT Whiskey Cove PMIC/unbind

This one is not present under /sys/bus/pci:

	$ find /sys/bus/pci -name 'CHT Whiskey Cove PMIC'

Although clearly this is provided by a PCI driver:

	/sys/devices/pci0000:00/0000:00:02.0/i2c-4/subsystem/drivers/CHT Whiskey Cove PMIC/unbind

So, add an altertate What location in order to match bind/unbind
to such devices.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-bus-pci | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 1eeac7f59672..16afe3f59cbd 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -1,4 +1,5 @@
 What:		/sys/bus/pci/drivers/.../bind
+What:		/sys/devices/pciX/.../bind
 Date:		December 2003
 Contact:	linux-pci@vger.kernel.org
 Description:
@@ -14,6 +15,7 @@ Description:
 		(Note: kernels before 2.6.28 may require echo -n).
 
 What:		/sys/bus/pci/drivers/.../unbind
+What:		/sys/devices/pciX/.../unbind
 Date:		December 2003
 Contact:	linux-pci@vger.kernel.org
 Description:
@@ -29,6 +31,7 @@ Description:
 		(Note: kernels before 2.6.28 may require echo -n).
 
 What:		/sys/bus/pci/drivers/.../new_id
+What:		/sys/devices/pciX/.../new_id
 Date:		December 2003
 Contact:	linux-pci@vger.kernel.org
 Description:
@@ -47,6 +50,7 @@ Description:
 		  # echo "8086 10f5" > /sys/bus/pci/drivers/foo/new_id
 
 What:		/sys/bus/pci/drivers/.../remove_id
+What:		/sys/devices/pciX/.../remove_id
 Date:		February 2009
 Contact:	Chris Wright <chrisw@sous-sol.org>
 Description:
-- 
2.31.1

