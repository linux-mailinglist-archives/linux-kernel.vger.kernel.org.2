Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD93784D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhEJKzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 06:55:41 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:46525 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbhEJKoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:44:37 -0400
Received: from xps13.home (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 7E09F24000B;
        Mon, 10 May 2021 10:43:31 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>,
        miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: mtd: sm_ftl.c: Fix alignment of block comment
Date:   Mon, 10 May 2021 12:43:31 +0200
Message-Id: <20210510104331.10755-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210504062059.mywqzwveyjfawreg@kewl-virtual-machine>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f58997881dc4a2626ce3f363bb8305974164c67b'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-05-04 at 06:20:59 UTC, Shubhankar Kuranagatti wrote:
> A star has been added to subsequent line of block comment
> The closing */ has been shifted to new line
> This is done to maintain code uniformity
> 
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
