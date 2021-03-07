Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2F3304B1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhCGUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 15:54:05 -0500
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:51808
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232804AbhCGUxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 15:53:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzzjM1sthpW4RQLuuiOo/o7CMbXrW5VrDPV9GM4+D0sILPADXwrT1AIj3UO1SDrEyNMvLm/yS2jrw3ZfLZlWn2r2It6d1zwZfaOE+OIqCVg4cMSO6TXTTgJBZRQYr0tuTpUEx8Dv+12Fab1EvhFeJlYCZHEEu6ygUwIXw/7BQHP87DaevBLfECm7KLkesQ3PV8TZNhxhyPErcIitGC5AQoH8eOTEAKFyF4v/9O0DGNba5hc006wEzQVUGyp8YZCpSrRR/y3GKHZ5ctsT+JbItsMFoRtX2LtwDlzvm6f+cyo/HYgUSrc7y/09yADHwnw4Bkeo4eUwV6HRwfPQTKZHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4o52bvkDMeFriRwGIzDYBL78i08qqCIStc7fxANH3CI=;
 b=WUnfFmdTDLtebcnlpJxKDMk2wWu6xuzhv00O3MjM0aL9nULxJ45H3Ny18TDKBpMha6+qC+ccIrn1saV8vMLUneq6yXFqHHCz8fIQCAj3l/cyPorgDtWJBFSVGDSyYRjsfn+C8c3OUhfzwno57i3MLoI/D5oxekzx3wPZWzIuiU1cUmBteLEQXEmxX8Pt/Y/KClFV6NIfFHTtXowlQE01haQffWasJJ7lS4zM7URcfR2RHMKmwEGAYVsdKZwcrLjM//LcdSjLzrg10Yl2uPkY4qm+VZON3bVDmCGSFIVWgPXxTWJEpvgsXMuZKn5QjayZlPPXEhrZlgjnQuTrDvt6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4o52bvkDMeFriRwGIzDYBL78i08qqCIStc7fxANH3CI=;
 b=gBYRewt6DKdbO2k8bspIjCnPz92Wwu1nZ1K3Q74UiHG4bWm8HwVMn0vYrJ9nVvF5Eplcq1/xMEVjQ+ft8EErPbR8Y34Ux80I1bPu06VQSTLhvpya9qru+r6MMuIL44w3EZiCZ6fFXm+N/q+F+huC0LQw2i9DbA9LPQv70JooFTE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com (2603:10a6:803:4d::29)
 by VI1PR0402MB3792.eurprd04.prod.outlook.com (2603:10a6:803:20::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Sun, 7 Mar
 2021 20:53:34 +0000
Received: from VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba]) by VI1PR04MB4046.eurprd04.prod.outlook.com
 ([fe80::29a6:a7ec:c1d:47ba%5]) with mapi id 15.20.3912.026; Sun, 7 Mar 2021
 20:53:34 +0000
From:   =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Ungerer <gerg@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: ls: mark crypto engine dma coherent
Date:   Sun,  7 Mar 2021 22:47:34 +0200
Message-Id: <20210307204737.12063-1-horia.geanta@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To VI1PR04MB4046.eurprd04.prod.outlook.com
 (2603:10a6:803:4d::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv15138.swis.ro-buh01.nxp.com (83.217.231.2) by FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend Transport; Sun, 7 Mar 2021 20:53:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f93abef5-6b49-445a-f45a-08d8e1ab12cc
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3792DC606A76172873F7C0DD98949@VI1PR0402MB3792.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivHLwnMOZdMgo0Ug4mycEW6EilwF6tjLWvw9atpuQs5nX+6MIb2tln/s54vuajiMPUXIR7Z5OwsbYnlmU78wjJixp+/u/44WNg7DQnHlJ/CRxey2xQgArx+E9Umf6bZX3O5gOzfNcblnjoB2yVTvGRGJpMuV5k1s1Lxc/S3rWKm/kZPMw7CqXJ221t2YzCysvQqBHW8gcT9gol60++aGX9qKhlUyWDrFHIL77G8svR73KxJlY4+3IWa4J2CIk5A9kJJ24pLyA7y/BmyxJ0bkxzcKx+WAq778d3+iFE7GChSMWgbuat4yM6XApJfQtU1IkMHkMWcVDcmFgiUA/FSw40onpFU1hWM6vTfc9H6vTHtKHVt2GN7W19XC41Q1VqkINzfsl04ULeMX3RlsSXoq3wBuS3X6OHskaNJGws5ybZppfOWqCx4I5sTSJXTO+F0qGk4X07nK9IEQZeHvEjtVEg56PRxaW3oBlBlWRMDDY6ADvwyanaP0fgm+aTT5UNL7rF7mlW07YAYP5nzShmScug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(4744005)(2906002)(8676002)(5660300002)(66556008)(956004)(54906003)(16526019)(66946007)(86362001)(1076003)(110136005)(2616005)(26005)(36756003)(66476007)(316002)(8936002)(186003)(7696005)(478600001)(6486002)(4326008)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MkpqQ29WYXpsRUFiL29MZUlnWWhDSGIwVFdMYnNuNzN6cnlHYjZndDZ4QlRM?=
 =?utf-8?B?a1FnU2hCNFM1QXZPMDRuaWFZU0VLVmI0ZHhiVEhwQS9aYlMyWHN4MzlDL3pX?=
 =?utf-8?B?S0FJUDE4ZGJvNVF6bzZkRWtGUC82bjZYS1IwejJLZlZtY3hHN1QvQ2ZNUkpR?=
 =?utf-8?B?ZnFzZEdQNm1VR08va1V4Uy92Yjhzem5uNi9QME5HTUNNOFRVT2lGNXh5QlJ5?=
 =?utf-8?B?VDNhZzRpdm1qVk9lZ1d5cEhKZXh2eUVtUFNDd0RKZitRZElicnN3TXpaMjRX?=
 =?utf-8?B?RDlCc05uQ2htRHdUMHJRelNnR3ZaVUJ0a1pzWElWT2JtV0RJTXpFK254Q1JZ?=
 =?utf-8?B?S0F2OVpvSER2UVNBSFk1S0xjeTA4MFM5eXhNVmZtUHFVbFZOZXpmOS8xT2Mx?=
 =?utf-8?B?OThHSG1QYnFBRzlhTXNiYUZvamh1QWtVeEk4dzc4RlN2amdhQzJ3bHJhek1i?=
 =?utf-8?B?Z0tiVzFKWmxCRXdGVW03TE5xQ25CSEp3L1M4bWZCcXdSUTFZbDlyM0h3WG5n?=
 =?utf-8?B?UVhBditqVVJtVU5JZWZhN1FWdm5LK3JUdzh5M0tIMnd5TjVINE9IMTBobTlL?=
 =?utf-8?B?emM1VHJZUWJCbXMvdldEaUxjWjh3ZDA1Zko3REhpYWtpV0k5ZkNJcmQzQmxI?=
 =?utf-8?B?S1Y5bGZNOUVyaVk1SndiVnZaaXRmeGZ6aytsTjFwS21HNmJISWh6bE9HdmRn?=
 =?utf-8?B?VStsaEE0VHdERkU5ME4zdnltS016QlhnTHBjNmMwOGJ1R2twbFh3VXp4K0dm?=
 =?utf-8?B?MGdEV1JOS05HU3kwb1V1ZlFhZkd6RXhXNURPM0ZZZXRIb1BFQlBLdVM0MCtS?=
 =?utf-8?B?M2VMbnR0M2JudkZNWTdzUk5hQ1ZEcGRzK0lmb1RSNnVjS2l4d2ZZR2VDSmx3?=
 =?utf-8?B?dVJYUEFXV0swL2owNmlpSjkvMkpGZlI3QWdFbC9Ld0t0c2IwdVpHRHlmaVpw?=
 =?utf-8?B?eS96QjBZT2cwVWdqMXRRaDVPL2dyOTNZNTkreEs2TGFqcjFNYVRuT2Zxdy9a?=
 =?utf-8?B?WHREYlZwVHJRUGxRWkltL29HdUFldmtOMzlReVJOTXovY1J1NUFhYTRiKy9R?=
 =?utf-8?B?RkZZMER0Z0QrUHJwWWpoRUV0MUlzdmNkSDh5a3hOS3c3bFQwTmRlMlNpY29X?=
 =?utf-8?B?ekZPbUhFbGZoRDV1K3lReEJ5U1pucmNsUEVXdUFvOGw0YWg4RlVGdGdjR29R?=
 =?utf-8?B?N2JET3dpeExuNld2VERKSmxLVW11dDJGNXVWRmpGRCs5amtPcUxwNFVSbmtI?=
 =?utf-8?B?Y2Rra1JVWGpjdktOMVY1YVY3RUpPMlFhU2lRbE5rTVViR2hTRjVyaUdONmZt?=
 =?utf-8?B?UUVhR0VvVVNIUk10czArdjZGMDVVTmRZMGJEYnI1NUpVWTVDbHl5dFYzalBz?=
 =?utf-8?B?ZEV6blJ6WlExK2xDNWw2bmZXeGJONjZ0czVINHN2Skh3UzIwVk92T05uZkxR?=
 =?utf-8?B?Njd2YklZOVBpSWxmL09yQVUvU1k5cENSRmhmQjVZdjJvQytuYXduM2VQNnNz?=
 =?utf-8?B?WHMxMWFCYjlMZmIxYVk2eHdjdmZ2TFc2d3JzTmZvN1h4QmlLaTNZR2dDMGpV?=
 =?utf-8?B?MEhxZ2RjZUl6MklVd2pmSTBEWHFyNG9TSzB0NmtHd0lUSitoUkFmZmhhYzBN?=
 =?utf-8?B?TlllSVFJU0FuUFVpdEhSTHBZM3FTYlR1dXZFUW1UUkFmaDBFcnRraXM1ajl0?=
 =?utf-8?B?dDkzMVo0ZTIycmlKNmNISGFlNjlmVUFibVY3Q2F6RTR2TzA3dEE0eWdjUjNK?=
 =?utf-8?Q?W35HSIprnc3mRJSh90Ng/y4OgHRsWVU8XhRcFCc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93abef5-6b49-445a-f45a-08d8e1ab12cc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2021 20:53:34.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSsgPmRwDjHQqeni+HQushqj7e7aaBG1RIt3ZEQpZeNdXN+naZyt4yrJKdXBhSEHCSx5ifFaQGc/3tByO+MMTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds "dma-coherent" property to the crypto node
for NXP Layerscape platforms where the IP (CAAM) is configured
HW-coherent.

Horia Geantă (3):
  arm64: dts: ls1046a: mark crypto engine dma coherent
  arm64: dts: ls1043a: mark crypto engine dma coherent
  arm64: dts: ls1012a: mark crypto engine dma coherent

 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
 3 files changed, 3 insertions(+)


base-commit: da1a6b8bec881b67f0e234ed19e8b7e2fb1e7812
-- 
2.17.1

