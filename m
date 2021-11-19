Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB8457686
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhKSSlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:41:39 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:45961 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhKSSli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:41:38 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 6FBCEFF809;
        Fri, 19 Nov 2021 18:38:34 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 4/4] mtd: rawnand: fsmc: Fix timing computation
Date:   Fri, 19 Nov 2021 19:38:33 +0100
Message-Id: <20211119183833.1402635-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211119150316.43080-5-herve.codina@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bed96b1b5b2c03bc61e0ac0f679c0de36a6f717f'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-19 at 15:03:16 UTC, Herve Codina wrote:
> Under certain circumstances, the timing settings calculated by
> the FSMC NAND controller driver were inaccurate.
> These settings led to incorrect data reads or fallback to
> timing mode 0 depending on the NAND chip used.
> 
> The timing computation did not take into account the following
> constraint given in SPEAr3xx reference manual:
>   twait >= tCEA - (tset * TCLK) + TOUTDEL + TINDEL
> 
> Enhance the timings calculation by taking into account this
> additional constraint.
> 
> This change has no impact on slow timing modes such as mode 0.
> Indeed, on mode 0, computed values are the same with and
> without the patch.
> 
> NANDs which previously stayed in mode 0 because of fallback to
> mode 0 can now work at higher speeds and NANDs which were not
> working at all because of the corrupted data work at high
> speeds without troubles.
> 
> Overall improvement on a Micron/MT29F1G08 (flash_speed tool):
>                         mode0       mode3
> eraseblock write speed  3220 KiB/s  4511 KiB/s
> eraseblock read speed   4491 KiB/s  7529 KiB/s
> 
> Fixes: d9fb079571833 ("mtd: nand: fsmc: add support for SDR timings")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
