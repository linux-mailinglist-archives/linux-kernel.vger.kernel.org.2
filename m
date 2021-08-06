Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1849D3E3011
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbhHFUD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:03:27 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:50239 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244463AbhHFUD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:03:26 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 93F4E1BF204;
        Fri,  6 Aug 2021 20:03:09 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Palmer <daniel@0x0f.com>, miquel.raynal@bootlin.com,
        richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mtd: spinand: core: Properly fill the OOB area.
Date:   Fri,  6 Aug 2021 22:03:08 +0200
Message-Id: <20210806200309.393655-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617110842.2358461-1-daniel@0x0f.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'df12a75a2be915e7c419707bc71fba0fa7548d81'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-06-17 at 11:08:42 UTC, Daniel Palmer wrote:
> The comment in spinand_write_to_cache_op() says that
> spinand_ondie_ecc_prepare_io_req() should 0xff fill the OOB
> area but it doesn't.
> 
> This causes the OOB area to get filled with zeros
> and anytime the first page in a block the bad block marker
> is cleared and it becomes a bad block on the next boot.
> 
> This was observed on Longsys FORSEE branded parts and
> might be specific to these parts.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
