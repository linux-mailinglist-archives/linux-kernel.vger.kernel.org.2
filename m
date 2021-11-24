Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5F45B565
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241093AbhKXHf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:35:59 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:63110 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241030AbhKXHf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:35:57 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AO2aJGq017039;
        Tue, 23 Nov 2021 23:32:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=TXmADHCjJc/17cES+t4DdzKyqP6mY/YCQLjK3FfbgmE=;
 b=tNfeQrcVFE684dik12gZA7FWfG+DbjPRvwcdW2hXxIzzmzLFFKATHxEVb/LsdNBQ5nG3
 hWhn5PmDO1f6Kplk0BdH6zOKaw+OsE9tOp3/7qD+5l0m9ctaX6iDzq1mV0hJzzVAJQ1W
 q+lj8u9mnb2C3rT7/dYTxrRFhxKoQ9CvVNv02EY7/bpV8+jcAGmB7F4BLeoEb1UHVLew
 0CDyUImaDRh9aKN11+GFjMe8GZQgQjDaIgBcPlO2iW6lb6zrWz1gGR95HyelCbYii4FQ
 jCr3DGNj4WuT+5v+t37bbplqE6sFwQbxiFye0ORdinPZ76yjspq2VFleTWDw1yzF/rvB tQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 3chcrp8nue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 23:32:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8gS3S4jAKk8HfB+XbmeDATPlU/4mDs6uduLszPNoS8U+4pxQ5I2Wew472kTy1IdzB5XU7s3fnlBYh+GfsTic8RA73woswgK90T+kPHQnSGfQMOvs6PqHLflGMs5+w2ju0md6B7pCJAHhPniVXIa37JAafEeUwco8Hh9rC0d6Dw8IQdX/EevxwusRPmbJGSI3k2YW678P6nJuSvXWA1zmqp9ClhLGhkOoAxTt60wJTdjPdhyxZH509UeFsN91Vq0A0tyxLSd0oXWNc9oSJprUGy3U9Vf2rlScvWAkPKHWoFI2OhjQU7J1J7t1v6BG+F+PJLe7jXeNfXZ22jhfUmlag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXmADHCjJc/17cES+t4DdzKyqP6mY/YCQLjK3FfbgmE=;
 b=WzL35OmMzuYVS4TsP4nh4jYxx3VfkBrf419RByErF1gvWfIuvo76OJ2hRd7Q8fkNRxzbicAukqzxkEin78C6j4Z89J+7hbkYY6fzXv9BgRQS+zDuQMJmVdv3jFFtXL+68ZCntNJtaozEQNqB0goyluSdGTZgzytKH5ON8cOYUfrqHTNGqQj1qVTCmHkW7UsPPrKOtmhfStje8TLq9Wv6BIuikwwMdHpbjHEZKKzuc404rUHAhfzp/A1YXyWmnAXpvS2SeYAOrJyAogsfzCo15EDyG2yIKEgz4fR785qN99ck5U9tVPmr3+vdhxLktZd58snlRGTwVPgAFzF9Fnr8uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXmADHCjJc/17cES+t4DdzKyqP6mY/YCQLjK3FfbgmE=;
 b=w+7LKvSgeM8uVS0QsGvXsgNhuHOIAvuiKMQi2ajBX2D7K+cQKbuZsIyfP4B1B0rdjFtK441Yyz4lBWlef4ag7r8OYqB29N6xTl1UMEUVn7kS8OL1R0B8To3MApDoFLkFbAEIEzGg9SwSfXPARkN84w+WSwgzlB1dNid5rRfgh1U=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB7132.namprd07.prod.outlook.com (2603:10b6:5:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 07:32:24 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::a15c:c860:703d:3017]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::a15c:c860:703d:3017%7]) with mapi id 15.20.4713.026; Wed, 24 Nov 2021
 07:32:24 +0000
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
Subject: RE: [PATCH v3 02/15] phy: cadence: Sierra: Prepare driver to add
 support for multilink configurations
Thread-Topic: [PATCH v3 02/15] phy: cadence: Sierra: Prepare driver to add
 support for multilink configurations
Thread-Index: AQHXx2anZo4Pol8NYk+Htx3JgA4aZKwQt5iAgAGpyfA=
Date:   Wed, 24 Nov 2021 07:32:23 +0000
Message-ID: <DM6PR07MB61548F462DD615DFF5C17D02C5619@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
 <20211022170236.18839-3-sjakhade@cadence.com> <YZxu/Tzo4fdiHKtR@matsya>
In-Reply-To: <YZxu/Tzo4fdiHKtR@matsya>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hODQxNTE5Zi00Y2Y4LTExZWMtODU4Yy1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcYTg0MTUxYTAtNGNmOC0xMWVjLTg1OGMtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIxMDkyNiIgdD0iMTMyODIyMTI3NDExOTg3NjQzIiBoPSJPRjBZOFVpMFhpUFhrdXF1djltaDJqSEVvMW89IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b09b9d98-cb3a-4903-d3b9-08d9af1c8ef6
x-ms-traffictypediagnostic: DM6PR07MB7132:
x-microsoft-antispam-prvs: <DM6PR07MB7132F11B2B2D8EEF8B5EC6BFC5619@DM6PR07MB7132.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:632;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWD6pmhUluuysgrNf21g1AQNvccllRvi5FROXb0XOCpAd2SzwH2yQhPvwwmGMXidjicQVm1Q9X77MZ93GNvdE3Pf5oiy93dfL2QZjH0YecE/4bvCcSRox9UREB0l6c8bTYNfaAM0yrQcsXO7J02lVuwHJxfoX5oLtoiKy+SXVocAvHyAErG13HQeuGQ7M23ygDhRuQh/BENBi6fR1pDq5upTSGiHdk9bmhMSiOyzdrsSxBzSGBTSNeKyjPqSSPPYScyNFePadrYLz30q8Q6ZSyDCyn+WgeuzTcZZp9If1LWJntYvhk9tapMix/ZAU3/UIJ+1VX5nAanjOooC32Og36vC2jfPHibYw5Ryvez5xqujgHn82uv9NTuLjUa2x59Dy1N/Q2BSTZ2ZCquAkrjwsHHRUKVDhkg2Irs+91Fo0gTSUg4nd88YVKXAnAPkrm+Ciml4ek2Zhyq1HJHbMQYTWtIfRrm6InewPsDptsIuD1BWgMO/oDz+eHktU9G/XlJ205r/+jgf7F8AMzUlb/+1+yrbUjHyOX7FrdOpVJBlAq5r84c+bS5DpaeKnwILP9950OqOZ2XGYJibU3Z8V3dayDJQ/FTdmYYnBDJkGUNpE99OJhEcDpwu83YBZXw22U6sSP2U1Vd96wgfteV2XTYGnNjJJpY4J9UUeiMjQ+pvoeGoJtgCGcQST3R7jsWpPj0pqjQ7htP7nA37GPZalf/CGocgeYkYLV7o+LD8mB6F/p0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(52536014)(2906002)(71200400001)(66446008)(66556008)(8936002)(186003)(55016003)(76116006)(4326008)(54906003)(86362001)(66476007)(64756008)(38070700005)(7696005)(5660300002)(26005)(6916009)(122000001)(38100700002)(33656002)(9686003)(83380400001)(508600001)(66946007)(53546011)(30864003)(8676002)(6506007)(316002)(19627235002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RqIaSWXkc2OTjRP4/XROOCooYHWslWr3hlMacVL29M/jgUs2Kpat/oUE/p7I?=
 =?us-ascii?Q?1Kv91iRlHq+iU8dy4HsFOKjCLFDXw59QGqdY3mk0+HiN+oET9mPZOwAFoEdp?=
 =?us-ascii?Q?MLyE7aq9AWPopKvSxuxfDSBMxKcwyzQImbf9VL9vS5CvZEJhO8cXmPbqiAQG?=
 =?us-ascii?Q?YvDi624STvq7JZrIKjAMuDSYtmpGi+tSGDBjCAqUuShgNN0EW/S4+P7ziwgV?=
 =?us-ascii?Q?N8jfEW1iJkTkoGIQ29OT6OY2gsHsxui6zNq+MwrShFuN8nplqIfsET5rQTp4?=
 =?us-ascii?Q?jXkAQGSbhL3ntaXHmKinQrj44tkBgbRMh5lvjYmGkpgs74oSc0oJDRs3RIig?=
 =?us-ascii?Q?2qocbPahw35yvuyxi99xK6I0em3BYmajm5/Ex6jTiXWFvIBTTz+Qe1RCAZOg?=
 =?us-ascii?Q?Fq6cI7pAeAmm7RvBmdLQUBma/o04CTfhvJC2uBC1yR8EZqJ6IcyHLOghZ2cs?=
 =?us-ascii?Q?+vlg1IP7HYGj4a2y6ytgIWTbSFU2TWKb3YK8GJJVK8j1Ne7izbbIacGS+cSE?=
 =?us-ascii?Q?Ldm9eG3f4ZeacnGsby2/ppchRKc/IO6YHGVC2HdzJ2StWUtuEfBRgkUItFfm?=
 =?us-ascii?Q?Od58Aw+5iEdqcPueNz3se0yFKAgWA2RNZOy1hbaefh4ishRV/n/D7ZXzbW+s?=
 =?us-ascii?Q?q0VuyiMw8Da4H/Wi1uKB21/Ao9HBZzMXD0bWzP41E4eoU2E+z+Xczmctxt5e?=
 =?us-ascii?Q?yWJyABysCwiLIYtM42v1PPxa3HJGkgBnEY0M268kYMpJ+//Da55xYBL/9VXB?=
 =?us-ascii?Q?0X1+HpWhoykOuT5+Aitof0nBM4TFuzze7RGgi7CBu2GMaP2/YzOQ8FGcAR9C?=
 =?us-ascii?Q?rq3m0VUL0AkxrAMA5Cj4tw6mMw/GfjCTZec2hv1Gq7uR7RRYf4AgxLLeKLA+?=
 =?us-ascii?Q?vtorkl4RdXOR2V7+mcZnS82uT4MkdCqyez1EonNMjglOR6/NAq393TkhwBPb?=
 =?us-ascii?Q?XPQfPKsY1uqolceZUdC4tcVyJISLTfwi8esNAfc1F0nhUKTXUsjFys4QLBxb?=
 =?us-ascii?Q?pW/sch7OzSMq64hnks2xMhuAundOlrZK9Rhr6k7jkrWnMHCDdY+EvlbDrk19?=
 =?us-ascii?Q?Vqp2olqurLAZ1tDzqoNTHjUx6VUhUyB2LrBPhBVZoLpHjKb4ugTc70xIXvwT?=
 =?us-ascii?Q?LjmcA/LoNF7kstcRgdhoyF2u6zla1h6mre665NYxALcpATJMnxwQRQwGWaiV?=
 =?us-ascii?Q?6MK5ItCK9oQ7nrTJ/q0gAw2UmyTbtijbOWnWJOJFil/li08afK7Dfo0mDskb?=
 =?us-ascii?Q?nBUQrT9xCtUdK1GOAvlwUWlkxUKJKsnTiS0d957j/SnoP/XtiClCOsUVPIQd?=
 =?us-ascii?Q?mOI6JXFi2nUBI/+8sG1QVIixc/cL9h/YhRHV1aXv/TwHluHz7MNUUZtmUh1x?=
 =?us-ascii?Q?/yRgi1FfGkGwzgGx3WskLBsdF41vI6Y0WKHrkdXyyesY7gU6NrCsUIUKRMIc?=
 =?us-ascii?Q?gDnHnN6DceHq8oJuewVfwrAR5r/Ep6ItP+Zrai7V/+3zBF9Z+y16iXpZHkmC?=
 =?us-ascii?Q?4sEyIWQ/5/WhZRGf19gWiHLNjW71tN6YPgb5cpe8I2+dkaeaj4mvHpUTk9LI?=
 =?us-ascii?Q?94zYRHwWXYODnarlKqJXXrUeCtMjy4Q2HliuNpYA/Zcfyq97UMJIxuBzwFrs?=
 =?us-ascii?Q?FfEcAtiQo/McFeBKnzawV9rXDq4eMtgtLIq/Ar7ONp+JHA6ZnoITQxYvE6Fj?=
 =?us-ascii?Q?sgOa5A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09b9d98-cb3a-4903-d3b9-08d9af1c8ef6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2021 07:32:23.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wRsjNDVtQ2mGIU4C2fR4S33d5fw2XxpPif+527FabiGhPm0qumzK+/Csoxrnut8sfizSojOfy6nyetj8t3Qmhmyogn81YFr6fat65Q2n/2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7132
X-Proofpoint-GUID: b_9J6O6-AvMNAlL8C0yNZXKDKn1jieCE
X-Proofpoint-ORIG-GUID: b_9J6O6-AvMNAlL8C0yNZXKDKn1jieCE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_02,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

> -----Original Message-----
> From: Vinod Koul <vkoul@kernel.org>
> Sent: Tuesday, November 23, 2021 10:03 AM
> To: Swapnil Kashinath Jakhade <sjakhade@cadence.com>
> Cc: kishon@ti.com; robh+dt@kernel.org; p.zabel@pengutronix.de; linux-
> phy@lists.infradead.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; Milind Parab <mparab@cadence.com>; a-
> govindraju@ti.com
> Subject: Re: [PATCH v3 02/15] phy: cadence: Sierra: Prepare driver to add
> support for multilink configurations
>=20
> EXTERNAL MAIL
>=20
>=20
> On 22-10-21, 19:02, Swapnil Jakhade wrote:
> > Sierra driver currently supports single link configurations only.
> > Prepare driver to support multilink multiprotocol configurations along
> > with different SSC modes.
> >
> > Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> > Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
> > ---
> >  drivers/phy/cadence/phy-cadence-sierra.c | 195
> > ++++++++++++++++-------
> >  1 file changed, 139 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> > b/drivers/phy/cadence/phy-cadence-sierra.c
> > index 54d1c63932ac..c82ac6716f5e 100644
> > --- a/drivers/phy/cadence/phy-cadence-sierra.c
> > +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> > @@ -23,6 +23,9 @@
> >  #include <dt-bindings/phy/phy.h>
> >  #include <dt-bindings/phy/phy-cadence.h>
> >
> > +#define NUM_SSC_MODE		3
> > +#define NUM_PHY_TYPE		3
> > +
> >  /* PHY register offsets */
> >  #define SIERRA_COMMON_CDB_OFFSET			0x0
> >  #define SIERRA_MACRO_ID_REG				0x0
> > @@ -217,9 +220,21 @@ static const int
> > pll_mux_parent_index[][SIERRA_NUM_CMN_PLLC_PARENTS] =3D {
> >
> >  static u32 cdns_sierra_pll_mux_table[] =3D { 0, 1 };
> >
> > +enum cdns_sierra_phy_type {
> > +	TYPE_NONE,
>=20
> What does NONE type mean?

TYPE_NONE is used to denote single link configuration.
e.g. [TYPE_PCIE][TYPE_NONE] denotes single link PCIe configuration.

>=20
> > +	TYPE_PCIE,
> > +	TYPE_USB
> > +};
> > +
> > +enum cdns_sierra_ssc_mode {
> > +	NO_SSC,
> > +	EXTERNAL_SSC,
> > +	INTERNAL_SSC
> > +};
> > +
> >  struct cdns_sierra_inst {
> >  	struct phy *phy;
> > -	u32 phy_type;
> > +	enum cdns_sierra_phy_type phy_type;
> >  	u32 num_lanes;
> >  	u32 mlane;
> >  	struct reset_control *lnk_rst;
> > @@ -230,18 +245,19 @@ struct cdns_reg_pairs {
> >  	u32 off;
> >  };
> >
> > +struct cdns_sierra_vals {
> > +	const struct cdns_reg_pairs *reg_pairs;
> > +	u32 num_regs;
> > +};
> > +
> >  struct cdns_sierra_data {
> > -		u32 id_value;
> > -		u8 block_offset_shift;
> > -		u8 reg_offset_shift;
> > -		u32 pcie_cmn_regs;
> > -		u32 pcie_ln_regs;
> > -		u32 usb_cmn_regs;
> > -		u32 usb_ln_regs;
> > -		const struct cdns_reg_pairs *pcie_cmn_vals;
> > -		const struct cdns_reg_pairs *pcie_ln_vals;
> > -		const struct cdns_reg_pairs *usb_cmn_vals;
> > -		const struct cdns_reg_pairs *usb_ln_vals;
> > +	u32 id_value;
> > +	u8 block_offset_shift;
> > +	u8 reg_offset_shift;
> > +	struct cdns_sierra_vals
> *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
> > +					     [NUM_SSC_MODE];
> > +	struct cdns_sierra_vals
> *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
> > +					    [NUM_SSC_MODE];
>=20
> You have defined phy type and ssc, that sounds fine, I am not sure why yo=
u
> need a third dimension here? What purpose does it solve?

PHY can be configured to support max 2 protocols simultaneously, so there
are two PHY_TYPE dimensions.

Thanks & regards,
Swapnil

>=20
> >  };
> >
> >  struct cdns_regmap_cdb_context {
> > @@ -341,10 +357,14 @@ static int cdns_sierra_phy_init(struct phy
> > *gphy)  {
> >  	struct cdns_sierra_inst *ins =3D phy_get_drvdata(gphy);
> >  	struct cdns_sierra_phy *phy =3D dev_get_drvdata(gphy->dev.parent);
> > +	const struct cdns_sierra_data *init_data =3D phy->init_data;
> > +	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
> > +	enum cdns_sierra_phy_type phy_type =3D ins->phy_type;
> > +	enum cdns_sierra_ssc_mode ssc =3D EXTERNAL_SSC;
> > +	const struct cdns_reg_pairs *reg_pairs;
> >  	struct regmap *regmap;
> > +	u32 num_regs;
> >  	int i, j;
> > -	const struct cdns_reg_pairs *cmn_vals, *ln_vals;
> > -	u32 num_cmn_regs, num_ln_regs;
> >
> >  	/* Initialise the PHY registers, unless auto configured */
> >  	if (phy->autoconf)
> > @@ -352,28 +372,26 @@ static int cdns_sierra_phy_init(struct phy
> > *gphy)
> >
> >  	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
> >  	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
> > -	if (ins->phy_type =3D=3D PHY_TYPE_PCIE) {
> > -		num_cmn_regs =3D phy->init_data->pcie_cmn_regs;
> > -		num_ln_regs =3D phy->init_data->pcie_ln_regs;
> > -		cmn_vals =3D phy->init_data->pcie_cmn_vals;
> > -		ln_vals =3D phy->init_data->pcie_ln_vals;
> > -	} else if (ins->phy_type =3D=3D PHY_TYPE_USB3) {
> > -		num_cmn_regs =3D phy->init_data->usb_cmn_regs;
> > -		num_ln_regs =3D phy->init_data->usb_ln_regs;
> > -		cmn_vals =3D phy->init_data->usb_cmn_vals;
> > -		ln_vals =3D phy->init_data->usb_ln_vals;
> > -	} else {
> > -		return -EINVAL;
> > -	}
> >
> > -	regmap =3D phy->regmap_common_cdb;
> > -	for (j =3D 0; j < num_cmn_regs ; j++)
> > -		regmap_write(regmap, cmn_vals[j].off, cmn_vals[j].val);
> > +	/* PMA common registers configurations */
> > +	pma_cmn_vals =3D init_data-
> >pma_cmn_vals[phy_type][TYPE_NONE][ssc];
> > +	if (pma_cmn_vals) {
> > +		reg_pairs =3D pma_cmn_vals->reg_pairs;
> > +		num_regs =3D pma_cmn_vals->num_regs;
> > +		regmap =3D phy->regmap_common_cdb;
> > +		for (i =3D 0; i < num_regs; i++)
> > +			regmap_write(regmap, reg_pairs[i].off,
> reg_pairs[i].val);
> > +	}
> >
> > -	for (i =3D 0; i < ins->num_lanes; i++) {
> > -		for (j =3D 0; j < num_ln_regs ; j++) {
> > +	/* PMA lane registers configurations */
> > +	pma_ln_vals =3D init_data->pma_ln_vals[phy_type][TYPE_NONE][ssc];
> > +	if (pma_ln_vals) {
> > +		reg_pairs =3D pma_ln_vals->reg_pairs;
> > +		num_regs =3D pma_ln_vals->num_regs;
> > +		for (i =3D 0; i < ins->num_lanes; i++) {
> >  			regmap =3D phy->regmap_lane_cdb[i + ins->mlane];
> > -			regmap_write(regmap, ln_vals[j].off, ln_vals[j].val);
> > +			for (j =3D 0; j < num_regs; j++)
> > +				regmap_write(regmap, reg_pairs[j].off,
> reg_pairs[j].val);
> >  		}
> >  	}
> >
> > @@ -583,15 +601,28 @@ static int cdns_sierra_clk_register(struct
> > cdns_sierra_phy *sp)  static int cdns_sierra_get_optional(struct
> cdns_sierra_inst *inst,
> >  				    struct device_node *child)
> >  {
> > +	u32 phy_type;
> > +
> >  	if (of_property_read_u32(child, "reg", &inst->mlane))
> >  		return -EINVAL;
> >
> >  	if (of_property_read_u32(child, "cdns,num-lanes", &inst-
> >num_lanes))
> >  		return -EINVAL;
> >
> > -	if (of_property_read_u32(child, "cdns,phy-type", &inst->phy_type))
> > +	if (of_property_read_u32(child, "cdns,phy-type", &phy_type))
> >  		return -EINVAL;
> >
> > +	switch (phy_type) {
> > +	case PHY_TYPE_PCIE:
> > +		inst->phy_type =3D TYPE_PCIE;
> > +		break;
> > +	case PHY_TYPE_USB3:
> > +		inst->phy_type =3D TYPE_USB;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> >  	return 0;
> >  }
> >
> > @@ -1006,6 +1037,16 @@ static const struct cdns_reg_pairs
> cdns_pcie_ln_regs_ext_ssc[] =3D {
> >  	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG}
> >  };
> >
> > +static struct cdns_sierra_vals pcie_100_ext_ssc_cmn_vals =3D {
> > +	.reg_pairs =3D cdns_pcie_cmn_regs_ext_ssc,
> > +	.num_regs =3D ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
> > +};
> > +
> > +static struct cdns_sierra_vals pcie_100_ext_ssc_ln_vals =3D {
> > +	.reg_pairs =3D cdns_pcie_ln_regs_ext_ssc,
> > +	.num_regs =3D ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
> > +};
> > +
> >  /* refclk100MHz_20b_USB_cmn_pll_ext_ssc */  static const struct
> > cdns_reg_pairs cdns_usb_cmn_regs_ext_ssc[] =3D {
> >  	{0x2085, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
> > @@ -1113,32 +1154,74 @@ static const struct cdns_reg_pairs
> cdns_usb_ln_regs_ext_ssc[] =3D {
> >  	{0x4243, SIERRA_RXBUFFER_DFECTRL_PREG}  };
> >
> > +static struct cdns_sierra_vals usb_100_ext_ssc_cmn_vals =3D {
> > +	.reg_pairs =3D cdns_usb_cmn_regs_ext_ssc,
> > +	.num_regs =3D ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
> > +};
> > +
> > +static struct cdns_sierra_vals usb_100_ext_ssc_ln_vals =3D {
> > +	.reg_pairs =3D cdns_usb_ln_regs_ext_ssc,
> > +	.num_regs =3D ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
> > +};
> > +
> >  static const struct cdns_sierra_data cdns_map_sierra =3D {
> > -	SIERRA_MACRO_ID,
> > -	0x2,
> > -	0x2,
> > -	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
> > -	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
> > -	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
> > -	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
> > -	cdns_pcie_cmn_regs_ext_ssc,
> > -	cdns_pcie_ln_regs_ext_ssc,
> > -	cdns_usb_cmn_regs_ext_ssc,
> > -	cdns_usb_ln_regs_ext_ssc,
> > +	.id_value =3D SIERRA_MACRO_ID,
> > +	.block_offset_shift =3D 0x2,
> > +	.reg_offset_shift =3D 0x2,
> > +	.pma_cmn_vals =3D {
> > +		[TYPE_PCIE] =3D {
> > +			[TYPE_NONE] =3D {
> > +				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_cmn_vals,
> > +			},
> > +		},
> > +		[TYPE_USB] =3D {
> > +			[TYPE_NONE] =3D {
> > +				[EXTERNAL_SSC] =3D
> &usb_100_ext_ssc_cmn_vals,
> > +			},
> > +		},
> > +	},
> > +	.pma_ln_vals =3D {
> > +		[TYPE_PCIE] =3D {
> > +			[TYPE_NONE] =3D {
> > +				[EXTERNAL_SSC] =3D &pcie_100_ext_ssc_ln_vals,
> > +			},
> > +		},
> > +		[TYPE_USB] =3D {
> > +			[TYPE_NONE] =3D {
> > +				[EXTERNAL_SSC] =3D &usb_100_ext_ssc_ln_vals,
> > +			},
> > +		},
> > +	},
> >  };
> >
> >  static const struct cdns_sierra_data cdns_ti_map_sierra =3D {
> > -	SIERRA_MACRO_ID,
> > -	0x0,
> > -	0x1,
> > -	ARRAY_SIZE(cdns_pcie_cmn_regs_ext_ssc),
> > -	ARRAY_SIZE(cdns_pcie_ln_regs_ext_ssc),
> > -	ARRAY_SIZE(cdns_usb_cmn_regs_ext_ssc),
> > -	ARRAY_SIZE(cdns_usb_ln_regs_ext_ssc),
> > -	cdns_pcie_cmn_regs_ext_ssc,
> > -	cdns_pcie_ln_regs_ext_ssc,
> > -	cdns_usb_cmn_regs_ext_ssc,
> > -	cdns_usb_ln_regs_ext_ssc,
> > +	.id_value =3D SIERRA_MACRO_ID,
> > +	.block_offset_shift =3D 0x0,
> > +	.reg_offset_shift =3D 0x1,
> > +	.pma_cmn_vals =3D {
> > +		[TYPE_PCIE] =3D {
> > +			[TYPE_NONE] =3D {
> > +				[EXTERNAL_SSC] =3D
> &pcie_100_ext_ssc_cmn_vals,
> > +			},
> > +		},
> > +		[TYPE_USB] =3D {
> > +			[TYPE_NONE] =3D {
> > +				[EXTERNAL_SSC] =3D
> &usb_100_ext_ssc_cmn_vals,
> > +			},
> > +		},
> > +	},
> > +	.pma_ln_vals =3D {
> > +		[TYPE_PCIE] =3D {
> > +			[TYPE_NONE] =3D {
> > +				[EXTERNAL_SSC] =3D &pcie_100_ext_ssc_ln_vals,
> > +			},
> > +		},
> > +		[TYPE_USB] =3D {
> > +			[TYPE_NONE] =3D {
> > +				[EXTERNAL_SSC] =3D &usb_100_ext_ssc_ln_vals,
> > +			},
> > +		},
> > +	},
> >  };
> >
> >  static const struct of_device_id cdns_sierra_id_table[] =3D {
> > --
> > 2.26.1
>=20
> --
> ~Vinod
