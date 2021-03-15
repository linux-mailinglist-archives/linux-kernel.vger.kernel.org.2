Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FD833AB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 06:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhCOFuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 01:50:35 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:48750 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229945AbhCOFuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:50:14 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12F5mssF018370;
        Sun, 14 Mar 2021 22:50:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=q+hLTUWRzh8NsKqp5pXnRDI46fGSLSCmuMbbFzVB4Y8=;
 b=VfHD52WbIeKX5VOpTNNB8QLgCHl1OH0nQySivUG4lDy76WEHRjEaJHSnaaM6bqsbrI3I
 5Wpo8v34XgVGQCjDwQhEitwco+D6CzPbDcQE/kNlgO/Xo546Yh3vRm3k8eXB/HT/SR5U
 IxqgrFlc2tGK+Bz1Lat7wP70smezhhPybErVXZv/+91GPsUk5Dz2tmHmRaFL1Tdlby2X
 zpGZIDYI1xYcuVhcXvqyboTcTJrBqU04elziFIx7+RakuEQbfUJYum0/4jIpNR5Ae8C+
 B8LaufXtnZ6avXN7yReswleyS2ivkIQhY2QurIoywMCXcsfossAdBircbxP23ki3vp0o Xw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 378sv2cuyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 14 Mar 2021 22:50:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ab3jGN406d5cWJ5xEcT/fo0+PqTdqfkHZTg2m6l6yJVsaCKRgLlC7S0m2Wo9yTjY7piE31kYRZGo9Pj8omjfioVlWPAIvqqeocdpKnzjIxvPVRpEQ+B1WsM3tq2aStBXe8TCanOEBmgKVynpFXbetsByFvejkS7nwizk4itIpwxjPCxqE/j2/0iCO6prvs4aR4AWhVo4b+7xCJg83/WDgzNIlhuf5YZiMCF1sXCQDZULxb5nrqu7QGMzHTkmWKQ8Zmf+VeNYSRVRiqwblQb5iOnlQF6Mz6SHnOI0Yz3UFFYaLdcbqvaPhofQq5qKm+do1ddI783YgLBb5mO7r9yicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+hLTUWRzh8NsKqp5pXnRDI46fGSLSCmuMbbFzVB4Y8=;
 b=Jvyostuwu5Jd+6P1SGvnkWXB32LATlzh8OZKxDSAs9YyNpuoalrTdYZuDH/oUpX7RYv77iw7sLHMeu/5Js14YRKFAPlSd4R0UKJ0n5YwTTTrAV7LVTC6f+S2nTu/o08khXW7MS5Tk0TGRIxZKoPeUEQWBlh/Ily4uslY2cxzRo/g9zleTJLzplV+vyb+EinYXjC+Oy6KKm9AUGjVsG6tHJ7WXz+/6DfhcGsqfzcb95rqaFoKQD6eojOiBEDrm6fYn8H5+ALmkGxxzfUmzs73ZOaNJqcMyfGlo5d5pgjecSLv0RbirwuyJCfSuU+meqlNWg/Og1Kxb3fwaw/flw6fhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+hLTUWRzh8NsKqp5pXnRDI46fGSLSCmuMbbFzVB4Y8=;
 b=YPDbQFDFT60aq3Wcj2T6tLOtPKCId89TOJ7o7c7pS01Pu/j635gxuhWtwq3/hnFq4b5oiKNbGpy44dtt2UPCaN0FKkRIM4nfp1zdEe9VXI09aRP2b4oTJqpDPZvF6GAD9B+tcGwx+hI7vlKLaAZsaWW6iydxwL9plJERkT9h4CU=
Received: from MN2PR07MB6160.namprd07.prod.outlook.com (2603:10b6:208:11d::30)
 by BLAPR07MB8258.namprd07.prod.outlook.com (2603:10b6:208:323::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 05:50:05 +0000
Received: from MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39]) by MN2PR07MB6160.namprd07.prod.outlook.com
 ([fe80::294b:4e83:24b:ce39%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 05:50:04 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: RE: [PATCH v6 03/13] phy: cadence: cadence-sierra: Create PHY only
 for "phy" or "link" sub-nodes
Thread-Topic: [PATCH v6 03/13] phy: cadence: cadence-sierra: Create PHY only
 for "phy" or "link" sub-nodes
Thread-Index: AQHXFcSDWYhUizFLY0OWp/kzgnrN0Kp/8pQg
Date:   Mon, 15 Mar 2021 05:50:04 +0000
Message-ID: <MN2PR07MB6160EAB28F3A60B2E7582672C56C9@MN2PR07MB6160.namprd07.prod.outlook.com>
References: <20210310154558.32078-1-kishon@ti.com>
 <20210310154558.32078-4-kishon@ti.com>
In-Reply-To: <20210310154558.32078-4-kishon@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy00ODA0NzkwMy04NTUyLTExZWItODU0Ny1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcNDgwNDc5MDQtODU1Mi0xMWViLTg1NDctYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIyMDUyIiB0PSIxMzI2MDI2MTAwMTczMzY2MjkiIGg9InMzNm83SWpTdG41UVl1L0RYOVBLNGxNWVI1QT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 021b08fc-aeb6-473b-fb82-08d8e7762ea9
x-ms-traffictypediagnostic: BLAPR07MB8258:
x-microsoft-antispam-prvs: <BLAPR07MB8258F0CC171EEF99234C155BC56C9@BLAPR07MB8258.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 095VjENZPGEVGzlTS7m+tOm03nFoAepdcFCxWwH2srq6xLx4Y4bws2RVf8XYteIeTn/+v0ZZH4bKIQZdfJxxLt4WX/wZnADDeK9E85Wq58Acuo+TiluejpNXOwDdqvgbiClD+mDaUsPdrvIJMMHjI8pCuJVu1LZ7XzlKgxUeHH1jF8lBgXvNkmfDfMEOipJ2F3UkpWxcwQ4Getj94xYd0RD1bgIOwrJFDA/wk3xLFk7dMu9AGTp8KTr8B5+SUutS26jjN0JAtnIBEy54aSLNujnmW3DzgGbyHE4Stdir1oyvTL8slOh7TQidESY+BcAMiZPKBZzCK0uxU5VKWg/Ki4b+JY+Dv8ngZZZkIAzmVYXczTYqTWwPxYoJdhwZ7BUH725B67lszFG0VGPsGiXM8RcK4sRzjI6M+dY7n9sqcW2z0gkn1ezDfg1u6Bf3rtIIz4rPy1hS0haSGvtzrv8OVJLw53FF7I7SMt/meQd6K1U6mTqCAIu02D8xvEuoR68RCy2n1sjVhU0K9KWvOpR686/8uenKY4zG3IAXZYZemlyuEqtk99nN1MQfEypv7STRp8XVzwuN0nqCAVKkWHfzr6d4kFF2yGFN+W5fnPJiVXli5jceMr9k4ZBZ/18YRqZV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR07MB6160.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(36092001)(66946007)(64756008)(66446008)(66556008)(66476007)(26005)(53546011)(33656002)(186003)(52536014)(71200400001)(5660300002)(6506007)(316002)(76116006)(8676002)(7696005)(8936002)(4326008)(478600001)(9686003)(55016002)(86362001)(54906003)(83380400001)(2906002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vqXclVZunbyJ4w0yKT6T59gHeJpKXPYepxTsdW9MtQBiUEa/UB6z2gd/BlRd?=
 =?us-ascii?Q?/iGAjLCps8ngvBtJyV1YV9Rfo3tBFmhv6QDc4TAIY2eUwbpRLDNv1W0cWZhU?=
 =?us-ascii?Q?s84ZfjaNmK8BbXrzyEBZRSBknojy7qqLbeEw9pDsZaUpN99grSAUsGRWjqNd?=
 =?us-ascii?Q?6plS3y6wCHtfc6LR3akyDmIktPLtM1GYi0Ciwtw82DrKl9cIpKeCZt1rTCJH?=
 =?us-ascii?Q?ZrGzcuVVoFIaCaSyVX0asOx9TrK8MAwVvGgKnPIHNnCij0RJ+sQSfqLkq6wZ?=
 =?us-ascii?Q?k04IRq5bVt6rDLEnDTmAHJjDl3q+gP1LXd6Ckb11rVasix6lroIp9yXnht0u?=
 =?us-ascii?Q?mVG6Tkef/w4DoiUPRUBIgF7RAqoF5w1Zd/gY5k82ENavsO+NNms/HbFQso2O?=
 =?us-ascii?Q?eZFl8JM9uFk77Q/LyRNsTZ6XYAQ1dviUqLxgTYdymRY8ERFWW4UHVtrVMXjk?=
 =?us-ascii?Q?0m1LIiAziG6R5ZlzfEdSki+VvUUr1uriXvXbYkfF/6/4bJycYgu3PYjJFS41?=
 =?us-ascii?Q?i/nImfqDku4qyFw7slUxD2FU5Yxm9y3U8aMbsXCAYwD+N+NKWG8UjFiOkww8?=
 =?us-ascii?Q?hqop4zX5N5LsrdGLs3FiIzzx/bfpEHGOHtUIab5juvr2B1JYKbNUAVveeNGQ?=
 =?us-ascii?Q?bJ8oYADlIfRLKBywW3Xuj4GYV8WjapwIPlhMiu2+S+TK9PJajptw/DwtCxHE?=
 =?us-ascii?Q?cVrpA1WAqJXiMjlzsr4TRn8p1DtkLI2I8a7/UDjmRd0Y8uY/lUqjCda9Yv6Y?=
 =?us-ascii?Q?fSEG5S5RGQnD8Nj+Wgs1hO+9k6yxVuUOf2OmGxkFrzUhu47Yq012w9+m9l0s?=
 =?us-ascii?Q?xvmMzO/MmYody846Lz1NwxXXIg0o/NwZwyoEfYvR+LsjLgQypuKJEoE83es+?=
 =?us-ascii?Q?9iP1tn9Ewy++20a/fb+YqsY+q12p3V5dTQDDsV/Og1UGPBndAwnHzJjp5Dqt?=
 =?us-ascii?Q?loKYdQXTo55vYdP80S91OCoBNjA0mfBesz8sJ2noqqaKtg9akOwUdAVUTJfD?=
 =?us-ascii?Q?a6QpUsstWKuJTHqJtZAnxl2T3WqNQDEq4lwFLfT5nWnjfAtseE9R24hczXAO?=
 =?us-ascii?Q?Mu99HFp5fShQifgFHOdTUex4NyNVz5tOx0H3uuSVYKeJu8xM4/HmN3N9gFtn?=
 =?us-ascii?Q?FiPVexH0bQDIMa5Ai4YyDjg7BVTxHcB1xyXqHo9Jtna3SUtVNpfK1TslrY3X?=
 =?us-ascii?Q?vS+EqKCTmPJ0iTFmxCp5OqjjQxAeYurrFLnZcbb2OAXTp7pHH9ACUW67o91V?=
 =?us-ascii?Q?n+/u3gG/0tCDt5VTfLwbGqjBHpyHXngx78D9vPGP3012v8GVf+LPThjXo/HP?=
 =?us-ascii?Q?GqPcwqsYphz2K5LOE5JcnwbY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR07MB6160.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021b08fc-aeb6-473b-fb82-08d8e7762ea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 05:50:04.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MaDot+hGj6Oq2yWwQNeMesBmjD3AQQw82qfZmc0O86jQphpXvrF3cPTlF9LTDNEfZ2gRq6mL+6cEK+Y+4oiertqrngzfmBxAKCz75DUCM8=
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
> Subject: [PATCH v6 03/13] phy: cadence: cadence-sierra: Create PHY only f=
or
> "phy" or "link" sub-nodes
>=20

Nitpick, subject line in all Sierra patches in the series could be uniform.
Maybe, phy: cadence: Sierra as per earlier commits.

Reviewed-by: Swapnil Jakhade <sjakhade@cadence.com>

Thanks & regards,
Swapnil

> EXTERNAL MAIL
>=20
>=20
> Cadence Sierra PHY driver registers PHY using devm_phy_create()
> for all sub-nodes of Sierra device tree node. However Sierra device
> tree node can have sub-nodes for the various clocks in addtion to the
> PHY. Use devm_phy_create() only for nodes with name "phy" (or "link"
> for old device tree) which represent the actual PHY.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c
> b/drivers/phy/cadence/phy-cadence-sierra.c
> index 19f32ae877b9..f7ba0ed416bc 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -577,6 +577,10 @@ static int cdns_sierra_phy_probe(struct
> platform_device *pdev)
>  	for_each_available_child_of_node(dn, child) {
>  		struct phy *gphy;
>=20
> +		if (!(of_node_name_eq(child, "phy") ||
> +		      of_node_name_eq(child, "link")))
> +			continue;
> +
>  		sp->phys[node].lnk_rst =3D
>  			of_reset_control_array_get_exclusive(child);
>=20
> --
> 2.17.1

