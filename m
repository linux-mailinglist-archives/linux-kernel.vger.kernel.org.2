Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F163637BD6F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhELM4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhELMxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5C0361400;
        Wed, 12 May 2021 12:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620823907;
        bh=1yrj5M30NmRCy5DABQ6Bqz4By6Wgg6wO7dCpsCSrEPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXXGKBOFIN0un+grTYzFKdj3/XfH2UsemybWM1pUxm5U+u54N6YcuMpxRcYMbDyXJ
         UrAxj6omBfnuKqkC6OrvSDCN56apof65moEExGjrTVqEYavzx6ZsTm7BexgD58bx4B
         SdNL8xy0g4qYxcSMYjsFvIBfORDTP4d1QHnWPMFN7DxQMcAxH7Fp5zdELRkpo4oTLx
         8nxzVLG4678H/e3GYwZGCr6+cDQoBFR1Rlj7Hqf7cYCNg/TbyNdOjxvXlXeK5n+mjL
         DrClPOWz/GRbyds9i7KfqRXVYpSLqlv6cRpQhH8T98f30tAt2pKCF0Vtp53K2PS4FZ
         yrPFmwFGykhAA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lgoL3-0018ni-Pj; Wed, 12 May 2021 14:51:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/40] docs: misc-devices: ibmvmc.rst: Use ASCII subset instead of UTF-8 alternate symbols
Date:   Wed, 12 May 2021 14:50:40 +0200
Message-Id: <7d7c879ce9542de7d1612b70ec85a1b879744064.1620823573.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620823573.git.mchehab+huawei@kernel.org>
References: <cover.1620823573.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion tools used during DocBook/LaTeX/Markdown->ReST conversion
and some automatic rules which exists on certain text editors like
LibreOffice turned ASCII characters into some UTF-8 alternatives that
are better displayed on html and PDF.

While it is OK to use UTF-8 characters in Linux, it is better to
use the ASCII subset instead of using an UTF-8 equivalent character
as it makes life easier for tools like grep, and are easier to edit
with the some commonly used text/source code editors.

Also, Sphinx already do such conversion automatically outside literal blocks:
   https://docutils.sourceforge.io/docs/user/smartquotes.html

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

