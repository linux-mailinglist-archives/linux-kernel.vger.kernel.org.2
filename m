Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0760940B61E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbhINRmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:42:13 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:48269 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhINRmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:42:06 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 79A7A1BF205;
        Tue, 14 Sep 2021 17:40:47 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yi Yang <yiyang13@huawei.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: Re: [PATCH] mtd: Remove obsolete macros only used by the old nand_ecclayout struct
Date:   Tue, 14 Sep 2021 19:40:46 +0200
Message-Id: <20210914174046.302368-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210830083356.31702-1-gongruiqi1@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a2aec2c86ef0cad0fd6be718cfeb5cf5eefbfca9'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-30 at 08:33:56 UTC, "GONG, Ruiqi" wrote:
> All uses of MTD_MAX_{OOBFREE,ECCPOS}_ENTRIES_LARGE have been removed as
> commit ef5eeea6e911 ("mtd: nand: brcm: switch to mtd_ooblayout_ops") and
> commit aab616e31d1c ("mtd: kill the nand_ecclayout struct") replaced
> struct nand_ecclayout by the new mtd_ooblayout_ops interface. Remove
> these two macros therefore.
> 
> Reported-by: Yi Yang <yiyang13@huawei.com>
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
