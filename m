Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FDE429370
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhJKPem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 11:34:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9062 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234930AbhJKPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 11:34:40 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BEfLTw032253;
        Mon, 11 Oct 2021 15:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=NWuNPwAE3ej56Is8nN/XujJ+yffNmSzprTRX3FpQCik=;
 b=Vmjz1BQRE0AnzNWGK1+B5JRU/HeEBTn6WWTB1g94jt7+56YhjyxqBzc1hntUGboU7yiQ
 9rVda9WaIypNnR1E8diqnawaq//xfXxNycDkLCNfmUCDCdW/fgJkfjqaw7pOE/uTJdon
 geTXIdWj8ujz8S0WjublOWKbfHKABOzUv9BBGPEJVgQB4DqN1GK9DrcMFyrR6o2lMn5E
 SdAee34w9f+nErfUkwK2NIs9mVbqnN7t0aDMH84DqhHuKccB3emegAYZ6H6e9keYxMES
 lO/mY0yG8Cy0JJIMHepwUns9OjuLzklq8edWuCv8nssqaXZtJdnmicLRDoBpBolHwRu2 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmq29gh1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 15:32:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BFEgAw091717;
        Mon, 11 Oct 2021 15:32:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3bmadwe2x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 15:32:15 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 19BFWETu174897;
        Mon, 11 Oct 2021 15:32:14 GMT
Received: from t460.home (dhcp-10-175-30-45.vpn.oracle.com [10.175.30.45])
        by aserp3020.oracle.com with ESMTP id 3bmadwe2ue-1;
        Mon, 11 Oct 2021 15:32:14 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH] staging: ks7010: select CRYPTO_HASH/CRYPTO_MICHAEL_MIC
Date:   Mon, 11 Oct 2021 17:29:41 +0200
Message-Id: <20211011152941.12847-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.23.0.718.g5ad94255a8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 25PLLqA_6KuwNlmXa0FklCm0hqWWSR1_
X-Proofpoint-GUID: 25PLLqA_6KuwNlmXa0FklCm0hqWWSR1_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following build/link errors:

  ld: drivers/staging/ks7010/ks_hostif.o: in function `michael_mic.constprop.0':
  ks_hostif.c:(.text+0x95b): undefined reference to `crypto_alloc_shash'
  ld: ks_hostif.c:(.text+0x97a): undefined reference to `crypto_shash_setkey'
  ld: ks_hostif.c:(.text+0xa13): undefined reference to `crypto_shash_update'
  ld: ks_hostif.c:(.text+0xa28): undefined reference to `crypto_shash_update'
  ld: ks_hostif.c:(.text+0xa48): undefined reference to `crypto_shash_finup'
  ld: ks_hostif.c:(.text+0xa6d): undefined reference to `crypto_destroy_tfm'

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 drivers/staging/ks7010/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/ks7010/Kconfig b/drivers/staging/ks7010/Kconfig
index 0987fdc2f70db..8ea6c09286798 100644
--- a/drivers/staging/ks7010/Kconfig
+++ b/drivers/staging/ks7010/Kconfig
@@ -5,6 +5,9 @@ config KS7010
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select FW_LOADER
+	select CRYPTO
+	select CRYPTO_HASH
+	select CRYPTO_MICHAEL_MIC
 	help
 	  This is a driver for KeyStream KS7010 based SDIO WIFI cards. It is
 	  found on at least later Spectec SDW-821 (FCC-ID "S2Y-WLAN-11G-K" only,
-- 
2.23.0.718.g5ad94255a8

