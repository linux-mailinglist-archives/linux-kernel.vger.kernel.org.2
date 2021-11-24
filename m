Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5887D45B569
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbhKXHga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:36:30 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:26330 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241030AbhKXHg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:36:29 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AO2aeFM017190;
        Tue, 23 Nov 2021 23:33:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=bHjbo0aXp+dFrYtiSKM8elZFPtahqU+e9QF8YV3GtiE=;
 b=uFUzxtZtWAKT1QsUTtuofA6ZzZldfM8agaUqe08X2Pvzpwq3Ung3QMdKAE5VKXh/ZJr4
 nrcmEGUu3+6KJfjbX5QNRjvrS0RthsZO5Utf+NleXjCI3CsphQtiNbbvfFPJftQm62Z9
 17Wtmb5zz7z8ozb389fY3uduoehvevEFvNAtD3b+29JezAdHh455xr/i8uUm81SmgTRE
 bivazmjScV17lSWSTT7haCdwoqxnDe2UyWgGej1ZgWp7mybY5b3XxkbnJxkOKxRuLfW1
 7BMs9+IryTNjFGZz1LL4Cm7wukmEPSqVB5T8Vi3lIqX+NUBR1l9hu5uY46GjaWOf9pXt fg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3chcrp8nwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 23:33:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGd0TCG5TLhWaw+ZaNWhMHBR5lPH/vrnZLTgFSgIbZnvciWwmfDBvTzrPTUx/tUSr6mNJhFpGZKq8KwpT5/dmXPCBKFXI2l8NmJYrn0ATDeKkI+ihNabElWcCdaAj3Q/0NN5hLmgpAa3s4hylm8lzFIlyrRmWu7qdGB1x+izXyhSO39C2wVfJM5Tf+aMQCDCArrAs1epcY5kV2LnU2YZrsYuluHhiKZbeBd5nT9HZ47RnqQz6yF5jHPiMJLEe4clWrw/KIMQUZ8wfHopLqsG/FFkA0Bs2i28sVCnVLF9t8UFFVeskn9JRIMfPbBvCjViw7MJmgl0dryQUTWfZV0c5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHjbo0aXp+dFrYtiSKM8elZFPtahqU+e9QF8YV3GtiE=;
 b=UKPdn/s3J6kcyVFEerXLhMB1G0xmwj+ZK49mgLHRtK10wr9FQsV7/lS9rsbpt0bgF+BIiAf18hYloA1oFoD+um2A3vLTSgHJ7OJFt22IfivUj6xGQPWrcntVfrmlgqB6TJmIdpC+iMcI5/3WbRe1JMt4sY5BjuJGmx5KVziAfqQt4GaShnpbSlUFYKiagjZficnt2YN2fQnssMV8FJuqLoDd0QDLo1VbXdIVKxEsJBLJX4tV6Rd/neYjYeeNygL2evfCi9NwcR1Z3nlYVj25tjmteS6rOO9EyAz7htknK3fGEqrxEOt1mJHrrjoz/ZPU2fccLSCo2jwaHOlP73diqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHjbo0aXp+dFrYtiSKM8elZFPtahqU+e9QF8YV3GtiE=;
 b=yRlc9ILXage+yahCLmFBB/EN5CxZ/VVn5j7v47FenIPg0X4/C4Ee11Ebi3SAeTVmVcE6qQHm9blcYoD4RiHP+AWSS/j6Fe7sGuMQ989phBVL/MsWMVQTDe895Dq7BRmAKb0NxQhejfR+mGqMKFMrvd2gvDGH2AxYH9+Cpvi2SLc=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB7132.namprd07.prod.outlook.com (2603:10b6:5:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 07:33:07 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::a15c:c860:703d:3017]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::a15c:c860:703d:3017%7]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 07:33:07 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Milind Parab <mparab@cadence.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>
Subject: RE: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Thread-Topic: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
 multilink configuration
Thread-Index: AQHXx2bHmQutwPZ9l0Sv3BSHrxD/16wQu9eAgAG6aaA=
Date:   Wed, 24 Nov 2021 07:33:06 +0000
Message-ID: <DM6PR07MB6154FB5EB84B7BE063965619C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-14-sjakhade@cadence.com> <YZxyja2xEkpWvStR@matsya>
In-Reply-To: <YZxyja2xEkpWvStR@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jMmNjOGI5Ny00Y2Y4LTExZWMtODU4Yy1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcYzJjYzhiOTgtNGNmOC0xMWVjLTg1OGMtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIxODQ0NSIgdD0iMTMyODIyMTI3ODU2MTg1OTc0IiBoPSIwaWx3dS9wTXA1cit6b0U5YklRS2U1RFNaajg9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e9599de-48e3-463f-abee-08d9af1ca87b
x-ms-traffictypediagnostic: DM6PR07MB7132:
x-microsoft-antispam-prvs: <DM6PR07MB7132422A9C5FC3894F199150C5619@DM6PR07MB7132.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7NmrLiafg/lR36PdnlIvUP8wQmmaGGkKFckkc78BfoxuYLDVCYGozR/CcCLRkLI8CIKR/wuFaUwIbnPYBlf67RYfB+2P6CfXW9OX6Cx8DkTeUoqcx78/0osmnkau8dtOel7IQwRWtlQXo1KL0A691l4LTx5fimoMfMUeVK3qx+k5w9qDEc0M2OudKcoSjDJi2XCSgpdmsg7jWBQYy8+qiWv6AFVdbxHbgP7qAaYeckUzCZamPoGlg20JpiR4ZwweCiLR0It8Fm+LhqgHyYNhBtIbmW0WYo6EoQs+5JKeb7H4xFh2hP9KMvixcNRPN/qxsWmkJ7XlVB2Kfnep4TnJ3t37ka259t/rVe43GlrDnZjiJgr4xd6lvzeJhpTFYLNxwpKGX09xerv6Fd0iMWx3tA5pX5kVcxn4Z7aD/KW3+t9dw+NMreo0LjAkmoi2wcxEbtahUrhJe/A7oSkUHlqU4nLtzl576MNlX7YYd5LkY8LQ/0YxVVVvJmmsrGK7bnCKHqqkNvnajaAC1vQZkCwJ1oPMWKGV8zyMBt11FvSca/hwhTFKYcLL8SUeEE6KESPA4enD5JLXoZM219ITiOfVKCRgEXD9vHEUUpGvVpMaTU8Ml3lgvO04LdzavuTd6l8PVpmIOnNX2vQfmmpUbez2fOnVoIqm7Tzr4Zft+IdJ0eI71boBtbMhR0C3oa90asD1Ioa0+6hOGiMR4IgpjH9vK9SyTVsdMqmrpq8ot/WpXZ+ZYCsNaZKd0lN3DqWLrsv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(52536014)(2906002)(71200400001)(66446008)(66556008)(8936002)(186003)(55016003)(76116006)(4326008)(54906003)(86362001)(66476007)(64756008)(38070700005)(7696005)(5660300002)(26005)(6916009)(122000001)(38100700002)(33656002)(9686003)(83380400001)(508600001)(66946007)(53546011)(30864003)(8676002)(6506007)(316002)(19627235002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4Rm1/ejVPPGVlojJ6FmgTZHU5Alp6+9vFtNUip/l/EhuPdT8SQHsWtM7EiLy?=
 =?us-ascii?Q?kStnv1hWxLBXbegmS9S8InYFhgh3AWxYx2fXkplI8FMf1cbrK6D6TNCIJ+8c?=
 =?us-ascii?Q?8X2WcIsU03xg81KLI1XNkb54IsSrQ5KVIO8HWllX/hlCdvaz6IfZOdASEax9?=
 =?us-ascii?Q?ZAPk8Kmg1sWRENhLPvqdbdGjE9fypDjE/rIVak3adzYH8AMjx84VJob7ja77?=
 =?us-ascii?Q?neEHnidqjFVtdDof8YSdQHYqyu4Crr0w/YCp05OGHAq3b7rBO8y951BK5yOo?=
 =?us-ascii?Q?KJnB/u8Ft1+TaNgNUnfeoppbEpBplWHTVt5BABDocz3S0x0R+a5YE5sgka/I?=
 =?us-ascii?Q?CwSYRocMwoG3LQzR/BCgQkI115eYp3PnTCvqt0Zx2s5s5rV3gyr6vCVUfAiI?=
 =?us-ascii?Q?BhHSPDHkIkleFj+Q9sjGGFbr90uiK89KGZI2ylaZFfg1EgAW37RQ2JZj8SMn?=
 =?us-ascii?Q?rsCziGZe7DWdI55j8farvNx1bWd8CjAoRzgSUotAzKZ1W2K24AOr4wqmcJSa?=
 =?us-ascii?Q?J0vcjIoIloK7M/P6ssEbZuRHL5sV/ZlV/fmpXkJanZzWAn4eqVNRn/8mB4KH?=
 =?us-ascii?Q?AUszVC9mPc+WEeJQepOR9dr9rbOlmOHXcA3NAa7SwHhYoSsaPOpcC7NwvUXM?=
 =?us-ascii?Q?YxoLx0XsCyDTRek2YQSOv43l8SFJHTa/jvqqy7H7VcMg8IqHvEzzhYcTLAfk?=
 =?us-ascii?Q?C3wOqtoE5qE9IpaRiS+D4PY1Of42xwciZ2fXJpwPSe8CdJyQ6Fh+XdRPYjX0?=
 =?us-ascii?Q?WuyB9hR/PEoC+9OKQI8KbXzaRYKM0DZg2jKILy4BAMtX3vBjnT6KiuhrBV40?=
 =?us-ascii?Q?9GA/fJ2k5IoFATxXvp6jyatDUDmy8CWVwr77S7xhOKahfeCZ3kge0cIsYaiE?=
 =?us-ascii?Q?ZWz1DXyLrNQklBNHO2sAtcg60me330tEl4nDSRiq/4UB/htZKaXlFuKqYDax?=
 =?us-ascii?Q?QouAT4i2c5zU1ZjQ8QekQvW9BRYufIy9bkE/BMM3z3dpqZbV4Hfkxd2Qoi77?=
 =?us-ascii?Q?VI3i3lgCBddeVPVBJ+J8YQZnVl/gKnWUal9ejU20FggUCHzXIY/T2dRg51K9?=
 =?us-ascii?Q?PE94ksYest5CuLah0hYRldy7gmY0Kh80JScL1BYk5sQvMeAZT8n/qbEMrQD0?=
 =?us-ascii?Q?v/AWDugG+V/yqJ3MuGkzulY+YVo9vsS5gt4AEbv+Pmlgp5sw0QqQGMrzhlr8?=
 =?us-ascii?Q?Kql1Nc5NUPIU/RM740QnYXFBIaTh4mMgNQiwjAVT4KUBQYL7xAeQx5HLfgoV?=
 =?us-ascii?Q?JMbCFctxePZW3DkzjF5Txb5+0gtUu4Zos2lIhgaiiXaFkSICbgu/SZZhWbb3?=
 =?us-ascii?Q?7jr4qQXNq+T0OQx9pEgDiz67q5MLM5+dEbXxTQW0XsV2iadfvC/73zbKe27V?=
 =?us-ascii?Q?lNK1FWe2Luy1Fg+5Ejewa+dcdi8uBnMyKOKL05JE9o1IND7Lic0EZvZnG4mj?=
 =?us-ascii?Q?2w4p+BjeYAAxAi8BBxy9IPJKNOo4igADUfFC48iERaek3hXeaAzFRvLi7oXA?=
 =?us-ascii?Q?C+cUaHQEZKi5xddSnN5Dvb98vy59rTxUAxWRumfHkm9HabWwa78EANYZ7ULN?=
 =?us-ascii?Q?C2bj6FStLbi7F87uORyvVGh4J9T+Euz7i78yjYshtnG1G0ED/Gkvbq/vRa/Q?=
 =?us-ascii?Q?DkRRRY5YZL3xj8q4jozjhcx/5OUrUIW1Kqk7EmdizkXUCbpHnGmTRUan4AzA?=
 =?us-ascii?Q?92Dt8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9599de-48e3-463f-abee-08d9af1ca87b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 07:33:06.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDh7GNkVQysOCDWu+X/o5gcYQ9HJRL2DCnhLEGX30iJAhW5G94+xksCHhmhKPfti3dqLDEaHJ56sETq2whaZnpZyrmsEVepdQyHP5RZqzVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7132
X-Proofpoint-GUID: 9i7_ARHEyG7q6CyHWchCzqNcwQycL5WC
X-Proofpoint-ORIG-GUID: 9i7_ARHEyG7q6CyHWchCzqNcwQycL5WC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_02,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, November 23, 2021 10:18 AM
> To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de; linux-
> phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> govindraju@ti.com
> Subject: Re: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY
> multilink configuration
>=20
> EXTERNAL MAIL
>=20
>=20
> On 22-10-21, 19:02, Swapnil Jakhade wrote:
> > Add register sequences for PCIe + QSGMII PHY multilink configuration.
> >
> > Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> > Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
> > ---
> >  drivers/phy/cadence/phy-cadence-sierra.c | 377
> > ++++++++++++++++++++++-
> >  1 file changed, 376 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> > b/drivers/phy/cadence/phy-cadence-sierra.c
> > index a39be67424a1..0deb627845b1 100644
> > --- a/drivers/phy/cadence/phy-cadence-sierra.c
> > +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> > @@ -45,6 +45,9 @@
> >  #define SIERRA_CMN_REFRCV_PREG				0x98
> >  #define SIERRA_CMN_REFRCV1_PREG				0xB8
> >  #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
> > +#define SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG		0xCA
> > +#define SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG		0xD0
> > +#define SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG	0xE2
> >
> >  #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
> >  				((0x4000 << (block_offset)) + \
> > @@ -59,6 +62,9 @@
> >  #define SIERRA_PSM_A0IN_TMR_PREG			0x009
> >  #define SIERRA_PSM_A3IN_TMR_PREG			0x00C
> >  #define SIERRA_PSM_DIAG_PREG				0x015
> > +#define SIERRA_PSC_LN_A3_PREG				0x023
> > +#define SIERRA_PSC_LN_A4_PREG				0x024
> > +#define SIERRA_PSC_LN_IDLE_PREG				0x026
> >  #define SIERRA_PSC_TX_A0_PREG				0x028
> >  #define SIERRA_PSC_TX_A1_PREG				0x029
> >  #define SIERRA_PSC_TX_A2_PREG				0x02A
> > @@ -68,6 +74,7 @@
> >  #define SIERRA_PSC_RX_A2_PREG				0x032
> >  #define SIERRA_PSC_RX_A3_PREG				0x033
> >  #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
> > +#define SIERRA_PLLCTRL_GEN_A_PREG			0x03B
> >  #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
> >  #define SIERRA_PLLCTRL_CPGAIN_MODE_PREG			0x03F
> >  #define SIERRA_PLLCTRL_STATUS_PREG			0x044
> > @@ -150,6 +157,7 @@
> >  #define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
> >  #define SIERRA_CPICAL_PICNT_MODE1_PREG			0x174
> >  #define SIERRA_CPI_OUTBUF_RATESEL_PREG			0x17C
> > +#define SIERRA_CPI_RESBIAS_BIN_PREG			0x17E
> >  #define SIERRA_CPI_TRIM_PREG				0x17F
> >  #define SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG		0x183
> >  #define SIERRA_EPI_CTRL_PREG				0x187
> > @@ -272,7 +280,8 @@ static u32
> > cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] =3D {  enum
> cdns_sierra_phy_type {
> >  	TYPE_NONE,
> >  	TYPE_PCIE,
> > -	TYPE_USB
> > +	TYPE_USB,
> > +	TYPE_QSGMII
> >  };
> >
> >  enum cdns_sierra_ssc_mode {
> > @@ -807,6 +816,9 @@ static int cdns_sierra_get_optional(struct
> cdns_sierra_inst *inst,
> >  	case PHY_TYPE_USB3:
> >  		inst->phy_type =3D TYPE_USB;
> >  		break;
> > +	case PHY_TYPE_QSGMII:
> > +		inst->phy_type =3D TYPE_QSGMII;
> > +		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -1186,6 +1198,9 @@ static int
> cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
> >  					regmap_write(regmap,
> reg_pairs[j].off, reg_pairs[j].val);
> >  			}
> >  		}
> > +
> > +		if (phy_t1 =3D=3D TYPE_QSGMII)
> > +			reset_control_deassert(sp->phys[node].lnk_rst);
> >  	}
> >
> >  	/* Take the PHY out of reset */
> > @@ -1363,6 +1378,72 @@ static int cdns_sierra_phy_remove(struct
> platform_device *pdev)
> >  	return 0;
> >  }
> >
> > +/* QSGMII PHY PMA lane configuration */ static struct cdns_reg_pairs
> > +qsgmii_phy_pma_ln_regs[] =3D {
> > +	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
> > +};
> > +
> > +static struct cdns_sierra_vals qsgmii_phy_pma_ln_vals =3D {
> > +	.reg_pairs =3D qsgmii_phy_pma_ln_regs,
> > +	.num_regs =3D ARRAY_SIZE(qsgmii_phy_pma_ln_regs),
> > +};
> > +
> > +/* QSGMII refclk 100MHz, 20b, opt1, No BW cal, no ssc, PLL LC1 */
> > +static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_cmn_regs[]=
 =3D
> {
> > +	{0x2085, SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG},
> > +	{0x0000, SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG},
> > +	{0x0000, SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG}
> > +};
> > +
> > +static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_ln_regs[] =
=3D {
> > +	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
> > +	{0x0252, SIERRA_DET_STANDEC_E_PREG},
> > +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> > +	{0x0FFE, SIERRA_PSC_RX_A0_PREG},
> > +	{0x0011, SIERRA_PLLCTRL_SUBRATE_PREG},
> > +	{0x0001, SIERRA_PLLCTRL_GEN_A_PREG},
> > +	{0x5233, SIERRA_PLLCTRL_CPGAIN_MODE_PREG},
> > +	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
> > +	{0x0089, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> > +	{0x3C3C, SIERRA_CREQ_CCLKDET_MODE01_PREG},
> > +	{0x3222, SIERRA_CREQ_FSMCLK_SEL_PREG},
> > +	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
> > +	{0x8422, SIERRA_CTLELUT_CTRL_PREG},
> > +	{0x4111, SIERRA_DFE_ECMP_RATESEL_PREG},
> > +	{0x4111, SIERRA_DFE_SMP_RATESEL_PREG},
> > +	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
> > +	{0x9595, SIERRA_DEQ_VGATUNE_CTRL_PREG},
> > +	{0x0186, SIERRA_DEQ_GLUT0},
> > +	{0x0186, SIERRA_DEQ_GLUT1},
> > +	{0x0186, SIERRA_DEQ_GLUT2},
> > +	{0x0186, SIERRA_DEQ_GLUT3},
> > +	{0x0186, SIERRA_DEQ_GLUT4},
> > +	{0x0861, SIERRA_DEQ_ALUT0},
> > +	{0x07E0, SIERRA_DEQ_ALUT1},
> > +	{0x079E, SIERRA_DEQ_ALUT2},
> > +	{0x071D, SIERRA_DEQ_ALUT3},
> > +	{0x03F5, SIERRA_DEQ_DFETAP_CTRL_PREG},
> > +	{0x0C01, SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG},
> > +	{0x3C40, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> > +	{0x1C04, SIERRA_DEQ_TAU_CTRL2_PREG},
> > +	{0x0033, SIERRA_DEQ_PICTRL_PREG},
> > +	{0x0660, SIERRA_CPICAL_TMRVAL_MODE0_PREG},
> > +	{0x00D5, SIERRA_CPI_OUTBUF_RATESEL_PREG},
> > +	{0x0B6D, SIERRA_CPI_RESBIAS_BIN_PREG},
> > +	{0x0102, SIERRA_RXBUFFER_CTLECTRL_PREG},
> > +	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG} };
> > +
> > +static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_cmn_vals =3D {
> > +	.reg_pairs =3D qsgmii_100_no_ssc_plllc1_cmn_regs,
> > +	.num_regs =3D ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_cmn_regs),
> > +};
> > +
> > +static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_ln_vals =3D {
> > +	.reg_pairs =3D qsgmii_100_no_ssc_plllc1_ln_regs,
> > +	.num_regs =3D ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_ln_regs),
> > +};
> > +
> >  /* PCIE PHY PCS common configuration */  static struct cdns_reg_pairs
> > pcie_phy_pcs_cmn_regs[] =3D {
> >  	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
> > @@ -1373,6 +1454,233 @@ static struct cdns_sierra_vals
> pcie_phy_pcs_cmn_vals =3D {
> >  	.num_regs =3D ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
> >  };
> >
> > +/* refclk100MHz_32b_PCIe_cmn_pll_no_ssc, pcie_links_using_plllc,
> > +pipe_bw_3 */ static const struct cdns_reg_pairs
> pcie_100_no_ssc_plllc_cmn_regs[] =3D {
> > +	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> > +	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
> > +	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
> > +	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG}
> > +};
> > +
> > +/*
> > + * refclk100MHz_32b_PCIe_ln_no_ssc, multilink, using_plllc,
> > + * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz  */ static const
> > +struct cdns_reg_pairs ml_pcie_100_no_ssc_ln_regs[] =3D {
> > +	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
> > +	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
> > +	{0x0004, SIERRA_PSC_LN_A3_PREG},
> > +	{0x0004, SIERRA_PSC_LN_A4_PREG},
> > +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> > +	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
> > +	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
> > +	{0x8055, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
> > +	{0x80BB, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
> > +	{0x8351, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
> > +	{0x8349, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> > +	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
> > +	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
> > +	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
> > +	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
> > +	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
> > +	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
> > +	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
> > +	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
> > +	{0x0041, SIERRA_DEQ_GLUT0},
> > +	{0x0082, SIERRA_DEQ_GLUT1},
> > +	{0x00C3, SIERRA_DEQ_GLUT2},
> > +	{0x0145, SIERRA_DEQ_GLUT3},
> > +	{0x0186, SIERRA_DEQ_GLUT4},
> > +	{0x09E7, SIERRA_DEQ_ALUT0},
> > +	{0x09A6, SIERRA_DEQ_ALUT1},
> > +	{0x0965, SIERRA_DEQ_ALUT2},
> > +	{0x08E3, SIERRA_DEQ_ALUT3},
> > +	{0x00FA, SIERRA_DEQ_DFETAP0},
> > +	{0x00FA, SIERRA_DEQ_DFETAP1},
> > +	{0x00FA, SIERRA_DEQ_DFETAP2},
> > +	{0x00FA, SIERRA_DEQ_DFETAP3},
> > +	{0x00FA, SIERRA_DEQ_DFETAP4},
> > +	{0x000F, SIERRA_DEQ_PRECUR_PREG},
> > +	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
> > +	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
> > +	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> > +	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
> > +	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
> > +	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
> > +	{0x002B, SIERRA_CPI_TRIM_PREG},
> > +	{0x0003, SIERRA_EPI_CTRL_PREG},
> > +	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
> > +	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
> > +	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
> > +	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG} };
> > +
> > +static struct cdns_sierra_vals pcie_100_no_ssc_plllc_cmn_vals =3D {
> > +	.reg_pairs =3D pcie_100_no_ssc_plllc_cmn_regs,
> > +	.num_regs =3D ARRAY_SIZE(pcie_100_no_ssc_plllc_cmn_regs),
> > +};
> > +
> > +static struct cdns_sierra_vals ml_pcie_100_no_ssc_ln_vals =3D {
> > +	.reg_pairs =3D ml_pcie_100_no_ssc_ln_regs,
> > +	.num_regs =3D ARRAY_SIZE(ml_pcie_100_no_ssc_ln_regs),
> > +};
> > +
> > +/* refclk100MHz_32b_PCIe_cmn_pll_int_ssc, pcie_links_using_plllc,
> > +pipe_bw_3 */ static const struct cdns_reg_pairs
> pcie_100_int_ssc_plllc_cmn_regs[] =3D {
> > +	{0x000E, SIERRA_CMN_PLLLC_MODE_PREG},
> > +	{0x4006, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> > +	{0x4006, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
> > +	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
> > +	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
> > +	{0x0581, SIERRA_CMN_PLLLC_DSMCORR_PREG},
> > +	{0x7F80, SIERRA_CMN_PLLLC_SS_PREG},
> > +	{0x0041, SIERRA_CMN_PLLLC_SS_AMP_STEP_SIZE_PREG},
> > +	{0x0464, SIERRA_CMN_PLLLC_SSTWOPT_PREG},
> > +	{0x0D0D, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG},
> > +	{0x0060, SIERRA_CMN_PLLLC_LOCK_DELAY_CTRL_PREG}
> > +};
> > +
> > +/*
> > + * refclk100MHz_32b_PCIe_ln_int_ssc, multilink, using_plllc,
> > + * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz  */ static const
> > +struct cdns_reg_pairs ml_pcie_100_int_ssc_ln_regs[] =3D {
> > +	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
> > +	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
> > +	{0x0004, SIERRA_PSC_LN_A3_PREG},
> > +	{0x0004, SIERRA_PSC_LN_A4_PREG},
> > +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> > +	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
> > +	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
> > +	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
> > +	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
> > +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
> > +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
> > +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> > +	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
> > +	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
> > +	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
> > +	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
> > +	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
> > +	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
> > +	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
> > +	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
> > +	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
> > +	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
> > +	{0x0041, SIERRA_DEQ_GLUT0},
> > +	{0x0082, SIERRA_DEQ_GLUT1},
> > +	{0x00C3, SIERRA_DEQ_GLUT2},
> > +	{0x0145, SIERRA_DEQ_GLUT3},
> > +	{0x0186, SIERRA_DEQ_GLUT4},
> > +	{0x09E7, SIERRA_DEQ_ALUT0},
> > +	{0x09A6, SIERRA_DEQ_ALUT1},
> > +	{0x0965, SIERRA_DEQ_ALUT2},
> > +	{0x08E3, SIERRA_DEQ_ALUT3},
> > +	{0x00FA, SIERRA_DEQ_DFETAP0},
> > +	{0x00FA, SIERRA_DEQ_DFETAP1},
> > +	{0x00FA, SIERRA_DEQ_DFETAP2},
> > +	{0x00FA, SIERRA_DEQ_DFETAP3},
> > +	{0x00FA, SIERRA_DEQ_DFETAP4},
> > +	{0x000F, SIERRA_DEQ_PRECUR_PREG},
> > +	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
> > +	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
> > +	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> > +	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
> > +	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
> > +	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
> > +	{0x002B, SIERRA_CPI_TRIM_PREG},
> > +	{0x0003, SIERRA_EPI_CTRL_PREG},
> > +	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
> > +	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
> > +	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
> > +	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG} };
> > +
> > +static struct cdns_sierra_vals pcie_100_int_ssc_plllc_cmn_vals =3D {
> > +	.reg_pairs =3D pcie_100_int_ssc_plllc_cmn_regs,
> > +	.num_regs =3D ARRAY_SIZE(pcie_100_int_ssc_plllc_cmn_regs),
> > +};
> > +
> > +static struct cdns_sierra_vals ml_pcie_100_int_ssc_ln_vals =3D {
> > +	.reg_pairs =3D ml_pcie_100_int_ssc_ln_regs,
> > +	.num_regs =3D ARRAY_SIZE(ml_pcie_100_int_ssc_ln_regs),
> > +};
> > +
> > +/* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc, pcie_links_using_plllc,
> > +pipe_bw_3 */ static const struct cdns_reg_pairs
> pcie_100_ext_ssc_plllc_cmn_regs[] =3D {
> > +	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> > +	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
> > +	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
> > +	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
> > +	{0x1B1B, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG}
> > +};
> > +
> > +/*
> > + * refclk100MHz_32b_PCIe_ln_ext_ssc, multilink, using_plllc,
> > + * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz  */ static const
> > +struct cdns_reg_pairs ml_pcie_100_ext_ssc_ln_regs[] =3D {
> > +	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
> > +	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
> > +	{0x0004, SIERRA_PSC_LN_A3_PREG},
> > +	{0x0004, SIERRA_PSC_LN_A4_PREG},
> > +	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
> > +	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
> > +	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
> > +	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
> > +	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
> > +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
> > +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
> > +	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
> > +	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
> > +	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
> > +	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
> > +	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
> > +	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
> > +	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
> > +	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
> > +	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
> > +	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
> > +	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
> > +	{0x0041, SIERRA_DEQ_GLUT0},
> > +	{0x0082, SIERRA_DEQ_GLUT1},
> > +	{0x00C3, SIERRA_DEQ_GLUT2},
> > +	{0x0145, SIERRA_DEQ_GLUT3},
> > +	{0x0186, SIERRA_DEQ_GLUT4},
> > +	{0x09E7, SIERRA_DEQ_ALUT0},
> > +	{0x09A6, SIERRA_DEQ_ALUT1},
> > +	{0x0965, SIERRA_DEQ_ALUT2},
> > +	{0x08E3, SIERRA_DEQ_ALUT3},
> > +	{0x00FA, SIERRA_DEQ_DFETAP0},
> > +	{0x00FA, SIERRA_DEQ_DFETAP1},
> > +	{0x00FA, SIERRA_DEQ_DFETAP2},
> > +	{0x00FA, SIERRA_DEQ_DFETAP3},
> > +	{0x00FA, SIERRA_DEQ_DFETAP4},
> > +	{0x000F, SIERRA_DEQ_PRECUR_PREG},
> > +	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
> > +	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
> > +	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
> > +	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
> > +	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
> > +	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
> > +	{0x002B, SIERRA_CPI_TRIM_PREG},
> > +	{0x0003, SIERRA_EPI_CTRL_PREG},
> > +	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
> > +	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
> > +	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
> > +	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG} };
> > +
> > +static struct cdns_sierra_vals pcie_100_ext_ssc_plllc_cmn_vals =3D {
> > +	.reg_pairs =3D pcie_100_ext_ssc_plllc_cmn_regs,
> > +	.num_regs =3D ARRAY_SIZE(pcie_100_ext_ssc_plllc_cmn_regs),
> > +};
> > +
> > +static struct cdns_sierra_vals ml_pcie_100_ext_ssc_ln_vals =3D {
> > +	.reg_pairs =3D ml_pcie_100_ext_ssc_ln_regs,
> > +	.num_regs =3D ARRAY_SIZE(ml_pcie_100_ext_ssc_ln_regs),
> > +};
> > +
> >  /* refclk100MHz_32b_PCIe_cmn_pll_no_ssc */  static const struct
> > cdns_reg_pairs cdns_pcie_cmn_regs_no_ssc[] =3D {
> >  	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> > @@ -1710,6 +2018,11 @@ static const struct cdns_sierra_data
> cdns_map_sierra =3D {
> >  				[EXTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> >  				[INTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> >  			},
> > +			[TYPE_QSGMII] =3D {
> > +				[NO_SSC] =3D &pcie_phy_pcs_cmn_vals,
> > +				[EXTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> > +				[INTERNAL_SSC] =3D &pcie_phy_pcs_cmn_vals,
> > +			},
> >  		},
> >  	},
> >  	.pma_cmn_vals =3D {
> > @@ -1719,12 +2032,24 @@ static const struct cdns_sierra_data
> cdns_map_sierra =3D {
> >  				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_cmn_vals,
> >  				[INTERNAL_SSC] =3D
> &pcie_100_int_ssc_cmn_vals,
> >  			},
> > +			[TYPE_QSGMII] =3D {
>=20
> so this is pcie->qsgmii ->ssc/external/internal ... ok
>=20
> > +				[NO_SSC] =3D
> &pcie_100_no_ssc_plllc_cmn_vals,
> > +				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_plllc_cmn_vals,
> > +				[INTERNAL_SSC] =3D
> &pcie_100_int_ssc_plllc_cmn_vals,
> > +			},
> >  		},
> >  		[TYPE_USB] =3D {
> >  			[TYPE_NONE] =3D {
> >  				[EXTERNAL_SSC] =3D
> &usb_100_ext_ssc_cmn_vals,
> >  			},
> >  		},
> > +		[TYPE_QSGMII] =3D {
> > +			[TYPE_PCIE] =3D {
>=20
> now it is reverse! qsgmii -> pcie -> ... why?
>=20
> what is meant by pcie->qsgmii and qsgmii-> pcie?
>=20

Multi-protocol configuration is done in 2 phases, each for one protocol.
e.g. for PCIe + QSGMII case,
[TYPE_PCIE][TYPE_QSGMII] will configure common and lane registers for PCIe =
and
[TYPE_QSGMII][TYPE_PCIE] will configure common and lane registers for QSGMI=
I.

Thanks & regards,
Swapnil

> --
> ~Vinod
