Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034E24195BB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhI0OBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234705AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CAE6109F;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=UKfUww/5UHEYY8CpMBzjLtL4qHBzffzX9FZNntH/pzM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tt5g4K4YEpa6J3h87ubuJ775ZNBbobsAXcxPMX54cC2bdv1TAqhRH4vssYy6v8iyk
         WgRz5MvoLXQo4HG1hTZ/mPVrcUZzvk1NDWmodwyhmN8g8NMuqyaZkFiNtiAiQOMZ8T
         B94VFfyt7UZ+DNboyTp64vxVsq5bfZxOOPU8EkyeOFsmkqwBxq1q0deaYUtzUwpkBy
         y0xjN3h/Idy/zzGxwVLg72AOPhxZjkYBepVYzr1Zt9Y5SjRKRN7Zhy7d/6AeTtwr5h
         RAl7PzwuuQRVDG+8mUO+mpKWH393o0XhGge6buAWNN8r86PKW7fGfwALm11B/eporv
         o2tno0w6FXMRA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000Atu-Fd; Mon, 27 Sep 2021 15:59:55 +0200
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] ABI: sysfs-bus-pci: add documentation for modalias
Date:   Mon, 27 Sep 2021 15:59:39 +0200
Message-Id: <9ceb1fcdbef3c0d2d0368dcc2f19084a3e529ad1.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even being available since 2005, there's no documentation for
modalias.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-bus-pci | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 191cbe9ae5ed..1eeac7f59672 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -187,6 +187,24 @@ Description:
 		The symbolic link points to the PCI device sysfs entry of the
 		Physical Function this device associates with.
 
+What:		/sys/bus/pci/devices/.../modalias
+Date:		May 2005
+Contact:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
+Description:
+		This attribute indicates the PCI ID of the device object.
+
+		That is in the format:
+		pci:vXXXXXXXXdXXXXXXXXsvXXXXXXXXsdXXXXXXXXbcXXscXXiXX,
+		where:
+
+		    - vXXXXXXXX contains the vendor ID;
+		    - dXXXXXXXX contains the device ID;
+		    - svXXXXXXXX contains the sub-vendor ID;
+		    - sdXXXXXXXX contains the subsystem device ID;
+		    - bcXX contains the device class;
+		    - scXX contains the device subclass;
+		    - iXX contains the device class programming interface.
+
 What:		/sys/bus/pci/slots/.../module
 Date:		June 2009
 Contact:	linux-pci@vger.kernel.org
-- 
2.31.1

