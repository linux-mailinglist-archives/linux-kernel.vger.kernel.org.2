Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4653E3010
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbhHFUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:03:17 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40267 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244402AbhHFUDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:03:16 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3727F60003;
        Fri,  6 Aug 2021 20:02:57 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jason Wang <wangborong@cdjrlc.com>, miquel.raynal@bootlin.com
Cc:     liang.yang@amlogic.com, vigneshr@ti.com, narmstrong@baylibre.com,
        khilman@baylibre.com, richard@nod.at, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: remove never changed ret variable
Date:   Fri,  6 Aug 2021 22:02:57 +0200
Message-Id: <20210806200257.393527-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210803113300.24230-1-wangborong@cdjrlc.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'74a021a632b07dd990e85e815b8757921b23db4b'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-03 at 11:33:00 UTC, Jason Wang wrote:
> The ret variable used for returning value in the function
> `meson_nfc_rw_cmd_prepare_and_execute` is never change after initialising.
> Therefore, we can remove it safely and return 0 at the end of the function.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
