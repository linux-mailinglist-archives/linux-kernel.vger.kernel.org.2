Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7433D391F06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 20:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbhEZS1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 14:27:42 -0400
Received: from mail-eopbgr1410132.outbound.protection.outlook.com ([40.107.141.132]:34688
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232262AbhEZS1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 14:27:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR+7N1RbUAH/jOsstqWISba8TOmnToakkfV/YzSEDg0cbxDRYF4HTLDfNdaTyncwfsndRF9W4kvwq2W2E0+m37dYVi7ZqPdmg9BM4ce4EpMnupkxz89jtJfNp3T2duEL8Yz05xboIxl0iMcHM/XsIuMKOFwUTHj0d3WwZOuYF9yCxy9Rn6XQKDjwyE+878o5c3ReV4pNHfWDS4l0qKQvx+TrmDJwKfYketUBGPQRA3vVLPmht6jLZiaTVIe4YIdbDeRmwyqk62H48syb2UCV6tK2YgWZmmLMMVC0n1CsgLOwapqS1XDfY4ZVm51G+Fe7uBlP0qVmqwugwWKly/e3tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPqeRUz19FGDaKGdq/ZS9oUXjbfyii25n4ZRCWtDFcQ=;
 b=miTalUmiRkNoaJwZhD+0z5RoucInDBLH3XgMQnAJN2tKghWDu1CSxhhAsDDOs9bKR73kRo0TBcO5CwUNDtwksyGJ9t+e+yp9fszYd6Sapajav6jRSwUX6ENlU1bgMGy4qOfDSiueVO+vvruVZVqXxbyu1mUk9FASk6MQCkzJeqgIuD61p5bxwfBbJchDGwT2ItZOvE0i83crj9WqmXSpCfN+p5QvrGmFzOSLT9xykZ3Gdu7/yKRUq8h30QpUvRoJRhsvZA9XMKLhS7U+NN93a6nmSd0ksXHmbpSoDz1a5D9krc1maA2HaGRsgITS5AC8JSfh8i1OKzAecg3g3ChDYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPqeRUz19FGDaKGdq/ZS9oUXjbfyii25n4ZRCWtDFcQ=;
 b=kLXCXrivracRIyNJox4jhAGrCveWbuYiRfp0Ls6jgTV8RS37GsZBbLjgjb/DuijW4jCAJD4bTOHYFCoTi3GRaFcSdlXZ7ffQRuZdGZNzLDUPQKde4yhDTBvnHJ92OtwN8lnJH26GEUbepFP/DV6LWGukZFrFz0dVA6UaRCc3iQU=
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com (2603:1096:604:101::7)
 by OSAPR01MB1556.jpnprd01.prod.outlook.com (2603:1096:603:31::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 18:26:05 +0000
Received: from OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2]) by OS3PR01MB6593.jpnprd01.prod.outlook.com
 ([fe80::6c45:c45:40f8:e4a2%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 18:26:05 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "grant.likely@linaro.org" <grant.likely@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH mfd v1] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AQHXOtSPoxM3P4fkKEmDrY8StfrCU6rqloqAgAunjUA=
Date:   Wed, 26 May 2021 18:26:05 +0000
Message-ID: <OS3PR01MB659398F1C336CA2A03A0A7EABA249@OS3PR01MB6593.jpnprd01.prod.outlook.com>
References: <1619466246-11198-1-git-send-email-min.li.xe@renesas.com>
 <20210519080807.GH805368@dell>
In-Reply-To: <20210519080807.GH805368@dell>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e16a6a1b-c0f7-4976-2d42-08d92073b9a7
x-ms-traffictypediagnostic: OSAPR01MB1556:
x-microsoft-antispam-prvs: <OSAPR01MB1556FF1303DE2306977AA15FBA249@OSAPR01MB1556.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rg9fph/0Y2WZOYpuMw0Xhga3s/im+SYbatN0BQJfd+0pM9PfsBnTmvCA3/Bs5UkYpa1DSt0uPwwd1+t3ZNcet8H8ezNkD8ZIuOSOClnnIYTjaYV3dZnUiWwnw7l+a8OjvNC8DdycUB0vNMVQlOCB/GEOT/5qFFYwIAghkAviFSYCXaBi7tGMMEvMkBxxlV8LLUzXJrtLOMXBast84pPKdmP7bJ6riFEK1ieG53ZVAOu6XWUiOTztOVMeaA4DtnSlfN/UZ7TZ3IDdzY51LTRV3hGaE4DKgh3iwBUKT9W5E1US2P3sUKJCxyitd9fnADOEgAQe1NfH51vNJIh3WMt2GyTaydJ5S9RC/zULCgw45+hAegEifhi71BhkURZnit5FgBs/ACWrXrruI0FeSyKssRJxPHyqawBbaThWDzdjJZ+ANj/CmOu9k3WLyHE3fb9XW6mteYSqG8UTWV1wFnnftFU/tYHap9c1znhAICDOoN5CwXUw9UxBDnZDxxN+rF90aQI4h0Z4o3cCTCe8LU7gn8KBrwFmJXC8k6sqvDCwuUtnvcRH6BPSZ1bBeOgiJpFWgtmbFl7uTAXU7WAyy09CyVraBjt88ugWB96vQpRZXvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6593.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(376002)(136003)(366004)(346002)(316002)(122000001)(6916009)(33656002)(52536014)(7696005)(54906003)(186003)(8676002)(6506007)(2906002)(83380400001)(9686003)(38100700002)(71200400001)(66946007)(4326008)(5660300002)(86362001)(66446008)(4744005)(26005)(66556008)(64756008)(76116006)(478600001)(66476007)(55016002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R0J2SXoxMTVHY0Y0ZGJDMHFZeCtoZGRWZUlqazZUNWtoN1ZlVENSY1E3b1E5?=
 =?utf-8?B?N0NxbEdYbXlxemp1UXBBMGExeTRLMzFSNW5QYlN6TnZwTStjcWkwMlh2b1Bi?=
 =?utf-8?B?WWJoVFFDd2Z6UyszZ0Z5NzN4cjdETU54VDJJRzM0T2JtSzcwcWxqL3VabU9t?=
 =?utf-8?B?RWd0UzdNdDlVRFFZVUNlMkhZOENnRUlvNThDV0VWUU9nMkUzMzBjdW4yNUc5?=
 =?utf-8?B?VDRlYytOYnI0MGMwamRoRmluWW85Z3ljcWRmVTN6bUx2Z0dyc2haUVZFdER5?=
 =?utf-8?B?ZkhNMFFOUWw0TjJaNnJTSDFYN2ZiSHlFdEpWTDZaNXA5NmNHd2F2S0JWaWR1?=
 =?utf-8?B?Qm15b0ljUUt2NlpoVVFXVmpYNUNXQjFWSjFudzBlUXdYd0Q0MnBnZHhoSCs4?=
 =?utf-8?B?MlI0QzRjQlU3ZHVrRVYvVFVqeDJnNGpWWkZac0hDcGRQVjB3aVRFZlp5K3Jo?=
 =?utf-8?B?ZEw4eG5KVWZQaWEwYTlqOXdTL2V2c2xkTTdJa2JLT3Q5RFBZam9JRVNlV3Vq?=
 =?utf-8?B?b2pUQ1crS0hMQmpyblpNVlpqeE05VjYyc0hldmYwalFYWVlhQ0hBVWRnWHRJ?=
 =?utf-8?B?QS9LMUtadVBOWEZqd3pNVkNhZHZ3Zms3NGVuRVdXNm9BdUpoRWpudVBSbXh1?=
 =?utf-8?B?aWNXRTdWVFdOcUpmV2J3SUVVNGFzc2pIZ0t2SElSSFp6djRFcSsvM3pwUzJF?=
 =?utf-8?B?ZzhzdGYvUTNqTFhnQ3hWN1FMWFd5YzZrdndmblcxWEVqWkxhYzNrcitGRzFO?=
 =?utf-8?B?TXdsWDF6V3NMVnBBYmtJd1M1K3JKUHJEWlgyTE9lSHFSbmpmUjdoeXJRZDVm?=
 =?utf-8?B?VkJzWVBoYnRMYzRlc29rMEN4QkJkZnE5dHk2UkIrdUg0d2Y5S1RNOTBlcXU0?=
 =?utf-8?B?WklEY1h2UzUrVjNLN09BV0lqT2gvSVpDY3p3Qm9ncWNDeGwxTGREM3Z5em5B?=
 =?utf-8?B?MmxRYzUrZ0pCV3VyQ0J1T05JWFhGUlJhYUFvV0NCdzhuRkUvM1YyVllBdmFM?=
 =?utf-8?B?b1l3SzA4a3BxY2lreTVQSlZ4V0VFQTZEajRRYytreGFNd3ZhRXFSYjdaNEln?=
 =?utf-8?B?cURsM2ptaFVTTUZ3OUtJNkMzalcvRVIxMG1CK2VUT3FBOTc0aTZyUGVnWko2?=
 =?utf-8?B?dlV4bnBXazh6RkVtYmt0Sklld2NKelJvWlhYNHlnRkN1TlV6TWZOcTdTRlV3?=
 =?utf-8?B?N3d6QXE0Ny9pSG40M3dTYVphV2tSS2hvaVVhLyt4dXRsdFZNNWVEUXY3WDBt?=
 =?utf-8?B?em82dkNtOWxKaEwxQW5LaE1hVkF3QUpyWitVTUFVeHMwUmdSaVdJZFpBdy9P?=
 =?utf-8?B?MGFtUmNmbTJLeXNacysxZGdwQ1M1Q2wzSjE5UGFWREU4bXVtNnZRaUpiSGFm?=
 =?utf-8?B?ZzhkMHVNMVVpMjFCNkJYMjJETVRxTjVkdktUU2Z1ZFh2elFtM0NaVjlwOFR1?=
 =?utf-8?B?cEh4Y08rdjJvYVhRUEdZK3ljcndwTjBOL3JkenlwQ0JjdEJlemhrZ1pNRFR4?=
 =?utf-8?B?MGUzenp5M0FETFFpUG5Uc3U1OW5mdVV3TFlZY05zQXFJME9tdEpvdUpuY2Jj?=
 =?utf-8?B?ZFQ0Y05hakY4YThUVTVUNVpDSXl0eVdaS25YUlQrMEdDM1dGK21VTHQ2Mkh0?=
 =?utf-8?B?VitqV3AwdUFyMnEwV3FDamRtMzNNNlZSaEdQVVM0TjVlblUxeHQzM0ZvVFpS?=
 =?utf-8?B?RkpUc1ZjVmFYNWZKcTkwek01MjJkblFlcGVGdzhKL2YwcXE4U2N4Sy9LQmU1?=
 =?utf-8?Q?IJ3CK4Xtz/8gSh7rDHE/wrBi51ocmpOe+qMwslC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6593.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16a6a1b-c0f7-4976-2d42-08d92073b9a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 18:26:05.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dOWwR7qWnwCLPeuViP+eIOPh0yDeyPQg4j0+Y1AEafOHuExcIcTH3Pn3tyMCB23QnepFIFFHZ5lYZA5Z/yC/8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gPiArCXJldCA9IHJzbXVfZGV2X2luaXQocnNtdSk7DQo+ID4gKwltdXRleF91bmxvY2so
JnJzbXUtPmxvY2spOw0KPiA+ICsNCj4gPiArCWlmIChyZXQgPT0gMCkNCj4gPiArCQlkZXZfaW5m
byhyc211LT5kZXYsICJQcm9iZSAlcyBzdWNjZXNzZnVsXG4iLA0KPiA+ICsJCQkgcnNtdV9uYW1l
KHJzbXUtPnR5cGUpKTsNCj4gDQo+IE5vIHRoYW5rIHlvdS4gIFBsZWFzZSByZW1vdmUgdGhpcy4N
Cj4gDQpIaSBMZWUNCg0KV2hhdCBpcyB0aGUgcnVsZSBmb3IgYWRkaW5nIGluZm9ybWF0aW9uYWwg
bG9nIGluIHRoZSBkcml2ZXIgcHJvYmUgZnVuY3Rpb24/DQoNClRoYW5rcw0KDQpNaW4NCg==
