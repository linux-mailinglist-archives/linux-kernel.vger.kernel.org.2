Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E2B32BC7E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhCCN7p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 3 Mar 2021 08:59:45 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:49669 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842906AbhCCKWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:22 -0500
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 5E7503B0C2F;
        Wed,  3 Mar 2021 09:47:16 +0000 (UTC)
X-Originating-IP: 86.206.8.148
Received: from xps13 (lfbn-tou-1-491-148.w86-206.abo.wanadoo.fr [86.206.8.148])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 87D3BE0003;
        Wed,  3 Mar 2021 09:46:52 +0000 (UTC)
Date:   Wed, 3 Mar 2021 10:46:51 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: nand: Fix error handling in
 nand_prog_page_op
Message-ID: <20210303104651.2d49fb2c@xps13>
In-Reply-To: <20210303094246.5724-1-colin.king@canonical.com>
References: <20210303094246.5724-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Colin King <colin.king@canonical.com> wrote on Wed,  3 Mar 2021
09:42:46 +0000:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The less than zero comparison with status is always false because status
> is a u8. Fix this by using ret as the return check for the call to
> chip->legacy.waitfunc() and checking on this and assigning status to ret
> if it is OK.
> 
> Addresses-Coverity: ("Unsigned compared against 0")
> Fixes: 52f67def97f1 ("mtd: nand: fix error handling in nand_prog_page_op() #1")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks for the fix, but this has been handled just an hour ago :)

Cheers,
Miquèl
