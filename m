Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1030F40B23D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbhINO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234363AbhINO4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7DB9B6113B;
        Tue, 14 Sep 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631328;
        bh=QC67BJg7ZAdm46Ej3uu4GekTnusX8K0SxeusxKKINvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZjs80UuZEZUU6lIOQ3uBu4QArNdhbSo/ZdgDtVgn2HjzG4U3KHg0zuuUCqzsbTLm
         5ncsahcrwOjUJT+6c9WLUh+ESPFRVlTyCg1xZeBVy5a9UY7tbQpQPpkwHQqhgHOSFq
         BixHkdxF7PFiqPp/6OILepbycc/l7PvL+XIcGESIqx9hp4t9jFGulXG9izNTu7mosK
         jVEOPH83URPaHKW1laDxTwfXsyJnM9Mup/AEwtIkV5YV/P0iz0URKQFqENxnzvcKsW
         +WI3bmGYBo7iQO1XOA8T1klIcAabjzOZ1uKF+FMZypoYduW7TXoUOCgiwkEnY2rZtZ
         1wsBYllu41RHA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9qI-000L75-Qa; Tue, 14 Sep 2021 16:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Carlos Bilbao <bilbao@vt.edu>,
        Leon Romanovsky <leon@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/8] ABI: sysfs-bus-pci: add documentation for modalias
Date:   Tue, 14 Sep 2021 16:55:19 +0200
Message-Id: <c2dfcf56d156a13d9c7c82122efdb64ddbc4e7d9.1631630792.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631630792.git.mchehab+huawei@kernel.org>
References: <cover.1631630792.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even being available since 2005, there's no documentation for
modalias.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-bus-pci | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 191cbe9ae5ed..1da4c8db3a9e 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -187,6 +187,23 @@ Description:
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

