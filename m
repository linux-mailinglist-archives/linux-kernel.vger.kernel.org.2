Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E862F459B7B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 06:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbhKWFUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 00:20:44 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56794 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232827AbhKWFU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 00:20:27 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id DCCF241D16;
        Tue, 23 Nov 2021 05:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1637644639; bh=f7etQvzHe0FBIDbYmGSz3Fo694P/U2gFTIy1TdCnZD0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Wh3K56GQahrm06wBlBrg8s8LNpESlaheTYj2Bm3ObYNtgSkCj704v9POc+DBybwws
         yigxq6fJdn+Li5xkQ7dmzgUAQ2yFGiLF+upz5fC5YtZwjYII4qrjZXWdueuDhEtMeJ
         oaaJvnQtt+pdjfGMf2JjBV3as6NN8Y1G1lPljs2yVmdV+oJ0Q5haKdWU/07XsG3tSb
         hEKxDhP1lZ0NX7aOkiA44Go+z7rGcC3QaNCtu1hwWxKSElYeb1DJumMWa50P80akRN
         JmBr/SpNFj4PHDcWDDQsi4uw8GGW0CuLROpf9PmtGj+7lW0xAXcfhk0qxooQBA65kq
         77eMoyJC3Z36A==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4F19FA0081;
        Tue, 23 Nov 2021 05:17:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 37909400DA;
        Tue, 23 Nov 2021 05:17:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="AcGjpNhj";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJzY4ChpOAaX287EfIy1/g0imCUHjz2ey19ujs/TrzBWvkrbySIpgCyu6rjotoNkqc+0ORcBQNIpXKuTrR6lV4KvukUcUOv84IT9hTn4AngPV9TsxxbYLxVKA/gx9A0RYWEoLesxalgSe4Gk5AAMFu7wVmuWhNpT1p/MdpmW0AeYvzg5OcJT0Cihuu3BKC8CNfoiy3zUOEanaVCWHPMYXKmmkAwCMdyA1E1ou1Rs315X3O7etF4KvpaG9RRnalcAKBm84iP0qiuNEpSEwPX5HJZXICIzeWy6kmMgBywadSq9T3TB/kvIRo5n0x/IswDYKo0BvvOGba1mKF6+o/kr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7etQvzHe0FBIDbYmGSz3Fo694P/U2gFTIy1TdCnZD0=;
 b=EvpkcXez0JeU+m8Y2zxv/9z8CCn04+OKHD2gQCB0lEDXf7MDoB6ymfT8fuqtkGM1BFe/6hmDPpNPuAyc0K/QBK6gpd7aUKc+ldcKQWl6ya4Gw0k3mNef5odJmds5Kffjy0lVYF9L6vPaoWtCbsJ2UepXSdVKkwyuDxQIG6dmqYAW+XsjiUDzTQzQP5cXU04QFDgYkIAu07rlzEFuz9BFVc6krD31ZQbQwOexGSmYeoUZUp8Tnps2w+GOhVFAHnsn9Q1FBE56prS+o4uDIxGJ0jDJLacgZYf1bfup2+bRcp8LOccBGavOK17dP49TLnRJZ7m0Se5rwkUEjcQ6vdwCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7etQvzHe0FBIDbYmGSz3Fo694P/U2gFTIy1TdCnZD0=;
 b=AcGjpNhjMs0ZHKkpieSJ8LStuMcGjFk8Vin4BbGFF4ijUgyJRqLFL9OnjILaCDfx6hEB2UDnSA816P0apuB2OW6DYeWIB4rP9hT7IyB3eukpB97AIvszuRrAJYDA23T7rD+s+lydPdw+jMFR1olr2H8dlzoyvhDAaWyFGdt9u5M=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Tue, 23 Nov
 2021 05:17:15 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::a0da:c3e5:4562:cea9]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::a0da:c3e5:4562:cea9%7]) with mapi id 15.20.4713.024; Tue, 23 Nov 2021
 05:17:15 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     John Keeping <john@metanate.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: gadget: use existing helper
Thread-Topic: [PATCH] usb: dwc2: gadget: use existing helper
Thread-Index: AQHX35zeaP5cXlvCfEK9utMT1Ukfx6wQk4eA
Date:   Tue, 23 Nov 2021 05:17:15 +0000
Message-ID: <d18a3b7c-c6ec-5967-d0d3-8fdbb0716cd5@synopsys.com>
References: <20211122123107.3147353-1-john@metanate.com>
In-Reply-To: <20211122123107.3147353-1-john@metanate.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d7c1c1d-25fa-4e6f-5dad-08d9ae408384
x-ms-traffictypediagnostic: DM4PR12MB5231:
x-microsoft-antispam-prvs: <DM4PR12MB5231DC7AD459E45E6B47C0BDA7609@DM4PR12MB5231.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fryqEm34358ICKrxMF37ILKYD/oz7AjmOlmJ+N6FXINYMqQs0G7Rux7rHs+OEzAydI4ZUUtlSgmyccUMODvGH5Ku93DjHGmuMaLiepSQheytRGmCN7iiJvLC6Pk98F7ci8e0+sU150mkoNbB6jMeYWuC7C+iqRzotWEB/PxAP8HLAmbuQiqIPX1i1ghmyL5hN8MG8xOxyntptvCI3tUyhMzFN3qnsdnDE8N3Jqz6hb3ufO6Z27KVkQ/P+VLIAci+a+1Pi2dJv7ViTTRSPf7Q+3xJ67AZ2xRZs5zznSTg/n8IoefpcKKbeGJ3E/h0klgkZzEv4snZi+aDcbykflatSGYfanUjrZ4Qk8HMO6nkVsEGOcqIH/f1edyxgDRyBg+zNc35EWAA2K5mDK+UtvySlKaNPefJEhNsE9fE1bf6yYz6sdTVkUQrEzw9Meks2h6VzTDlXJaej+R77z4OKpigO0njKlj58K/DNJ5o97+8vN0GuhJgA5y2etAI3vwsVKNr6CMP7eBR5KUO2kQ7iQcjPDkSO9qaxY0rzO4jmZ/oPPjWWonk/BLfUUqEeoIjDjlZJk5TKAYiGzo2WZTQkMwYzgPW4k+REE+TYHCTqOMJ2EeVYIwR7/8jMF8b6eVrK2c8I3YN/89FeEcUcQuKLU6UNB03pwWSN4qIwR8a7UrE7v0wqI3bp/YWuwG4m3WfXEb7d7bweEaY92ZQWG4/skiSZhP+v/czK8anYIa14MVqBBa0qiojsPaSSZtfcQmdeNlnR35tp9Sq2SUCNcBe3RjV0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(31696002)(2616005)(83380400001)(38070700005)(31686004)(54906003)(508600001)(6506007)(316002)(2906002)(38100700002)(86362001)(8676002)(66946007)(4326008)(91956017)(76116006)(186003)(66446008)(36756003)(6916009)(64756008)(5660300002)(8936002)(6486002)(26005)(66556008)(71200400001)(122000001)(53546011)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmV0VURYaGdodXZFTWhBYkxNVm4vaUh1TW1wNDF5Q3VqdE9QejI1ZXJRWkJ2?=
 =?utf-8?B?clE1a3NIWkpRbGRtK3pIZTlkT2Y4a0VOeklGenBaVnlYMjBkVGNIU0l1czF1?=
 =?utf-8?B?WFd0Z29VNUpTL0RNYWVqT2Z5M0pKdkdDUDdqM2FQQ3RZVVlvTWZBNUgySmZ3?=
 =?utf-8?B?bEFmWW11T1RTUE1BUFRwMTQyU2lJdE5WbWxCVDM5ZWVxMFhwQ0NWaHhkbFgz?=
 =?utf-8?B?b1pZQWU0MzhoVzlZZzdxRFMxakFVNmRLa0RMaUF0RmcyQ2pYWUtVNXhtdUth?=
 =?utf-8?B?RzRBYWtWS0dsLys5dDF6QURvQWU1dGQySENVM2dPYWh2UmNWRkpVUGJFU3pQ?=
 =?utf-8?B?WWhNUnVGZnU0b0hPbGlqWGRJQTdEeGpOVzNiSVdCUEZJLy8wRlJ0MlRMemFM?=
 =?utf-8?B?ZDNMUVRWRVhWV0U1b29DY25hcjNsSEdsOUFsM3JMYlpyMTBLRWlFczUvVTNN?=
 =?utf-8?B?a1VzZUhBRFJ3MnhPdXVZSnpIV2l1MTNNTFZ5MkZPNFQwcnJIY2xCOFliNEI1?=
 =?utf-8?B?SGlqOGxJVEc5cmhBUjR0MmVjMXZXYzJJZlVVc2ZlWEk0a24xV1UzTWtLMEdN?=
 =?utf-8?B?T0lIZVdZNXdiSjZITEgwZXhsVFJaOWtIdHF4LzdxL3JVZGZhckJkVTRWdmha?=
 =?utf-8?B?UlpFSENsU0Z3YmxTMllMdTJvVVUzaGkwSVRJRUthdDhIU1BYTXRyVTBZWFNF?=
 =?utf-8?B?dkF6aFNNU3o5OGZidkRXL0lDNkZSc2hNYTh5TjZ0MWprS2ZZM0tCQkVkTDJ0?=
 =?utf-8?B?QW9IVTJyRkVuMFNoWmNITW4xSnIwS3FtcVRCY2xSN3NpT0crUVRHT0RFSWZx?=
 =?utf-8?B?SmtLYitUVFQ3YjVqc1QvUlU5N2g1dGIvMmIzMkwrWTNBcDlsNFB0dVpsOFdz?=
 =?utf-8?B?Uld6c3RGWksxSml0YVNTNFNHSUs5Vll5N3JzMks4VXp2YTRrTmkrZ1lmcFNq?=
 =?utf-8?B?Sm9BT3BDTTcwZTZ4cnhhSUhjc2xyWlpqd1lVRGtCWTlhOG9CM0w4MDgwcldx?=
 =?utf-8?B?UitEY1BDaEdGOXJ6cDJUSXNiQmxmNkwwZWRCOWNXblR3aXBzbTRObHNKQ3Av?=
 =?utf-8?B?L1F5RlM3NThIVG44VGJVVmd6aEFHc0N1ZzV5MWkwWkR4dkVRMkMyZkVzSkxi?=
 =?utf-8?B?ZWhQZTR6TVp3WGVCUnpoRG83WkFXbmJ4ZzkxSFI5MUVRM0V4Nnk4cmh1eHRY?=
 =?utf-8?B?anZONklwNVJnckptcnVMNnpIQnEvSnRBZEpXNGJobjhPZmxtMnE4dGp0QnFS?=
 =?utf-8?B?cWdiTllwb1BGNERKcE9VMzQvbkJyQXFBUG4reTBPQkhzZytUOE9mZEEvbHlw?=
 =?utf-8?B?UXdsVDZ0cnpqdGZyRE93TzB0OFZMNFJNOThRQ3NYT1ljb09yUWdtbHdQdU95?=
 =?utf-8?B?ZTZRTFVlRWxnNnFOUjZ6QzNOM2ZYdCtsY05rdDh3UmFHYjhQZ0FUdENJbGNN?=
 =?utf-8?B?ZzB4TnJNTm5Fb0ZtR0tGSURhMm4xdG1kWGw0bGVaK1FmU2NqQW9RWEpablhV?=
 =?utf-8?B?NUlKbU4rZUVVMmJBRFAzejdmeDVkZlpKcXZQbDBQTGw5dlp6eXBEWStjVmJO?=
 =?utf-8?B?TGZoR1NwQTJ0eEhlRGJSTk9tbkROZm11UkM4YnN2V2FoTHl2UnpQcDR1cmJq?=
 =?utf-8?B?UXBoY212clExZTBzSUFVRWlvSms5Q1NUSlhyRkVmcU54aUxsTmlFanNlanhH?=
 =?utf-8?B?VzkvZ0JNMXBmUnJOMW1kT3QzRGYydWg3dkxlZFM4OHZPR3dEaFBRT2NWTTFu?=
 =?utf-8?B?dHJuRDhHU2xqS3dsT2YwbmZlQzhVcDQ5YTY4ZVhzS1RtczBnSFpVS2pMZGxD?=
 =?utf-8?B?S2dxTTBJQ3R2S3FlVDJsaXVhbFRYTGN0ckpkcnl5SkxGSVpHaHRyeXUrRHJL?=
 =?utf-8?B?RlFScTE5RWVFeEtkZHpReXhRSzhqNWNlZmxBaFNtWE1MeDBhZFlVNDVmK3lT?=
 =?utf-8?B?SitEL3RianFhWkxYWllIVlhWV0NucHV2THd6K0taNkVUWXBmbVA1QzUyS0Vz?=
 =?utf-8?B?bkJXbkpkQ3FTWHV5NklBWDdmdkNFaTQ1T01yT2FuT3lQcXkrZlJ0aXZpcGps?=
 =?utf-8?B?YXBJb1lZQU9ZSTV6MlIzL0c0ZFJYR2t1bEJsTUlIMjJTeGdxM1BZNkFmVGF3?=
 =?utf-8?B?Q2NWK2pjNFF6QmRlVDZFRW53M1UyYjlFdGx4WlR5YkhYQnFUYjMrdGdqQU1G?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D2C1A6F3C194444B1FE7E4848583E4E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7c1c1d-25fa-4e6f-5dad-08d9ae408384
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2021 05:17:15.6708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBSLBpo3IicRk5AlcP1yZKrHYUp5ptKIAr9vrqeZvLWrE43Aegb3meWF83etEjTzbDqjaN1zYvzkWftmfmg+Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5231
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjIvMjAyMSA0OjMxIFBNLCBKb2huIEtlZXBpbmcgd3JvdGU6DQo+IEFsbCBvdGhlciBj
aGVja3Mgb2YgcGFyYW1zLmdfZG1hX2Rlc2MgaW4gdGhpcyBmaWxlIHVzZSB0aGUNCj4gdXNpbmdf
ZGVzY19kbWEoKSBoZWxwZXIgZnVuY3Rpb24uICBVc2UgdGhhdCBoZWxwZXIgaW4gdHdvIG1vcmUg
cGxhY2VzDQo+IGZvciBjb25zaXN0ZW5jeSB0aHJvdWdob3V0IHRoZSBmaWxlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSm9obiBLZWVwaW5nIDxqb2huQG1ldGFuYXRlLmNvbT4NCg0KQWNrZWQtYnk6
IE1pbmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCj4g
LS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvZHdjMi9nYWRnZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmMN
Cj4gaW5kZXggYWI4ZDdkYWQ5ZjU2Ny4uYjg4NGE4M2IyNmE2ZSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMi9nYWRnZXQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2dhZGdldC5j
DQo+IEBAIC01MjE3LDcgKzUyMTcsNyBAQCBpbnQgZHdjMl9yZXN0b3JlX2RldmljZV9yZWdpc3Rl
cnMoc3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnLCBpbnQgcmVtb3RlX3dha2V1cCkNCj4gICAJCSAq
IGFzIHJlc3VsdCBCTkEgaW50ZXJydXB0IGFzc2VydGVkIG9uIGhpYmVybmF0aW9uIGV4aXQNCj4g
ICAJCSAqIGJ5IHJlc3RvcmluZyBmcm9tIHNhdmVkIGFyZWEuDQo+ICAgCQkgKi8NCj4gLQkJaWYg
KGhzb3RnLT5wYXJhbXMuZ19kbWFfZGVzYyAmJg0KPiArCQlpZiAodXNpbmdfZGVzY19kbWEoaHNv
dGcpICYmDQo+ICAgCQkgICAgKGRyLT5kaWVwY3RsW2ldICYgRFhFUENUTF9FUEVOQSkpDQo+ICAg
CQkJZHItPmRpZXBkbWFbaV0gPSBoc290Zy0+ZXBzX2luW2ldLT5kZXNjX2xpc3RfZG1hOw0KPiAg
IAkJZHdjMl93cml0ZWwoaHNvdGcsIGRyLT5kdHhmc2l6W2ldLCBEUFRYRlNJWk4oaSkpOw0KPiBA
QCAtNTIyOSw3ICs1MjI5LDcgQEAgaW50IGR3YzJfcmVzdG9yZV9kZXZpY2VfcmVnaXN0ZXJzKHN0
cnVjdCBkd2MyX2hzb3RnICpoc290ZywgaW50IHJlbW90ZV93YWtldXApDQo+ICAgCQkgKiBhcyBy
ZXN1bHQgQk5BIGludGVycnVwdCBhc3NlcnRlZCBvbiBoaWJlcm5hdGlvbiBleGl0DQo+ICAgCQkg
KiBieSByZXN0b3JpbmcgZnJvbSBzYXZlZCBhcmVhLg0KPiAgIAkJICovDQo+IC0JCWlmIChoc290
Zy0+cGFyYW1zLmdfZG1hX2Rlc2MgJiYNCj4gKwkJaWYgKHVzaW5nX2Rlc2NfZG1hKGhzb3RnKSAm
Jg0KPiAgIAkJICAgIChkci0+ZG9lcGN0bFtpXSAmIERYRVBDVExfRVBFTkEpKQ0KPiAgIAkJCWRy
LT5kb2VwZG1hW2ldID0gaHNvdGctPmVwc19vdXRbaV0tPmRlc2NfbGlzdF9kbWE7DQo+ICAgCQlk
d2MyX3dyaXRlbChoc290ZywgZHItPmRvZXBkbWFbaV0sIERPRVBETUEoaSkpOw0KPiANCg0K
