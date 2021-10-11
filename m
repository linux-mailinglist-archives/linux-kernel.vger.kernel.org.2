Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B477542870F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 08:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbhJKGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 02:52:49 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34714 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233148AbhJKGwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 02:52:44 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19B55hqk013078;
        Sun, 10 Oct 2021 23:50:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=wvwhvktZ4oUvg2xNLcn7P07o6pFEXt0Z+P3ayPIJuw8=;
 b=PM6HlXRLUDrwtDII2sSMudRYxmuxyI85sggL78tRxUX1E6n8LF4K1vVmts9lzxtSKync
 50U3fhMvpBFzw2xxkUE/ISAQZLFu9gZvkVFYJlZqzqrth/+Qwt9xUfeoTnwtvHwKxnVH
 58KbbR2qPhm4gcmGkEjodx3R5jJzOSbhkofMvr5cLqSFl6/ofcLPXVXsW2PtkJkYMVRS
 F4WRQ20hW+eQB3Bv9TFVabaNdSdwcdhI4T1JVQB/h6IO7sw0uD4C7mUFjQW6j25Vxmlb
 ohVgKcHO6PChzCuFnNYuXpTOcWpzcvdNw0HG57F6H6mNieaQ7Bwnpia44oMZQ8787VG3 Ng== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3bkwk5tas2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Oct 2021 23:50:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVBQhS5rbiO1DNJ5SwyaRP4r9t5UyxGQFfmO2wqM1LufboQeb3NB6HXprlQqT/RSYlUAMbomtgGTFiXcDA52rmRNHHYYPTj51tdzqNvEGSWF/TQeN0dV3lDC+aTGTDLiog9mn4WGl3O2gkEWOgLiGSCO2UsD4tSOioY/7REaRvc24bdd5OeOejlPGkWvaqhytC1c6zHI425A0dUzegLI+KYEbJ43DJFrGwp/S7sZ/YQQOGBKpH6Xq8amjT20hgKnpseEaHGlgWke+Wdh+dPrvM2AyeVvhg1FghUiMIMt0CiQmiIZgP55hZa8RU9qVDN86wnY5uAWZ1UPqEreogXmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvwhvktZ4oUvg2xNLcn7P07o6pFEXt0Z+P3ayPIJuw8=;
 b=TsTySAfOQMbBxK8Juv7R/qjx46speDE43fpyGxp7dH8Cb4KWEyZP0XXWJgMuCWVafL0fgnvpTx/SBMge/XXVZuS1UhTdyV52DHjtuNIcmyUX0xLn5TCQtcC+vvzCJRvEdy6NGFEnVtbG8TSxtHm0VRYUBa2OAp/kbK0aeor/M3RlC7tyCFbzohLsHv/3POHfUJg8YxhGpHPvf5BXhxN0nugeYgiphhPcw1PgJo/Ij12ywnw7TzhOCk2emTwGf6EjI3dIoxXxgM8hD3GZAmP6gkPoQ+rtiGK9esQEWhw0JwHXhmBzt8V8X/nVmpzWaRjgI3M3Wn8wtDz3bm4TfKR96A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvwhvktZ4oUvg2xNLcn7P07o6pFEXt0Z+P3ayPIJuw8=;
 b=e+vpf4XLQRB4alw3K7hBJcBKv9Oos8eGHcb8RqOppGOXy2RpdOksc4Ws7LfZ4LcC9NTrF1HVcS6turnySeo3vVMkse7sxdy6xKCHAF3Z2/RxyJtipzfUM9gvOyurI0CelJAL2KbFCuHEutXIjzP5MREfyGlaA/UnsOUupqQjb/U=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB5370.namprd07.prod.outlook.com (2603:10b6:5:45::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Mon, 11 Oct
 2021 06:50:30 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::e453:f454:9058:598e]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::e453:f454:9058:598e%6]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 06:50:30 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Aswath Govindraju <a-govindraju@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Milind Parab <mparab@cadence.com>,
        "lokeshvutla@ti.com" <lokeshvutla@ti.com>
Subject: RE: [PATCH v2 00/15] PHY: Add support for multilink configurations in
 Cadence Sierra PHY driver
Thread-Topic: [PATCH v2 00/15] PHY: Add support for multilink configurations
 in Cadence Sierra PHY driver
Thread-Index: AQHXpK0vf/++FvVsJ0eafISJtjn/3aulPymAgChPEMA=
Date:   Mon, 11 Oct 2021 06:50:30 +0000
Message-ID: <DM6PR07MB6154EFBCCAB7ED1BEACAE1CEC5B59@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
 <23a8f4d9-3467-1cf5-eec7-a4d33fe03458@ti.com>
In-Reply-To: <23a8f4d9-3467-1cf5-eec7-a4d33fe03458@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04MmNhYjk3OS0yYTVmLTExZWMtODU4NC1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcODJjYWI5N2ItMmE1Zi0xMWVjLTg1ODQtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSIzMDk2IiB0PSIxMzI3ODQwODYyNTYzNDUxMDQiIGg9ImdEVXBKN1J6Q3kydjlXclRkQVFYK2tONGFlUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d1c8177-4b0f-474a-d26e-08d98c836a81
x-ms-traffictypediagnostic: DM6PR07MB5370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB5370DF380CA31B20647B4B33C5B59@DM6PR07MB5370.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dU/eyxUUiHla2BdxbGnqJQpyJ5fx7JgtH0p6bCJMVTtTs4pFBBOEih8M6dDslcd2KTWh3G/vAN/EJ/Te5khoMkuMpCWtej+pVdMKh2nPXiQsJCYqzSuUBUN/sRO8/iy9siukEpAURuTl7zAWZgMVts6TKWbR7bUtj5opNT7stiFtpj9zMuZBHmJAUeIzDfZVNKKu/ZMu7Abt24jvnKqGhH5PgoHsHiQP9s0ncNvkspw4IAxoLqa12Cv1j4NquallArZBSZrRLX7F6gj3f7fzSvv14GpzbL9QeaK/eMXWU1HOFnUxpfATw+GbZIIjHjecPO0bHljn4WztWqjknREm4cEWgvFUQVqSvzO8T1Ez1ftkgjMJBwezZrMhS3Vb6MGOFEIWSZcIIMRi6WjusMhSU2TCg8IGSz2VsL+YauueKyrGCtE1uj6ZZkooc/EORBVuw61NNvCnuatQ+P1xj7zTvkNnSiMb7bxWnb6U7l6FTfiUs7eSrwsoNyyvRQFbVzMSyoGbURjoRdk+8i6+Shc9/1epVQqTu2dwHbGwi7VYu71cg9x3dw2YWUpMkwRwf17e4iQBQWJDoN0By1ENAAWlLugp5+cMRJWMqqeodJMYWtlOLi7jlHAklxql2wL0AGXb4iTyPLXg2U/qEBSEiRKl85ZWrzU8PLhDIjRJHSVvIuvqHZzgXV1uw8/JR/CZBLMA6/Q8hKwzYuXUOCGjANAXi01ZyBC8dx/7WzIQ+Ke+zUBeA+JY1hEb+Au2fjDs2rNg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(6506007)(53546011)(5660300002)(66446008)(64756008)(66556008)(38070700005)(66476007)(110136005)(66946007)(54906003)(2906002)(508600001)(71200400001)(26005)(38100700002)(316002)(76116006)(55016002)(9686003)(186003)(86362001)(7696005)(8676002)(52536014)(122000001)(4326008)(8936002)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3pRMEdEYi85MkxERXBIaFRyM1d3WU5wckJldEMzTFpFeEREdVNJV2xLRldv?=
 =?utf-8?B?TktyR3orNnJBQnBJNCtXWnh3YUE3T0g1U3JTSlRLamNvMFIxZm1VbVI4ampm?=
 =?utf-8?B?cnl3dExiN1VRZTJJNjRhTXQ3Z1JaSEREd2kvWEF1RTFRdlQzNGRsTmZpUm0r?=
 =?utf-8?B?cTcxNHlsWTVhSG5kRlNXWUc1ak8wQ1VvbHRIa0tGN1Exd3FSZmlRcDBrb1ZQ?=
 =?utf-8?B?OEhxMkYzdUxZc2o5ai9oSStoT0dBZzZ5ZERGOXg2NTBSM3dJYzdjTnplaUlk?=
 =?utf-8?B?bmJoSTZLazJPZkhIOGwwdGFGVjk2Z3k3d0UxU0w3Ym5mZk1NL1YwQnM3T1ZX?=
 =?utf-8?B?a3Y0NWhFRGFYazZiQXhNUHoySHdHUjhxS2lpK1hXVWtJRVphdGNDeUdSYXY3?=
 =?utf-8?B?VHJVaWphZnI4OWNOQ1h2RDU1cUFEMXIvS2lPZnplVmxXWWJFRzhpWGJqQ3p0?=
 =?utf-8?B?cGxzcFNqVzFLd3ZUK3BmVTAzRXlxWi85cnhEUzFkRkRQUTF1c3RYSi9ZZWRV?=
 =?utf-8?B?R0E1QmhJQkRQaGJOYlFvSW0yQ0tkVTlvS2tlM3BKdm9aMm9wY0pOVW03SWxD?=
 =?utf-8?B?elFkOTM2NHlOZVNuMVZUL3paWld0akVjM1dMdW1GckFSL1BxOGYyMGJNcWpo?=
 =?utf-8?B?NWhVOEk3WEY1cU1jNXZUMGtFQ2tDNHdqdC90NDRyZS9ZN1YwOWIzTHloTjc3?=
 =?utf-8?B?SEtaWm5LMTFqNVVKbG5kTTB0RWZyemhmT3dwTzM5L291c0hFUk5YVDlERWNt?=
 =?utf-8?B?VzlnMG95c3dXZTVSVkVLdFF5RDl3V3V1RTU1dW9CaDVZQ3c2UTI1YkFyUWF5?=
 =?utf-8?B?SDFadUNRSkhiTWN6bHMyQWxIQTJ5VWk1YVM0dDUwQkRaZ2VTd1lES3F2ZXEw?=
 =?utf-8?B?OSt2VXVyYUJDR0tzYVYvTEErM0xwdUNKR3NQSXhIWTNLM0E0eWJ6SDByUXB5?=
 =?utf-8?B?djhHcVh1ZVFDNFl5L3BxUnFzLyt1cnBKbGhWZ0JDZVgvSkJQTkhrejFRdzRL?=
 =?utf-8?B?WS94bno1VVh6emlrUEg2TXJHdENEcWxJclc0WElsSUhBOHFpdTdtbnF1dUs0?=
 =?utf-8?B?cGNuclJIRXZ4SVJDT0lESlNhcTA2TnV2dURTVjVpbVorNWxCdXA2MWE5K3Z2?=
 =?utf-8?B?blZjbTVmUlNBdVdZczdjOThiRjNsbll0WnhiNk4wZVVET2ppWmJwMHErZGUr?=
 =?utf-8?B?b2N0azhrVldML285S2gyZ1lwbllJK0FTeXRkQkIwMTR4VDhkQWwwV3MxQTlR?=
 =?utf-8?B?eGI3eXZxQWJrb3B1SXowdlBNVGxVbGVOZUorckp6cEtpWjlyWGtpQzFaRkRH?=
 =?utf-8?B?ZDFxMFZrT1RQU1dsd084cVlscExQOUVvWWJValZFWVdWVEVkanFqWTRsNzh5?=
 =?utf-8?B?SVhsOENOMGhpMGlVbCt2Y1RjVGZCb3h6UGltT1NWNkxWWXBBa3J4SUQvR0xR?=
 =?utf-8?B?dXluayttUFNPQm9YR0VmVEppNC84ejM3N3lhY0M1VXJYUHNxNWNobFZDUGVG?=
 =?utf-8?B?OENZTmo5WjF3OTV4YnFpN1RQTGoxZmViTFBVMmJ1blYvWmxEdUlTd0w3Q2pl?=
 =?utf-8?B?U0dzMlBOTEhVMHlXazdNaUNQMlQxY3g2eEowVHdoMW1MVGJnb2o5OG9MN3VZ?=
 =?utf-8?B?SnZDVkF3QldxdkxaNWpBWjRqMitoUlU3MXZubkZ5cEV6N1dtdU5QVXpJb09p?=
 =?utf-8?B?Q1Z1ZFJWRy9tTHJlTTVJZjdXNHJXak9OSnJNZGtKNzAwQUVWTWZmd01QeVNk?=
 =?utf-8?Q?5iGYw80Kzssf+WHMuOZ6ArZDxx85OU5Juc479Bq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1c8177-4b0f-474a-d26e-08d98c836a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 06:50:30.4133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoVhT3IJA4d/GAn4L7Ni2g9krurubC+sjMXi1DMnSng1NirkwXDmZEWyVPrWnisrNjGtO6QLlXr9b9z4qxW3A3SsJLNUx4ymrL9tG1dj+rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5370
X-Proofpoint-GUID: _23ybT7zjvRqF1B-osKhsoiMLW_L0HS1
X-Proofpoint-ORIG-GUID: _23ybT7zjvRqF1B-osKhsoiMLW_L0HS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-11_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlub2QsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXN3YXRo
IEdvdmluZHJhanUgPGEtZ292aW5kcmFqdUB0aS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2Vw
dGVtYmVyIDE1LCAyMDIxIDg6NDQgUE0NCj4gVG86IFN3YXBuaWwgS2FzaGluYXRoIEpha2hhZGUg
PHNqYWtoYWRlQGNhZGVuY2UuY29tPjsNCj4gdmtvdWxAa2VybmVsLm9yZzsga2lzaG9uQHRpLmNv
bTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC1w
aHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiBNaWxpbmQgUGFyYWIgPG1wYXJhYkBj
YWRlbmNlLmNvbT47IGxva2VzaHZ1dGxhQHRpLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDAwLzE1XSBQSFk6IEFkZCBzdXBwb3J0IGZvciBtdWx0aWxpbmsgY29uZmlndXJhdGlvbnMNCj4g
aW4gQ2FkZW5jZSBTaWVycmEgUEhZIGRyaXZlcg0KPiANCj4gRVhURVJOQUwgTUFJTA0KPiANCj4g
DQo+IA0KPiBPbiAwOC8wOS8yMSA1OjU5IHBtLCBTd2FwbmlsIEpha2hhZGUgd3JvdGU6DQo+ID4g
Q2FkZW5jZSBTaWVycmEgUEhZIGlzIGEgbXVsdGlwcm90b2NvbCBQSFkgc3VwcG9ydGluZyBkaWZm
ZXJlbnQNCj4gPiBtdWx0aWxpbmsgUEhZIGNvbmZpZ3VyYXRpb25zLiBUaGlzIHBhdGNoIHNlcmll
cyBleHRlbmRzIGZ1bmN0aW9uYWxpdHkNCj4gPiBvZiBTaWVycmEgUEhZIGRyaXZlciBieSBhZGRp
bmcgZmVhdHVyZXMgbGlrZSBzdXBwb3J0IGZvciBtdWx0aWxpbmsNCj4gPiBtdWx0aXByb3RvY29s
IGNvbmZpZ3VyYXRpb25zLCBkZXJpdmVkIHJlZmVyZW5jZSBjbG9jayBldGMuDQo+ID4NCj4gPiBU
aGUgY2hhbmdlcyBoYXZlIGJlZW4gdmFsaWRhdGVkIG9uIFRJIEo3MjFFIHBsYXRmb3JtLg0KPiA+
DQo+ID4gVmVyc2lvbiBIaXN0b3J5Og0KPiA+DQo+ID4gdjI6DQo+ID4gICAgLSBBZGRlZCBhIG5l
dyBwYXRjaCAzLzE1IHRvIHJlbmFtZSB0aGUgU1NDIG1hY3JvcyBmb3IgZHQtYmluZGluZ3MNCj4g
PiAgICAgIHRvIHVzZSBnZW5lcmljIG5hbWVzLiBUaGVzZSBtYWNyb3MgYXJlIG5vdCB5ZXQgdXNl
ZCBpbiBhbnkgRFRTIGZpbGUuDQo+ID4NCj4gPiBTd2FwbmlsIEpha2hhZGUgKDE1KToNCj4gPiAg
IHBoeTogY2FkZW5jZTogU2llcnJhOiBVc2Ugb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgdG8g
Z2V0IGRyaXZlcg0KPiA+ICAgICBkYXRhDQo+ID4gICBwaHk6IGNhZGVuY2U6IFNpZXJyYTogUHJl
cGFyZSBkcml2ZXIgdG8gYWRkIHN1cHBvcnQgZm9yIG11bHRpbGluaw0KPiA+ICAgICBjb25maWd1
cmF0aW9ucw0KPiA+ICAgZHQtYmluZGluZ3M6IHBoeTogY2FkZW5jZS10b3JyZW50OiBSZW5hbWUg
U1NDIG1hY3JvcyB0byB1c2UgZ2VuZXJpYw0KPiA+ICAgICBuYW1lcw0KPiA+ICAgZHQtYmluZGlu
Z3M6IHBoeTogY2FkZW5jZS1zaWVycmE6IEFkZCBiaW5kaW5nIHRvIHNwZWNpZnkgU1NDIG1vZGUN
Cj4gPiAgIHBoeTogY2FkZW5jZTogU2llcnJhOiBBZGQgc3VwcG9ydCB0byBnZXQgU1NDIHR5cGUg
ZnJvbSBkZXZpY2UgdHJlZQ0KPiA+ICAgcGh5OiBjYWRlbmNlOiBTaWVycmE6IFJlbmFtZSBzb21l
IHJlZ21hcCB2YXJpYWJsZXMgdG8gYmUgaW4gc3luYyB3aXRoDQo+ID4gICAgIFNpZXJyYSBkb2N1
bWVudGF0aW9uDQo+ID4gICBwaHk6IGNhZGVuY2U6IFNpZXJyYTogQWRkIFBIWSBQQ1MgY29tbW9u
IHJlZ2lzdGVyIGNvbmZpZ3VyYXRpb25zDQo+ID4gICBwaHk6IGNhZGVuY2U6IFNpZXJyYTogQ2hl
Y2sgY21uX3JlYWR5IGFzc2VydGlvbiBkdXJpbmcgUEhZIHBvd2VyIG9uDQo+ID4gICBwaHk6IGNh
ZGVuY2U6IFNpZXJyYTogQ2hlY2sgUElQRSBtb2RlIFBIWSBzdGF0dXMgdG8gYmUgcmVhZHkgZm9y
DQo+ID4gICAgIG9wZXJhdGlvbg0KPiA+ICAgcGh5OiBjYWRlbmNlOiBTaWVycmE6IFVwZGF0ZSBz
aW5nbGUgbGluayBQQ0llIHJlZ2lzdGVyIGNvbmZpZ3VyYXRpb24NCj4gPiAgIHBoeTogY2FkZW5j
ZTogU2llcnJhOiBGaXggdG8gZ2V0IGNvcnJlY3QgcGFyZW50IGZvciBtdXggY2xvY2tzDQo+ID4g
ICBwaHk6IGNhZGVuY2U6IFNpZXJyYTogQWRkIHN1cHBvcnQgZm9yIFBIWSBtdWx0aWxpbmsgY29u
ZmlndXJhdGlvbnMNCj4gPiAgIHBoeTogY2FkZW5jZTogU2llcnJhOiBBZGQgUENJZSArIFFTR01J
SSBQSFkgbXVsdGlsaW5rIGNvbmZpZ3VyYXRpb24NCj4gPiAgIGR0LWJpbmRpbmdzOiBwaHk6IGNh
ZGVuY2Utc2llcnJhOiBBZGQgY2xvY2sgSUQgZm9yIGRlcml2ZWQgcmVmZXJlbmNlDQo+ID4gICAg
IGNsb2NrDQo+ID4gICBwaHk6IGNhZGVuY2U6IFNpZXJyYTogQWRkIHN1cHBvcnQgZm9yIGRlcml2
ZWQgcmVmZXJlbmNlIGNsb2NrIG91dHB1dA0KPiA+DQo+IA0KPiBmb3IgdGhlIGNvbXBsZXRlIHNl
cmllcywNCj4gDQo+IFJldmlld2VkLWJ5OiBBc3dhdGggR292aW5kcmFqdSA8YS1nb3ZpbmRyYWp1
QHRpLmNvbT4NCj4gDQo+IFRoYW5rcywNCj4gQXN3YXRoDQo+IA0KDQpDb3VsZCB5b3UgcGxlYXNl
IGNvbnNpZGVyIG1lcmdpbmcgdGhpcyBzZXJpZXMgaWYgbG9va3Mgb2theS4NCg0KVGhhbmtzICYg
cmVnYXJkcywNClN3YXBuaWwNCg0KPiA+ICAuLi4vYmluZGluZ3MvcGh5L3BoeS1jYWRlbmNlLXNp
ZXJyYS55YW1sICAgICAgfCAgICA5ICsNCj4gPiAgLi4uL2JpbmRpbmdzL3BoeS9waHktY2FkZW5j
ZS10b3JyZW50LnlhbWwgICAgIHwgICAgNCArLQ0KPiA+ICBkcml2ZXJzL3BoeS9jYWRlbmNlL3Bo
eS1jYWRlbmNlLXNpZXJyYS5jICAgICAgfCAxMjk5ICsrKysrKysrKysrKysrKy0tDQo+ID4gIGlu
Y2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1jYWRlbmNlLmggICAgICAgICB8ICAgIDkgKy0NCj4g
PiAgNCBmaWxlcyBjaGFuZ2VkLCAxMjI2IGluc2VydGlvbnMoKyksIDk1IGRlbGV0aW9ucygtKQ0K
PiA+DQoNCg==
