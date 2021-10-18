Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74A6430EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhJREkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:40:23 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35994 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229589AbhJREkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:40:21 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19I3oR6O025462;
        Sun, 17 Oct 2021 21:38:05 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bs1bug41x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 21:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1JkGCuL/IoRU0pCF8rJ7RW/VYJtzCHVJB8HwWUsVeYGQXkC6vuKto5mSfJJokr0mMbxSG+Vo1zVUOeecR6CDdGbfdvdQZ2n7cq2uyYsc4rK1/MH5F4+bPOhz1BnkSFaKms8rPfqr1MWWlJphDl8iaWi/meQAKlz4F9jSdVFRVt/1pf4IooIZKKZSs22YNgtyWoyCYc0WMW6b3nKalY2r2AxJZ/MXkQ3iJitMyjlTeay1+t0vcXPXLeQQvxP1Jz/SwVZb1OWUwYULTQcRLT7Bg14doj+9fm3B7DWDFtg7+nKx0XkA79Sngcaa/nFW1bqCm5Qk1iE3pe2urlcIH3UFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ftb4BU0Pf0QV5/Z/tHUjvpxUxzkAgZobIsi+2MDaoCg=;
 b=GLimoPpagYp6ZmblllPvWU93rcqwqh+db+fUiwryjKfaC0Q6qgMXn57/YLJn/zDVBHh50ZzzmuiEoM355WGUdP9tQ0d2mri3VCO9raD3xXQV3xXt5BpiXyDFKkfikusjHEfq5SlfDkcQKieO/A8330TGe4Pc39jguiy1m8bFWMc/KTRz+83owkln1hTUcWPNNFcFpMfiZL8oY8D9WkAUz6uAR+LovvEQ8aWlMKhrJFu+qpjs+h9F12oSPCDExWa9pKdZeSOwRn2MwfnM4XI7PzhKWipw3xgM5LkDf4MXXmHkW5aXXA0ms+t7Fh7UEYDeeoEtxxS6P+dDO5eM30bBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ftb4BU0Pf0QV5/Z/tHUjvpxUxzkAgZobIsi+2MDaoCg=;
 b=pg9paWSYXTNhgJyXqp1OzzJTrtUpiaGWLm55pbEuzmYx+0cVhN+MZnLzNFHiPiLjNGQLY+kSIT1q10ODHbfgtJ8+hXgv3OjQ7BQ0V7mwifQNIGruD3IPfrjpEGZcA752cVIWxmG70XTqurJJoY1Qpvqyh8pOX/XZVTdhyHdY7YE=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1045.namprd18.prod.outlook.com
 (2603:10b6:903:a6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 04:37:58 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 04:37:58 +0000
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
Subject: RE: [PATCH v5 4/4] perf/marvell: cn10k DDR perf event core ownership
Thread-Topic: [PATCH v5 4/4] perf/marvell: cn10k DDR perf event core ownership
Thread-Index: AQHXw9eFspeAYN+B10ehY8PTl6e7VKvYKmOw
Date:   Mon, 18 Oct 2021 04:37:58 +0000
Message-ID: <CY4PR1801MB207092F0F2EFABA1C8A5B1B4DEBC9@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20211018042015.25151-1-bbhushan2@marvell.com>
 <20211018042015.25151-5-bbhushan2@marvell.com>
In-Reply-To: <20211018042015.25151-5-bbhushan2@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2646266a-5fc2-4a17-46b4-08d991f10fdc
x-ms-traffictypediagnostic: CY4PR18MB1045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB10457A75D8107FFDBA6C9604DEBC9@CY4PR18MB1045.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeW9Kfso4BJpPSh88mLOQFVE62BxboIhVyLvodQaO8ULy4PNfs3rJgOoqZrWnU4O7TsHhqs9Gmj9nY5FrMUfnilIl3GO1bhJ1lNY5oF8e0vFTh6+VHjQClM0Ch62XN3DYvWHPsOeOPx8Dp9TkxvjOb1wRepnZhaMeQaGhqHljgFV/81KGIOrIcO+OJAywCwySZT4UwvfyPhDTfmlH11pBIqr/R0Zn9T/FX0mOSwn0zryyEy1dSOh7Y/1JylGslOQ5vc6gieetiJeIGgqDvOEGsoc8vw6pA0Baj2rP3t24O4xAKuUYawYlp4yY6JSYuDf/TjmOXuTuqdcGQHJpdTGDFj0T9JCf+fHUQ/MZrwXyuFbl12JeDkdJEQT4WHKj3QpOTWihUa2dTXpSUpqnffSNccdzD7kMBnn196xvuaV+rB4Q/AyagAXV223h7Qjg2hoCK1tPg1A8Z1dcWMjkd5lY2qEpbRTCMpBzEsV3IuNq19tqw0Zp4eg3e9LDJLVVQ2igFUlxyGZxIaH6XvzMgS+U+cLcSCbvfQpLqwrhemCVHbYyWaEBwVekVToj/UPULu6lcobP0gS+QFmR9alw74yGXOvIds056Urs47Lu9v1UxPzh6EThNqGjQeu32wDW61HN+ksrRfEhuHnkjjTzV/OInQ4NmwDae/+XZ4lNbRpfHizhZbd413yXc+cjVYDBrhGmeIUCdDoUxnTaIC/CKxfdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(7696005)(38070700005)(38100700002)(8676002)(76116006)(64756008)(66446008)(2906002)(558084003)(33656002)(316002)(107886003)(86362001)(66946007)(6506007)(66556008)(122000001)(66476007)(186003)(55016002)(9686003)(4326008)(5660300002)(26005)(8936002)(508600001)(52536014)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ur11oUjNpv+hLeCZsLF4IBYEGA9iWTSoBmTBlj0lNWD5sIeBwv3qEhRTigwL?=
 =?us-ascii?Q?+U128W203TlkzyLhPg0gJ8kh0R4Ejs5/3E4WcraylkBRONOfZvOA7pu0gXxP?=
 =?us-ascii?Q?ryTJgwUA5+EStpU0/h+jV8SZug0cMDgdH85gy2hPoejBlww9Sv6ePvf4MbuC?=
 =?us-ascii?Q?rz8ybMOlCvyjftlE52r0UWdXfLeHQkNTF2P8G+7fhGNcAOGteR9t96Is42em?=
 =?us-ascii?Q?A10i+uuJ9rgMhG1phlvlXyjpxh1AqKfFxxziI6zBeusHPi0liLcTOGj3True?=
 =?us-ascii?Q?XBUTD77WXfxfpCVA3FbO3id9qlU/n/c+nKwSLSxzaSUj2P2eQqBEIgKk6DNT?=
 =?us-ascii?Q?wbVl1tTJolmqakjJu00YDXHti6h7putBmTzIylmbjtnVdSogXdsZzj+EaNsZ?=
 =?us-ascii?Q?VOjN49acKPwE+Qp1YCFC5usvZNE2Q7RT3T+V+44BGaiGEl1avdY6q3n7tVP1?=
 =?us-ascii?Q?geVX9n0t8qnpfysnuVTfphdUHR02f9H8XfoUeqnrO38qnUiXYlc8DIMwlnLl?=
 =?us-ascii?Q?6a/aKpAUL3/40seP0ei6jn9wiJvis/EV6EoANdFG84FVVk86QrOy+L0hJ4tp?=
 =?us-ascii?Q?J0GJ+dowOqqQkMHdbPB5R8tdKl9LErAgS/IDV2hgIYWULNP0r352HaW9MGSF?=
 =?us-ascii?Q?8mu9DApNkivliTHCU5rV2DIQrhjt9Tfg9Iow8TuUgCo+UBYxGVAyzku67Lsa?=
 =?us-ascii?Q?4w/j0o7QJRoiaxaJonkWxFLVt8zICG99na7gMrqVjkQVNLtSe2YV9A/VBAiH?=
 =?us-ascii?Q?5kT4T5AX6dJlNPe2QBTnU7Z8Wgo+sCz0CJSSNwUKPp+iiVrsLAoLdaOmpkL2?=
 =?us-ascii?Q?LLrghLWByXZFRabgi2aGNqeisfMWvieNtDkFNYkK/MSRwaHH3z37W3PRY6x9?=
 =?us-ascii?Q?ZObj3k4pyLXsPVzMCvYQRR1Kta+LBo3HfY7N+m1IcIdlcgDdXYC1gsLt6KQN?=
 =?us-ascii?Q?lAOUVWAyaHwYl0pa5FSBqfHPw372T27ylHLDwQGbdh7HysUx7lGuLFEm3uhT?=
 =?us-ascii?Q?kKzr9O+2E1QPSbHqmp9kOG2JugdWqVKvRyFofJbsj+te9XomLfVan235GSHX?=
 =?us-ascii?Q?mTDmv1mRu5cikGXR+3XK92LxxSfOh4YKina7EbEvYgiLOqFUXrrL1mk5mVHY?=
 =?us-ascii?Q?kESlXYnfAIptM2gPq5ptE1RB7MIescJHZaQDHmuf/1QjLu3eBnqt5naGdbh4?=
 =?us-ascii?Q?jj5Yt3EHOJITaiKG5+1xV/rMirMQX3sV3ciA7WeD0h0T1IqCkOp8sdtIGlrs?=
 =?us-ascii?Q?3FNiqP2avRBftyJjQdMEZvDz+klbWnkPWavPcdTCgmtO8XpVZhhguz1KFy9G?=
 =?us-ascii?Q?4hgfZF6eBkYLHX2ZoEbz+dYu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2646266a-5fc2-4a17-46b4-08d991f10fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 04:37:58.8196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yu6Eqw9GzK68JGpBcZkJPD/qFji+4bFyO+hjyGK7QmJj8Lfc81sBQfNZaCQkn0lixECl4dzIWPcByEqjD1f1zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1045
X-Proofpoint-GUID: 3x-C8Q9Suwz2qs21wel2nZ7gFHpPMKFo
X-Proofpoint-ORIG-GUID: 3x-C8Q9Suwz2qs21wel2nZ7gFHpPMKFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_01,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>
>As DDR perf event counters are not per core, so they should be accessed on=
ly
>by one core at a time. Select new core when previously owning core is goin=
g
>offline.
>
>Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>---

Reviewed-by: Bhaskara Budiredla <bbudiredla@marvell.com>
