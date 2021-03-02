Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BD832AA78
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 20:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444900AbhCBTag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 14:30:36 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:47953 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245508AbhCBRPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 12:15:43 -0500
Received: from xps13.stephanxp.local (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id AB31F20000E;
        Tue,  2 Mar 2021 17:14:24 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, nixiaoming@huawei.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mtd/next 5/8] mtd: mtdblock_ro: Use module_mtd_blktrans to register driver
Date:   Tue,  2 Mar 2021 18:14:24 +0100
Message-Id: <20210302171424.1508-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210213164600.409061-6-zhengdejin5@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: ebaedffc4b4e595a50ace22461bc7305b6f2aad7
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-02-13 at 16:45:57 UTC, Dejin Zheng wrote:
> Removing some boilerplate by using module_mtd_blktrans instead of calling
> register and unregister in the otherwise empty init/exit functions.
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
