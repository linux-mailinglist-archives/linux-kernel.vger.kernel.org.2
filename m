Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53325415864
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 08:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbhIWGoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 02:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239370AbhIWGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 02:44:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A464FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 23:42:52 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6C5851F4121C;
        Thu, 23 Sep 2021 07:42:49 +0100 (BST)
Date:   Thu, 23 Sep 2021 08:42:44 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Ren Xiaohui <ren.xiaohui@zte.com.cn>
Subject: Re: [PATCH] mtd: spinand: add merge-two-spinand function
Message-ID: <20210923084244.54a6a899@collabora.com>
In-Reply-To: <20210923015241.248910-1-ren.xiaohui@zte.com.cn>
References: <20210923015241.248910-1-ren.xiaohui@zte.com.cn>
Organization: Collabora
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 01:52:41 +0000
CGEL <cgel.zte@gmail.com> wrote:

> From: Ren Xiaohui <ren.xiaohui@zte.com.cn>
> 
> Combine the two SPI NAND flash in the MTD layer

Just had a quick look, but it looks like you're re-implementing
mtdconcat. Maybe you should just extend mtdconcat to cover your use
cases.
