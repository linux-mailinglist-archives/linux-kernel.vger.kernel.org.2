Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0D5363C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhDSHbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:31:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37330 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233438AbhDSHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:31:35 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 94CD54023A;
        Mon, 19 Apr 2021 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817466; bh=VPuOXF9w6/Vge2r8ubtYz615wHctVsBcRA397ja5H0o=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=fRuaSLwwFLcunFvf4tDmmxO0eyReRLa8F3uz4OoNHlVNFihOaEjBpRURzU/PiGSXB
         lKYTQkMDtaWSNgnZs2oaok8ESSZyGpshdNJGcJIkdKf9PNYNprvhi3MzMXCgSjEPtr
         LcIYv1GnGLmmw9LxA53zX6cmuiyqXVfiELTKQZteOPRJUtDYzaf0lOhgvREHV/MoGF
         B44OMgJ6uzN166wuMxZWpIcaVyJeAAKkXAVtQX6l3Z5tbsxnoWE4fBn8WIigFJsWDe
         zStGZygdT7CvOZIKW1n6iJAd1sNmH9qFOLwMzqdNDCJaJ+hIAAV0fRxhKvkcZ1PTcg
         xZAVwgRTkZpqA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 52194A0070;
        Mon, 19 Apr 2021 07:31:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BFC64800C0;
        Mon, 19 Apr 2021 07:31:05 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wBq/nTRS";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGktXmgJZyd7JPcMq5TCu93Fo3uW2xWuXgeQjCMR7y6DuEGzWRav5bWmKnthySvtWAX4bdUKT4fGcIjSw83IedJPa2pfrpZ3mnboDmfMQtHI+kcItqKEAGSgMt7tpYMZ++N7TVIRsEahrP6uwSI0p9TsQ2Z0NkYfEAWArnNQc1cCp9fl1vJlKeNVOJZIWhlCi85tavLStkUdOEz2BdcSItm+y2pSxoIgMWlFQbQkwBd/F26J8ga/zNd+vpF+PpmEb1n0u5X9JBd4eATNlTIwsxNjS9Vga142BJrpS8TDys+7UaVklWoeDJmWRbDwsW3pg7hXGMrRMczDJcdQp3tD+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPuOXF9w6/Vge2r8ubtYz615wHctVsBcRA397ja5H0o=;
 b=oHlizwZhe0Ht1Wlyd2brJPAOiiKmemG3rHq878MrvOsafYmPnQKofzFc0EYOlWioMrmaDu/uJ86DPcW3gLj6Cj9gNCwqXG4zF0dXz7XpL+7ecDQYqa9pFS/AmWtaY6xHq5+00/EPmLBLw7LMezC0mQP0gre2qEgc+xGgkJLevhD6At9t2AksIgFi89krpQR75rKkKIAJZhco6Aftff/Ex/8YOM2kXRO1ly5HHxe9usDnh5011lS0YsHXWfkNjY/DiNNPiFKFfmGYfmFh7Kb+47M1hcAlnIWUYG4qA03n0oNGyt/xMkLBsgBzP6s+9J/YCSnKDeWH1TmfAyljJjNL8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPuOXF9w6/Vge2r8ubtYz615wHctVsBcRA397ja5H0o=;
 b=wBq/nTRSv78fprK0IAFtW3SQJM/GXMIYXSXFGDjfce/E82VoWmI5KYjoSwmUizT/WsRE6OpA2PTuIqB7POReRdSbSVcviOMkrDAVBsvzHER1XEEI/3iRZpbMrtYczNa1vR6jgu7VKqpw4LTPEuqjijf4ZPa6pfS6IhyDOhfWtPM=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:30:38 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:30:38 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        John Youn <John.Youn@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Vardan Mikayelyan <Vardan.Mikayelyan@synopsys.com>,
        Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/15] usb: dwc2: Fix host mode hibernation exit with
 remote wakeup flow.
Thread-Topic: [PATCH v2 03/15] usb: dwc2: Fix host mode hibernation exit with
 remote wakeup flow.
Thread-Index: AQHXMr6fJ11OpqeU8kO63fsgTLYVWaq7dkuA
Date:   Mon, 19 Apr 2021 07:30:38 +0000
Message-ID: <f058e382-dd73-5978-b48a-0efb0cd167a4@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124707.5EEC2A005D@mailhost.synopsys.com>
In-Reply-To: <20210416124707.5EEC2A005D@mailhost.synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8142a224-270f-4159-8595-08d9030507ba
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB50005E5FFB21AE357EEBC7CFA7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZGJ0wBwM43yBSCvaOZ27RWUVI8hSJEY3lqrBkPYHwNCcURoC9CEcuyMOaoPOxkI6g90fX+QkQvQ6zNtRt1qnn4Kjvx1udQVWOgdStsUEW+yBptkptFUQfE2adn6kFGhB+0Pup7hswD+cMXWxvKz+vsSvb4e65W4LawXcijvBDTaNEx9r/sxg7kfmuz7nIQJnAnCq9sMd7t4P/gfncYU5vHU6GYHtaoOyXatpy5eNchMuikzAr1l/F2RkHipbRjaIx3jLX8Nar90ISNSjJLeG8kTWMLm+NriGFSs+ZA8wPvw0P0WzRzaGyJKObPhykZKoaFJU/LXu4luApZkddFkoaX7vjh/jtGJaOI7DuMXsQifgh4kDDSR9CIXdgMmFlwZzx0wMzIsOXx0T8sEYw3bsLcGTyERWmDSyoOgD/zGdeoeQOXQYzcyCtk69uTmtqmj5NKvCCHWYbyZziBwNAOQOzifLAqjnfm36GSA78aesxMf/U49jPc88Wz7hAJM+ZQhL3AR3hnXZ/AlWMK+R7YAa4DvoRZuU4NgLWqf93N2HzJyN49Wy35UEeOOiNojnuL6h8Fpcu/nfd9HugZuhVynTUKOoxlfmFw7QFgc+GdDSemvA7QejKNpnshXRm8tOBo5WLmj0eZqi1IgET4EAkVbzj9ZelQPiprBoVrVWrjAO0o4qstIQ1jVD/PkMdAMzP3rq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(122000001)(2906002)(31686004)(38100700002)(6512007)(316002)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bldadnNlc3luRE91a2gwSXpZTHVqeDgzVjEyUVNSaTFRSzZXVkg2TkhvUmZx?=
 =?utf-8?B?QzZ0WEt6Q0pIaVd0RnpaWmV5TW16Y0FubWxwMjVPQ1N2dzRhcGVzdGFpN01C?=
 =?utf-8?B?QUJjaGl1Y21XVDJoTjhqNmdMUUxRUVU4V1EwcjFKQzFob3I0MnNiSUZYRWVZ?=
 =?utf-8?B?Qm5FZWQ2V3dVWDdNMllWaEdUbFR2Rzdmbjg4NDJCVXFEN0Q0Wm5CUThISVIw?=
 =?utf-8?B?eGZSTlFJMk9MMVlhK0dVbkVKbkl0d1d2dGpPSnVQZHRMVkRCU2N3R0p0SXhk?=
 =?utf-8?B?bUl3UU9wOXVoV2dVV2tOUUdWQkZIR3NoRW1lc2t2NGpzTkZ2MTJqVWFyWk11?=
 =?utf-8?B?L1ZTcGdkZXpzRjROVUlsdkVldmZhTVozTG1TbXhsUUtJR091VzBsdEpRSU1O?=
 =?utf-8?B?SUgydVoxa3k5YzJ1Q2kvTzg0V1lraXBSN3hEVEIyOWoyMk1KUElvM2xnVFN4?=
 =?utf-8?B?cWtPQzF0YWJkUzR3OG9RNWZuM3lLMGNzUk14bzYwVHg0eE9PbTRhSWpxNHlB?=
 =?utf-8?B?d3FpZG0va25MMmV2dW1TOVlmRmV1OWgySjRIN0tOMk9wNFZQUVJPMm1Fdy9X?=
 =?utf-8?B?UVFZckRCSWlIYjBIVVRLa0pwYXA1T3JjSnpWQmRwU0xoN2wzMWV5NFRCZ2xW?=
 =?utf-8?B?VjQ2a2h3emZNMHlHTm9jTzBxVFhQaWhRMXF6d1lMcjZmVDRDYzZpMDM1UXVM?=
 =?utf-8?B?cFZiMmdUa2k4TmlKaGN1c1o5YUdjV00rRmxwaEJIUnM0YitZQjVxVUU0aXVx?=
 =?utf-8?B?VjFYZy9VRlA2cVUxZVJidU52NkxaNUJaQ1g5di9QcjhpcVNLZjRRUzQwY2J5?=
 =?utf-8?B?VTRnTXVNd3l0aVRNMGwybkJ2cnNsSXp0OSttTlREV3gxeDU0MHF3LzlEcVFU?=
 =?utf-8?B?TytHTXNjOG4vWEMwdmVzOGIzSWlvaVRkMUdzQ3J3dVRTaXJKd3FhM293UHph?=
 =?utf-8?B?OFNVZzZaL2Z5NU1INEc4d0ZmZU9tN0lDbStGOTE5WjJ1TWZST1dPRjN6NWJt?=
 =?utf-8?B?NGh4Y0huaGxGMFpsd21Id3piZ3M4Q3N4OWJlQVpCbVUyRlhmcmZPbWpJMi9C?=
 =?utf-8?B?ZlUxMU5ZOHB4NmRRT24rMEE5ay9HOXJwNUo3WEtTY2hKT3QraDFKLzJBclh1?=
 =?utf-8?B?b05veUxEZktqV000aE1GNzlhcXRLVmZlZUxiTWdzUlVTelRuOFI2RGFPM3Jk?=
 =?utf-8?B?WkRVUnlGTUMxODEyMERQazFhOEl1Z3JtR0dXRDFpWjlxR080V29CTkdiV0Ey?=
 =?utf-8?B?dkJJeWhFZExPSldpWVVOL1lsbi82eTNaNmt4TFZkUXFoQlNIREZNRjZRdzdy?=
 =?utf-8?B?U2xWaVB0eVY0UGNjcEFIWUN3dENHa3Zzd213d2lybmhLVzBVc2xYc2crYUxt?=
 =?utf-8?B?SFhoTTM5WWUxMXBwZlVnMDFwRkMxZlRoZ2dLOW9kZCs1WUVUcnVjeFVYUzBU?=
 =?utf-8?B?bnQ1QXZxWXJRWGpHUGh4Zk9pUHhSWlZGTHhyWjdnUjczQ2Njbno4Q21icStV?=
 =?utf-8?B?R2FDNU0rT3FRMXZ6TlVMdVJPeHV6MEc3a25kTDhzZWRyMmFmTFdxV3A0MHhP?=
 =?utf-8?B?eWdYVDJuS2pBbjV4dHZ4aTRhZ3BYZ0MzZmF6Q20zUmxiWlVsTVhwd0FFRW9i?=
 =?utf-8?B?Sm1qeFdKWnRWVDVVR2Z3cEl1NnA2cDJ0WHlDN3BhWjdlYVBHbG1vREkyWmdS?=
 =?utf-8?B?MWZVanNwSDNsQ0d5KzF1Y25ZWHd0SWl2bjJNWitTOFhpaS9DbUJpeUxHWGsx?=
 =?utf-8?Q?lhZoDicOx7GBA1giEk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF674B089AB8E34E917328E80FC4B91D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8142a224-270f-4159-8595-08d9030507ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:30:38.7470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvOPew2wstvJU2xl9UR5/LIK4vHe+8lsEmVhMHa+k41/YHNL6gsrdKpli/qlMU3g15DUoxj+VBPABCqBukhUyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDcgUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gQWRkZWQgc2V0
dGluZyAicG9ydF9jb25uZWN0X3N0YXR1c19jaGFuZ2UiIGZsYWcgdG8gIjEiIGluIG9yZGVyDQo+
IHRvIHJlLWVudW1lcmF0ZSwgYmVjYXVzZSBhZnRlciBleGl0IGZyb20gaGliZXJuYXRpb24gcG9y
dA0KPiBjb25uZWN0aW9uIHN0YXR1cyBpcyBub3QgZGV0ZWN0ZWQuDQo+IA0KPiBGaXhlczogYzVj
NDAzZGM0MzM2ICgidXNiOiBkd2MyOiBBZGQgaG9zdC9kZXZpY2UgaGliZXJuYXRpb24gZnVuY3Rp
b25zIikNCj4gU2lnbmVkLW9mZi1ieTogQXJ0dXIgUGV0cm9zeWFuIDxBcnRodXIuUGV0cm9zeWFu
QHN5bm9wc3lzLmNvbT4NCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1
dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgQ2hhbmdlcyBpbiB2MjoNCj4gICAt
IE5vbmUNCj4gDQo+ICAgZHJpdmVycy91c2IvZHdjMi9oY2QuYyB8IDEwICsrKysrKysrKy0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9oY2QuYyBiL2RyaXZlcnMvdXNiL2R3YzIvaGNk
LmMNCj4gaW5kZXggY2RhM2Y5MzExOTVkLi5mZjk0NWM0MGVmOGEgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzIvaGNkLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBA
QCAtNTY1MCw3ICs1NjUwLDE1IEBAIGludCBkd2MyX2hvc3RfZXhpdF9oaWJlcm5hdGlvbihzdHJ1
Y3QgZHdjMl9oc290ZyAqaHNvdGcsIGludCByZW1fd2FrZXVwLA0KPiAgIAkJcmV0dXJuIHJldDsN
Cj4gICAJfQ0KPiAgIA0KPiAtCWR3YzJfaGNkX3JlbV93YWtldXAoaHNvdGcpOw0KPiArCWlmIChy
ZW1fd2FrZXVwKSB7DQo+ICsJCWR3YzJfaGNkX3JlbV93YWtldXAoaHNvdGcpOw0KPiArCQkvKg0K
PiArCQkgKiBDaGFuZ2UgInBvcnRfY29ubmVjdF9zdGF0dXNfY2hhbmdlIiBmbGFnIHRvIHJlLWVu
dW1lcmF0ZSwNCj4gKwkJICogYmVjYXVzZSBhZnRlciBleGl0IGZyb20gaGliZXJuYXRpb24gcG9y
dCBjb25uZWN0aW9uIHN0YXR1cw0KPiArCQkgKiBpcyBub3QgZGV0ZWN0ZWQuDQo+ICsJCSAqLw0K
PiArCQloc290Zy0+ZmxhZ3MuYi5wb3J0X2Nvbm5lY3Rfc3RhdHVzX2NoYW5nZSA9IDE7DQo+ICsJ
fQ0KPiAgIA0KPiAgIAloc290Zy0+aGliZXJuYXRlZCA9IDA7DQo+ICAgCWhzb3RnLT5idXNfc3Vz
cGVuZGVkID0gMDsNCj4gDQoNCg==
