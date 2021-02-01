Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952DE30B34B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhBAXSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:18:32 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:55809 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhBAXSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:18:16 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B439D40003;
        Mon,  1 Feb 2021 23:17:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-i3c@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] i3c: Handle drivers without probe or remove callback
Date:   Tue,  2 Feb 2021 00:17:21 +0100
Message-Id: <161222143405.3432488.2548904901699225293.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128091048.17006-1-u.kleine-koenig@pengutronix.de>
References: <20210128091048.17006-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jan 2021 10:10:47 +0100, Uwe Kleine-König wrote:
> A registered driver without a probe callback doesn't make sense, so
> refuse to register such a driver. (Otherwise i3c_device_probe() yields a
> NULL pointer exception.)
> 
> A driver without remove is possible, e.g. when all resources are freed
> using devm callbacks. So guard the call to driver->remove by a check
> for being non-NULL.
> 
> [...]

Applied, thanks!

[1/2] i3c: Handle drivers without probe or remove callback
      commit: 7456fea589c6ad3422b0c188871ae80e1d307737
[2/2] i3c: Make remove callback return void
      commit: dd9267034c0e364b49261c3e0070b863286d1242

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
