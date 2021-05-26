Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A4391B44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhEZPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:12:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:49206 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235357AbhEZPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:12:31 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 723E24002D;
        Wed, 26 May 2021 15:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1622041860; bh=DkjhKHZGk2tpcgHAUAu9ZaePsUqPwaT190jsASLpPNM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kIq4VKiB5cyjYSn5YtQPkQqJfAeRjipOHsuyCPv4lCXCx/lj38c4Xe2k25i5X7a/o
         w44LG3aAnlXygqr2QCPZEP3XZLpBSy1cJVZ3G4tIBCSQwfGhWuylN2HXJYxydIU3ty
         iCUFZzmn3jJtGVzq5UO0cgwL86CNyxgAWEyNOA6u303/UwlipGY3VKVAKjFuvSR5NV
         z3uZsVoG5I9Rx8T4h/tx2FFxwqa5DxjjBODY+Odi0WSbIS08bwoyBELONB7l49UtjO
         hsSzv7wFG/AUN02oroREPQXORUw0yg+5chih8IUQuynvOwA85hoFyS+HLn2gFNVHZt
         SWx7R2pfqpShw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id CA510A0077;
        Wed, 26 May 2021 15:10:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A7D1340A5C;
        Wed, 26 May 2021 15:10:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gWvDNrvX";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=muR6CllSpxnMhUg00ogsMeVwzk6cUzhYB0v5b1rlx3rY36li8/8j512dPH+FhnCoVuG6MtyI7xRoirKYNN/hjMtl7jHPoHM19KTUhe85BUMy8LMtsx/vFNs8rSSrHGzNyjgIUdUDTuvpidwXzk4m0jo40FoK8WfnaKVDjLKuD1iMA9phJ+ldsb+Dfa8c5j5CocF/aYVB5KtC1sUxykfAeKorGwcf68DpqHPTGhvE6t2vVZKfpHfiAq5Ik3fD5qapXFmavc8dLvCWkx1bgURXytlOQ/LaoNKslL3CS4ZhXz4v9K9ooFl+Gslr1/uRPQvdgbEjUz5yxL02RffJn+iESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkjhKHZGk2tpcgHAUAu9ZaePsUqPwaT190jsASLpPNM=;
 b=JqpQy16cyx+BRBoKoewc08kRsRSmrmbskQGUT/5aaNukLBQZcNHiOmWltLEbXhiQnZrUsRP0bFd6464rlozCXLPB1ecqseE5HrFM1iRQPGohz7l8RcJgHsNHCu83ek+CQgc9IpOa5pCiuihImvAKIGfSPBG6LhUXVX+CyPHyiRUtlLPYAUH2aJqVJMf3Cv4MEreEY03Pgdx/ranLiXHVayOlIGc3W7Otu7rGnCccW9PFtDU+XOHVFU208+5ZTOGAqu1hUjQwfxqwykifZUC67O4U2Q+nRVkk8pFEcAXAUG/WEItLCRz2Zu6k/MAGh80Rs9r5bWih/AjWCpVqObqKug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkjhKHZGk2tpcgHAUAu9ZaePsUqPwaT190jsASLpPNM=;
 b=gWvDNrvX2km1APo/GKwLw/8gAVkBu9hKALeoSQ9lpW8uc5zjwxfNd65i/bzNlta7I2NIc7K8Yt+LfdWgVzTruALDC3PH+BRBw8OlDRyQXTbCWGrXBUOVMkjM4+1fsq0Xy26d5dcRXnUfJ1aqOH+cdy64SFI5iomNm4rWeUnSs9U=
Received: from DM4PR12MB5390.namprd12.prod.outlook.com (2603:10b6:5:39a::12)
 by DM4PR12MB5309.namprd12.prod.outlook.com (2603:10b6:5:39d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Wed, 26 May
 2021 15:10:56 +0000
Received: from DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458]) by DM4PR12MB5390.namprd12.prod.outlook.com
 ([fe80::bd1a:d4df:7c02:e458%6]) with mapi id 15.20.4129.036; Wed, 26 May 2021
 15:10:56 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 05/24] usb: dwc2: params: Fix naming of
 'dwc2_get_hwparams()' in the docs
Thread-Topic: [PATCH 05/24] usb: dwc2: params: Fix naming of
 'dwc2_get_hwparams()' in the docs
Thread-Index: AQHXUi8qpoZfAdlXEUCJbG1iDr/iYKr13keA
Date:   Wed, 26 May 2021 15:10:56 +0000
Message-ID: <ea2c0d51-2db2-7af7-92ce-b408d9381495@synopsys.com>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-6-lee.jones@linaro.org>
In-Reply-To: <20210526130037.856068-6-lee.jones@linaro.org>
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
x-ms-office365-filtering-correlation-id: e74082b2-4aa2-45e9-8b86-08d92058764c
x-ms-traffictypediagnostic: DM4PR12MB5309:
x-microsoft-antispam-prvs: <DM4PR12MB53092AAD6C38602C3FA346ABA7249@DM4PR12MB5309.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5IIzkAI463gwc3HYik3qhokNWNsj4DIP4ce70lCx9GKp8e+FATFBqLHUlNZyQrQXcQXeS/kSOm/mRlcOVJyZBzZTXpOfSz9nW+WiX9ltIlh/dLYgd+HEtCCT2C1IrRMz/BWPOGM2wwEzPUXV19O9NREl71mFyHlnER7wxcAI4qefZTariXL3rkbcCpsXsklz/dFltCOUgL8mMtuzx+aVdA8BY211iNmfDaYZrAKjUX8nc1aTshkyzCwJK9LDYuz1EgYybd/QwFPKyN3vD5MunTTlW2W06L/pqZZ1VVDisyd4LSOhgPjwoviZyk+RG82XwfVsL5DpeN4N8NhFColcopP93KOQhCQ80DhDLIzlSxXl8/nhN1OroJqb/RXblKsF6Vk3cmEDzWacih/sRz/7o47YGiN9Q++JjsX9UowctepFj7lK3onmTtLv5EfxetLQlxAgN1pqTjZ9LEBdKhypSLLei8QOUKHI7NDawdW6mJeixZzRi4qXw4ZBRg/d/vZ4+UtZ1LHP/tlbL3y77JSvE9D/C+TG0xAfGjs34qBCj2dc4Cq6ZEeTRy2jZSlYfDTpwvounOP4ftEwwakqDuvgqt3Mq5/1CB/csLLUHzLweddpcUXIM9oqqVVzxx7WzuF5Cx5wYHOJPFLkMQPQcFOY9CedSNwuOCn8dVC9jHqJzxpilov6Sdp7R4jKPOiQ9si
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39850400004)(376002)(76116006)(2616005)(122000001)(38100700002)(31686004)(6486002)(6506007)(186003)(91956017)(83380400001)(8676002)(26005)(8936002)(36756003)(6916009)(4326008)(53546011)(478600001)(6512007)(71200400001)(31696002)(86362001)(54906003)(66476007)(2906002)(66946007)(5660300002)(66556008)(316002)(64756008)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RzhUZmJURnhuTEdEdEtXdDc3QzhyWGhNOHdrUXVLZ2FHNzVsNVdyVTQzRlBK?=
 =?utf-8?B?Rk5NWVZJeG13bkx2OGk1U3FDRlFOUjNYeE4xc3liWnJ5YmNmT0dXcnF2NUZ3?=
 =?utf-8?B?NUF3Y3pneVVlallrZzNyTS8wbmRXSmZ5R3dMWG1oeDN6QXNkVDZhV2JEZnFJ?=
 =?utf-8?B?Rm1tdTlZZ3c3Z0pHdXVOZU9GMDIrQXpNaXMyWW54S2EwODMvak9ySUF3SUJy?=
 =?utf-8?B?aTJ5Tkxidmk4Tm5PZGhrY3ErRzJwMCtjeHVqSjR6QlR4T2FSUmpIVUM4Vmhv?=
 =?utf-8?B?M2gxaHhYV0xjY1B4MElOdS9pNzZqc01pMHdxK2tsbGNTTVdWa1MwbnFvZC80?=
 =?utf-8?B?WEV6aEgvZ2lPM1U2WTBwS05EbHliSGhHQlk4NlRyTlJqWnJSblV1dTJOTE9O?=
 =?utf-8?B?K3lKQ3BUdm9rdXV6QlJ3UG5maFZNYSttQ29JZjMrVDFYWXVaSmJ5bGlYYUVq?=
 =?utf-8?B?R3RwOEJPd1lxK3pkZjliTytTQUplejFlNDhHcTVJcnhWdG1IR01WaFV2c3N2?=
 =?utf-8?B?N2ltQVJkZjVQV3lvZ1RQdWx2YWlraDhFQjR4cGR3cUdiN2hIc2FSbjFaMVRh?=
 =?utf-8?B?L2hGbWVMU1dpcWpjc2F3RzRKSGl3emRRbjVncGd4c3pqVFVYZ1JEb0tqYmdN?=
 =?utf-8?B?U1NwUXBhRFFjNklGL1VGdm56bytXMUFXNzdOSXM5MHFlaE9kQ0pqQkI4R0pU?=
 =?utf-8?B?d2dPVDdnNUM0eFN4KzlnTTZkd1JYRVhaRlpENXQva20vWlZIUXRnZHc1emtM?=
 =?utf-8?B?bE8vY3E1ZUVtWEo0TTBOQm51OHhGYkdYSWpoV2N4VHdCbUI0d05OcWNuQ29D?=
 =?utf-8?B?S1B5bXVFTy9UR21Fb3JvMDdXcVRKZ01mV0hVMG5PWExPVTFMNlVIL0hYVktU?=
 =?utf-8?B?dWVxRjFhaEp2RDNIekxoVXdCbGxiOERhUmtvVTdTU0dUZFVRb0h2MkVsdTZJ?=
 =?utf-8?B?R0RpOTR1NllHZDJ0dFR4Nytwb0lrQ1Eza3hiNjJZLytnQy9NWEcwKzJlT2dJ?=
 =?utf-8?B?UGtPY2srdUVvWFBXVkQvVUluQ1l1QzVuVVp3NGlXWEt2anBSOE1qUkJwTXBW?=
 =?utf-8?B?WXRlNXY3VExHeEV6NElFZjA1QjRlVGpFQmlxQk5DNk04aDF0QXdYNDlIVlBx?=
 =?utf-8?B?TTBUdy8zVll3ZnlnSktmbXIvV3pmSE1oZk5GZ3lRVzZPVVRzNjN0bkNQZEo4?=
 =?utf-8?B?aThWWGQ5dDNZWldtY0RFWGF5cDJBRk43YUt2eDMxMlVHamdtQ3hSczNRUUdQ?=
 =?utf-8?B?cDBnRXNFNEErTW1YeFRKU0puZ25vOGRTcFlLeFRoT2xKOEE3KytFcHZtRWlv?=
 =?utf-8?B?NThVOThZQWp3MGhCZk5OaThuRU14ZnVXUDI1d0dJbXlsY0pnK1ZjWWdHMUVB?=
 =?utf-8?B?cGtnK1JnMGh5YWM4cWN2akpwUDE5YnZvMjF6Y25Qa1B6V2o5ZzJqNXA5b2Na?=
 =?utf-8?B?eGhpbytjaTF5M1d3WHdJd1RZcjdlRlI0Vm8vWGVpcHFVcVBBUXlGYTlvWEps?=
 =?utf-8?B?Yno3emt6RDZhSkdIUC9Cc21jai9YTmhXVThHSmFXR3NneHFEYkYwdWVvK2RK?=
 =?utf-8?B?STcxalRpU2VzODIxV1pjd1NZRHduVWVQZkM3OFp6ZW12M0U2eVQ4MWpEdHlp?=
 =?utf-8?B?alZ4VTRhaVFnOXQ4VTltWlZwa0xhaHI3OGc1K2lPU0lsUFN5RkpxTWZsR2xq?=
 =?utf-8?B?eWRRSnZRbUFxVTdKRDN6U2t2Z1V4Mk90T210azVZMW91Umt1NEVmTmFFb1Fj?=
 =?utf-8?Q?pL/u2yWeO6iQi5bI3s=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECD2B1677A57844EA45BA25C7526C6F0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74082b2-4aa2-45e9-8b86-08d92058764c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 15:10:56.2798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+GFp5lp2VKuaYHsdSZEcaeveBCh0tvh8criuxzE1Sjx4lf/plXuf6z5xugN5lTkhf2UX9XFymrTutSl9gOaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5309
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8yNi8yMDIxIDU6MDAgUE0sIExlZSBKb25lcyB3cm90ZToNCj4gRml4ZXMgdGhlIGZvbGxv
d2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6DQo+IA0KPiAgIGRyaXZlcnMvdXNiL2R3
YzIvcGFyYW1zLmM6Nzg3OiB3YXJuaW5nOiBUaGlzIGNvbW1lbnQgc3RhcnRzIHdpdGggJy8qKics
IGJ1dCBpc24ndCBhIGtlcm5lbC1kb2MgY29tbWVudC4gUmVmZXIgRG9jdW1lbnRhdGlvbi9kb2Mt
Z3VpZGUva2VybmVsLWRvYy5yc3QNCj4gDQo+IENjOiBNaW5hcyBIYXJ1dHl1bnlhbiA8aG1pbmFz
QHN5bm9wc3lzLmNvbT4NCj4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc+DQo+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1v
ZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+DQoNCg0KQWNrZWQtYnk6IE1p
bmFzIEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCg0KPiAt
LS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jIGIvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYw0K
PiBpbmRleCA3YTYwODlmYTgxZTFkLi42N2M1ZWIxNDAyMzI1IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3VzYi9kd2MyL3BhcmFtcy5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMN
Cj4gQEAgLTc4NCw4ICs3ODQsOCBAQCBzdGF0aWMgdm9pZCBkd2MyX2dldF9kZXZfaHdwYXJhbXMo
c3RydWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIH0NCj4gICANCj4gICAvKioNCj4gLSAqIER1
cmluZyBkZXZpY2UgaW5pdGlhbGl6YXRpb24sIHJlYWQgdmFyaW91cyBoYXJkd2FyZSBjb25maWd1
cmF0aW9uDQo+IC0gKiByZWdpc3RlcnMgYW5kIGludGVycHJldCB0aGUgY29udGVudHMuDQo+ICsg
KiBkd2MyX2dldF9od3BhcmFtcygpIC0gRHVyaW5nIGRldmljZSBpbml0aWFsaXphdGlvbiwgcmVh
ZCB2YXJpb3VzIGhhcmR3YXJlDQo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgY29uZmlndXJh
dGlvbiByZWdpc3RlcnMgYW5kIGludGVycHJldCB0aGUgY29udGVudHMuDQo+ICAgICoNCj4gICAg
KiBAaHNvdGc6IFByb2dyYW1taW5nIHZpZXcgb2YgdGhlIERXQ19vdGcgY29udHJvbGxlcg0KPiAg
ICAqDQo+IA0KDQo=
