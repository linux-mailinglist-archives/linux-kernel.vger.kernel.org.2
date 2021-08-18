Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225703EFD06
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbhHRGoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbhHRGoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:44:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77159C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:43:46 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mGFIe-0001CZ-SE; Wed, 18 Aug 2021 08:43:44 +0200
Received: from mtr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mtr@pengutronix.de>)
        id 1mGFIc-0006iI-8O; Wed, 18 Aug 2021 08:43:42 +0200
Date:   Wed, 18 Aug 2021 08:43:42 +0200
From:   Michael Tretter <m.tretter@pengutronix.de>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com, kernel@pengutronix.de
Subject: Re: [PATCH 0/3] Add support for runtime features
Message-ID: <20210818064342.GB12231@pengutronix.de>
References: <20210817130553.20219-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210817130553.20219-1-ronak.jain@xilinx.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:33:33 up 181 days,  9:57, 99 users,  load average: 0.20, 0.28,
 0.27
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mtr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ronak,

On Tue, 17 Aug 2021 06:05:50 -0700, Ronak Jain wrote:
> Adds support for runtime feature configuration by using the IOCTL
>  calls. The user can enable or disable as well as can configure the
>  runtime features. The support is added for the over temperature and
>  external watchdog. The user can configure the over temperature limit
>  and external watchdog timer interval at runtime by using PM_IOCTL
>  calls.
> 
> Also, added support for sysfs interface for runtime feature
> configuration for the over temperature and external watchdog features.

Can we have proper kernel drivers instead of the sysfs interface?

Michael

> 
> Ronak Jain (3):
>   firmware: xilinx: Add support for runtime features
>   firmware: zynqmp: Add sysfs entry for runtime features
>   firmware: xilinx: Add sysfs support for feature config
> 
>  .../ABI/stable/sysfs-driver-firmware-zynqmp   | 84 ++++++++++++++++
>  drivers/firmware/xilinx/zynqmp.c              | 98 +++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          | 25 +++++
>  3 files changed, 207 insertions(+)
> 
> --
> 2.32.0.93.g670b81a
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
