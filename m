Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D3457688
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhKSSls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:41:48 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43329 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhKSSlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:41:47 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id BAFB81C0007;
        Fri, 19 Nov 2021 18:38:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/4] mtd: rawnand: Fix nand_choose_best_timings() on unsupported interface
Date:   Fri, 19 Nov 2021 19:38:43 +0100
Message-Id: <20211119183843.1402825-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211119150316.43080-3-herve.codina@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ffb753f0b4bb685834ac42e94d028cfe63ecb200'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-11-19 at 15:03:14 UTC, Herve Codina wrote:
> When the NV-DDR interface is not supported by the NAND chip,
> the value of onfi->nvddr_timing_modes is 0. In this case,
> the best_mode variable value in nand_choose_best_nvddr_timings()
> is -1. The last for-loop is skipped and the function returns an
> uninitialized value.
> If this returned value is 0, the nand_choose_best_sdr_timings()
> is not executed and no 'best timing' are set. This leads the host
> controller and the NAND chip working at default mode 0 timing
> even if a better timing can be used.
> 
> Fix this uninitialized returned value.
> 
> nand_choose_best_sdr_timings() is pretty similar to
> nand_choose_best_nvddr_timings(). Even if onfi->sdr_timing_modes
> should never be seen as 0, nand_choose_best_sdr_timings() returned
> value is fixed.
> 
> Fixes: a9ecc8c814e9 ("mtd: rawnand: Choose the best timings, NV-DDR included")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
