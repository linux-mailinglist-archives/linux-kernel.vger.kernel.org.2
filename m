Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6823D329F27
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573360AbhCBDVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243053AbhCAU0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:26:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 31CF46511F;
        Mon,  1 Mar 2021 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614622002;
        bh=XoaCinxVTN5rOPS4CJsOkgFKJAVWsw3ghesWvXuw8xM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=onB+X9yNvlWqutRArrPYQbkJPkC0PjaaEGQf71cE8mZQ3xt72Fj814Fck+iOrsDbB
         j4PKOtQyzCY3neNHFK8qBZcLh79qKZO66yzusybpP5GtKrsLhqBDBvhzK26F/JuOok
         CdTElUXGzJtvHxkUtLj2+I1KHDIPLv92N0+jTGsE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 5.11 694/775] mtd: spi-nor: sfdp: Fix wrong erase type bitmask for overlaid region
Date:   Mon,  1 Mar 2021 17:14:22 +0100
Message-Id: <20210301161235.677091761@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161201.679371205@linuxfoundation.org>
References: <20210301161201.679371205@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

commit abdf5a5ef9652bad4d58058bc22ddf23543ba3e1 upstream.

At the time spi_nor_region_check_overlay() is called, the erase types are
sorted in ascending order of erase size. The 'erase_type' should be masked
with 'BIT(erase[i].idx)' instead of 'BIT(i)'.

Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
Cc: stable@vger.kernel.org
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
[ta: Add Fixes tag and Cc to stable]
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Link: https://lore.kernel.org/r/fd90c40d5b626a1319a78fc2bcee79a8871d4d57.1601612872.git.Takahiro.Kuwano@infineon.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/spi-nor/sfdp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -788,7 +788,7 @@ spi_nor_region_check_overlay(struct spi_
 	int i;
 
 	for (i = 0; i < SNOR_ERASE_TYPE_MAX; i++) {
-		if (!(erase_type & BIT(i)))
+		if (!(erase[i].size && erase_type & BIT(erase[i].idx)))
 			continue;
 		if (region->size & erase[i].size_mask) {
 			spi_nor_region_mark_overlay(region);


