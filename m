Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A0537B6F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 09:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhELHgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 03:36:04 -0400
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:54209
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229850AbhELHgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 03:36:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/Y5uz3T+5sCFdRnNcU/DfFAdTejCKNUzVsQTx0Oss2ncU9g+zawW3IWZxIXNW3JLXajZNCofUorV1fp/qXvk4yrxKuaQBCd/zbWFH2p1FKxlsnOUoKynddx7NwkSvUU1zJ9JA3crlGl2v/rR3A7SDfPvg5/Epy69byWoSvk58zyF+pAE5JmihYVsduxg3i+5KHvqxjtkf/WkvlOJqZ4sb4iFrwdXdwWf/MSx/lmQgJt6TO1iDQW4Uz8HQd1++04KHpAifqdgUUaI3qqCtqGFdVxcyHn4HahBOZEbTXzcCvIkaUPne/Z8SxL27wAEOupNxfCNpKsJfDtP/LSvFxVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPOMAjobFJP4FvNmqCXEUvETykgf3NI2XNPO2u0DkhQ=;
 b=aoJPmENbs63cIHNeYMGOSQEuHr4cmzUHkLeMnKSgUr6bgbiJ5o7kPyIlV6KKKT4NTgJd4OewOAJ6ZNRwmBqrOCi7uH2AGeR8SvMASFLyouFHwoQIwml98hUp44+5tUS6mrAPb4JCzd+qzidASXXMCzyY1T7eFF+Q+osN8hB5QDWrXJObRq9uXk33AqV+voRzDdCdR848pFXKsfV1bpyO814rlBAaOM0wOuhMWdyQgTfDB9Goty+C1CTJQ6Ih+oF3C0Yqzj6gskIlUqPDbB+rkXqjdgJqu7jA8XX8o/r7p+aFqQ3q/roCZa5MaAFHSx5EkUX93szjlYWUKS7s3UGLgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPOMAjobFJP4FvNmqCXEUvETykgf3NI2XNPO2u0DkhQ=;
 b=icKur3kxHjQCVywObVrg2Tqhq2pasoSn4sL6ebb72zgqqzRvixFG9QbmN+116H2MW5XF6/L/JZp3DCapNBurnDdkeKTODSvH+Y1E2ts9G6M/SNMElw54u9oI0uPP7zcvVzadNhOmVfOBVwpB2MevGWoe3jjMeQ0PcegL3m5ASgs=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7688.eurprd04.prod.outlook.com (2603:10a6:20b:29d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 07:34:53 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::b034:690:56aa:7b18]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::b034:690:56aa:7b18%4]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 07:34:53 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Zou Wei <zou_wei@huawei.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] soc: imx8m: add missing MODULE_DEVICE_TABLE
Thread-Topic: [PATCH -next] soc: imx8m: add missing MODULE_DEVICE_TABLE
Thread-Index: AQHXRt6lHFuM/krLTUy5d8Hkd8IGiKrfc92g
Date:   Wed, 12 May 2021 07:34:53 +0000
Message-ID: <AM6PR04MB60534F8BDD52FA83708C5D7FE2529@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <1620790885-15892-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1620790885-15892-1-git-send-email-zou_wei@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d52c13c4-0fd3-4341-d1ca-08d915186ede
x-ms-traffictypediagnostic: AS8PR04MB7688:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB76888A9479F826AD0246F068A3529@AS8PR04MB7688.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0DVUIegvCzD+7n62QhJ1ejBLMFJgzy04iQvKwzhxdiaYQR3OkPmUIrhk//G0aNjc/W8ZYhYmZYSGXIZ/DvqMnKcWkps3G+N0p/nMIXNLTml8wInhFuhY1uvqMj9nlGwBNUGcVUnHtUz9yjxuOmrJeLoPewSz1Od88K+0Hj+C7rq5f9WQEVE8KvvZg5RVlQ2E7zshNu8xDC9kJll0SY6m32VOHXyd8mP2FfgO0FWca/9IcZrOKCLdtHumdff5o/2r2rVjJ5DQAs7nLZXqZ+X8BBoWdgz8VjTkpe9dsnwCVziAhhUYo0cTzERXesn95pqUgpiBD2Y27e9/RmmhoKTIp43ht4vL0lacTqSS2frAeJuVZ/ki1tELTIBkI+jM1BKxt/keryzVn0pwG3ZajiAPStlvKxkJcknMxYlCMqa1XAdn8IAUfdkd+l48Uj1ZyxasIDuligPlrL9u/NxighTcnbtizSkxrYJBO5bEgoS9WF/tA4a6lrqGoE5qFtw7XS5Bwb5gk53OoSxJXRXsOH0b4JjKXW7QcbcuOyUJe5R7YGHPEGhExV1RwPiKk214RaMMXD5Q74AWSwrAfJoWi8yDnrNCem8WQUbbeDiJIu5yrWLcQIpDeuUEYXBVXD78lICxJKMt2NNjjv+C2aOqC3R1n9FQJXOtToS9Yq8StcHkc2HUQh8bsaI2uyziP1QZmJkO7sd0MPf/jTdjelWo7TaBwhL9UKk0PVSWCD6NTrNm+4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(33656002)(86362001)(38100700002)(122000001)(76116006)(83380400001)(71200400001)(64756008)(66476007)(66946007)(66446008)(66556008)(7696005)(186003)(4326008)(966005)(2906002)(316002)(110136005)(55016002)(54906003)(8676002)(9686003)(478600001)(26005)(8936002)(5660300002)(53546011)(6506007)(52536014)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?UWhNVS8rMXVXaWxLcnFsMTcxTmFiUWNUZHAzMTBZNHpFbFlqcWdyRlpCVGF5?=
 =?gb2312?B?ZlBJU0wrV3NnLzFocHV0VlEyRllybTlGSzVTQWFCM0hsY1RDRWpIT3VwQXJ4?=
 =?gb2312?B?SDNPc1V1U2xwblFmU0FEdkkzS2tvbFpsVFZnU3VTMFdmU0c0d1RoeHd4MldN?=
 =?gb2312?B?dXNKQmY3SkJUZlFiZmR0dGNRaFFTdWo3RVQ0SURpT01RN0tpMTkyVjBDb0tT?=
 =?gb2312?B?N1pZa3JjTjNkdzVIMFJPZXFaUWx6aXdLWGVqQjd0NjFENWFMNTMrams0T2dl?=
 =?gb2312?B?SWI2bjJkc09INXJSZWZWczh5ZHZYSGRxSjRZOXIvekdUSU9zekJVQjY3WGJT?=
 =?gb2312?B?YkFZY3JKSTNmOER5Y2xoM09TS3EyVlVOYUQ3M0tUSGN2M05uUFNhTkViNmR5?=
 =?gb2312?B?aWhtQkpueC9FUUNEbkExQXFRZlRGWFFKbmN4SVFSZHpMQnpydjJhcWdMTEta?=
 =?gb2312?B?RlB2NkEvTFN5TUs0NXE1QTVua1ZvWjMvSVh3WWJBcHN5eWhZSkhUb24yeUF2?=
 =?gb2312?B?aWlwemNsNmo1RTRVV0ptc0RqcWhIcmM3SHNvOGtURXNIN242OXlRdUxldmFj?=
 =?gb2312?B?ZDlmS3dybHY1a2E5eDBVZllLMXl5MklNSjh1cENwRytsbm5ON3ZFbWNheGhQ?=
 =?gb2312?B?K0V6elA2QXpCd05oN1FtNStULzhqSmJ0TmJVbHRZZ3duOGdLRllsVXFnSDZE?=
 =?gb2312?B?QUFiaWlUQk9JL3NsTHgydTBsVi8rVU1UYk1CbXhzelMxQzlwUlA0V05lbWFN?=
 =?gb2312?B?TllSQkRqVG5lejhWNDloclljZGtvMzVmSEtDQXhZdVJTdjRNWmFBQ3RYeEt3?=
 =?gb2312?B?ZmpudGdiT2ovVmxuS1R2YVJobmh4RUlFSU40L1dqeS84ZjFBRjMwUnNWNklC?=
 =?gb2312?B?UGdJdVE1U3BDRDBjbVFPUW8zYVRjUGlwcFVuc1VsVXZMVzFLNGRUbERxakI2?=
 =?gb2312?B?eTRFWGtDZk93VUR5NW5RRXFZZTliRnlRWEJEUkZqakdUZCtjeFpna0JFOG81?=
 =?gb2312?B?NGxqQkV2Rm1LQlo5V2xhYVNDencrenZSL2daMGxRcldzRVhlSjFFT2xsUDlv?=
 =?gb2312?B?UUNDYUUvVlpqczNaNjFkbGhQK2RVVklEU094OEVHQlgzL0JOL3BLNTMrOWN3?=
 =?gb2312?B?Yy9oYUtCRnJoNjI4aDB3RHZYYXU2aFlzZWdiQmkzRlZta3NkWGFmMXlRbVJL?=
 =?gb2312?B?Y2J4Vk5BS2NpV3c0NVQvSGdVSWpZalpUS0VXTzFVNUwrL25JR0Y1UkVmUjVE?=
 =?gb2312?B?cUxnU3FLWFBkei9MVTk3RjR4dkF1eno1US83U01aVy9WL2wrSXdKNXJQeTZ3?=
 =?gb2312?B?MTd0RVVpNlVwczcyeXIrVElYT2MvelloSGpNdlF4RXF6THNyQjRjR1hlRVZs?=
 =?gb2312?B?RG1iR0FmVDdsaWhIYkowZEN4dzE0STFSMTF1ZzlLb3d4QXpwVW04Vmt3NjFk?=
 =?gb2312?B?U3F2M3BDVkRvczNXUTVVMFZ1SkhHT1gybCtVcVFXNGdyenVpZ29qR2NpOWRi?=
 =?gb2312?B?ZGZ4amMwM2kzektmeUtNOFR3cSsxTDBXNHl6dXAxQWY2ZU9Gd2FCNENjZno3?=
 =?gb2312?B?TXVTZUVQOXJwcU5vZlF3ck9oRXBabEN6alNid3VRRGxtRERTZytqbDZoZGZp?=
 =?gb2312?B?cWozaVNOeWt1MDlFS1YzdzJOeWRnRnZBY0kveG41VXY4T29uVWNjb0Q3Y1FK?=
 =?gb2312?B?VFdPV2FSUWR0Y2doMit6T3ZkNm1TZG1vbVVoSDNrUU9LRE1WV0R1YUpwYUxl?=
 =?gb2312?Q?/K85jTzYDxtQee+XsHxD85/FwrtuyA1er4b3FcH?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d52c13c4-0fd3-4341-d1ca-08d915186ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 07:34:53.2630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjpV7IJDk9WcoAlF9SqwZ12/xr1fx/t3IJ9zsJcC0bhTQpwAjEYoUKbupJd+1T4DuwEltPhXRiEEn0ypb1qLzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1hcm0ta2VybmVsIDxs
aW51eC1hcm0ta2VybmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9yZz4gT24NCj4gQmVoYWxm
IE9mIFpvdSBXZWkNCj4gU2VudDogMjAyMcTqNdTCMTLI1SAxMTo0MQ0KPiBTdWJqZWN0OiBbUEFU
Q0ggLW5leHRdIHNvYzogaW14OG06IGFkZCBtaXNzaW5nIE1PRFVMRV9ERVZJQ0VfVEFCTEUNCj4g
DQo+IFRoaXMgcGF0Y2ggYWRkcyBtaXNzaW5nIE1PRFVMRV9ERVZJQ0VfVEFCTEUgZGVmaW5pdGlv
biB3aGljaCBnZW5lcmF0ZXMNCj4gY29ycmVjdCBtb2RhbGlhcyBmb3IgYXV0b21hdGljIGxvYWRp
bmcgb2YgdGhpcyBkcml2ZXIgd2hlbiBpdCBpcyBidWlsdCBhcyBhbg0KPiBleHRlcm5hbCBtb2R1
bGUuDQo+IA0KPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8aHVsa2NpQGh1YXdlaS5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IFpvdSBXZWkgPHpvdV93ZWlAaHVhd2VpLmNvbT4NCg0KQWNrZWQtYnk6
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1
bw0KDQo+IC0tLQ0KPiAgZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4bS5jIHwgMSArDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Nv
Yy9pbXgvc29jLWlteDhtLmMgYi9kcml2ZXJzL3NvYy9pbXgvc29jLWlteDhtLmMgaW5kZXgNCj4g
MDcxZTE0NC4uOGRlYmY2MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zb2MvaW14L3NvYy1pbXg4
bS5jDQo+ICsrKyBiL2RyaXZlcnMvc29jL2lteC9zb2MtaW14OG0uYw0KPiBAQCAtMTg2LDYgKzE4
Niw3IEBAIHN0YXRpYyBfX21heWJlX3VudXNlZCBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+
IGlteDhfc29jX21hdGNoW10gPSB7DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJmc2wsaW14OG1wLXNv
YyIsIC5kYXRhID0gJmlteDhtcF9zb2NfZGF0YSwgfSwNCj4gIAl7IH0NCj4gIH07DQo+ICtNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBpbXg4X3NvY19tYXRjaCk7DQo+IA0KPiAgI2RlZmluZSBpbXg4
X3JldmlzaW9uKHNvY19yZXYpIFwNCj4gIAlzb2NfcmV2ID8gXA0KPiAtLQ0KPiAyLjYuMg0KPiAN
Cj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LWFybS1rZXJuZWwNCg==
