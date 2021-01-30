Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E56309160
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 02:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhA3BxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 20:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbhA3Bro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 20:47:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4AC061573;
        Fri, 29 Jan 2021 17:46:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 565531F45F7F
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 1/2] docs: Make syscalls' helpers naming consistent
Date:   Fri, 29 Jan 2021 22:45:46 -0300
Message-Id: <20210130014547.123006-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation explains the need to create internal syscalls' helpers,
and that they should be called `kern_xyzzy()`. However, the comment at
include/linux/syscall.h says that they should be named as
`ksys_xyzzy()`, and so are all the helpers declared bellow it. Change the
documentation to reflect this.

Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Fixes: 819671ff849b ("syscalls: define and explain goal to not call syscalls in the kernel")
Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/process/adding-syscalls.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index a3ecb236576c..61bdaec188ea 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -501,7 +501,7 @@ table, but not from elsewhere in the kernel.  If the syscall functionality is
 useful to be used within the kernel, needs to be shared between an old and a
 new syscall, or needs to be shared between a syscall and its compatibility
 variant, it should be implemented by means of a "helper" function (such as
-``kern_xyzzy()``).  This kernel function may then be called within the
+``ksys_xyzzy()``).  This kernel function may then be called within the
 syscall stub (``sys_xyzzy()``), the compatibility syscall stub
 (``compat_sys_xyzzy()``), and/or other kernel code.
 
-- 
2.30.0

