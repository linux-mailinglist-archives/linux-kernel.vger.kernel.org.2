Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DE3F1433
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbhHSHPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:15:40 -0400
Received: from mail-am6eur05on2074.outbound.protection.outlook.com ([40.107.22.74]:62688
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229909AbhHSHPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:15:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPPLiIt9ggc+t3B7SHvEVa47Uv6Zf/9YIDgPH3NmCEx3eNJgUSjqKjRx4wbz7cdDGCvaugAAuM6RaTL3qt+R1qy3MrJdbvB5v+3ngl/swgudTvvrFxxa23hfzw2sOXQMoFkyBPoSduXmoMIbKONorc/9UukOK/WnHMIx3jX0PfEbcjGrL0bKlcjj8B/oh5ZqBD1d1PToeuOwfL3soUDe39PiBQcCSOHk9540gcgy0i13pDjTMvi3YuNbtmjO9C3m8ruzNsP+t9QCKKNdrg2s120R60I6PaQrHOfy35/kdrPmS2nKiQ5g2Qzk13AfPfuyDsxRgE1gH+YVg7Ox9Jextw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P1N2j1ZTcHoHoG/Tks3AizTXNqI/rYeCDcYIKJ9rc4=;
 b=GtGrI/sjE1K14fTu0kAMPJWB099EVQ1B79JVMMS6EnDly5BP5IJZGWLrSMyAMIfPtOLwdWu4Xua4Jim0NZ79K6teQ30/qEndhjU+e+To3UwG9SJZaE4asXpfK8pvRVRvkExT0wm5Vzu9bQnN9g4z6XIfgcTaNtSR+KQ8kzcxWFq3Nuvx8o+hy9IVn0vv4fRKV2YYqz/YK/XPM+1aSd670Fc1DiKauTDze+b8Zp4YXDqEhHsdgB+rLLYThqtyqzdKaiuNI8+cEZPZ5tHXj8Tqx6TLa0/rBqE9gGMl33Q88XAk0Sygg6n3KXN5V6vpanw6dAfNnIBo9ed6ILXOfDLuTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3P1N2j1ZTcHoHoG/Tks3AizTXNqI/rYeCDcYIKJ9rc4=;
 b=GywmuLjkfIUGtWERy3dWoXkC57pxzl88f6W5QTTUm/2pXtzv+5aoaZpZ/g1mb/aDe+Nk3g4Eg7rocblq123SwTFNm1OuYKxSFZCTJHjQwV1B4a5GtUdwkbBRAwua3TZdtQDxRpz4DMGrm21/c1hICj8g8phMqQ8+BZxfX7aINVQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0401MB2512.eurprd04.prod.outlook.com (2603:10a6:800:4e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 07:15:00 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::d010:8002:44b8:117b%7]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 07:15:00 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     robh@kernel.org, l.stach@pengutronix.de, galak@kernel.crashing.org,
        shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de
Subject: [PATCH v1 0/3] dt-bindings: PCI: imx6: convert the imx pcie
Date:   Thu, 19 Aug 2021 15:14:05 +0800
Message-Id: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0105.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::31) To VI1PR04MB5853.eurprd04.prod.outlook.com
 (2603:10a6:803:e3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR01CA0105.apcprd01.prod.exchangelabs.com (2603:1096:3:15::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 07:14:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f85e3b14-a08d-41e7-4ed7-08d962e10e8c
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB251212756D3A492C67CF3EA08CC09@VI1PR0401MB2512.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qm64H+Q0GaiFjGvMvT+yWLzqU5r9Ft5hSSFbllf+UPCLeaWbVBQBjLSqzdEJ91VNP+cCwbklalgB4p7COqceEiu4YkD9LWQACTZqsDNMVLjWWoKO9q91Z6ZnEFEL9FOYjFZiqSiWXeqbzOSKn/SNGXpGn1KMTMmqiZ7ha8YKgYkD0FsNZ6t9XCh5Zel5AtFeMniZcGsNS4234QkiNxLmRpk8W3qDVTtM6xI3UrsLikJgoP0+cK/ul/sUlxaLnKWhObwcHHWfdY4JYVzXDc7AprVsO3yeUumz6KjuB5wGDyt/n3Cx8kM92sh6njn+JV+cBo1BWbxVM8gVEN+FW0aHlqpsNyId+xLkcjTN0duBGAkr58YchU9ll3UTRzGIToklWxhL+mhFH8Zm/MOgADgGCPR1rY9Xb/KS7VtKu1bOOgdbSWBRCrXTJRRkGLCu4UaESqcEzakMA9rPxQoUNbmc2mAcDHnuqXcMXhucgzsc9MJsjGw3M6Qb84l8XKDCJLrkTnw2SyqLeHdfV9SL9vrSOxxTzdQ+OXyhagqr+/NMpmZyIjg4kyx2+VG+qV/vLdbrveeTBcp8wx8ZFTVI1kazzjaId/RzRAW9txcLGQICYieNTRsmygvMTTti9yQC5fow/m+sRW74+AAen9xNijD2fR8SXKjjfM8jOWk2VgaZutmB9kYdVeN1otiVTA3JNagPfe0bf/W6KbPb72IvNagBQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6512007)(316002)(38100700002)(1076003)(38350700002)(508600001)(2906002)(4744005)(66556008)(83380400001)(8676002)(6506007)(6486002)(66476007)(52116002)(66946007)(186003)(2616005)(956004)(4326008)(6666004)(26005)(8936002)(86362001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VXgqgvSEl1Y8dzVRx7z85BmW1w4/D7ZSWXEc0WXjsxGXxnXJ9UJrBHq070aT?=
 =?us-ascii?Q?wkkgZijiLVFpAjyLOMvFFDOWrm1YtUegYjxKg/PbUvROZf3XrUymCNUbcFUr?=
 =?us-ascii?Q?duyjkbCPKfrY9XLWrENugxSApC0mdBQwJRrPUOLgyoEgrH8MRgHeVA3105m4?=
 =?us-ascii?Q?ANoEY3vwAbC9JIMKzj4RcG12gmyFc2vZaMM9ABaoeLKBKeB3pp0SeBIQLu1I?=
 =?us-ascii?Q?kJ3eqADk8GCtSroPmTJ2CMEN+wwKHVQXBYeIYG/WAGNGXoLTQ+ureVHQgWGg?=
 =?us-ascii?Q?Trn5LUYJq7od71Y66VWnXj1O1ND4LftBNKWusXNgQUWUMiuz5RAnYHA9jewV?=
 =?us-ascii?Q?6Eo1IIraaIouyBJnMoxlgwCZ8O1eUf5mzhBa5MWW97pOMQ4QApTcJ6FDupFI?=
 =?us-ascii?Q?5eERh2Orp1UXtel902LIgdOXNeVH08c+wZGcs718q/TwO67P+opPZtwP2gV1?=
 =?us-ascii?Q?RWcyfSHmvp8y7eH9HtBBaqsfK6MDXFHnzYqe4rH6AaHf7QzJykT2idFv1wEE?=
 =?us-ascii?Q?qjmXqB5QRMuwscvxd4oX0kqUFGDfktVo5sXR0BO5INXDIbw//7hIHJUK9dBa?=
 =?us-ascii?Q?kIhO4NI9SIj2jdWCQzh0ml97tK+/cpNSE6o/465nvKR2CXBAHbfZ1GOuq6bY?=
 =?us-ascii?Q?rJmDcA/H5hupsmcUxn4GJ07ihs23IFn8IhRekJJ3B1Rpu1OoyK+26QSr43NK?=
 =?us-ascii?Q?Lyh1iWeo57eHhHZyfI5I0n0Bel/3BcMO3OcxKmzW2CP9E6DK5BJl/1dl63X2?=
 =?us-ascii?Q?GJfq1Z+dn9lqUBoiCeQpXcQRAwHfMCwP9CkjukG85thy9v7BXNV1wb8wTzPH?=
 =?us-ascii?Q?qVSE9DYDjQKXX1E/eoVZWEWTH58ElpPNyi4zyf2mJ2ixfJh3ZOY1zr49LZAd?=
 =?us-ascii?Q?4DlqkU9BQHzWqy62g+xcuIj6rd5FohZt3TTbkmNFqpwwePuBiv1qthVc7zzi?=
 =?us-ascii?Q?IwZiNLtgOz2o8zttr+5sIS4KquAp3XgR6bkCI1MqsnqDTRcAF6m3TLQf3Z5s?=
 =?us-ascii?Q?XnQzkCQt6asMaoy4h7NOYuxm10tDxohmpkhGQGsIwF60QSnfWrga3HygeRFb?=
 =?us-ascii?Q?E+P8E4V0P6iUnqa5v8fKGlswDA/zDNGz0ow5Rk+WPTfElaQWjn3V0lwPAOyw?=
 =?us-ascii?Q?lixV70UIxvXRUGhNblwym3Na5GaAlqIn05DBkFFHmIBa90zgEHjfJ6mYX+6B?=
 =?us-ascii?Q?ZIJk2c1gc6zUqLUKARHqXcM8rDB8mNp9XZfCyZk5u7dZPbkXOd/a0FvrjXpw?=
 =?us-ascii?Q?OvmMUYN5bLdL1cZR1ojeRTJvBwT57kbz00vCppTzukTOi/ZRvGtSczeoFobW?=
 =?us-ascii?Q?cUzV8KQip8wmV9Fw8dcuLwvd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85e3b14-a08d-41e7-4ed7-08d962e10e8c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 07:15:00.4443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ekfxznUYWU5jYfNWL78VLVm50iZuSenxclEkjj7lgoK+U9bN540j+9qtEjvNBlkj485SPoUaSTllQWzH+f8dkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2512
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And fix according errors on imx6qdl.dtsi, imx6qp.dtsi, imx6sx.dtsi,
imx7d.dtsi and imx8mq.dtsi found by dt_binding_check and dtbs_check.

 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt  | 100 ----------------------------------------
 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 207 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS                                               |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                            |   6 +--
 arch/arm/boot/dts/imx6qp.dtsi                             |   2 +-
 arch/arm/boot/dts/imx6sx.dtsi                             |   7 +--
 arch/arm/boot/dts/imx7d.dtsi                              |   6 +--
 arch/arm64/boot/dts/freescale/imx8mq.dtsi                 |   8 ++--
 8 files changed, 223 insertions(+), 115 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml

[PATCH v1 1/3] dt-bindings: PCI: imx6: convert the imx pcie
[PATCH v1 2/3] arm: dts: imx: fix the schema check errors
[PATCH v1 3/3] arm64: dts: imx8mq: fix the schema check errors

