Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6475745B02B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhKWXbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:31:12 -0500
Received: from mail-eopbgr80074.outbound.protection.outlook.com ([40.107.8.74]:62029
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240476AbhKWXbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:31:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUIAsF8on4jgSaM0IJxX2WusAUCUjqg3ZFaBbP7wiPBCd1fTDhapjctLl8wSUNsr8kVD0ey5ELgMr2OFlajmmMb6yaudO9sgZHhGci3Ffu1QVRbvBOeVifRec7A+mTVJkavB/0F1mXPaR4w3FYcBZHd3E3IeZlJdGr0CG7FHkyX12qGy248M34RhnGpD0L3qb3OHIIIXLm1PW7cxAvmMb1TPaw1Zhjsf3q7xEOF0hDH05nZClNgEiNw+OyMOBtv/fTPakMV/O4UQ+D26xvUqLu1pKjUQbYM8Tf8Dlv6fM7yG+vjsaObIZBs/pAfS5f/KeJgthgiXL0L7gwQp4jz9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmuZ1WBrSJyU9SkSNoiAEhkhK6RlIF/fkywqSGEblwQ=;
 b=FiL6+sOLSTGQRk43ERy1bPybyiiR/nvkRmJvT+QBxDICaa58iFG904e2BT97XIRLeTBSOQBBG7xpe/RnAY23xn7fcvPC8c50gFIEVhibuaoA7ghYsgSHvQzJadpjQJXabeNmNHtxaG11b6Lk1Uejl7YVFQT5QtdzLWhQ1cqQoABysEpvqAxlw43B9KWRj241x2JujXsth1oQpWiXj3nU2FS+LiCkvbFKBHb1Ba0QxZYk+RytLGdtb74wLbFM6v7fwV2YJG6DAd2iqwbPeCHBBHlyt6sWfaKafGSRJhzC2OKk+pII+lm4+z2wLcqEJkHSGBiWQkmUHYDSga/r9zUbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmuZ1WBrSJyU9SkSNoiAEhkhK6RlIF/fkywqSGEblwQ=;
 b=yDLu4+cwWRecNyL97AqJspH0CucbCxMv2vEsWU4xwYyYRElOJ/2o0e35MN+ZfZQrnqiBpBgNd/o7xsPzOriMs/yVfaN3r871ZjKIeuEcV3Y8m4I5YMLDjjRg8bdPD/3dD2ysc2jhQluXsdmVvVnxuE0lRYdjncFv/1Bp4ruzFw8=
Received: from AM0PR02CA0152.eurprd02.prod.outlook.com (2603:10a6:20b:28d::19)
 by PRAPR10MB5251.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:291::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.18; Tue, 23 Nov
 2021 23:27:56 +0000
Received: from AM5EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:28d:cafe::80) by AM0PR02CA0152.outlook.office365.com
 (2603:10a6:20b:28d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 23:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT016.mail.protection.outlook.com (10.152.8.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 23:27:55 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Nov 2021 00:27:55 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 24 Nov 2021 00:27:55 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 00B7D80007F; Tue, 23 Nov 2021 23:27:54 +0000 (UTC)
Message-ID: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 23:27:54 +0000
Subject: [PATCH V3 0/3] regulator: da9121: add DA914x support
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e6041b-9462-4c10-57b9-08d9aed8e0cb
X-MS-TrafficTypeDiagnostic: PRAPR10MB5251:
X-Microsoft-Antispam-PRVS: <PRAPR10MB5251D9015B60AC3A519BD47BCB609@PRAPR10MB5251.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctVVh/doMHyztQLuPATXgWykpvcSaHcj/e3XfYQy8Oq3IaUBFnG6xqO0yBdGf6XygvgfZdP98+5cvZxdjBP8IbmvXZZpiiIz5sZ8c7Lza9hMHpfthouudGa1o4rThJOrSaahAGjpdS6auEpTzSYjtu/CwiRMA/O1dZ6QfYp3oRsPVo5bdjk7Rt6NiHGwK73iayHbUP1/qa2M3Bj0tzYWjlr3atAgL6XhAhkZIlPapfJDjUBqbl95ZKpRJ5fR8575nEKi4MPeE8dDVMhUMWsnaTlvRpZtQctjzblCRdeXR+j0RCZsIS7eNy4GYyS0JhHqqZFRkXst7rk/5yOIV/pAPdXCtyDyRhLWdcocECrAL2MQBqswW2lOhlZTgysKzMcM6Xhs0rlExg6ZHlcV6WA0PRxNciHHrHnShoPIMJTnFlfLtnrDjO0GCefNBCg/PiAm0elhb36GSppJO6KbdiuXGP+Wx1zQAD+4iP47Zh/ZNFCJq7v0ev4N/Ccm4phxex5vzLGtDvVActPB0u8aETjV8JsxUQk5yu3osxeY1QVllc/iES7EJtnuVEbSS5wLiZdsgPkKGpCRhm1GoN2IYZ5gE0r1ukF/rjwQYsT2jvhun3Ql7EG6DAwP4Toeoghg9mnEz/nSZqx8PipiFDG/Awvmuc42DYTA9Co0G9JS5D0Jyb17vosum2UfUKnCrbwvzYhBX+6VbIa2X0SOIhL30plMpaSKVzBpCOne7tBcLUmmqDA=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(426003)(36860700001)(47076005)(5660300002)(86362001)(356005)(336012)(8676002)(81166007)(110136005)(82310400004)(83380400001)(36756003)(316002)(186003)(42186006)(26005)(4326008)(4744005)(70206006)(6266002)(8936002)(107886003)(70586007)(2616005)(54906003)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 23:27:55.6577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e6041b-9462-4c10-57b9-08d9aed8e0cb
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5251
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series extends the DA9121 driver to add support for related products:

  DA9141, 40A, Quad-Phase
  DA9142, 20A, Dual-Phase

The changing of current limit when active is now prohibited, for the range,
due to possibility of undefined behaviour during transition

V2:
 - Separate removal of obsolete/unused test compatible from binding

V3:
 - Fix binding update
 - Improve patch titles


Adam Ward (3):
  dt-bindings: da9121: Remove erroneous compatible from binding
  dt-bindings: da9121: Add DA914x binding info
  regulator: da9121: Add DA914x support

 .../bindings/regulator/dlg,da9121.yaml        |  76 +++++++-----
 drivers/regulator/da9121-regulator.c          | 113 +++++++++++++++++-
 drivers/regulator/da9121-regulator.h          |  21 +++-
 3 files changed, 173 insertions(+), 37 deletions(-)

-- 
2.25.1

