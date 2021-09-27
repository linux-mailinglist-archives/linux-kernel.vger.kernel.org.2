Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF524195AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234763AbhI0OBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234587AbhI0OBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C81861002;
        Mon, 27 Sep 2021 13:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632751197;
        bh=pgBtpFgwAsewCq5MDA93H9m+9sWkW6ZRNITD23kNlxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lQQbBWA3iSL4L/2wNQBFDnPu9TIBXW2ihCEN3RPk+Hm7XueaVETkiffruOquy7bs4
         izVoyjNF4HeLmY7rN5qznjhjTVfC8blgqIfaiO/TV8uzohZVIp8Pfa4rOWgrmIF6zc
         oXBADPkQqEMk5lKBLP+e+OLf6XvqlAPyX28MCpCMQYiQKaWbe2o0+W8KYKFD+QIodW
         uw7iJYX3s5fE71K/F9+jnKaU1aH9MLrzPvZT3fLkfVVcGBXxuT54fRcUGxG4xWW8pF
         O2PVDiv2bMgTQbu1IBxi/xTJwsBf6jWjhlUZXIylQ0aLNiEYhRn6UroJKsFi2TeWH2
         dtRglqXgKz2DQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mUrAh-000Au6-JT; Mon, 27 Sep 2021 15:59:55 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/17] ABI: sysfs-devices-power: add some debug sysfs files
Date:   Mon, 27 Sep 2021 15:59:42 +0200
Message-Id: <df6c3ae0ffc2dddf73d7a5baf696a4aa260fb576.1632750608.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632750608.git.mchehab+huawei@kernel.org>
References: <cover.1632750608.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those files were added back in Apr 2010, but there's no
documentation for them yet.

Fixes: c92445fadb91 ("PM / Runtime: Add sysfs debug files")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

See [PATCH 00/17] at: https://lore.kernel.org/all/cover.1632750608.git.mchehab+huawei@kernel.org/

 Documentation/ABI/testing/sysfs-devices-power | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentation/ABI/testing/sysfs-devices-power
index 84694b8fec8e..1b2a2d41ff80 100644
--- a/Documentation/ABI/testing/sysfs-devices-power
+++ b/Documentation/ABI/testing/sysfs-devices-power
@@ -283,3 +283,25 @@ Contact:	Arjan van de Ven <arjan@linux.intel.com>
 Description:
 		Reports total time that the device has been suspended.
 		Used for runtime PM statistics.
+
+What:		/sys/devices/.../power/runtime_usage
+Date:		Apr 2010
+Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
+Description:
+		Reports the runtime PM usage count of a device.
+
+What:		/sys/devices/.../power/runtime_enabled
+Date:		Apr 2010
+Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
+Description:
+		Is runtime PM enabled for this device?
+		States are "enabled", "disabled", "forbidden" or a
+		combination of the latter two.
+
+What:		/sys/devices/.../power/runtime_active_kids
+Date:		Apr 2010
+Contact:	Dominik Brodowski <linux@dominikbrodowski.net>
+Description:
+		Reports the runtime PM children usage count of a device, or
+		0 if the the children will be ignored.
+
-- 
2.31.1

