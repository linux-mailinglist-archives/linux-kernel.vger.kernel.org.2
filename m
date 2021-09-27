Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FBE4195B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhI0OBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234704AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49A8A610A2;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=JSJGD8oEtr4UgVNxX4nTLt/BvMiQeGS7fW3nJC9PfHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0vKUaz5FtH5vI9VuGPWauA82jY05IzDAg8jcZvx46YnD5FnY0u3DCvuQhWi7ZlRL
         7C2FDDA0WP/CyN4GzGQoKfc2UqWLHtpbmSRnSkkvW1uzaqkRLd4AMUzz56uJAeOU+w
         97VfpOXhBctYEEZQMLi0QwkzFx0FMEfvr5uS4GIJlkXLrcfnffhd6EeZg3G3gsJcjg
         gceAnm9oixMQQ703pe23KCFo5EiBHcag7vAYdDLInn6SdswB7HdviOwzXIdytkrK8y
         Nrz1Z3b+nmjP/q344St1utX17jnjsicd1ZyvHXqwJ550Ok78We1+1P8CyEX46eQOjk
         5yYm2iIT6jdUQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000Ata-8i; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/17] ABI: stable/sysfs-module: better document modules
Date:   Mon, 27 Sep 2021 15:59:34 +0200
Message-Id: <35876c1eabbcd03170d658081030db980b403297.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of placing almost everything there as a text, use
the proper What: for each component of the ABI.

This allows it to be better documented and parsed by
get_abi.pl.

While here, use wildcards for MODULENAME.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/stable/sysfs-module | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 6272ae5fb366..5c028af9921a 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -1,8 +1,7 @@
-What:		/sys/module
-Description:
-	The /sys/module tree consists of the following structure:
+The /sys/module tree consists of the following structure:
 
-	/sys/module/MODULENAME
+What:		/sys/module/<MODULENAME>
+Description:
 		The name of the module that is in the kernel.  This
 		module name will always show up if the module is loaded as a
 		dynamic module.  If it is built directly into the kernel, it
@@ -12,7 +11,8 @@ Description:
 		Note: The conditions of creation in the built-in case are not
 		by design and may be removed in the future.
 
-	/sys/module/MODULENAME/parameters
+What:		/sys/module/<MODULENAME>/parameters
+Description:
 		This directory contains individual files that are each
 		individual parameters of the module that are able to be
 		changed at runtime.  See the individual module
@@ -25,7 +25,8 @@ Description:
 		individual driver documentation for details as to the
 		stability of the different parameters.
 
-	/sys/module/MODULENAME/refcnt
+What:		/sys/module/<MODULENAME>/refcnt
+Description:
 		If the module is able to be unloaded from the kernel, this file
 		will contain the current reference count of the module.
 
-- 
2.31.1

