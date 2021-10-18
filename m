Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB8430EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbhJREjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:39:25 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:54268 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229526AbhJREjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:39:24 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19I3oR6F025462;
        Sun, 17 Oct 2021 21:37:07 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bs1bug3yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 21:37:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPpcxMk1ZyOMpA+w1GBj7RRZ0Je9/QlyHWxGZEq4Fwcmof/lnzTcYueM2WKgsNMfshta5LhT50evxY83lay14HGgYtvuNpM5eazPiF/nEZemtLwh7OfNKwGiDeI1H3PONpdjB8TPe7r0b1eE6oCmxFNX4NPlT5JGD5c9L+odUrmPxnV3oqcLdaeFqsxi0hpHepRnADmll0XTNfrg+RFux8UdtEhpxtih0+T+ayAQeA0hgKhVHmjdKxopU6ps7cPh+vGN9npfrc0b4pIwc0mFS+bbcIhSEin+doiZRD14wcrn/YXP+BDTJsziA8ZGe3B8UmlAyanYnT8VIyXCOvwSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfcVrwQ2VcNaTEi86d/CW4AzB7ugXB/iJtCa1Y8H3Dk=;
 b=QD777WbibTX3uvwF/6qtbMG2dgmYZUDmSbqbUBRqGkD7B1S+QSywxDEE9rbY0SdoQfGHWXGG6BhPoNFRJ6e4sZmzlxDMBllRffpslXmK1blqkgVagOeROWpA9ppDIOXWddtyiG4W/DNKk6K/7rwrjgey2QBgikMchCXhgPBv1ky7p4V96ZdhxlZx17NwVnlgfyjkDFof+pC5NHGTI2sxfXTz0IsronBfWyI/D6xziGVtqg6gldl3rj503b8H7S9uVwTFHZo4Lt5RxNLHp06u1nzbx6MRkuiyZmD4eaISKRIOTWgsiHzBi3Qm8244Ky6Uhy896GFCrO1yAc11U6BW6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfcVrwQ2VcNaTEi86d/CW4AzB7ugXB/iJtCa1Y8H3Dk=;
 b=E5Pn6fQ394nT10s1Gx2s+8tGiaYRNUv+4xnkyolQMbt39MRnGxGrVpKfZqRZOVcf755v+e4v6eOW88SLBNDuzwJG0tgizowaFl9UtXjg2ML4O8D/ACJCTfBySmHEp9ss52FxWSAx0mKgg8Sq4jSoPN20Kan3gq+IekLmThyegns=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1064.namprd18.prod.outlook.com
 (2603:10b6:903:a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 04:37:05 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 04:37:05 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: RE: [PATCH v5 2/4] perf/marvell: CN10k DDR performance monitor
 support
Thread-Topic: [PATCH v5 2/4] perf/marvell: CN10k DDR performance monitor
 support
Thread-Index: AQHXw9eJm5/fLt44GUGPJLm7sy7+E6vYKshw
Date:   Mon, 18 Oct 2021 04:37:05 +0000
Message-ID: <CY4PR1801MB2070C0121F3B7A75693F04A1DEBC9@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20211018042015.25151-1-bbhushan2@marvell.com>
 <20211018042015.25151-3-bbhushan2@marvell.com>
In-Reply-To: <20211018042015.25151-3-bbhushan2@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed34ecd4-7267-4bc5-ef33-08d991f0eff0
x-ms-traffictypediagnostic: CY4PR18MB1064:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB10646EA4E06A37532E03F746DEBC9@CY4PR18MB1064.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eEWlx2YjDSNl2d7k341rCV76xavDE7EZOQkREYXFKoMGCUbPS0zhE4D6G92Z769kCp4+WCkr4CZ2gVc684drrBH/+Bu0IGd/w6Gj2HoGnzEWXu2NxslvCP14c+bRzjNM+vv5SDYKneq0yU2WIWsfCkGM7kCEojFknCQRv4r5VWlijCOK0DH7s26x+lbYMQX12kYR81sD8a8UAm4Z6dAHHPvIz12+M1FEkVQTBG3HJUESQxuswWwKdbyr5MaaR2l2F3NJyqHhoWalHYhMx6YbzJ/wWzs7dm/WnXQmovFgD2ilMvEQrvuLeMPmmFc8b92SZWL2aQ2a5+DsgBbIGH6ziGlc2qbLtr+aoNbDQcMLJPDxi9eT5Z6omGJ/OzgcuFkNqVbEYy7fdxYP9yxCDf0zVqBiMDKlPyTl4w4U6PpIAvMiakOPzAXGexo1l4X9Pc0WEE/PTSZK+xzA+KBbqiCSust8/oM+nEQjDcshXkFAMHi/w9Yokic7fgt/U4icC5dm3+cqlh98nLeFTD89KD3x/G31WKDyIC6MpiYToDWc12LY4UkedzRZPCnJai9f7xxensbCvCMHpRKObs8abN0O4/r/ITsevPgWbytvY3mKCIA7pxL3krcg/09nq9QnL6d+65AMcRwJhMHEGmfM2ExJiSHICaVUitOXX/hmFqaJ9ALncmykDQsqplr7sDbVwvelQpFkIdjKve5fAsrB2WNe5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(66946007)(7696005)(9686003)(33656002)(55016002)(8676002)(122000001)(4326008)(66476007)(508600001)(2906002)(66446008)(66556008)(558084003)(6506007)(26005)(8936002)(5660300002)(186003)(316002)(86362001)(64756008)(38100700002)(38070700005)(107886003)(76116006)(71200400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kuhTEKJs5gmI2XBOP2YOhamVgMCDhFv9A+kuQBhd0Ghnsf6zvD8C06TrxGGs?=
 =?us-ascii?Q?dNK9uEl2xRoGF5yRk06HGz/9YRvnX0RD2C3n7TPbfV8edCYidxU0QB/T6P6R?=
 =?us-ascii?Q?zZPQ8hHv1ZbfMPz4gqETB+3xBfuRiz+bzl/DB5/m8qxVVNKfpe00xvV+un49?=
 =?us-ascii?Q?b7dKioAkJreP53uFSyQInqIMWFPJ6PZwAZ3Ebm+OkB/cWinzu3AlzuuJ3b3J?=
 =?us-ascii?Q?Qm0jgmT0fdcyjuvGy4klDLtjEwcH1Sp5xLrNy6Mi+wFSpI4GMC77vPtfJXTW?=
 =?us-ascii?Q?an66mCOmEW5rEH4ifEpIJQWhqrvlM/n2GI191NlpL9nmwMjdXA6fQUsSKN3F?=
 =?us-ascii?Q?DamkL3RBkr8rNoiSKiLn8LpmBNjglPgIbQZuU+XVfFg3d8U8jqTmv693rDay?=
 =?us-ascii?Q?/GcI4b2IKtNGNRIqk2sW97VFBCPzXJL6EImga4zdmVjygwD/0pzFpKX1SLcB?=
 =?us-ascii?Q?BpVUE03NPv5QgZRCDFJdRYrGOPMD4FOWW9pRHwYOeb2FlfwH8IdBRmhmRqNZ?=
 =?us-ascii?Q?ifLkwPTNAPpsgCOlmDgDixxDOLRz9rm70Vt/MPt0dbzAAe31xnsok8c47uPx?=
 =?us-ascii?Q?F7y2He+Hv7TWVOwX4zTSdqEE7DfLq7kfB6To78o+mHarOaI2T/8TVevUqV6m?=
 =?us-ascii?Q?IsOwunSbe+CQBqIklVcu5X81GmHo8sOhwjEcEQEj8fCC/3NeuChwPhYJ/Fr7?=
 =?us-ascii?Q?XYi1kZ4vxolK0Y0cY5+vep4C88Fgd0T+qnW4jsMrVtOp7ofZJkLGMvwI0Y9N?=
 =?us-ascii?Q?PoqOVCvMV5ztyCAttaY3I1HWvznKpZA4goJ1sfw3g0JulDmlcK2FinjCnAmT?=
 =?us-ascii?Q?qz4LxRm23J/ev4xWp7ubGFzIt6Ye7Z5LGnpjSHOLTVBs7M6GWACmKfj8tEzQ?=
 =?us-ascii?Q?787QBal7fhYoq4O+BRYQrBfDmCbQaaKXPtK/S5xMg544KszDZJVG4ih0VF7e?=
 =?us-ascii?Q?CXW4nDUE6B3SXCLfCcbr+yfPgEfzRYa6iqalhXiAlbRZawdXWpIMGb4JNnhh?=
 =?us-ascii?Q?DyDCSE4GfvbdwIyU0c9sXKhTgnmfRxHF8gbH+DWIm+tnsWntZX9qxc1ImrzE?=
 =?us-ascii?Q?Jg7J9CmeQaobpjAqPiPtC+74xMMELqoRYkU/KrGt3L9oYM8p82Tumiz8obPa?=
 =?us-ascii?Q?GDCUr12v/3fK06xJMkkcbc6WzqctFNrxB66e82vwnEqGl1TcubT4CqR0XbK3?=
 =?us-ascii?Q?Pkr6RTEZDJdgEtN3KXWeeZHB3l6+UjdIARAwkPPOaAzgpX9Kgmet5aWvMzfa?=
 =?us-ascii?Q?4BCdNioTcqJcKmT0TzfBlRkftU6Zm+8sCDDdPmU1W4/QOOP11m3uCryltvAS?=
 =?us-ascii?Q?IBlw1n3VOgLLZ2Ij6XBSDHPs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed34ecd4-7267-4bc5-ef33-08d991f0eff0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 04:37:05.1899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJlT+vkQ7HEZx5QWt3koL7py+QbaYKi0xn4Aesp3gTw0U7+xd+quKZ6bCc08cQjYTWthp86XABQgq6FcApiFTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1064
X-Proofpoint-GUID: RqkV5uk4FMygZLlBjv_zjoHkvWPol53n
X-Proofpoint-ORIG-GUID: RqkV5uk4FMygZLlBjv_zjoHkvWPol53n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_01,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>
>This patch add basic support for these performance monitoring events on
>CN10k.
>
>Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>---

Reviewed-by: Bhaskara Budiredla <bbudiredla@marvell.com>
