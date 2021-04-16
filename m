Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64640362520
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 18:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhDPQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 12:06:22 -0400
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:50166 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236004AbhDPQGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 12:06:19 -0400
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GG1Jp7016196;
        Fri, 16 Apr 2021 12:05:51 -0400
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2050.outbound.protection.outlook.com [104.47.61.50])
        by mx0c-0054df01.pphosted.com with ESMTP id 37xgw48p8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 12:05:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDkiqsbFfhwUC6ILP2xvVGfJYfpStelmtPC1vNDMCqbHdqGUVpA/R9/Lb5nvrtjPlA+odKBkkO6cBMqTbW1wk/wcA9vWlCEt8dHt0T+nR6zrfMN2jJ2FT1h4ZAyKpS6G4Gi63NXoHIUl/PKfyZn0cfd39pHJ2m9eWaAvUqYfww4536aNFjHF6rPAAIL3YBC24QMMPjwSEMi+xpCmk/b9s4M+YNKHRHg35PSbX59D35Orwr1SbqoDdd8LM7Eriwi1WLi2Bdsb7vN8Dfhlyo02cGCeCSwRjHf8iIOg/PGAkzJlcbJrtF327ffcdl4xP8/JIhLpkt4ucynXE0jfJ+srZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq6HL9qcSlj/LOQoXOi5GINt//WuWD4sBRRJdZcGOxA=;
 b=TS5grzjNV1IfADtKr8iOptuOXuIyUwB5NCa0Axvf3KMU5C0IFColTtrGPxQVGedEqsREQtV9y0hyEDmbrW8EpgIT9+VPR3bQHcWKP0jTvdJnnrpYKqOxQHdthCqrn4tZ+6uJu/ckwBihnGCvECDh59jws38abvcGkwTUF63LOBV+iZZdwWD0PBpbLVUfJIcvo2UefckF4b5MwYGd3RxCWOVVgumgeJrydiW3+XQ9KqwVjiZs0EH2adp6EMqHBoUawFTdWgKAlGfJ3kuT5k9CPUyk4OrZztQbEpTnL0ULzEHX5Z8xqxkW7W/7qBqVkswtOSxpslpYGtOwAIStL4vntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq6HL9qcSlj/LOQoXOi5GINt//WuWD4sBRRJdZcGOxA=;
 b=ChehM5tDQ4Adl/8xCk2+DKz/X/dXPhr2pq1aOgaKobT9JK6G+VFA6Hu1d+Yckgg8ZiwwLSKOaN9ZIqn50VjPgIjr4U1SN7JZ6xIjEW3wX+lZM7BIZBY6JLj/edyzCfD+FxeOFTSmuXjasIRKJf65HexNoSl9C0zHHrZMQZA6kjw=
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f::20)
 by YTOPR0101MB1466.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.25; Fri, 16 Apr
 2021 16:05:49 +0000
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb]) by YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb%7]) with mapi id 15.20.3999.038; Fri, 16 Apr 2021
 16:05:49 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Subject: Re: [PATCH] irqchip/xilinx: Expose Kconfig option
Thread-Topic: [PATCH] irqchip/xilinx: Expose Kconfig option
Thread-Index: AQHXMk+1X72b4VVgvka/cnIJ9aoOvqq3J68AgAAobAA=
Date:   Fri, 16 Apr 2021 16:05:49 +0000
Message-ID: <2834595e6552c81441592a57dc41146d46484143.camel@calian.com>
References: <20210415233250.4071772-1-robert.hancock@calian.com>
         <87zgxys5xn.wl-maz@kernel.org>
In-Reply-To: <87zgxys5xn.wl-maz@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-16.el8) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=calian.com;
x-originating-ip: [204.83.154.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac94d78-a0a3-4c67-897d-08d900f18089
x-ms-traffictypediagnostic: YTOPR0101MB1466:
x-microsoft-antispam-prvs: <YTOPR0101MB14660F552B1FA10D4A36B5E1EC4C9@YTOPR0101MB1466.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1wepUpjwISDdhcAIK45RkMhUHrRGRLi4NliVW9jqoTC6piaV/FamLi+R++U6gLoH4a/DA4fQNzq0liMB7QVTq6iPAeOUTouDDeNJ/SHU7kRNmBFAl++mjVUCOUzt2DWQMdkR3Pk6Ro6SvsRJl8ZmSRCTGQKYEMQIlHLO7qDDzDo1o2BNqo3a8rOkh5/QALq6vrz/h0Jo40f0/X1SQXkbLxpHiKbB3NmvKlhY8YvkUxJofsRxazDfqok5tJ3FAB1dcN+PhtZSqPUVoLnS5LVRdHR983aThEkS16iVZqULc8axxorc+3uJk9OUis8x2PKlTbs7KlX1GpJFqx6Wd7SEj+AK0MbVyw7gSugTOmRpsxmtEgraPdlwYSwmVIm87DQ2UWRWw8JuRMTY9X17HRuoOPpP88o25T6mE+0RS96xHGq5t0YcvaIgnJmDeBnrtun3cnK346zi1eZUsuuZoldMOcdwwrBFd2AZZr1Ny5rgl8/eSweBFgHnrBpjCjZRwD/unIgxF9KkJB54IZyKlkGauMqlhNKLZKL1bbGW9heep94pfAHhoyCmeMWaYP7e8U3rgCyaQksLwoJYYLwEWwfAWcqM+0JmhqqrWA1Pme66N7RxqUeW3RmXrXXzKOUcZ7H6ogcppfyh2jly8dP5osrrm2BlAyCBqUSxbsvl0dlfPGrm7PVY+ZWk2JMjEdBZ000x4ztPDMsMP/oBHc/UHVBY7mNaeCHJOIym/X4zmnogybJhD7Ksi8vVkf4Jzc7TCl4nQvC3O//3erQPiCOO18K2kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39850400004)(346002)(376002)(54906003)(6512007)(66476007)(64756008)(478600001)(8936002)(15974865002)(316002)(44832011)(6916009)(86362001)(4326008)(66556008)(66946007)(91956017)(6486002)(2616005)(76116006)(5660300002)(66446008)(36756003)(26005)(6506007)(122000001)(2906002)(38100700002)(8676002)(83380400001)(71200400001)(186003)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QkdUaFNCbTRFSXVtSlN1ZWNybm9GcEpKZnZRelY1d2d2ZUN1N3RUdzlXVnRL?=
 =?utf-8?B?N0xZNHcvcnFQUlhnSFJDTXRnWG9JQTRSWXRVMGpSeXdtMk5NMmI2RGJMUGMw?=
 =?utf-8?B?M3huV1BBZ1l4b3BCSm5iWVo4TDhVU3RPZWNUZ09BcldKYXpwZ0g5L1dSWFVJ?=
 =?utf-8?B?Y211Um5QTEJxUC8xcmFwOWowNnd1cExJOE5WN1NEc28yWEgyT0hFd1U0Q3p1?=
 =?utf-8?B?ZGVKbDZVZWhvcUtVVjNyZ0k2WjZicVpWSVFXck53T0VOWW9kc0hSaHNzM1dH?=
 =?utf-8?B?RzB1T25CUS9RSTBpTW5PYWtBNkNjeWFkQkp1cUNDZFRPTFZzMlY2Z3g3UWZn?=
 =?utf-8?B?ZlBCa0dRTTJxWTRBeVVVTUJXY0NnYnhwamNsVVVDOEpQY1BXdkxybW5OSnBS?=
 =?utf-8?B?SkVpRm9PL1ZONVZQR3RKN2YyeHlCRkcxQmpOS0NVOExiNkYvZnFWNXhsSm5D?=
 =?utf-8?B?NkxhYXEvb056TFJSRGJvSzJQVXdEVUsrYzE5TXNCREJrK0tEL3p5VGNGYXVw?=
 =?utf-8?B?T0hETUhwaElGQkpzZjB4UGovV1JzWmJMQklqSHU4RW9ReTdjekV3SDNZcjJq?=
 =?utf-8?B?NVdiKzVPMXZya3BpbDVKY2J0RERwSnpsYmk4TGVNNWNOMyt2SjVmcXMrR21B?=
 =?utf-8?B?WXVoS2FVYnd0ckdpSTZ2bG9ubUxlU2JabE9ZN3FuVWlpMmhSTmtGL3oxMHFv?=
 =?utf-8?B?QmRkQlBPTXVpenVxeDRmaVlkeWZ0dE9uQUJtSEIrdlFnZ3FEVWZxSVpwL1Ja?=
 =?utf-8?B?TDdBTVd6bFU4Rld1MXRha0d4Y3RvMElTYjJyVk1Kd3l3ZmdrbkQrSWpTNFkz?=
 =?utf-8?B?QmFKeUtML0tqMzJ4NUZYVklVZi9UajdDNUMxbk55L3g2STNmbk5GclpKb1V2?=
 =?utf-8?B?OTBuMjA1ZXpQck1iYzVLNWl4M2VsYzMvb2J0b2lQOWFVTCs2ODJXNkxnZXZn?=
 =?utf-8?B?OU1uK2tjQ2NmWXcraldvdzgxNXNvbmRiMEZBMElDS2RVcEpZT2QzYmtCRXZR?=
 =?utf-8?B?RUR0azVZTm9oMVZZZDJPMlhoSWh6cmRMZXdWa3VBcEF0ckxleFUyTk9ib2VO?=
 =?utf-8?B?dXBubXQ3WXVyTitjRk8zRm5qcGZvSTZlaW5RampRRko3TDRQN2lPVzlMSzV4?=
 =?utf-8?B?M2lRaEtXNHd3b0Nkc1kwZ2JqNERFbm8wRTV2bzVUQlpBVzlERnQ5NWRVR1RU?=
 =?utf-8?B?ZkloN2NtS3pwU3doNVlyM0ZjSDExUS9aQ0wzd2IxSkdBbjlUb1dHZzFGbTk3?=
 =?utf-8?B?SnFzZjdEeGJzVnJ5dEI0L1hHUzcyV1lhdzJtRGtWV3JRNVF5NC9YRzB5NE9B?=
 =?utf-8?B?OWlyV1dEeXpKblBuVXFoWTFaMmo1MysyZU10QUw5MlF2S1RjbGtBYlJvRUhC?=
 =?utf-8?B?WnRJRzFOSXl4SlpvSTRlbmRkazVEVDlKRFI5YW9RM2JoL1RkU21PdDBzWTFH?=
 =?utf-8?B?c3Frc0xSdWNLNERtalRVbHd2SzdkUHpmOXlKb1NHRjI5by9EVS8xK3VXMU05?=
 =?utf-8?B?aHpHbENmOUdmdUlrZC8rUWdNRXExb3QvM2oxdmpjOUJzenI4OEg1MDJGSW0w?=
 =?utf-8?B?cUFKeHRweWxOVHdLMEptRm4vYnIxNm5RdERHV3pXeklVaHFLamdiU1loS1VC?=
 =?utf-8?B?VWtjSHNROU92YkJWeHlIMkJIajEva3cra1Vmd1hEMTg0OTdLTnpIM1VCbnNu?=
 =?utf-8?B?TGFQM010SFEyc004OHMySXY4T1ZZU2NXZGlXUXZxQ0ZqKzFab3ZKRVp1SkRL?=
 =?utf-8?Q?chgIFtYisr07BRjQoWnTRynQb7zz0vR796Xy94L?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7F51401A73983428615424D02B81459@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac94d78-a0a3-4c67-897d-08d900f18089
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 16:05:49.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c8/Tmytsl15aSD0+kNcKKBC3BqXpdzTndRgsbq9Zopvot6s5GmHP4MjK2uQi97suoFURM9NAdVeN98DzyGh1tsuusNCQ7dWe5WJl4pzKmQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTOPR0101MB1466
X-Proofpoint-ORIG-GUID: DFFNMN8V4J4mqpAfdaEXj025cGcfxST4
X-Proofpoint-GUID: DFFNMN8V4J4mqpAfdaEXj025cGcfxST4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=690 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTE2IGF0IDE0OjQxICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIEZyaSwgMTYgQXByIDIwMjEgMDA6MzI6NTAgKzAxMDAsDQo+IFJvYmVydCBIYW5jb2NrIDxy
b2JlcnQuaGFuY29ja0BjYWxpYW4uY29tPiB3cm90ZToNCj4gPiBQcmV2aW91c2x5IHRoZSBYSUxJ
TlhfSU5UQyBjb25maWcgb3B0aW9uIHdhcyBoaWRkZW4gYW5kIG9ubHkNCj4gPiBhdXRvLXNlbGVj
dGVkIG9uIHRoZSBNaWNyb0JsYXplIHBsYXRmb3JtLiBIb3dldmVyLCB0aGlzIElQIGNhbiBhbHNv
IGJlDQo+ID4gdXNlZCBvbiBvdGhlciBwbGF0Zm9ybXMuIEFsbG93IHRoaXMgb3B0aW9uIHRvIGJl
IHVzZXItZW5hYmxlZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgSGFuY29jayA8
cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBh
IGdvb2QgaWRlYS4gSW4gZ2VuZXJhbCwgcGVvcGxlIGhhdmUgbm8gaWRlYQ0KPiB3aGljaCBpbnRl
cnJ1cHQgY29udHJvbGxlciB0aGV5IG5lZWQgdG8gc2VsZWN0LiBTbyB5b3UgZWl0aGVyIGVuZC11
cA0KPiB3aXRoIGEgbWlzc2luZyBpbnRlcnJ1cHQgY29udHJvbGxlciwgb3IgYSBidW5jaCB5b3Ug
cmVhbGx5IGRvbid0IG5lZWQuDQo+IA0KPiBUaGlzIGlzIGVzc2VudGlhbGx5IGEgcGxhdGZvcm0g
Y29uc3RyYWludCwgYW5kIHRoaXMgc2hvdWxkIGRpcmVjdGx5IGJlDQo+IHNlbGVjdGVkIGJ5IHRo
ZSBwbGF0Zm9ybSBpZiB5b3UgaGF2ZSB0aGlzIElQIGluIHlvdXIgc3lzdGVtLg0KPiANCj4gVGhh
bmtzLA0KPiANCj4gCU0uDQoNClRoZSBwcm9ibGVtIGlzIGVzc2VudGlhbGx5IHRoYXQgYXQgdGhl
IHBsYXRmb3JtIGxldmVsLCB3ZSBkb24ndCBrbm93LCBvdGhlcg0KdGhhbiBpbiB0aGUgTWljcm9C
bGF6ZSBjYXNlIHdoZXJlIHdlIGtub3cgaXQgd2lsbCBiZSB1c2VkIGFzIHRoZSBwbGF0Zm9ybSdz
DQpwcmltYXJ5IGludGVycnVwdCBjb250cm9sbGVyLiBJbiBvdXIgY2FzZSwgd2UgYXJlIHVzaW5n
IHRoaXMgSVAgY29yZSBvbiB0aGUNClp5bnFNUCBwbGF0Zm9ybSBhcyBhIHNlY29uZGFyeSBjYXNj
YWRlZCBpbnRlcnJ1cHQgY29udHJvbGxlciBpbiB0aGUgRlBHQQ0KcG9ydGlvbiBvZiB0aGUgZGV2
aWNlLiBCdXQgbWFueSBaeW5xTVAgY29uZmlndXJhdGlvbnMgd291bGRuJ3QgaGF2ZSB0aGlzIGRl
dmljZQ0KcHJlc2VudCwgaXQgZGVwZW5kcyBvbiB3aGF0IHRoZSB1c2VyIGluc3RhbnRpYXRlcyBp
biB0aGUgcHJvZ3JhbW1hYmxlIGxvZ2ljLg0KQWxzbywgdGhpcyBjb3JlIGNvdWxkIGp1c3QgYXMg
ZWFzaWx5IGJlIGluc3RhbnRpYXRlZCBpbiBzdGFuZGFsb25lIFhpbGlueCBGUEdBcw0Kd2hpY2gg
Y291bGQgYmUgY29ubmVjdGVkIHRvIG1hbnkgZGlmZmVyZW50IHBsYXRmb3JtcyBvdmVyIGEgUENJ
ZSwgQVhJLCBldGMuDQpidXMuIFNvIEkgZG9uJ3QgdGhpbmsgaGF2aW5nIHRoaXMgYXMgYSBwbGF0
Zm9ybSBjb25zdHJhaW50IG1ha2VzIHNlbnNlLg0KDQotLSANClJvYmVydCBIYW5jb2NrDQpTZW5p
b3IgSGFyZHdhcmUgRGVzaWduZXIsIENhbGlhbiBBZHZhbmNlZCBUZWNobm9sb2dpZXMNCnd3dy5j
YWxpYW4uY29tDQo=
