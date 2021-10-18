Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251BE430EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhJREkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:40:22 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62752 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229470AbhJREkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:40:20 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19I3oR6N025462;
        Sun, 17 Oct 2021 21:38:05 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bs1bug41x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 21:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGfcowBxp/nAcGlYtA5k/slcGAtXbU1MXknjGY8QVwBLphfMzDb1qP/u88Qgec8EHIXX4kUnXfdo6GY79n6gmFK9BmGhQU+Cq/NTHoVux2vlb7wlJR5QE0CXcQwIyvPOrt12x/6jZKSN51WNt9kfaZ36AYk/aJ+Bj32INuP4GZV6WJhJzpPmulFIo2HRumwbr1huBFU2iuRdn7J44fAjIpCE89Q68SCf0W+5qM65Bo1mvgTwbuYcHYP2onDo0h+JIaZwJEjekwnlCtug+x9hEu29qH3wyBbegtKd2RhEAeL8QB03y86Dbr6fAAz6rzRFa23Xcw7OK5IeW0ku6Bln8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liATlIuCsj3T1ymDAsFXCt35lH1lZv1AZoQtwGkNw6Y=;
 b=D7S0NR6AV1Xzqq1T4K9DQc614ixe1vJMY4VxxJsSpoLhwHRl1r1FNdOPrbzkgu1yXB7PCJk0SOmbT8XFjtucieJvEIZ5B2lNsQqqtbz1k34BABO6YDY6a+ZAKq1ae1TfrTN1rwhnABoqnVG0Kuh6+dDA+ZqiZlIxXPH8g3lOLUrmUY6yVJhlUvfl11KcWE1rd9sqbU39fn0yzl5uWpjekHfp66DjFw3FcN6PC5iFkfZ2w+VYdaCxKBZOUvuH3KNq4hvUaN46zx/dOe/8P3Zt8IjLAAkwQTlb2+U5kLKoSUjf7ayNH58wEOxX9yS231VjOwdUATGkS7hb+OtgsT1Yvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liATlIuCsj3T1ymDAsFXCt35lH1lZv1AZoQtwGkNw6Y=;
 b=dXkV8NxWQQZuQcxD+2v3nzy7d8uWb3wnuCxDsfb7iZPa3EIqAend6DGDJgChs6nB0IFvWXVuE3YFGW4IPttSF//mf5kBfbOk7T3COStm8GpSGjFUhAlsjlTtiD0Ba9wzX+RzsPZxqq8ogsE2eprLkQAXHi5gKKZhTeE4qBkbsHA=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1045.namprd18.prod.outlook.com
 (2603:10b6:903:a6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 04:37:49 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 04:37:49 +0000
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
Subject: RE: [PATCH v5 3/4] perf/marvell: cn10k DDR perfmon event overflow
 handling
Thread-Topic: [PATCH v5 3/4] perf/marvell: cn10k DDR perfmon event overflow
 handling
Thread-Index: AQHXw9eLecb4O5tsLUWUa4k2XOclQavYK/DA
Date:   Mon, 18 Oct 2021 04:37:49 +0000
Message-ID: <CY4PR1801MB20700C2BF32D287679CEB52DDEBC9@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20211018042015.25151-1-bbhushan2@marvell.com>
 <20211018042015.25151-4-bbhushan2@marvell.com>
In-Reply-To: <20211018042015.25151-4-bbhushan2@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa2adf70-40c1-4167-b9b1-08d991f10a09
x-ms-traffictypediagnostic: CY4PR18MB1045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB1045BF389A53C5DD2C48FD3ADEBC9@CY4PR18MB1045.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3mwfH7XZ+Tijksta0NmQmTZTOL6yENWjgAQwKNaDMBw2DvZ92Wa+/1HyoX13zMzCWcW9l0KapwMvEDNLGsmVcUMENAX1tV1vSdit4UdCTZL9UoRj4jREFimkz1rscdCdttd01UYEcpKVecCmW3AAYI8Rty69/B0sRIfZUbcQaAdqI/aCKFKi7CmZFfVrUrYfWepjHKl63wUAsJSpFQPK0CIfzuToBstcwA1aYV3idycxI79HNTlCta29KaFzKHb/YB6Amq/oY7kOfByoqxvLcKNyTJsx70pmRy88RPRdSeD/CMqcIsQ8dRwryyscOrQkSFvu3iaxiYC2fXqEAChCKKYcmU6VMACdDacwS0tWlqjGnMEdSt4+xwkdW65UqrvdxpouHkYAMjwSEcd93WTE6dVZsFV6I7NEBAun9INZnJ3l5GsLiFBrRTZmOqyJlTEt4aOuTTWW6DtCZ/gr6Ix+J6iJiKFkNT94jJhXLzHpSyYUm6SXCtiz3a4XWIdBZyRIhl8tnwRAd7O4+1FrEt6r9DGgp0Z47FHmhkzUW4PXmG0BQ9/GGncYwOIMVOQ8KLt9g74Bg673domBxYWUJRUGXTvnVML/XKzVGFHJxRCL/4laEfAhArXgSgomLTJFseGxJM9nhj3MIXfJzM/u7cuMrI86dX2Twi5DXQQ3IDVcroWHbz4jb34/+8wzc7slJzqojJ+f/h/td9x0SWi0W/IEfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(110136005)(7696005)(38070700005)(38100700002)(8676002)(76116006)(64756008)(66446008)(2906002)(33656002)(316002)(107886003)(86362001)(66946007)(4744005)(6506007)(66556008)(122000001)(66476007)(186003)(55016002)(9686003)(4326008)(5660300002)(26005)(8936002)(508600001)(52536014)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iKoiBa9TESI/4zdvKKlm6btoBN7xZUonQGOLqGSPRuXCpVWSgFcVGPPGQ0TX?=
 =?us-ascii?Q?JHTHoGSxoXcSSWYHtG7RufJLChNrsH++YA64+X7ItRnUeTUVAmOW9kYLul0g?=
 =?us-ascii?Q?tkACbtnEBfDdrPnOq33x61VKqN9kmr8WFKA3vABDoru878wJ1R32GosRP/eL?=
 =?us-ascii?Q?nCqxrpXuVy/F8aEOSiVqXkzrHGFnMSibzkC7tRBRTsHsnIJEfsvUB2KEEU/9?=
 =?us-ascii?Q?vZgo/KNJZjmcFevNa0wOKZ+prHCdltKl0tACGxVWxD8u32SUJRQOupyGEYhZ?=
 =?us-ascii?Q?/SKmnikXrFGI52UPO6epE4nVwIA+K49UYrB5xdMPVJZafQG5RO4hoIT5pSGm?=
 =?us-ascii?Q?kjqvOWfZ8DSgGWzPs8XMZ1u2AwG7Lll3j1GIsf9HSOD0Ur0hMf/iNNQFXmKj?=
 =?us-ascii?Q?SMIbuNcDTOooRMXdNiUwS/ORW5tJV/xo7r31u2OWy4PvEvBc7FxbhV9/bXaH?=
 =?us-ascii?Q?R+tz5/H7sr//a7rSXy6ePndsH2DMAIQX89BCatDx/wF5wiZujJGHh7A93JN1?=
 =?us-ascii?Q?uc0C8NTQrqZEeHBTrpQXqJql4KYp/7qZ5Z7iHM2pEJzcYLZ9UYtjITDPt95b?=
 =?us-ascii?Q?01ch9d3OIJkq3DbNnCmPyuJs/Gc2JDFyk8VS4SdNtF4AtdSxiMDgcdatnc2M?=
 =?us-ascii?Q?gcWQwXg01aQymn48TphbZHUUOx1dFIG6ZKBCjQkT5DdBYjv93z4ilSUV+eS8?=
 =?us-ascii?Q?qWczlZ9ztao6ppMOEidMeP3gv/OGpO0sObBxYAeJ1w9YJnGxqqLLz67F2j61?=
 =?us-ascii?Q?/0VVXnL44om7Pq9BRl13VHGO3x7/OwSt6oIr3bu5Ar8dfe4gXNxDw+emdiBl?=
 =?us-ascii?Q?A31cXjEVnbnR70dVSl9s317JFGJT/i1SQwl5swXjMdTaOruRx7OCJv1iwi9R?=
 =?us-ascii?Q?/KxR0/7KKNNcGw8Ffz6M+z9AkRvTUnzP7lt0PAykMtkI4mivOarthEMt4kn8?=
 =?us-ascii?Q?cMskmsHSNpvgt0oBkFFXDej0JTXyqY+mail71EFVINJvNEirxQDVbgqvVzU9?=
 =?us-ascii?Q?JVTDNjg75bCmEJb3QNT3+oQFwmzVTXGb4eledGj0nFhKD6xT7UYlkc+xVgdX?=
 =?us-ascii?Q?JqlyPrpPnLe2WficiXjp26FNkrmoJ5XzBS7R8U7s4apTWnHMYj5cEha9axvg?=
 =?us-ascii?Q?ktf8h+ws9wW9J+4BE0pb5+g0AqI9/8khpuchqdQpE4l2umWQxuCpR8B0ABF9?=
 =?us-ascii?Q?C5BO4o0Ak5nrkoRFuOsgMKiqUwBUaTYJKvPkmnayrl9j8rsJthsLWKmvlyUC?=
 =?us-ascii?Q?e1ZBOU8uDaP9VVEJO4xSvSIDM73T2YAd9Wvf31rUnuWaGR/sVNCTp63N8ls1?=
 =?us-ascii?Q?Esw+oF0nP5oICXA909R88Xwr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2adf70-40c1-4167-b9b1-08d991f10a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 04:37:49.0621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y6CKxAWQXkho6ZSgnWaHoHjnF+meLzLgPLZh658rMyyCcGS4waes1lY5n7+EA7JFRmkq0TXKlTq/Ro9cI4NAHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1045
X-Proofpoint-GUID: U1DmX096JkSHhT3dsbwS4q1kovpcOZH3
X-Proofpoint-ORIG-GUID: U1DmX096JkSHhT3dsbwS4q1kovpcOZH3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_01,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Two fixed event counters starts counting from zero on overflow, so overflo=
w
>condition is when new count less than previous count. While eight
>programmable event counters freezes at maximum value. Also individual
>counter cannot be restarted, so need to restart all eight counters.
>
>Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
>---

Reviewed-by: Bhaskara Budiredla <bbudiredla@marvell.com>
