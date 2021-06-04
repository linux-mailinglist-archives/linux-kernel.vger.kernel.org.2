Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB439B981
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFDNJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:09:46 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48560 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1622812079; x=1654348079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uJtCddZ3KkALMGo06GK960VJb6jOOg6DV5FsigAHodI=;
  b=Uwd6trqMVWhtXKYUGLdreJZSSgYGhE/BPyQ00UZvJPGkUpIX+JKTLQl7
   34PPhGEEtVOH0Gsz+99ecHMU14AVeWXd1rGSpwlKGOMI8yKa3KhZKvxCn
   +TOnvIlRhF62ObaIeGnft20nsHb9I6NQlOsCV3ZYxiSI7/O6IQ1yNIQ4W
   T4rAjzYmEsiM989z5+XSqCNnnok341N2PUUKsaf6DPr7WxhBtVB7h0UWm
   Yq7EBpbMcTzfBj331F+Hr38rlad4e2AxkBr49M+XZjufok0Wnq15rXtHp
   XRn4pTHMomWSjggeAvBnyIFhvRYl+qtDQx9C+8H2E3unRTx8HPXcMRhWx
   A==;
IronPort-SDR: SOPmu6vNktOt+G2dZHGBgdfGR18LfrKxqu+8LvyA61u5G36UoV0g6QqLW22qvqGlk5pQitU1jK
 uR1y4LUffMhgEQGb1CiA3SLm5YH8rPPS59ufj+KmQnay51/EUdfdJCgfFGMNkr1DZgleHopuz3
 XpmE477o8DTNVjY+dAQ5Ik9Mm3P596O8OLpGgLMnHd0x9x/AaDrWOx2riJ+ftzZHXV1NDw6S64
 E2iWxy5TjIX1Wlq30zlxhjgKQSje78wRMFf0YoWYBa44c+u7HNn0GSGG9nbb9pBTONstaRfGvP
 bOo=
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="117652518"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Jun 2021 06:07:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 06:07:58 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 4 Jun 2021 06:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9n9jBQ/q8RnK/4udhtI7NH87DgKV7vwk09cZNW0JC6/nnbEQnIKrElSiazA09lhESk5fcphK5T3rzpgluFRr8lW4NzOAvsx+VhDpG25Pj0puTzSsPxg9aSCFY3sc61dLhuH+0Q1IKjGzSKqURn7lqG1g7cbR9rOdQOZtDvDomA4ysWJq6Jfa5gnHQhcWuBcRLaC28Ewhin6BI2tr2Dy9AdM/5sdxis2m+C0N5gNSRP5oSSLGMvouIn6pXM4qlxjNQo86EKeMPKxSle3eu7SMT2tg9oG4q0EjTmboeokaM85czG9Y9OohTwDKSmKWntUFMrSxw0VNG0dq7AqTGjJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJtCddZ3KkALMGo06GK960VJb6jOOg6DV5FsigAHodI=;
 b=fAJM6/3CD09ghDuR8G77uEVFe/xd62Y9WDVioGpojEFXsiLsRMnYhbGLdrG/NeK0c7mg/yOJY5Ld3ahjFBvyvc7zcMs4YyO+1ceBJKQSkQJ5Rf6qHhBX5qLcVXVq6DWKpeOu2gj6tsLolN6KbDDs7HJNQvJFspsRLmAdqksg3r5wWddpAU9BB2yixEAt8X6De0zXbOHOgohF047t0UtgODL4IzHJfbBrZClDnC3ji+6CziW3FwmWY5sFTQ0mRrAYyAWyfvNM6zuoABP4GLDS8hXHQ98hRLfSiTgKjbc3NjLYj7b3DwOOZxIEQuvP33kkt4Mv95OReAL9WopkE14ulQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJtCddZ3KkALMGo06GK960VJb6jOOg6DV5FsigAHodI=;
 b=YadKpBao+Y2MU4oIYo2yzuK6+cCQRuQ3N4Fybr4eI3aL+hIjzztarDkuqtELSV6K2bKGu9oi/TQVEEWzKgkk2PxVY3PzW4gwhTCZ7TqDijSpBP6NNT4RRGsAGMf6NA7lTSYkzwbJlBx4xP/5HqhkF7baeYeuqXm6FyC8AgWjK98=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by MWHPR1101MB2303.namprd11.prod.outlook.com (2603:10b6:301:5b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 13:07:56 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::1c4:1014:a541:e370%4]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 13:07:56 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>
Subject: Re: [PATCH v5 3/5] mtd: spi-nor: otp: return -EROFS if region is
 read-only
Thread-Topic: [PATCH v5 3/5] mtd: spi-nor: otp: return -EROFS if region is
 read-only
Thread-Index: AQHXWUKi6uM9wdkNjkycmiOG/lhhMw==
Date:   Fri, 4 Jun 2021 13:07:56 +0000
Message-ID: <c2b58dcc-5a60-792c-30ac-a3db327a85ed@microchip.com>
References: <20210604100252.9975-1-michael@walle.cc>
 <20210604100252.9975-4-michael@walle.cc>
In-Reply-To: <20210604100252.9975-4-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6e0b670-524a-414e-f9cf-08d92759c570
x-ms-traffictypediagnostic: MWHPR1101MB2303:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB230305F294C2B644A4E61D22F03B9@MWHPR1101MB2303.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BQbJHd/5mKZyNEwXNhbcTbGSOPgeLvgH/8S0B2Sq4+ThFPE0xY5ifWgmOP887wzpA3+Mj8F+B2ElT+VigcvNqqGG/4ZV6sBj9mGpauhhpPxERwlPFyL6OZu68la7eWFFR4u5hyZYvX/7tZGn3Bxz/BXt5pCfJMe+tSsjbC3EiyqNn3aagjaUFUKf4nnFHshViNLkjrV90OcRe2j67PM7VWldP97NM4ZC+eFd72ppEf8DrUP4LcHR1W+LewpbuNMkP6R0/YnWfvyyH/YLJh8MjXqqk4eM2Mzo+jER+6YeIDrlThVDNiUqOtj0+v/W6k13k9cWaEVOHhuPWj09flCrPIUXj8qPIbQduJ4C8MAAsvjquuS58E6IgmavrpV+oGjS1VcXDRjvrWBcXTsgFu6368DxmNSpRfHRZPDpNAlsXCv95P84uZm0x2du/vtCYBYRc+Ou8KrR7Oy861H3MGI4hn/kh34tdy0Lo3dN5xBWePqtzgFMs/BX9qQF8XwknAfl/RICDDIeANVYHWecWKria0nOoq0R5LbR8G06hyG1k7bECuRXzEAmGNFrJCmpFx3fMOf/IyCeB/ro/Zgj8l248TLoNQFxpdNa8wSgMSdlzQnrMSXRXHiXdeC/OLNYayGQITaLM4kscmafVHfvhj7+Z+Q2aoASKXSGx71HqROz4Iv3KRLS9Ogbxokg9uPHxko8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(396003)(366004)(136003)(376002)(478600001)(38100700002)(8676002)(8936002)(6512007)(2616005)(31686004)(4326008)(122000001)(66476007)(36756003)(66556008)(86362001)(71200400001)(76116006)(66946007)(66446008)(64756008)(6486002)(5660300002)(91956017)(110136005)(2906002)(83380400001)(186003)(31696002)(316002)(54906003)(53546011)(6506007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VHBndVpnM3RicFNrRHcrc0FETmhLK3ZkcTgzMnhhZVFvYjhnUmV1NENQQVND?=
 =?utf-8?B?YURKQWFJekRLVVpvQ1hUa0k0NGN0MWtZSUdyWVh6RUV6ZWEwTmZDbFZiZXB5?=
 =?utf-8?B?MUdwdS9aUks4MFFiTjBsbGhwYW9PMGRLUmtzajBKWW11UUdhYm5QdGdmbUxj?=
 =?utf-8?B?QkRPK2tIV1RoSkNMa3dSRUdWNVh5MzZzVEpEamY2KzA2TTk1dlR6d2lpYVpY?=
 =?utf-8?B?MFl5QTF5SHNTYnpWWDNxMVRHT1RzOWNvL05pU01pb2o1bUIxajEwSmlRbExp?=
 =?utf-8?B?RTZqcHBlVEN4a2U2MDF2UHFPSmVRM0o0OHZJRjF6ckJveW9mdFZOaFhNOTN0?=
 =?utf-8?B?VmdzamxuMVY3dG1xWENJdG5iTXo2VlBFS1pMbEFRcEhyR0ZuZENKeFRaUFA2?=
 =?utf-8?B?ZmxwaDhJblhxWjZydzk0dVQ5MHF3Q1YxUmVYUFhNN0F2QlptTmJ5VlJoZVdY?=
 =?utf-8?B?MFhkcHVPOU9RUUVDdFlYT1lxY1NFN0l3c0FqOFJVaHBkV29ITG5iUTRNZG15?=
 =?utf-8?B?UUNZL1VkQVlzZDRidFRIRFh1bDNORmxweGxYL2trZDlSbFViNnUxcUpXMU5p?=
 =?utf-8?B?SGFoWVQ5Uk1ZMXdXTWFQU3dhT3FpbUdpcitvOTFVazJpa2NKNGpBdi9nQ0dz?=
 =?utf-8?B?RTZPRysyQ2NseEpUVXo2MkQ5V1E2M3plaCtKN2NWNVhEZzB4TlpNU3JLbWJR?=
 =?utf-8?B?bVhYR29TTDB4ZU5XNGpCZ2pySlFkM0NaNmYyYTBObnJWeHdGTXJTOUtKUlhy?=
 =?utf-8?B?RmVaMC95dmdiSm5haktJZzVONTVwRUE2b21IVkg2aVFZYzNRaFM5N3BUakpt?=
 =?utf-8?B?V2ZiU01PRzhodEhMWVV5eFN4S2VZRWdBcmc4b3hlZER2b050Z0JUQVJmQUt0?=
 =?utf-8?B?UkN1UFJDN0lvMXJ2dXJidzYyK0hoRGc3NzB2dXZ2V0pJR1VPMzhab0VzcU9u?=
 =?utf-8?B?TWtldFZDdzFIaE9URWpzM0hKdnM1Z1FyYTVCQ0R0ZDdLMVE0SGhiVFdVZFJy?=
 =?utf-8?B?bWhQSkdvWmhpTVFkdjVYSFZpZCtXeXRaMjRycDgwaHFIZThhc0tldkJQVVYy?=
 =?utf-8?B?WEN2L0pjOUp5Nno3emovTEg3eG45MEMwZUJLQ2tCU3ZzRXA4VXlyL1d0Q3ZB?=
 =?utf-8?B?YkUxSVJIbmh0MDFPWjkrRlZOVnpzM3h1bkNUMVdaNldUOE9EOUNkQzg1UE8v?=
 =?utf-8?B?amVlWkRXNU5YRXpBdWVWcDFrQlFxbHU4cVhHRGVCQ3NVcXFWSFlwT2F4T1dY?=
 =?utf-8?B?ckdXZi9VWUEzaUxOWmc0THBzbVM5dmg1ZnVlNmVFNkxoUnk5eEpmQ2tPdXRT?=
 =?utf-8?B?M2pPdHhXdmcyck5GNUVxTzQ0TjlSUDQ1US9vamhiTk8wbnJLMk1aWWsydmRI?=
 =?utf-8?B?UDhqV1cvTDNNNXdDMVBiRGsxUWZnaUxLWUYvLzlFaDBzV1VXUVlmS2gvMGhy?=
 =?utf-8?B?dnIzL2ZYQXNUZUxLbWg3M3dWL3pFa0lCRzR1b082TjhzU0llQW1sRlk2bWNn?=
 =?utf-8?B?cUlUV2RSUGZBVzdPYkpHWFVGbHNkQTcwYVpEa3QwSlBIWWJ4WXljWnV6TXFF?=
 =?utf-8?B?ZllSMGh0d09OUFhnZ2pwZFBCK2VnemMrakhMWEZFM3gxemFDK3llVjhDR3R0?=
 =?utf-8?B?NmRxMWIwZXlQbG14UUFxYU1GamlYanlGQUdUOVBGWHZZVWRpZjVUd3BOdWRo?=
 =?utf-8?B?cXptamxqSVFmT3I5bU5KNU9YcEQxS2c0TWFmeGhWaFFoNUlIRTdIamFXUUNh?=
 =?utf-8?Q?Nc2h5V6W7+KH1VSsN8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <377F74ABFFF37C459B8D53FCB17797C8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e0b670-524a-414e-f9cf-08d92759c570
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 13:07:56.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnGDAfEdz6plDGJQ52mnN+soWrLHppfC+AmzOZKFBHbiJfqU/BS9XAGmqyvQc0nDVBeNsLXvk08ZmT3xis241/Er2ClDNQJL8hKiGYcGnCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2303
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi80LzIxIDE6MDIgUE0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gU1BJIE5PUiBmbGFzaGVzIHdpbGwganVzdCBpZ25v
cmUgcHJvZ3JhbSBjb21tYW5kcyBpZiB0aGUgT1RQIHJlZ2lvbiBpcw0KPiBsb2NrZWQuIFRodXMs
IGEgdXNlciBtaWdodCBub3Qgbm90aWNlIHRoYXQgdGhlIGludGVuZGVkIHdyaXRlIGRpZG4ndCBl
bmQNCj4gdXAgaW4gdGhlIGZsYXNoLiBSZXR1cm4gLUVST0ZTIHRvIHRoZSB1c2VyIGluIHRoaXMg
Y2FzZS4gRnJvbSB3aGF0IEkgY2FuDQo+IHRlbGwsIGNoaXBzL2NmaV9jbWRzZXRfMDAwMS5jIGFs
c28gcmV0dXJuIHRoaXMgZXJyb3IgY29kZS4NCj4gDQo+IE9uZSBjb3VsZCBvcHRpbWl6ZSBzcGlf
bm9yX210ZF9vdHBfcmFuZ2VfaXNfbG9ja2VkKCkgdG8gcmVhZCB0aGUgc3RhdHVzDQo+IHJlZ2lz
dGVyIG9ubHkgb25jZSBhbmQgbm90IGZvciBldmVyeSBPVFAgcmVnaW9uLCBidXQgZm9yIHRoYXQg
d2Ugd291bGQNCj4gbmVlZCBzb21lIG1vcmUgaW52YXNpdmUgY2hhbmdlcy4gR2l2ZW4gdGhhdCB0
aGlzIGlzDQo+IG9uZS10aW1lLXByb2dyYW1tYWJsZSBtZW1vcnkgYW5kIHRoZSBub3JtYWwgYWNj
ZXNzIG1vZGUgaXMgcmVhZGluZywgd2UNCj4ganVzdCBsaXZlIHdpdGggdGhlIHNtYWxsIG92ZXJo
ZWFkLg0KPiANCj4gRml4ZXM6IDA2OTA4OWFjZjg4YiAoIm10ZDogc3BpLW5vcjogYWRkIE9UUCBz
dXBwb3J0IikNCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5j
Yz4NCj4gUmV2aWV3ZWQtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL290cC5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivb3RwLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL290cC5jDQo+IGluZGV4IDM4OThlZDY3YmExYy4uMDYzZjhmYjY4NjQ5IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL290cC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivb3RwLmMNCj4gQEAgLTI0OSw2ICsyNDksMzIgQEAgc3RhdGljIGludCBzcGlfbm9yX210
ZF9vdHBfaW5mbyhzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgc2l6ZV90IGxlbiwNCj4gICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4gK3N0YXRpYyBpbnQgc3BpX25vcl9tdGRfb3RwX3Jhbmdl
X2lzX2xvY2tlZChzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3Qgb2ZzLA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGxlbikNCj4gK3sNCj4gKyAg
ICAgICBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9vdHBfb3BzICpvcHMgPSBub3ItPnBhcmFtcy0+b3Rw
Lm9wczsNCj4gKyAgICAgICB1bnNpZ25lZCBpbnQgcmVnaW9uOw0KPiArICAgICAgIGludCBsb2Nr
ZWQ7DQo+ICsNCj4gKyAgICAgICBpZiAoIWxlbikNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAw
Ow0KPiArDQoNCllvdSB3b24ndCBuZWVkIHRoaXMgaWYgeW91IHB1dCBwYXRjaCA0LzUgYmVmb3Jl
IHRoaXMgb25lLiBXaXRoIHRoaXM6DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRv
ci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIElm
IGFueSBvZiB0aGUgYWZmZWN0ZWQgT1RQIHJlZ2lvbnMgYXJlIGxvY2tlZCB0aGUgZW50aXJlIHJh
bmdlIGlzDQo+ICsgICAgICAgICogY29uc2lkZXJlZCBsb2NrZWQuDQo+ICsgICAgICAgICovDQo+
ICsgICAgICAgZm9yIChyZWdpb24gPSBzcGlfbm9yX290cF9vZmZzZXRfdG9fcmVnaW9uKG5vciwg
b2ZzKTsNCj4gKyAgICAgICAgICAgIHJlZ2lvbiA8PSBzcGlfbm9yX290cF9vZmZzZXRfdG9fcmVn
aW9uKG5vciwgb2ZzICsgbGVuIC0gMSk7DQo+ICsgICAgICAgICAgICByZWdpb24rKykgew0KPiAr
ICAgICAgICAgICAgICAgbG9ja2VkID0gb3BzLT5pc19sb2NrZWQobm9yLCByZWdpb24pOw0KPiAr
ICAgICAgICAgICAgICAgLyogdGFrZSB0aGUgYnJhbmNoIGl0IGlzIGxvY2tlZCBvciBpbiBjYXNl
IG9mIGFuIGVycm9yICovDQo+ICsgICAgICAgICAgICAgICBpZiAobG9ja2VkKQ0KPiArICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gbG9ja2VkOw0KPiArICAgICAgIH0NCj4gKw0KPiArICAg
ICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IHNwaV9ub3JfbXRkX290cF9y
ZWFkX3dyaXRlKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3Qgb2ZzLA0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCB0b3RhbF9sZW4sIHNpemVfdCAqcmV0
bGVuLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHU4ICpi
dWYsIGJvb2wgaXNfd3JpdGUpDQo+IEBAIC0yNzEsNiArMjk3LDE2IEBAIHN0YXRpYyBpbnQgc3Bp
X25vcl9tdGRfb3RwX3JlYWRfd3JpdGUoc3RydWN0IG10ZF9pbmZvICptdGQsIGxvZmZfdCBvZnMs
DQo+ICAgICAgICAgLyogZG9uJ3QgYWNjZXNzIGJleW9uZCB0aGUgZW5kICovDQo+ICAgICAgICAg
dG90YWxfbGVuID0gbWluX3Qoc2l6ZV90LCB0b3RhbF9sZW4sIHNwaV9ub3Jfb3RwX3NpemUobm9y
KSAtIG9mcyk7DQo+IA0KPiArICAgICAgIGlmIChpc193cml0ZSkgew0KPiArICAgICAgICAgICAg
ICAgcmV0ID0gc3BpX25vcl9tdGRfb3RwX3JhbmdlX2lzX2xvY2tlZChub3IsIG9mcywgdG90YWxf
bGVuKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGdvdG8gb3V0Ow0KPiArICAgICAgICAgICAgICAgfSBlbHNlIGlmIChyZXQpIHsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVST0ZTOw0KPiArICAgICAgICAgICAg
ICAgICAgICAgICBnb3RvIG91dDsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICB9DQo+
ICsNCj4gICAgICAgICAqcmV0bGVuID0gMDsNCj4gICAgICAgICB3aGlsZSAodG90YWxfbGVuKSB7
DQo+ICAgICAgICAgICAgICAgICAvKg0KPiAtLQ0KPiAyLjIwLjENCj4gDQoNCg==
