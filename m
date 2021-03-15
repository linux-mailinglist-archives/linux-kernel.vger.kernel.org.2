Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0518133AB41
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCOFvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:51:43 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:19032 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229937AbhCOFvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:51:31 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F5mvbr018552;
        Sun, 14 Mar 2021 22:51:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=qOKoQwjN+6cVcCVxOcNrw9Y4VXJQFsTgp4xztxcGf+k=;
 b=mPeUU4VMbIXhxPu4H7KGkDjsh0p3CXMjraV9E5duj2KhcmV6VJvL8GeygdV2dO8xokAX
 G57TvSxu+7VcKX1nfaCeyNStpCc0YkLlX+WUSyYzsqKh5FXvLtPIGd8msExM/rZxP8+1
 iQ6xQ/Xa43ExLG5JysAY/AXWKwX5tb8Hlwt1uDMqDclwYua/2/p7K0wIoK7/IziTnPOB
 r4/IBeFIoipIXUnkRFSyzUNsQTzfs7yXsOvAcEfq7x4oReU7G40FajY+KLFgd0HFKhIe
 ceDy9djvVNhKG9C3Cj42Rkeb4fgEDi5HjgpEJqTus1ZCBBt+y9xVyA+4RxvTl7QsEtHQ Xw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2cv3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 22:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb7g5osyojlZwpCwjTlnZrRS0oQAsH5ujXZVh/eE8Nhy05cd8XLv1sSa5jhPNXvg3MwfP6ayWZvwI/f6i4gtzmuV+OalYRBlqLBUup1bFdqLd9d38l8JM4qx/CyFSPPjQigWviREDb0BTxgb78vFzSqGjRNKKFdVAzGARnsd7LJfyvAYQPHHMkSUYetEKWT8WdvvprA43tSG6GsH9JIstsQsjRSv4UQYdBOhrYgz+V0uUXGGSKYEZRWB88OOTi+AuyEPaDc8/YzoXfAj8zu8MTAgBpaaucxkL1CBmRvELLZtjMOTZp1wR1pVYVW3l41/2Mn/pZT4pBTTN55Vq574wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOKoQwjN+6cVcCVxOcNrw9Y4VXJQFsTgp4xztxcGf+k=;
 b=HgArr+a3RREHN5KwgQnPAau7EoYqCI1hOybT5ypkYaOVPvlSu+k+N1FLmedsR74ENKuMwYIfjg648q6MSG1YOg81dmVzuK6WnFysq3VeJMmQc+3KvDoiLizRMlfw++qxhdgwZ+s9gK/izHybj1wLpWxKNFhWmn5qtIoyqK6LXcN+fXb+Rmi0toYgiO8Fs7TdsnKvsqiZMsdXKqjTVNyrUyywzbzNjiSIHOP95Bm+MxcYHZiuixBpRYqGHW13Qwfa1RkDGBQmobiwDIEaMhuRi9KsMZZiferLePCSXblC4FRnbHaiNcmDDaeZNOizBV0SNAMdYmyvDEuOhvtaKL/OXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOKoQwjN+6cVcCVxOcNrw9Y4VXJQFsTgp4xztxcGf+k=;
 b=LTpXtC+AcKeUmT0iUVcuvfdBdNsLZ+HjvdM/BxCiV+RR68a0yZ/5H3BAU0IV43CMEAYJFoA+eMULZNytCR/nRp3VzG+HL/NpYj1aYgF+cJqQM97pgLZm1rqufeV+ivWEcERyJ7RDeMjnsVETOzU5TikTqlu6BND8ZpqzquCFcW4=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by BLAPR07MB8258.namprd07.prod.outlook.com (2603:10b6:208:323::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 05:51:23 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 05:51:23 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v6 08/13] phy: cadence-torrent: Use a common header file
 for Cadence SERDES
Thread-Topic: [PATCH v6 08/13] phy: cadence-torrent: Use a common header file
 for Cadence SERDES
Thread-Index: AQHXFcSLP2ATwwVEmUKYsVCPLtlnqKqACWQw
Date:   Mon, 15 Mar 2021 05:51:23 +0000
Message-ID: <MN2PR07MB6160DC5FC5F9C3F63FC21C08C56C9@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310154558.32078-1-kishon@ti.com>
 <20210310154558.32078-9-kishon@ti.com>
In-Reply-To: <20210310154558.32078-9-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy03NzFhYTM2NS04NTUyLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcNzcxYWEzNjYtODU1Mi0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIyOTA5IiB0PSIxMzI2MDI2MTA4MDcyODgxODUiIGg9Imptc3EyTDVEbW8vUkh2aTBQS09GYk0rNlc5OD0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24badd8e-62a7-4682-00b1-08d8e7765da2
x-ms-traffictypediagnostic: BLAPR07MB8258:
x-microsoft-antispam-prvs: <BLAPR07MB825824A554AC9FC70A633F9FC56C9@BLAPR07MB8258.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YxOpQ+a9ko0yirVL7z7LYB2/V1Fb8DH4GLb35fjbtl01H06isIN+pyFPT6tNdU6SFKhxdSSo/EpJmaxvXruh3ph4qRhPNl48wLtHZgoA6z/CFSgUcZXbdk098RMn6Oez8RCqWIr4rk+AIRFe6UJwj+bXi4GKLMNLriJaXjBW8ypdItMJb0WWd8PcVgrC5UEeVsVeznuQcueDSTd4z/AkuMlspF0cPLiFL+e68zKxf3VJnOpJsRPRwJLo7waJMivl0q/xpxBziRHLudqGSFtQh91eZQ+twxSW6usWI7iSDMuJum68qzH5314JU+oDzOYPHtjoivSisbFYt71JO9DmlLku9uLVlkIBFit27PTzIdlLiBww5TPBhaaH+0/NCA2nZR40gUDtYzdK1MBIeDSmOYBWek6KYKM+XxNjjo4ZYmkQG/e/sYIXd9uPH31kpqVmp/Gfdine5FD2Qj2X3Paq7HRF3NP60dyXJ3n++1FbjmmslNGBMkpaxfuJ5mgoO2kJjr7VJe7ELAPlj8lcEgWNS1EKnwmzAUxSsRRMydi75xSrVEKdzZMIHSVOtRPPsbAR3YOWzIFoXV8M3lqgr9nQd+qMTvMBQC0GZw1WDxYXW9RMFKWHROvSAdQns4e++9V
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(36092001)(66946007)(64756008)(66446008)(66556008)(66476007)(26005)(53546011)(33656002)(186003)(52536014)(71200400001)(5660300002)(6506007)(316002)(76116006)(8676002)(7696005)(8936002)(4326008)(478600001)(9686003)(55016002)(86362001)(54906003)(83380400001)(2906002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DU2HMFVlNo6N29OkZX7ZXTGVRrd26Ay3GA4mhzk1dVCmHYYQmC7J+2d9GOc7?=
 =?us-ascii?Q?zFl9FVVz8Optx47zvc2QT/A3YGx6zA7pebws1MT2S+27Eeh4P+cOgzv1j09M?=
 =?us-ascii?Q?tm+Un0SK3c7WZS2fyTGpQOWHEIE5uzUBPXtoBsJKIsSNHW1qmGA3SQZxXX0o?=
 =?us-ascii?Q?5ReAc9kBgI2ltOzCRzIVxqxL9t56ZvIh9uITHBR4YgGsuHY7rG+619uAxcJ+?=
 =?us-ascii?Q?fy0ji0SAa3B1FYf+Jv6aHyl9yVd/ri9S8mPm5gj64qCq1jdIXvCLjGLcJrrw?=
 =?us-ascii?Q?vH77YqifyfGdNmPjh/A7idy4O8c/q66PBNwzdVYAP0mO2OQu9qIhrniifRTU?=
 =?us-ascii?Q?PRpTY9e1nZuy6caa43IREJzSjw32hw+DAWagrtG5APAR3ua8lW+xeAjMSCV5?=
 =?us-ascii?Q?ohxaUFWaMWpGb9JXP/1qCDsjyoyekODutu5mDZsysrOzxZ6mvtwuammSSoDu?=
 =?us-ascii?Q?tXo8NMzrFEDWsrqsqGO8fqFV3ynvjNDSMNRIXjgMKRObcFe/vXWZYRF6qplm?=
 =?us-ascii?Q?l8G6rU5B5BT9+ezucjCykRohjofX6CJplqsgQOC+v67ocYRo5NufuoWKnWCs?=
 =?us-ascii?Q?xV6Y6s8zT0v8nRQyZ4GAMF+tQK2TqRT45bVIKAyTFG2pDCcn7MBw7XqGog6z?=
 =?us-ascii?Q?+24BMmMBvzDbYgsGVLoyDKiiovHZHnytSS317EN8dettmo/Gi4mgECKWl5Xv?=
 =?us-ascii?Q?VnMvvXdP9Anp4HvlVcLbptlqgXjJ2OVmk0YzTxjBFi4Wcre2/5gJp0rx+wvK?=
 =?us-ascii?Q?tCevHS9/Jvuet/BCWd+JYTH99UrjGGXkY/kTwBtBNiiPrmLoFqLtVkkhrd3x?=
 =?us-ascii?Q?J5g8TTBnZExg9spO3onKQczqbgxz1f0YGn3gtSfN+ZE2xtiv97lVfQCJWy9A?=
 =?us-ascii?Q?HuVR7UmCwmGA+s82XbdnueulYE2TOGw2XSMo8aXwg5HIEuWyva/gEvbFhLIq?=
 =?us-ascii?Q?T7iSkXvcYuLpdVBRejcoURGUZAdxepgMYhs4A9Sw/WJphyQzt4FpGH9l903a?=
 =?us-ascii?Q?QKS9CxWTFIYpg91/SA2TuZ+PbLupRhXfGWw5UynNpXTcl3XTAeH5keyPUTxA?=
 =?us-ascii?Q?04nKrPRhkDhSN4GiDU4dbx3ocJox5h9Gk8Ju5KzqFRezBoEpRx5Dy44yOAQP?=
 =?us-ascii?Q?3iaJ3dd8m95Gqv987vvgXWB0zMah7PmAJeJ3D4su0qFlXYbnIKxqEvuMCWgp?=
 =?us-ascii?Q?JuztrW1U/GUpdzaJZDuFwgyqFFLYlix0LBu073cCBtZ20qj3LY5McOaRvnoA?=
 =?us-ascii?Q?bN29S2C2FE8nS1DRc6wA7AZZqStlf18kFe/lTw62+NmzE/9nr/YF5HfxMVH/?=
 =?us-ascii?Q?7GpVfsELBhK8iuQmoH++60Km?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24badd8e-62a7-4682-00b1-08d8e7765da2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:51:23.4451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qi2+6AIqqlxOnPiA3AhyBusiNDCaQ9TptcjDYwcqoUj+SFiUwKoJTZrznFq2CC9K6AVG220lSDB8ytO1DoCbAFPsanKjmxDowb1pHDPtekw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB8258
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_01:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103150040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Kishon Vijay Abraham I <kishon@ti.com>
> Sent: Wednesday, March 10, 2021 9:16 PM
> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul
> <vkoul@kernel.org>; Rob Herring <robh+dt@kernel.org>; Philipp Zabel
> <p.zabel@pengutronix.de>; Swapnil Kashinath Jakhade
> <sjakhade@cadence.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Lokesh Vutl=
a
> <lokeshvutla@ti.com>
> Subject: [PATCH v6 08/13] phy: cadence-torrent: Use a common header file
> for Cadence SERDES
>=20
> EXTERNAL MAIL
>=20
>=20
> No functional change. In order to have a single header file for all
> Cadence SERDES move phy-cadence-torrent.h to phy-cadence.h. This is
> in preparation for adding Cadence Sierra SERDES specific macros.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-torrent.c                | 2 +-
>  .../phy/{phy-cadence-torrent.h =3D> phy-cadence.h}         | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>  rename include/dt-bindings/phy/{phy-cadence-torrent.h =3D> phy-cadence.h=
}
> (51%)
>=20

Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> diff --git a/drivers/phy/cadence/phy-cadence-torrent.c
> b/drivers/phy/cadence/phy-cadence-torrent.c
> index 95160da3e667..3fdab0d288c4 100644
> --- a/drivers/phy/cadence/phy-cadence-torrent.c
> +++ b/drivers/phy/cadence/phy-cadence-torrent.c
> @@ -7,7 +7,7 @@
>   */
>=20
>  #include <dt-bindings/phy/phy.h>
> -#include <dt-bindings/phy/phy-cadence-torrent.h>
> +#include <dt-bindings/phy/phy-cadence.h>
>  #include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/delay.h>
> diff --git a/include/dt-bindings/phy/phy-cadence-torrent.h b/include/dt-
> bindings/phy/phy-cadence.h
> similarity index 51%
> rename from include/dt-bindings/phy/phy-cadence-torrent.h
> rename to include/dt-bindings/phy/phy-cadence.h
> index 3c92c6192493..4a5ea52a856f 100644
> --- a/include/dt-bindings/phy/phy-cadence-torrent.h
> +++ b/include/dt-bindings/phy/phy-cadence.h
> @@ -1,15 +1,16 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * This header provides constants for Cadence Torrent SERDES.
> + * This header provides constants for Cadence SERDES.
>   */
>=20
> -#ifndef _DT_BINDINGS_TORRENT_SERDES_H
> -#define _DT_BINDINGS_TORRENT_SERDES_H
> +#ifndef _DT_BINDINGS_CADENCE_SERDES_H
> +#define _DT_BINDINGS_CADENCE_SERDES_H
>=20
> +/* Torrent */
>  #define TORRENT_SERDES_NO_SSC		0
>  #define TORRENT_SERDES_EXTERNAL_SSC	1
>  #define TORRENT_SERDES_INTERNAL_SSC	2
>=20
>  #define CDNS_TORRENT_REFCLK_DRIVER      0
>=20
> -#endif /* _DT_BINDINGS_TORRENT_SERDES_H */
> +#endif /* _DT_BINDINGS_CADENCE_SERDES_H */
> --
> 2.17.1

