Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A767E435AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 08:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbhJUGee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 02:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhJUGec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 02:34:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71A4C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 23:32:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdRcb-0002kt-1Y; Thu, 21 Oct 2021 08:32:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdRca-0007d4-97; Thu, 21 Oct 2021 08:32:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mdRca-0007fn-8C; Thu, 21 Oct 2021 08:32:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] MAINTAINERS: Chrome: Drop Enric Balletbo i Serra
Date:   Thu, 21 Oct 2021 08:32:10 +0200
Message-Id: <20211021063210.52503-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=X3kBnmQ1CzTBfMOKAn3EuCWwtvhdTDXjwZZbJWKOJTk=; m=Fyn1VEkOuAmuNT97w5nmcLALz7RpK03gpK7MJ/LxtrI=; p=i5NFBo70KWKmInkanaREPF0Cf96dvp2oCnSSXvHPDF4=; g=caa9830666dff11f4449199b6640e0addd469d32
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmFxCWcACgkQwfwUeK3K7Ak7QAf/Tjv 7YLpErv9UyHTqnGExhZafDS+W16P3itCORJFcXDA4d6SRCxYfx0Ahn2v27605L0yKtwUHLDMuu2IW O22FWusJ4hZ/lCZijMGQfzaL8Hjcw07uzX0cS4hq23+ZDfWpfbk+XFT0dOmIhVRPNpCG0Z41ax397 6iMKsoQ0KdUF4v5jGW9Xj7Jh9la5ft6xY34IysgWL3Y1onUfeEEfx4yqQnAgg1sfSRL8YvNFiFUdP A22PngGk9YemTbM1dPZE8xJge/qfuwGkxRKWfl+gB8gOCxRCCxGRClXMO+OGLzNQ7DvfhTlAoSKJK SeWrK9UqDLhq2v2JMfd5gKcf0sNEtIA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sending a patch to the chrome people resulted in a message by
Collabora's mailer daemon:

	550 5.1.1 <enric.balletbo@collabora.com>: Recipient address rejected: User unknown in local recipient table (in reply to RCPT TO command)

So remove Eric from all maintainer entries.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d118d7957d2..b6ff67394b78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4413,14 +4413,12 @@ F:	drivers/input/touchscreen/chipone_icn8505.c
 
 CHROME HARDWARE PLATFORM SUPPORT
 M:	Benson Leung <bleung@chromium.org>
-M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 F:	drivers/platform/chrome/
 
 CHROMEOS EC CODEC DRIVER
 M:	Cheng-Yi Chiang <cychiang@chromium.org>
-R:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
 R:	Guenter Roeck <groeck@chromium.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -4428,7 +4426,6 @@ F:	sound/soc/codecs/cros_ec_codec.*
 
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
-M:	Enric Balletbo i Serra <enric.balletbo@collabora.com>
 R:	Guenter Roeck <groeck@chromium.org>
 S:	Maintained
 F:	drivers/power/supply/cros_usbpd-charger.c
-- 
2.30.2

