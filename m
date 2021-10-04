Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E874421415
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhJDQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:30:43 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:58352 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbhJDQam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633364933; x=1664900933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dw5DYh5y1L/QRAlDQYhO5W5C9DPHcowkT64GkUKcJxQ=;
  b=DqLczWY7f7T8+dZ8NkIISfvvPFpFpwNy3XeSf67zluY1NkmtGTzTNLH2
   2XzhKTO30R42s5ugRyIjouhG9QtiNW61bWQ51H3gLGmEV2CmqxvhTs6o3
   7Baw6obzvcPlFXUZFjdPM3tdmnPlGmZragrA4dbMxq1qM2Bx3Znr0Ab1f
   GQhlI1TKUP4DuVjj4DQQf7WDDIZjkl+hQIjig0/TDj7pzXF+dU+MCx4Q7
   QteQ09ZA1aMUOFcPp1UMPMJlTACnmOww75ym+S+lCOh12fWPj/WMD4LFm
   d6/fT9/bzf7om/sZG7e9hK9w63CFtRtdn6dMWTv4nUcE5WoS+qwamknCJ
   g==;
IronPort-SDR: DCXdkKRkrbtvyCY4pyllbjykPvc7aPvGTIL19bxx0hpyVAsvNT5P9mhsK3gxdlEFNbuF+AeU1L
 q0eVhgVv0jJGBHyFC3P4O/qb50gC3ruKX0ozTadDsGoj2FNmYQaPWpOAhFD6YxAzI1u0ElpnQX
 /ctLzCW20DK2AW79uJSZOeOM/R4GY0Gf9Kp65tSS94d/lv0ATVMILWOlVXrm661ybGAj/q5+gg
 RY5pxRO5kPth08QU6zIrEr1V1mAKElpiO5Gq4Wf4NOEJg2tngykVDdomN1y5aFLv/Qm5AtKtcM
 iSPs8/rbouuvSpaVhRjGDaUg
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="71643047"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 09:28:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 09:28:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Mon, 4 Oct 2021 09:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEeyVm5yWgk5MIGeAGcU9lsJ5gzyQSSiVsKmz9AMIRkcQWqi+/oLse5gg1ZgnsELdbYIIXKtPepLqYLb4RJG+f2GQiO8iOTLRPqEFhi7A1WXAtxI35203Ud+KGkPgcuz9tpbKzNIABq9AYbA/45NvsnqR8VylTVBZ2QUZZdIdOJrT3VIQ2r92tPQA2Ahctq1OuD7YNCK7r2sCnOvL9810OVexWqgfS9V4wInivtFuhrKB1TeAsFIWJET3gonzL8DTFlgDwWx8N0DELUlsa//WG2uZZOl7kaeztBteT0Hze6QZgMHB+pEBiGaYkhW0j/X+MydDA0YP+4DQvgNHV6gMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dw5DYh5y1L/QRAlDQYhO5W5C9DPHcowkT64GkUKcJxQ=;
 b=YaDTrixmt6P7g5HR3vZBDmdSMF2SOA6vOcb4ctttmo9OXVQTclKGOAse/8OQFza7U/1yQUsKuh2d4JtGxS9P7H5B6Vi61/GzutmV2Yj21mNEve1giTFFuQyXeWAlDkVjNZp4qmtHLV2pXQMMNahbbqxPrSmPS8AS9kAkjw+mNwZvMQwAGoNEZmyvuL1e0EgHqGK5uvYg4uHrUAfGbWPDu+4hihYoITapZP3o7Eyz84DkRQysOqaDbvYE6aqzZ8oZVqFg5RoCfA9cZSU8Xg5arZXbNpdvtCdc3jqils9TH10hmRqpLYJUb7VafaReKCJYEVleg+5R8NDL75bV7hDj7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw5DYh5y1L/QRAlDQYhO5W5C9DPHcowkT64GkUKcJxQ=;
 b=La1hjAowZkKb7ihv/SA3frIC4cAsK7W4G1IpkiuBUWdaSsW1ymSPXAB6RpEebSd3MjsXcN/GpUMNjx/lD3vfFBN0ji7mDK0e+xkLirl7w+HKlWXCYPz+rYNdDgeiqTb9DQZzkE7YyiDqQXFp9RnZtn8qRojTTKYkTz+QiZmcICQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2879.namprd11.prod.outlook.com (2603:10b6:805:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.18; Mon, 4 Oct
 2021 16:28:49 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::a496:d4af:df74:5213%9]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 16:28:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Alexander.Stein@ew.tq-group.com>,
        <Alexander.Stein@tq-systems.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <robh@kernel.org>,
        <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: AW: (EXT) Re: [PATCH 2/2] mtd: spi-nor: micron-st: Add support
 for output-driver-strength
Thread-Topic: AW: (EXT) Re: [PATCH 2/2] mtd: spi-nor: micron-st: Add support
 for output-driver-strength
Thread-Index: AQHXuTzpCzQ6JNQlPUG9Of6OadU+6A==
Date:   Mon, 4 Oct 2021 16:28:48 +0000
Message-ID: <73611195-2f04-9627-7170-88af6c7faf20@microchip.com>
References: <kcEE.Dc11rDoPQ8iRcxif5TBAOA.gESl4Bi51wE@vtuxmail01.tq-net.de>
In-Reply-To: <kcEE.Dc11rDoPQ8iRcxif5TBAOA.gESl4Bi51wE@vtuxmail01.tq-net.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: ew.tq-group.com; dkim=none (message not signed)
 header.d=none;ew.tq-group.com; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea10fd57-072c-40c2-3e2e-08d987540b98
x-ms-traffictypediagnostic: SN6PR11MB2879:
x-microsoft-antispam-prvs: <SN6PR11MB28792D80AC588A990F0677F5F0AE9@SN6PR11MB2879.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LcWHWhyVeyhlrQ/CiIYiye5+dQCn3zay/D2X+lDO5HamkxfDfKDL3e15p5oj5Fs1WCYK3aK/wisVOFzCnQB4+WxHXPHRQ5y/sMMKwUVasqq8IMUiIzqIXbxAWmboFBvw+q7HIHXOEiWIBzM8Y8dtQFEbWFVIH4EZNvcjyDGeWYX5RwmqsGwLwmghVxC1D2WEWyx0RhjGuTPWdQtMYyNvxkxT6nTNriKWfABlADTx6MKENkxm/8S1D0vvEkmAGAgzSA2pXRY8dZdPMxpI5JaWAseDfKJZGVcYqmXhbj1Rh5+AYftLPHA+e/RysiCFqNjkrpmsmpUaqDThoG9nEzLb5gYwggKZADhJaYXsWj8KrNoTkVXwYjLxAb81OZVPtgbIkZ7sQWqsevhy81QrtL+pRoNK8lN3UYkm0GV7s6CAew2w4+EedzSJmJ6RRQSux8aKySTS6+nyMNq3nUBJ+7bUFBNimD4z/a2/xfsXjrCZnvrD9MczTRgSx5PFnCelM3VZfy5UnyXYHdn7ZSYKI6xx9/ZBkLktgUQ3vtb7zU7wH1ugC8Y5apfe/4/k4DwBYlcbLpQPvrEq/6w/D/AN1fWWlBAXEiRrcfqCPToUy28ctLajUYpoTQiOO2qOSrKTiawlH08OzhbMheVZ4k0uQiMtLZ7giwaM/cSdIt2gyGd3pLZ2ZpiltFUvPoX6o0S5xUezfm1fQHa+hGR63v4XR3KkTf1z4gxtK3FuHgnhqRtJ/Sxhg57nIVjoj7cKUPTBkyIe+4KYgjui9G7MD7mmyPMNpLOktvUs5GDubSq0XyzisuE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(508600001)(7416002)(66946007)(4326008)(6486002)(316002)(110136005)(26005)(66556008)(66446008)(6506007)(8936002)(64756008)(38100700002)(86362001)(122000001)(54906003)(2906002)(31696002)(91956017)(186003)(53546011)(66476007)(36756003)(71200400001)(31686004)(2616005)(83380400001)(38070700005)(5660300002)(6512007)(8676002)(76116006)(43740500002)(45980500001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0dHdUh6ciszT2NpMWhINEw2UUpuUXhUUTlqeXpYYzZJRnZLdndGQW5ENGs4?=
 =?utf-8?B?bkZ2VEdpR1NKdXpEU3VlcVNQUjAzN2wrMHBFVkVTR2Z3cjF6S2htYXZFTnJO?=
 =?utf-8?B?aFRyUjNKVTJwS0FCYktvMGh6aVFNeTk4T0VWSG00bm9sc2s3ZUFIak91SitK?=
 =?utf-8?B?ZGFzQXB2ajF4UEZtN1FJL0t0dHlheCtJQTdVN0V6NkFWam5kaTlueCt0TU10?=
 =?utf-8?B?RXpJaEJhZFpoQzNyUXhXaG94MWZrRGtKNitNOHF1cjFYNnY3Q08vcFpxcEFF?=
 =?utf-8?B?cC9CZmlFSjhEM2hVdTk0OTNSa2JRT3Y3MmhiU2c0ZUE5bmJYWGJKN21IVlhj?=
 =?utf-8?B?eDlpVXNmM0FDeUU5YU5ydlUzNzluTVkrUENaVlgxMmhRMFRFempaeHZhRW0w?=
 =?utf-8?B?THhReklROTZMSmN2d3gwSTlWSXU2eldZRkI4OEsxWUZWU2RPcWVLNDN3bk5F?=
 =?utf-8?B?ekhHNGdFVXNiRDgzazlnbjgxaGlpN2JyOVdDY2Y4K2RPOFZLVXhHdTM1STJo?=
 =?utf-8?B?RUlQbERUcjluQkxxNFpWUS9NT3o4MWZiNVp5ZEhWT2Z0UHBtbWtubjdjT20z?=
 =?utf-8?B?TXF6UzNEbC9EWHhJQTRnaUx1VGdUZElrZWhXeDlSQWNidkkwNXd0RHhlK0JY?=
 =?utf-8?B?bnhNOVB0YkxrZ3BiSlhJN3JDRFVqN1F0dllkSnZVeGd5WFlwVVE2blJrcWI4?=
 =?utf-8?B?RTNqVXRUVytZUkQwQUJlaElScTM1MHduUDc2eWRzQlpTeURzc3B2bFNlU1Nk?=
 =?utf-8?B?bWlwMllSd0dtbHg5VGtzUDNFQkRWbmoySm1iS2pDUTloZnVVR1B4TXFQRXRV?=
 =?utf-8?B?MWhhMm1jV0hBV1JCSFluNy9IQnNqYnVHYkZEVjFVM01qNmhVU2dWendGZHFH?=
 =?utf-8?B?UWJ6T2ZwNWtOaGVOTk93dmdWTHZXYUJNcVcxTW1KeUIrQnNSQWMvSmdaUkx0?=
 =?utf-8?B?UHFnU3libjhwQ2pCN2JYK054dDZrTmV6RU9NMytrWnNPMjE5aWFnNUpyZGND?=
 =?utf-8?B?K2lNdktOL0NSZ0E2S0NVNG1GV2xwMEVMVHBOcUlwNHZlZm9CWG1FQjZjb2dj?=
 =?utf-8?B?c2RhRW1Da0NiazkvY0dZY1hhdDVJbkR1TmNZRlBRd1d4MmxQNDJlbGo1eEkx?=
 =?utf-8?B?VW82NjFMbUFEMEN4WjRXMC90bzAyTlloMVhDOGRpMWJkUmtWb1kvcnJRQWdP?=
 =?utf-8?B?Nkx5RGF3WnJudUpvVGpacTFIMXVLVVcxcGdPdkhEdHM3ZHpJbnJoK1U4S3Ni?=
 =?utf-8?B?K2t6c0xnWXc4ei9NZ3JFcVQxRHJEalNCQkJ4aUxVbE96VVBSZTBtUFFTVm5I?=
 =?utf-8?B?U3I1V3dSZG9wZVBQelZkcUFkTFQxK294TnpCM09idDNaUVJLbk50VkdZRXdL?=
 =?utf-8?B?RzROR2N0QkVpWi9mOEhJVEFDVmtjZkhlell4Q0VDUnJIbk4wcHZtdzhPTnNZ?=
 =?utf-8?B?RTg5LzRDa2dwWnpQOTZtQ090NWpYZXU2MmN1VGNrMDA4ZldBMGRrRTBMSXNB?=
 =?utf-8?B?K1lwN25aQ2UzMEpJSCtvUVBtSnk1amkyMVdJazNNaFlUL1FDeWNqT1ljR0Zr?=
 =?utf-8?B?TzN5dEpPamdXV0QzdkorV3lDTlcwRVd6eTkyMHcxVTduSzQyblRPSnNJTnBB?=
 =?utf-8?B?c2tURjJ3NERDenhDdGRqV28wK3BFSnpsSDRtTDlSVUpkM1VDbWl3SFNGWWpt?=
 =?utf-8?B?c0ZNM1FvMFljd0x5ZVNNUzBoZFZHSGRtampRQ3VGNGQzblpkdU5hQmJwOXkr?=
 =?utf-8?Q?EL08Tc0lEe0Ehk81Qw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F7928B736D67E42AE4C12014A272581@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea10fd57-072c-40c2-3e2e-08d987540b98
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 16:28:49.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KH3SF58N0na6TEF4+Ro5Ynh3E+IKmKJnRKAxukyjm7wWWeEv9NznsAsoO6XOOWHaHfhfp24RMzOkJiI382Z6t2hoJ5Tkk3Ltl2bm14U1hMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2879
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNC8yMSAzOjEwIFBNLCBBbGV4YW5kZXIgU3RlaW4gd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8sDQoNCkhpLA0KDQo+IA0KPj4gRG9l
cyB0aGUgbWljcm9uIGZsYXNoIGRlZmluZSB0aGUgU0NDUiBTRkRQIG1hcD8NCj4gDQo+IEFzIGZh
ciBhcyBJIGNhbiB0ZWxsLCBpdCBvbmx5IGRlZmluZXMgdGhlIEJhc2lzIFNQSSBwcm90b2NvbCBh
bmQgdGhlIDQtYnl0ZSBBZHJlc3MgSW5zdHJ1Y3Rpb24gVGFibGUuDQo+IER1bm5vIHdoZW4gdGhl
IFNDQ1IgU0ZEUCBtYXAgd2FzIGFkZGVkLCBidXQgdGhpcyBmbGFzaCBvbmx5IGFubm91bmNlcyBK
RVNEMjE2QiAoU0ZEUCAxLjYpDQo+IA0KPiBJcyB0aGVyZSBzb21lIHRvb2wgZm9yIGR1bXBpbmcv
ZGVjb2RpbmcgdGhlIFNGRFAgYXZhaWxhYmxlPw0KPiANCg0KeW91IGNhbiBhY2Nlc3MgZHVtcCB0
aGUgU0ZEUCB0YWJsZXMgdmlhIHN5c2ZzLiBIZXJlJ3MgYW4gZXhhbXBsZToNCg0Kcm9vdEBzYW1h
NWQyLXhwbGFpbmVkOn4jIGZpbmQgLyAtaW5hbWUgc3BpLW5vcg0KL3N5cy9kZXZpY2VzL3BsYXRm
b3JtL2FoYi9haGI6YXBiL2YwMDIwMDAwLnNwaS9zcGlfbWFzdGVyL3NwaTEvc3BpMS4wL3NwaS1u
b3INCi9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9haGIvYWhiOmFwYi9mODAwMDAwMC5zcGkvc3BpX21h
c3Rlci9zcGkwL3NwaTAuMC9zcGktbm9yDQovc3lzL2J1cy9zcGkvZHJpdmVycy9zcGktbm9yDQpy
b290QHNhbWE1ZDIteHBsYWluZWQ6fiMgbHMgLWFsIC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9haGIv
YWhiOmFwYi9mMDAyMDAwMC5zcGkvc3BpX21hc3Rlci9zcGkxL3NwaTEuMC9zcGktbm9yDQp0b3Rh
bCAwDQpkcnd4ci14ci14IDIgcm9vdCByb290ICAgIDAgTWFyICA5IDE0OjUxIC4NCmRyd3hyLXhy
LXggNiByb290IHJvb3QgICAgMCBNYXIgIDkgMTQ6NTAgLi4NCi1yLS1yLS1yLS0gMSByb290IHJv
b3QgNDA5NiBNYXIgIDkgMTQ6NTEgamVkZWNfaWQNCi1yLS1yLS1yLS0gMSByb290IHJvb3QgNDA5
NiBNYXIgIDkgMTQ6NTEgbWFudWZhY3R1cmVyDQotci0tci0tci0tIDEgcm9vdCByb290IDQwOTYg
TWFyICA5IDE0OjUxIHBhcnRuYW1lDQotci0tci0tci0tIDEgcm9vdCByb290ICAgIDAgTWFyICA5
IDE0OjUxIHNmZHANCnJvb3RAc2FtYTVkMi14cGxhaW5lZDp+IyBjYXQgL3N5cy9kZXZpY2VzL3Bs
YXRmb3JtL2FoYi9haGI6YXBiL2YwMDIwMDAwLnNwaS9zcGlfbWFzdGVyL3NwaTEvc3BpMS4wL3Nw
aS1ub3IvamVkZWNfaWQNCmMyMjAxNg0Kcm9vdEBzYW1hNWQyLXhwbGFpbmVkOn4jIGNhdCAvc3lz
L2RldmljZXMvcGxhdGZvcm0vYWhiL2FoYjphcGIvZjAwMjAwMDAuc3BpL3NwaV9tYXN0ZXIvc3Bp
MS9zcGkxLjAvc3BpLW5vci9tYW51ZmFjdHVyZXINCm1hY3Jvbml4DQpyb290QHNhbWE1ZDIteHBs
YWluZWQ6fiMgY2F0IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9haGIvYWhiOmFwYi9mMDAyMDAwMC5z
cGkvc3BpX21hc3Rlci9zcGkxL3NwaTEuMC9zcGktbm9yL3BhcnRuYW1lDQpteDI1bDMyMzNmDQpy
b290QHNhbWE1ZDIteHBsYWluZWQ6fiMgY2F0IC9zeXMvZGV2aWNlcy9wbGF0Zm9ybS9haGIvYWhi
OmFwYi9mMDAyMDAwMC5zcGkvc3BpX21hc3Rlci9zcGkxL3NwaTEuMC9zcGktbm9yL3NmZHAgPiBt
eDI1bDMyMzNmLXNmZHANCnJvb3RAc2FtYTVkMi14cGxhaW5lZDp+IyBoZXhkdW1wIG14MjVsMzIz
M2Ytc2ZkcA0KMDAwMDAwMCA0NjUzIDUwNDQgMDEwMCBmZjAxIDAwMDAgMDkwMSAwMDMwIGZmMDAN
CjAwMDAwMTAgMDBjMiAwNDAxIDAwNjAgZmYwMCBmZmZmIGZmZmYgZmZmZiBmZmZmDQowMDAwMDIw
IGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZg0KMDAwMDAzMCAyMGU1IGZm
ZjEgZmZmZiAwMWZmIGViNDQgNmIwOCAzYjA4IGJiMDQNCjAwMDAwNDAgZmZlZSBmZmZmIGZmZmYg
ZmYwMCBmZmZmIGZmMDAgMjAwYyA1MjBmDQowMDAwMDUwIGQ4MTAgZmYwMCBmZmZmIGZmZmYgZmZm
ZiBmZmZmIGZmZmYgZmZmZg0KMDAwMDA2MCAzNjAwIDI2NTAgZjk5YyA2NDc3IGNmZmUgZmZmZiBm
ZmZmIGZmZmYNCjAwMDAwNzANCg==
