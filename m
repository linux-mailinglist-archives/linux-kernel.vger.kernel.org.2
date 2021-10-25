Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7C8439A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 17:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhJYPUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 11:20:51 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:52790 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234050AbhJYPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 11:20:39 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PDvnFP003305;
        Mon, 25 Oct 2021 17:18:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=/B1ovPvs1F2t7y2D3TF9nCO3cWsr7QGR4ztsocLXIvc=;
 b=jjJriQBlTnnCoklBSJh/Pphqgq5qKXIYimCuw66IgPl+8PiDu2wZUvo/Brtog8ICmGWg
 lgBT31T+5qEpVDRtDKIbUXdkHOBqUsJfqZ5WzdpEis4iJOgZUoVgJwAYXUZJTWpqoMg7
 aSJ+ZEcBbHV2KZ9PUxFHC5NF/Ea55FxH6i60v8+6Hd12+GPZexloAC1v5rxBtLB293Ae
 v/myklU5jC0DqjGzyOi94oCQLP0o0PU/Vvvy0/i6P11b4PRq5K1dYPSHmWosNii6vLhh
 SuExehiBCHztbREcaTfaiQCDrtDa4q1Uy1VGz8riPSqSLpKWHUQUJYdcHZ7ypqsdGakl Vg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bwrvj2anx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 17:18:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A47BC100038;
        Mon, 25 Oct 2021 17:18:04 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9D72324187B;
        Mon, 25 Oct 2021 17:18:04 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 25 Oct 2021 17:18:04
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>
CC:     <robh+dt@kernel.org>, <amelie.delaunay@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/2] tune the HS USB PHYs on stm32mp15 eval and disco boards
Date:   Mon, 25 Oct 2021 17:17:48 +0200
Message-ID: <1635175070-28722-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_05,2021-10-25_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tune the HS USB PHYs on stm32mp15 eval and disco boards, now that
dt-bindings and drivers have been merged in [1].

[1] https://lore.kernel.org/all/20211015161427.220784-1-amelie.delaunay@foss.st.com/

Fabrice Gasnier (2):
  ARM: dts: stm32: tune the HS USB PHYs on stm32mp15xx-dkx
  ARM: dts: stm32: tune the HS USB PHYs on stm32mp157c-ev1

 arch/arm/boot/dts/stm32mp157c-ev1.dts  | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 16 ++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.7.4

