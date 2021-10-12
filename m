Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC82429DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhJLGbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:31:21 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:37934 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232690AbhJLGbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:31:19 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C07VVW030551;
        Mon, 11 Oct 2021 23:29:09 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-0016f401.pphosted.com with ESMTP id 3bmpv4u7q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Oct 2021 23:29:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mk8sqwfJCeZ64HnkWZ8qArwlgjx9aS26AoAP9owdutD/Wr2cye8+QllOTA2fdbStecuOhvuzLlKVypQ7UUmWugHo/ZVH3tJw1Yskogv/2Xh7n8X7P53ZU5dNw6FaaEpXGCTXthJ0pmKyg3PjdTNvS87tz9TvXlMtyvlbLKAS2Zhsky6qP9Z+bruDU28y1xs928YrTqFhn+rCMgSijTCQ3a5SJW9Hubzloqut4GcQbbDep6FFPpqIU/w9sQ1u7veTyQG0EWzk1T8oN1cdHJtqIbZbpq/bhKGP4tumldJY0YKuDlVSUiTKGPsC6bWvk7oJfox2Z0MY3au2Gxb0fKXzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YS5/yAgZ2AJ/TYDExRCWZxFWcJxKsROhKvlUgBIMkvo=;
 b=ke4hGM06RPeh/uOFzvyD8BCXdODRPOGP7fYVlCW8zQEfG97XIPKlYhdhP6goqUqjfzrz/r3LLdPuppVqYvuV89xvlGhHUw/9u7coSkCZAAcqvaamJ+j/7EmSohjk0J3SmQbElMub4nUAbDNQjz2JTjQbqpYSjpTxOhx//mdKbzmsGlYcO8x55Q9c1OMp+RyY/5iIIcn/vKBn4T9UYS/o5G4OSzygj6VH3O9wHvG6IRuIx0ZN0KlAwIxVKvk9hXgGKQiGnRvfSTkEu9qGTZR/GrrtJgbM0W31F30YWO9ttVvK0+IqWSEwMZmr5cVs+L7bIcv1rRL4Zu6c1SZ8lDWG8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YS5/yAgZ2AJ/TYDExRCWZxFWcJxKsROhKvlUgBIMkvo=;
 b=oj94Aj/6FpBySRhfhW167lMtvM7MZszHr/Lsk8eLYkAJEpzTtg3L1RFec7iAigidBI0A1s3IDRMCqNlxUZget92ubBQUfyKjkv/QSB4OgXrplIhJsssUpZ5QT3A96MvzWeFldrBoChXNRL3G8BPqFptX51HWUd7WaC34sv+lilA=
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 (2603:10b6:910:7e::28) by CY4PR18MB1045.namprd18.prod.outlook.com
 (2603:10b6:903:a6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Tue, 12 Oct
 2021 06:29:06 +0000
Received: from CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491]) by CY4PR1801MB2070.namprd18.prod.outlook.com
 ([fe80::9de0:2038:e0cd:e491%6]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 06:29:06 +0000
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     Will Deacon <will@kernel.org>,
        Bharat Bhushan <bbhushan2@marvell.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K LLC-TAD
 pmu driver
Thread-Topic: [EXT] Re: [PATCH v5 0/2] drivers: perf: Add Marvell CN10K
 LLC-TAD pmu driver
Thread-Index: AQHXpKmvLbIyd1MMTUy5i5BlP65Pnau8ahDwgArTNACABqrfAIABKBDA
Date:   Tue, 12 Oct 2021 06:29:06 +0000
Message-ID: <CY4PR1801MB207066A7007F06D63B753142DEB69@CY4PR1801MB2070.namprd18.prod.outlook.com>
References: <20210908120425.10084-1-bbudiredla@marvell.com>
 <CY4PR1801MB207038FD04A714BF15DA88A3DEAA9@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CY4PR1801MB2070E39832569F339D8F9439DEB19@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <20211011120842.GA4297@willie-the-truck>
In-Reply-To: <20211011120842.GA4297@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5dc3405-6b26-4385-c459-08d98d499795
x-ms-traffictypediagnostic: CY4PR18MB1045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR18MB1045272D328A8FD875796A84DEB69@CY4PR18MB1045.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hMDsYNR1r9WO0hjVpt4MM4bTUDihfyLkkQanP1bDRFaZQt3GycsJm93TKUAiJWsAhRooYyFnFemo5GfhIrSYbcmB2n9OGyakVtvs6KCKA1Vrdd62bJlgDrhgCqJfPKW7mfoxNDyCbJLoA1qVaPVqmOgwsypjaej35dKcK1tS7PxOPMNxilev197X/SJw8fqUbzuqPPrVH8ZxUL+7KzymbMQGE+zMRcxsQoGYuvn6ojArwXzxSeVhc9rEoiwdQiW0esNKtuWF88a6J0GAAwK0K0HfoZzmYVJJn5DScuSN5qdVkFH35kM+mjU0rz6S67E67KRDynY791hEApo0fo9OLRF9SVhR5HY3WXG2kJoniRmz+VnLdEqGasnjum/wGdgyonzRUGgi6wzXGtKRKQHHdjSZVFqE/Qlxp9jBv/eC3MJu6hjxw5T99ykwtBLlNI40jwHyYOsLaiz0b8MT3Whz6QO+JJ01IE9fJw6PJ4vBy9zJosD67C6Ouarbx/7USpJwm26V058YyyRw2qqwqBch2Q7XICLpBbekhOm8MOyMTC0BdvP8HTAigGbKbqoEtaqnM8CGS+s1GeVlTIjYDTZwuTz6WWFr2G6GmR8rYIril9XhXOCQKSQKiPV6VPJQakUQMWPXQ88TqOBAFe1+ZvcKWOeDIu3llz9y5TWzgx9Z90SMNRY0NQ/0En9TI+9QrK6xNpaUVBUieU/GiAibNVvwZlxABVOskTI+jA9Pr+1IUqRcLDGfIDRDjIwjFr3geN/0+DrM6mIrsBsG+1KrnLOuka4btExVtmjAgJnjhaP9dVg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1801MB2070.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(38100700002)(54906003)(316002)(55016002)(508600001)(52536014)(5660300002)(110136005)(33656002)(26005)(7696005)(6506007)(38070700005)(6636002)(4326008)(122000001)(9686003)(2906002)(66556008)(83380400001)(66446008)(64756008)(8936002)(66476007)(66946007)(71200400001)(186003)(76116006)(4744005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Du0tMMdB1sEJTcrix3x3Pc/5bughPgVqoPYa8v81t2x8Hv4RKGphYx6RpxGZ?=
 =?us-ascii?Q?JUc+P4R5ltJOvBpRkk9BhgmwzKPDDceinqQPBfmxqwsx/NajjRbxapPxjgRH?=
 =?us-ascii?Q?nd7znnOyNT+ZH6gBr/MsmyXBzOss1FhpKmzwtaQDix+5auei+jsS5StYCvU6?=
 =?us-ascii?Q?dGHi2G03k7aSiK8/cd/no69OZH3T79h2OdtipDfqMqxblgLbajXILYATNYyC?=
 =?us-ascii?Q?77Dg1D2vg5Z0hqMPsvx00SsMVWLhkF5K46FGE+9fJIDuUl+zUsEYPYr32eND?=
 =?us-ascii?Q?wM0Bca70NllLbrDiGrWHvsF6DYf9WLgoU4VXyXSQ16Q4KMdKzLbk/PRu6kNd?=
 =?us-ascii?Q?BI5C0JL1WtwLSudZZY5dlqH+Z1A/prG2VDCXmq054j87AWpKRZr5XRsFTqFn?=
 =?us-ascii?Q?vHfI1v0YcBPG8TjnQVDr5dKYhaGf3bGWmR8dTPH2Zs8c/u4Uh53qWgicqSSf?=
 =?us-ascii?Q?qs8OMIphJHK8FhGf99/GKsgtKb8FFVUgT9I1MLkwmrFv4eoxWmu1wI1SnWfA?=
 =?us-ascii?Q?mbQhR0CDhVUeNk9wtYIkmpNNUuBHFwDDqnQwijlxHltKWEtMspqekadSF2Vf?=
 =?us-ascii?Q?F8iTap87C/4hNrlq5gePnXwo4WDRsDHIxtBoMC8+fubmc/QavRNYtBA74nOu?=
 =?us-ascii?Q?lWVf1fhyV9sEskRgw/1Io2RgOMcQP4ugZmrDKrbSyTmaswtfQN1fBL+FUm9I?=
 =?us-ascii?Q?kDsuSKfJQxSdMj8+ESXVeUFqenaXtcyEMIYkO/hc6cuyjpZR6hAcnheWM9j6?=
 =?us-ascii?Q?pc0W9wU/HSUC4m/ZsuyIUxGaQywIglmhrAFpRDeNREqMBgfQecp5iDi3HsM0?=
 =?us-ascii?Q?hczDxzsfXJlbeDq4qK1suAm+trRKDgaUUPiuksveVp2n8O5OXslT++4OsY9C?=
 =?us-ascii?Q?jnTyfNjSX4PMW8oxa/ALRXEMlrVUhoOpKmFvBqVyyBbgH8yR7LhLx30rtVRb?=
 =?us-ascii?Q?cpmHSVasFBUHdUjJQzSC3Htn7py9DIpX1pzjKkdeo75EY+zetRjKSd4jeKCq?=
 =?us-ascii?Q?EaTMKoo1gDRlBdMQMVYUAeKPU+r3ukTmmOmTW7aDKToMmEFLjphGV9300CaI?=
 =?us-ascii?Q?7HNvlkOUlLsSaI7VKo/Lp0p/F17dABm3aTC/g0yZRgo3ZktMl/hH76bsc9q9?=
 =?us-ascii?Q?AX2HK4QFlPX7OD47mlJqUr8zn8c9KhchanmfOPn5nj6Hu49ZdasfEhhLnEXH?=
 =?us-ascii?Q?S4iGkjMAvT8Q8mEigRVsg0nLhS/X1G0t1r4mA5l+goKRIE9FXLwCddwwHa1Y?=
 =?us-ascii?Q?KSS1BYC/2ZJ3xxdMPLGDNak7KbLdOWumyX/uaL78pWiTpEpHBMlbDsav+x2A?=
 =?us-ascii?Q?zmR/DTPgQ6W/hVXz5csQZLwY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1801MB2070.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc3405-6b26-4385-c459-08d98d499795
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2021 06:29:06.3430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WAamn8nSGOHm3iLo6+fot8eJ60BR+l37UrpkIPcz5HxWFWshUhj3/U9ZONCqPXf6tKp8ULVcILUlt2Kwtx9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR18MB1045
X-Proofpoint-ORIG-GUID: GJ7KtLNOwUk_dm3VnLiEiMWUDkqPR6yS
X-Proofpoint-GUID: GJ7KtLNOwUk_dm3VnLiEiMWUDkqPR6yS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-12_01,2021-10-11_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]=20

>
>One big thing you could do to help would be to review this other PMU drive=
r
>from your colleague on the mailing list:
>
>https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
>3A__lore.kernel.org_r_20210920050823.10853-2D1-2Dbbhushan2-
>40marvell.com&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D9P_lSljSO7KnQ
>NkCGsgu9x_Op4mstSdqWN3Olr4bUv0&m=3DDJa6Fqm62SzYUy99uDA1B2uVYAl
>5AzDlLPZXJvnHkiw&s=3DHPRArNqyDRlnLY9DYZVXGjqNhlVOYTD-
>CKfcYulRJu0&e=3D
>
>and vice-versa.
>
>Will


Okay. We have already reviewed these patches internally.
Bharat, please see if you have any further findings.

Thanks,
Bhaskara=20
