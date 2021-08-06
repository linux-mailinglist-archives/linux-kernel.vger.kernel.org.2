Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945C03E2FD0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbhHFTqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:46:11 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:34835 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhHFTqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:46:09 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E5C281BF203;
        Fri,  6 Aug 2021 19:45:50 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, boris.brezillon@collabora.com,
        tudor.ambarus@microchip.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        martin@kaiser.cx
Subject: Re: [PATCH] mtd: rawnand: Fix probe failure due to of_get_nand_secure_regions()
Date:   Fri,  6 Aug 2021 21:45:50 +0200
Message-Id: <20210806194550.392325-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210727062813.32619-1-manivannan.sadhasivam@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b48027083a78b13356695555a05b0e085e378687'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-07-27 at 06:28:13 UTC, Manivannan Sadhasivam wrote:
> Due to 14f97f0b8e2b, the rawnand platforms without "secure-regions"
> property defined in DT fails to probe. The issue is,
> of_get_nand_secure_regions() errors out if
> of_property_count_elems_of_size() returns a negative error code.
> 
> If the "secure-regions" property is not present in DT, then also we'll
> get -EINVAL from of_property_count_elems_of_size() but it should not
> be treated as an error for platforms not declaring "secure-regions"
> in DT.
> 
> So fix this behaviour by checking for the existence of that property in
> DT and return 0 if it is not present.
> 
> Fixes: 14f97f0b8e2b ("mtd: rawnand: Add a check in of_get_nand_secure_regions()")
> Reported-by: Martin Kaiser <martin@kaiser.cx>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Martin Kaiser <martin@kaiser.cx>
> Tested-by: Martin Kaiser <martin@kaiser.cx>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
