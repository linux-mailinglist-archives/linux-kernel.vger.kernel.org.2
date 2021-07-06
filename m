Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346B43BDB79
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhGFQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbhGFQgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:36:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38410C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 09:33:46 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m0o10-00050V-GR; Tue, 06 Jul 2021 18:33:42 +0200
Message-ID: <678b4197893029819040781305d87d2cc566d293.camel@pengutronix.de>
Subject: Re: [PATCH 0/2] drm/etnaviv: add GC7000 r6202 support
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Michael Walle <michael@walle.cc>, etnaviv@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lukas F . Hartmann" <lukas@mntre.com>
Date:   Tue, 06 Jul 2021 18:33:39 +0200
In-Reply-To: <20210618120433.14746-1-michael@walle.cc>
References: <20210618120433.14746-1-michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 18.06.2021 um 14:04 +0200 schrieb Michael Walle:
> This is the first step to bring GPU support to the NXP LS1028A SoC. It
> features a Mali DP500, a Vivante GC7000 and has one DisplayPort output
> which is driven by a Cadence MHDP controller and PHY.
> 
> This was briefly tested with glmark2, a patched mesa kmsro driver [1]
> to support the mali DP500/GC7000 duo, fixes from mesa merge request
> 9255 [2] and using ETNA_MESA_DEBUG=no_supertile,no_ts.
> 
> [1] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/11419
> [2] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/9255
> 
> Michael Walle (2):
>   drm/etnaviv: add HWDB entry for GC7000 r6202
>   drm/etnaviv: add clock gating workaround for GC7000 r6202
> 
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c  |  6 +++++
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 31 ++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)

Thanks, I've applied this series to my etnaviv/next branch.

Regards,
Lucas

