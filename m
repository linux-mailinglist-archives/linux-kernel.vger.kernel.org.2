Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D68E3D782F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhG0OLV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jul 2021 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbhG0OLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:11:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:11:19 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m8Nng-00028q-80; Tue, 27 Jul 2021 16:11:16 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m8Nnf-0007H0-Sr; Tue, 27 Jul 2021 16:11:15 +0200
Message-ID: <48daab3294fbdca7b68c6a16f9cdb522d24762f5.camel@pengutronix.de>
Subject: Re: [PATCH] Fix i.MX IPU-v3 offset calculations for (semi)planar
 U/V formats
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Krzysztof =?UTF-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     dri-devel@lists.freedesktop.org,
        lkml <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Jul 2021 16:11:15 +0200
In-Reply-To: <m3y2bmq7a4.fsf@t19.piap.pl>
References: <m3y2bmq7a4.fsf@t19.piap.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-07 at 12:49 +0200, Krzysztof Hałasa wrote:
> Video captured in 1400x1050 resolution (bytesperline aka stride = 1408
> bytes) is invalid. Fix it.
> 
> Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

Thank you, I've prefixed the subject with "gpu: ipu-v3:" and applied to
imx-drm/next.

regards
Philipp
