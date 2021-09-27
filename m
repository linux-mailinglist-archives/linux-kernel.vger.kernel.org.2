Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3610D4195A6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhI0OBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234583AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38D5560F46;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=BNlZNAUTMLhlrg2wEynRw5qh+hUiXumdL2pp1O0ToQw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEj/McxIgpZNztQbEVauHZ4/P9ef2XBY1li7PtqfdB6hGDjhdwFGI6J0TUgCFf2hh
         vMYBlq1IubPsPjrGx8DmLSRODwv74z+Oy/ilchjutJJ1YDxQYBl8aSJqIO+sqIcY+7
         GpZJUOXp6rprXCNp+wP2hPoHKwzVzoYDGuyzkXOCOZiiXyugvpdpPrmh0kRI9TQ1a0
         3ySgS9yihLjP72HuRbUSufX4a4zr5CyUhU46kxAeqWeWUVMIEinGp3b4oUEgiYfBSA
         TMkPVKP8i75X5lFhoFy4Sgv8lL6IKH+hNRyXUlBQKdPaVVUHHGuv8Yiukm26TAz5sf
         slqxIfeO2SnIw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000Atd-AJ; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/17] ABI: stable/sysfs-module: document version and srcversion
Date:   Mon, 27 Sep 2021 15:59:35 +0200
Message-Id: <82bc7ebcc56c68c39b0e9de89cd0e023339d0597.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
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

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

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

