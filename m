Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C901327A18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 09:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbhCAIzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 03:55:16 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:28158 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233588AbhCAIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 03:51:13 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1218kZq0009357;
        Mon, 1 Mar 2021 00:49:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=fzxbMgyz3oZwI/IwhIVQFzueCnYmzFXAA2wnJz8XD3c=;
 b=lszyRd4IyYk+58gfPubvCMYes6SKiTeWO2SByN9ygY6Y7+ArdSyayVrkD3JGWdOGKI6g
 lpjW3kyUmpp1FOVDTMgghJASg/vq4LjNU4Yl5MFoNeqcsmklKTxGL/jelMPZ7n3NI3di
 5ZREiYkm1ToS2IxlDTC18pvtmRyXBrNLfvoPB+e68PtHhUuIxWVE5O+iWkecCM8d2TqE
 nlqZODuJIvgOYCLw7+gIUGMaGrZxVwm/ZHvpm0kqCLXZN4VIj4pIA2nMcsj8PZPhqUF0
 /k4xVrpamPpfysHgzN1szoRi43Um9cXGNx7ZyBYCxKKAhv6yotyDgREidEP+i+NdMe8o gA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36ykh1mbf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 00:49:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XpkJXgmCMuV9jv5Z7oHNjkV6yhOstJg3/8Le/QeyiLmlEf+sUd7vxxeyFRhg37+Ox1798qAM0lIIHj4lT8yidPAxCHidT86UMuoh2SrkLNoi/zgN1kQNaZQsKNJFXKR0hdrPZIiFJLo7EiqJ5SSBkNXzbDy/JOj1sjmcPC9EFh/a8OQkuL561dPHog6h1lsXlDqvKEzZyleEn4vrZ2jc72RY8C1D0GuSaGGgs+q5e3k4bd2jo4ALJCQlEl0zNFMsvdR8X1WKNr5M/4gd9M/yUrdPkcE5AjV+j6NmaGIjgYjIvlZjdnl+P69p10v4YiFpAvoIc6dGJ2a7eyYF3xwvyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzxbMgyz3oZwI/IwhIVQFzueCnYmzFXAA2wnJz8XD3c=;
 b=WMLTNBAdrYThULJ4iDSiWErHll+oE5+MBRthY52eh6EeAb0fbfRhGGgpI+on3PM9M8KgJY8vtAAJjgp0C9821mYSpQSs0EIjZvgrRQzSz9iYaHZZt2wmrxmeXI3ROuBDw2BgCvoCOoHE4C1s5h85V7pCArVKJsmSsIS/eVS2sepjB7bjNXYTLvj2XshRItiMNtalqvUecfS5UzBhRv16BB9f783fj5cf3+qgEbpJ9jW3KflEdQyh+B9l6XDGrJOA+jHgr3HRiKyFzhUsOB+QWHch7yHJQ7x63Wzvc2Lc+SbHEBqrBsH2+8P4b5P9e+QgXsf0LlEySc3ObPsZxchejw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzxbMgyz3oZwI/IwhIVQFzueCnYmzFXAA2wnJz8XD3c=;
 b=K+Fu9I8HXAWhRJq6IObHxHGssvsh8GPR82I4D2LT+1UA01nx6praV1Jq9XzkuyjLY2uPOD/Hwn82dGh4/qL4VYm02gmTlUutzECyoqXgbFbKY3WhbLpTi0a7SmsWh7oYZsVvNYTTpOtF2I4Rn2IwVnBxNI9RQcl/GMgcZuwmDgc=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM6PR07MB4875.namprd07.prod.outlook.com (2603:10b6:5:9b::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Mon, 1 Mar 2021 08:49:41 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 08:49:40 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Robert Foss <robert.foss@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "nikhil.nd@ti.com" <nikhil.nd@ti.com>,
        "kishon@ti.com" <kishon@ti.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Thread-Topic: [PATCH 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Thread-Index: AQHXDFqp3mrwSdsNCEq5dY4w2h5itqpqokWAgAQ0coA=
Date:   Mon, 1 Mar 2021 08:49:40 +0000
Message-ID: <DM5PR07MB3196D92300EDCB16E8F2F724C19A9@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1614356086-19745-1-git-send-email-pthombar@cadence.com>
 <1614356118-21409-1-git-send-email-pthombar@cadence.com>
 <CAG3jFysryArs1DD3pgQAqO8AaW_+OH_Jpb4=o7uc93jaXFKF0Q@mail.gmail.com>
In-Reply-To: <CAG3jFysryArs1DD3pgQAqO8AaW_+OH_Jpb4=o7uc93jaXFKF0Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0wZDcwNjk2Yy03YTZiLTExZWItODYyZC0wMGUwNGIzNmI1YjFcYW1lLXRlc3RcMGQ3MDY5NmUtN2E2Yi0xMWViLTg2MmQtMDBlMDRiMzZiNWIxYm9keS50eHQiIHN6PSIzNjM2IiB0PSIxMzI1OTA2MjE3ODEwNTM5NDAiIGg9IkQ2Ris0Qjg2a3IyYzRLa1hLMU9wSGVOdG1FUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47446adc-9c67-4478-a20a-08d8dc8ef3f9
x-ms-traffictypediagnostic: DM6PR07MB4875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB48754C7C5D945C9C9DFD3C5DC19A9@DM6PR07MB4875.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMFRha9KdtN+5OrdMP1PinJyCToIvMAH11wIjydG+B9MvtRc66vhzB+bA1N42ZE8QPx/O9inW1GdtK7Fn3T5tny8Ej9BDYJxJnfHzWeMvFOr6fYGNtcy0xnyE2/KgoE/shqI/LPubSUPADSp/YVJvKMZLYPIso4B+XpJ1/WFJ9W+FvE5RviCf5A3nW9h1YpE2FQ3XWTE5hRyQyLmuCkHzpzvloqxy//6f0Li+qZOhOz1PNDMUVgC1mkmSqW7mnrlC7R5Ou1Xb/SIGb2TRn3+PfY+U5kahbrxV6fqxTJO5YoHPEu5aa5vhadJ7/vCC5fxh6zCQ4HPJV8v58kkzZH3YRLquzlO/EXimd/CMfh8yxodbdJg5RbPjSUNt4EUHr6a+bR8eX81W8Bo3nNKgNB7Xnmyf1A6SwZxYRUv2UFn5t3gsx39i9K7HSMvF5M1xhFVuPYMPtN0sAnCad449zUUxxcSGghExDt2mmLiqc/BQFAO9xB+7uP+hSLdyDuhv3eoz7HOmbb3UjXhilLD5is4QSTCDKSGzsrwfQhOTqxNbn7SuJpMmV606qTvWW4yN9uf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(36092001)(55016002)(2906002)(71200400001)(83380400001)(52536014)(33656002)(66946007)(54906003)(66476007)(316002)(86362001)(5660300002)(107886003)(7416002)(66446008)(64756008)(9686003)(76116006)(66556008)(8676002)(186003)(8936002)(4326008)(6506007)(7696005)(478600001)(26005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Z3A0SHFRNWdraHFZT3U4UUdmNkI1VW5Ucm9NQ1RjemZWMi9ZazFaazQ1aVQ5?=
 =?utf-8?B?dlNsQ050eG9LZ2dNNjV4WkZ4WTIxVk1xcnVTeVBTRm1QN3QreG1jZTl5Qzkw?=
 =?utf-8?B?ZGRSejMxTXRzKzMyQ3B1SzE2ZE1QVmptSkJLSEcxbmJDK213ZWFBaUN2Qklp?=
 =?utf-8?B?NFlPbSsxd0s1S1QvZXp3Q3dUNnduVlR3MW1RQ3VOcGtRck5YSk1lSFA3NTN1?=
 =?utf-8?B?dDF3UkV1VnpkTk9VL3UzYWZtUXNLcitzejI1TEliVFFuZXJqYnV6cnRZUVZp?=
 =?utf-8?B?MnljZjNORkVBVG9EUVBHbFpXRzM3eFEzZTBCT2NlSGhHM1UvNllId3BvZjFS?=
 =?utf-8?B?WFo3N1p6YTBqUk9ybHFKdWZKcmk1WnVZYlcwWUJlMkVnbER5RXQ4ZXNPdCtH?=
 =?utf-8?B?Rm5PV1h4ZjV6b3E0UjVQbkZiSjk5TXVzU2V0UFFFOGw5QTFseG5rVXVrMnhC?=
 =?utf-8?B?cXh2Zm5GNzgzU2c3cGxhWUo2QnA1c1cxbzhaOEQ4ZElYQ3hBMHB4ZWxCK1M0?=
 =?utf-8?B?US9vT291bjAwUzF1cWtRZVQ2UVJySWRzTlY2VnNLYWxmN3dRUU9xNUg3cVRP?=
 =?utf-8?B?YlZuRDFsN2x6TnVBMTZ0dHEvN240TjRpM3FlbDRmanNuQkpZVTY4a25WR21H?=
 =?utf-8?B?UHdYWEZaa1pVSXJubzQrMkJVYWpjVGpwYkwwS01CdEpwY3RKSkMyVTB0T0Fa?=
 =?utf-8?B?V0VOaXVFcjA1V3JVb1JHc0hMdGo3WFB1NjUwVmRNWVBocE5kWjd2SHJFNWVW?=
 =?utf-8?B?QmxQTVpTNzFaL1poWi84RTVmVE9vZTRGUUkwNUFvZlFqS1R4UHFRNkJXZk5y?=
 =?utf-8?B?Q3hZeHFESkE5Z3B4Y1IweVp2QXNjQ0M2d0xjeTd6QlIrbS9TTHhvMmN6ejZx?=
 =?utf-8?B?b0dINmUrYmpYYWlESWJKbVBpc1h0bGk0UmZ5NTgyZUhjVUdBTklLM1JKQlZW?=
 =?utf-8?B?UmV6a3NLZ1A1UFEwOThZMS9JR2l1amYyTm9aRHlmZU5nT3poSXVET2RFaVQr?=
 =?utf-8?B?R3YzNzFYcjRsUVJqSjYwVEpHUWF2cTAzanJCY2FZQWlGMmxGTU5rLzdpUlNN?=
 =?utf-8?B?VVF2U3lHRWxMcDgzS2ZQeThQcWY0R3ZBYlJVS20vWVI0bkIrMlRycFZtcXUv?=
 =?utf-8?B?ZEYrd09wdUpWY0gwZ2M0VlI2L3hQd3JFNzBNSUhnY0t3bjc1ekdRMWxwNk1X?=
 =?utf-8?B?Q3AxenAyeENRY2ExUzRXeDc5Y3N2blpLZ3BsWkNEWnYrQWN6WU55Q3VjUEFF?=
 =?utf-8?B?QzExUXFyMlZnN2RtZWhjL05uU0Z1Y1Z6aWdib2xlSDN0UVdjNWd5WlBqbzJN?=
 =?utf-8?B?alpXSHhDbWZxQ3o3Z1poRnM1Y0JBWm9oZ1BtOGZjOUFOOFpPWTZOaGpzcG9X?=
 =?utf-8?B?Um1Dd3NKMW9GYnlhN1ppamVKR2Fiek5sbTZTZDdoM21CRU85ajVOVUpmQlU0?=
 =?utf-8?B?RmdpSzM3bWdCVEJlMmovamhqV1BPNldwcDZKZERIWFJlMmZyeGlON3NqUjZ1?=
 =?utf-8?B?SHV5a1lma1hKRTllU0RaQW5Hdm80aU1RaGlpTjBFNFkrakQ2NUVFY05NS0JO?=
 =?utf-8?B?UlJWc292WENTSDh1M3FRNXloclEwVHc1WlN3d2c2S050NU5VZHhXK2Y2cWlY?=
 =?utf-8?B?dEtyNXJrcC83dW9SRzVOMXpKbUhCRUxRWURVVEVONXNHQ2hwR1pmUEllME9Y?=
 =?utf-8?B?citWaGtrclU3Rm8zV3JNRFhRNlVRSjF1MlY3TFlrb0dIUHhTQTNOTGlEUUZ2?=
 =?utf-8?Q?WVztBsXVc+QkbBJpzW3/y5cmWbBkeJl32VBw+mf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3196.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47446adc-9c67-4478-a20a-08d8dc8ef3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 08:49:40.8505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MQ7py4pttpuxLGT98gdZyFeSyRLWka9R3cD8Johcp7mHj13UQOA0acr5b8r+yuUhBlbV3Kgrf2ZgXoZ/DLTQN/GBt0og60dnNMTHg2qSu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_02:2021-02-26,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iZXJ0LA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGNvbW1lbnRzLg0KSSB3aWxsIGZp
eCB0aGlzIGluIG5leHQgdmVyc2lvbiBvZiBwYXRjaCBzZXQuDQoNClJlZ2FyZHMsDQpQYXJzaHVy
YW0gVGhvbWJhcmUNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUm9iZXJ0
IEZvc3MgPHJvYmVydC5mb3NzQGxpbmFyby5vcmc+DQo+U2VudDogRnJpZGF5LCBGZWJydWFyeSAy
NiwgMjAyMSAxMDowNiBQTQ0KPlRvOiBQYXJzaHVyYW0gUmFqdSBUaG9tYmFyZSA8cHRob21iYXJA
Y2FkZW5jZS5jb20+DQo+Q2M6IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBMYXVy
ZW50IFBpbmNoYXJ0DQo+PGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT47IERhdmlk
IEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT47IERhbmllbA0KPlZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPjsgZHJpLWRldmVsIDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnPjsgb3Blbg0K
Pmxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVEIERFVklDRSBUUkVFIEJJTkRJTkdTDQo+
PGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsIDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsNCj5BbmRyemVqIEhhamRhIDxhLmhhamRhQHNhbXN1bmcuY29tPjsg
TmVpbCBBcm1zdHJvbmcNCj48bmFybXN0cm9uZ0BiYXlsaWJyZS5jb20+OyBuaWtoaWwubmRAdGku
Y29tOyBraXNob25AdGkuY29tOyBTd2FwbmlsDQo+S2FzaGluYXRoIEpha2hhZGUgPHNqYWtoYWRl
QGNhZGVuY2UuY29tPjsgTWlsaW5kIFBhcmFiDQo+PG1wYXJhYkBjYWRlbmNlLmNvbT4NCj5TdWJq
ZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IGRybS9icmlkZ2U6IE1IRFA4NTQ2IGJy
aWRnZSBiaW5kaW5nDQo+Y2hhbmdlcyBmb3IgSERDUA0KPg0KPkVYVEVSTkFMIE1BSUwNCj4NCj4N
Cj5IZXkgUGFyc2h1cmFtLA0KPg0KPlRoYW5rcyBmb3Igc3VibWl0dGluZyB0aGlzLg0KPg0KPlRo
aXMgc2VyaWVzIHJlYmFzZWQgb24gdXBzdHJlYW0tZHJtLW1pc2MvZm9yLWxpbnV4LW5leHQgZmFp
bHMgZHQNCj5iaW5kaW5nIHZlcmlmaWNhdGlvbi4NCj4kIG1ha2UgZHRfYmluZGluZ19jaGVjaw0K
PkRUX1NDSEVNQV9GSUxFUz1Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxh
eS9icmlkZ2UvY2RucyxtaA0KPmRwODU0Ni55YW1sDQo+DQo+DQo+T24gRnJpLCAyNiBGZWIgMjAy
MSBhdCAxNzoxOCwgUGFyc2h1cmFtIFRob21iYXJlIDxwdGhvbWJhckBjYWRlbmNlLmNvbT4NCj53
cm90ZToNCj4+DQo+PiBBZGQgYmluZGluZyBjaGFuZ2VzIGZvciBIRENQIGluIHRoZSBNSERQODU0
NiBEUEkvRFAgYnJpZGdlIGJpbmRpbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogUGFyc2h1cmFt
IFRob21iYXJlIDxwdGhvbWJhckBjYWRlbmNlLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi9kaXNwbGF5
L2JyaWRnZS9jZG5zLG1oZHA4NTQ2LnlhbWwgICAgICAgICB8IDIwICsrKysrKysrKysrKystLS0t
LS0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0DQo+YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
ZGlzcGxheS9icmlkZ2UvY2RucyxtaGRwODU0Ni55YW1sDQo+Yi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZGlzcGxheS9icmlkZ2UvY2RucyxtaGRwODU0Ni55YW1sDQo+PiBpbmRl
eCA2MzQyNzg3ODcxNWUuLjg5YjRiZjc4M2M1MyAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L2JyaWRnZS9jZG5zLG1oZHA4NTQ2LnlhbWwN
Cj4+ICsrKw0KPmIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvYnJp
ZGdlL2NkbnMsbWhkcDg1NDYueWFtbA0KPj4gQEAgLTE4LDcgKzE4LDcgQEAgcHJvcGVydGllczoN
Cj4+DQo+PiAgICByZWc6DQo+PiAgICAgIG1pbkl0ZW1zOiAxDQo+PiAtICAgIG1heEl0ZW1zOiAy
DQo+PiArICAgIG1heEl0ZW1zOiAzDQo+PiAgICAgIGl0ZW1zOg0KPj4gICAgICAgIC0gZGVzY3Jp
cHRpb246DQo+PiAgICAgICAgICAgIFJlZ2lzdGVyIGJsb2NrIG9mIG1oZHB0eCBhcGIgcmVnaXN0
ZXJzIHVwIHRvIFBIWSBtYXBwZWQgYXJlYQ0KPihBVVhfQ09ORklHX1ApLg0KPj4gQEAgLTI2LDEz
ICsyNiwxNiBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgICAgICAgICBpbmNsdWRlZCBpbiB0aGUgYXNz
b2NpYXRlZCBQSFkuDQo+PiAgICAgICAgLSBkZXNjcmlwdGlvbjoNCj4+ICAgICAgICAgICAgUmVn
aXN0ZXIgYmxvY2sgZm9yIERTU19FRFAwX0lOVEdfQ0ZHX1ZQIHJlZ2lzdGVycyBpbiBjYXNlIG9m
IFRJIEo3DQo+U29Dcy4NCj4+ICsgICAgICAtIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgICAgICBS
ZWdpc3RlciBibG9jayBvZiBtaGRwdHggc2FwYiByZWdpc3RlcnMuDQo+Pg0KPj4gICAgcmVnLW5h
bWVzOg0KPj4gICAgICBtaW5JdGVtczogMQ0KPj4gLSAgICBtYXhJdGVtczogMg0KPj4gKyAgICBt
YXhJdGVtczogMw0KPj4gICAgICBpdGVtczoNCj4+ICAgICAgICAtIGNvbnN0OiBtaGRwdHgNCj4+
ICAgICAgICAtIGNvbnN0OiBqNzIxZS1pbnRnDQo+PiArICAgICAgLSBjb25zdDogbWhkcHR4LXNh
cGINCj4NCj5UaGUgcmVnICYgcmVnLW5hbWVzIGNoYW5nZXMgYXBwZWFyIHRvIGJlIGludHJvZHVj
aW5nIHRoZSBmYWlsdXJlLg0KPg0KPj4NCj4+ICAgIGNsb2NrczoNCj4+ICAgICAgbWF4SXRlbXM6
IDENCj4+IEBAIC01Myw2ICs1NiwxMSBAQCBwcm9wZXJ0aWVzOg0KPj4gICAgcG93ZXItZG9tYWlu
czoNCj4+ICAgICAgbWF4SXRlbXM6IDENCj4+DQo+PiArICBoZGNwLWNvbmZpZzoNCj4+ICsgICAg
bWF4SXRlbXM6IDENCj4+ICsgICAgZGVzY3JpcHRpb246DQo+PiArICAgICAgSERDUCB2ZXJzaW9u
IHN1cHBvcnRlZC4gQml0IFswXTpIRENQMi4yIFsxXTpIRENQMS40Lg0KPj4gKw0KPj4gICAgaW50
ZXJydXB0czoNCj4+ICAgICAgbWF4SXRlbXM6IDENCj4+DQo+PiBAQCAtOTgsMTUgKzEwNiwxNSBA
QCBhbGxPZjoNCj4+ICAgICAgdGhlbjoNCj4+ICAgICAgICBwcm9wZXJ0aWVzOg0KPj4gICAgICAg
ICAgcmVnOg0KPj4gLSAgICAgICAgICBtaW5JdGVtczogMg0KPj4gKyAgICAgICAgICBtaW5JdGVt
czogMw0KPj4gICAgICAgICAgcmVnLW5hbWVzOg0KPj4gLSAgICAgICAgICBtaW5JdGVtczogMg0K
Pj4gKyAgICAgICAgICBtaW5JdGVtczogMw0KPj4gICAgICBlbHNlOg0KPj4gICAgICAgIHByb3Bl
cnRpZXM6DQo+PiAgICAgICAgICByZWc6DQo+PiAtICAgICAgICAgIG1heEl0ZW1zOiAxDQo+PiAr
ICAgICAgICAgIG1heEl0ZW1zOiAyDQo+PiAgICAgICAgICByZWctbmFtZXM6DQo+PiAtICAgICAg
ICAgIG1heEl0ZW1zOiAxDQo+PiArICAgICAgICAgIG1heEl0ZW1zOiAyDQo+Pg0KPj4gIHJlcXVp
cmVkOg0KPj4gICAgLSBjb21wYXRpYmxlDQo+PiAtLQ0KPj4gMi4yNS4xDQo+Pg0K
