Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658543B23E4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 01:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhFWXMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 19:12:05 -0400
Received: from mail-eopbgr1410078.outbound.protection.outlook.com ([40.107.141.78]:29717
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229688AbhFWXMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 19:12:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5e6T/z3nCBNuAxLgZ4FHHTZIZmP+LzpheqJSwgzexaaTA8PURCuF40/UglfCZRI5iEhMoWhToJ49p8zdOY10inV8SiOKdx7yRUG5WgPtGHCyK8rLkXBR+q+mUYoi8bdENvM+OWWQgBJdnN7j5eXw8TxNpuXrEduAFT75UZkH9Fqq7H0guca4Z0fhZrWmwDeCieiy07m/c3wapTq/BMapBwOwA/zRkC+ufrX43SSZMZd/WTmySeFWQuCWGpjF0PXB2JEG6mbbMOEd90LehEfsFJEPxwzSVGTP8djyikxpLx+V8uO1GAkMuhz/tsZu1hasVztrGLlXRUq/4TYIPWmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ScwhG7h0YXS1EfQPFbUf4/zPbcVdBnmrL4P0/ryy6E=;
 b=Yd54iUrSDM1QslVWh5b9IpfKkp6nj5er+M8u63bT/Iwqdr8MsGwwDJs9ttnVCgcAYx3E54YncmUHF591LYSMksVnEJFnxFErTtc5DrTmqYB9ca1Q4e+kLAmsGYz9Z1HW+RQ/vBPurANqnE6TRfufsv5uBIobngA0DtDZw6y0g0pNA4VDwua8Jca43Xjpawv+nD+Kkqz3Sea8AbbPixxOgm994nUAmCs9LEvQEv2er/zLh8znv211ejV9gFq6U02WUx/EudiMLmWNiV99i3SgLCawCvnee3ze7d/9cmFHqFwASLMknwmJah9aJPo9DUmyJp3wGej1jmt6BWIqW/BKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ScwhG7h0YXS1EfQPFbUf4/zPbcVdBnmrL4P0/ryy6E=;
 b=RQXeMhCb9wqgYwW8tdkbzDg6NC364v3gGnxzeDS0zst9i1yWtM0eN399QzkVg584OtikMf2kZr7Zb0rQxSND9+f984f62V++3bv/lV3+Mdp7vN2Krv/5oTRpXeUCGLRP+640f60U29XAEqtNEraaeSpifksuk1bwB3xj+GgRKPo=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5929.jpnprd01.prod.outlook.com (2603:1096:404:8054::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 23:09:40 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::751b:afbb:95df:b563%5]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 23:09:40 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Wang Wensheng <wangwensheng4@huawei.com>,
        David Hildenbrand <david@redhat.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rui.xiang@huawei.com" <rui.xiang@huawei.com>,
        =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
Subject: Re: [PATCH] mm/sparse: Fix flags overlap in section_mem_map
Thread-Topic: [PATCH] mm/sparse: Fix flags overlap in section_mem_map
Thread-Index: AQHXaITYkxTC4UgbbEScTTfz2sUPkg==
Date:   Wed, 23 Jun 2021 23:09:40 +0000
Message-ID: <20210623230939.GA2963480@hori.linux.bs1.fc.nec.co.jp>
References: <20210427083019.110184-1-wangwensheng4@huawei.com>
 <e838d8b5-84f1-5532-6f22-e4b729124e1c@redhat.com>
In-Reply-To: <e838d8b5-84f1-5532-6f22-e4b729124e1c@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62711ca6-4a88-4d14-0fdc-08d9369bfac7
x-ms-traffictypediagnostic: TYAPR01MB5929:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5929D06E9CF1BBFC5C98A2B4E7089@TYAPR01MB5929.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+Y+gGfjkg9g6AM4hkEjLq+f19OCHObrawnBWe3ShZjehKKMvHJXzXrN3+u9nB+AxgLRqL71J4MJ1NnnReEGDtqMGlSJ7QkDr1JNIjfMl7MUpeCriCnUFTrMPusx2Aoj8hthTJ4PFNwIHo2r+uGEDTIFkE3CpO31iVGRCGS0Gcj2mJy8rAlYSWedxg9LtnW16NdrJ4dOOF7/WFSVLQBRsB4mnTz2xLpdOaQ6ivBznRFg8SwpdIleVZ47WcQo4VclZ5sXrMLlpgmaWv7qll2P0szdxkn73eOztjKhlL00mZN6TtHKiN8uLI2K8fBEhsuio5nritKJM5um+7mm1ilUcI61wBwbla7ov5SiNXwR98gXSAEhLboALhb1AZxZQB7bUhq4sODdrmG3UGO2hI7X7Nw6lzoWd/qCUfKU+zAPow7YK2x/8BNuhqy+ASmVi+jrOw/v5207kWPnHvwE9s/N7uY4NGqMcKhSCQ9Y+uxcfKHDZcTYtJd8+uKwh4JUS8wJE6ucMA1jForNWl3OOXrRCxMbwBshqGDpnTHr9bp0SBQk7j88eHHsYQj8h+OB2HEoau9+YKD19Lbtufv4yfqn/5VwkgJ3znXZ6HKCAcBVgIw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39850400004)(366004)(136003)(4326008)(478600001)(1076003)(66556008)(66446008)(33656002)(8936002)(2906002)(85182001)(66476007)(122000001)(64756008)(26005)(186003)(86362001)(8676002)(38100700002)(83380400001)(53546011)(6506007)(66946007)(55236004)(71200400001)(76116006)(9686003)(5660300002)(6512007)(6486002)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUdkUFZaWGFYOE13MTdWRFRvN3dCOUVPOVdsTHFGNU1MYlFUNGtPZ25RdjRk?=
 =?utf-8?B?Mk9ENVFXSHlINVhsQUpUMExMYWpha2RWVzBWa3FZVlR6NzV0dENZSWdYaHpB?=
 =?utf-8?B?S3RzZ1lhbCtFM25sTEJKak1NaWZ0QThWSmtTNFI0aVVMK1dLWmRYb294RytL?=
 =?utf-8?B?clcwMnVISzJqZkNoTFA5YzY2Tm9pTlpYSEZPbTlFQnVTc3ppN3pjRVhoTHpU?=
 =?utf-8?B?QkhqaGpKZ1o2SDIzWGJRa3RrVGZCendkd2VrZTNkbXZkWFZYUzV4SGhSMk9U?=
 =?utf-8?B?MnM0dFh2OXVYRVZNWk9BWmI4NjlvRENkKzQrcm96OGVIZ0pTczZqYk56M0tM?=
 =?utf-8?B?ektWdjh1V2kvSTV6eElZTk5kMDF1RXd3a3BndFdlckdjTVEzZDJ2Z0FNWnVs?=
 =?utf-8?B?T09EaFhqSFVScGJsbWJLc1pqalNMRVZuVng4NDl1WVRDckNVZTFRUyt2YzlF?=
 =?utf-8?B?elZMR1NtTjhKV2dMa3lkalIwa2ppOXhQUEZmQ1lhT21nREZBTS9HS2dneFBL?=
 =?utf-8?B?NjEwdVd0L2kyTnJhWk5ta2ZpVUIydzZDeVFPcDJkeUVDQ1BFRyt4NE1oMkw2?=
 =?utf-8?B?VDFyQy82WUcrMXI4ZmoyenBDRWxHQXNTa3lTbU9JS0I1Vk5IYkNmczlYbTVZ?=
 =?utf-8?B?dlFTVFFSQ01MMlowWWRkTDkzcGFBdklKOGNkZHZOZmZQSTl6OTMzRXh6cVV2?=
 =?utf-8?B?OWtrS0I5dVEwOFJqRnhmMWU4Tk96WUZIZmppcjVSVXhXNzdOZVpaRmMycVMx?=
 =?utf-8?B?Tm9wRVRBTTA2L0VkVCthVCtuSUFaLytBb0JMc2NaZ1IrejZIWVBHRjdDOHBU?=
 =?utf-8?B?a1VFYmRiYzRjYzN2WGZDRFVSWUNxTG5laVF2amtEOFNGUHBYcDNqU1dSUUJC?=
 =?utf-8?B?K0kxNllsdUFtQmg1dzlWdUtueVpKcWh6ZG91Tk1TckRBK0l3SGRqZUtpN0hQ?=
 =?utf-8?B?TmlMUDRsNnhJQkNXUjVIOVNjMjNpUXAzM050QmpGKzhucmc5T3E3RkNPRnda?=
 =?utf-8?B?c1REaGRFTXNtUkVlSjB1NzcvM3VURVJicC9lTEtneHZMNU9zVVJTeU1za1Br?=
 =?utf-8?B?ZGxIY0tTZ1pvOW1reGtKckFzQkFkNi9JN2RpczVLUjk0THV4dWlmdFlHc2k1?=
 =?utf-8?B?Z0xEVVprcEtmN1N3Vzh0YkJlcytuN3d1NmtrVjA1TVI5WmN0NGVXM2tOMXpq?=
 =?utf-8?B?OFBBaE9GZWFWbVZ0QzhyVWJsSmNudWx3Nk9wSVl6MDBURGtpd1hURHA1OEow?=
 =?utf-8?B?WEZYTWkyUU95blRqbmFCS096VS9oUHhFNGZ0RFhaUXVRa1VaL0JtcW5BSERI?=
 =?utf-8?B?MU1uYkFqS1lvOU5GV2pGVnFwUUVXaEZHV3o0bU1VcStiUDVyUjBSZXdUOXJB?=
 =?utf-8?B?MmE1UnZSQmV2aVVSYVMxeisvdnp2WW1ORTgwd3MzZ2k1NUxnL3BBSys3alZu?=
 =?utf-8?B?V3Z1QzVCUGJWZFRmSDRxTXR5dlVtbEJDa2FxZmZkS281dkpGOEhtdm5PRThr?=
 =?utf-8?B?YStXM3FmSDJnd0hLVFFPSi9vRmdnSTB0UkNCSk5ObDRYcTRGNHhIR0ZaZkl0?=
 =?utf-8?B?RE94SjBTdkV3WE1sWkRUTTVOZ3pxcnNQNG5tOTZ2dS83YTFGLy9aMlY4RU1N?=
 =?utf-8?B?cHE3R084VzZrVVUxTEg0WktKNFJCMzZhRjd5S2k0a2QyL1g3QWFaUjllVDBG?=
 =?utf-8?B?SWVPTXpZL3NSWXZhc3JTN0ZMQ04rb3VUOC8vWENWOTdNdzJpZVE3SDlNZ09S?=
 =?utf-8?B?ZnErOC9YTjdFcUxpbm5lVDdGb2szTkx3dUNUWDhEMEpWZk5CbE5sN0lLbm1a?=
 =?utf-8?B?U3ZON0svV0Y0QVRTSVpHZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C8CC8E84F18304B9EC589CBF2EBCCDA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62711ca6-4a88-4d14-0fdc-08d9369bfac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 23:09:40.4106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1t1eXnoPslsHIFE6mrR1Ikrwfbh4B99AmSd9sLpE6K0RnVnNOm8RgVaQ24nbAV58ZZQhRzxOvUdTxci335H6dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5929
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBcHIgMjcsIDIwMjEgYXQgMTE6MDU6MTdBTSArMDIwMCwgRGF2aWQgSGlsZGVuYnJh
bmQgd3JvdGU6DQo+IE9uIDI3LjA0LjIxIDEwOjMwLCBXYW5nIFdlbnNoZW5nIHdyb3RlOg0KPiA+
IFRoZSBzZWN0aW9uX21lbV9tYXAgbWVtYmVyIG9mIHN0cnVjdCBtZW1fc2VjdGlvbiBzdG9yZXMg
c29tZSBmbGFncyBhbmQNCj4gPiB0aGUgYWRkcmVzcyBvZiBzdHJ1Y3QgcGFnZSBhcnJheSBvZiB0
aGUgbWVtX3NlY3Rpb24uDQo+ID4gDQo+ID4gQWRkaXRpb25hbGx5IHRoZSBub2RlIGlkIG9mIHRo
ZSBtZW1fc2VjdGlvbiBpcyBzdG9yZWQgZHVyaW5nIGVhcmx5IGJvb3QsDQo+ID4gd2hlcmUgdGhl
IHN0cnVjdCBwYWdlIGFycmF5IGhhcyBub3QgYmVlbiBhbGxvY2F0ZWQuIEluIG90aGVyIHdvcmRz
LCB0aGUNCj4gPiBoaWdoZXIgYml0cyBvZiBzZWN0aW9uX21lbV9tYXAgYXJlIHVzZWQgZm9yIHR3
byBwdXJwb3NlLCBhbmQgdGhlIG5vZGUgaWQNCj4gPiBzaG91bGQgYmUgY2xlYXIgcHJvcGVybHkg
YWZ0ZXIgdGhlIGVhcmx5IGJvb3QuDQo+ID4gDQo+ID4gQ3VycmVudGx5IHRoZSBub2RlIGlkIGZp
ZWxkIGlzIG92ZXJsYXBwZWQgd2l0aCB0aGUgZmxhZyBmaWVsZCBhbmQgY2Fubm90DQo+ID4gYmUg
Y2xlYXIgcHJvcGVybHkuIFRoYXQgb3ZlcmxhcHBlZCBiaXRzIHdvdWxkIHRoZW4gYmUgdHJlYXRl
ZCBhcw0KPiA+IG1lbV9zZWN0aW9uIGZsYWdzIGFuZCBtYXkgbGVhZCB0byB1bmV4cGVjdGVkIHNp
ZGUgZWZmZWN0cy4NCj4gPiANCj4gPiBEZWZpbmUgU0VDVElPTl9OSURfU0hJRlQgdXNpbmcgb3Jk
ZXJfYmFzZV8yIHRvIGVuc3VyZSB0aGF0IHRoZSBub2RlIGlkDQo+ID4gZmllbGQgYWx3YXlzIGxv
Y2F0ZXMgYWZ0ZXIgZmxhZ3MgZmllbGQuIFRoYXQncyB3aHkgdGhlIG92ZXJsYXAgb2NjdXJzIC0N
Cj4gPiBmb3JnZXR0aW5nIHRvIGluY3JlYXNlIFNFQ1RJT05fTklEX1NISUZUIHdoZW4gYWRkaW5n
IG5ldyBtZW1fc2VjdGlvbg0KPiA+IGZsYWcuDQo+ID4gDQo+ID4gRml4ZXM6IDMyNmUxYjhmODNh
NCAoIm1tL3NwYXJzZW1lbTogaW50cm9kdWNlIGEgU0VDVElPTl9JU19FQVJMWSBmbGFnIikNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFdlbnNoZW5nIDx3YW5nd2Vuc2hlbmc0QGh1YXdlaS5jb20+
DQo+ID4gLS0tDQo+ID4gICBpbmNsdWRlL2xpbnV4L21tem9uZS5oIHwgMiArLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW16b25lLmggYi9pbmNsdWRlL2xpbnV4L21tem9uZS5o
DQo+ID4gaW5kZXggNDc5NDZjZS4uYjAxNjk0ZCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L21tem9uZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tbXpvbmUuaA0KPiA+IEBAIC0x
MzI1LDcgKzEzMjUsNyBAQCBleHRlcm4gc2l6ZV90IG1lbV9zZWN0aW9uX3VzYWdlX3NpemUodm9p
ZCk7DQo+ID4gICAjZGVmaW5lIFNFQ1RJT05fVEFJTlRfWk9ORV9ERVZJQ0UJKDFVTDw8NCkNCj4g
PiAgICNkZWZpbmUgU0VDVElPTl9NQVBfTEFTVF9CSVQJCSgxVUw8PDUpDQo+ID4gICAjZGVmaW5l
IFNFQ1RJT05fTUFQX01BU0sJCSh+KFNFQ1RJT05fTUFQX0xBU1RfQklULTEpKQ0KPiA+IC0jZGVm
aW5lIFNFQ1RJT05fTklEX1NISUZUCQkzDQo+ID4gKyNkZWZpbmUgU0VDVElPTl9OSURfU0hJRlQJ
CW9yZGVyX2Jhc2VfMihTRUNUSU9OX01BUF9MQVNUX0JJVCkNCj4gPiAgIHN0YXRpYyBpbmxpbmUg
c3RydWN0IHBhZ2UgKl9fc2VjdGlvbl9tZW1fbWFwX2FkZHIoc3RydWN0IG1lbV9zZWN0aW9uICpz
ZWN0aW9uKQ0KPiA+ICAgew0KPiA+IA0KPiANCj4gV2VsbCwgYWxsIHNlY3Rpb25zIGFyb3VuZCBk
dXJpbmcgYm9vdCB0aGF0IGhhdmUgYW4gZWFybHkgTklEIGFyZSBlYXJseSAuLi4NCj4gc28gaXQn
cyBub3QgYW4gaXNzdWUgd2l0aCBTRUNUSU9OX0lTX0VBUkxZLCBubz8gSSBtZWFuLCBpdCdzIHVn
bHksIGJ1dCBub3QNCj4gYnJva2VuLg0KPiANCj4gQnV0IGl0J3MgYW4gaXNzdWUgd2l0aCBTRUNU
SU9OX1RBSU5UX1pPTkVfREVWSUNFLCBBRkFJS1QuDQo+IHNwYXJzZV9pbml0X29uZV9zZWN0aW9u
KCkgd291bGQgbGVhdmUgdGhlIGJpdCBzZXQgaWYgdGhlIG5pZCBoYXBwZW5zIHRvIGhhdmUNCj4g
dGhhdCBiaXQgc2V0IChlLmcuLCBub2RlIDIsMykuIEl0J3Mgc2VtaS1icm9rZW4gdGhlbiwgYmVj
YXVzZSB3ZSBmb3JjZSBhbGwNCj4gcGZuX3RvX29ubGluZV9wYWdlKCkgdGhyb3VnaCB0aGUgc2xv
dyBwYXRoLg0KPiANCj4gDQo+IFRoYXQgd2hvbGUgc2VjdGlvbiBmbGFnIHNldHRpbmcgY29kZSBp
cyBmcmFnaWxlLg0KDQpIaSBXZW5zaGVuZywgRGF2aWQsDQoNClRoaXMgcGF0Y2ggc2VlbXMgbm90
IGFjY2VwdGVkIG9yIHVwZGF0ZWQgeWV0LCBzbyB3aGF0J3MgZ29pbmcgb24/DQoNCldlIHJlY2Vu
dGx5IHNhdyB0aGUgZXhhY3QgaXNzdWUgb24gdGVzdGluZyBjcmFzaCB1dGlsaXRpZXMgd2l0aCBs
YXRlc3QNCmtlcm5lbHMgb24gNCBOVU1BIG5vZGUgc3lzdGVtLiAgU0VDVElPTl9UQUlOVF9aT05F
X0RFVklDRSBzZWVtcyB0byBiZQ0Kc2V0IHdyb25nbHksIGFuZCBtYWtlZHVtcGZpbGUgY291bGQg
ZmFpbCBkdWUgdG8gdGhpcy4gU28gd2UgbmVlZCBhIGZpeC4NCg0KSSB0aG91Z2h0IG9mIGFub3Ro
ZXIgYXBwcm9hY2ggbGlrZSBiZWxvdyBiZWZvcmUgZmluZGluZyB0aGlzIHRocmVhZCwNCnNvIGlm
IHlvdSBhcmUgZmluZSwgSSdkIGxpa2UgdG8gc3VibWl0IGEgcGF0Y2ggd2l0aCB0aGlzLiBBbmQg
aWYgeW91DQpsaWtlIGdvaW5nIHdpdGggb3JkZXJfYmFzZV8yKCkgYXBwcm9hY2gsIEknbSBnbGFk
IHRvIGFjayB0aGlzIHBhdGNoLg0KDQogIC0tLSBhL2luY2x1ZGUvbGludXgvbW16b25lLmgNCiAg
KysrIGIvaW5jbHVkZS9saW51eC9tbXpvbmUuaA0KICBAQCAtMTM1OCwxNCArMTM1OCwxNSBAQCBl
eHRlcm4gc2l6ZV90IG1lbV9zZWN0aW9uX3VzYWdlX3NpemUodm9pZCk7DQogICAgKiAgICAgIHdo
aWNoIHJlc3VsdHMgaW4gUEZOX1NFQ1RJT05fU0hJRlQgZXF1YWwgNi4NCiAgICAqIFRvIHN1bSBp
dCB1cCwgYXQgbGVhc3QgNiBiaXRzIGFyZSBhdmFpbGFibGUuDQogICAgKi8NCiAgKyNkZWZpbmUg
U0VDVElPTl9NQVBfTEFTVF9TSElGVCAgICAgICAgIDUNCiAgICNkZWZpbmUgU0VDVElPTl9NQVJL
RURfUFJFU0VOVCAgICAgICAgICgxVUw8PDApDQogICAjZGVmaW5lIFNFQ1RJT05fSEFTX01FTV9N
QVAgICAgICAgICAgICAoMVVMPDwxKQ0KICAgI2RlZmluZSBTRUNUSU9OX0lTX09OTElORSAgICAg
ICAgICAgICAgKDFVTDw8MikNCiAgICNkZWZpbmUgU0VDVElPTl9JU19FQVJMWSAgICAgICAgICAg
ICAgICgxVUw8PDMpDQogICAjZGVmaW5lIFNFQ1RJT05fVEFJTlRfWk9ORV9ERVZJQ0UgICAgICAo
MVVMPDw0KQ0KICAtI2RlZmluZSBTRUNUSU9OX01BUF9MQVNUX0JJVCAgICAgICAgICAgKDFVTDw8
NSkNCiAgKyNkZWZpbmUgU0VDVElPTl9NQVBfTEFTVF9CSVQgICAgICAgICAgICgxVUw8PFNFQ1RJ
T05fTUFQX0xBU1RfU0hJRlQpDQogICAjZGVmaW5lIFNFQ1RJT05fTUFQX01BU0sgICAgICAgICAg
ICAgICAofihTRUNUSU9OX01BUF9MQVNUX0JJVC0xKSkNCiAgLSNkZWZpbmUgU0VDVElPTl9OSURf
U0hJRlQgICAgICAgICAgICAgIDMNCiAgKyNkZWZpbmUgU0VDVElPTl9OSURfU0hJRlQgICAgICAg
ICAgICAgIFNFQ1RJT05fTUFQX0xBU1RfU0hJRlQNCiAgDQogICBzdGF0aWMgaW5saW5lIHN0cnVj
dCBwYWdlICpfX3NlY3Rpb25fbWVtX21hcF9hZGRyKHN0cnVjdCBtZW1fc2VjdGlvbiAqc2VjdGlv
bikNCiAgIHsNCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
