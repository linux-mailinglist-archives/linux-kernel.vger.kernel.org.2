Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179C04195C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234836AbhI0OCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234709AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 726B7611C7;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=dfQV/wMfYqwW1vFBGv8r+gNurdBocYKKwQRV6MPpuzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6RDFibEDJJtwpm3dZrryYDfgmo/Jbi9q0t7bCKli4unFpC81w4aUnHAWtPdBufE/
         TWs+dSPq4z6z5A71ehdfPp9/66bZ1a7126rwX4Xk8VBazrXaD12vDgv9ubMZhZHvRy
         8SiWII4rz/FRvvIXcLXApdXPyCNsJe9vLpnkldz1YL3vGAEhLZKanTJ3WSDTnVkyH7
         qLTrTXWEm/sMpGNCkmw7b/6LvjOFpE97JBoOEYE8Mh6OLNMEcmKFuV0mtng97kiUzb
         TsoY5EmGyB/eLCmHb7H+2C2JJdK6e7Ju8Wx/XnMJ2EmeGhL4a1RuZ5kASnWiR4/Hgk
         uL2MvA66nKH0w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000AuI-PA; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/17] ABI: sysfs-bus-mdio: add alternate What for mdio symbols
Date:   Mon, 27 Sep 2021 15:59:45 +0200
Message-Id: <aa51f6c2d482b28a349ba67e2a3904564e67496b.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all sysfs nodes are shown under:
	/sys/bus/mdio_bus/devices/...
They can also be at:
	/sys/class/mdio_bus/.../

So, update the What: entries to allow both.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-bus-mdio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-mdio b/Documentation/ABI/testing/sysfs-bus-mdio
index da86efc7781b..38be04dfc05e 100644
--- a/Documentation/ABI/testing/sysfs-bus-mdio
+++ b/Documentation/ABI/testing/sysfs-bus-mdio
@@ -1,4 +1,5 @@
 What:          /sys/bus/mdio_bus/devices/.../statistics/
+What:          /sys/class/mdio_bus/.../statistics/
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
@@ -7,6 +8,7 @@ Description:
 		MDIO bus address statistics.
 
 What:          /sys/bus/mdio_bus/devices/.../statistics/transfers
+What:          /sys/class/mdio_bus/.../transfers
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
@@ -14,6 +16,7 @@ Description:
 		Total number of transfers for this MDIO bus.
 
 What:          /sys/bus/mdio_bus/devices/.../statistics/errors
+What:          /sys/class/mdio_bus/.../statistics/errors
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
@@ -21,6 +24,7 @@ Description:
 		Total number of transfer errors for this MDIO bus.
 
 What:          /sys/bus/mdio_bus/devices/.../statistics/writes
+What:          /sys/class/mdio_bus/.../statistics/writes
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
@@ -28,6 +32,7 @@ Description:
 		Total number of write transactions for this MDIO bus.
 
 What:          /sys/bus/mdio_bus/devices/.../statistics/reads
+What:          /sys/class/mdio_bus/.../statistics/reads
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
@@ -35,6 +40,7 @@ Description:
 		Total number of read transactions for this MDIO bus.
 
 What:          /sys/bus/mdio_bus/devices/.../statistics/transfers_<addr>
+What:          /sys/class/mdio_bus/.../statistics/transfers_<addr>
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
@@ -42,6 +48,7 @@ Description:
 		Total number of transfers for this MDIO bus address.
 
 What:          /sys/bus/mdio_bus/devices/.../statistics/errors_<addr>
+What:          /sys/class/mdio_bus/.../statistics/errors_<addr>
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
@@ -49,6 +56,7 @@ Description:
 		Total number of transfer errors for this MDIO bus address.
 
 What:          /sys/bus/mdio_bus/devices/.../statistics/writes_<addr>
+What:          /sys/class/mdio_bus/.../statistics/writes_<addr>
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
@@ -56,6 +64,7 @@ Description:
 		Total number of write transactions for this MDIO bus address.
 
 What:          /sys/bus/mdio_bus/devices/.../statistics/reads_<addr>
+What:          /sys/class/mdio_bus/.../statistics/reads_<addr>
 Date:          January 2020
 KernelVersion: 5.6
 Contact:       netdev@vger.kernel.org
-- 
2.31.1

