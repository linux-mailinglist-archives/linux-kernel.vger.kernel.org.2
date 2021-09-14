Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7B440B605
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhINRjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:39:02 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55123 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbhINRiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:38:52 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 3EF1320007;
        Tue, 14 Sep 2021 17:37:33 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>, miquel.raynal@bootlin.com,
        mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org, stable@kernel.org
Subject: Re: [PATCH V6] mtd: rawnand: qcom: Update code word value for raw read
Date:   Tue, 14 Sep 2021 19:37:32 +0200
Message-Id: <20210914173732.167846-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <1630998357-1359-1-git-send-email-mdalam@codeaurora.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f60f5741002b9fde748cff65fd09bd6222c5db0c'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-09-07 at 07:05:57 UTC, Md Sadre Alam wrote:
> From QPIC V2 onwards there is a separate register to read
> last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".
> 
> qcom_nandc_read_cw_raw() is used to read only one code word
> at a time. If we will configure number of code words to 1 in
> in QPIC_NAND_DEV0_CFG0 register then QPIC controller thinks
> its reading the last code word, since from QPIC V2 onwards
> we are having separate register to read the last code word,
> we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n"
> register to fetch data from controller buffer to system
> memory.
> 
> Fixes: 503ee5aad430 ("mtd: rawnand: qcom: update last code word register")
> Cc: stable@kernel.org
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
