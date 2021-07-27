Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728A53D7831
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 16:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhG0OL0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jul 2021 10:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbhG0OLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 10:11:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E40BC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 07:11:25 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m8Nnn-0002Bs-Ad; Tue, 27 Jul 2021 16:11:23 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1m8Nnn-0007HT-1E; Tue, 27 Jul 2021 16:11:23 +0200
Message-ID: <f21f46d95972a14e67fa3429e3d464d5762cce34.camel@pengutronix.de>
Subject: Re: [PATCH v2] gpu: ipu-v3: use swap()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Salah Triki <salah.triki@gmail.com>, festevam@gmail.com,
        alexdeucher@gmail.com
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Tue, 27 Jul 2021 16:11:22 +0200
In-Reply-To: <20210713140521.GA1873885@pc>
References: <20210713140521.GA1873885@pc>
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

On Tue, 2021-07-13 at 15:05 +0100, Salah Triki wrote:
> Use swap() instead of implementing it since it makes code cleaner.
> 
> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
> 
> Changes since v1:
> 	- Remove the declaration of tmp
> 	- Fix typo in the description

Thank you, I've changed the subject to "gpu: ipu-v3: image-convert: use
swap()" and applied to imx-drm/next.

regards
Philipp
