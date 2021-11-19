Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07F4576AD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 19:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbhKSSvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 13:51:19 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34695 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbhKSSvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 13:51:17 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 8DA9460006;
        Fri, 19 Nov 2021 18:48:12 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zev Weiss <zev@bewilderbeest.net>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Michael Walle <michael@walle.cc>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tian Tao <tiantao6@hisilicon.com>, Petr Malat <oss@malat.biz>,
        Jon Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: core: clear out unregistered devices a bit more
Date:   Fri, 19 Nov 2021 19:48:12 +0100
Message-Id: <20211119184812.1481781-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211015185049.3318-1-zev@bewilderbeest.net>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'67bcbe202b487a2e4d9da586b63e4df632655568'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-10-15 at 18:50:48 UTC, Zev Weiss wrote:
> This allows an MTD device that has been unregistered to be easily
> re-registered later without triggering spurious "already registered"
> warnings in mtd_device_parse_register() and add_mtd_device().
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
