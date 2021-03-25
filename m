Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C417C3489D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhCYHIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhCYHIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:08:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B232C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 00:08:03 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1lPK64-0007Ul-PZ; Thu, 25 Mar 2021 08:08:00 +0100
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1lPK64-0000eS-9w; Thu, 25 Mar 2021 08:08:00 +0100
Date:   Thu, 25 Mar 2021 08:08:00 +0100
From:   Philipp Zabel <pza@pengutronix.de>
To:     Liu Ying <victor.liu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Subject: Re: [PATCH] drm/imx: imx-ldb: Register LDB channel1 when it is the
 only channel to be used
Message-ID: <20210325070800.GB22419@pengutronix.de>
References: <1616381800-4862-1-git-send-email-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616381800-4862-1-git-send-email-victor.liu@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:07:41 up 35 days, 10:31, 66 users,  load average: 0.36, 0.41,
 0.40
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:56:40AM +0800, Liu Ying wrote:
> LDB channel1 should be registered if it is the only channel to be used.
> Without this patch, imx_ldb_bind() would skip registering LDB channel1
> if LDB channel0 is not used, no matter LDB channel1 needs to be used or
> not.
> 
> Fixes: 8767f4711b2b (drm/imx: imx-ldb: move initialization into probe)
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Thank you, applied to imx-drm/fixes.

regards
Philipp
