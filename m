Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F65358DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhDHTyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:54:52 -0400
Received: from mail-eopbgr1400138.outbound.protection.outlook.com ([40.107.140.138]:7836
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231918AbhDHTyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:54:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krCUYuYrZSUl8sy8xFgdJv3Euot8QpH6X/Wo3uZNLNVIb2KZOcKKq9SyBjbZNNJWW6XBKk2c4WyBk99dRvN6sPc/7Lwr4ibkEdWpHVPfyEMxvzwOl5ZPlvW8jw56j+SjB3Ow9J0nwiQjWBb8PsMvWBj4dlwMID4dOT6EjkHkZBcVal+hGqC1XxyWXJrZsE8nZEQve6vBefYF9y8HpD32FA9FfDTLQ9d66oz98KlR0vVPzREWkAInURogwLqlYTZG8bUBK8y5IOn+04YfG+BBtKmRd+1JH6UcImCKHLtiMFs0UF+uX/mHd+o8hZ67QuIQdDAbxSOvWctFvyvhZyr97g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1mGMlpUwCYuoOoaguH1/dylMEqj+Qy0HioXeD0bvbo=;
 b=gBO6HT1WKAoTlRAOWJjhDzBUUmMp/qP2jG3YOBzCFkvD4uJI9m9F4tpNkYh91l4a6BuOqK5rKjCS/OaFE6mNW/GhgWp1iQDV1oNpoF7jefWdgdDAWd0eVkuRU7NeXIdnBHdJGh2mxXeRzkf+BV8Rp9RGplzs54Suo+WDaz8vaDnyTZEm1R/j0DYUvD3jRLWTvkIME2LvwOGCjTIRsFhvVmf8YH59oEqPPwrAWOCvdeAJy6KD6P7iZjmCk4pPbynP6t7GTD+sCTVszGiG0fjkl00MC5MKeircR1O5Hh1YPYTMvl5jfBCtconSWWgW2PkNFuydK4w5NQHjkfnHw1aK+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1mGMlpUwCYuoOoaguH1/dylMEqj+Qy0HioXeD0bvbo=;
 b=b3oTHu3IsLK3/vmlDhikomBgeR93n0YCgVinx/BlXVe+1eoWVJF26itllYt1Y0jAvfde0LdZfCW9w2YZO3ODQyyLJl1FPLMToXoQv0hxSHc8fPeTeXeaIyaQHRRa2sCDJLw0FIx1nJ+xkengr5qtsVWedCz1fHNcZqOA3dpvhzY=
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com (2603:1096:604:7a::23)
 by OS0PR01MB5761.jpnprd01.prod.outlook.com (2603:1096:604:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Thu, 8 Apr
 2021 19:54:36 +0000
Received: from OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433]) by OSBPR01MB4773.jpnprd01.prod.outlook.com
 ([fe80::f04d:9261:4793:3433%7]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 19:54:36 +0000
From:   Min Li <min.li.xe@renesas.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH next v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Topic: [PATCH next v2] mfd: Add Renesas Synchronization Management Unit
 (SMU) support
Thread-Index: AdcssPLi9/st1ao8QfWNISRq9wqu0Q==
Date:   Thu, 8 Apr 2021 19:54:36 +0000
Message-ID: <OSBPR01MB4773762C3922D6E828B615F6BA749@OSBPR01MB4773.jpnprd01.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [72.140.114.230]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9259b3ef-f850-4b46-ebfe-08d8fac82364
x-ms-traffictypediagnostic: OS0PR01MB5761:
x-microsoft-antispam-prvs: <OS0PR01MB5761C0762EBD522961DD56E2BA749@OS0PR01MB5761.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +UGLmlwQVXb+2eBWAwV+gogJss7Yho4WucslfnSIMG1qgWwicNcKzz9OP0J/Klw9VTuXjmbkxfn0bupV33eZSGHyOEMjbcI5uXhNwuJ0FDhVMXOUxHwvbyPuue2BFT19qjywvqyGnmJNVzN3bQJ1pi11jGtyRPXoq5WJnq5yxD7vHCbwo+L63/TWSa0mRlzD3jxp00Zn720lEhr/Jcz+/7T/x/cXHmmqqNAxg8taXfLYoKIo9ftfQ8fK5G0gvhUCa5vc4KOaunRtOA4KyFlNMcy/MGyrYhlYDdAiNpF+rHriZ23YTl+NFixPM1NATW1OkaaYhmzZQdnOfvDoxuAsseZp8PpN6IRbQsk7N28/S62uH1Z31POrYTcN7/bHsV+pvRlg9OTjaELb5QTTIcJwhdL/f4a9f1g9s89TLnLKkKM8zDTsvrh34CX4iQ35xlQALkAQ2thvh34dhLXl45kJQxV6hNVqR0Oz48kPr2efGFdpGSaKwNqH1C/BbJdtGmpEZVYrscYdKv5iiYkgqdssjpnvWSw10rfC/fTh8qd8xt2m+x4Gipz/oTVgz3sYzXlBhPvwNDJh4P/xujJFVZTjOLmcXULx7R08s4Np1SxvylvtJIJO9BquY9wmbpAPQUkv/yPZY69/Aorcfrs1NXBzVSsB8nK25z6bmWWKsz61/s8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4773.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(366004)(396003)(316002)(186003)(558084003)(86362001)(64756008)(66556008)(76116006)(33656002)(38100700001)(7696005)(478600001)(2906002)(71200400001)(26005)(5660300002)(66446008)(66476007)(55016002)(9686003)(6916009)(54906003)(4326008)(52536014)(8936002)(8676002)(6506007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SFZTNWlXaHpQY0pFS1FaTDEvWFM4eXZxL3JmYjI0QnV5b2dxenFOUndtR282?=
 =?utf-8?B?ekdrQ1pUVFZXeVhtdm4reksxVEJnbk1vVkIyYTB4TnhnZEdiZ2trTlgrdFhm?=
 =?utf-8?B?MzI1QTNsdktSVmcrYmYxcUhBRnJpQVJCMUc0cHNtKzEvWXkxbkRuS3BzNkpw?=
 =?utf-8?B?WGl6VHNHdFQranBNYTRGa2I4TGlvLzhhZWFWSzlJb1BkRGFzWTF3aVdSeGlV?=
 =?utf-8?B?NUdOTS9kZHZZb0lUSDNkSWdaZGpwRnFPODdycUxEOEwyaTg0N1hnckxLM3pp?=
 =?utf-8?B?aXhtZXIzWDBwemJkenF2anZtUXppT3ovcC95dy9FWEJ2V2hrT0tYbmd5cWx1?=
 =?utf-8?B?Smp0RHZZNlNSaXhrQ296V2lRTkR2V05TRUVXQU1UbFN4dUlEdlFLZlVQV1FL?=
 =?utf-8?B?UHBEcE5HeWxWNlYyaUF1Z2wxbmFyU3RpdVdENUl6SVhldm9nSTF0bENKTlUr?=
 =?utf-8?B?NXJJaE5KK2swVXlzN29mOFRnckV0K1FhTHA4S0ZTaVVINEsxaEtWY3lvNlMv?=
 =?utf-8?B?U0NGTWZlMWZFMll1eGtPRTIrcFNndituckY0Y1E2cXNpMCt6Vy9USVdjSTlJ?=
 =?utf-8?B?TG1nYU5zM0Znc3huVGx4ZnNGWUVEbmprK3E5TzFSVUl5TGlvb0pSR2xmbkYx?=
 =?utf-8?B?TDBhUHhyb2VMa3FNMGRiSGNEM051NjFNak1NZTRrdkc4SUNBY0VWQnp2SDh0?=
 =?utf-8?B?TFpZeWFITm5QVFd2eUd5RzM3MGhlSy9HRVY3NHZnVDU1bGhTRko4Kzg0NHBN?=
 =?utf-8?B?MGV1MEFDQm1JdGo0TGhzdmFZc1ZVZXZUVmpORUlERTJSOFh0UWVESVViM0pC?=
 =?utf-8?B?S1c5MDg5MHhXelc3c3ROU0VENnJEZVRYQUN1QkVlNE1lVjB3NXBOZHhwQkxa?=
 =?utf-8?B?djJMbjN1UUxKQmMvUEl1aFpVVG1YVDJtcXUvNnZQaFBZMC90QWlqcTN3L3Nu?=
 =?utf-8?B?Y01ld29BTUdOQjhHVHJxTjRnWVl2MCtJbXdBU1ZZbi9mQ2l5TkJtNHBnY1hM?=
 =?utf-8?B?eUJYSkx4akxWMHNMajUvVXNGZGZjV0pRQStlSVQ5S0VuOXFuV0tPZkFLaUQy?=
 =?utf-8?B?VmFSNG0yNFU3Z3NpeFBIb1liUjUwdld4S2prS0RxdkJMUTkrNkVzcy9jNzU1?=
 =?utf-8?B?Y1cxNW9yQm1Fd3dGdSs0SzZvM1FlT0xRaEwxZ3dGczUwNGt0NnQxRnliMnYr?=
 =?utf-8?B?Rm4vY1NkblVQWG1XT0NITDRMb3U4OUIyekY5NHJSNjlIWVk5V29XdXYzUTQ3?=
 =?utf-8?B?ckxiVllGTmhoQVBMUEczYWk2UFh2a24ybzRjWUxJMWdKOEdDSGNkOFp2SnBC?=
 =?utf-8?B?c1RJM0hOc3hwNGh6QXJpZExDdXZDYUpjWFNWZ0luVmEyTy8xdys0OFRGdGhj?=
 =?utf-8?B?MjhYKzJlNlh1dlJVaDNvZkgyTSs2YmlMTXhRUmJvY3gwaUk1V0ZGMTI1eWJ3?=
 =?utf-8?B?UFk1RGpsalo0b2Uwd0R5SEYxRGsyeExCVUhSVkpFQXRMMXIxZ0hCMFlhSEEx?=
 =?utf-8?B?b29nWUFES2lOR1ZjNFpxODRjdzJxeFFjK1RzMDNLdWcyTnJRQnJHSC80bS92?=
 =?utf-8?B?WS9QSDdOTFdOYWdGUlZrOHhuZFpxMC9qSUQ4S0wydW0xWU5GTXA4MFBnOG13?=
 =?utf-8?B?YTZVdldsR0o1Vm52alJCVERyZkVzdUVhUnRUK0VBVGJwbTZ1bS9oS082eU5F?=
 =?utf-8?B?aEFyZllNYTc2Y3VOendkcGVDc1NkY1RSVmxNRDBGazNZMzgxdWFqZ3NML2JC?=
 =?utf-8?Q?uSXuC4zpY+pNE0loYrYkAhcBfjxCLNBoVKg6zZG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4773.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9259b3ef-f850-4b46-ebfe-08d8fac82364
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 19:54:36.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBII7grMdf9fGC4lq10vkySARp9stWyoqv2ZmUQNAqyLDaUzm4F8U8UXdp4ZU4BgdPDOcz3yUTLRqygamqZ/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5761
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlDQoNCkkganVzdCB3aXRoZHJhdyB0aGUgbWlzYyBkcml2ZXIgcmV2aWV3IGFuZCBzZW50
IHlvdSBhIG5ldyBwYXRjaCBmb3IgbWZkIGNoYW5nZSBhbG9uZS4gDQpJIHdpbGwgZm9jdXMgb24g
bWZkIGZvciBub3cuIFBsZWFzZSB0YWtlIGEgbG9vay4gVGhhbmtzDQoNCk1pbg0K
