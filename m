Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E4C403F16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350039AbhIHS2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 14:28:19 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:27374 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235227AbhIHS1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 14:27:51 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 188ILvw9030286;
        Wed, 8 Sep 2021 11:26:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=FQuzQx64q4H3khbdMZn2yGkKH8ce2fX8A5IXneOih5Y=;
 b=fEsV8gdCNde+FkSZRIt9ej7t883o/VeabfZyk99QnhQWmH2wNHE9YCggK3c3S/uf846O
 Wxoqjm/yVDegMNJ/gTUmX1Lzr1AL0ow4pd3yg5kqdW7RLNPnxakMWUUF3dMX+07qgC9W
 En/wF8sCmneFlK5szRNgI/GlaUlGSkvAg5MZAKJ4haFI5OtQ88OkBGFr93Z2qNYoNHez
 +Kb2wloX4LAbC9pZDeKX7Imh4y4eBNcjLrDUZtnbLQq8x5SzLgz4WYJsl/3Lm3xgjOKe
 jUYOK8T9D3RTuW94RMk5R0Pw8/fA4cFoA3tSTwmNXNfMJQH6FZ3tJv78P4RIdjzLvIxh nQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5c470-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 11:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJoTjHRuWxj9OHDh6W2TD/062xJZoVwcdh5V+U4Sw7CVkTj6TMzTCLBYmWI50tDZQuC6v3BkKjHSaSb3VDRx/ccZlT9zuD8vVtglxkWAm0X32GAUj6II0NUibjfBHh/PpgS7C6NQmtCQbY5djuUJ7qIcn9n5T5LbxEHavasj+PNsgWF6rAgoGH4KryyaiOCTl33m1SJRjTMQm8K80ISk46SrvzkqXz1A7rOSOfWBWP1pzGGArhJEPQ22DhIvGhRtobq3h9rV4tDNyMgsLf9UuI7qYhIQMx3adsIxh1pYuoB0IRcGXcl4AivoW1BnLK/PyICcCGVPwojN6L/cFkJ9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FQuzQx64q4H3khbdMZn2yGkKH8ce2fX8A5IXneOih5Y=;
 b=hDEVnqiBSX50zMouKMO3ZW8qraXR/cRmgET1gyVKm+EEdB0z6vMtLf92JU06pml52ZHLQBC2SODM+loEBfM/Fo0hQNpdAif9qvECbv/wURF4d1IXLzjKjIVwBBJFNZv9gdAeqQhqlZNQiXcK/bfEy0jUXtqaQtcMraEl0xig4m2EDIjHOUIhECA41Uv6NHR4jWW2BC4/Xt/8O8d6FcucDpgtrA5yWSl4KaC1t+6DKC6GoHWmzK3UjU/vp6ZbNTuEQ/gu5nQUArui9XoRjmWlSRhyHRejT77P4eXYBOEHci3nHzteSPgVwE/9tJPKDt4OXLqPLEy1e2XRuVHJ6cJVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQuzQx64q4H3khbdMZn2yGkKH8ce2fX8A5IXneOih5Y=;
 b=T1TDn31iIT8JPlqcTHQQ0Hj6ngQBI+J+cQP/j9qclpNJlqFW2oVO795ikwsEgu6kzfNFyOifeB9zp3eikE7SfchcbF792XuiBDYKyRfxLxgJf0nT+IPD7A2eK5D22nq8jXp8+rA2Ev2PQ7JIchLf39v1DgiP4r0Rr7A9sy0i1KU=
Received: from BN6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:404:10a::25)
 by BL0PR07MB3986.namprd07.prod.outlook.com (2603:10b6:207:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 18:26:32 +0000
Received: from BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::82) by BN6PR13CA0015.outlook.office365.com
 (2603:10b6:404:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend
 Transport; Wed, 8 Sep 2021 18:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT065.mail.protection.outlook.com (10.13.182.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.8 via Frontend Transport; Wed, 8 Sep 2021 18:26:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQUwJ017985
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 14:26:31 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 20:26:30 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 20:26:29 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 20:26:29 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188IQTCS028405;
        Wed, 8 Sep 2021 20:26:29 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188IQSKm028404;
        Wed, 8 Sep 2021 20:26:28 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH 0/5] PHY: Add support to output derived and received reference clock from Torrent
Date:   Wed, 8 Sep 2021 20:26:23 +0200
Message-ID: <20210908182628.28364-1-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e666329a-d4a5-495a-dbc1-08d972f62ef6
X-MS-TrafficTypeDiagnostic: BL0PR07MB3986:
X-Microsoft-Antispam-PRVS: <BL0PR07MB398646FA94590BEB70730AE4C5D49@BL0PR07MB3986.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mGQfjTY3HG5EPf4Tcb04R6VOyS0SFmD7KsRAQpsHaxV8w3RE3nyIkRywsnzDJzBsHzFuBZ6oH5nd1AWxwq5a8m7oEr3gq/uoOiigeLb7N29dKcQTpVgVBgBPtBLk+VWm/G72NgU/xGFgi+vOsVp0kw6FEJDlpOZj++eXismTtGeCLr7SnnVG7EI5fCSOsPFnXnUf7YFS3OiCzBmXy57vnTguIa5fGxnjModU3ac0E6HPtQvIIukXiRT4wuEOIvHnFOsuAiF3sNBpJWySq1eykETMiKTtwWisTPYVhupc6YlkeaDwwm3886Iv03pvfKjrns4HqWdqm9d3pIjFrCv9sL+SY6hxu2BlLQm4gOcLowYNm4kSGEGh/UE9BTFvFhK6R+XbiriueKG+Mpqun+w2J5D+v2Il/axzpObF0WVkOlGarjDlWws75mPqbU6FdMLGA+WPTXeKPU/dfpoQZiAwbb271FCmPb5p/t2MtexpJIkiX/4ogKNhHOoQTGIUvjwOY9D4PHNExgLHXYyB1QxWl9gQvMbuqpTXaZhMAIqzyIK98N8KD8Hcp+5u/tYulEz1ZA+3+uJ0Ga+yWqCOPKinPUBhx+vOAd+jKZDGP2UQVkcEryQdWjpG5IK0GMskuPGeWp+tQ+9K113UONIClDZHZlko8i4Uhyuqr+FuKyZDpqOI0pHb6unDFSKMwmlNMLIiclorueGgZJ6ylIBVZdzpwixcsxhwQEOZH+fk0a2kmOXmbE7yRu8+zAgZ/uON6TvMT908E04v5i3K95CyJGhe1Coud2jYtPngANY81Pqco5c=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36092001)(46966006)(36840700001)(81166007)(70206006)(356005)(47076005)(70586007)(54906003)(2906002)(4326008)(36756003)(2616005)(82740400003)(36906005)(82310400003)(316002)(110136005)(1076003)(186003)(83380400001)(5660300002)(42186006)(8676002)(8936002)(36860700001)(26005)(478600001)(336012)(426003)(6666004)(86362001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 18:26:32.4777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e666329a-d4a5-495a-dbc1-08d972f62ef6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3986
X-Proofpoint-ORIG-GUID: U_PdgBw3B0TQTydpCMVfrKEXfiM81sM7
X-Proofpoint-GUID: U_PdgBw3B0TQTydpCMVfrKEXfiM81sM7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=596 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates reference clock driver implementation for Torrent
by adding support to output derived as well as received reference clock.
When reference clock driver is enabled, either derived or received refclk
is output on cmn_refclk_p/m.

In derived reference clock mode, cmn_refclk_p/m outputs the refclk derived
from internal PLLs while when received refclk is selected to output on
cmn_refclk_p/m, this is the internal reference clock driven on the
pma_cmn_refclk_int.

Swapnil Jakhade (5):
  phy: cadence-torrent: Migrate to clk_hw based registration and OF APIs
  dt-bindings: phy: cadence-torrent: Add clock IDs for derived and
    received refclk
  phy: cadence-torrent: Add support for derived reference clock output
  phy: cadence-torrent: Add support for received reference clock output
  phy: cadence-torrent: Model reference clock driver as a gate and mux
    clock

 drivers/phy/cadence/phy-cadence-torrent.c | 316 +++++++++++++++++++---
 include/dt-bindings/phy/phy-cadence.h     |   2 +
 2 files changed, 286 insertions(+), 32 deletions(-)

-- 
2.26.1

