Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31DF36278D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244543AbhDPSPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:15:16 -0400
Received: from mx0d-0054df01.pphosted.com ([67.231.150.19]:36739 "EHLO
        mx0d-0054df01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239524AbhDPSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:15:12 -0400
Received: from pps.filterd (m0209000.ppops.net [127.0.0.1])
        by mx0c-0054df01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GIBSLH028162;
        Fri, 16 Apr 2021 14:14:42 -0400
Received: from can01-to1-obe.outbound.protection.outlook.com (mail-to1can01lp2056.outbound.protection.outlook.com [104.47.61.56])
        by mx0c-0054df01.pphosted.com with ESMTP id 37xgw48rcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 14:14:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpL0d7M2LrVIyD7h+CPzmPnzEU0WDPlACscCorSRQKx8L84f206SrXI2hBTdXNaeWreVJTsCMQI08UPleFTDEaY9124WZcbv6nyY2Lv5JsI1L8R9ILDtTfMuMkxzJUH1E2KDTvTr7UVc7IZDZp0mrpOiJlcBVqbBebxGVJB4kZXBmUF++cOzEdi4ZXh4sFhWlEQedWnnm3gWRYaLAFgyBtQRzTJhihzMTMkkMwWZU8wyF2hwdB26hAsNeoXlFQ0EF8eNe/lXTMosnskAIFuNVjtawyTxuQtaaiDSOHv9HwMdnLi5FGwh/I58kZsJO/gYSxyEYBbA1p6+p3gqkG9UIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBer/c9uQMgL7n9+kuxbfYDwBCstImIVi+UNtdTVH7Y=;
 b=apBVOqzR37mEk7ChM7GXnYzs2O+A7z4dGDFeGHePZ1dO71jLPBRi4R/Tk8BxUzumZ2Uvz9BDvlIhrnzfiq4tvEMrGR4gf5WUAmH4Cuf3LFHHBrh/1UyVAGFhco/YSJ4A3FahKODXKKUd4gGQg075nFO3PEqyFtySfeg+c3VDlv/mqLgGng68mzQr+kncl3ZuQyLCbABBS94ypOWaVppmFBqqweqHVV8nv6e91TrODvvyIQr5Udc57CPAriNEQyJW4eot26Dr3pyg/KIxX2XrjRTz4ApyvxCBiTyTFBZCkw2wqVw8FZydxCvsxCAR8NFhA/dwVRmvL76Z9kc8L29gOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=calian.com; dmarc=pass action=none header.from=calian.com;
 dkim=pass header.d=calian.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=calian.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBer/c9uQMgL7n9+kuxbfYDwBCstImIVi+UNtdTVH7Y=;
 b=anoLyyfPNu7US5th8OeODKOWQmsp7IfTi70tL768eJ85WeFjJnMCDFFNHbX/LhXSValimENcqvVLBaA0VQdxa7Bx6s6vl1DTaiz6DDsJ8ds3QcuPFzeE4w7cXnuZbPGDxH+Mi93+BRXw7rY0/C8SFrQud9i4ixQszsW1osdRzgE=
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f::20)
 by YT1PR01MB4409.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 18:14:41 +0000
Received: from YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb]) by YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::90d4:4d5b:b4c2:fdeb%7]) with mapi id 15.20.3999.038; Fri, 16 Apr 2021
 18:14:41 +0000
From:   Robert Hancock <robert.hancock@calian.com>
To:     "maz@kernel.org" <maz@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Subject: Re: [PATCH] irqchip/xilinx: Expose Kconfig option
Thread-Topic: [PATCH] irqchip/xilinx: Expose Kconfig option
Thread-Index: AQHXMk+1X72b4VVgvka/cnIJ9aoOvqq3J68AgAAobACAAB4bgIAABeYA
Date:   Fri, 16 Apr 2021 18:14:40 +0000
Message-ID: <87916c069789a91a5bb0856c6ff9d72c36a59dd5.camel@calian.com>
References: <20210415233250.4071772-1-robert.hancock@calian.com>
         <87zgxys5xn.wl-maz@kernel.org>
         <2834595e6552c81441592a57dc41146d46484143.camel@calian.com>
         <877dl22k0y.wl-maz@kernel.org>
In-Reply-To: <877dl22k0y.wl-maz@kernel.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5 (3.28.5-16.el8) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=calian.com;
x-originating-ip: [204.83.154.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df5f65c3-e041-441e-ffb5-08d9010380fa
x-ms-traffictypediagnostic: YT1PR01MB4409:
x-microsoft-antispam-prvs: <YT1PR01MB440928D598A2E2FC74697431EC4C9@YT1PR01MB4409.CANPRD01.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /DOqNI/zf3SIMD5Pm5133vhu1GjbEiPOV+flr+bU6AYaSNZSw7vW85QfSks/abjjEOMTy/VIVRzNS7FtK4Ww2SbWPX4PoToA3+TV4rIdIw7VILUkV+GtdsC6+c2hR3mJbun4fEK5gWF3l2HRcWT/VTc4Rx/Lw/mSSQ8mb67uUX6/2StDbu652H85xA8KmNmgM2ms3YtBzaZiVF/Pz/A8C0QXDJtTTfIP5SVeHswEE0Twr/E3Mgo8UAifRDr0+4NX/IWfUqgQVYRp2R3xpkp9xOmhELa3ejA4bLuqt/xnAhC51RYeFqnlCdhS4mGDRqvJjp3yet2Qym96uFz5bz3B5eSntkNPgqb0fmaJBPU0c9UwvxzFsFHzCRZC2c5zplhgyuH4c+J4B3j29vWlZcNGls8t9ARViylgcMXRxS4XQT7NzxhTb8WcGO+kaDESDHzyrv9+sIdFL8YSb9b7MkxZOIi2PBO1blC9lMVQJ5U4B7eojp5sY4ZsQ9ioJmfyNbw68ooc1z8ZU/ZDQacld1VTW/t6K5aeSUU1WPCgPFAkl6Eh9xxorsnCGTlh3MCyIJ8ae1/cfahR0SOY/X8fGtBfR27IPQvG1VwmIwgeTRLO6fMG78L+xjNVSChM742E3DoPez3WQ+Vnq/EPEnvYK9yrxKl/c1wDntiUZVZcdjYOZfXUGwIWAlRZaVJjayyRjlEc2Ll3V8TdfkM4EfxO9Eg8ADcBhLUSm82H2yrikBkRbq2/b8q8yZe2wrj7DnVrZH1oCMa2zRhAKe5+Sv7k7IAwtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(366004)(346002)(376002)(396003)(54906003)(83380400001)(6486002)(2906002)(8676002)(122000001)(44832011)(6512007)(4326008)(8936002)(76116006)(86362001)(5660300002)(26005)(66446008)(64756008)(66476007)(478600001)(6916009)(71200400001)(2616005)(91956017)(15974865002)(38100700002)(316002)(186003)(36756003)(66946007)(66556008)(6506007)(99106002)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b1YzSHBSamZaOXRPVmJ0U2ZxYjlJbEFFS3djZktvYWxKVDFvQmpEcFBpckZz?=
 =?utf-8?B?QURiT29uTVRZVVY1eGxwaXVGTW1LMUdSOVA1dlBrbndQUTBNWndGU2VyVEhO?=
 =?utf-8?B?by9TcDQ5WTZ5OGZBS1dkUStSYTZpZW5Tekd6aG1UdWg3cWJLdVhLdUhoeWZT?=
 =?utf-8?B?R2xXQlZMbUlYNk9KQ3p4WjVOdVp2YUR4VHNhYmxMdWdtS1RFMEp5bGdIK3lm?=
 =?utf-8?B?KzYrcVFrclFiczUwVnNuOXY2bFZtWFhCa3c2cW11a3p1OXp6UHFoS290T2Js?=
 =?utf-8?B?OThZdDJiNmQyUFhjSHQ3dURENTJUL0JoQ0t6N3o4ejhYTEw5N1dHWmhLMzlS?=
 =?utf-8?B?VjNDQmdEQ2NFeE96TDJOV3NETGRTWWZJb0pqV3lFNmlVSEZ0aVlIZ2lvaUZU?=
 =?utf-8?B?KzVDV0kwZ20yOFZDdXFVL21rbGQ2ZXZyQWJUTkF5d3FDMjVPYTZjU09rY0l5?=
 =?utf-8?B?R0VPa2J0c1pGWUdpdGx5dVYxYThaeXFSMHM4UzU0dHJjcVh6R2laT0FoVk1n?=
 =?utf-8?B?SWorWFdlYUI4RXhwQlFrZjNwcUd3VTJZeG41RG1rYWUzdFBMZlluZlUwc1pk?=
 =?utf-8?B?Z0l3RFRWNXl2TlJ1UjlBNTdlVnExd21CL24xTHgrYmtVRG83QXErYWl3emV0?=
 =?utf-8?B?MDNubEZ2ZEpDejAwbXgrTGNnWFJGc0ZxZllsUGF1NFVVMTU2TldUc0tYbVRr?=
 =?utf-8?B?Z3Q0QzZmbEYveXlFN29LZ1JpN2VYZGVhaHR3bTFNSTVtaHVLSTJCSEZKVnlK?=
 =?utf-8?B?bnFORU43YWVYY3A3RjRibVhjd1hhREpSL1Q5WXo0Mi9ma0ZsZDJwNWI2c2d0?=
 =?utf-8?B?cDMzYlp0MDVmelk0Y3oweTZEaTQwSFZKell4RUFXNWJLSzJjNllOMDRNR3hS?=
 =?utf-8?B?ZjFMSkg3Q3pseXJGeUhmc3E4OFRzclVSclJKR1kxeituZ29jdy85Nlh0OU45?=
 =?utf-8?B?SlhxY3FYZGloaXE1c2Mrb3NLZS9GbGoyek1NTFFPU3pWbGMyRTJUY0JpSlZ2?=
 =?utf-8?B?SkVJRDIrY014QUI4bitxK25rZTBBd25FRWNPamlpSXVLZmM0a05JNS9PNkpD?=
 =?utf-8?B?RzAvazB0dlIvd3R2eXpYYitGcUJuem0xWmZadDFaenA3MFU5bTVkcHovQUFm?=
 =?utf-8?B?SUV6U3RYazJXbkkwZkpMT0VQRndrajB2M1ViY2NCNUIwWVBrenFYUThaV3NI?=
 =?utf-8?B?RXRmU2Qrb0hRbzJiRzBvVElQcEtGMW8xZHlaenZoOWIvamxwU25PRmlXOFF4?=
 =?utf-8?B?UHdHWm5ONWxvZ1ZzY2ZTa2R5VVBkSjcrdCtqcnV1M3kyTklRV2EzbHZyYWVE?=
 =?utf-8?B?TnJUbitkRFBVMVJGb2pkajdnV1phQUZUTEcySlVORitLdkRZVThPOU1vQWtx?=
 =?utf-8?B?ZmhGU0hqbUlIenZoNUgvYWMwcHU4Z2xJSGRhUVc0MmUrZE1sMTRmbjZwWkhp?=
 =?utf-8?B?YzBRdmN3UkhDdWdaK2lnN20vamZnVVpDZGw5TkE5TFkrcHpUemN5NDZvRmZX?=
 =?utf-8?B?NlZUWGNsY29uQ1R1UVVyRzVrRDEzS2dEZXk2ZnVEYWR0a3psVFJlVXJOeldK?=
 =?utf-8?B?OXhoLzZwUWtucFJNYWFVdkUySmhRNUt1VEtESkFCUlU3NlBIUjdNUGN1WG9p?=
 =?utf-8?B?cm45SHIzSUxVbVBWb0lWSUlIWGtrMjkzaFNnbVJnODNsWnZ1TFBwY1ZPMS9B?=
 =?utf-8?B?ZEJCWFpCcWMwSTZPdCtSeGpkSDFhQ1loOVZuRnVkQkJkZUdaL05lb2hZVjMr?=
 =?utf-8?B?c3d0RkhsWHhhbnNnalFYQXM0S3dsaU00WFNqQkk5WlBZK1QzWDNVeGhES2hT?=
 =?utf-8?B?MlRWMDVjTTBQK28vTWhyUT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDA8CB0E420A8143B9E0585194E827AA@CANPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: calian.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: YT1PR01MB3546.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: df5f65c3-e041-441e-ffb5-08d9010380fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 18:14:40.9409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b57807-562f-49ad-92c4-3bb0f07a1fdf
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bfkZiGcwZSMmoqDrQl8jXUPZj7qBQ0QJo62zrVQCA8u4TTjsqQMYmoz0rjtnX7daAEV8Pn7WjurjtT6Mw0b66+2JCffzW70bQ7rt6BXmCl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB4409
X-Proofpoint-ORIG-GUID: V8LS1LmOWDC1tlinyVxtmecSLP36NKeN
X-Proofpoint-GUID: V8LS1LmOWDC1tlinyVxtmecSLP36NKeN
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=767 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA0LTE2IGF0IDE4OjUzICswMTAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIEZyaSwgMTYgQXByIDIwMjEgMTc6MDU6NDkgKzAxMDAsDQo+IFJvYmVydCBIYW5jb2NrIDxy
b2JlcnQuaGFuY29ja0BjYWxpYW4uY29tPiB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjEtMDQtMTYg
YXQgMTQ6NDEgKzAxMDAsIE1hcmMgWnluZ2llciB3cm90ZToNCj4gPiA+IE9uIEZyaSwgMTYgQXBy
IDIwMjEgMDA6MzI6NTAgKzAxMDAsDQo+ID4gPiBSb2JlcnQgSGFuY29jayA8cm9iZXJ0LmhhbmNv
Y2tAY2FsaWFuLmNvbT4gd3JvdGU6DQo+ID4gPiA+IFByZXZpb3VzbHkgdGhlIFhJTElOWF9JTlRD
IGNvbmZpZyBvcHRpb24gd2FzIGhpZGRlbiBhbmQgb25seQ0KPiA+ID4gPiBhdXRvLXNlbGVjdGVk
IG9uIHRoZSBNaWNyb0JsYXplIHBsYXRmb3JtLiBIb3dldmVyLCB0aGlzIElQIGNhbiBhbHNvIGJl
DQo+ID4gPiA+IHVzZWQgb24gb3RoZXIgcGxhdGZvcm1zLiBBbGxvdyB0aGlzIG9wdGlvbiB0byBi
ZSB1c2VyLWVuYWJsZWQuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQg
SGFuY29jayA8cm9iZXJ0LmhhbmNvY2tAY2FsaWFuLmNvbT4NCj4gPiA+IA0KPiA+ID4gSSBkb24n
dCB0aGluayB0aGlzIGlzIGEgZ29vZCBpZGVhLiBJbiBnZW5lcmFsLCBwZW9wbGUgaGF2ZSBubyBp
ZGVhDQo+ID4gPiB3aGljaCBpbnRlcnJ1cHQgY29udHJvbGxlciB0aGV5IG5lZWQgdG8gc2VsZWN0
LiBTbyB5b3UgZWl0aGVyIGVuZC11cA0KPiA+ID4gd2l0aCBhIG1pc3NpbmcgaW50ZXJydXB0IGNv
bnRyb2xsZXIsIG9yIGEgYnVuY2ggeW91IHJlYWxseSBkb24ndCBuZWVkLg0KPiA+ID4gDQo+ID4g
PiBUaGlzIGlzIGVzc2VudGlhbGx5IGEgcGxhdGZvcm0gY29uc3RyYWludCwgYW5kIHRoaXMgc2hv
dWxkIGRpcmVjdGx5IGJlDQo+ID4gPiBzZWxlY3RlZCBieSB0aGUgcGxhdGZvcm0gaWYgeW91IGhh
dmUgdGhpcyBJUCBpbiB5b3VyIHN5c3RlbS4NCj4gPiA+IA0KPiA+ID4gVGhhbmtzLA0KPiA+ID4g
DQo+ID4gPiAJTS4NCj4gPiANCj4gPiBUaGUgcHJvYmxlbSBpcyBlc3NlbnRpYWxseSB0aGF0IGF0
IHRoZSBwbGF0Zm9ybSBsZXZlbCwgd2UgZG9uJ3Qga25vdywgb3RoZXINCj4gPiB0aGFuIGluIHRo
ZSBNaWNyb0JsYXplIGNhc2Ugd2hlcmUgd2Uga25vdyBpdCB3aWxsIGJlIHVzZWQgYXMgdGhlIHBs
YXRmb3JtJ3MNCj4gPiBwcmltYXJ5IGludGVycnVwdCBjb250cm9sbGVyLiBJbiBvdXIgY2FzZSwg
d2UgYXJlIHVzaW5nIHRoaXMgSVAgY29yZSBvbiB0aGUNCj4gPiBaeW5xTVAgcGxhdGZvcm0gYXMg
YSBzZWNvbmRhcnkgY2FzY2FkZWQgaW50ZXJydXB0IGNvbnRyb2xsZXIgaW4gdGhlIEZQR0ENCj4g
PiBwb3J0aW9uIG9mIHRoZSBkZXZpY2UuDQo+ID4gQnV0IG1hbnkgWnlucU1QIGNvbmZpZ3VyYXRp
b25zIHdvdWxkbid0IGhhdmUgdGhpcyBkZXZpY2UgcHJlc2VudCwgaXQNCj4gPiBkZXBlbmRzIG9u
IHdoYXQgdGhlIHVzZXIgaW5zdGFudGlhdGVzIGluIHRoZSBwcm9ncmFtbWFibGUgbG9naWMuDQo+
ID4gQWxzbywgdGhpcyBjb3JlIGNvdWxkIGp1c3QgYXMgZWFzaWx5IGJlIGluc3RhbnRpYXRlZCBp
biBzdGFuZGFsb25lDQo+ID4gWGlsaW54IEZQR0FzIHdoaWNoIGNvdWxkIGJlIGNvbm5lY3RlZCB0
byBtYW55IGRpZmZlcmVudCBwbGF0Zm9ybXMNCj4gPiBvdmVyIGEgUENJZSwgQVhJLCBldGMuICBi
dXMuDQo+IA0KPiBOb3QgY29tcGlsaW5nIGl0IGZvciBzb21lIHVzZXJzIGlzIGdyZWF0IGlmIHlv
dSBoYXBwZW4gdG8gKmtub3cqIHdoYXQNCj4geW91IGhhdmUgdG8gc2VsZWN0LCB3aGljaCBpcyBw
cm9iYWJseSBhIHNpbmdsZSBkaWdpdCBwZXJjZW50YWdlIG9mIHRoZQ0KPiBwZW9wbGUgdGhhdCBi
dWlsZCB0aGVpciBvd24ga2VybmVsLiBBdCBsZWFzdCBoYXZpbmcgaXQgdG8gZGVwZW5kIG9uDQo+
IFpZTlFNUCAob3Igc29tZSBvdGhlciBGUEdBIHBsYXRmb3JtKSB3b3VsZCBuYXJyb3cgaXQgZG93
bi4NCj4gDQo+IEFuZCBpZiB5b3UgaGF2ZSBzb21lIG90aGVyIEhXIGluIHlvdXIgRlBHQSwgeW91
IGNhbiBtYWtlIHRoZSBjb25maWcNCj4gZnJhZ21lbnQgZm9yIHRoaXMgSFcgc2VsZWN0IHRoZSBy
aWdodCBpbnRlcnJ1cHQgY29udHJvbGxlci4gQnV0IEknbQ0KPiBkZWZpbml0ZWx5IG5vdCBrZWVu
IG9uIG1ha2luZyB0aGlzIGEgdW5pdmVyc2FsbHkgdXNlci1zZWxlY3RhYmxlDQo+IGRyaXZlci4N
Cg0KSW4gZ2VuZXJhbCB0aGVyZSBpcyBubyBzcGVjaWZpYyBvciB1bmlxdWUgY29uZmlnIG9wdGlv
biBmb3Igd2hhdCBpcw0KaW5zdGFudGlhdGVkIGluIGFuIEZQR0EsIGl0IGlzIGNvbXBsZXRlbHkg
dXAgdG8gdGhlIHdoaW1zIG9mIHdob2V2ZXIgc2V0IGl0IHVwLg0KWW91IGNhbiBpbnN0YW50aWF0
ZSB3aGF0ZXZlciBsb2dpYyBjb3JlcyB5b3Ugd2FudCBhbmQgdGhlcmUgaXMgbm8gZ3VhcmFudGVl
DQp3aGV0aGVyIHRoZXkgd2lsbCBvciB3b24ndCBlbmQgdXAgdXNpbmcgdGhpcyBpbnRlcnJ1cHQg
Y29udHJvbGxlciBpbiB0aGUgcGF0aA0Kc29tZXdoZXJlLCBzbyBoYXZpbmcgYSBkZXBlbmRlbmN5
IHRoZXJlIGRvZXNuJ3QgbWFrZSBtdWNoIHNlbnNlLiBGb3IgRlBHQSBsb2dpYw0KaXQncyB1bHRp
bWF0ZWx5IHVwIHRvIHRoZSB1c2VyIHRvIGVuc3VyZSB0aGUga2VybmVsIGNvbmZpZyB0aGV5IGFy
ZSB1c2luZyBoYXMNCnRoZSByaWdodCBkcml2ZXJzIGVuYWJsZWQgZm9yIHRoZSBjb3JlcyB0aGV5
IGFyZSB1c2luZy4gS2NvbmZpZyBkb2Vzbid0IGFuZA0KY2FuJ3QgcmVhbGx5IGhlbHAgaW4gdGhp
cyByZWdhcmQuDQoNClRoZXJlJ3Mgc29tZSBwcmVjZWRlbnQgb24gdGhpcyBpc3N1ZSB3aXRoIGRy
aXZlcnMgZm9yIHZhcmlvdXMgb3RoZXIgRlBHQS1iYXNlZA0KSVAgY29yZXMgZm9yIFNQSSwgSTJD
LCBFdGhlcm5ldCBldGMuIE9mdGVuIHRoZXkgc3RhcnRlZCBvdXQgd2l0aCBhbg0KYXJjaGl0ZWN0
dXJlIGNvbnN0cmFpbnQgd2hpY2ggbGltaXRlZCB0aGVtIHRvIHRoZSBwbGF0Zm9ybSB0aGV5IHdl
cmUgb3JpZ2luYWxseQ0KZGV2ZWxvcGVkIHdpdGgsIGJ1dCB3aGljaCB3YXMgbGF0ZXIgcmVtb3Zl
ZCBiZWNhdXNlIHRoZSBhYmlsaXR5IHRvIHVzZSB0aGVtIGluDQpzdGFuZGFsb25lIEZQR0FzIG1l
YW5zIHRoYXQgdGhlIHBsYXRmb3JtcyB0aGV5IGNvdWxkIHBvdGVudGlhbGx5IGJlIHVzZWQgd2l0
aA0KYXJlIGJhc2ljYWxseSB1bmNvbnN0cmFpbmVkLg0KDQo+IA0KPiA+IFNvIEkgZG9uJ3QgdGhp
bmsgaGF2aW5nIHRoaXMgYXMgYSBwbGF0Zm9ybSBjb25zdHJhaW50IG1ha2VzIHNlbnNlLg0KPiAN
Cj4gSSBkb24ndCB0aGluayBpbXBvc2luZyB0aGlzIG9uICpldmVyeW9uZSosIGFjcm9zcyBhbGwg
c3VwcG9ydGVkDQo+IGFyY2hpdGVjdHVyZXMgYW5kIHBsYXRmb3JtcyBtYWtlcyBhbnkgc2Vuc2Uu
IFN1cmVseSwgcGVvcGxlIHdobyBidWlsZA0KPiB0aGVpciBvd24gSFcgKGJlY2F1c2UgdGhhdCdz
IHdoYXQgd2UgYXJlIHRhbGtpbmcgYWJvdXQgaGVyZSkgY2FuIGJlDQo+IGJvdGhlcmVkIHRvIGFk
ZCB0aGUgc21hbGwgS2NvbmZpZyBmcmFnbWVudCB0aGF0IGlzIHJlcXVpcmVkIHRvIHRoZWlyDQo+
IGtlcm5lbCBidWlsZC4NCg0KLS0gDQpSb2JlcnQgSGFuY29jaw0KU2VuaW9yIEhhcmR3YXJlIERl
c2lnbmVyLCBDYWxpYW4gQWR2YW5jZWQgVGVjaG5vbG9naWVzDQp3d3cuY2FsaWFuLmNvbQ0K
