Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE2B389901
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 00:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhESWBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 18:01:25 -0400
Received: from vps.xff.cz ([195.181.215.36]:55744 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhESWBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 18:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1621461602; bh=KLTp9TvJTISdCvfu+UFZy1P5nOgOwGxFLgijoG6hkSc=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=jPs0Hd3lGedJKjDAKYMmQFFKddPNo6gGdrZyUubenneiaCktWI5JbdreHplPL//Md
         ptO28xKZqbzHYut3uiMcB2/b8Q0TeVzcRJZOJvH3V3kwj08iy9sCnt+67dKjhzcQ36
         LG4hDU34wowd7M6vgbaEifkSCGDVxiO0ar8fE/o0=
Date:   Thu, 20 May 2021 00:00:02 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, andre.przywara@arm.com
Subject: Re: fw_devlink=on and sunxi HDMI
Message-ID: <20210519220002.w6e3jf6m5t45vbob@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Saravana Kannan <saravanak@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, andre.przywara@arm.com
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20210516170539.2yxe43qwezonuo3r@core>
 <CAGETcx93RxfsXG51zeaUK+UyKdEDgivqkmS85mcMPp0H42X5ZQ@mail.gmail.com>
 <20210517082957.sddwy2dv5esbzmo4@core>
 <CAGETcx-UgSCn9V5W0EgOBbdNGxsXR+ZGPNLL1MMJfHN35WCLRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx-UgSCn9V5W0EgOBbdNGxsXR+ZGPNLL1MMJfHN35WCLRw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Saravana,

On Wed, May 19, 2021 at 02:29:48PM -0700, Saravana Kannan wrote:
> 
> Nothing in sun8i_hdmi_phy_probe() depends on anything from
> sun8i_dw_hdmi.c other than getting a struct device pointer to use with
> dev_err and some devm_* APIs. So it seems pretty straightforward to
> fix this so that you don't have one struct device trying to represent
> two distinct hardware blocks. What am I missing?
> 
> Anyway, I took a swing at fixing this while preserving the ordering of
> the important bits. The changes are fairly trivial/straightforward and
> not meant to be final code, but can you test this out please?

the patch seems to work, after fixing a few compilation issues. See
bellow. Thanks!

I think the probe order is reversed, but HDMI works in my case, so
I guess that doesn't matter in the end. Or at least it didn't in the
short test I made.

kind regards,
	o.


From 0eac644368711f52fffa4246aefc546591cef090 Mon Sep 17 00:00:00 2001
From: Ondrej Jirman <megous@megous.com>
Date: Wed, 19 May 2021 23:44:45 +0200
Subject: [PATCH] fix compilation issues

---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index c44ed22d8aef0..947b4231f6449 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -5,6 +5,7 @@
 
 #include <linux/delay.h>
 #include <linux/of_address.h>
+#include <linux/of_platform.h>
 
 #include "sun8i_dw_hdmi.h"
 
@@ -748,7 +749,7 @@ int sun8i_hdmi_phy_probe(struct platform_device *pdev)
 	return ret;
 }
 
-void sun8i_hdmi_phy_remove(struct platform_device *pdev)
+int sun8i_hdmi_phy_remove(struct platform_device *pdev)
 {
 	struct sun8i_hdmi_phy *phy = platform_get_drvdata(pdev);
 
-- 
2.31.1


[    0.307254] platform 1c28000.serial: probe deferral - supplier 1c20800.pinctrl not ready
[    0.307340] platform 1c28400.serial: probe deferral - supplier 1c20800.pinctrl not ready
[    0.307379] platform 1c28c00.serial: probe deferral - supplier 1c20800.pinctrl not ready
[    0.309235] fwnode_links_purge_suppliers: display-engine
[    0.310176] platform 1c0c000.lcd-controller: probe deferral - wait for supplier mixer@200000
[    0.310228] platform 1c0d000.lcd-controller: probe deferral - wait for supplier mixer@200000
[    0.311902] platform 1ca0000.dsi: probe deferral - wait for supplier pmic@3a3
[    0.312287] platform 1ee0000.hdmi: probe deferral - wait for supplier pmic@3a3
[    0.313076] fwnode_links_purge_suppliers: hdmi-phy@1ef0000    <------ phy probed
[    0.316766] platform 1c21800.lradc: probe deferral - wait for supplier pmic@3a3
[    0.317258] platform vibrator: probe deferral - wait for supplier pmic@3a3
[    0.318703] sun6i-rtc 1f00000.rtc: registered as rtc0
[    0.318748] sun6i-rtc 1f00000.rtc: setting system clock to 2021-05-19T21:40:59 UTC (1621460459)
[    0.318917] sun6i-rtc 1f00000.rtc: RTC enabled
[    0.318938] fwnode_links_purge_suppliers: rtc@1f00000
[    0.318960] fwnode_links_purge_consumers: reboot-mode@4
[    0.319185] i2c /dev entries driver

....

[    0.453301] fwnode_links_purge_consumers: port
[    0.453323] fwnode_links_purge_consumers: endpoint
[    0.453346] fwnode_links_purge_consumers: panel@0
[    0.491868] sun4i-drm display-engine: bound 1100000.mixer (ops 0xffffffc010a44230)
[    0.501830] sun4i-drm display-engine: bound 1200000.mixer (ops 0xffffffc010a44230)
[    0.502915] sun4i-drm display-engine: No panel or bridge found... RGB output disabled
[    0.502956] sun4i-drm display-engine: bound 1c0c000.lcd-controller (ops 0xffffffc010a415a0)
[    0.503466] sun4i-drm display-engine: bound 1c0d000.lcd-controller (ops 0xffffffc010a415a0)
[    0.503545] sun4i-drm display-engine: bound 1ca0000.dsi (ops 0xffffffc010a431c8)
[    0.505330] sun8i-dw-hdmi 1ee0000.hdmi: Detected HDMI TX controller v1.32a with HDCP (sun8i_dw_hdmi_phy)
[    0.507566] sun8i-dw-hdmi 1ee0000.hdmi: registered DesignWare HDMI I2C bus driver
[    0.510717] sun4i-drm display-engine: bound 1ee0000.hdmi (ops 0xffffffc010a43568)
[    0.514674] [drm] Initialized sun4i-drm 1.0.0 20150629 for display-engine on minor 0
[    0.514932] sun4i-drm display-engine: [drm] Cannot find any crtc or sizes
[    0.515160] fwnode_links_purge_suppliers: hdmi@1ee0000           <------ hdmi probed
[    0.515195] fwnode_links_purge_consumers: ports
[    0.515217] fwnode_links_purge_consumers: port@0
[    0.515240] fwnode_links_purge_consumers: endpoint
[    0.515264] fwnode_links_purge_consumers: port@1
[    0.515343] fwnode_links_purge_consumers: endpoint
[    0.517089] input: 1c21800.lradc as /devices/platform/soc/1c21800.lradc/input/input1
[    0.517358] fwnode_links_purge_suppliers: lradc@1c21800
[    0.517384] fwnode_links_purge_consumers: button-200
[    0.517407] fwnode_links_purge_consumers: button-400
[    0.518414] input: gpio-vibrator as /devices/platform/vibrator/input/input2
[    0.518582] fwnode_links_purge_suppliers: vibrator



> -Saravana
