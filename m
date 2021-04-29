Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3490F36E59D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 09:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbhD2HKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 03:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237275AbhD2HKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 03:10:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94D3C06138E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 00:09:45 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1lc0ns-0005sg-IO; Thu, 29 Apr 2021 09:09:40 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1lc0ns-0005Pn-3a; Thu, 29 Apr 2021 09:09:40 +0200
Date:   Thu, 29 Apr 2021 09:09:40 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shengjiu.wang@gmail.com
Subject: Re: [PATCH] ARM: dts: imx6ul: Switch to fsl-asoc-card sound card
Message-ID: <20210429070940.6hech7hezrpiyzzp@pengutronix.de>
References: <1619664739-12589-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619664739-12589-1-git-send-email-shengjiu.wang@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:08:19 up 147 days, 21:14, 44 users,  load average: 0.09, 0.18,
 0.13
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks for the patch.

On 21-04-29 10:52, Shengjiu Wang wrote:
> There is issue with simple sound card, the simple sound
> card can't configure the pll of codec.

Hm, than we should fix this rather than moving to the 'old'
'fsl,imx-audio-wm8960'. But that only my opinion.

Regards,
  Marco
