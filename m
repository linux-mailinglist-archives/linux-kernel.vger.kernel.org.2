Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE5452CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhKPI3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:29:45 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:23762 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232040AbhKPI3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:29:39 -0500
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7oeR3010396;
        Tue, 16 Nov 2021 08:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=e+Gl7LnkaVoCX0mKXAmiCeeTMp+qTaHJR6GxbFqRrJA=;
 b=krnRMIZEfiphs7zOjeB4c4kjBEknqD6ZC+BA7wEkrFPVgdszssb9kLKpF2D8xIrvfj2Y
 hKwwM4iv0U2HhAWvmCH8pIKf5RTF85KFfXlpNVjxvoI2e0cUqp6/u66Aghg6+iJqP3tu
 8ZXMhFCNz5d2Zetypdg33sCwbxZ0xZrC9END58SjNSL0npfdwqUkiUv2W0rxR1Bh+ie0
 MVuRT1suQZbeN8xBKokPf8snJ2eaCwTc9Rk0g1JV7M1r0zTl6sahB5QRQENBMocmUe6b
 VpQDS/X7hdQ0+OyYNoYFFZa+ezyShS15n1HeRBQDJ/54JXvpvH5o8VzcoszLhnokbiNT 7Q== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cbfy314ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 08:26:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdP9qmstoAKOKqE6LSO5JLNIsZyY6oftJYbqdwoUPG2BdgHhhur1vyB1oGbDhw3wWqXWpHLyQs+JmODDP2vtAPXhadxe8EmT2hF4zNtG5mbN9EWqqC1WhAuvqhW5nYFhlEJSS389Q0C7yuYpaR1G9oGhcmsheChn0sDm29aZBjqbBl5X3K0JQRyCaekqpKcdrllPpx4xcwLAnuzJHhj/OQjzteO3cFQVMkONQzXKK0YykMHdRGG/8S39rW8wK2XS1Gt11sUy2eTsQkafiOuG9GeL5NWXukHLaXY9vael9jkTpjG7Um5Tw9CmgV87yhGVQjMvIaULe944UlKWfjDndg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+Gl7LnkaVoCX0mKXAmiCeeTMp+qTaHJR6GxbFqRrJA=;
 b=A8yzyn+Rg3UbJGlVMf36iwA8R/z58EVYBE3/ZpDr7Xvyj98BQF7G9hbp4OvyhQJaN0iA1yCuTMkrVkN+tz8Na7JxXpzoteiUuDXRNjo4NpbXMC9b6qYUgGqh4cvBxj2PrG8ZGbxULIgkQXr+UiiMRv/d3lIuqGMOSWHLm4ExqSV9NI7RRhwAzdFMJqXbuFvIPAqeZnYeCkoXO29XsWC9S4xCA+/ix3DT9jCRcVlrjSciWcg5fw5bPaXw+OpmscsIOKAjOVibpfCyQUnDFlBQv/j5gSRqSZFZSLQqrGZ2kuwVxh+xTYpm2P7p+sjbttTPA6XDOjVX32gIprZNIPJ2yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5160.namprd11.prod.outlook.com (2603:10b6:510:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 08:26:31 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 08:26:31 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
 stratix10 platform
Thread-Topic: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
 stratix10 platform
Thread-Index: AQHX2dMxQI9mmdfJzUuSR61j2fUwhKwF01tQ
Date:   Tue, 16 Nov 2021 08:26:31 +0000
Message-ID: <PH0PR11MB5191DA68E99D04B9FF4574FBF1999@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20211115034455.19240-1-Meng.Li@windriver.com>
In-Reply-To: <20211115034455.19240-1-Meng.Li@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8630993f-8177-4496-9f93-08d9a8dacb5b
x-ms-traffictypediagnostic: PH0PR11MB5160:
x-microsoft-antispam-prvs: <PH0PR11MB516088DDD10AED52E0861DC4F1999@PH0PR11MB5160.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yuke+e0maVS77mRIDS6iMBDAhVV0TCRx1/c4o5kT9SoBtoqr+9aNx10bJ+70PISAjB1FY7nYZyrQIayl+4pqBUf6c2JTwN/0JF2Ft1Om7484oz/dAXHvCPA83DVwAEp3qvTCj6WA/R8joot21HRJHOaMeiKJAROC55y+OkGoejH7Vs9MoLm9noEoKwXdL+YYysUcena8gip2FdWd5Wp5fsVkAIQwLCDHQ+Fe/eiyE6jJyBvHKEuguJhGatp+ujoVpXOxCI5p6/fFgft4/gIuJPvx1d8f7QHZK3h1jcGa+VElkfgdMHtRc3OuemyVo1zRjG2Z4xI+gc6VZ5xJdAlAoNOWMaTCtQH2tcDTuWSFrVQnBw4rN0IM7uXNLObn4mx8eF8G5WyK6oe58wLt1NbU1CWB62S8264rWOBMf8Hm6P/lLw5UuRACSUgTr5HH/DbcyUsaXOrRIbMwjulZ3foTbEO65E4Uq3v6j71yk5T/EMvQSnsKMmpvl0EXqGDYWJgUwDuGgc1pDSUrR6aKoQBXqixN5rOgYotq5BX6xI99mo4h7hDBvRSIkTwOTDkHNDQ3eHqLbh+Bcq7SdrMK8HrNMs5k9CkyqvqRYUDEDGSO+V+j07uBkNWZNA76Sq3zHGYH6T9KsBAL6CJ0EFSRjp0T9reh+sEH5RshkB1LKW7zTg96l6vDzBEnW8BEuKNCiSRZq3qR86eaeBPVGuW4yXusOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(110136005)(6506007)(53546011)(86362001)(316002)(33656002)(66476007)(2906002)(83380400001)(9686003)(38100700002)(4326008)(66446008)(66946007)(64756008)(122000001)(76116006)(66556008)(8676002)(8936002)(26005)(508600001)(38070700005)(55016002)(186003)(7696005)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YPpwtkObas3UY7btCdJATAZVxaBNKmwtUmVtxG6hZOi+O6t+1YVLec5LUl7F?=
 =?us-ascii?Q?gFKM4Fx6W7a3SI2BhZBTpJIQn1GUCvicw4lLRNi9UnPUyyBaiRUNrqMKfQDo?=
 =?us-ascii?Q?xV4VSGi2iHPFNsM17ffc70Dv3MwFFfumBe40JUJUNRp2uxK2xp0dfDz3ApzV?=
 =?us-ascii?Q?yCXexgg+lhdm9Sgi7SeSCGLTfWgL/xUh1BrxwB+29M+Ir0rRITbskwmncLk5?=
 =?us-ascii?Q?d0mxoYNuXjwAoChrGiTAgTviPeWR5fwcLohp0J+pM9XykfV54cT+GHI52+bx?=
 =?us-ascii?Q?BrC3J+fWABjzWSPmMQrieyEyfhkzZHlz+OgUxhFvvQDAh/OU2cEA7zIYFFty?=
 =?us-ascii?Q?wjOXmbD724XvmX+9RnxyvS+bBLrc2a9paUef6SbToPoQBP182b7Ub9fIWZ5N?=
 =?us-ascii?Q?YRpQWwW6bC/1d/fnN2o+Phi71gbpFaUdlCB+Q9xXmA7lNUhN4a8Kx1I7+9kh?=
 =?us-ascii?Q?6hQPiHpAlvRhsUfajMgaKWqPL4LRxTJyk/CyFqwouF1pPTk+En0LkhbC4d7I?=
 =?us-ascii?Q?0wJ83SzV7ZVErZ7JKxiVnNdIG3mJBaB8ktbiLmFC2lLddEVPeWLNOvoEo2FC?=
 =?us-ascii?Q?xilTKKOgMehyHVWkj9YHI9VKxsIEsYy8dkRjQqw0B1vzlRm+gy0fRfolZcSF?=
 =?us-ascii?Q?pfnOFoT4lK1df7o7EgxTLs6BrbzTKOQHq+FFgzv2wVOOg/6JDJUn5a/0YJNl?=
 =?us-ascii?Q?38LG9NrugBoXJ2G3FWZ0NszKfAF0TMtzi3bsLS1DtUEpR4SXCckAzzHDheMX?=
 =?us-ascii?Q?4MNshgOUsfSJSoGMqFvOY5qedHF1dhJ6Y5lOeorkV3NaIkCBpmWXpKM/fDQz?=
 =?us-ascii?Q?G1twVWixPNpIy1gtAPJPnnHCkhQLMQFqREue5eqGK218PYqoqVBEqdSxi2I0?=
 =?us-ascii?Q?5wOsfta2OvXi0DLN6FqWH3HiIKar/SNDez5BGAcT9N4CKBZ2aHjx5WtIxW+H?=
 =?us-ascii?Q?ejQ3vZI7Zy1CAXXgzy7cyWqMgF7Q9NoMbMKWTKNkSyrBYPcNwOrPGQ7Ca/Lj?=
 =?us-ascii?Q?Y1p1j01P+qCU/2MRw9sNsUBXQg5arc0JgvkydAtd5wwiYmxAE8WCHwIdeDBN?=
 =?us-ascii?Q?yxnbXg7UFBpcRe+gTm/6B58x1X0fWPBcqzFdYuNA04y/hraq/L+0PVLTs2XS?=
 =?us-ascii?Q?9vXyAM1okJ6UMj5YFI+RGpIRYUZzT1AguBk8X1Oc/Ak0ma3WKl/o8UbPLThl?=
 =?us-ascii?Q?Mpic7xh4UwhGLM06EPoBJmcoNEUgaWpdfIZ1x4jduhsP76hHYfL1rGNv5UHv?=
 =?us-ascii?Q?3pM67A3taduWcAyh9nOPMHBkYPzXCYuxsriOOSU2uvBnWm5FhgP/oVn6wD+U?=
 =?us-ascii?Q?nwjCoWP4m8Gr6v3MCAPQ0JktICtQq4T7e1urQELK4IQ9EzKiNSmKlAXxreqF?=
 =?us-ascii?Q?LGAj9lvdpOeD2NjIz4fK9yvjOhRFtkboa55RMhOmgJXq3ELDi7fHysCCLPhe?=
 =?us-ascii?Q?9uhwhOAgI5ZZLvoF2DiM3Y3yo6igrIdnxcxXyojH2kep08rhhEvktj733MSQ?=
 =?us-ascii?Q?fscQs9fzmtrCnsoSOoSx9bEQuf5YaWm9ysKXvA8wHDtKiyRkcNRmwUqTEstF?=
 =?us-ascii?Q?TXgMILWazY1j24k+sc4zK2InzPz25AHjVSwQrmuvDxNOMTQTtjnbbo4XsxQB?=
 =?us-ascii?Q?1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8630993f-8177-4496-9f93-08d9a8dacb5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 08:26:31.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d2GXN+flVhGVjeX6p3DqVuVqfK4T+9Zz0dUt0FVRNqUdLFaRsXY/sK1D0TUxH+MsOljK9jNSyrqMDHuTYkbAYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5160
X-Proofpoint-ORIG-GUID: Ai8epYATDn4LzC6pv0gMvrBopLEa1tPO
X-Proofpoint-GUID: Ai8epYATDn4LzC6pv0gMvrBopLEa1tPO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_16,2021-11-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111160043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I did some improvement for this patch and will send v2 RR.

Thanks,
Limeng

> -----Original Message-----
> From: Li, Meng <Meng.Li@windriver.com>
> Sent: Monday, November 15, 2021 11:45 AM
> To: thor.thayer@linux.intel.com; lee.jones@linaro.org; arnd@arndb.de
> Cc: linux-kernel@vger.kernel.org; Li, Meng <Meng.Li@windriver.com>
> Subject: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
> stratix10 platform
>=20
> When booting up preempt rt kernel on stratix10 platform, there is below
> calltrace:
> BUG: sleeping function called from invalid context at
> kernel/locking/rtmutex.c:969
> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper=
/0
> Preemption disabled at:
> [<ffff8000100b25b0>] __setup_irq+0xe0/0x730
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.78-rt54-yocto-preempt-rt
> #1 Hardware name: SoCFPGA Stratix 10 SoCDK (DT) Call trace:
> ......
>  ___might_sleep+0x144/0x180
>  rt_spin_lock+0x34/0x9c
>  regmap_lock_spinlock+0x24/0x40
>  regmap_write+0x48/0x84
>  a10_eccmgr_irq_unmask+0x34/0x40
>  ......
>  altr_edac_a10_probe+0x16c/0x2b0
>  platform_drv_probe+0x60/0xb4
>  ......
>  ret_from_fork+0x10/0x38
>=20
> Because regmap_write is invoked under preemption disabled status, and
> might trigger sleep. So, enable raw spinlock feature forcibly.
>=20
> Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/mfd/altera-sysmgr.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c in=
dex
> 591b300d9095..8aad5bbb13b3 100644
> --- a/drivers/mfd/altera-sysmgr.c
> +++ b/drivers/mfd/altera-sysmgr.c
> @@ -83,6 +83,9 @@ static struct regmap_config altr_sysmgr_regmap_cfg =3D =
{
>  	.fast_io =3D true,
>  	.use_single_read =3D true,
>  	.use_single_write =3D true,
> +#ifdef CONFIG_PREEMPT_RT
> +	.use_raw_spinlock =3D true,
> +#endif
>  };
>=20
>  /**
> --
> 2.17.1

