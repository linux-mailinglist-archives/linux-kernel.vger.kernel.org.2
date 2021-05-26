Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46F391B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbhEZPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:12:56 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:59436 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235369AbhEZPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:12:50 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3F8CDC076C;
        Wed, 26 May 2021 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622041878; bh=UBmvzT0VcJQeHAEm8FUlLTVIHZFqdIUcfmAV9AEhToE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kgBEY6JM3Q9Tr8njOU9zM3kvVTQnN0pTIdUBc8ipcmD6bB6yNrsHQ5jJatsAtiib5
         sqR3vBdLrt6u8Vtqj2VMJEqDV4eWzsEXNEJfYCYnBtyHanmWC24F3WHrLeKt4RgD7Z
         VlBJ81prHp7FTboN8f2BMIfGr6GYbfehQOxvnY8rZiS2p8rVQ3tSzU1PGWkUOj14d9
         B4nOSQhdXVXs1Xs2wwxgLQXhew7ECUgdQ/Ld5gPDYOJqi3bsqgh4suutD3YW898uin
         1P+W5UOvJPhTZx+U75+fVVtiZK21N0NDR3Y3GQS+4a/Am35+ZyNXTJx3upS9is8qWL
         fprgTWzALmztQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1923AA005C;
        Wed, 26 May 2021 15:11:16 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D7FEA8126D;
        Wed, 26 May 2021 15:11:15 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="obrYalOI";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQiMDSp66TKCQkCLeYn9o3YhTQAjty19mZ/peqhqlxXvuhHhQC81/xfj4HF5xEdXEehBtXA4H+wMpAl/2yp/vzoKwc6xDy4K7tceslmuUxiRdAQOnKm7AzKC+dEWtRevQX0w6Oo3usq4Gi1YheoYl5JFDbl+qpCI2sURuvSEWWNU1GT0xyisZDKdZlibRnzzaL5idjNGacIgPmLEEYsBAMQ5JXXQABEiXnxrBx2NwYnNPE0ONhEQfVgG1v9wKYW3zG6bFsZBI4mIyU+BPOAktXSRqof43PCPUJ7OJLKbDf8r2pUkE5xNiNhsQFg3beESBjECVkOA4Cv1CeQhFyKcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBmvzT0VcJQeHAEm8FUlLTVIHZFqdIUcfmAV9AEhToE=;
 b=b0ZUQ+224T19onmuVU87H60L+raeO9zeTJAIwhxicqk7xDwWZvTxomO3ussMHpzTxqEwCnsJUgGqPvr4+dsDDb7RO47mj7Ic2CuUsOqIjENuolFCI3aXUkBhKH6Qj9kJMxHMRwn/XyZwyD3ml3OdONz6fOBF/YDJwILiPf92OJDyCO1acN+R45i9IVrN2VdfJ2DQZeR9X73t12Q/Y7i6Pz7W74xccMKEssIrI5PR9V04ue2z3Td+58EjBTRn+PeckybW1q0QFNMThKn0EVx1Wb02enpqttYFB727wiSPmzQ1suYUuRxcS8bM6PTLAeFfpCZAg97m8tGZG1TnEb0uHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBmvzT0VcJQeHAEm8FUlLTVIHZFqdIUcfmAV9AEhToE=;
 b=obrYalOIL48gpLYXqhde5c31X6Q0z759B6RzFcpPEMyXXKFrAAVXliviZ5+m/I88XxB3lvk3taB1RF0S2esLdlefqIHmOYEKWT6Xad11uN8qx62IRweWD5nongy+EC/QeNXG+tkVtYQE/0H7grJ2Nof5TZkPBCG3VF/j7sqjfzQ=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:39d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 15:11:13 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458%6]) with mapi id 15.20.4129.036; Wed, 26 May 2021
 15:11:13 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 11/24] usb: dwc2: hcd_queue: Fix typeo in function name
 'dwc2_hs_pmap_unschedule()'
Thread-Topic: [PATCH 11/24] usb: dwc2: hcd_queue: Fix typeo in function name
 'dwc2_hs_pmap_unschedule()'
Thread-Index: AQHXUi8uD7wjLDysE0qEzQpOsYMu06r13l2A
Date:   Wed, 26 May 2021 15:11:13 +0000
Message-ID: <4d2ea19c-ea7f-8c32-4b91-d85219ab90ca@synopsys.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-12-lee.jones@linaro.org>
In-Reply-To: <20210526130037.856068-12-lee.jones@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.93.215]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2d61393-6b3b-4526-eb64-08d9205880cc
x-ms-traffictypediagnostic: DM4PR12MB5309:
x-microsoft-antispam-prvs: <DM4PR12MB5309DE79706BFCC9460188A1A7249@DM4PR12MB5309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VhrFgRYOKx5lRb/kRvuaAQtqttXDtdBaVpYUsF95QGPt5OWhDlRHL9WhidRaMZvRG8OUgtI1oK4x0ASXAVLtItArRZhqX48vRg7HT412Z1R6fGRUUty6LwtHPLwBrC2EoiLeTUhW0sFi+ZHR8yGkVcOh2iANlw9w2TfLshBdt8qJiD2g0/5Atfj4eu4tDPlvdWQBDPpNvYtZz6TzyWrH0XDTP/eSItHBVJHSossGWHWbcPUWOIp5Xq3+BPJ16mZnlAcPlNruC018gDMPvrBYWH9UkGCX1eWBcvaBaxj0ehqlZaq/LYUPhT/1kyAceDvjdd9bIlqIZv+vTciv8SWuR6uqAuOPgBNl8DyY5Hur63eMe3z/9wrsyjP5n/Hfxi0Yom7SN09Ocy+3kMS2wjdeTM72JGlNnFheyXBWpVQUIxYSrizbO4TaPlRFeKaUZUZRnFgI/ms/z04KdUeirFtzxFAlqt7kAKnALMxrzi8MDjynI5f5zon7FJ+Lq1+cy/pvcWGEeQRi+wfglMXvB9UxpCx/dFkjU6z1seOM7zMdwSxivuCANc1sakEZc08Ft7xV+bPRZVhIn0wfZSCWkPb/c4azbIdbaf/e3v9f422t1zdJxYECdgMzHUqHA8/TNWqDdT4F71N1EMR2a+wTWChrFHo+mGQSMGu4pAFslmPGrQuScolY3o4PxzRjDkdS/WJE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39850400004)(376002)(76116006)(2616005)(122000001)(38100700002)(31686004)(6486002)(6506007)(186003)(91956017)(83380400001)(8676002)(26005)(8936002)(36756003)(6916009)(4326008)(53546011)(478600001)(6512007)(71200400001)(31696002)(86362001)(54906003)(66476007)(2906002)(66946007)(5660300002)(66556008)(316002)(64756008)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?V2RnQ1BiT2pQeUJFdlU1Y25FNTIrN04wOU0zdktSNWw5d09GWHZDcWFUemhM?=
 =?utf-8?B?Z0NVREZJNS94aVVTVGFBdWZsaktqTTlyZUF6Tm5WaVo2RDdrYUloRGN2cnBp?=
 =?utf-8?B?VmVJbEZzaTdnektONUZZS204SVVwb3Z6Y3dkNWthazYxbSthemZYbVNRaTZV?=
 =?utf-8?B?bHlsSjFvSkNDM2Q1UmpsUk5acUwxMGhiM3haNjAvaStlcStqVWI2VHJBbkZh?=
 =?utf-8?B?bWMrRS9zN29qQi83ZVpsTkxkNGduOFFEUEtaU1pxWlIyWkViTERlUUpEeEJN?=
 =?utf-8?B?Yy9EMkdpREJTR1NiQ1pmcGpKSzU4MlAzU2NTdWxJbG5YaVNiejdMU3ZNaFgy?=
 =?utf-8?B?dzM0NEVldmJSY2ptakNPbkdCRnZHc3JaTTdvdE5oNVJkSUo3YVdoRnl0aEhO?=
 =?utf-8?B?WE04UlpoZklWVVF5NEtIVkQzQm11VVBJWGUwRUNMN2Y2MXFZdjczWnVrN01T?=
 =?utf-8?B?NzlHcW1sTVNYa2QxNk4vemVPS3hLUGw2UCtpMnA3c0JPL0pjbC9ldG4vUHZl?=
 =?utf-8?B?RmtjWTZuNWFzSTZJRzVhcXlrSDE4c285dVNXUFIxaGRBTmFXd0NDM0JWaGdh?=
 =?utf-8?B?cCtqSGVlRWpQNGZXd1d6a1hvbzJnRG9HNzdZUkpUK1VGNWsxR01UNDd5ck9i?=
 =?utf-8?B?ZnpLZm1relYzVW1YS1k4VWNNazB3b2VqdWFMYzJid2F5aGx6V3VjcjgyTVdD?=
 =?utf-8?B?UGRDK1hURU1pSGlsZ3lncUdPNmQxRWwybFNsOUlYRXdpOUx5ZlNGQ2Y4Qnhz?=
 =?utf-8?B?bXJQYkRvNFdpV1lwQyt6YThialZoTCsxRGh4d0tpSHM0aDQzMjQwZ2ZpN1pl?=
 =?utf-8?B?SlRyaFNzTkN2WmV0TlNCMUg2R0lWWFc2dmxIY1cvdXBjVUVNK0c5cHNqOExB?=
 =?utf-8?B?WjA4aDI4cG1POXJNcERNV0wvWGFjdERVN2NVakttT3lyUFlzcGhIMXZLTnMw?=
 =?utf-8?B?NjVjUy9FT1hxdVZCZ29GTytnVTJhcGN2L2h3dTl3Q2tzcXBMOWhhMzgrVG1I?=
 =?utf-8?B?L3A3dDIrRjlEeE1ka3Izc3UvdlJ2ci9YK3UraUxnWlo4ajMzeFJsa2lKUVNl?=
 =?utf-8?B?UE5tNytKOXlvb1V1REFXQk1jME9DaEo0bS9Bd3NjbVh3RVNpdk5sSGwwOGZh?=
 =?utf-8?B?c0tqa1U4c0tsR2IwNjVBVjlsbGNNbmZLdk9ZQ3lxZUR5NDhPcmZLcURVNDgw?=
 =?utf-8?B?ODhGc3ZGLzYvajlqV2VkaWZEdGRQcGo2RFQyajlSeUx5ODgwakRNMXFoMjFB?=
 =?utf-8?B?QVRmMC9Dc2pDSlBSVTVNUlFjNmE3SFZSZGRhZXJTZldIdHo1OVhTaHRGcXc1?=
 =?utf-8?B?UUovUVA5SUtNdys5cVNJOStrenJlMFBaODcrQTBoMjBMcUIvWmF3L1g0NWN5?=
 =?utf-8?B?UjdBWW9POXptUjRGWjdEdGpGZ3FxbmNNVzZ1L1lKWlcxclFHbmFxWE9HbWdi?=
 =?utf-8?B?M0hOTElHV29BYkdrN25LUUozcERDK08yNVBYRGI1cHpuSjJLNnJwREhpdUxa?=
 =?utf-8?B?Y0JES0kzNG9WWnpyNjhyTU50OEVTRVN6ZlBuOVRTTjRrVHJRZDd4WC9Ybldn?=
 =?utf-8?B?SlZzaDFwNEc3SGlPeWsybEhuNXY5cURTVW55OWdSa2JwYXBRT2tsSlZSVFFV?=
 =?utf-8?B?aVlteUVtODc2SWtOZXNpZG54U3h5NnpqUHMxZ0JVc1ZxMzdQc2tVUFdTWW1j?=
 =?utf-8?B?aE1IU2g3WWhqWStvT0MxOFNnRlBndWhPa0FHRXBTNjRhQjJrOHVKTnNMMmpB?=
 =?utf-8?Q?Ngh+fgK+Q4diS/yZiI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DF3FA97E938AC40B091BFBECD80127C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d61393-6b3b-4526-eb64-08d9205880cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 15:11:13.8983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AvB7nCcigkq0yLD8IkKjNx1JSJOXQr+JMeIVSoJ34ZBZIiTXIYhFILAWQcHfg710ZoZFrbXWlQlej2+Y77pjLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yNi8yMDIxIDU6MDAgUE0sIExlZSBKb25lcyB3cm90ZToNCj4gRml4ZXMgdGhlIGZvbGxv
d2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6DQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3
YzIvaGNkX3F1ZXVlLmM6Njg2OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBkd2My
X2xzX3BtYXBfdW5zY2hlZHVsZSgpLiBQcm90b3R5cGUgd2FzIGZvciBkd2MyX2hzX3BtYXBfdW5z
Y2hlZHVsZSgpIGluc3RlYWQNCj4gDQo+IENjOiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFzQHN5
bm9wc3lzLmNvbT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+DQo+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+DQoNCg0KQWNrZWQtYnk6IE1pbmFz
IEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCg0KPiAtLS0N
Cj4gICBkcml2ZXJzL3VzYi9kd2MyL2hjZF9xdWV1ZS5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzIvaGNkX3F1ZXVlLmMgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZF9xdWV1ZS5j
DQo+IGluZGV4IDYyMWE0ODQ2YmQwNWEuLjg5YTc4ODMyNmM1NjIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdXNiL2R3YzIvaGNkX3F1ZXVlLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9oY2Rf
cXVldWUuYw0KPiBAQCAtNjc1LDcgKzY3NSw3IEBAIHN0YXRpYyBpbnQgZHdjMl9oc19wbWFwX3Nj
aGVkdWxlKHN0cnVjdCBkd2MyX2hzb3RnICpoc290Zywgc3RydWN0IGR3YzJfcWggKnFoLA0KPiAg
IH0NCj4gICANCj4gICAvKioNCj4gLSAqIGR3YzJfbHNfcG1hcF91bnNjaGVkdWxlKCkgLSBVbmRv
IHdvcmsgZG9uZSBieSBkd2MyX2hzX3BtYXBfc2NoZWR1bGUoKQ0KPiArICogZHdjMl9oc19wbWFw
X3Vuc2NoZWR1bGUoKSAtIFVuZG8gd29yayBkb25lIGJ5IGR3YzJfaHNfcG1hcF9zY2hlZHVsZSgp
DQo+ICAgICoNCj4gICAgKiBAaHNvdGc6ICAgICAgIFRoZSBIQ0Qgc3RhdGUgc3RydWN0dXJlIGZv
ciB0aGUgRFdDIE9URyBjb250cm9sbGVyLg0KPiAgICAqIEBxaDogICAgICAgICAgUUggZm9yIHRo
ZSBwZXJpb2RpYyB0cmFuc2Zlci4NCj4gDQoNCg==
