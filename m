Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27E36483A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhDSQbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:31:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51532 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbhDSQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:31:22 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7779FC051A;
        Mon, 19 Apr 2021 16:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618849852; bh=+PJ/Vm95yp/YER/dKff7XYqBgTMbwQELI98GAEvo928=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=cJ1YUWOaj4wbiayxPba7tEZSGlBbkkTuFSdN1X163rGxNpxKpH+ExRRCkRv6mPid7
         35Kc/NvB1QWWgQcMH4G/zj4BVeghicGDpQlqRp2XpKUqQSxRioQkRbaXcogH42pCWR
         6zWT8WugGPDwyMm218GC9lpVtsrm7rM+pvU6nT9ZT5exdiiKM7pgO3LeH60zTnxJGK
         wNrOISzqZ8DYHQSaKQegXDaSwUBbRI5JVX0SDEHh60ugn3d42rYzYj2PGjMdY/U/bS
         1YcEOlTQpACCZ5yW1KIbpq5olReJhUASEjT3rSL9zLNKh+34smLTJovEuLflpYQ3WN
         Y7MDTavi1OvcA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C24EDA0071;
        Mon, 19 Apr 2021 16:30:51 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1D22B8018C;
        Mon, 19 Apr 2021 16:30:50 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="XRlXTt7/";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsTcUeOC/o72RZPCjIWbk+cbqtp8piIPF/alZwW3+e5uiNTDWjjDmHOGnPNDou3hgwPepc3AB+ioPFObhVN5OX0NwlDwA/ifF4k6vs2lEhqPJbvHkUjwlRacsGX99BYm9VpBAjmQH9o7AJPto+BVbcnkuuJjQvFi3s9dLAbGMZpISstka/wz3NeOEq/WuvDKQLd8DNWdZDzLI50mNuTywxkxRV5xVcKNRQsQ2sqREPZheVmW+WLPGeWgx4Qhm5qFC4hugsGD5dLr5R8pmqf3xxa7TsJFBBor5OBOBCyBYgJdDAENxYiMLnb+jSwIrM7nGEhEEIQjaY7eYV+JX5FaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PJ/Vm95yp/YER/dKff7XYqBgTMbwQELI98GAEvo928=;
 b=eD0pE3iO7azFATAURupuctJH8Q3bQK+5VQMufsep1wsyjFXz89MYZcl0W70q9MwJKQWXkQzBrSzUSm1xRxUgf4ok1w9z53qf7LkRAuC1lS4o0AbCcm/kMY/rE+7MrwKjL8sw/yXl2dl1lHnXNSLDawDBPvigP0l1Otchf3OEd2jlOelVELAV9+yvEXV7R7DLNTt9KI+MUvt5asB6en8dWcD2x4l+z5Wx+KmVBV+Zlf+11EOrMx3HJ/FvHDuIZR32MUAFGPSoLj6xzyk7UFsg+qNWO+mVXeDHWrSLPNMlY4iQHQKK+OQbOpVWJmnoK4kjP/2fGRvB9vJPlRDaweiAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PJ/Vm95yp/YER/dKff7XYqBgTMbwQELI98GAEvo928=;
 b=XRlXTt7/sePaocUNgTAA7whasOUERSyXO4pKNsCzoH9M/ktZZKqjC/Ciy0m1vFhF1p/J7a6bAuTDp11kPKegBk3ww2P3RhUw76hKRuxV2MDN7EQk75qRzqH8DEdJUy+vPozrurYDXCXezfQC7hzWX4A/ZBT0gpb9u52NBNbcFos=
Received: from DM6PR12MB3465.namprd12.prod.outlook.com (2603:10b6:5:3a::20) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Mon, 19 Apr 2021 16:30:48 +0000
Received: from DM6PR12MB3465.namprd12.prod.outlook.com
 ([fe80::d03c:b1e8:e718:48f4]) by DM6PR12MB3465.namprd12.prod.outlook.com
 ([fe80::d03c:b1e8:e718:48f4%3]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 16:30:48 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Pavel Hofman <pavel.hofman@ivitera.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Linux USB <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: RPi4 DWC2 gadget doesn't copy data to a buffer in ep0 SETUP +
 DATA OUT transaction
Thread-Topic: RPi4 DWC2 gadget doesn't copy data to a buffer in ep0 SETUP +
 DATA OUT transaction
Thread-Index: AQHW+CsepOTWzTdUVEWkekFV1Dw/f6pS360AgGluHACAADSTAA==
Date:   Mon, 19 Apr 2021 16:30:48 +0000
Message-ID: <57a43b0c-d82a-8931-5063-ffae488cae1e@synopsys.com>
References: <CAB=otbTVxa=nGWF4K1AYcYyPceYYRkC_1HYSb_Nhu6C9RMZEHA@mail.gmail.com>
 <2e068eea-605c-3f7f-904f-2a1d7279879f@synopsys.com>
 <f0379d74-82fd-949f-f151-6b2a0d7b51ff@ivitera.com>
In-Reply-To: <f0379d74-82fd-949f-f151-6b2a0d7b51ff@ivitera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
authentication-results: ivitera.com; dkim=none (message not signed)
 header.d=none;ivitera.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.80.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8803609c-31b0-43e7-2a9c-08d903507d73
x-ms-traffictypediagnostic: DM6PR12MB4124:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB41240B6A3494BAFDCB4B981FA7499@DM6PR12MB4124.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cBYXS77uFFDccOwzOTFtfkivGthGxTqwYWiCif0gBqMKgCNS25EgpY8Yb5jmlcRQelKWkcWqLlVYWpI9M0p5bcYI6FB8KqpUu98/PGVCGP/XlPjfIPOoVoWVsnjPSM+d8di/vXU4ve3sTMMwAn9Jn6Gd5x4SvG7+zEJ3ivzzo/Xr2y66CkJoacqtWy07ouc5mMQjPM+wvGJjU6rVGlr85L7IYDujRoHBNZDmtoiagCeHLb4l3H/ID579bumX1qBI0Tt7ydupxQAucC2nxYzJwWEwp3H6NSqpnvA+I271KcJ3y+Trs0e/Objd9a5Z8N1B6ZCQTSRZF16xIWjbIEif8Jchjw1EZmQSBQ1Wzg6on9Yd9PEz8H0M8+L+dTeN/GrzuePSjBuCYx8qpCr6vfIhmZ3KIcjIwtyeWbbeySK9AGP6dwbXQULcAWW0PYwOG0txH5glGofkWSHu0j6bAfQ0tsZfkb09mpG46QPwMItJuAT+38XKfTsWBaUqzXxjExKMK88nI2oG6/OBwux8lRGiz/DCUFTgMsQZpQ9SaCO6JSmu3msaBNGh3YA7UtRrSLYnxpFO6TLvTWYduORstkXHZUAs9EJgWnmp5frdsnyIvh5av3DCfhhO2iMOSi0F7BevEwjOMt3ucnM0Z+lqsd9Jq5XlZlH2x3wg2G0eD1Rlv+FpLSxd5mrBaSAmrZ7+gXU0xdu9IGjaZv7FWsv8eHm8jkUEDmNB5ptUjreQKS1z2lij7lhWwVnjIvSKgGC0JIh/K8QXo8GM5RuvSpQOS2Nz1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3465.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(136003)(346002)(396003)(316002)(966005)(83380400001)(6512007)(26005)(6486002)(110136005)(2906002)(31686004)(5660300002)(478600001)(86362001)(4326008)(38100700002)(36756003)(6506007)(186003)(31696002)(91956017)(53546011)(66556008)(64756008)(122000001)(8676002)(8936002)(66946007)(2616005)(66446008)(71200400001)(66476007)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eG9zTStobWFiNXQ0MFp3TVFaZ2sxTFYrWnRHU0NHR2tJUUd6Tm81MHQ4Vk5y?=
 =?utf-8?B?TzVKKzFuY3V5ZFhvaEVJNDlpR1lzZG9mbUNoYWhIZmxwQmVMQ0s3ZEFJUnZE?=
 =?utf-8?B?Z3laM0tGTlJCdmdJdTU0NWYxanZEMWVCd0RKOW5jMFZTYXp0dzlkV1hpbzNP?=
 =?utf-8?B?c2tuSTkvaE8wNWI3UE1kbFhDR3YvMW40L0g1MVAvTkc3ZVJXVWlONXNkSzF1?=
 =?utf-8?B?OEVxRkgvVmZwRm1PeTBadTI4SzBQRVB5WHhrMXlIMnROVXZQblRRMlMyNmpG?=
 =?utf-8?B?TURGTGd0Y2VYamMzcHJyTjRTKzNYdzRVdkVtU21oZWxDZnZBd0JYV25KUmlJ?=
 =?utf-8?B?SDNaQno1dnIzU2lZNldaRGhCbGkrajFpZ1RVQTdYeG0ycWdLRjB2REJQeERC?=
 =?utf-8?B?dnhDVmR3MWhXUTZ1WXJvRkV2NkxtbWdXQXBIaU1la25PY2FMZXRERkNiUmds?=
 =?utf-8?B?SEJVdTZ4TnltVDhlaTNCTndDUG4vWEE2UGZZWjBsTzByNEdyb0RpZm9jVWVq?=
 =?utf-8?B?RWwyZFVwZ1FwUUhLN0FqSnNEdS8xQ3d6endZWU9xcFpkdFVLSm9KbmJHZEM2?=
 =?utf-8?B?bGRXdDNXTkh0NGlyM3JLTFRURDIxZVgzcThQOGFxMGVNbHM4VW9Wdm03REhu?=
 =?utf-8?B?Y0s5N2tsdlNKMzJ0N0l0Mm4wUllFcEdnMHlhRXphck9HWU0xQ0hSUlZmMUJS?=
 =?utf-8?B?Sy90V0RheVY0akJIejF2Qy9MdnVVKzBDQ2hrSG9CbXhMQXliNVNjSnlVWkRD?=
 =?utf-8?B?YWxZNEFlbHlCWGpNRGoyZEdoUkQ1eThaU2xPYS9vd05SSks4UGo1SVBDLzZK?=
 =?utf-8?B?c3g3TTVQWlBXTmdnMmQvNmhDV0dHd211R3dVeVZGd0J6NGlnaGtpOVFVNzkv?=
 =?utf-8?B?TVFZdHgwNGRraW02U0NTbnY2R3dkV1FCaEhrTTlKUVpoU2t3ekZQTjZyVTZT?=
 =?utf-8?B?QmlaUkNQQ2xHcWdXT1ZDQm1Wb2c5MkdMY3pJUnhlWEg4bDhqZVVkWUY5dFVQ?=
 =?utf-8?B?VTZSYnBHSHJoMkd2dzVHeDFhdzE2SlltcUdDNVBlS21pZlNpMzFIQkRrQUY0?=
 =?utf-8?B?QVlNSDZlSGlxUDVjNjZwelQ3NTRWc1MwV2g5WmFxbTZlbkxzMXNVbFRGd2xt?=
 =?utf-8?B?c0tzQXNNM1Y3ZjI1KzVKUUptcGdhbjgycEl3ZmU0eEJYSVlkNHAyaXU4STlj?=
 =?utf-8?B?Y3gxTTh4QW9RVkhyMTRhaFBWZmh0bDFubm96QjNJTlVtVVQ2R3l4WlA3a0hq?=
 =?utf-8?B?Um1DeEl5V20xTmQzZXBIY1Y0bUp3VHFTNUlQVk5WOE00VjR6T1djNEk4bmdl?=
 =?utf-8?B?Q1NMTkppN1FvMVZFcnJXZ29pVlNoa2Z3U3ozNzNwTmhJN0pVZ3NxSTgwSmVS?=
 =?utf-8?B?ZUdFS0dFU2RJemNaVGFaemQzWkNpYUJFaHRTanNFbjhVNWQxSzlDQklPQXpy?=
 =?utf-8?B?WThzTWVmUDlod1drZzd4eTZRKzNVVjlzazZKOWlUc09PUnhGMzhlcnN3L1k4?=
 =?utf-8?B?U0kzanBnSFRXdG55MGVOSlNOQXlOK2owdkJ2TWJDME9WRFhGUnNwdTNYVkFh?=
 =?utf-8?B?QW42cENNMkJ4amtOZ1ovb05DOUl0ZHJ3TGlNOVpkVE1nemVNcmcvRHFpc0d5?=
 =?utf-8?B?YWdQNFlvWjdiN1pJODh1VUZ0T0ZadGJGYnJRdFpBb0JnQ1ViaENXSXBkNVd3?=
 =?utf-8?B?dnIyUDRtMEFYOVFyQnRtbHI5cklMTTZYRVhCMC9DTTYrTmQxY3FmeVNsd3N4?=
 =?utf-8?Q?PNaVQbSVHcuwH7DqCWZWad4FBS58MK9wIhcHvPF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6BBA016B160F0D42AD672A9A7D4C2F0D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3465.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8803609c-31b0-43e7-2a9c-08d903507d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 16:30:48.5852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nNA35aK1feSNkwATIBmDg4z7Wapvxd0eXEQei3b7QaOjT7Nzxj+B0pF1hWGgeBsXjRmnU+eULXHTDoZZVkFfhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF2ZWwsDQoNCk9uIDQvMTkvMjAyMSA1OjIyIFBNLCBQYXZlbCBIb2ZtYW4gd3JvdGU6DQo+
IA0KPiBEbmUgMTEuIDAyLiAyMSB2IDEyOjIxIE1pbmFzIEhhcnV0eXVueWFuIG5hcHNhbChhKToN
Cj4+IEhpIFJ1c2xhbiwNCj4+DQo+PiBPbiAyLzEvMjAyMSAzOjQ0IEFNLCBSdXNsYW4gQmlsb3Zv
bCB3cm90ZToNCj4+PiBIaSBNaW5hcyBhbmQgb3RoZXIgVVNCIGV4cGVydHMsDQo+Pj4NCj4+PiBJ
J20gY3VycmVudGx5IGRldmVsb3BpbmcgbmV3IGZlYXR1cmVzIGZvciBVQUMxL1VBQzIgYXVkaW8g
Z2FkZ2V0cw0KPj4+IGxpa2UgVm9sdW1lL011dGUgY29udHJvbHMgd2hpY2ggdXNlIENvbnRyb2wg
U0VUVVAgKyBEQVRBIE9VVA0KPj4+IHRyYW5zYWN0aW9ucyB0aHJvdWdoIGVwMC4NCj4+Pg0KPj4+
IFdoaWxlIGl0IHdvcmtzIGZpbmUgb24gQmVhZ2xlQm9uZSBibGFjayBib2FyZCB3aXRoIE1VU0Ig
VURDLA0KPj4+IG9uIFJhc3BiZXJyeSBQaSA0IHdpdGggRFdDMiBVREMgdGhlcmUgaXMgYW4gaXNz
dWUuDQo+Pj4NCj4+PiBJIGZvdW5kIHRoYXQgd2hlbiBEV0MyIHJlY2VpdmVzIGVwMCBTRVRVUCAr
IERBVEEgT1VUIHRyYW5zYWN0aW9uLA0KPj4+IGl0IGRvZXNuJ3QgY29weSBkYXRhIHRyYW5zZmVy
cmVkIGZyb20gdGhlIGhvc3QgdG8gRVAwIGluIERBVEEgT1VUIHN0YWdlDQo+Pj4gdG8gdGhlIHVz
Yl9yZXF1ZXN0LT5idWYgYnVmZmVyLiBUaGlzIGJ1ZmZlciBjb250YWlucyB1bmNoYW5nZWQgZGF0
YSBmcm9tDQo+Pj4gcHJldmlvdXMgdHJhbnNhY3Rpb25zLg0KPj4+DQo+Pg0KPj4gQ291bGQgeW91
IHBsZWFzZSBzZW5kIGRlYnVnIGxvZyB3aXRoIGlzc3VlIGFuZCB1c2IgdHJhY2UuDQo+Pg0KPiAN
Cj4gSGkgTWluYXMsDQo+IA0KPiBJIGNvbmZpcm0gdGhpcyBwcm9ibGVtIHdpdGggRFdDMiBnYWRn
ZXQgb24gUlBpNC4gSSByZWJhc2VkIEp1bGlhbidzDQo+IG11bHRpcGxlIGF1ZGlvIGNsb2NrcyBw
YXRjaA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvcGF0Y2h3b3JrL3BhdGNoLzgwMzQyMi9fXzshIUE0RjJSOUdfcGchSjN6dWpIMFR6c3AwREJz
Sm02RVBUekcwdmRyOXBsR054N2ptb2lrOEp2TjROcU9EdWx2TkQ1UlhaaUxFOGQ3MFJrVW9kNFpa
JCAgb24gdG9wIG9mIFJ1c2xhbidzDQo+IGltcGxpY2l0IGZlZWRiYWNrIHBhdGNoZXMNCj4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC11c2IvbGlzdC8/c2VyaWVzPSZzdWJtaXR0ZXI9MTIxNjcxJnN0YXRlPSZxPSZh
cmNoaXZlPSZkZWxlZ2F0ZT1fXzshIUE0RjJSOUdfcGchSjN6dWpIMFR6c3AwREJzSm02RVBUekcw
dmRyOXBsR054N2ptb2lrOEp2TjROcU9EdWx2TkQ1UlhaaUxFOGQ3MFJ0dl9kdVZoJA0KPiBvbiBi
cmFuY2ggcnBpLTUuMTIueQ0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9n
aXRodWIuY29tL3Jhc3BiZXJyeXBpL2xpbnV4L3RyZWUvcnBpLTUuMTIueV9fOyEhQTRGMlI5R19w
ZyFKM3p1akgwVHpzcDBEQnNKbTZFUFR6RzB2ZHI5cGxHTng3am1vaWs4SnZONE5xT0R1bHZORDVS
WFppTEU4ZDcwUmtxamIyUWIkICBhbmQgY29tcGlsZWQgZm9yIGFybTY0Lg0KPiANCj4gV2hlbiBV
U0IgaG9zdCBzd2l0Y2hlcyBhdWRpbyBwbGF5YmFjayB0byBub24tZGVmYXVsdCBzYW1wbGVyYXRl
IChmcm9tDQo+IDk2MDAwIHRvIDE5MjAwMCBpbiBteSBjYXNlKSwgdXNiX3JlcXVlc3QtPmJ1ZiBj
b250YWlucyB0aGUgcHJldmlvdXMNCj4gZGVmYXVsdCB2YWx1ZSBvZiA5NjAwMCwgaW5zdGVhZCBv
ZiB0aGUgbmV3IHZhbHVlIHNlbnQgYnkgdGhlIGhvc3QgLSBzZWUNCj4gdGhlIGNhcHR1cmVkIFVT
QiBwYWNrZXQgYmVsb3c6DQo+IA0KPiA9PT09PT09PT09PT09PT0NCj4gRnJhbWUgOTogNjggYnl0
ZXMgb24gd2lyZSAoNTQ0IGJpdHMpLCA2OCBieXRlcyBjYXB0dXJlZCAoNTQ0IGJpdHMpIG9uDQo+
IGludGVyZmFjZSB1c2Jtb24xLCBpZCAwDQo+ICAgICAgSW50ZXJmYWNlIGlkOiAwICh1c2Jtb24x
KQ0KPiAgICAgICAgICBJbnRlcmZhY2UgbmFtZTogdXNibW9uMQ0KPiAgICAgIEVuY2Fwc3VsYXRp
b24gdHlwZTogVVNCIHBhY2tldHMgd2l0aCBMaW51eCBoZWFkZXIgYW5kIHBhZGRpbmcgKDExNSkN
Cj4gICAgICBBcnJpdmFsIFRpbWU6IEFwciAxOSwgMjAyMSAxMzo0MToyNS4xNDY2NTAwMDAgQ0VT
VA0KPiAgICAgIFtUaW1lIHNoaWZ0IGZvciB0aGlzIHBhY2tldDogMC4wMDAwMDAwMDAgc2Vjb25k
c10NCj4gICAgICBFcG9jaCBUaW1lOiAxNjE4ODMyNDg1LjE0NjY1MDAwMCBzZWNvbmRzDQo+ICAg
ICAgW1RpbWUgZGVsdGEgZnJvbSBwcmV2aW91cyBjYXB0dXJlZCBmcmFtZTogMC4wMDAwNTAwMDAg
c2Vjb25kc10NCj4gICAgICBbVGltZSBkZWx0YSBmcm9tIHByZXZpb3VzIGRpc3BsYXllZCBmcmFt
ZTogMC4wMDAwNTAwMDAgc2Vjb25kc10NCj4gICAgICBbVGltZSBzaW5jZSByZWZlcmVuY2Ugb3Ig
Zmlyc3QgZnJhbWU6IDYuMDEzNTE4MDAwIHNlY29uZHNdDQo+ICAgICAgRnJhbWUgTnVtYmVyOiA5
DQo+ICAgICAgRnJhbWUgTGVuZ3RoOiA2OCBieXRlcyAoNTQ0IGJpdHMpDQo+ICAgICAgQ2FwdHVy
ZSBMZW5ndGg6IDY4IGJ5dGVzICg1NDQgYml0cykNCj4gICAgICBbRnJhbWUgaXMgbWFya2VkOiBG
YWxzZV0NCj4gICAgICBbRnJhbWUgaXMgaWdub3JlZDogRmFsc2VdDQo+ICAgICAgW1Byb3RvY29s
cyBpbiBmcmFtZTogdXNiXQ0KPiBVU0IgVVJCDQo+ICAgICAgW1NvdXJjZTogaG9zdF0NCj4gICAg
ICBbRGVzdGluYXRpb246IDEuMTQuMF0NCj4gICAgICBVUkIgaWQ6IDB4ZmZmZjhjMzc0NDRmMjQ4
MA0KPiAgICAgIFVSQiB0eXBlOiBVUkJfU1VCTUlUICgnUycpDQo+ICAgICAgVVJCIHRyYW5zZmVy
IHR5cGU6IFVSQl9DT05UUk9MICgweDAyKQ0KPiAgICAgIEVuZHBvaW50OiAweDAwLCBEaXJlY3Rp
b246IE9VVA0KPiAgICAgICAgICAwLi4uIC4uLi4gPSBEaXJlY3Rpb246IE9VVCAoMCkNCj4gICAg
ICAgICAgLi4uLiAwMDAwID0gRW5kcG9pbnQgbnVtYmVyOiAwDQo+ICAgICAgRGV2aWNlOiAxNA0K
PiAgICAgIFVSQiBidXMgaWQ6IDENCj4gICAgICBEZXZpY2Ugc2V0dXAgcmVxdWVzdDogcmVsZXZh
bnQgKDApDQo+ICAgICAgRGF0YTogcHJlc2VudCAoMCkNCj4gICAgICBVUkIgc2VjOiAxNjE4ODMy
NDg1DQo+ICAgICAgVVJCIHVzZWM6IDE0NjY1MA0KPiAgICAgIFVSQiBzdGF0dXM6IE9wZXJhdGlv
biBub3cgaW4gcHJvZ3Jlc3MgKC1FSU5QUk9HUkVTUykgKC0xMTUpDQo+ICAgICAgVVJCIGxlbmd0
aCBbYnl0ZXNdOiA0DQo+ICAgICAgRGF0YSBsZW5ndGggW2J5dGVzXTogNA0KPiAgICAgIFtSZXNw
b25zZSBpbjogMTBdDQo+ICAgICAgSW50ZXJ2YWw6IDANCj4gICAgICBTdGFydCBmcmFtZTogMA0K
PiAgICAgIENvcHkgb2YgVHJhbnNmZXIgRmxhZ3M6IDB4MDAwMDAwMDANCj4gICAgICAgICAgLi4u
LiAuLi4uIC4uLi4gLi4uLiAuLi4uIC4uLi4gLi4uLiAuLi4wID0gU2hvcnQgbm90IE9LOiBGYWxz
ZQ0KPiAgICAgICAgICAuLi4uIC4uLi4gLi4uLiAuLi4uIC4uLi4gLi4uLiAuLi4uIC4uMC4gPSBJ
U08gQVNBUDogRmFsc2UNCj4gICAgICAgICAgLi4uLiAuLi4uIC4uLi4gLi4uLiAuLi4uIC4uLi4g
Li4uLiAuMC4uID0gTm8gdHJhbnNmZXIgRE1BIG1hcDogRmFsc2UNCj4gICAgICAgICAgLi4uLiAu
Li4uIC4uLi4gLi4uLiAuLi4uIC4uLi4gLi4wLiAuLi4uID0gTm8gRlNCUjogRmFsc2UNCj4gICAg
ICAgICAgLi4uLiAuLi4uIC4uLi4gLi4uLiAuLi4uIC4uLi4gLjAuLiAuLi4uID0gWmVybyBQYWNr
ZXQ6IEZhbHNlDQo+ICAgICAgICAgIC4uLi4gLi4uLiAuLi4uIC4uLi4gLi4uLiAuLi4uIDAuLi4g
Li4uLiA9IE5vIEludGVycnVwdDogRmFsc2UNCj4gICAgICAgICAgLi4uLiAuLi4uIC4uLi4gLi4u
LiAuLi4uIC4uLjAgLi4uLiAuLi4uID0gRnJlZSBCdWZmZXI6IEZhbHNlDQo+ICAgICAgICAgIC4u
Li4gLi4uLiAuLi4uIC4uLi4gLi4uLiAuLjAuIC4uLi4gLi4uLiA9IERpciBJTjogRmFsc2UNCj4g
ICAgICAgICAgLi4uLiAuLi4uIC4uLi4gLi4uMCAuLi4uIC4uLi4gLi4uLiAuLi4uID0gRE1BIE1h
cCBTaW5nbGU6IEZhbHNlDQo+ICAgICAgICAgIC4uLi4gLi4uLiAuLi4uIC4uMC4gLi4uLiAuLi4u
IC4uLi4gLi4uLiA9IERNQSBNYXAgUGFnZTogRmFsc2UNCj4gICAgICAgICAgLi4uLiAuLi4uIC4u
Li4gLjAuLiAuLi4uIC4uLi4gLi4uLiAuLi4uID0gRE1BIE1hcCBTRzogRmFsc2UNCj4gICAgICAg
ICAgLi4uLiAuLi4uIC4uLi4gMC4uLiAuLi4uIC4uLi4gLi4uLiAuLi4uID0gTWFwIExvY2FsOiBG
YWxzZQ0KPiAgICAgICAgICAuLi4uIC4uLi4gLi4uMCAuLi4uIC4uLi4gLi4uLiAuLi4uIC4uLi4g
PSBTZXR1cCBNYXAgU2luZ2xlOiBGYWxzZQ0KPiAgICAgICAgICAuLi4uIC4uLi4gLi4wLiAuLi4u
IC4uLi4gLi4uLiAuLi4uIC4uLi4gPSBTZXR1cCBNYXAgTG9jYWw6IEZhbHNlDQo+ICAgICAgICAg
IC4uLi4gLi4uLiAuMC4uIC4uLi4gLi4uLiAuLi4uIC4uLi4gLi4uLiA9IERNQSBTLUcgQ29tYmlu
ZWQ6IEZhbHNlDQo+ICAgICAgICAgIC4uLi4gLi4uLiAwLi4uIC4uLi4gLi4uLiAuLi4uIC4uLi4g
Li4uLiA9IEFsaWduZWQgVGVtcCBCdWZmZXI6IEZhbHNlDQo+ICAgICAgTnVtYmVyIG9mIElTTyBk
ZXNjcmlwdG9yczogMA0KPiAgICAgIFtiSW50ZXJmYWNlQ2xhc3M6IFVua25vd24gKDB4ZmZmZild
DQo+IFNldHVwIERhdGENCj4gICAgICBibVJlcXVlc3RUeXBlOiAweDIxDQo+ICAgICAgICAgIDAu
Li4gLi4uLiA9IERpcmVjdGlvbjogSG9zdC10by1kZXZpY2UNCj4gICAgICAgICAgLjAxLiAuLi4u
ID0gVHlwZTogQ2xhc3MgKDB4MSkNCj4gICAgICAgICAgLi4uMCAwMDAxID0gUmVjaXBpZW50OiBJ
bnRlcmZhY2UgKDB4MDEpDQo+ICAgICAgYlJlcXVlc3Q6IDENCj4gICAgICB3VmFsdWU6IDB4MDEw
MA0KPiAgICAgIHdJbmRleDogMTc5MiAoMHgwNzAwKQ0KPiAgICAgIHdMZW5ndGg6IDQNCj4gICAg
ICBEYXRhIEZyYWdtZW50OiAwMGVlMDIwMCAgICAgIDwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gPT09PT09PT09PT09PT09DQo+IA0KPiANCg0KU29tZSBjbGFyaWZpY2F0aW9ucyBy
ZXF1aXJlZDoNCjEuIGdhZGdldCB3b3JrcyBpbiBzY2F0dGVyL2dhdGhlciBETUEgbW9kZSAoZ19k
bWFfZGVzYyBpcyB0cnVlKT8NCjIuIEFib3ZlIGNhcHR1cmVkIEhvc3Qgc2lkZSBVU0IgcGFja2V0
IGNvcnJlc3BvbmRzIGluIGRtZXNnIHRvIGxpbmUjMzk5MDc6DQoNClsgMTI2MS43ODk1NTJdIGR3
YzIgZmU5ODAwMDAudXNiOiBjdHJsIFR5cGU9MjEsIFJlcT0wMSwgVj0wMTAwLCBJPTA3MDAsIA0K
TD0wMDA0DQoNCkNvcnJlY3Q/DQoNCjMuIFlvdSBhc3N1bWUgdGhhdCBpc3N1ZSBzZWVuIGluIGJl
bG93IHByaW50aydzIChsaW5lcyMjMzk5MjMtMzk5MjcpOg0KDQpbIDEyNjEuNzg5NjQwXSBnX2F1
ZGlvIGdhZGdldDogQ2FsbGluZyB1YWMyX2NzX2NvbnRyb2xfc2FtX2ZyZXEgMS4NClsgMTI2MS43
ODk2NTJdIGdfYXVkaW8gZ2FkZ2V0OiBDYWxsaW5nIHVhYzJfY3NfY29udHJvbF9zYW1fZnJlcSAy
Lg0KWyAxMjYxLjc4OTY1NV0gZ19hdWRpbyBnYWRnZXQ6IHVhYzJfY3NfY29udHJvbF9zYW1fZnJl
cSB2YWw6IDk2MDAwLg0KWyAxMjYxLjc4OTY1OV0gZ19hdWRpbyBnYWRnZXQ6IENhbGxpbmcgdWFj
Ml9jc19jb250cm9sX3NhbV9mcmVxIE9VVC4NClsgMTI2MS43ODk2NjVdIENhbGxpbmcgdV9hdWRp
b19zZXRfY2FwdHVyZV9zcmF0ZSB3aXRoIHNyYXRlIDk2MDAwDQoNCkluc3RlYWQgYm90aCA5NjAw
MCBzaG91bGQgYmUgMTkyMDAwPyBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUgbWUgDQptZXNzYWdl
cyBzZXF1ZW5jZSBmb3IgY29ycmVjdCBiZWhhdmlvdXIgZm9yIDE5MjAwMC4NCg0KNC4gQmVsb3cg
ZG1lc2cgZnJhZ21lbnQgbm90IGNvcnJlc3BvbmRzIHRvIG9ic2VydmVkIGlzc3VlLCBpdCdzIGp1
c3QgZm9yIA0Kc2hvdyBhZGRlZCBwcmludGsncyBpbiBnX2F1ZGlvLiBDb3JyZWN0Pw0KDQpUaGFu
a3MsDQpNaW5hcw0KDQoNCj4gVGhlIHZhbHVlIHNlbnQgMDBlZTAyMDAgY29ycmVzcG9uZHMgdG8g
MTkyMDAwLCBidXQgdGhlIGdhZGdldCByZWNlaXZlZA0KPiB0aGUgb3JpZ2luYWwgOTYwMDAgKEkg
YWRkZWQgc29tZSBwcmludGtzIHRvIGdfYXVkaW8pOg0KPiANCj4gPT09PT09PT09PQ0KPiBbIDEy
NjAuMjc3ODU3XSBkd2MyIGZlOTgwMDAwLnVzYjogZXAwOiByZXEgMDAwMDAwMDBjZjBhNzUwMjoN
Cj4gNEAwMDAwMDAwMDBlNTc0YzkwLCBub2k9MCwgemVybz0wLCBzbm9rPTANCj4gWyAxMjYwLjI3
Nzg2NV0gZHdjMiBmZTk4MDAwMC51c2I6IGR3YzJfaHNvdGdfc3RhcnRfcmVxOg0KPiBEeEVQQ1RM
PTB4MDAwMjgwMDAsIGVwIDAsIGRpciBpbg0KPiBbIDEyNjAuMjc3ODcwXSBkd2MyIGZlOTgwMDAw
LnVzYjogdXJlcS0+bGVuZ3RoOjQgdXJlcS0+YWN0dWFsOjANCj4gWyAxMjYwLjI3Nzg4Nl0gZHdj
MiBmZTk4MDAwMC51c2I6IGVwMCBzdGF0ZToxDQo+IFsgMTI2MC4yNzc5MTNdIGR3YzIgZmU5ODAw
MDAudXNiOiByZXEtPmxlbmd0aDo0IHJlcS0+YWN0dWFsOjQgcmVxLT56ZXJvOjANCj4gWyAxMjYw
LjI3Nzk0NF0gZHdjMiBmZTk4MDAwMC51c2I6IHpscCBwYWNrZXQgcmVjZWl2ZWQNCj4gWyAxMjYw
LjI3Nzk0OF0gZHdjMiBmZTk4MDAwMC51c2I6IGNvbXBsZXRlOiBlcCAwMDAwMDAwMDE4ZTViMzFh
IGVwMCwgcmVxDQo+IDAwMDAwMDAwY2YwYTc1MDIsIDAgPT4gMDAwMDAwMDAyM2U3OWVkOA0KPiBb
IDEyNjAuMjc3OTg0XSBkd2MyIGZlOTgwMDAwLnVzYjogdXJlcS0+bGVuZ3RoOjggdXJlcS0+YWN0
dWFsOjANCj4gWyAxMjYwLjI3ODA3OF0gZHdjMiBmZTk4MDAwMC51c2I6IGR3YzJfaHNvdGdfZXBp
bnQ6IGVwMChvdXQpDQo+IER4RVBJTlQ9MHgwMDAwMDAxOA0KPiBbIDEyNjAuMjc4MTA0XSBkd2My
IGZlOTgwMDAwLnVzYjogZXAwOiByZXEgMDAwMDAwMDBjZjBhNzUwMjoNCj4gNEAwMDAwMDAwMDBl
NTc0YzkwLCBub2k9MCwgemVybz0wLCBzbm9rPTANCj4gWyAxMjYwLjI3ODEyOF0gZHdjMiBmZTk4
MDAwMC51c2I6IGR3YzJfaHNvdGdfc3RhcnRfcmVxOg0KPiAweDAwMDAwMDAwZmIwY2I4MDAgPT4g
MHgwMDAwMGIxNA0KPiBbIDEyNjAuMjc4MTYzXSBkd2MyIGZlOTgwMDAwLnVzYjogZHdjMl9oc290
Z19lcGludDogWGZlckNvbXBsOg0KPiBEeEVQQ1RMPTB4MDAwMjgwMDAsIERYRVBUU0laPTAwMDAw
MDAwDQo+IFsgMTI2MC4yNzgxODJdIGdfYXVkaW8gZ2FkZ2V0OiBDYWxsaW5nIHVhYzJfY3NfY29u
dHJvbF9zYW1fZnJlcSAyLg0KPiBbIDEyNjAuMjc4MTg2XSBnX2F1ZGlvIGdhZGdldDogdWFjMl9j
c19jb250cm9sX3NhbV9mcmVxIHZhbDogOTYwMDAuDQo+ID09PT09PT09PT09PQ0KPiANCj4gUGxl
YXNlIGZpbmQgYXR0YWNoZWQgdGhlIHdob2xlIGRtZXNnIGZyb20gbW9kcHJvYmluZyB0aGUgZ2Fk
Z2V0IG1vZHVsZXMNCj4gdGhyb3VnaCBwbGF5YmFjayBvZiAxOTIwMDAuDQo+IA0KPiBQbGVhc2Ug
bGV0IG1lIGtub3cgaWYgeW91IG5lZWQgYW55IG1vcmUgbG9ncy90ZXN0cy4gVGhhbmsgeW91IHZl
cnkgbXVjaA0KPiBmb3IgeW91ciBoZWxwLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiANCj4gUGF2
ZWwuDQo+IA0KPiANCj4gDQoNCg==
