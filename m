Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CBA43F8B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 10:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhJ2IX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 04:23:59 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com ([40.107.7.118]:6630
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232305AbhJ2IX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 04:23:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0/vpEaIAnswHu6rUD+RnlEu3YPA0vh3/KFxbtx9l7k+HAR/EwT13ih3ydiGJZpiEelRftDNEZd/wzol7H2WH6/YQT3Icvdi23v516juh0GaoLZ7kPRz4601gaIPMkdIYwkqk94huVCX0XX6bE44GjB7peCihcw8ysLcyizyeZ5tzhb4uPdimAOT3r578DP8VeuHt4pzsuowbXV8S40J9DR4+YnQ9zQ745nKCKOMjJC0YyMvBqlD77WILvumHoqF7IAdbuHv0W1wVhdB/+wAg9Y5fRPnGs2dWMrzH/Gg4WqwlpvNTpVpobXYLpIuuyT/BulWdYZZFrS/60DG9819EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxFqKIpkGnlTGHt0iBAm3iWwnntmcWsr1ubGotOwVJ8=;
 b=FuO0CWoB2a7o6jlw6Ca7geZnZpcGIOT1cDigYtzvBuOOAZvQSiwHXA8DacYNQwV0OYiff+Xewolpb6/h0AV3jJaigsgvsq8o4b44CP2U42kgNbkNouLY47gvlPfRaezgmDkXUoTjqTYvo/V5qBIj9QG3U21kU+kecGD195BOVvN54JUFyoICuMDzNlaWXkV7haDNsz9BkrQjrQlfa+ZVaoBMu+yjgCSzhZ+qClUIfwPXHcYDnI7cNd3CP4jlTi9PlAwYEzNRnYzKesmfnZbWuXTVDpLvKxvB9EHkx/uqHZgUyDi5yir2kWfWtHw1+6xkBgaOMQX2xlyXaTOEVascOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxFqKIpkGnlTGHt0iBAm3iWwnntmcWsr1ubGotOwVJ8=;
 b=fgt4LollSfgUzRioJ6rFo3Z+jYezTHgAo9VNZEHmOVspYmgB3o9We6VYQ7jqe1cmI2YWF4F44y+N7S78gnW07rG3aZRyDtCMiN90sruxwgCdJcZKBeuOWLfpgZckwsx3AwEXbHubW+Yduy1JcnRBmfgwzlu3o1qlazt8Rm+mLCY=
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com (2603:10a6:10:55::32)
 by DB8PR05MB6825.eurprd05.prod.outlook.com (2603:10a6:10:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 08:21:27 +0000
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::91e8:e960:243:da70]) by DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::91e8:e960:243:da70%5]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 08:21:27 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "galak@kernel.crashing.org" <galak@kernel.crashing.org>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>
CC:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>
Subject: Re: [PATCH v4 7/8] arm64: dts: imx8mm-evk: Add the pcie support on
 imx8mm evk board
Thread-Topic: [PATCH v4 7/8] arm64: dts: imx8mm-evk: Add the pcie support on
 imx8mm evk board
Thread-Index: AQHXy9DhoIziRQxDJ0KUED6KbQZsaKvppEwA
Date:   Fri, 29 Oct 2021 08:21:27 +0000
Message-ID: <ddd1606a22782bdf0ca81c8259eb8aeb2eb056b8.camel@toradex.com>
References: <1635406037-20900-1-git-send-email-hongxing.zhu@nxp.com>
         <1635406037-20900-8-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1635406037-20900-8-git-send-email-hongxing.zhu@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712f64b3-a6a5-44d7-478e-08d99ab51a99
x-ms-traffictypediagnostic: DB8PR05MB6825:
x-microsoft-antispam-prvs: <DB8PR05MB6825FD02D5A0639F3D258D4EFB879@DB8PR05MB6825.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OpARx5uwImHGCzhRPcXDH/Ah91s+UJAkSyWL/x6TInUWkPrBbAFdxYbxKIVBRrSLHhfhtSjh9P8UhcZWSFy2N+OOvRuW3149rW393RYBNKt8H05adiOR4MZ8FeWUSsD6sWig/Y0Ka8+TgoupbAj2IWEGnA/2Q/Yp4ZQKaS2OeeStv1dx/l73L4jHqdJew36qQjAnwmoquCSU9bgQkyme9VY67WNgpN/nvs2/Z+tdA7so8lGdXHyQ85DsNWyCQ9E/8n8d//MuV0a3dKmZh6WA//YogB+Q6dcld+GhWeUEN9rUx7rtgcfnZNdp8vuyeGSatXIIqD+dd+tQ9wd3VpRWZX5V8/SdWrdWeDLSDcCJu6NZXN0fsvxx04nmGTg/v3djhSa0KjKNxp7Xw0c5U8bjMncXQpzlRAb9rGafuII+O+KZO97qQ5sZd7bTZ/0rxji5SBn/Pk9tk+K6N64IybCHvzF1GUpUDLASwy9J7CYMFFzo/HLNsXiMTOkJKQCBEGys47Qj0G8yNMzYHNzzre87LX9XdIL8ppbmgTDA2bozkn6vpYNf9f7RqNwrgg3HjiKfWDqALDO+/l8gj7v1tlcqB761aK37gdRG7YLRun6S8UyWvVv0eb9qWX8dn5EYFnaN5DtRZJ+sVsysCdgFQs+eZoHuPBJ08NMb4gA4H2pTzDpcMN3gpov/PntWrOIuq3FLRzziRXkVvodysrI7Xy1jPvyrkoHcZKHYIboNF2/OjXU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5431.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39850400004)(376002)(122000001)(71200400001)(508600001)(8676002)(38100700002)(186003)(26005)(6506007)(86362001)(7416002)(44832011)(316002)(2616005)(36756003)(38070700005)(66556008)(64756008)(6486002)(66446008)(54906003)(66476007)(2906002)(4326008)(83380400001)(4001150100001)(6512007)(110136005)(8936002)(76116006)(91956017)(66946007)(5660300002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anRmdEhmWlRLRFMxUndJaUZrbnhsbjF5K0FzdVdwZUhVbVBwYjgvWFA0azc4?=
 =?utf-8?B?cnduM2tGUS9XZjlQOHpQTGNGeVdKSXp5bWdLdXgyNnp2RTd5VGk3cEtqdzNO?=
 =?utf-8?B?Y0owaGNrT2ZVQ1IzSEZGdWk1ZTVBZUlHd0huamtnbW1DbTV5emVGemlDYWgy?=
 =?utf-8?B?ODBSdm5GclJjNGYwenZpVFNISStra0xnZ2Q0d09SOEoyRkIyN0cwOGZYOVJw?=
 =?utf-8?B?ZldWVlRtSy9rVG9QN0pOYUVGaXRILy9aUGQwQ2xkbWxiR24yblFEZnM3YTJ6?=
 =?utf-8?B?OVJTejMwQ0J0cTdaeFdKMTFMTXcyRnFWeDJ6WW0zS2lrL3N6S1hoeWU5aWVT?=
 =?utf-8?B?TEhFTFExaWtLa0VTWjR0Q1Q0S2RxdElpaDNHZG5oeUVFc1RVZkhQTjZLQmZH?=
 =?utf-8?B?M1JXSTNJRThpUm9za2xWbHl4cXR6eUtDY0NXMUZUZzhDSnJ6RStWOVU0TGFr?=
 =?utf-8?B?ZEp1TGpJaU1QTjJpZFFkQi9RTWZ6R2cyUU1jRjZQZWRhNFl5RzlkQWpwU25i?=
 =?utf-8?B?dXc4UmNtQTRZU2ovYlIzSjI4L01DSE0vbnlzYlp3OGY2OEFuaTVOMW1KMEZz?=
 =?utf-8?B?R0h0VVMyL3JHNk50NnNzcUdKekVsUitETmYwMWVYYWhNekFMMitSQVBqTXRm?=
 =?utf-8?B?dE41c0FNbUVqcG5GNGZVbVBNV2FmbktWYXFNY0treHJ0SkNkQkUyc3RjR201?=
 =?utf-8?B?UEh6MVBwN3dzTldrdGRXR2ZQRlBQSVVtaldMQ29HWkhXeDhDa0dPYVYxTDVE?=
 =?utf-8?B?U3RJZ0dzdDYzSW9VWjNSSC9sZW5kQU5FRFNnL2dVdVVnTnMwTnQrY3FTdWJl?=
 =?utf-8?B?Q1NubXNYOVlBdURlQmhUNHdzRFh2SHRDSUprSWdDYUNDUTlxeUlOMFMwRzU1?=
 =?utf-8?B?Q2wrdFdQS0dmeml5K2g1VzJuQXRIVmoxT0lRMndWRTk4c281Rjc0bHdFM1M0?=
 =?utf-8?B?Z09EZ1BHUXhzK3ZHN3BFdVVlQVVSWjFNRFBLdCtOTUd0MllpaHI3bEFKbWdv?=
 =?utf-8?B?WnEvMlZmd3pMS1A0VEFOZkx4WHNlcElsQXZQemRLczFUZ0pMU2RQK3JENExl?=
 =?utf-8?B?UDg4UkpVbVlENEZadzdNQmlKbnhjRUFNNkQ0cUNkSXRwMk5BRjVLbk5sbTBE?=
 =?utf-8?B?Yk8wQks4QmV4N0I4MW9VaXV3ZkhDdmREVkVuTWpqcjd5MnJNWUVTWUQ4VUFy?=
 =?utf-8?B?NXNOUHFWTWY1VHlQQkdxY2YyRmhESjNCWXJxRElTRUZuYVE5VkkzNkZUb1dm?=
 =?utf-8?B?NGdIeWpuL3pHeEgveHNkNkk4RmRFSmVzNWY0WDRLeXZreHZ1aFV0TlZZd1I3?=
 =?utf-8?B?aFJ2K0ZDQ3BIcUZ0cjRmNGhFRU1vYVBjSjFSMkUxY0x0M1FnMFpiQjNIc2lQ?=
 =?utf-8?B?NDlaQkQvMWZyOW9ab2lxTmIvTElFRFlXMGFHU3E1R0NtTCt3RjR6UUcyWmpk?=
 =?utf-8?B?TVJySGVJV2pqWStQUklnQ2JLUzQ4U3FLazh0VGhyc3pNdkxWRTFSK1p5MlQ4?=
 =?utf-8?B?cm9HeXhWbG1Pamp4MHNRU08wTG1TTjhSK3BhdzFWSisxajVVOGpmNWdqaFZq?=
 =?utf-8?B?cSt1bGRnUkJtbUlQVFpENExYR0RFRDlwaTJkb1JkQ3RFSVVjcUlwb1dQZ1Rv?=
 =?utf-8?B?WDBwTXN5eWlYVUZ2S0E2ekIzcWlPV283aWFIZDd0NGpwOGdQc0lIZUk3dWlt?=
 =?utf-8?B?Zy92MG5Nb3dSTXo4Y2F5QklyMVFpeTYvL0tNUTFFcUZ4bFpBRzgzOTNsbWhm?=
 =?utf-8?B?Vzc3cXBENG1XdWpYQTR0S1NSbnd1SmEyT1FDZUNxTDAzdnczWVFiK3c5NVFM?=
 =?utf-8?B?dzg1ZGdGeDZKbXU4WCtMTFZBUEdSUGgrUWVmYW5Wc2ZhWlN2YXhFZWpWZll6?=
 =?utf-8?B?b1NCR0RQbmpUc2Y1MnVLbnhwMEphbnFVN0syam5yUW9zQWNMa1BtMzh1azdH?=
 =?utf-8?B?M3J6WGE1ejV2ckp0eEI2ZkgxMUhxSlBMZFhROEEwNWRMRGNzK0xlaTM0d0FS?=
 =?utf-8?B?eFFpOHZhSUNzMDZnblRsUWZBN2JKWVNlWThlWTkyOGlyR3p6SjU4cDVTU282?=
 =?utf-8?B?ZlQ1RFdsSkxPdWc4b08yYUZwQjJDMko2MWlHKzVDU2pCU3p6TUZnWU5SU3RQ?=
 =?utf-8?B?R20xTUlDOHBrektTN2RnVmFLUGpzdmZSVVVtcHgrZUZmbG5ab25LOHF2SFNx?=
 =?utf-8?B?VnFkTHBIQTUxbkVJcHhhSGtpbDFTSDRyV0xjdE1OaTNkblQ2ZzhCcnZ4bndF?=
 =?utf-8?Q?jscUDe36a3ZLmGz9FkA4KS8TRud6dxXwaQksqRUSeQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF34E4F52298B6469CEF159012C9E3B1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB5431.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712f64b3-a6a5-44d7-478e-08d99ab51a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 08:21:27.4097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26I+rWeU4FeUsNRdhgaiYk2iVTcdMDj0ZjKtC6czzt1P5VFBu+ndmAUzDonKPX8Ag58uLFaajtlvhX676lR8xv8ZJ2iCn3xMDrUlCR9Et8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR05MB6825
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTEwLTI4IGF0IDE1OjI3ICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToKPiBB
ZGQgdGhlIFBDSWUgc3VwcG9ydCBvbiBpTVg4TU0gRVZLIGJvYXJkcy4KPiBBbmQgc2V0IHRoZSBk
ZWZhdWx0IHJlZmVyZW5jZSBjbG9jayBtb2RlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQg
Wmh1IDxob25neGluZy56aHVAbnhwLmNvbT4KPiBUZXN0ZWQtYnk6IE1hcmNlbCBaaXN3aWxlciA8
bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPgo+IC0tLQo+IMKgYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpIHwgNTUgKysrKysrKysrKysrKysrKysrKwo+IMKg
MSBmaWxlIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1tLWV2ay5kdHNpCj4gaW5kZXggZTAzM2QwMjU3YjVhLi5mYzE4
MDNhOGFmNWIgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14
OG1tLWV2ay5kdHNpCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LWV2ay5kdHNpCj4gQEAgLTUsNiArNSw3IEBACj4gwqAKPiDCoC9kdHMtdjEvOwo+IMKgCj4gKyNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9waHkvcGh5LWlteDgtcGNpZS5oPgo+IMKgI2luY2x1ZGUgPGR0
LWJpbmRpbmdzL3VzYi9wZC5oPgo+IMKgI2luY2x1ZGUgImlteDhtbS5kdHNpIgo+IMKgCj4gQEAg
LTMwLDYgKzMxLDIzIEBAIHN0YXR1cyB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB9Owo+IMKgwqDCoMKgwqDCoMKgwqB9Owo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgcGNpZTBfcmVm
Y2xrOiBwY2llMC1yZWZjbGsgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21w
YXRpYmxlID0gImZpeGVkLWNsb2NrIjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCNjbG9jay1jZWxscyA9IDwwPjsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrLWZyZXF1ZW5jeSA9IDwxMDAwMDAwMDA+
Owo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJlZ19wY2llMDogcmVn
dWxhdG9yLXBjaWUgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxl
ID0gInJlZ3VsYXRvci1maXhlZCI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHBpbmN0cmwtMCA9IDwmcGluY3RybF9wY2llMF9yZWc+Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZWd1bGF0b3ItbmFtZSA9ICJNUENJRV8zVjMiOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8
MzMwMDAwMD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdwaW8gPSA8JmdwaW8x
IDUgR1BJT19BQ1RJVkVfSElHSD47Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVu
YWJsZS1hY3RpdmUtaGlnaDsKPiArwqDCoMKgwqDCoMKgwqB9Owo+ICsKPiDCoMKgwqDCoMKgwqDC
oMKgcmVnX3VzZGhjMl92bW1jOiByZWd1bGF0b3ItdXNkaGMyIHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gQEAg
LTI4OSw2ICszMDcsMzAgQEAgcGNhNjQxNjogZ3Bpb0AyMCB7Cj4gwqDCoMKgwqDCoMKgwqDCoH07
Cj4gwqB9Owo+IMKgCj4gKyZwY2llX3BoeSB7Cj4gK8KgwqDCoMKgwqDCoMKgZnNsLHJlZmNsay1w
YWQtbW9kZSA9IDxJTVg4X1BDSUVfUkVGQ0xLX1BBRF9JTlBVVD47Cj4gK8KgwqDCoMKgwqDCoMKg
ZnNsLHR4LWRlZW1waC1nZW4xID0gPDB4MkQ+Owo+ICvCoMKgwqDCoMKgwqDCoGZzbCx0eC1kZWVt
cGgtZ2VuMiA9IDwweEY+OwoKVXN1YWxseSwgaGV4IG5vdGF0aW9uIHVzZXMgbG93ZXItY2FzZSBs
ZXR0ZXJzIGluIGRldmljZSB0cmVlcy4KCj4gK8KgwqDCoMKgwqDCoMKgY2xvY2tzID0gPCZwY2ll
MF9yZWZjbGs+Owo+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJva2F5IjsKPiArfTsKPiArCj4g
KyZwY2llMCB7Cj4gK8KgwqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiAr
wqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcGNpZTA+Owo+ICvCoMKgwqDCoMKg
wqDCoHJlc2V0LWdwaW8gPSA8JmdwaW80IDIxIEdQSU9fQUNUSVZFX0xPVz47Cj4gK8KgwqDCoMKg
wqDCoMKgY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19QQ0lFMV9ST09UPiwgPCZjbGsgSU1YOE1N
X0NMS19QQ0lFMV9BVVg+LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgPCZwY2ll
MF9yZWZjbGs+Owo+ICvCoMKgwqDCoMKgwqDCoGNsb2NrLW5hbWVzID0gInBjaWUiLCAicGNpZV9h
dXgiLCAicGNpZV9idXMiOwo+ICvCoMKgwqDCoMKgwqDCoGFzc2lnbmVkLWNsb2NrcyA9IDwmY2xr
IElNWDhNTV9DTEtfUENJRTFfQVVYPiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDwmY2xrIElNWDhNTV9DTEtfUENJRTFfQ1RSTD47Cj4gK8KgwqDC
oMKgwqDCoMKgYXNzaWduZWQtY2xvY2stcmF0ZXMgPSA8MTAwMDAwMDA+LCA8MjUwMDAwMDAwPjsK
PiArwqDCoMKgwqDCoMKgwqBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gPCZjbGsgSU1YOE1NX1NZ
U19QTEwyXzUwTT4sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIDwmY2xrIElNWDhNTV9TWVNfUExMMl8yNTBNPjsKPiArwqDC
oMKgwqDCoMKgwqB2cGNpZS1zdXBwbHkgPSA8JnJlZ19wY2llMD47Cj4gK8KgwqDCoMKgwqDCoMKg
c3RhdHVzID0gIm9rYXkiOwo+ICt9Owo+ICsKPiDCoCZzYWkzIHsKPiDCoMKgwqDCoMKgwqDCoMKg
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC0wID0g
PCZwaW5jdHJsX3NhaTM+Owo+IEBAIC00MDYsNiArNDQ4LDE5IEBAIE1YOE1NX0lPTVVYQ19JMkMz
X1NEQV9JMkMzX1NEQcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDB4
NDAwMDAxYzMKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD47Cj4gwqDCoMKgwqDC
oMKgwqDCoH07Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBwaW5jdHJsX3BjaWUwOiBwY2llMGdycCB7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZzbCxwaW5zID0gPAo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgTVg4TU1fSU9NVVhDX0kyQzRf
U0NMX1BDSUUxX0NMS1JFUV9CwqDCoMKgIDB4NjEKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoE1YOE1NX0lPTVVYQ19TQUkyX1JYRlNfR1BJTzRfSU8yMcKg
wqDCoMKgwqDCoCAweDQxCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoD47Cj4gK8Kg
wqDCoMKgwqDCoMKgfTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgcGluY3RybF9wY2llMF9yZWc6IHBj
aWUwcmVnZ3JwIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZnNsLHBpbnMgPSA8
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBNWDhNTV9J
T01VWENfR1BJTzFfSU8wNV9HUElPMV9JTzXCoMKgwqDCoMKgwqAgMHg0MQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqA+Owo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gKwo+IMKgwqDCoMKg
wqDCoMKgwqBwaW5jdHJsX3BtaWM6IHBtaWNpcnFncnAgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgZnNsLHBpbnMgPSA8Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgTVg4TU1fSU9NVVhDX0dQSU8xX0lPMDNfR1BJTzFfSU8zwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgMHgxNDEK
