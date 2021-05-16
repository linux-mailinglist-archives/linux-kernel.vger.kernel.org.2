Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB1382028
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 19:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhEPRNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 13:13:50 -0400
Received: from vps.xff.cz ([195.181.215.36]:51834 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhEPRNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 13:13:49 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 May 2021 13:13:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1621184739; bh=uHlcH0STNmNleBKETejswBkFPZ8BfNTar3rYv5h1z3A=;
        h=Date:From:To:Subject:X-My-GPG-KeyId:From;
        b=E5ZOlREtj/L0TAq2nbvJ3WPUJw/WU1L+A76jOUVUTxIxB4aDr+/oGO8ChSNb0fSHv
         VNGI362hkCBbHZgiKnD8AY94Te4rmQZSjRcCmqxuDM3DJ8xJET8h28Oq5BIw58ZDyl
         RJVOLtIp+10UJll90Atxz7Jc9CW06W68t1izi75w=
Date:   Sun, 16 May 2021 19:05:39 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     saravanak@google.com, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        andre.przywara@arm.com
Subject: fw_devlink=on and sunxi HDMI
Message-ID: <20210516170539.2yxe43qwezonuo3r@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        saravanak@google.com, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        andre.przywara@arm.com
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Linux 5.13-rc1 again has fw_devlink=on enabled by default. I've found that this
breaks probing display pipeline and HDMI output on sunxi boards, because of
fwnode_link between hdmi and hdmi-phy nodes.

HDMI device probe keeps being avoided with these repeated messages in dmesg:

  platform 1ee0000.hdmi: probe deferral - supplier 1ef0000.hdmi-phy not ready

Both nodes have their own compatible, but are implemented by a single
struct device.

This looks like a kind of situation that's expected to break fw_devlink
expectations by my reading of the the e-mails about trying the fw_devlink=on
during 5.12 cycle.

Is this supposed to be solved by implementing the PHY node as it's own
device or by breaking the fwnode_link between the hdmi phy and hdmi nodes?
Seems like second solution would be quicker now that rc1 is out.

Where would be a good place to break that fwnode_link in code?

Or can the fw_devlink code be made aware of this situation, where two fwnodes
are implemented by the same Linux device, somehow?

Relevant references:

https://elixir.bootlin.com/linux/v5.13-rc1/source/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c#L600
https://elixir.bootlin.com/linux/v5.13-rc1/source/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c#L212
https://elixir.bootlin.com/linux/v5.13-rc1/source/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi#L1176

kind regards,
	o.
