Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2259735D991
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 10:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240242AbhDMIEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 04:04:12 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37550 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239617AbhDMIDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:03:49 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AD1B74049B;
        Tue, 13 Apr 2021 08:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618301006; bh=lz1wdZoaKKSH4HYwkH6MrhyNoblF7gJ5gU6NfC/cX/c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gOb8IWQz7YjAS3wae+0L866rR7cnl0FLHhp9mL8dAXHXV9aFWFwUnR+pI8p23kzai
         4EOfMRG+khyvKNMshTjudMiuUfC8E0WzM9UZ0w7a8w0Dv+2oQ2ozIkqgN8Hd1pIqnL
         JGcxLirxj7/UVjwfIQQn9m2aDjxWmYysnamwvIyhCNmwOaPNbILcN5co+6PR2hfw+v
         k0v9zVzMeMdfS/4OuhbCrq634vaxnYCBR5Sovilk6Q12J93+/ZZ1yv9NgH0SX0J4GE
         DA2sSP/h6EEPa4lix9ZIgeGlc4CKb3UiF/m423hVHDwYDrc529pEwdddfl9fe9fzzA
         p3Rc494ZhQB8w==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 83AF5A006A;
        Tue, 13 Apr 2021 08:03:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 90B47800C1;
        Tue, 13 Apr 2021 08:03:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=arturp@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="pybXJ5qI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+xCsuGxz/1os3xPh4qpWQMn6yMeBRdjfleQHrCOIKcoauLC7+UHIEfRDdq0tOipeg0QPAuKKNVPi4hTn7efg4KKEZJr+RuKXIQrecAy8mP2QYN5cN28XVdV7Tc1dl7PsHIO+/4KmP5WXaSo7/X2pccOaAI1CBKTVjztsfUtkBN2pmNXFW+YYJPuTyx0O4vIiZ77tOJkBQtJwso7vGfwCBXvhxu7J8dOsgKaTB41yS83TNGyfxtLejRF+nDI4xoEHVoobX47OEVPFTP8zagr26w7stI9Fr69qDFnkPpdDmHMU1HOwD4VuETHeYCsmIrfn3Bn2QeszSmAJaRjphBK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz1wdZoaKKSH4HYwkH6MrhyNoblF7gJ5gU6NfC/cX/c=;
 b=n3rp8gPKM+iqeB0hFosZIstMz2wPCM+MSNvEFiLtLrpOIXsncsefWK3McYu+Tan97x71dE0FXjKNK0jGN77l5OYC30bZpn4EduHf61o0XpvUGroaqXAsQuKYZmarSGljt9mbUKvRPw9rpUoyMm7k0dP8+uwNqhNEUdKAR1Q6rzzZ8HsgwGs4ubu92CzvQiCQetHjOp+sLEDeyCV5tpf3eCwBBzhhMQ9+qBJxklpoHkhxVu/TX2roD82DUfiLl9VrUsDxg8RvIILqNj2i4etdoxExzkdR21DVUjBf+yRbxUU66SBhchzInsG7xfWSkYzWyc1kd1Lo+QSMrudHuDdIJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz1wdZoaKKSH4HYwkH6MrhyNoblF7gJ5gU6NfC/cX/c=;
 b=pybXJ5qIHK1o+a9ZOeC39X4W4V0oTCcY4FxLLInbVVdcLdcN3I9LGZGFJTQJpHQl3g9YpEj5mIqWmSVhLEbgOIb9pZs5FJ28x6VC3OT7Ik8ohl5eRBUe2j9t5gYV2AqrzzqzhaGuVe9HvrrznTiz8bMOFP9+lMx19efuXbZ3f4o=
Received: from CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 by CH0PR12MB5171.namprd12.prod.outlook.com (2603:10b6:610:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Tue, 13 Apr
 2021 08:03:23 +0000
Received: from CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::b1a0:f306:3b5a:7f0c]) by CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::b1a0:f306:3b5a:7f0c%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 08:03:23 +0000
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 00/12] usb: dwc2: Add clock gating support.
Thread-Topic: [PATCH v2 00/12] usb: dwc2: Add clock gating support.
Thread-Index: AQHXMDepGGRPT9cAjEqbl02AgePLHaqyFoIA
Date:   Tue, 13 Apr 2021 08:03:23 +0000
Message-ID: <9b21e84b-817d-df04-1eb1-78c7ca1c931e@synopsys.com>
References: <cover.1618297800.git.Arthur.Petrosyan@synopsys.com>
 <20210413073600.57846A0094@mailhost.synopsys.com>
In-Reply-To: <20210413073600.57846A0094@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ebcdfd2-9fa3-4475-3820-08d8fe529c54
x-ms-traffictypediagnostic: CH0PR12MB5171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB517173D49450550750E07346A74F9@CH0PR12MB5171.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GRnnPeR6ep7/BSh+FcZa9dW+gKPzEaTCOe86x+w4sb+/gYBJlTFEfVBpUSoLa0leUSgbLAaq87pwpVRoRGAOn2BUU1tzkfqQk6WeN7PG9GHRkjqr8DJQfJupAjh+jb9CivhKpYDQfhHSz4yZpBMyAfRDXLeTFP0DqEF66oHW8XCRiSh/SSHAs6C7Sli+1BLr/vF2KMJ7zAoKhZuxncqg59w1W/+Nkp5JN9IOp8wQj4iv/SOK25tcS9DJYjNi2yvU5+75vuTDXG0CyLTrcCh7O05L1bV4u5ob0dOLOdUwYen5+2epGUD8YkjZt4g7lkpO7fctCth5rPSeyEEz/54nXmGAY68YrPcQ2G8w7GOlo5hvXun5Pk/hCapardJZdc4t7Q/VRTPA0pFdtwTb4HWrTNLOSgpSkDGDaeg3KqVH9dVkAY72Lo9XjRNdZm/WLF376VnLPyqU9WCIY/6pkgDPhxAZk/dBJhk/d+hgivSgMn2/mGDkoN49//NlhQyz+gXnXxskcJI7eTYYkJaJY0/iAikWrh8//LMG4EkDBE9RSgSzWf7oCT9HxCwwR0n1RYkb9sXpk29WHyFWeysOwOENqlymQ0KqAAK0XFgnXIXfmDyOf2YuA+pR8NNpdAPu+Vt8WBF/AgzKivzQ5nyKNEfd94iGR8RqX9NNdHZ+pIHUgAyhzdD2zsYlydhW8b4YUHmTiajOhXNjrRsdSPrSC+C8dZHmJTdaYwbofKQFZ+1WCMZwvarkAMvMlMb+Bo3WxSY7X5XD3b0dyPLrxBcg88SEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(396003)(39860400002)(136003)(8676002)(8936002)(53546011)(86362001)(31696002)(966005)(6506007)(31686004)(83380400001)(2616005)(6512007)(186003)(66556008)(5660300002)(6486002)(2906002)(66946007)(316002)(71200400001)(107886003)(66476007)(76116006)(110136005)(478600001)(36756003)(38100700002)(4326008)(26005)(91956017)(64756008)(122000001)(66446008)(45980500001)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MnozVnpqOEtDZzVNaGNyOWdFcWI2SE5GMUFGdXpJbGh1blViZzBxaGpKRG9m?=
 =?utf-8?B?ZThTaU8yRnlJbkhJWEFJWTBONVVoK3ZJeFJsUGVOU05DWWE0NXZFdENYbmR3?=
 =?utf-8?B?OWhPZ0V3RFFqY2xicjBhdWhBMUFjZ3l1eUpab2t1aC9YV1EwdGxDWEtnam1N?=
 =?utf-8?B?YlBmNVBQZGxsVDBOYWJ5akxXdUhvVCtGYitXYXV1NU9HUThLeUd0Z2Jobm0w?=
 =?utf-8?B?VTR2Sm01aXluSEliV2t2c2RlQ1Y4TC9Gc29qUG5ZazNReHFueHE1Z0VGNVlM?=
 =?utf-8?B?NWprMlJyeGtxS0ZOd3h3YnpxeG1ObGNsMFdtOU1QRFNvV0w0NEE1Rk5iSlV6?=
 =?utf-8?B?Q0JpTXZGR25GVk9ld1BTVFF6VzhkOGErWm5ZOTB2U29Wbno5RkpyN1VYZ3Zl?=
 =?utf-8?B?M2tVUXhHdXFaY0FZNDltZWRkajN5bFVnaTBuRkhRcHp5bnFhbmNpYlh2d1Bz?=
 =?utf-8?B?Ly9JQkkySUlNRnN3Z29XQVhYb2xLMHN1UzErcHFKMkpHbm5Id1NDcFRoRFBy?=
 =?utf-8?B?aE9JMjFTMjFpRE5LcHdKQXZVaUdzU3F0MWdJNUVQK295dVlhcnpxZnFjM1hn?=
 =?utf-8?B?enFRZWpDblFnOWd2eG5wZDdybyttaDBFMGhDOUdYRFZHSDJxZFZnVXVFM0p4?=
 =?utf-8?B?K052MnczbGFoejU1dmxFejQ2Uk5UVWcxQy9OaXkwVi8vcElmYkt1OURoNGs4?=
 =?utf-8?B?Sm5ydzN4dk92eFoyeUo5OVd5Y0hQeGh5VDRVdkZUc2lxWGIyYXlTNGc1NS9q?=
 =?utf-8?B?UTRmMVBCZGMrMVg0Zlg2aW1Rb1cxelpnYk8rTjdsUldFK1FFRWQ0Mmh0UDlv?=
 =?utf-8?B?UjBiWWdjSEFKVHRZUDNBck5aelF4NWFsWVo0a0EwdnRWZ3kvc3dURS9LS09H?=
 =?utf-8?B?MUdqaHVMNHl3ZFFWZTJLd1IzSkR3K0NCRFNZSEZrK3o3enhHblR6UVk5b1g2?=
 =?utf-8?B?YmlSN2Y2M2RPeTRsb2JMWDRDdm1LbE1nZlNMNjZNS0prUExrVkVlN21WS3BM?=
 =?utf-8?B?SEE4cU5mTjFNUmV1TGMwTDFJei9GNkViVGFiTVZSRlBJSXBCMkRCNnVBOXdl?=
 =?utf-8?B?Y3FabmZhQTkvZ3VqdlVYeTVuclpLRXFqeVgvcTdJaEZLU3dTWTBxK1RjMUtW?=
 =?utf-8?B?R1hYNUpTYjMrWHF0eCs5Y1dUUnE2QWp4djhIRHRJa2NPWjltQ0ZOSWg4bmE4?=
 =?utf-8?B?RTFmUWxQdk05akQxaXNpMndKakIvMDcxZml6UzVRZWszMjM5UUJIQ0xmQVEr?=
 =?utf-8?B?MkZlcDFnQWZFSkY2cW1RNTlsZnVGRW14d1h5a1RjU3FDTHVsSXdDRHZ2bUty?=
 =?utf-8?B?WnZ0YVVUR2drc1NpVmpwZEQ2QXFnV0E3QklwUG1XRVlRNjlHVzFHOFlVTXcv?=
 =?utf-8?B?WEF6SjZhOGswdkx4d1pabnBQTWtmZjhnaEJ1ZFJjUCtaL1UzWUFuN1dleGVC?=
 =?utf-8?B?UmZ5eDJrMlJvN0xXOWEvSTFzbUhKQitOZFZPb1k2MnNCZHZzcld3ajY0SUZH?=
 =?utf-8?B?ejdmZVNZY2VFTkdHMzU4b20wZHE3dEdIdlkvT3pDam55WVA0djgrSjVPUm4z?=
 =?utf-8?B?MTRHejJDdE00S2gvMC9ma2tjbFBUb3JUWUJMdlpmTlQrajMwS0prb3pCN1pO?=
 =?utf-8?B?anJ4L0pQZThuV05zWElnK0NtZXdEV2dnZEJLR1dFMmhmWUtDTVEwUHNKT25l?=
 =?utf-8?B?WnkrR2lVbHI3NExzNFhMZ2FMNEZrRG5JbHFlVitiYy9aZlZ0U1ZSaElGekd5?=
 =?utf-8?Q?ijPEAsuuaomRdKehmc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFAE1E0AC70FF74AB747ED8438E5BA42@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebcdfd2-9fa3-4475-3820-08d8fe529c54
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 08:03:23.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3ywfXIvQ0b0+NUiXc2lqVaU0hiiN61wjFf3t3Y69lGMv0EnV+3w9BUk4wZMU7KU5aNU/hnwTSmQusmFFrEeHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5171
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KT24gNC8xMy8yMDIxIDExOjM1LCBBcnR1ciBQZXRyb3N5YW4gd3JvdGU6DQo+
IFRoaXMgcGF0Y2ggc2V0IGFkZHMgY2xvY2sgZ2F0aW5nIHBvd2VyIHNhdmluZyBzdXBwb3J0IGZv
cg0KPiBkd2MyIGNvcmUuDQo+IEl0IGFkZHMgc3VwcG9ydCBmb3IgdGhlIGZvbGxvd2luZyBjYXNl
cyBkZXNjcmliZWQgYnkgcHJvZ3JhbW1pbmcgZ3VpZGUuDQo+ICAgIDEuIEVudGVyIHRvIGNsb2Nr
IGdhdGluZyBmcm9tIFVTQl9TVVNQRU5EIGludGVycnVwdC4NCj4gICAgMi4gQ2xvY2sgZ2F0aW5n
IGVudGVyaW5nIGZsb3cgYnkgc3lzdGVtIHN1c3BlbmQuDQo+ICAgIDMuIENsb2NrIGdhdGluZyBl
eGl0aW5nIGZsb3cgYnkgc3lzdGVtIHJlc3VtZS4NCj4gICAgNC4gRXhpdCBjbG9jayBnYXRpbmcg
ZnJvbSB3YWtldXAgaW50ZXJydXB0Lg0KPiAgICA1LiBFeGl0IGNsb2NrIGdhdGluZyBmcm9tIHNl
c3Npb24gcmVxdWVzdCBpbnRlcnJ1cHQuDQo+ICAgIDYuIEV4aXQgY2xvY2sgZ2F0aW5nIHdoZW4g
cG9ydCByZXNldCBpcyBhc3NlcnRlZC4NCj4gDQo+IEFkZGl0aW9uYWwgY2FzZXMgdG8gZXhpdCBm
b3JtIGNsb2NrIGdhdGluZyB3ZXJlIG5lZWRlZCB3aGljaCBhcmUgbm90DQo+IGRlc2NyaWJlZCBp
biBjbG9jayBnYXRpbmcgcHJvZ3JhbW1pbmcgZ3VpZGUuDQo+ICAgIDEuIEFkZGVkIGNsb2NrIGdh
dGluZyBleGl0IGZsb3cgYmVmb3JlIHJlbW92aW5nIGRyaXZlcg0KPiAgICAyLiBFeGl0IGNsb2Nr
IGdhdGluZyBpbiB1cmIgZW5xdWV1ZS4NCj4gDQo+IEl0IHVwZGF0ZXMgdGhlIGltcGxlbWVudGF0
aW9uIG9mIGR3YzIgZW50ZXJpbmcgYW5kIGV4aXRpbmcgY2xvY2sNCj4gZ2F0aW5nIHdoZW4gYSBw
b3J0IGlzIHN1c3BlbmRlZCBvciByZXN1bWVkLg0KPiANCj4gVGhlIHBhdGNoIHNldCBhbHNvIGFk
ZHMgdGhlIGltcGxlbWVudGF0aW9uIG9mIGZ1bmN0aW9uIGhhbmRsZXJzDQo+IGZvciBlbnRlcmlu
ZyBhbmQgZXhpdGluZyBob3N0IG9yIGRldmljZSBjbG9jayBnYXRpbmcuDQo+IA0KPiBOT1RFOiBU
aGlzIGlzIHRoZSB0aGlyZCBwYXRjaCBzZXQgaW4gdGhlIHBvd2VyIHNhdmluZyBtb2RlIGZpeGVz
DQo+IHNlcmllcy4NCj4gVGhpcyBwYXRjaCBzZXQgaXMgcGFydCBvZiBtdWx0aXBsZSBzZXJpZXMg
YW5kIGlzIGNvbnRpbnVhdGlvbg0KPiBvZiB0aGUgInVzYjogZHdjMjogRml4IGFuZCBpbXByb3Zl
IHBvd2VyIHNhdmluZyBtb2RlcyIgcGF0Y2ggc2V0Lg0KPiAoUGF0Y2ggc2V0IGxpbms6IGh0dHBz
Oi8vbWFyYy5pbmZvLz9sPWxpbnV4LXVzYiZtPTE2MDM3OTYyMjQwMzk3NSZ3PTIpLg0KPiBUaGUg
cGF0Y2hlcyB0aGF0IHdlcmUgaW5jbHVkZWQgaW4gdGhlICJ1c2I6IGR3YzI6DQo+IEZpeCBhbmQg
aW1wcm92ZSBwb3dlciBzYXZpbmcgbW9kZXMiIHdoaWNoIHdhcyBzdWJtaXR0ZWQNCj4gZWFybGll
ciB3YXMgdG9vIGxhcmdlIGFuZCBuZWVkZWQgdG8gYmUgc3BsaXQgdXAgaW50bw0KPiBzbWFsbGVy
IHBhdGNoIHNldHMuDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiBSZSBzZW5kaW5nIHRoZSBw
YXRjaCBzZXQgYXMgdjEgYmVjYXVzZSB2Z2VyLmtlcm5lbC5vcmcgcmVqZWN0ZWQNCj4gdGhlIGNv
dmVyIGxldHRlci4gV2l0aCBlcnJvciBjb2RlICI1NTAgNS43LjEgQ29udGVudC1Qb2xpY3kiDQo+
IE5vIGNoYW5nZXMgaW4gdGhlIHBhdGNoZXMgb3IgdGhlIHNvdXJjZSBjb2RlLg0KPiANCj4gDQo+
IEFydHVyIFBldHJvc3lhbiAoMTIpOg0KPiAgICB1c2I6IGR3YzI6IEFkZCBkZXZpY2UgY2xvY2sg
Z2F0aW5nIHN1cHBvcnQgZnVuY3Rpb25zDQo+ICAgIHVzYjogZHdjMjogQWRkIGhvc3QgY2xvY2sg
Z2F0aW5nIHN1cHBvcnQgZnVuY3Rpb25zDQo+ICAgIHVzYjogZHdjMjogQWxsb3cgZW50ZXJpbmcg
Y2xvY2sgZ2F0aW5nIGZyb20gVVNCX1NVU1BFTkQgaW50ZXJydXB0DQo+ICAgIHVzYjogZHdjMjog
QWRkIGV4aXQgY2xvY2sgZ2F0aW5nIGZyb20gd2FrZXVwIGludGVycnVwdA0KPiAgICB1c2I6IGR3
YzI6IEFkZCBleGl0IGNsb2NrIGdhdGluZyBmcm9tIHNlc3Npb24gcmVxdWVzdCBpbnRlcnJ1cHQN
Cj4gICAgdXNiOiBkd2MyOiBBZGQgZXhpdCBjbG9jayBnYXRpbmcgd2hlbiBwb3J0IHJlc2V0IGlz
IGFzc2VydGVkDQo+ICAgIHVzYjogZHdjMjogVXBkYXRlIGVudGVyIGNsb2NrIGdhdGluZyB3aGVu
IHBvcnQgaXMgc3VzcGVuZGVkDQo+ICAgIHVzYjogZHdjMjogVXBkYXRlIGV4aXQgY2xvY2sgZ2F0
aW5nIHdoZW4gcG9ydCBpcyByZXN1bWVkDQo+ICAgIHVzYjogZHdjMjogQWxsb3cgZXhpdCBjbG9j
ayBnYXRpbmcgaW4gdXJiIGVucXVldWUNCj4gICAgdXNiOiBkd2MyOiBBZGQgY2xvY2sgZ2F0aW5n
IGVudGVyaW5nIGZsb3cgYnkgc3lzdGVtIHN1c3BlbmQNCj4gICAgdXNiOiBkd2MyOiBBZGQgY2xv
Y2sgZ2F0aW5nIGV4aXRpbmcgZmxvdyBieSBzeXN0ZW0gcmVzdW1lDQo+ICAgIHVzYjogZHdjMjog
QWRkIGV4aXQgY2xvY2sgZ2F0aW5nIGJlZm9yZSByZW1vdmluZyBkcml2ZXINCj4gDQo+ICAgZHJp
dmVycy91c2IvZHdjMi9jb3JlLmggICAgICB8ICAxNSArKy0NCj4gICBkcml2ZXJzL3VzYi9kd2My
L2NvcmVfaW50ci5jIHwgIDYyICsrKysrKysrLS0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvZ2Fk
Z2V0LmMgICAgfCAgNzEgKysrKysrKysrKysrKysNCj4gICBkcml2ZXJzL3VzYi9kd2MyL2hjZC5j
ICAgICAgIHwgMTc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tDQo+ICAgZHJp
dmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jICB8ICAgOSArKw0KPiAgIDUgZmlsZXMgY2hhbmdlZCwg
MjcyIGluc2VydGlvbnMoKyksIDYyIGRlbGV0aW9ucygtKQ0KPiANCj4gDQo+IGJhc2UtY29tbWl0
OiA5YmM0NmExMmM1M2Q4MjY4MzkyNzc0MTcyNzQyYWE5ZTVkZDY5NTNkDQo+IA0KVGhpcyBjb3Zl
ciBsZXR0ZXIgZm9yIHRoZSBjbG9jayBnYXRpbmcgcGF0Y2hlcyBpcyBiZWluZyByZWplY3RlZCBi
eSANCiJ2Z2VyLmtlcm5lbC5vcmciLiBJIGhhdmUgdHJpZWQgdG8gc2VuZCBvbmUgbW9yZSB0aW1l
IGFzIHYyIGJ1dCBhZ2FpbiBpdCANCmlzIHJlamVjdGVkLg0KVGhlIGVycm9yIG1lc3NhZ2UgaXMg
InZnZXIua2VybmVsLm9yZw0KUmVtb3RlIFNlcnZlciByZXR1cm5lZCAnNTU0IDUuNy4xIDx2Z2Vy
Lmtlcm5lbC5vcmcgIzUuNy4xIHNtdHA7IDU1MCANCjUuNy4xIENvbnRlbnQtUG9saWN5IGFjY2Vw
dC1pbnRvLWZyZWV6ZXItMSINCg0KQ291bGQgeW91IHBsZWFzZSBzdWdnZXN0IGFueSBzb2x1dGlv
biB0byB0aGlzPw0KDQpSZWdhcmRzLA0KQXJ0dXINCg0K
