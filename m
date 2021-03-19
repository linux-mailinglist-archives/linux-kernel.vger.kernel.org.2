Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8E53417FD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhCSJJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 05:09:56 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54968 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229469AbhCSJJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:09:49 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B9A87C033D;
        Fri, 19 Mar 2021 09:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616144989; bh=hoM0fg0+7lRcrqZ2zDfvADc8hcV5ue/81BUze3l2iIM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aD964SYOAFejL0GFvlNK/hMO7CBHUnXbcGaE7yfySlEUZY5H7RAimCn6+53iRESDB
         l96qzBwUZ7mBpFPx0WW8Y+fJ0IxL7Pa4a5V4b66BrnIe3A7PbALfI0Xxh4gZSzF7wM
         EGk8qA4yZEd+7FALPiLDyF0dBSb73fDchvvBUY8M70cv/+eJXgSw8w/B0A6CtYWkwX
         hBRF+rI/oAV09dj2gfcb66Nwmami/U+HoSZIa/vZXMNIiDT7G6BE221EbtDG3P5nuj
         LC9CsoVqjiXmRZIN46kvWfl8/YMiWzIG7Kj7X3010GIoO3WPam4Obd9+a4kk+Cr//m
         1nftysFkJRCuw==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7D3CBA005E;
        Fri, 19 Mar 2021 09:09:47 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4510E8000C;
        Fri, 19 Mar 2021 09:09:45 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NsKCA+jf";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu9roFQ6djbKdRH95mqwajN5p/UiSVLCk+LayOdqi5M0IZSrIqL4LdibJtvUGsB8VAIz9AeDg94kQr6h0X6Hwnr6I/dp4aYxXeq4hrJ3QL0GT0Oj+rv9e/nGyns0Fp27dmfi0NBVtI0XdnjDm/kdKZI+k1vMR80nFgSTrZYCzBZOPvr51gStjIJXjdnyRk8DEFjGsv26el9zNgi0KptK0T1vnq1scwfVAhbhtdxZ63IC+nkaiQquUqW+m9Khs9VrCYQI3D8VUzanU8MvBv5AAEFjJdEycNCpBKfdaqq+DDPW0MfXkByjsiO+z2ePzXKLYRr2xAYAkYkPosqvQRjoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoM0fg0+7lRcrqZ2zDfvADc8hcV5ue/81BUze3l2iIM=;
 b=iFm+gYI9igqY8babgneiDwQKDQHXIzs/Jr/uuCIZjGPVgSA1gX5pnQzX0M9iX6+9SgaEQgIzEpBanhPdvMy9ouwJysHPgTvAkP0Mb6LguMlHpowA23NZf4/9N3tbzHTN3sociPiTaN0cQJ9veuigLf8ymsY7H8u4zvxwwmAqsgHyrNi7Ii1Lg8hmilJPl5MF72oTHa4R605mEaKTi/vOD4DMbQgT3D1LuHUkybGWZKwtXU2jSEz5FOQym8+tpQxwnaQa8OM9kfz0OHYwvdhGyC+TGZjDFjlSEduKL5rTQOpLDHan/QU40e9F4ik7HHU+KaPLHqTfOOZWMU+UIkxWaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoM0fg0+7lRcrqZ2zDfvADc8hcV5ue/81BUze3l2iIM=;
 b=NsKCA+jfOgMuD8GZ87/e274+oY7z9GKn25lLP3tAAXSApoaxOT71xdwym2zorMSSnZuoLZVHaYhrIzNH5qFRUhKSV+LMGbyTeY+1WkkAx9TojYJSrbjUWMgH/h7KKT2EapeKMAVmJ8t64P5lKVBNyPHgKmJ1U7tkDa/9q/49UiY=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB4034.namprd12.prod.outlook.com (2603:10b6:a03:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Fri, 19 Mar
 2021 09:09:44 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.3955.018; Fri, 19 Mar 2021
 09:09:44 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Zeng Tao <prime.zeng@hisilicon.com>
CC:     "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Using tab instead of blank
Thread-Topic: [PATCH] usb: dwc2: Using tab instead of blank
Thread-Index: AQHXHJ7GJRPUoiz5O0avx8zgn/iUG6qLBfWA
Date:   Fri, 19 Mar 2021 09:09:44 +0000
Message-ID: <595b28ae-4ce7-8c71-b101-effa4d8b0f5f@synopsys.com>
References: <1616144456-15381-1-git-send-email-prime.zeng@hisilicon.com>
In-Reply-To: <1616144456-15381-1-git-send-email-prime.zeng@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.94.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5def0726-c584-4fdf-2275-08d8eab6bc9d
x-ms-traffictypediagnostic: BY5PR12MB4034:
x-microsoft-antispam-prvs: <BY5PR12MB40340655F5B4EB6C3FF728CBA7689@BY5PR12MB4034.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:862;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MAD9gMhMXsgC1Hsx59ZNJO48pVsu9nHN0ZlusPxvJvNBH8zkX6lDL64lOTp6wr0qrgb/mtk8KlEjAcZlpTwn2rrNbyCMb+q8Ojv2qdKVv3z9FgK05Q+U9c76dAa5yoSL012r3IaPebeRR7kNSh947wDV3V15/VLim8TkyheMILx6sQ6UAjNTerN54V2IKbTDwheTEfSPflS9+aSal6ZHAw5vwr2EdA+FlC2JNewTiBFrN1chU6kY17JlCdkiRLAmfyZRb+Scf6ycIZP+gzRxKXqqmU8+ZFKgQKI/NQLkmItt9lC5FKJW4/SY3j2TWDl2McDT+zk3kFtSTrUJR66awX82cbsGex1H9cKk68iUu/1So1nnJfo3E3Z2I/BQLuEhLGArmfW4o87D4uqgIp28lUagQrWQcLmWKeUCb0hpiT92eGin7xDIWJ1zjWFTeX+6lgBWC+nqcaRlyxnmRgVJKMT6ksXt6jDiUoIASCIhe+JnacvniXUoTzzhRrtPZ/RYk3REruanLqLWvk1mQGEZkUDSxvQ/afIiPrFoguLSOCD6QQ4Yu58wX6dSVKSEmY6vhRDj8+X1ZbBX2OoTQ4HCYiHsUg0fOvHCLOA4AQouCnPX5CeHstAaDWuhQ9EYnXIAdyvixQUnEmfvZwaV7B8k2fuJlLYrmQhtnHr9u8kVi07UWYdZpe82dY8DncO3Q+Fz4w8Qx86UC22XwiFU2XCNswDY9/lQms88DsIHPfwxzps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39850400004)(346002)(136003)(376002)(31696002)(5660300002)(86362001)(26005)(71200400001)(2906002)(66446008)(66946007)(64756008)(66476007)(6486002)(2616005)(4326008)(8676002)(4744005)(66556008)(478600001)(53546011)(316002)(31686004)(6506007)(54906003)(6512007)(36756003)(91956017)(83380400001)(38100700001)(8936002)(186003)(76116006)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?amgreEFKME1ndVpaWkdTclBtdEs1Q2NJUTVGQk16bnF3M3dxU1FqRi9tclk0?=
 =?utf-8?B?bTF3djFoUWdQYW04WWxPMG1rR0YzZGhoNXltam56eUpiQUNOMFpkZ1ZDbGZr?=
 =?utf-8?B?c2NubS9iZmFkdzhlcFFHSk1US2ZMYWVIZjZ2bUNuY29zQ1dsNE90SDJHMkox?=
 =?utf-8?B?eGJBcWdHTXRxVDNzVGRnRVlKRWxFZmJLaUVzMThQK29OdGFpbkx2d1RBQXJU?=
 =?utf-8?B?U1p1enZYcHFWMjhpNzA0NGUraGJwTU45cFJpUE1pdXpMYzhSWWtGaFFGb2VO?=
 =?utf-8?B?eCtTQmRXWUhDaUJhS2FJanRqYVIrVitRTEgyZGJMU2x4dFIrWWE1M0pLaU1n?=
 =?utf-8?B?a3NrR0RwR0lJSkROL2tlZERubWFiZFhXcVltbmZBNG9DMVZSQVNmSFc3UXhw?=
 =?utf-8?B?ck5BdG1zN0RoT0lqYkxIcjVvT2ZEYUIvTUF5dCtZWVVNT1AwbHZ4dGhaaHRW?=
 =?utf-8?B?SUkxcSsyM25PcENxRkdwbktKZVgrcEoxa0lCZ3QrZWFra0tpaDJoYzJ6dXc4?=
 =?utf-8?B?MUJocG5IZU1SemtNVjE0YnAxTi8veENWL0NqK0Z6MkJ5S3hBRWRRODc5T1dO?=
 =?utf-8?B?bzZEOEgrdGd2ZWM0a2NpU2ZNN3RpaGk0N25hcnhLKzVNQXI1YkNKcDExQ2RU?=
 =?utf-8?B?NHRHYXlTUzBrQU5iZlhoa2ZodWMxeEs1bEE5MUQvSy81VUdZYjNDRmRvQ0ph?=
 =?utf-8?B?ZTkvdHJHZkFmdHBESFNyNW12eERzRVNsQ0Z5R3A0OCtjTTZjVkhpWStPTkFn?=
 =?utf-8?B?RGNsMGErS1VaTmhFUUVoNmVzdSt2YmtydEhrVElNeWdqam43K2hycVdSMnEw?=
 =?utf-8?B?TE1RdUZJQ2JEdXpkU29xekhsSHBxLzZkN0RkUWNxaTh6T2hCMTIrdjh1T0JY?=
 =?utf-8?B?SWM2ZDhTcEFidmc5SUg0dUtweFMrUFFOTkZYem1McVNuZ3R4OS9TVDBvR2Q5?=
 =?utf-8?B?RHoxSkhtOHd3azdhM01JM0dRSW5iR0RpNjN6Q28rRGI4UWdoMjR4Z3ZZYnlO?=
 =?utf-8?B?amQ5Z3RGWDMxOTZoUGxvZW1sUWhUdTNOWjRFbStlQW0zWHRGQlBva1hpWGc2?=
 =?utf-8?B?bm9QUFppRDdsS0Z5Z2ZiSlhBY1AzYkN5NXcwUGYzdHA1amhuNlBiRFFsL1F5?=
 =?utf-8?B?RXBzUTV1ZUNicERMNjBHQW45YnJIeFB1NjhSYlJscmlNRGdyQTFSdG5FRHJ6?=
 =?utf-8?B?amtqMlg0RElTSFVpUUJuek1iVU1ST3djRjF5MnVmUlZKVU14RGMvSHVjU25E?=
 =?utf-8?B?U3hNdWx0SlBhY0RaZ01pUHlMTHdEMkNabHkwVEtmWmF0ajlvcHNWUC9ydyts?=
 =?utf-8?B?SldMcWM2QWladHhveVp4em1pREtraTNBVHRrSDJNRW9BY0lJdk9pMzFCMjJN?=
 =?utf-8?B?UDNYVUpDMjc3YmpqSm93bUNXTlI5Rnh2NnJtMm5Nd3p3NHN3M1o3TUViR3Vi?=
 =?utf-8?B?cTdlalBtU0tjMWl5M2grWkppSkg2L3o2aEQvRFZvRlJTQkt3a0RtTWY1Z2ZH?=
 =?utf-8?B?dkdLRnZSOTlwa1pZRThVVVd6U2QvdGtWMDNzVGIwWm1qUG90UmhzZWFNeklv?=
 =?utf-8?B?d2crM2xYamhsQlZLMU5Bc250cXk4bkJaVWEzM2NSNk5KMmFaLy9OTEwrZXk1?=
 =?utf-8?B?YjFVeCs3SlRTTEJCc1VKVEVQL3FSSXpRdDRDazhXQzB2MDloRUdnY0pGeVds?=
 =?utf-8?B?b0RubEVzRzBPa1B4N1Y5NUNrbldPTEpzendaVEpRWnBUbDQwSTZsVldtWWRl?=
 =?utf-8?Q?1faOs0noeILqvGmJwc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0073DAB4F72A2A4F8BC12494442F6DE2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5def0726-c584-4fdf-2275-08d8eab6bc9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 09:09:44.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DpU0NZ+cBixqvCYp7WErLxHdEvLIeKCmOLcNbOWFzJ2occfOvKhkl2kP0dTnFPuI9vcd595YAziMS1TW0/nSVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xOS8yMDIxIDE6MDAgUE0sIFplbmcgVGFvIHdyb3RlOg0KPiBTaWduZWQtb2ZmLWJ5OiBa
ZW5nIFRhbyA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPg0KDQpBY2tlZC1ieTogTWluYXMgSGFy
dXR5dW55YW4gPE1pbmFzLkhhcnV0eXVueWFuQHN5bm9wc3lzLmNvbT4NCg0KPiAtLS0NCj4gICBk
cml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jIHwgMiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzIvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5jDQo+IGluZGV4IGFkNGM5
NDMuLjUzNDA2ZjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiBAQCAtMzM4MCw3ICszMzgwLDcgQEAg
dm9pZCBkd2MyX2hzb3RnX2NvcmVfaW5pdF9kaXNjb25uZWN0ZWQoc3RydWN0IGR3YzJfaHNvdGcg
Kmhzb3RnLA0KPiAgIA0KPiAgIAkvKiByZW1vdmUgdGhlIEhOUC9TUlAgYW5kIHNldCB0aGUgUEhZ
ICovDQo+ICAgCXVzYmNmZyAmPSB+KEdVU0JDRkdfU1JQQ0FQIHwgR1VTQkNGR19ITlBDQVApOw0K
PiAtICAgICAgICBkd2MyX3dyaXRlbChoc290ZywgdXNiY2ZnLCBHVVNCQ0ZHKTsNCj4gKwlkd2My
X3dyaXRlbChoc290ZywgdXNiY2ZnLCBHVVNCQ0ZHKTsNCj4gICANCj4gICAJZHdjMl9waHlfaW5p
dChoc290ZywgdHJ1ZSk7DQo+ICAgDQo+IA0KDQo=
