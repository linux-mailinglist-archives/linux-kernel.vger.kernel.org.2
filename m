Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED26346DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 00:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhCWXrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 19:47:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50088 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231277AbhCWXrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 19:47:14 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 966B6406F1;
        Tue, 23 Mar 2021 23:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616543233; bh=iwlIhY03AjnTEjRCcuHznHtf/yhlf1wmp5ieO9K4zAY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=j1TYfRp+Fl2Kkf/9avj11J7XeZaZ+IM9YMqdxt87jo0J/JSStVRUWQyFTClV5tqZQ
         GlzGungF3dTQn4LjKaFxTMoQ1oDImgtd9xH9Jur8psiASRgwQSjPIWm+FYCZE7ex3G
         veYXXzixg1FwLLweuo/ogc5wHlhJ3J5iXhz4VwRT93zXimPi8EJuL1jYjOJXrwIuNz
         m3l52PtvpRtgRV7exchDzoO8d81ActJFUT+VlacytzQtXa+TsvlFzVaatZikI/QFAP
         qlj7HOeAgc4DGAbmDpVMqWVl9mZwwQdk/2gcstpuiLG64a3+rKetu/W6OIM0CzYyJn
         ObqowLm2Sg/ng==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 013D3A007C;
        Tue, 23 Mar 2021 23:47:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EF846800C2;
        Tue, 23 Mar 2021 23:47:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ZxviWLZI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa0Yyrdu64L2xwH28EpxeOCg2w+7tgJDTycpqUZ8pr46bLgGkkQaaXENU7rDAc85kp/8PJVC4xR37LrGivHcv1rIaBU4cyKlmFpIRHskN2LYzlkldKX6IRMI7kgv3w2HcyMbrQ6Q2or6tf6rzjeFPfERKkQY0R3Fbz2Lmq+JNkTFT1d6rzrOKoXfSoPlJhXDTtQaz/kPcCzblFaOIG1YslF40jYlD0vN5ilYy8CEOMWvY3/K8xm1lsRkeahfonwODK5KgmAO4/eryCNZspM8g33mUguFQR6Kolgw0dW5xNWaFNCO6uxO+E4DT8qStXEoDVoELjxh3ghdAS5Nry8bEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwlIhY03AjnTEjRCcuHznHtf/yhlf1wmp5ieO9K4zAY=;
 b=aSbGYICwS1n0/0A1I5GTu7xNvT5VcJaP1MeDxHfVMnILBkmwdvO1Cu0oOrQXJgc7w2wm47r0bh128KSmoWf9BMpsQEghpiQf52OJl8H8ZFtxx+QvRkHOFSJqKghqfRUFAKEYL4MxTsPqGVAtvrBreMyKlV5pFdPgcMWFs2AKbC28Vv7DpAVYh+6kU78qSQfRXWCRlYtIGBVUhyNFwslTOWs+w3hIZasnjcYpz7xN9eOfEGW5FhItF3kskBIPNtWHlkw/SGY0IHHusJlHKBL8/fE6mQe4KL1eQDnQHnTS2u9Fs1cYTKf/232NX7GUa4NJ0qPeSKOAOyREN0ffLlRfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwlIhY03AjnTEjRCcuHznHtf/yhlf1wmp5ieO9K4zAY=;
 b=ZxviWLZIGiyxDlK7kVn/Rs/T7XB0fIpAiRs9d4YhEMjTrv5qlxPfcDS/uY+TTuxPvyw/eoznVyEz7HI1H3p2ebIf9ZHfxQI2I80t7QbGhsjh+OzmekgQ5Kig6l5vcTr1Ss+XOMfXX0Amg5FuV6KcSG7Joa6eKKy0bdtvf7+CYxs=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Tue, 23 Mar
 2021 23:47:08 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::7c97:6a33:14c4:dd8c%6]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 23:47:07 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: Ignore EP queue requests during
 bus reset
Thread-Index: AQHXHKLL7cdvVEBRMk+XgbJ+0C2uUaqMCeEAgAAHrQCAAA8agIAAOmEAgAXpXIA=
Date:   Tue, 23 Mar 2021 23:47:07 +0000
Message-ID: <862b2b75-2c71-d805-086c-7fbcac73724d@synopsys.com>
References: <1616146285-19149-1-git-send-email-wcheng@codeaurora.org>
 <1616146285-19149-3-git-send-email-wcheng@codeaurora.org>
 <eae3f779-acb0-c685-4323-d97c7c5c6296@synopsys.com>
 <1886f649-3da2-de25-405c-69c66876b0fd@codeaurora.org>
 <debcdb02-1164-df83-1174-440dbe31dcc3@synopsys.com>
 <d77bbea0-04eb-9426-5b16-50e408b2e787@codeaurora.org>
In-Reply-To: <d77bbea0-04eb-9426-5b16-50e408b2e787@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79ec4c86-cc63-442c-1131-08d8ee55f860
x-ms-traffictypediagnostic: BY5PR12MB4051:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4051E3191CE5B5FCE2E191CAAA649@BY5PR12MB4051.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHSRGfc+Fs7bwgkKB5L+xENuPJlnN+JZM+Z5dpvsyeqHCfsp9jVjD53b/vXnjAzpYh3onquU/3Boxf8ksIQyLjDNWVeZpiFNlFtXTlOO11uGd5kUxpWOw+Q5NzC8hZ1CpmyUfzKNlJb+8ylAVV8MzsvuYEOiz7Zd2SR8QUXN1DlWHixxQvUC6ugNMSmuVhF+MneHHNZyeG1CBGwXee64tMjO/Jd/L+t5vKgJCN7Sb202qDCw3ZNhPD9UcTgVyPpB1ci2Btg9PMWIaFz/DVy+1Who55v6qgFZxWBQJtYv5/s60m0KL2/Yr07N1jxDcDqPQliZq9jXkrr38NMjRBysrbicYs65xziHHJub5OhqPfo2PCM+dvX9FJEWPya3Qk5HjejN1FWkW0RWJz4zqMw1VSZRZuI5xZIKxUlXJSE0arpbwoMXBfutm7POG0ksr3YfnBd2rN5Q4tGbdd3gMNaVcRLXwMs6LZ2YoIVxX1ZIEjQjCSq3NWrGEGOyXkSqQgon1Y+pq7+hn5ImbEPADRNQu5VEDnPP9pB2xs+chMzYgy2xbgjhpyvUGGoHFKC8oaODO0TM4My2QYoExqbKNFuPJBrEH5wyWl+dg3y+469QbTfGgkNPtmsPGO5WDpmStDTe2UMSTpEKYFW/b91uzhfcL6ny49gWpPG11Gr5ZeHAfA8eoXoQTq6nTbpCO5oeJCCMudItwkwQuaohODKluJts6YqNMmqifyF5VEdmwi2stVc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(136003)(396003)(346002)(53546011)(66446008)(64756008)(66476007)(186003)(5660300002)(2906002)(66946007)(8936002)(38100700001)(66556008)(76116006)(4326008)(316002)(6512007)(26005)(36756003)(6506007)(31686004)(8676002)(110136005)(2616005)(31696002)(478600001)(6486002)(86362001)(71200400001)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aFhhRWpYeWhaK2RNL0FPdVlkdURwM290UWoxYzlVZTloU2ZuQmVMQkh6NkR5?=
 =?utf-8?B?NkpkaEJxSmVRdGlxZTViNEo1cDRwVDdFTWNwek9NeFNoOERiZVRpVHVxUExT?=
 =?utf-8?B?T1Z4bGtEVEhQL1FKMG9vcGdpa3dCOFVTYTlzTkNaaVZKZ3RNcTNqdHU5VG5B?=
 =?utf-8?B?eVlldG9lUWg5RUhKSWxHemI1TUwvVmd3WEdEdmhVejh4c3QzT1pDSTloM0R2?=
 =?utf-8?B?V1VRT3BuUThmelBXMDFma0RtTUZyUUxxSzRLSDdaMVBuUzFqY1U5QzlrRTJL?=
 =?utf-8?B?c05aY0F5Q2VhbWdHaEJFTWx1em5ROFJkamp6UDhIbW9BclJDcmxsb3dXMDVB?=
 =?utf-8?B?SWk1VnVoM3F4ZS9abFg3MmJjSXEzU2dFdDhlK2MraG1xV1pVd0ZVTWlXeVQ0?=
 =?utf-8?B?R0dsd0MwOHJJV25JTUh4YlRiTDM1UHpYeEV3MXJESWtvdkVpdWVUZnR5RDR2?=
 =?utf-8?B?Nkcwa3lXWnprSmtOUVJ4d1BJckVGdmVYUEhXc0ZRNTVGME1FbEJzL0RRN1BW?=
 =?utf-8?B?YmhrVE1vMWV3WHJOOUc3cDNCQUxuVDRiNWNpb3hGbmYzNEF1ZVh4RGFtVkJa?=
 =?utf-8?B?OE5IWEN4Zis5Ukd0U3BrYmxoTTJLQmZsQXV2ZGd3a0FISEJNa29uU0QxSUw2?=
 =?utf-8?B?R3VONEtXb2hIT1UrSGd3V0dNRWVLTWV4bUZTcWYwa3A2bFlEK0xLeEM0K0I0?=
 =?utf-8?B?WCtia01FK3RWOUpPeXR2eFZzK3NmbmR0QzFOVlAwTGtUNmcycnJDeFR3Nllo?=
 =?utf-8?B?ZjdKMUp2andFV2R4dGg0RXY1VTI2UStCUWo1RS9HanRtQXB1ZUcxb0JrVXJj?=
 =?utf-8?B?WitGVkpuUGo0eUhKcnJlaUFzVXRtdTRHWDUvTDdiWXVFN0o0VkhLVDhLWXVH?=
 =?utf-8?B?R1M0QWpmMEtnOUd4Sy8wcTc5aEx1V3VOODcvN3RWZzJDQkRJRjdDZmlBNnpQ?=
 =?utf-8?B?eDk1a0NFU3FkSXFXcUxzRXk5R0pjckNqRHY5bmZNMnY3STVPeFkyOWl1c1hr?=
 =?utf-8?B?dFpqTWFEd0JCY0I4TEN5VGpqaDlucDNjMk9rN0JVWm82eGFsTFA1YWVmeWor?=
 =?utf-8?B?d01DMUQvNGNNKzdhSmdLZWJnbGR4Vmc3SWl4S2ZWSlQwZXdvenFwd3czWGNS?=
 =?utf-8?B?bG9OTWd5cUlQTkdGQzlTNGUzcm4wTlNTVjVicDFyTXlLOWdnODNndmg3OSsw?=
 =?utf-8?B?WmIwcDdXR0hKSUE5YUVQQjkydE5Sd3dlMTl5QmtjS0QrcVh6Rkl6cGJyZm4x?=
 =?utf-8?B?NW1mSEQvR1IrV3pFMHRyTHBmV05wNnJLYVpscXFqNnI4MHd3NE4ycWVvZUlN?=
 =?utf-8?B?c3pFYm16c3lPWk9WZzRKMDduTVhRSko0dk41azVncmZmY25SN1BlUS92c3lB?=
 =?utf-8?B?b2dWeE1VckVHaW56dEZmSnFOdlA4WVM4SlFZL1U0NktHTjFKcGQ0cWNremhn?=
 =?utf-8?B?RTNxc0c0U1VackF6TXdTZi9idG5NMitSWjA1WUQ0eUpRU0VQbmxFVm13RERS?=
 =?utf-8?B?UGEzdWN1Z0xrYzdZU3p2MEp0YnpYOXZjS0dMTHlKcTBsZWJsaFNxUlhGMTZa?=
 =?utf-8?B?ekRjcXlxODJZUm1KaE1abnlLRjVKeWRFZXlLcWtmeS9lMFZha0xpbCtPK2Rx?=
 =?utf-8?B?elVFYnNKdEw4ak9OdlNkQ0NtdVJFa1lrMzdjRDRKcXV5QUVRRWNwelYrQjNL?=
 =?utf-8?B?MTA0TzA5MlFVZ2FOZjBzVVZ1d2FvaVcxZEZDVDdicUN6Z29KT3JzazJoZEM0?=
 =?utf-8?Q?WFZi8f0vEcISTUPVgs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE61D3094F2232419BB126DC847AE518@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ec4c86-cc63-442c-1131-08d8ee55f860
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 23:47:07.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +k1zxSNr2Gan3O0/PxHUd/stUTTBA3N/bWEc/yb+ATkdyVEVFdk0TGGkMRhteEkphbWxu762quUytzc/NXq3Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IA0KPiBPbiAzLzE5LzIwMjEg
NzowMSBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4gV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4+
DQo+Pj4NCj4+PiBPbiAzLzE5LzIwMjEgNTo0MCBQTSwgVGhpbmggTmd1eWVuIHdyb3RlOg0KPj4+
PiBIaSwNCj4+Pj4NCj4+Pj4gV2VzbGV5IENoZW5nIHdyb3RlOg0KPj4+Pj4gVGhlIGN1cnJlbnQg
ZHdjM19nYWRnZXRfcmVzZXRfaW50ZXJydXB0KCkgd2lsbCBzdG9wIGFueSBhY3RpdmUNCj4+Pj4+
IHRyYW5zZmVycywgYnV0IG9ubHkgYWRkcmVzc2VzIGJsb2NraW5nIG9mIEVQIHF1ZXVpbmcgZm9y
IHdoaWxlIHdlIGFyZQ0KPj4+Pj4gY29taW5nIGZyb20gYSBkaXNjb25uZWN0ZWQgc2NlbmFyaW8s
IGkuZS4gYWZ0ZXIgcmVjZWl2aW5nIHRoZSBkaXNjb25uZWN0DQo+Pj4+PiBldmVudC4gIElmIHRo
ZSBob3N0IGRlY2lkZXMgdG8gaXNzdWUgYSBidXMgcmVzZXQgb24gdGhlIGRldmljZSwgdGhlDQo+
Pj4+PiBjb25uZWN0ZWQgcGFyYW1ldGVyIHdpbGwgc3RpbGwgYmUgc2V0IHRvIHRydWUsIGFsbG93
aW5nIGZvciBFUCBxdWV1aW5nDQo+Pj4+PiB0byBjb250aW51ZSB3aGlsZSB3ZSBhcmUgZGlzYWJs
aW5nIHRoZSBmdW5jdGlvbnMuICBUbyBhdm9pZCB0aGlzLCBzZXQgdGhlDQo+Pj4+PiBjb25uZWN0
ZWQgZmxhZyB0byBmYWxzZSB1bnRpbCB0aGUgc3RvcCBhY3RpdmUgdHJhbnNmZXJzIGlzIGNvbXBs
ZXRlLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFdlc2xleSBDaGVuZyA8d2NoZW5nQGNv
ZGVhdXJvcmEub3JnPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQu
YyB8IDkgKysrKysrKysrDQo+Pj4+PiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0K
Pj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIGIvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+Pj4gaW5kZXggNmUxNGZkYy4uZDVlZDBmNjkgMTAw
NjQ0DQo+Pj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+PiArKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4+PiBAQCAtMzMyNyw2ICszMzI3LDE1IEBAIHN0
YXRpYyB2b2lkIGR3YzNfZ2FkZ2V0X3Jlc2V0X2ludGVycnVwdChzdHJ1Y3QgZHdjMyAqZHdjKQ0K
Pj4+Pj4gIAl1MzIJCQlyZWc7DQo+Pj4+PiAgDQo+Pj4+PiAgCS8qDQo+Pj4+PiArCSAqIElkZWFs
bHksIGR3YzNfcmVzZXRfZ2FkZ2V0KCkgd291bGQgdHJpZ2dlciB0aGUgZnVuY3Rpb24NCj4+Pj4+
ICsJICogZHJpdmVycyB0byBzdG9wIGFueSBhY3RpdmUgdHJhbnNmZXJzIHRocm91Z2ggZXAgZGlz
YWJsZS4NCj4+Pj4+ICsJICogSG93ZXZlciwgZm9yIGZ1bmN0aW9ucyB3aGljaCBkZWZlciBlcCBk
aXNhYmxlLCBzdWNoIGFzIG1hc3MNCj4+Pj4+ICsJICogc3RvcmFnZSwgd2Ugd2lsbCBuZWVkIHRv
IHJlbHkgb24gdGhlIGNhbGwgdG8gc3RvcCBhY3RpdmUNCj4+Pj4+ICsJICogdHJhbnNmZXJzIGhl
cmUsIGFuZCBhdm9pZCBhbGxvd2luZyBvZiByZXF1ZXN0IHF1ZXVpbmcuDQo+Pj4+PiArCSAqLw0K
Pj4+Pj4gKwlkd2MtPmNvbm5lY3RlZCA9IGZhbHNlOw0KPj4+Pj4gKw0KPj4+Pj4gKwkvKg0KPj4+
Pj4gIAkgKiBXT1JLQVJPVU5EOiBEV0MzIHJldmlzaW9ucyA8MS44OGEgaGF2ZSBhbiBpc3N1ZSB3
aGljaA0KPj4+Pj4gIAkgKiB3b3VsZCBjYXVzZSBhIG1pc3NpbmcgRGlzY29ubmVjdCBFdmVudCBp
ZiB0aGVyZSdzIGENCj4+Pj4+ICAJICogcGVuZGluZyBTZXR1cCBQYWNrZXQgaW4gdGhlIEZJRk8u
DQo+Pj4+Pg0KPj4+Pg0KPj4+PiBUaGlzIGRvZXNuJ3QgbG9vayByaWdodC4gRGlkIHlvdSBoYXZl
IHJlYmFzZSBpc3N1ZSB3aXRoIHlvdXIgbG9jYWwNCj4+Pj4gY2hhbmdlIGFnYWluPw0KPj4+Pg0K
Pj4+PiBCUiwNCj4+Pj4gVGhpbmgNCj4+Pj4NCj4+PiBIaSBUaGluaCwNCj4+Pg0KPj4+IFRoaXMg
d2FzIHJlYmFzZWQgb24gR3JlZydzIHVzYi1saW51cyBicmFuY2gsIHdoaWNoIGhhcyBjb21taXQN
Cj4+PiBmMDlkZGNmY2I4YzUgKCJ1c2I6IGR3YzM6IGdhZGdldDogUHJldmVudCBFUCBxdWV1aW5n
IHdoaWxlIHN0b3BwaW5nDQo+Pj4gdHJhbnNmZXJzIikgbWVyZ2VkLg0KPj4NCj4+IEFoIEkgc2Vl
Lg0KPj4NCj4+Pg0KPj4+IGNvbW1pdCBmMDlkZGNmY2I4YzUgIG1vdmVkIHRoZSBkd2MtPmNvbm5l
Y3RlZCA9IHRydWUgdG8gYWZ0ZXIgd2UgaGF2ZQ0KPj4+IGZpbmlzaGVkIHN0b3AgYWN0aXZlIHRy
YW5zZmVycy4gIEhvd2V2ZXIsIHRoaXMgY2hhbmdlIHdpbGwgYWxzbyBlbnN1cmUNCj4+PiB0aGF0
IHRoZSBjb25uZWN0ZWQgZmxhZyBpcyBzZXQgdG8gZmFsc2UgdG8gZW5zdXJlIHRoYXQgd2hlbiB3
ZSBjYWxsIHN0b3ANCj4+PiBhY3RpdmUgdHJhbnNmZXJzLCBub3RoaW5nIGNhbiBwcmVwYXJlIFRS
QnMuICAocHJldmlvdXMgY29tbWl0IG9ubHkNCj4+PiBhZGRyZXNzZXMgdGhlIGNhc2Ugd2hlcmUg
d2UgZ2V0IHRoZSByZXNldCBpbnRlcnJ1cHQgd2hlbiBjb21pbmcgZnJvbSBhDQo+Pj4gZGlzY29u
bmVjdGVkIHN0YXRlKQ0KPj4+DQo+Pg0KPj4gVGhhdCBzdGlsbCBkb2Vzbid0IGFkZHJlc3MgdGhp
cyBpc3N1ZS4NCj4+DQo+PiBCZWNhdXNlOg0KPj4gMSkgV2UncmUgc3RpbGwgcHJvdGVjdGVkIGJ5
IHRoZSBzcGluX2xvY2tfaXJxKigpLCBzbyB0aGlzIGNoYW5nZSBkb2Vzbid0DQo+PiBtYWtlIGFu
eSBkaWZmZXJlbmNlIHdoaWxlIGhhbmRsaW5nIGFuIGV2ZW50Lg0KPiANCj4gVGhhbmsgeW91IGZv
ciB0aGUgZmVlZGJhY2suICBTbyBpdCBpcyB0cnVlIHRoYXQgd2UgbG9jayBkd2MtPmxvY2sgd2hp
bGUNCj4gaGFuZGxpbmcgRVAvZGV2aWNlIGV2ZW50cywgYnV0IHdoYXQgdGhlc2UgY2hhbmdlcyBh
cmUgdHJ5aW5nIHRvIGFkZHJlc3MNCj4gaXMgdGhhdCBkdXJpbmcgZHdjM19zdG9wX2FjdGl2ZV90
cmFuc2ZlcnMoKSB3ZSB3aWxsIGV2ZW50dWFsbHkgY2FsbA0KPiBkd2MzX2dhZGdldF9naXZlYmFj
aygpIHRvIGNhbGwgdGhlIGNvbXBsZXRlKCkgZnVuY3Rpb25zIHJlZ2lzdGVyZWQgYnkNCj4gdGhl
IGZ1bmN0aW9uIGRyaXZlci4gIEJlZm9yZSB3ZSBjYWxsIHRoZSBjb21wbGV0ZSgpIGNhbGxiYWNr
cywgd2UgdW5sb2NrDQo+IGR3Yy0+bG9jaywgc28gd2UgYXJlIG5vIGxvbmdlciBwcm90ZWN0ZWQs
IGFuZCBpZiB0aGVyZSB3YXMgYSBwZW5kaW5nIGVwDQo+IHF1ZXVlIGZyb20gYSBmdW5jdGlvbiBk
cml2ZXIsIHRoYXQgd291bGQgYWxsb3cgaXQgdG8gYWNxdWlyZSB0aGUgbG9jaw0KPiBhbmQgY29u
dGludWUgcHJlcGFyaW5nIHRoZSBUUkJzLg0KPiANCkFoIEkgZm9yZ290IGFib3V0IHRoYXQuDQoN
Cg0KPj4gMikgV2UgZG9uJ3QgZW5hYmxlIHRoZSBpbnRlcnJ1cHQgZm9yIEVORF9UUkFOU0ZFUiBj
b21tYW5kIGNvbXBsZXRpb24NCj4+IHdoZW4gZG9pbmcgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zl
cnMoKSwgdGhlDQo+PiBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5HIGZsYWcgd2lsbCBub3Qg
YmUgc2V0IHRvIHByZXZlbnQgcHJlcGFyaW5nDQo+PiBuZXcgcmVxdWVzdHMuDQo+Pg0KPiBBZ3Jl
ZWQuICBUaGF0IGlzIHRoZSByZWFzb24gZm9yIGFkZGluZyB0aGUgY2hlY2sgdG8gZHdjLT5jb25u
ZWN0ZWQgaW4NCj4gX19kd2MzX2dhZGdldF9lcF9xdWV1ZSgpDQo+IA0KPiBpZiAoIWRlcC0+ZW5k
cG9pbnQuZGVzYyB8fCAhZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCB8fCAhZHdjLT5jb25uZWN0ZWQp
IHsNCj4gIAkJZGV2X2Vycihkd2MtPmRldiwgIiVzOiBjYW4ndCBxdWV1ZSB0byBkaXNhYmxlZCBl
bmRwb2ludFxuIiwNCj4gIAkJCQlkZXAtPm5hbWUpOw0KPiAgCQlyZXR1cm4gLUVTSFVURE9XTjsN
Cj4gDQo+PiBXZSBzaG91bGQgZG8gZHdjLT5jb25uZWN0ZWQgPSB0cnVlIHdoZW4gd2UgaGFuZGxl
IGNvbm5lY3Rpb25fZG9uZQ0KPj4gaW50ZXJydXB0IGluc3RlYWQuIFRoZSBFTkRfVFJBTlNGRVIg
Y29tbWFuZCBzaG91bGQgY29tcGxldGUgYmVmb3JlIHRoaXMuDQo+Pg0KPiBTbyBob3cgdGhpcyBj
aGFuZ2Ugd2lsbCBhZGRyZXNzIHRoZSBpc3N1ZSBpczoNCj4gDQo+IDEuICBJUlEgaGFuZGxlciB3
aWxsIGFjcXVpcmUgZHdjLT5sb2NrDQo+IDIuICBkd2MzX2dhZGdldF9yZXNldF9oYW5kbGVyKCkg
c2V0cyBkd2MtPmNvbm5lY3RlZCA9IGZhbHNlDQo+IDMuICBDYWxsIHRvIGR3YzNfc3RvcF9hY3Rp
dmVfdHJhbnNmZXJzKCkNCj4gCS0tLT4gZHdjM19nYWRnZXRfZ2l2ZWJhY2soKSByZWxlYXNlcyBk
d2MtPmxvY2sNCj4gNC4gIElmIHRoZXJlIHdhcyBhIHBlbmRpbmcgZXAgcXVldWUgKHdhaXRpbmcg
Zm9yIGR3Yy0+bG9jaykgaXQgY2FuDQo+IGNvbnRpbnVlIGhlcmUNCj4gNS4gIF9fZHdjM19nYWRn
ZXRfZXBfcXVldWUoKSBleGl0cyBlYXJseSBkdWUgdG8gZHdjLT5jb25uZWN0ZWQgPSBmYWxzZQ0K
PiA2LiAgZHdjM19nYWRnZXRfZ2l2ZWJhY2soKSByZS1hY3F1aXJlcyBkd2MtPmxvY2sgYW5kIGNv
bnRpbnVlcw0KPiANCg0KT2suIEkgdGhvdWdodCB0aGlzIHdhcyBmb3IgZGlmZmVyZW50IGlzc3Vl
LiBJIHRob3VnaHQgeW91IHdlcmUgdHJ5aW5nIHRvDQpzb2x2ZSBhbiBpc3N1ZSB3aGVyZSBhIHJl
cXVlc3QgaXMgcXVldWVkIGltbWVkaWF0ZWx5IGFmdGVyIGhhbmRsaW5nIHRoZQ0KcmVzZXQgaW50
ZXJydXB0IGJ1dCBiZWZvcmUgdGhlIEVORF9UUkFOU0ZFUiBjb21tYW5kIGNvbXBsZXRpb24uDQoN
ClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uDQoNCkJSLA0KVGhpbmgNCg==
