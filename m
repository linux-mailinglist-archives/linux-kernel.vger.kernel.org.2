Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70966326563
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBZQQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:16:36 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:12672 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230128AbhBZQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:16:18 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11QG84oJ020777;
        Fri, 26 Feb 2021 08:15:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=og4w6qSY2lUuaozB2jOyAu94BPC37AyN7qNbPUGaLNk=;
 b=aJjVnKi2RjAHW8m5NpR5nPn6mHS8sp9ufRrWu3xuvU+Mcs8q4J+StA5RFT3hbEWiXRfZ
 6rECZmHC892NnI37mvp1LB15F1hcp4pjvfckdp/wrjBbQNkXRI2/HixqW3hi0PUeE1oX
 y4o4b7obK36hdiC0k71nEcZzJL1f/UJ6fuZqqXvAr75tBc6NlwkyB8IzAku4CupSYTay
 gQn6+BcWVp16e8xUpWAKTKA/6twzV5EjX1IT7+Hfw7jbeE0Ut7bpOj0J0yjJUagZu2kC
 URyDdxuKYHaZqK/7Vcg81hoOGHzqMp19yzVgjZryxxqyCiSjmRMDJup8CfcilfdWd+F1 PA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36tyv3wqf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Feb 2021 08:14:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDrtKDVGLAS5EZCmwGZG1ItZt+gFtlgEQrjJVJH2kMXQmihLw9bxFmmoIexAvqyFP3VwdRPLWvTGtRhB76/nCuCryYJQBcuADs2Efib5pul2SCAZpAlnHcqMqbt7z3EPdDpV1WtQ1E+FKawXRfpNxob/lgrh9pWOpCyBiN6I2HIgxjF4jnYnwrsImSphavkwOK1DG69Y3OFjyH/y2EyobCVVfhvTK/0pR7XcacTgPLUPMCU1raZSElZQ95x/aRqWcuMllxkbMms8B9MF2p0CEvnxAfhuVrSNJ6U8xPkFlo2UrBSFEF6NI8XMpHUa5XwcmwrYx9N1KCx3MQtGzzTGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og4w6qSY2lUuaozB2jOyAu94BPC37AyN7qNbPUGaLNk=;
 b=X8+CjsNGXy5mIBOM2DUDMw3Hqo55uyPh5xDbNem40dq/OSSBtgczPOlI0F0LFMBrB3cqeZgH+7bCfhur9GBgA7m159QYCHHCC8jtMfJ8vvTO7ppf6E+L7LWkNTVSk6jOoRQuE4JKGeTGb/m5ukVOwP5UQ32cMj14kNbaq3lVYKTOUP/eC2rd+s1yGbPgf/ervhshMQ0ABwCrsh8/RyNfGATkFw5oBhKNoSxAQMnKOPAFgK3LQZbHiX6TsBkKmerM+g//edd2TxY+yU+ICrgMJVSVUhk/Zoc/SdlSyX/yISSqBdhk3WLNyXueSf8GdyaVGpOxqoTpwQX0jMjyxEshGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=og4w6qSY2lUuaozB2jOyAu94BPC37AyN7qNbPUGaLNk=;
 b=MLCln2ONQISPVqqIPgTCeITzw51UbRqThcpdXibf4DoIhlNk1iRZC+v2fhJBsHL113KrXRpHN2xGvm95JQfR16nsgzQ2X/6NRj/ubVh/7lQ48f8edhosNukeM2G6Xv3NByyH6WmJLciRC84weOKcyWeaUBp523SxhmrlYHP77xk=
Received: from MW4PR04CA0028.namprd04.prod.outlook.com (2603:10b6:303:69::33)
 by SN6PR07MB4765.namprd07.prod.outlook.com (2603:10b6:805:31::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Fri, 26 Feb
 2021 16:14:57 +0000
Received: from MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::3a) by MW4PR04CA0028.outlook.office365.com
 (2603:10b6:303:69::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23 via Frontend
 Transport; Fri, 26 Feb 2021 16:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT046.mail.protection.outlook.com (10.13.181.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Fri, 26 Feb 2021 16:14:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 11QGEpqa016505
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 08:14:52 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 26 Feb 2021 17:14:50 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 26 Feb 2021 17:14:50 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 11QGEoQk019803;
        Fri, 26 Feb 2021 17:14:50 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 11QGEmkq019797;
        Fri, 26 Feb 2021 17:14:48 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <robh+dt@kernel.org>, <laurent.pinchart@ideasonboard.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <nikhil.nd@ti.com>, <kishon@ti.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH 0/2] enable HDCP in Cadence MHDP bridge driver
Date:   Fri, 26 Feb 2021 17:14:46 +0100
Message-ID: <1614356086-19745-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d8ec5be-892f-4aec-4e58-08d8da71a8ba
X-MS-TrafficTypeDiagnostic: SN6PR07MB4765:
X-Microsoft-Antispam-PRVS: <SN6PR07MB47659A3CB6EDA7060DDCE8F9C19D9@SN6PR07MB4765.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jT3b1QbrvxMMfEPL28vTTRp9GMbdkOiP8mH7li+4zeAuQaSRUlQbZdirzvWU5xdJZuXHeZ93qFBI6liseUF+WYWhxNzg+cbwCVO0N0rcX5NLYYHy9in6U9vGbASXp/+WdKB/qlEj1kZQauAkL+6MrvoqQBvCXxHMQfPoulM3L9gL8dgMCp170eFSWH5ZOXfXHQwapKj9LQJI2LkcHkTwiNP822WzpdGjvPE4fc3ZLpSQhcuRW/2Thq+PnX9CElKrhpQoi5vajN5rDsbckfEHLsrVzGZ/Vlpv6AIqgegqR7Q4RoiXTP/u1BW8QoBJ8naJBAWwBKEmo+6BVdtYShE5T6D29Na5WwddS63sA0OVDzKEh1xXS4wy4i3Cs1VTwGd2ZWQJdx9qyq/FEoaQWP/CXe0efnXLdNlw6HZUnP5mDUY43+SPgRJRlv56iHWDyFRMPkesdg6T/9YCj6rmNoIPUF2bfsjhsqmjW0lUi6otVkk4MN7evwWeBP5ONKBaPOKZJYhiH64cyq+d3mDAdcpKgkTZQmtTNqGu4vC7N7cL/I3Zv7UCFCVgpyPiFXRNCBL0c1PucVJFSuY67ocKHhDGgnc4xA50fr9vZz5JIcYyam0Ft59mkpZ2hR0Maaah2A5n0c6VTd5UoiKWv7pDZbybuf7mmsInhTQ0EpmyPhUOgW8xQKw/Xpi6KlmHcfDYaQB
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36092001)(36840700001)(46966006)(42186006)(7416002)(36906005)(82310400003)(4326008)(82740400003)(4744005)(107886003)(47076005)(7636003)(36860700001)(83380400001)(2616005)(26005)(316002)(478600001)(2906002)(356005)(8676002)(70206006)(5660300002)(426003)(336012)(110136005)(70586007)(8936002)(86362001)(186003)(54906003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 16:14:56.9277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d8ec5be-892f-4aec-4e58-08d8da71a8ba
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4765
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_05:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxscore=0 phishscore=0 clxscore=1011 mlxlogscore=809 spamscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables HDCP in Cadence MHDP DPI/DP bridge driver.

Parshuram Thombare (2):
  dt-bindings: drm/bridge: MHDP8546 bridge binding changes for HDCP
  drm: bridge: cdns-mhdp8546: Enable HDCP

 .../display/bridge/cdns,mhdp8546.yaml         |  20 +-
 drivers/gpu/drm/bridge/cadence/Makefile       |   2 +-
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 105 +++-
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  21 +
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.c   | 578 ++++++++++++++++++
 .../drm/bridge/cadence/cdns-mhdp8546-hdcp.h   |  89 +++
 6 files changed, 796 insertions(+), 19 deletions(-)
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.h

-- 
2.25.1

