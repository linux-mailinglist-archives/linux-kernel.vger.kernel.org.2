Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA0363C87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237805AbhDSHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:32:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37360 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237818AbhDSHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:32:25 -0400
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1BBBD4066D;
        Mon, 19 Apr 2021 07:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618817516; bh=HVsUXRZIl6qarVTrrZ9O5zLHEM9WpDBeeuSGd9+cFiA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=h61HHjuMo6aF7OPTxug48XnscKdP+4frPJ06PaEDx0cKZoLYpi/Yc0WND+whhaLiZ
         vNWSNBKKa6lMAzCEzQQJ6tvbjZLl8dlQpU83U6d1Lh/a04DtTripr+ohNu+O9jq+h+
         xe6WQdlO1NGq7UQDiqfdm0ZW026sWOrltr6AuvbDlogAmT4an061sLYdTLiXNEbOT/
         bbBoaAGG7c+TrdU2QEnOkFVrJQMNoat7rQuL5nXD9sb0qyJ6bpjjYD2kMvWE/OKG6z
         Dj50zvmQ39CbKp+rEtGTJArQV2qWqhg8DsL3szOYNcy649U/NNuH1OtM0M1AFveGvm
         tzD83IUsm8QYA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C4D42A0063;
        Mon, 19 Apr 2021 07:31:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 1CAB3802D0;
        Mon, 19 Apr 2021 07:31:55 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wtdhh6Vq";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvnwILTEBS0LAhyE4Wpv1dEyK9YNTNPNI6EuSJ3PZAD9FyPr372A9b5yAsd/LsYSrH41W+8zYR9c3qbp+8dQTmPvQiyNww1peozMasKV3VfMd99S6P8PAG62K1O8IGpYMUuKJE89mJ7oRNtZLEtHLhkdoy/6rNy8ujN1L6rS0eyaWM0CSPmQg1TM7jl7Y3uEmV4snR1Osn3TagSavVnbAzsOzhk5qz/RVIBw5vxqjEd95lMDjpZskISArZvi8HpLEDgSETgqAXvYgG2t8M6JfoXAy+P1Mg/tKE6PdNpeYWRdPMkN/9bNSE3ofrltKj5lRIXd3ua4B/DuZSv9wWvDeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVsUXRZIl6qarVTrrZ9O5zLHEM9WpDBeeuSGd9+cFiA=;
 b=nOf2oa8Ttrsq2hDR7HZ5oPUPdVFwVzqutRjj6NM1ITydJYqO/Sq/ZBUSsjs33QnzF3Bg/rR6Zt4yU5UObCDP9KO8OYyBt0+Lj4FGwyCiQR6+GNEBFpkYTe5JJ4r93oXzE40A0P+ksdyRFnFs+wyTCnhlXkpbBaiaIYHw3NzHx9tr1OSapC7fy7VBYkKkVUa5mvVlK+EWcawTWHsvPd7VNYLGPwIkzAVC5hNhTkOWI2LRxXjH7kfsee8wsMAZghda4MefNdzsi9xI97QTbx4gp9gMVSj/J/pgeLDdiwidCumLS2fOa6jQy5NpiaBoIMYwvvRks9Ywg2WPo/IKgn/OGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVsUXRZIl6qarVTrrZ9O5zLHEM9WpDBeeuSGd9+cFiA=;
 b=wtdhh6VqyMef2x+jh2dwXuF4YqPlcsopUARlDNAvMCEpOSgjpCWLm1T38IM0hP3BX7BUxtjIi7GuzlMyU6POTTLnXkGNH9RZEJQfMUjgMopmFpTj1g0h2yMjskslzRp3mFcgkfhHaX0HJ0cbuKLOxWYyolgMrUbg0tCUnO/L5Y8=
Received: from BYAPR12MB3462.namprd12.prod.outlook.com (2603:10b6:a03:ad::16)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 07:31:53 +0000
Received: from BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1]) by BYAPR12MB3462.namprd12.prod.outlook.com
 ([fe80::a025:1ced:b6f2:6c1%4]) with mapi id 15.20.4020.027; Mon, 19 Apr 2021
 07:31:53 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH v2 12/15] usb: dwc2: Add hibernation exiting flow by
 system resume
Thread-Topic: [PATCH v2 12/15] usb: dwc2: Add hibernation exiting flow by
 system resume
Thread-Index: AQHXMr7K4K4YL5fAEkm8KCuUO7NThaq7dqWA
Date:   Mon, 19 Apr 2021 07:31:53 +0000
Message-ID: <1d784536-b648-26f7-166e-e9e53a5c33ff@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <20210416124819.A3B26A005C@mailhost.synopsys.com>
In-Reply-To: <20210416124819.A3B26A005C@mailhost.synopsys.com>
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
x-ms-office365-filtering-correlation-id: 40c3d9b3-25f8-4538-f563-08d90305346c
x-ms-traffictypediagnostic: BY5PR12MB5000:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB5000CF0FB0FD8944CB943FADA7499@BY5PR12MB5000.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WEZMPeEtwsNe9y6qRSRvMEGAYvn4klxzW2pFT3ZvtJYiuc/ngh0GA9KBqfys1e62GNcmSbLHB0enqkpZYEIjUDRqq3xYzxzMUDuLG/zxIAF8ENPh3qLzGkS45Zhswaimz+7OE7zPLzEQsB3TSVjMm8FZWmaUlWTL6pq5Plsuvbtn2DGUMLfJJSJ5h1s1xnb5351Rj2i+KOJCRJ4DHLRzUXbmmWAxCOZSZTjv2A4ixv1pdQ6obpGQWSG+K2+27unzgOXh61NPv43F6AFFoS8UhKBfhTtsSpJrtF9lZnG2Dr8mFdhpa++RQbkEMjxclFZDzw715SSWNU8yjZt+vJ84BDfAJAK93Wizkz68ebnc+dEQqtAXIVSyaOf+0H9nE5FMl9Fr55cAbRf5SZ/Zg4MKHneWzx79TcFqc1/I5+Zyw96zIZungBUJTLofs87j4Q1fFisFaptlICJEnm2PtMctww2S+gGeBq+4Y2TonZdP0sk/EvUij/LnbuRT9WAhytksnsd8iaNUpULhMmeirzR6zJJMxdI74BLm6MkvtlWPGIa9ZridLd6rIFJIP/akWjuINVOA9LH2tGahkz8FXbNpb+i+njsaowz9ppOB/gfGVuCPrh3WBJyObntADBceAQ4b8GwdYVvlsWwoIALLZo22T14N8J5ArOYxFCkcfxsVXLtY+3N+R8ZTDn4+99Q9gvFi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3462.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(346002)(136003)(8936002)(31696002)(2616005)(83380400001)(86362001)(110136005)(122000001)(2906002)(31686004)(38100700002)(107886003)(6512007)(316002)(4326008)(186003)(26005)(8676002)(478600001)(71200400001)(66476007)(6486002)(76116006)(64756008)(66946007)(91956017)(66446008)(66556008)(36756003)(53546011)(6506007)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dVE4b3R5cUdVejk2TkhhTGVTQkR4d3p2YjVOUVRPZFJYUDZTN1hLaVYweHdJ?=
 =?utf-8?B?MitrTnNBcEtOSXY4Y0pzaVpPYXFGQ1FNZm1na3VHUUlIZE42THVKcG5ZemJL?=
 =?utf-8?B?NWc1RnN1b0ZxTWFaR3RwS3UvMlhKUTZHT29MU2l4SzQyUVgyd2ZHUmxndGxH?=
 =?utf-8?B?Z1V2bFdhY3VPeFlXelRmZUM2R3FadE5NMTY5UlZWOHdJb2wvQXp6N2gxWFoz?=
 =?utf-8?B?a1JVWmRYRElmeHlVYnRRaW5SWFltRkdVVnpVZ3lZNDB4U0ROUEFBaW96S1Jk?=
 =?utf-8?B?S2tzZ29ReVFwNXBXWEhHaHhoMDAxUERoTEJUT2RVOGFLTnZiSmNmK2FWcDcr?=
 =?utf-8?B?Z25hQjdZb2xHSmxKVUJQRlAzNnZzNHRlUnl5Z3l2cnpLdHZFQlprMy9VL2dZ?=
 =?utf-8?B?K2J6dXNyNTU4TDk1SEtBUG94cmdqeGJlR2hqT2FrOGl0TVVpTTErQzhmaWxW?=
 =?utf-8?B?d0xLNVdEM2dpUHE2SEVrWGsvT0N4LytqZThDUWFhTlUxNzlVNUN1L2h3SHdR?=
 =?utf-8?B?ZUxjLzhMSFByY1ZKWEpOWkdFMXU2dHkrYzJDNFRPQjg0YW0ydVQ0UHo3YTFK?=
 =?utf-8?B?TVlHUHlnL0xydXlaY213RjREV2l4V2dxdnJXenRBc1FjMmdkT1RkWW52SmdT?=
 =?utf-8?B?K01FdWZDZ2JTYWQ4N1BSeVoxVFhUbzVqWFUrM3ZmaVlWTVl1WTBHY2w2NC93?=
 =?utf-8?B?dlNTNTBHWWd0anlWK0p0MXZXanFqSDlSWHB5OEhYb2hIMEk1QUlEaWNvbFpS?=
 =?utf-8?B?UGQycS9HUXJ0VmsyeTFZM3J6aGg1OWxZdFZRTGl3Rk1pR0lQc3BXaStudm5i?=
 =?utf-8?B?OWlKaURZY3hpU3prUnhEZzRMVHF0Y0M0VEJLTUVlYnM5a3J3bFJSTUYzc2NV?=
 =?utf-8?B?dVoyNkdsWCtzOTVjZlVzSlpCSzg0dURKYUpZZ1hhVDVyZ0lMdDhXMXF0MVcz?=
 =?utf-8?B?V1RrQ1UxeTkyTVhlNHBtZktCZkZaRTdnQ1NyU01reHpTSEEzSGN4RnlPdXFl?=
 =?utf-8?B?M3EzazIxZ1hMZk1UWktoazV5dW02N3U0V0dYcnVOMi9yc3ZpNkhCanE2dnZG?=
 =?utf-8?B?QmxZTDN0dmU3Vko0UTVEVERGVVZ2TkhKYWpSdC82Zi9ZSTh6dTFMeE0rd2xa?=
 =?utf-8?B?ZFNJdEZ4N3VzWEsxWVBFanZjRDYyYWR2cnVLdVhIaUtabUE5eE1lb0drNjdw?=
 =?utf-8?B?ckY4dGVYK3IyWm9wWlVNVnI4OFp4T1NRUEgxcTBsdC9lZytSdWJvYUdjbnJT?=
 =?utf-8?B?a2VEeTMycCtmaFBYUFIwc0duaDY4WlQ1UXJxa2NFNER6NXJvYXB1UWRwbGRw?=
 =?utf-8?B?VFRyM3Zta3FCUy9kUHpXT1NXMmFSMDh2RjZWRE8wNG5mUDBJblQ0eVQ1eDdo?=
 =?utf-8?B?eklBR2NjdHo4Tlltc3JIckxOdDBCTnMwOFhLNFA4blFnc0hyY2xhQlpYaXFU?=
 =?utf-8?B?RU9naHpFTEFUSktDaGFETVNqaGtrRGl4cUdHZ0dURVpzYWZXVHoxaHNRUlhP?=
 =?utf-8?B?cjl2WXkyMFVKcmxKdlZjNDh2QkxIN005ZHhDWWQ2NmFkaGw2RmZNbXV5QzFt?=
 =?utf-8?B?akRUU1Nva1dVWFZQMUZFZjJDMXNtSHMyQmVNR1lwQXpaRVM0VjNuZW9NTUhS?=
 =?utf-8?B?QkE2RWE1dVlydGdLSDd5elRrMDlmOW94WklReGVmVk1xK2FZNkF6R3F1a0x3?=
 =?utf-8?B?YzlJU0pBdXBIT0h6ZEdPR2ZJcmlRQmh5Um4ydTBBZG56cmNYK3dNQ2pqNHND?=
 =?utf-8?Q?kmsqqnD3OBFDkiJvOk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <030D8ABE6B31384DA6C1ECD14D32068B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3462.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c3d9b3-25f8-4538-f563-08d90305346c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 07:31:53.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r2cB829Y9Mw6Nt0F9AW+fRw/u8iQU4nIRUWPq6C37Q0zJYbq6BiRJYxuAIYP7o4+Hpiyy0pU4PvZDjlGMKz/AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNi8yMDIxIDQ6NDggUE0sIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4gQWRkcyBhIG5l
dyBmbG93IG9mIGV4aXRpbmcgaGliZXJuYXRpb24gd2hlbiBQQyBpcyByZXN1bWVkDQo+IGZyb20g
c3VzcGVuZCBzdGF0ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFydHVyIFBldHJvc3lhbiA8QXJ0
aHVyLlBldHJvc3lhbkBzeW5vcHN5cy5jb20+DQoNCkFja2VkLWJ5OiBNaW5hcyBIYXJ1dHl1bnlh
biA8TWluYXMuSGFydXR5dW55YW5Ac3lub3BzeXMuY29tPg0KDQo+IC0tLQ0KPiAgIENoYW5nZXMg
aW4gdjI6DQo+ICAgLSBOb25lDQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvaGNkLmMgfCAxMCAr
KysrKysrKysrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9oY2Qu
Yw0KPiBpbmRleCA5Mjg0ODYyOWNjNjEuLjAzNWQ0OTExYTNjMyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy91c2IvZHdjMi9oY2QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IEBA
IC00NDcwLDYgKzQ0NzAsMTYgQEAgc3RhdGljIGludCBfZHdjMl9oY2RfcmVzdW1lKHN0cnVjdCB1
c2JfaGNkICpoY2QpDQo+ICAgCQlzZXRfYml0KEhDRF9GTEFHX0hXX0FDQ0VTU0lCTEUsICZoY2Qt
PmZsYWdzKTsNCj4gICAJCWJyZWFrOw0KPiAgIAljYXNlIERXQzJfUE9XRVJfRE9XTl9QQVJBTV9I
SUJFUk5BVElPTjoNCj4gKwkJcmV0ID0gZHdjMl9leGl0X2hpYmVybmF0aW9uKGhzb3RnLCAwLCAw
LCAxKTsNCj4gKwkJaWYgKHJldCkNCj4gKwkJCWRldl9lcnIoaHNvdGctPmRldiwgImV4aXQgaGli
ZXJuYXRpb24gZmFpbGVkLlxuIik7DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogU2V0IEhXIGFjY2Vz
c2libGUgYml0IGJlZm9yZSBwb3dlcmluZyBvbiB0aGUgY29udHJvbGxlcg0KPiArCQkgKiBzaW5j
ZSBhbiBpbnRlcnJ1cHQgbWF5IHJpc2UuDQo+ICsJCSAqLw0KPiArCQlzZXRfYml0KEhDRF9GTEFH
X0hXX0FDQ0VTU0lCTEUsICZoY2QtPmZsYWdzKTsNCj4gKwkJYnJlYWs7DQo+ICAgCWNhc2UgRFdD
Ml9QT1dFUl9ET1dOX1BBUkFNX05PTkU6DQo+ICAgCQkvKg0KPiAgIAkJICogSWYgbm90IGhpYmVy
bmF0aW9uIG5vciBwYXJ0aWFsIHBvd2VyIGRvd24gYXJlIHN1cHBvcnRlZCwNCj4gDQoNCg==
