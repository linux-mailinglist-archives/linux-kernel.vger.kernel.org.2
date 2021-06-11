Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B7C3A4914
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbhFKTE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:04:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49699 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhFKTE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:04:26 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F39DDC0003;
        Fri, 11 Jun 2021 19:02:25 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] mtd: rawnand: marvell: Minor documentation correction
Date:   Fri, 11 Jun 2021 21:02:25 +0200
Message-Id: <20210611190225.226268-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210607193736.4654-1-jrdr.linux@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e45fde98e2968e7d5101757f76f8da3abf2cfa15'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-06-07 at 19:37:36 UTC, Souptick Joarder wrote:
> Kernel test robot throws below warning ->
> drivers/mtd/nand/raw/marvell_nand.c:454: warning: This comment starts
> with '/**', but isn't a kernel-doc comment. Refer
> Documentation/doc-guide/kernel-doc.rst
> 
> Minor documentation correction.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
