Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2452240B240
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhINO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233464AbhINO4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8759261157;
        Tue, 14 Sep 2021 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631631328;
        bh=jwBvmMOmjYkXF39zRKm8ty4zFYEarHAXbppvfDBGqGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWSGAEHYBULHEesvzWRCd/qxV8KtefeIKT+WbuHgnVvWEqyYqFr1oQ0S9l//z55wf
         NAojxhK0+FQov+7WVV60n0opXfPBfZ27ys17ssxSTnYl7zO/pNLZUhgdpj0nxWzzx/
         Ac77POMBopitj8NdS1BkmjMflvXtS4t9SriIKdf0CPgrICWcL+C7zBrJrActXMmQ7m
         mZ8w5wDo//iey6lBjcOcgvFXMOXC/t4brwAjtxFM2h842xmh+7gFWMNwO8/JqcDifI
         mCI647Vz722pyX1gs4kPUyNuCTEwVIeS+NzR1KFvu2jAX4m2BdPuZ5R3opSSBaoMoL
         WVkjAShEiPGoQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9qI-000L6o-Jb; Tue, 14 Sep 2021 16:55:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] ABI: stable/sysfs-module: document version and srcversion
Date:   Tue, 14 Sep 2021 16:55:15 +0200
Message-Id: <b1ad99d45a8bf9a0ec4aa69723ca0c5afb7132a8.1631630792.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631630792.git.mchehab+huawei@kernel.org>
References: <cover.1631630792.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset c988d2b28454 ("[PATCH] modules: add version and srcversion to sysfs")
added version and srcversion ABI to modules. Document them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/sysfs-module | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 5c028af9921a..560b4a3278df 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -33,3 +33,15 @@ Description:
 		Note: If the module is built into the kernel, or if the
 		CONFIG_MODULE_UNLOAD kernel configuration value is not enabled,
 		this file will not be present.
+
+What:		/sys/module/<MODULENAME>/srcversion
+Date:		Jun 2005
+Description:
+		If the module source has MODULE_VERSION, this file will contain
+		the checksum of the the source code.
+
+What:		/sys/module/<MODULENAME>/version
+Date:		Jun 2005
+Description:
+		If the module source has MODULE_VERSION, this file will contain
+		the version of the source code.
-- 
2.31.1

