Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6B5351E5F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhDASkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239665AbhDASQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:16:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9369461209;
        Thu,  1 Apr 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617279476;
        bh=HeEviqMcd07vaiDkDgrG8UUhzX6Vzf19XKOP3eUlLxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M59xwmAowKv4+c+lZ/0usaaelSe5Gv4xfokr/RDIk4CaPw25vSJsQ1bVPqAmOTe38
         9Tl8eeZvUYFNZyxbIJuSLUAsF369nsRq6T+ae5qPEuCMhMgXc9Jo/gOtHRZJebVUCt
         Z+5k4eID51A856H0nVRBV1OkTOuBCY4733DFZtJMU7M6jYZT2gfMsUTsmiBx722t7Z
         udbFjXvQM6thrM6Uf75De+94HzNDg6B78Apn7cmoLYU7d48qkCMH6g5dhzG1G+CVHw
         tA6+GnQKDWnKvdbrkPHpcx/pm7/vihMgFG7kI+Vutt3VX/NYa53UYsaL2IT7jnBssT
         ips8wTxtdi8Qg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lRwGo-001c3k-Ml; Thu, 01 Apr 2021 14:17:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 31/32] Documentation: update sysfs-platform_profile.rst reference
Date:   Thu,  1 Apr 2021 14:17:51 +0200
Message-Id: <828434d891e40234255e3f06c13827b7996b1ad1.1617279356.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617279355.git.mchehab+huawei@kernel.org>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file name: Documentation/ABI/testing/sysfs-platform_profile.rst
should be, instead: Documentation/userspace-api/sysfs-platform_profile.rst.

Update its cross-reference accordingly.

Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
Fixes: 8e0cbf356377 ("Documentation: Add documentation for new platform_profile sysfs attribute")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/platform_profile.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a6329003aee7..e5cbb6841f3a 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -2,7 +2,7 @@
 /*
  * Platform profile sysfs interface
  *
- * See Documentation/ABI/testing/sysfs-platform_profile.rst for more
+ * See Documentation/userspace-api/sysfs-platform_profile.rst for more
  * information.
  */
 
-- 
2.30.2

