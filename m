Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E197E3782F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhEJKlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhEJKea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:34:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93AD461920;
        Mon, 10 May 2021 10:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620642492;
        bh=UdJoc4oz4UR45DYdDMtvCbPGRIFRoj5CojFrrsp5YdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfRyAjZ4P+TwFWlRmR+rCkGT9crzu4E2kDWzBJ8xo4ICLvjoaH060nJcgEqj5kvP0
         TMhGA9z9a6DWW1G78C1WWJlh1t3dTF7258EjZe1RM8fWswrUVpIbQlsGAhDtFiPMsk
         BThjZ8Gn3RRyU1hjvL8iqdfGvngscKdrki7RQmoPLO7NML/Q2fWiHfF/+Qk6hSvi/i
         joiT2z1wwDuGv5xxFgVOUbjktooRSOekK+r1NoMMBUhimlD823uwaGriVjFr25OJ+j
         kJdAcVkqNnj0/U2nRSpLTF5vQWuIEcz7szRR6uoW7s3p8pyAOo1fcT4GIWWYOkh6eI
         qFY12nfZZg35g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lg38z-000UYK-Id; Mon, 10 May 2021 12:28:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 49/53] docs: misc-devices: ibmvmc.rst: avoid using UTF-8 chars
Date:   Mon, 10 May 2021 12:27:01 +0200
Message-Id: <870e02b2fa71498907e6fc3a8bf43b0060f5b831.1620641727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620641727.git.mchehab+huawei@kernel.org>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While UTF-8 characters can be used at the Linux documentation,
the best is to use them only when ASCII doesn't offer a good replacement.
So, replace the occurences of the following UTF-8 characters:

	- U+2019 ('’'): RIGHT SINGLE QUOTATION MARK

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/misc-devices/ibmvmc.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/misc-devices/ibmvmc.rst b/Documentation/misc-devices/ibmvmc.rst
index b46df4ea2b81..b075211c6dce 100644
--- a/Documentation/misc-devices/ibmvmc.rst
+++ b/Documentation/misc-devices/ibmvmc.rst
@@ -36,7 +36,7 @@ Management Application
 ----------------------
 
 In the management partition, a management application exists which enables
-a system administrator to configure the system’s partitioning
+a system administrator to configure the system's partitioning
 characteristics via a command line interface (CLI) or Representational
 State Transfer Application (REST API's).
 
@@ -108,7 +108,7 @@ This section provides an example for the management application
 implementation where a device driver is used to interface to the VMC
 device. This driver consists of a new device, for example /dev/ibmvmc,
 which provides interfaces to open, close, read, write, and perform
-ioctl’s against the VMC device.
+ioctl's against the VMC device.
 
 VMC Interface Initialization
 ----------------------------
@@ -177,14 +177,14 @@ VMC Interface Runtime
 During normal runtime, the management application and the hypervisor
 exchange HMC messages via the Signal VMC message and RDMA operations. When
 sending data to the hypervisor, the management application performs a
-write() to the VMC device, and the driver RDMA’s the data to the hypervisor
+write() to the VMC device, and the driver RDMA's the data to the hypervisor
 and then sends a Signal Message. If a write() is attempted before VMC
 device buffers have been made available by the hypervisor, or no buffers
 are currently available, EBUSY is returned in response to the write(). A
 write() will return EIO for all other errors, such as an invalid device
 state. When the hypervisor sends a message to the management, the data is
 put into a VMC buffer and an Signal Message is sent to the VMC driver in
-the management partition. The driver RDMA’s the buffer into the partition
+the management partition. The driver RDMA's the buffer into the partition
 and passes the data up to the appropriate management application via a
 read() to the VMC device. The read() request blocks if there is no buffer
 available to read. The management application may use select() to wait for
-- 
2.30.2

