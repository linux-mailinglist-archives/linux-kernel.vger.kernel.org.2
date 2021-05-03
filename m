Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339F23714C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbhECMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 08:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233449AbhECMAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 08:00:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 101A261221;
        Mon,  3 May 2021 11:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620043181;
        bh=PasxI9fq3tjDUoKO99fOGOPWeNEd0Xo8z+KLCALVXuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GezIq1N/PCCqsTe3/9TCLWL8CVBNO5San8Mn8jfX6GoIlZlkPqXWvj4CG994FyJGi
         7grcOABzrcJ/igqRkcOyZdZvT//ZfpmjuMwoCiCBz0nVsPAA1my12RJ53hkR6YCKy8
         QCc0H/FYQSgLXVuIY19zD1fYPDhMDtibQjKkIUO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tom Seewald <tseewald@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 29/69] char: hpet: add checks after calling ioremap
Date:   Mon,  3 May 2021 13:56:56 +0200
Message-Id: <20210503115736.2104747-30-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Seewald <tseewald@gmail.com>

The function hpet_resources() calls ioremap() two times, but in both
cases it does not check if ioremap() returned a null pointer. Fix this
by adding null pointer checks and returning an appropriate error.

Signed-off-by: Tom Seewald <tseewald@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/hpet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 6f13def6c172..8b55085650ad 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -969,6 +969,8 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 	if (ACPI_SUCCESS(status)) {
 		hdp->hd_phys_address = addr.address.minimum;
 		hdp->hd_address = ioremap(addr.address.minimum, addr.address.address_length);
+		if (!hdp->hd_address)
+			return AE_ERROR;
 
 		if (hpet_is_known(hdp)) {
 			iounmap(hdp->hd_address);
@@ -982,6 +984,8 @@ static acpi_status hpet_resources(struct acpi_resource *res, void *data)
 		hdp->hd_phys_address = fixmem32->address;
 		hdp->hd_address = ioremap(fixmem32->address,
 						HPET_RANGE_SIZE);
+		if (!hdp->hd_address)
+			return AE_ERROR;
 
 		if (hpet_is_known(hdp)) {
 			iounmap(hdp->hd_address);
-- 
2.31.1

