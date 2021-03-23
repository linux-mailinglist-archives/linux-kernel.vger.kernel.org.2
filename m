Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6FC346702
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhCWR5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:57:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54820 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbhCWR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:56:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NHsgBw017899;
        Tue, 23 Mar 2021 17:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=CQPQm/c8t+S+bUMtYHAmM4ttsrP0eQikBXYZmjhRVWo=;
 b=iQ0CPZuDb+0Q72vaBm6+wHtxh4mYIGTWtGJBl7EZmZt+VIJlDFZLTNZ2bfq67vglB3ma
 JNRyY722YSZjVTe6tXtMbdLVjYvoGxsYgafh+os5Cz/uPenZ6eCJ0HypALUFtUsf5Hxb
 Qltphi8F4267a9aoamZ/t1WakYMM8wTtoFegPJbYHqpsQ/b5T4fiSgLP/n4WSkDZOhQf
 WNb0ORBKvRgl0qBsLpAdJeNr+NNQV9Z/YitXqgDJrB16b50JSS7gkeY5uC/QNqxOl+kS
 nieXQAUI1yTRY5yM+gDO3UcZ0EFU51Op6/3PVH9Dt1GPCUHjYj698D+cE2SG4PvxL+8m NQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37d8fr8312-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 17:56:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12NHoANU099095;
        Tue, 23 Mar 2021 17:56:15 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3020.oracle.com with ESMTP id 37dtts976m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Mar 2021 17:56:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efNB0SFAktaDb9W1Xy528/upRrQ55dC+q26yvxiHHAyBTOTilvQnJlR6qYLja+FCX4kOrp9gGhqnjgsvKWKVFX8r0zmt4NUlOOKIk6eSlbZQhcoYVWb8cW8Yb1BlPpv4Um4ywqIh8IruW25aWsQ2OCfYRNrZG4NQP/SHLGjFqDGE3VszWsQGIew5HVG3fVtqUlBxRETdm4ntUGaMK4xKxTNqLMfjlSF/LwShXY8gHaVcLLXhnmYmVwcsWNt49AhMxE4jajLLHJDkD46czvdJRQRT5MSDB5MOCS/nkml1gpC8+lD01Ez2sHYYsEf9BeNUpXCC40B+j3SDRcjjgwJdfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQPQm/c8t+S+bUMtYHAmM4ttsrP0eQikBXYZmjhRVWo=;
 b=FW1DoN4Cg2do/DlIFbrWK8OlI7UkOPG3jSNyOdxOE6WIotg1qT31iN4l7JgkqYhGzHqKqMzOnVdXaAjyxHfLc13Eq7DkIgEaiFNc/k8ueLqu+XFUWK1aFJymv3fndHkNlpXSuOIorTLZGrPviQOJPLXF+mSe81YLihBlSHMhe7k+MvjihORgdYeP0onhgYWub/4oP+l/9kT2SnJVlJJQKOpyYCr5wN6O6ZLHSMvVIaaZZfWyQ19sfOwm6wm6JiQsIfFLIp/W52WQBVlqCEFVYxof4tGj0mw82i2VpGa46cIRjeph/WlnZ7NoNILEZp1f8Gqv06iP3rEJbCj1YRXR+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQPQm/c8t+S+bUMtYHAmM4ttsrP0eQikBXYZmjhRVWo=;
 b=rUGdrbkZq44eXBVUzBsdTFmHiPOiNJj43be4gFPKfAhr6po4u2fyzJoiuRnFkvKwj1iiXcrHbl6lZ5MsYrPSkzSHU/vzvnd5hNCixqq9o/VNlkfkXAthyxa5QxUFMiBvXR3PU9i313NuRuhjA/do4raVmXPS45sdFxAgzr9wrU8=
Received: from BYAPR10MB3270.namprd10.prod.outlook.com (2603:10b6:a03:159::25)
 by SJ0PR10MB4575.namprd10.prod.outlook.com (2603:10b6:a03:2da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 17:56:13 +0000
Received: from BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::9ceb:27f9:6598:8782]) by BYAPR10MB3270.namprd10.prod.outlook.com
 ([fe80::9ceb:27f9:6598:8782%5]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 17:56:13 +0000
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "soc@kernel.org" <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Robin Murphy <robin.murphy@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: keystone: fix integer overflow warning
Thread-Topic: [PATCH] ARM: keystone: fix integer overflow warning
Thread-Index: AQHXIA3QtV60SgMwyESQrTqBJcDToA==
Date:   Tue, 23 Mar 2021 17:56:13 +0000
Message-ID: <B995B0A0-165D-47CA-A766-3110D6C0DD60@oracle.com>
References: <20210323131814.2751750-1-arnd@kernel.org>
In-Reply-To: <20210323131814.2751750-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [69.181.241.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f421ad9-bd25-413a-a386-08d8ee24f303
x-ms-traffictypediagnostic: SJ0PR10MB4575:
x-microsoft-antispam-prvs: <SJ0PR10MB45753DB5365FBE15D93ABE7793649@SJ0PR10MB4575.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVq1bzyqs2kt2H5PCXcLjSPQN3WusuRim2FAdxQiBDvqY2RGkanaL935l2vhO44L1Xa2xUygisj+ttVY0EOnqNKbaiixaS62dlB5S/J4LnMYW/1xfjJw7YuNjvwckWg6bq/+5UgzgAnAYkh9NU6bny8l/pQNEzoLDIiooxLwcsHV6OsX9dDSfqVmDZukrPJ9UUfWjR7eByM84X2YuQCYApWmQu56UiIHDZcxH+7X4k5PQIdaOnug/Qt/MGyNfxw4E9GmjSlb8nFrcTtOFGJBgQI99vy0DJHJG1KqF7CbfUC4Ian8unZe9cql4KRYhF0E3QEGdvToe390TU+O8knF09hohiRs862aydezXmapMHw8vyKjefbKSEbdLzjl/igTy6tLU0XvpEWd+4GmWT10rBbC3ZuE3ZAV8N2TnB67X8nUNa1wvzK1iNvlqkjs0qT11ASkDwsX/dZL/yCmm6hzQASak2dKSv1QnAIuryiEIEf5l4fTJmj2pZsF2kDqq+8WMD58ovsvHO9BfLmNb9tY55SsE0TcYotXcyYztf+PbjpojnNVa8qrNiL0Da7sxR0/dqp1SB18y9DxQdZAq9Nenkmwik0ipbppOzP5fjMHN9qnlI76yQ10z50Dnn/wVbCpIG2ZvnhHZ/cxx5mP/z9Gvy9Fakt1q+zkvmfmHgqsJcc3Wbu4mtw4LFFiaqBj5Vu0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(2906002)(66476007)(66446008)(53546011)(316002)(5660300002)(76116006)(38100700001)(6486002)(478600001)(66556008)(6512007)(44832011)(64756008)(86362001)(66946007)(4744005)(6506007)(7416002)(54906003)(4326008)(8936002)(186003)(26005)(36756003)(71200400001)(2616005)(33656002)(8676002)(6916009)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UVBTSnpBVm1QMUVDNktSdnB0RHN2ak1YQkRLTlVFL0ljSUFCQXRPUnRjdG41?=
 =?utf-8?B?V1lEV05ONG12U3JmUU9Ed0FJR0xVWkJzb2tGVTBvSnJTSXRTcGFZZTlGTXFu?=
 =?utf-8?B?a3d2cGlKYW1TeHVuMGdyR29CdVVPRmJBcStIYkI0bkNXL3VkcE1UcG5jRFh6?=
 =?utf-8?B?ZnFmaGduQXJhSDd0KzcwUmlWQkIrQVJsdFhabXFvZ21qeG55L3laWlNIZUV4?=
 =?utf-8?B?S0UyNE9SZHVVaGkzUG8rTzVwcmFib29tbVY4ekpqNktvVTVYUjZERkpLS2Ex?=
 =?utf-8?B?UUttZUM0dWtNeFhWVWh6cmxRSEVqNEY2TnRkdkd3U2duSzltOHFkLzVraGJS?=
 =?utf-8?B?TnJGbER2S1JNL3RsRU1lN1lTOUNjUFJnWmZQbjA2ZWFnSXlDZmNiOVIvN1pJ?=
 =?utf-8?B?UGFmWDNFZFRwWXYySndqdllyS3o5YUJQY2x6VnRoS1J0aXpWWGtsdEt1UFFB?=
 =?utf-8?B?OTFENGVvYlVIdys2cy9ZY1RjVlpINFFyTkJEbGg5ZWExRi8vNmdqQ3VJVmZD?=
 =?utf-8?B?ZnNGMFNpWTNVNE5VUXBDbDR6Y1grZTVLU21jbUxJaW5nTU5FUFdSa3dldERZ?=
 =?utf-8?B?S0NnSkZUOGtSU2JoNjlpbmFKTmVsdUV5Ym83YVNIVmlNRk1hdWoyMWNEQzA2?=
 =?utf-8?B?aGdjVUIrL2JHc1B3MVRISi9yK2RndFUrWkV6SVFrQzdMTW1ZNy9pN1l0UVNP?=
 =?utf-8?B?dW1vRTQrTHkxaWZXRUZ6aEdUc281WDgwWjV5UW05d2ZHS0hUTE95Qmh1WVR3?=
 =?utf-8?B?Z29iTEZYVy9wVTI4WWpjVHV3azF6Y2x1QmM0OC9EN3VoR1JsQk5BMk5mVTRR?=
 =?utf-8?B?VXV4dWsyRFV5VXIwZmVPRmozUG8rMDBIckdYWmNRWGNwRDRFTk1EbEg1TlEv?=
 =?utf-8?B?SUNZSnVwRnV6QnVETDlKQ21mUHJjamtVNHpUWWxpWUluZDI0V09mWVNYcVJU?=
 =?utf-8?B?aWNRM2xpc1pkRCt5dGFGZktHN0wrM1JYeTZZdm5aWEkyUE1Db1BhOUhSZ2N4?=
 =?utf-8?B?bUdOb2dxZGk1b09Rd080WFYzbHlDaHpySCtCZHNkZmFKdE5yOGVBZ0xGcGxY?=
 =?utf-8?B?U1pOU1dML1hZc1JVNG1SSEJOOU8rNTRvR0hHTkFQRjY0LzF3a211TFBWYUgz?=
 =?utf-8?B?NVFtVEl4V1BXLzJ1Ni9nYThucjVlY2ZnTzZySWY3SVZuNE9NMDhWUUtWT2Fs?=
 =?utf-8?B?UkhzK0NuNGk3dW1VbXVxYU9UTytNWGNFMm5OWFZkTTVIY2RjMmhxdGx2Slcx?=
 =?utf-8?B?dXdqNGRNVUw4eUl6SVJaWWJJRis2eGxORWoraUVKREw1a1oyOXd1MlNXdjdY?=
 =?utf-8?B?RHZYejd6d3F3OWhTSHlqWm52R0JzSHNlSE90RTBhOWtPZXg4alEvaVZ1dnpH?=
 =?utf-8?B?NW1oNlhKdFQ5Y1MxTzY5MkI2S0kzV25iczV5SEJieU0xRFl0OXdkV1hXZ0VC?=
 =?utf-8?B?WUovUWxMd21aS2k5WkZ0QnhEcG9DZUxyZkh0d2NSeFpqdmJaTHJqdzJDREVu?=
 =?utf-8?B?alBXSUhackFweDA0SEl0enBDZ1VFY3lVbEZkbHRRaFppMHhVVFVOUEhEWTk4?=
 =?utf-8?B?MC81NFhCeC9VbFJHOUtmb0RmV3dpMXRpd3JESFR2c3J1YThsUHpuQ3NxSjlk?=
 =?utf-8?B?NFRJb2NYSURUV0x0b0lLSno2aXVIb1YyNlNuYUJ2SWFRcjlrZElZODZseFdj?=
 =?utf-8?B?MjhCM3htd0cwYUlWS1hrYTlzRVdqQkFYUlpaTnJ3ckJjcXQzVUhFTlVIQ1JQ?=
 =?utf-8?B?ZDZXbzZFL3krNnlnMmYzd0pENHlCSTNXTnhwMTFYUkFMcDMrNGs2ZllDR0to?=
 =?utf-8?B?YXg0dHpybGhQS3Brd1RPZz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <753C3C2D1BDD7A41964E9C80E4FEDEE7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f421ad9-bd25-413a-a386-08d8ee24f303
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 17:56:13.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rU0mTgLv6RlXDybtK57wF6n41ajZ707za7oljXkR7lMsjegtdJ/FzYAKP+WJbDnWEjiuo/SH7cOrNxF9XlAJwgck06ZOY7PCMrSEVWZyCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4575
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230131
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9932 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103230131
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTWFyIDIzLCAyMDIxLCBhdCA2OjE4IEFNLCBBcm5kIEJlcmdtYW5uIDxhcm5kQGtl
cm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5k
ZT4NCj4gDQo+IGNsYW5nIHdhcm5zIGFib3V0IGFuIGltcG9zc2libGUgY29uZGl0aW9uIHdoZW4g
YnVpbGRpbmcgd2l0aCAzMi1iaXQNCj4gcGh5c19hZGRyX3Q6DQo+IA0KPiBhcmNoL2FybS9tYWNo
LWtleXN0b25lL2tleXN0b25lLmM6Nzk6MTY6IGVycm9yOiByZXN1bHQgb2YgY29tcGFyaXNvbiBv
ZiBjb25zdGFudCA1MTUzOTYwNzU1MSB3aXRoIGV4cHJlc3Npb24gb2YgdHlwZSAncGh5c19hZGRy
X3QnIChha2EgJ3Vuc2lnbmVkIGludCcpIGlzIGFsd2F5cyBmYWxzZSBbLVdlcnJvciwtV3RhdXRv
bG9naWNhbC1jb25zdGFudC1vdXQtb2YtcmFuZ2UtY29tcGFyZV0NCj4gICAgICAgICAgICBtZW1f
ZW5kICAgPiBLRVlTVE9ORV9ISUdIX1BIWVNfRU5EKSB7DQo+ICAgICAgICAgICAgfn5+fn5+fiAg
IF4gfn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiBhcmNoL2FybS9tYWNoLWtleXN0b25lL2tleXN0
b25lLmM6Nzg6MTY6IGVycm9yOiByZXN1bHQgb2YgY29tcGFyaXNvbiBvZiBjb25zdGFudCAzNDM1
OTczODM2OCB3aXRoIGV4cHJlc3Npb24gb2YgdHlwZSAncGh5c19hZGRyX3QnIChha2EgJ3Vuc2ln
bmVkIGludCcpIGlzIGFsd2F5cyB0cnVlIFstV2Vycm9yLC1XdGF1dG9sb2dpY2FsLWNvbnN0YW50
LW91dC1vZi1yYW5nZS1jb21wYXJlXQ0KPiAgICAgICAgaWYgKG1lbV9zdGFydCA8IEtFWVNUT05F
X0hJR0hfUEhZU19TVEFSVCB8fA0KPiAgICAgICAgICAgIH5+fn5+fn5+fiBeIH5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fg0KPiANCj4gQ2hhbmdlIHRoZSB0ZW1wb3JhcnkgdmFyaWFibGUgdG8gYSBm
aXhlZC1zaXplIHU2NCB0byBhdm9pZCB0aGUgd2FybmluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IOKAlA0KDQpMb29rcyBmaW5lIHRvIG1l
Lg0KDQpBY2tlZC1ieTogU2FudG9zaCBTaGlsaW1rYXIgPHNzYW50b3NoQGtlcm5lbC5vcmc+DQoN
Cg==
