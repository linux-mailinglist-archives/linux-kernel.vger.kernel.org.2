Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2C316536
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhBJL2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:28:25 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:9080 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231166AbhBJLTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:19:44 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ABGajG026283;
        Wed, 10 Feb 2021 06:18:46 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-00128a01.pphosted.com with ESMTP id 36hrd9b67x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 06:18:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A01+AFd8Q8NQzivheWv7J+I0CawM77oT4ksfhAoKUDJ3bBQSXeDGIplFUWfQGs2X6iuH2fQFAJxocwSlAQjjm+rc1BtuuiwsISuQ4dj/lzEvFJ8WE/TDRkVTZpm6VC+1SnOIpiPOwqDoWjzLS25aFJDkAewEj6C/+JOHhYKXiaNdx1WSTCbgZwtKjrSDgiZZzSQ1nOSXvX5tZvnHbkr/YP1+WHeoO1AYoiK+p6h61VlBJUiFK3WsLURziSJV2Fk2jvCF1eToXKaY/rEnNowuA7UqqvNJOhT6m6/x1WS4pqu0egGWCb2KShTIQ1XJhkcqkqPKu1XxoVfSbP4ao9YV1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGASZDQA45K+3xX88owDvhKixGzbIVaLMlxKw3OCe1A=;
 b=QpO4Kf1ZiquTM1n1TCs/GRe0caYDJPGbTSQ4I29Wvbu2SGu74Y845XnT9rulY1UcquChekIIOaOPGoxRmvzsCfeQtFmP5oSbOcOtUCB9e4ZGnFP3R+dEFTRZVoKtyn4zpUz2YN2RlryKF+6EOQ078p27qqftanDSTXYKQiASdqbrHoIDkPRKkO5+1zcaGKquwpjDF1Fu3aQtT4oMwHk99U3hCFerS6OSRn0oeJnJTq0u8HibRKV7X51UmKTrhK9OWxz1nNC72R+KaKPkr/HaMnh7EW1DkmqDOv07Px4xFpHanikZ4xngylRHfy/5u1RgQKOlMf5aHqq7vtrBcHRFdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGASZDQA45K+3xX88owDvhKixGzbIVaLMlxKw3OCe1A=;
 b=s1Jz7/Pefepr1G5snKkYK2q1p2JfZAtgVV96qMGTFkNwdMYrFX/ZoLXh6hyBkGMEcg4aCpD4pbLf650pPu1E8HSZ7gVlX4q3qTrKH07z1/HCu79aQOJvpIWY2negdUaIN3BWIjtQychKP4YkbCu3Iv9/ffIWRZcU0izgE2UGeGc=
Received: from MWHPR03MB2960.namprd03.prod.outlook.com (2603:10b6:300:11a::22)
 by CO1PR03MB5748.namprd03.prod.outlook.com (2603:10b6:303:6d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Wed, 10 Feb
 2021 11:18:45 +0000
Received: from MWHPR03MB2960.namprd03.prod.outlook.com
 ([fe80::fce7:227c:e274:ed27]) by MWHPR03MB2960.namprd03.prod.outlook.com
 ([fe80::fce7:227c:e274:ed27%8]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 11:18:45 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Subject: RE: [PATCH] MAINTAINERS: replace my with email with replacements
Thread-Topic: [PATCH] MAINTAINERS: replace my with email with replacements
Thread-Index: AQHW/5u66QpB1vNkOUyxtJ8I+XegRapRPVig
Date:   Wed, 10 Feb 2021 11:18:45 +0000
Message-ID: <MWHPR03MB296083364621F04F851D4DA88E8D9@MWHPR03MB2960.namprd03.prod.outlook.com>
References: <20210210110116.49955-1-alexandru.ardelean@analog.com>
In-Reply-To: <20210210110116.49955-1-alexandru.ardelean@analog.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcmlc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy1iYjUzNWNiNi02YjkxLTExZWItOTBlYy00ODg5?=
 =?us-ascii?Q?ZTc3Y2RkZWZcYW1lLXRlc3RcYmI1MzVjYjgtNmI5MS0xMWViLTkwZWMtNDg4?=
 =?us-ascii?Q?OWU3N2NkZGVmYm9keS50eHQiIHN6PSIxNzgxIiB0PSIxMzI1NzQyOTUyMzIy?=
 =?us-ascii?Q?OTQzMTYiIGg9IkNZUHIxNXFhc0lvbU0rc0tJMTJNcTJsT2dKZz0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUlZREFB?=
 =?us-ascii?Q?Q3NMYXQ5bnYvV0FUcXMyMjc1ZjhZN09xemJidmwveGpzRkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUFXQXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBUmJyd1hnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJoQUhJ?=
 =?us-ascii?Q?QWFRQmhBRjhBWkFCcEFHTUFkQUJwQUc4QWJnQmhBSElBZVFCZkFIUUFhUUJs?=
 =?us-ascii?Q?QUhJQU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHRUFjZ0JwQUdFQVh3QmtBR2tB?=
 =?us-ascii?Q?WXdCMEFHa0Fid0J1QUdFQWNnQjVBRjhBZEFCcEFHVUFjZ0F5QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: analog.com; dkim=none (message not signed)
 header.d=none;analog.com; dmarc=none action=none header.from=analog.com;
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eaceb92f-7cc0-4460-1f23-08d8cdb5a163
x-ms-traffictypediagnostic: CO1PR03MB5748:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR03MB57489EFF09A2BFDF74E0890F8E8D9@CO1PR03MB5748.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yezcd8vPWhRrTiIHMXT1V9H6oL1k1CiD/aemrRO4TxTudwrgudxVWtLK3Ut0cD3HBlQcTKEWdbENUV4J3ZlS8igH3jbFAnMLYSPh+4fSNeQxFKBBTBnTfavaGDHTb74PHPOXCMkgNJXbsebWvmNJNdq9Q27y5xRjy1pyD98oTIffTB9MgtimCiIw0Qzv73eP6vnigc746eS4b6oxJ/32Q//9UZG5gFxo92Ats1tB4RGUcOYKvPAFzo8b8npYRiYhZ6ikWxnPgO22g332zal4CDM5Y1uyavVKIl7WcwgaV+wZf7NdbGClMugjanEITGg+Qr41zL/pamnnsb+c1VBo4k+1u4RnmS5+tFWjDOUWQFFiaTPOd2CQ2lSjVEHAj9Wbk1s9gKYAIFNHqFX/D0JgE6N8WKcLl3Ow5VBFBOrZrrmG9lPIihFAgLMaf2OpsH3vwErfUVf6WG+RJEXDjVdBP5l+4aV1mQK2hi1SuE9T1hkApBNN+15EetqpnERQMosx7w6VYYE0N7hKguxmSMMa9yqnxPgCjvqOmCmVNW+3UrY/kB9TxKv7ktCE6R7xkfEoVIB+V8iKpXkLkTgzZb/K0W5fMENYwy5Hf+85CUVzk9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR03MB2960.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(6506007)(53546011)(52536014)(110136005)(9686003)(8936002)(107886003)(186003)(26005)(55016002)(8676002)(83380400001)(66446008)(478600001)(64756008)(71200400001)(316002)(66946007)(76116006)(2906002)(66556008)(7696005)(33656002)(86362001)(4326008)(54906003)(66476007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GkJa1RSeUcyzbgOG5T57Oj7y+xxr3HGnmEt2Gxnk+Bc1ZFq/McLr+xgP+Yhr?=
 =?us-ascii?Q?V15H+g8HAIgb0ZMXPMcp3HT8LSS/Dd69gNX3vOfrKctn9pXTt+E31lN0rFSi?=
 =?us-ascii?Q?LitEDkSsDKtIFBiPNe1mac4so2SCGbyV9XK3LrIqVnF+/oSZrmo9qEB1E1kT?=
 =?us-ascii?Q?VLGz1XHe7ksVp5YQShfukNsmJFfbzCm1kb9beAlK1bGvWkt9xfNxP1l66KH0?=
 =?us-ascii?Q?BS3ci7mmZi04Zm4WY9VUdehHguU2RtMzb37Jz3CiCXXSYAbz72W7cWMESXfo?=
 =?us-ascii?Q?K7we5a4oFqNFUypJnuc9hn4AXngbaG+fQ0QDshbGjsLAOnT3TyyS8z1wOut0?=
 =?us-ascii?Q?GUZi2ZRy3OHW8zT22yb2WVuu9qyZPX2bwmhvE/an7nKC3TpoDfFyv42hug0W?=
 =?us-ascii?Q?4jMi6Hb53REN7dX45g4vdZResiuH25K8jBKiPN9c84fuOnn47oJ6HE+YSZm2?=
 =?us-ascii?Q?zWES+hFWRqwQN2rMvgLGyLGyGuJTcuyd5aFxXjfC7IRlzRubYLiAJJkz2ly2?=
 =?us-ascii?Q?zOp1dFDqd1v/eG89IAOJkMyt+BbIp5Ajh6UoYjFpNy37EoKJPuM7ppuLVXqg?=
 =?us-ascii?Q?cxYOWZA91Ap/VRPHiUGFRplGFIMtJUM0/BxPZjHtOm+yc484I33RKunTsVUA?=
 =?us-ascii?Q?fxNcDdWVTeHTd50MAGclQc+ZcC5NnVAQR4dDDyQs8tpFiu7XLAIJ6hUpw1I9?=
 =?us-ascii?Q?KYzRS9P+GkV6Rqa0Sy2URlJrQUkGUljs8k7+DBLvfJtQeclmLKut1SRcNYU0?=
 =?us-ascii?Q?YisRtS9seUNdCj087VeE+IntwUJEdsiPP5/+0LZfAIOSjcqM4LfwvCWVeX52?=
 =?us-ascii?Q?C+pCrV9cKUBoY8JqqrJaKLBBHFd9RILByHEH9Bzp+1/hy16a46JQzduG/n+H?=
 =?us-ascii?Q?TBcpd9xbCl6g1G7iGbCkWlG9Yrph4DlSy2r4ZEV95Af55hS3kQxjZPU5ZpKV?=
 =?us-ascii?Q?X5hm9SoKZ4IFl+uB/DOHcWKOuMeadKiJ2N2sroEMVJ6VjEcD1V+inFsjgs8w?=
 =?us-ascii?Q?GPOv5ROQHpZdMYvMEEt/QoqlVqNs1NAfqaONe9Y6e4O485u4OgDOzckPEUoH?=
 =?us-ascii?Q?EVsPqF5/neTsIINetlZYFlWdcy5eYP1wt5yWTmWYFcISEYuHsAksErTRmLVy?=
 =?us-ascii?Q?gViOpkLAE/KJuJvjl754w/4fP4LZAMPs5M1RuqGEabGUBvlVYb8kOrMScayv?=
 =?us-ascii?Q?8UcipGoha+sDoojKaUJefWW4pWx+DqwHY0B9jy1u75gU0FwG0gWqa/sHnRqW?=
 =?us-ascii?Q?DruTo/63Mvqpw/x+UM5ixlWgNcIfJ8QwLiVx2oe8/QkqZgGTPv6eMRzBeQLt?=
 =?us-ascii?Q?3yne+qTaF6cSxNRJ7ZOk4BU8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR03MB2960.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaceb92f-7cc0-4460-1f23-08d8cdb5a163
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 11:18:45.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2IQ/kMelzZgtu+jfCm6TCUmC4fDdca+dGxjyVb11kzGX3slR6wGLotzyT1cdHu+hV07jp2s4xjumQSbQYozWLuFTkeKdx5pXuiPiA+Nq78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5748
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-10_03:2021-02-10,2021-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 adultscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102100111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Sent: Mittwoch, 10. Februar 2021 12:01
> To: linux-kernel@vger.kernel.org
> Cc: gregkh@linuxfoundation.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Ardelean, Alexandru <alexandru.Ardelean@analog.com>
> Subject: [PATCH] MAINTAINERS: replace my with email with replacements
>=20
> This email will become inactive in a few weeks.
> This change removes it from the MAINTAINERS file and adds the people that
> will be responsible for the parts moving forward.
>=20
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e697044d34d6..97a91fd7948d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1016,7 +1016,7 @@ F:
> 	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
>  F:	drivers/mux/adgs1408.c
>=20
>  ANALOG DEVICES INC ADIN DRIVER
> -M:	Alexandru Ardelean <alexaundru.ardelean@analog.com>
> +M:	Michael Hennerich <michael.hennerich@analog.com>
>  L:	netdev@vger.kernel.org
>  S:	Supported
>  W:	http://ez.analog.com/community/linux-device-drivers
> @@ -1024,7 +1024,7 @@ F:
> 	Documentation/devicetree/bindings/net/adi,adin.yaml
>  F:	drivers/net/phy/adin.c
>=20
>  ANALOG DEVICES INC ADIS DRIVER LIBRARY
> -M:	Alexandru Ardelean <alexandru.ardelean@analog.com>
> +M:	Nuno Sa <nuno.sa@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  F:	drivers/iio/imu/adis.c
> --
> 2.17.1

