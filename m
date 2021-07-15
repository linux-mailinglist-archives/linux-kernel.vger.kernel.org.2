Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33FC3C9AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbhGOIuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:50:14 -0400
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:32026
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229620AbhGOIuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:50:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgbdlDc80oKe9EWfkRG781X2Tww6hqioLoa6WSXPm8Gs1REpeMeQ9WoF/KRsk5QbNrb0U+bK7JUOrixVE33DSCf9+Zl65TYHY3WyDBGoN37LPZ7Fkrej+T8x6/1m8rrwJCuxCAd8+fds1zv63xM8w4GeT11rR/dv/QHz9Rhn2PA4rB++WSgXms8z5h44Vas0VgB/1pOnpNGH4IL45o1N7P3amvLdQ44piTv+nkGJZ4fOJ8+7b3RfZowxtD21GZULjWqSWK9IgcTiMBWZ5BVW741ZWG67DisBWJMeBNVQhd41jT2UkUMph3n7WnQPK6X44x1ks5jSvengKxApc2zCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42V9OWDGSGaf6DgzClwqSj3H6syWOaJs/hNqmxx9WnA=;
 b=G3bfMCTH56DDTNy4zznXW9H7Agq90GAb9mMyZc6hPuc2sgw7xUAa8RVM6OLiaYZE6TtOib5l7V9TMRQUCM6iv6+Zz5IM88ZSWqmFx8dzKZ0HmhiYP/YPlGLAxm3Bx+H7Il9s0r6986zbWbQfiYoKp+5OimUh78HBfU1Z8CHA173OFwhWkJFlYNfkBWFeE7JEnic02FGVnEqcBJ/8aj7tzMh2vpAsw0pVWLf36rrqUNCBYLx+ZBxYpYX1c3vjoV3Ph43++dKt1omZjgqlWpv4snZ/5b7pWvYtmQMaMWAevHEg6tgDpexxfNVBYmNsj/c1d6lkj4g5V9hgeGaMPXxsPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kococonnector.com; dmarc=pass action=none
 header.from=kococonnector.com; dkim=pass header.d=kococonnector.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42V9OWDGSGaf6DgzClwqSj3H6syWOaJs/hNqmxx9WnA=;
 b=lezXMTwc72+tO1OGVcx9a/4Do5Pv0ySJHovaEX8n4IpOPJlUW6DMzp35wGm7d7TrOjdtzHMwCJHlfr8cC82WmR6Jq90s/fxGetBqS3l3qnwK0hC0LDtTWz1WH9JnASe82/30nBayhN9KDyqn/YRFchvLnKMsW7XIhl7C6TAE7TY=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by AM9PR09MB4690.eurprd09.prod.outlook.com (2603:10a6:20b:2dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Thu, 15 Jul
 2021 08:47:18 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::60d1:9cfe:5e26:92b5%6]) with mapi id 15.20.4331.022; Thu, 15 Jul 2021
 08:47:18 +0000
Date:   Thu, 15 Jul 2021 10:46:44 +0200
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     shawnguo@kernel.org, devicetree@vger.kernel.org,
        aisheng.dong@nxp.com, fabio.estevam@nxp.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: imx8qm: added System MMU
Message-ID: <20210715084644.GA28307@optiplex>
References: <20210714120925.23571-1-oliver.graute@kococonnector.com>
 <20210714120925.23571-3-oliver.graute@kococonnector.com>
 <d10b6230-6a7d-05c9-47ec-6defe840d827@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d10b6230-6a7d-05c9-47ec-6defe840d827@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM3PR07CA0096.eurprd07.prod.outlook.com
 (2603:10a6:207:6::30) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2.207.138.2) by AM3PR07CA0096.eurprd07.prod.outlook.com (2603:10a6:207:6::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8 via Frontend Transport; Thu, 15 Jul 2021 08:47:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14fcb2e0-1263-48e2-d0e4-08d9476d2706
X-MS-TrafficTypeDiagnostic: AM9PR09MB4690:
X-Microsoft-Antispam-PRVS: <AM9PR09MB469029747EF866E8BF91F15BEB129@AM9PR09MB4690.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cysduLEYZpahFKQfd6BdgxSdrvQ+/iC+FXGm80x7cS1+JuKI/MUFIWDIS16LCU1vCLBjMhD23qMR4rrdNQsnHGJrb85qBiQULBApZTxbz4Av68/mBZ6RZXFQ2qZJriZTi1ZYYpFjtulQziQ6SCkIMElqxmpesp0HXbPCbjEtYwO72Wq5Giaf9tMjPjIRnjOW6C+sKZw3vfPdMevH4Yh8THK0L2Kw2u/d+2OHsxUliWCgvcK17z1BKtxzrYFUtzVUBzwP3aj+OE0WK6P/b9QltCk5M5JV6X04R5c98bwEYYG+YAOl6MDb+OIsu4OiBUCQ52c13vm8Q1Wo3ygT/45TIXyO2Rco4V1C/NA0B5rQPd66iYo5wVv2Nu+vawpqcWjce0RgZGfIyz5cRCFNv7+NGIhyxgN8NPkQiq/q5btmyTK74josQC8s39XsKjcdX+APq9C1v0OsD1gRepwVXktLjgsmM4E7xyWNaPV1h7gR74X8wbxFpWB72ky+T23I7xoqmLao7jWJwbZvHAu0TCMQQB1hM3y4lK9GyGaRekzQ2bBSurumCJ19dz8O+THze3g3iZD+kIg8OhQOHVMOcwNzI14Xkqkk44Lg/iYfaNGkt5PpI+F2bCKXTTpul2iLNuMSjS+PKHCOhYVspS4hF2DzmbgMk3GgZ8j76Jn2/KpvYtrPSAHSS+ViGfOzERV3UmGTRdSs3Q3u9eQBfno936VS10oDVXe1VpTXDdLKmg4uoTI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(39830400003)(396003)(376002)(136003)(346002)(44832011)(6666004)(66946007)(8936002)(66476007)(33716001)(6496006)(52116002)(66556008)(956004)(6916009)(2906002)(53546011)(4326008)(86362001)(5660300002)(8676002)(1076003)(54906003)(478600001)(38100700002)(83380400001)(38350700002)(316002)(7416002)(26005)(9686003)(186003)(33656002)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WRomZOt7vK6gYn11e/2+thHA1PuGZnDvcqZIeyvEdTcnJVHofT6HShaYS78u?=
 =?us-ascii?Q?Fzak0P1TetP4DFdx6lUmJ/x618A3Ka3byWqo0PTX+S2lwm7qMNFYV54Awd0b?=
 =?us-ascii?Q?vfis/VVgC3SBdgEpK8ATLjUtjROYoUkueA/aAWQ3SfXXZATTag1sab5b3Eoc?=
 =?us-ascii?Q?0l0v1JeE4yY+yTmR7cr07/Rc2BjjjerBBesjDLhAWCGbt5qsW3w2dqmIKp2q?=
 =?us-ascii?Q?noV7MufR7+4Zu22fAPjcXfOD8/b3aHjIfq9JFxbER5dgIXZq2A8j2KSgdqse?=
 =?us-ascii?Q?ucVMBaLOHAdnMSCm0ouZjrRjmpU7oRF1L07AY5QYEwuenHMKX74Si7FryKd9?=
 =?us-ascii?Q?xNan1uZL9F59Xh0rYxVRwS3UM8oS/DOTBu0x9nX+/vMH4Rlz2yTnhIT/Hk1i?=
 =?us-ascii?Q?u8LSGTuq5wL06YMy0SFdt9yxQuFsLQ4lo2eY5qIiKvfFa2COHdzwVAFJ+t/L?=
 =?us-ascii?Q?utLsmNgkRNCzdecryF3kNn/+J2/eYh7oM3V+VFSmRmfr9Bt3Sa8VvDlojnSS?=
 =?us-ascii?Q?E5LwTZMmiSOZP86rvlz53hMHytv5HVh4rBicgeqCoH6sb/WlCVHhk/tNz/R5?=
 =?us-ascii?Q?8gvZH/wPw7XekrEboDIelroMnGuMrl0sJIXJJj4HZ9OH+i4oDXbXrK12JFQo?=
 =?us-ascii?Q?WRD2oXaGdld0jq1EhpMYrxhE08bRN8/CUESKmJkBhLiheCyBYMiQji3S5fG0?=
 =?us-ascii?Q?6OcweLCKwkf5fZBKSwDtOaDiRMKW+Mj9sbDTAkHOjqqUUacbKmz270KLFFwx?=
 =?us-ascii?Q?3ttpgkaC40EFf1f3XiLQPi48O0UMAQ3usdhljQU2cPI+RSP+m718xYdZIlQM?=
 =?us-ascii?Q?jn6vbDFbaT+zu8GHImCsIFEx3LAxMsIwmm351rlLylxleZrUSsAUY54XyJcM?=
 =?us-ascii?Q?DXu2yNm9tJ1nCryq5/9oeiqTV5wWQ5ifNe1ty7TCQ29SxMG8KFJp/h/cw2M1?=
 =?us-ascii?Q?V8nmOtglpjdNF7LUeEFzjD7wpubIACyiM1BWHGOeENOWvwPZNpjg/Ul2XIYk?=
 =?us-ascii?Q?/AZ8jsVlXJtGuzZi7shvQt2Yqq0etuxtQCaen4lEIgddGrcz1LRt/xBAyNKm?=
 =?us-ascii?Q?SBYckpSkA1hiB8uxEl5Y7vLZzlT5U3NnEvruJwZ7W3JmljTEP+ud+3sf6vlU?=
 =?us-ascii?Q?/X0sXvZ2rgXoXg3ihD0MnE1Ez0b7bNRv+MBxmU6DZ5/0E8Dh3526Uo9GPdOC?=
 =?us-ascii?Q?B1PqvQZ9HZuE2Lo6n7FcszYCyqzsqwCkugQwt/vEUPDYvluu7VZJAcJzQbUX?=
 =?us-ascii?Q?0hE3XlNydot6wu1bjel5CfntUV86NkfdI8FiU+s0rvVkal7tVlwGhs/H/XV5?=
 =?us-ascii?Q?SW6VYmifwIxONNfLxt/4k5Sp?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fcb2e0-1263-48e2-d0e4-08d9476d2706
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 08:47:18.3442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlnJjmQwDidLy0l9sbnE+kJf6aPGyghzyZzQ4dTWZ/Btqn27jdftv70FfjBA/ChJD37g9J65N0rPar2VZRQDHtuCKo+dJwpjCdwsaZyn0nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB4690
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/21, Robin Murphy wrote:
> On 2021-07-14 13:09, Oliver Graute wrote:
> > added node for System MMU
>=20
> Note that it's a bit of a dangerous game to enable an SMMU without the
> complete Stream ID topology for *all* its upstream devices also described=
,
> since CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT will ruin peoples' day. I=
t
> might be more polite to add it in a disabled state until every "iommus"
> property has been filled in, so that people who do want to play with it f=
or
> specific devices in the meantime can easily just flip the status (while
> taking the necessary precautions), but people who don't care won't be
> inadvertently affected regardless of their kernel config. I'm assuming an
> SMMU with 32 contexts has more than a single USB controller behind it...

thx for the explanation. So I will set this node to disabled state in
next version of this patch.
>=20
> >   	};
> > +	smmu: iommu@51400000 {
> > +		compatible =3D "arm,mmu-500";
> > +		interrupt-parent =3D <&gic>;
> > +		reg =3D <0 0x51400000 0 0x40000>;
> > +		#global-interrupts =3D <1>;
> > +		#iommu-cells =3D <2>;
> > +		interrupts =3D <0 32 4>,
> > +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> > +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> > +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> > +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> > +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> > +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> > +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>,
> > +			     <0 32 4>, <0 32 4>, <0 32 4>, <0 32 4>;
		status =3D "disabled";
> > +	};

Best regards,

Oliver
