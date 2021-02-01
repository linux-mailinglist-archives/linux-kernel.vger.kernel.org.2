Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7CF30A4CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhBAKBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:01:12 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47736 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231598AbhBAKBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:01:10 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1119aefV027350;
        Mon, 1 Feb 2021 11:00:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=N4vMR5Z35V9XSwzyek947QkwbVqglusfZ07NaE7/aOo=;
 b=rEI/k/LcwY/SMN4r1UtpDtUXL51LdfsVUVc9FMnf5V2W8wvXhQLOmCA7IHrK1nvhcb25
 Lwk1dTQ859Z4Exl4dD/jje6ItKtfNXjDCXA3whYjgD4eDE4ueNhu8cV3W8HHl9Y6QTi+
 FIFtP3NLA3Lwbm88derdWi9JvEugPnX6I/nMlMHrT2/2hzUiUMY6VhlEdvzaEekC/PnI
 4HSAtVVzj0UIg1XqOGVJJ1CwKsjTD0Hs/PN6uWUTDhEwGY6Q9PcqmV4OMymPynvF2mru
 gwb5URfx1j/VHgbg543Wrq2Szpk+qQTYZWHQtoEX8jt4QHE0GZTyvz0P/GW2kMj/YeLX TQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36e7x0j9y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:00:28 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1D18010002A;
        Mon,  1 Feb 2021 11:00:27 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1024422D602;
        Mon,  1 Feb 2021 11:00:27 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Feb 2021 11:00:26
 +0100
From:   <patrice.chotard@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/3] MAINTAINERS: update STMicroelectronics email
Date:   Mon, 1 Feb 2021 11:00:20 +0100
Message-ID: <20210201100023.10985-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_04:2021-01-29,2021-02-01 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

This series:
  _ Update st.com to foss.st.com email for some maintainers.
  _ Remove Vincent Abriou as STI/STM DRM driver
  _ Add Alain Volmat as I2C/SMBUS driver maintainer

Patrice Chotard (3):
  MAINTAINERS: Update some st.com email addresses to foss.st.com
  MAINTAINERS: Remove Vincent Abriou for STM/STI DRM drivers.
  MAINTAINERS: Add Alain Volmat as STM32 I2C/SMBUS maintainer

 MAINTAINERS | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

-- 
2.17.1

