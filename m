Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8545BB1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbhKXMQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:16:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243389AbhKXMOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:14:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 077036115B;
        Wed, 24 Nov 2021 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637755713;
        bh=XdNp5BEcKzHqxCQE890MTFd55JmUkz7siSqjavlsTS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhQJM5Yq9sovpfZVi0quI+VRConM8PLXYQDY1HjOOkgMaxkAzBl1YbGAlnMgjykNe
         cQQSpNniYfgkkaE/GAtJB0qKY6Obz5vG8luMgzqcbahU7h01F4RjN+0408SqktngYA
         nrY1PbKz1IH4lMxpSpMHkT307SxDGQbd7L0/KbAg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meeta Saggi <msaggi@purestorage.com>,
        Eric Badger <ebadger@purestorage.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4.9 031/207] EDAC/sb_edac: Fix top-of-high-memory value for Broadwell/Haswell
Date:   Wed, 24 Nov 2021 12:55:02 +0100
Message-Id: <20211124115704.958091457@linuxfoundation.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211124115703.941380739@linuxfoundation.org>
References: <20211124115703.941380739@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Badger <ebadger@purestorage.com>

commit 537bddd069c743759addf422d0b8f028ff0f8dbc upstream.

The computation of TOHM is off by one bit. This missed bit results in
too low a value for TOHM, which can cause errors in regular memory to
incorrectly report:

  EDAC MC0: 1 CE Error at MMIOH area, on addr 0x000000207fffa680 on any memory

Fixes: 50d1bb93672f ("sb_edac: add support for Haswell based systems")
Cc: stable@vger.kernel.org
Reported-by: Meeta Saggi <msaggi@purestorage.com>
Signed-off-by: Eric Badger <ebadger@purestorage.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20211010170127.848113-1-ebadger@purestorage.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/sb_edac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -1009,7 +1009,7 @@ static u64 haswell_get_tohm(struct sbrid
 	pci_read_config_dword(pvt->info.pci_vtd, HASWELL_TOHM_1, &reg);
 	rc = ((reg << 6) | rc) << 26;
 
-	return rc | 0x1ffffff;
+	return rc | 0x3ffffff;
 }
 
 static u64 knl_get_tolm(struct sbridge_pvt *pvt)


