Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4989030E31B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhBCTMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:12:37 -0500
Received: from alln-iport-5.cisco.com ([173.37.142.92]:59949 "EHLO
        alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhBCTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5388; q=dns/txt; s=iport;
  t=1612379553; x=1613589153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fuHicj7A80rKVuxlXYWN/qQxio2Q9d07/qC0VHwNj54=;
  b=hiYMeQ9DuHqxCFjLrWsYSFBVz2CWzz8JFI+AArD9ch5Hy7pvNTNxfQro
   ErqAZdFLF4TDhhSEOZPTRMoVWORJaPBEZCJEFzyTWabzgTT0EsIXWuyFS
   VQDRlMZ8LPj6BK+vUDxD6dyczhVT8PXfHZNp0CYoZZtUxhPkAEvb7BYRC
   I=;
X-IPAS-Result: =?us-ascii?q?A0BRAwAW8xpgmIUNJK1iHgEBCxIMQIMiUYFXMjGEQINIA?=
 =?us-ascii?q?44MA5kZglMDVAsBAQENAQEtAgQBAYRKAheBZQIlOBMCAwEBAQMCAwEBAQEFA?=
 =?us-ascii?q?QEBAgEGBBQBAQEBAQEBAYY2DYVzAQEBBCMRDAEBNwEPAgEIFQMCAiYCAgIwF?=
 =?us-ascii?q?RACBAENBRmDDYJWAy4BphgCiiV2gTKDBQEBBoUiGIISCRR6KoJ3hAaGQiYbg?=
 =?us-ascii?q?gCCJYIFPoQ+F4MCgmCBWWsHgQ9LAoEqNjcsD49Ag0OKeJpPCoJ6nAIioyCUM?=
 =?us-ascii?q?qFzAgQCBAUCDgEBBoFtIYFZcBWDJFAXAg2OIQwOCYNOill0NwIGCgEBAwl8i?=
 =?us-ascii?q?xkBAQ?=
IronPort-PHdr: =?us-ascii?q?9a23=3AO9rKKRy/nZQxw6PXCy+N+z0EezQntrPoPwUc9p?=
 =?us-ascii?q?sgjfdUf7+++4j5ZRWDt/5sl1TOG47c7qEMh+nXtvXmXmoNqdaEvWsZeZNBHx?=
 =?us-ascii?q?kClY0NngMmDcLEbC+zLPPjYyEgWsgXUlhj8iKwMFNeH4D1YFiB6nG35CQZTx?=
 =?us-ascii?q?P4Mwc9L+/pG4nU2sKw0e36+5DabwhSwjSnZrYnJxStpgKXvc4T0oY=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,399,1602547200"; 
   d="scan'208";a="657289183"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 03 Feb 2021 19:11:50 +0000
Received: from XCH-RCD-004.cisco.com (xch-rcd-004.cisco.com [173.37.102.14])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 113JBnVU005666
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 3 Feb 2021 19:11:49 GMT
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by XCH-RCD-004.cisco.com
 (173.37.102.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 13:11:49 -0600
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by xhs-rtp-002.cisco.com
 (64.101.210.229) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Feb
 2021 14:11:48 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-003.cisco.com (173.37.227.248) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Feb 2021 13:11:48 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHDohUe2vL+YqXO4ZcxjUY9GOjgaK32wYcOO2hozSvThp1JxraZryEcgeW/bZvCkrGtIPxyEbkzJpxr0nrQN9RJSgRe6MZUVPs1+UllbN1swLM1Ni0zLOW2mYnKAnR9t6lLy6b+Z3zq9KKwmRZgAPzu0gXWNA5YABy4mjccMeQZfdf+equu4i7fHmxqe7aCKffRrMPEbWhr1+awI69IgZCusL1QU70anLXupd3f4yOgfcnN+rikQooHb0Daw7RYR2ktrisVqbZj/JKkMZVlIoImJExdhAqSMwmj9JmrR0XoRjClw/pOskb+ofPy+yYd8r9fj5pptP3BdFk9GkdUGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuHicj7A80rKVuxlXYWN/qQxio2Q9d07/qC0VHwNj54=;
 b=liz6jMYFxGUhW2a33orA4yNDASg01Ow1q7NWc+5tpnofSMX8cxB6AsxDSIc6QfSeqQvIuBoijuw64Us8HNgJpO4s0QD7cBJTcLKg7lFQlrGQcRJf6Otl7qAVg3sPqdgKSr7mHC4yIDjd7NM3YhVHLlwCOKyFlsrpL7+RrYgves97x0D4EbtVcrVgAvLXbC1XxDOEuRq1+NrvgXKmZan2dgu30mO/jCy1Ygg0BdjvCbpaqQxrske/uEUsjNfS+JxU/WiAjaXx9xCmqW7SqB9YDzpsXgxsVFPUJz1NIUL6CW/TkPsS25cM5o7ha20OEN9rbe/lUQ4v3TvJ8n3wgo/W4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuHicj7A80rKVuxlXYWN/qQxio2Q9d07/qC0VHwNj54=;
 b=KlqwhHrEGrJPqcyvEdfBMuqL1GhRW5etl/URbEex32oqscjtgsCaQjsnrKzPNWuv4yZGCRA5IVtJHf0wuXHVbgmfeDC07ZUwS4nc3C/k4WljfSrO+HrJsperEjG0UxWqZL9ljfb+QYjSyQ5SW6Bff0GRhOhp8Xlw6w5rtbBEYx8=
Received: from BYAPR11MB2744.namprd11.prod.outlook.com (2603:10b6:a02:c8::10)
 by BY5PR11MB3958.namprd11.prod.outlook.com (2603:10b6:a03:18e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Wed, 3 Feb
 2021 19:11:45 +0000
Received: from BYAPR11MB2744.namprd11.prod.outlook.com
 ([fe80::1831:4b15:d094:806]) by BYAPR11MB2744.namprd11.prod.outlook.com
 ([fe80::1831:4b15:d094:806%7]) with mapi id 15.20.3805.024; Wed, 3 Feb 2021
 19:11:45 +0000
From:   "Phil Zhang (xuanyzha)" <xuanyzha@cisco.com>
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>
CC:     "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "eparis@redhat.com" <eparis@redhat.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
Subject: Re: [PATCH 2/2] audit: show (grand)parents information of an audit
 context
Thread-Topic: [PATCH 2/2] audit: show (grand)parents information of an audit
 context
Thread-Index: AQHW+aqHV28JclAf1k2Lsv3wiLeyMKpFZeuAgAFjeACAAAQaAA==
Date:   Wed, 3 Feb 2021 19:11:45 +0000
Message-ID: <07df653066640842400c07aa7a06a0cfc592a854.camel@cisco.com>
References: <20210202212930.18845-2-danielwa@cisco.com>
         <CAHC9VhTo_aTTsS5W-+AJe+RrNG4yL3_TbfOKZhZfpjg0QkkZUQ@mail.gmail.com>
         <20210203185700.GK3710@zorba>
In-Reply-To: <20210203185700.GK3710@zorba>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: cisco.com; dkim=none (message not signed)
 header.d=none;cisco.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [2001:420:c0c8:1006::87f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b91d192-d506-4b15-490c-08d8c8778c64
x-ms-traffictypediagnostic: BY5PR11MB3958:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB39587A6522A0D52086DDC58FC8B49@BY5PR11MB3958.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4RIf1lu+wo9S1czfB/5TXTzSn4SQkuwZQF03f7a5VJPNYltLyG/3QzDxinQczT+pd925M0oHIPDteOfW/8lymwSpgA6VweiltlloyHv0GC+fXd/zTarL8CpUXlgmo/AcVA78AAnLm5cZwSPOKGyJJiOAoITdDXbdlB6DJaMTkmKY00NSXvGEr95o97lLAy+VjbAbE85uuYPlOtUeDhkPMaQgzTuq1qkcxqfdKfks+2J06NDarLvRrUKgAiB/LTfTsCSplURDhFHMAsIWjav0v0MJtGKn4K3HkzXq4S2E5VeL7/zOsTIpHq4BHvuY7wzBy2J8XtwGZdPkoERSRGtMHSRDwiUdxZEoMxhOqoKvshS/3Ejbf/iiSwq0k1PVTEd69giYBf/e38aD5O0JUKkl91VOiolOc/qBp8qSp+8kp2/Y4ad5/mzRigzh3mrT5rFfX6KmJ88A1kq9W9o6YopnVvu8OoY5/0C6xQavOw0QlAE+V8tfJHu90yErzpOvLyqsFnCYL2U2jarJngcXFgRDLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39860400002)(366004)(478600001)(66446008)(64756008)(53546011)(107886003)(5660300002)(2906002)(2616005)(186003)(36756003)(4326008)(6486002)(66476007)(66556008)(8676002)(6506007)(110136005)(316002)(71200400001)(54906003)(83380400001)(86362001)(6512007)(76116006)(8936002)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OHVyc0FvS1YwZk5DQUs5R0Uvd2FHOTF2MHFhUzMvcE1zUlIxYWt1RDh4K1dn?=
 =?utf-8?B?NVkyRnlSbW1aOWxSL0tIcnFiWXRHdEVhcmhTMjJXNDhFNmpVeUoxRWh4ZmVh?=
 =?utf-8?B?dXZNbmZ2K3l3R1BFV25PYnhzVjVIYXRYNnJ5ekhDQVd5WDFCYWZtMnN2OEcx?=
 =?utf-8?B?QTdVVFJIMFErR1FxdUVXeTVUb3lWOFJ3U2k5dXBlZHdORVE4Y3p5bjYwTXI1?=
 =?utf-8?B?SWRRY0JINWthQ1JQV2IwM3Z6Y2J3cXQ1OUtLMjNYdUhsY1VoN2J0TEhjbVZ4?=
 =?utf-8?B?cHA1amJxR2JzeW1ZZm1uR3ErSkxPUkJYVWUwNUk3dVdJTVZmZUxwcm5oS3dh?=
 =?utf-8?B?dGxOT0dGZlUxSlMwdFlUTGF2VjJGWWtPUGQ2dDZtbXhON1JrVkw0M1pselNI?=
 =?utf-8?B?VmhLem1mUm1ISitnVjB4MGpCaGxMMmxXSHhRM1pUaWoxQzlDR2d1ZUZjNWpM?=
 =?utf-8?B?MmRMYzVxaUplbWk2b1BrbDR6cS9NUkdvNk5ueGJvcUhJNmptaFphZjBucDJH?=
 =?utf-8?B?bmtsMHUvV3dQZFdmY0lrTHRtNVJ1RHhwNUJkMFcxeWRaYU5PdEJMMnJETC95?=
 =?utf-8?B?V2F6RDlNM0Y4cFEwSU9GcDZyYk1mcjlNejJIZzJqQ21HS08wdE8rWUxYK1NW?=
 =?utf-8?B?S21Gc3gxMWIwZ2hoejlGbk03Z21mU3NXMlZ6NWtaY0NDNE05QWQzL2V5S0J6?=
 =?utf-8?B?V3M4K1pzMEwybXBCRXJUYXAvNW5xdWR5ckUwS2prVllodjBVVW5Gck9tR3cx?=
 =?utf-8?B?MUc3QnhOMTQ5VEkxVFF5QmxHWFBGUTN0MldTdG1IU051NFA5aS9jVUFGRlJB?=
 =?utf-8?B?c04xMjhWTENRYnNBcXZEaEdTWDNYS1Q3bFVsVHoxbVB2Y2NMY1QyWDRWcE9P?=
 =?utf-8?B?SCtSa0NjZTQrd09XWHh1ditDaE9ONTZ6b3BjMHdqbHpOdWRTV1crdTRFakdh?=
 =?utf-8?B?V1BVVVNISS9wcythZHdoQ2NxNk1ubGtSZExqRTgreCtINkt5KzVjaUNyUlJQ?=
 =?utf-8?B?dHgybEp1b0U1aExBeVB4SlFiVDBDQ0xET1U1R2wzZTFQOG1nZFArR0RmRzlF?=
 =?utf-8?B?SmhUZHFyVHhsazJ0dVh2dmVXQnloVXF1T05HTjN3VGM5L09Vc1AwQWYvMVJV?=
 =?utf-8?B?VGJlZzduSXNBM1RjQWxieFpxenRzeWV5emwyeDUwOEF4dnh6SktvZjlOYkdp?=
 =?utf-8?B?TGFnYjFtc2ZNUDRJM1ZJVWpvczkrQWNVWEhUb0t3aEgyQlpFSUE3M2dIUWhm?=
 =?utf-8?B?VWdGc1pzTTJmSk1hamt1Mnl5MlJUODd2VGNPazBOZ3JQbUkxY21Kb1dmaVlY?=
 =?utf-8?B?anlsR09CaE1wMmtwK2dGZWRkK2VHd2EvcWMzYkpFMUdVejJNUTd4emF5RnVj?=
 =?utf-8?B?cGc2UVJiZlhrZ3JFS01CNXJaL1FlRkM5UENYNlJ5OHNFTG5DTUJqdkJ5ejNT?=
 =?utf-8?B?czdMa3VuYzRhNXdVK0xCcGlGWEQvL1RBZElXMnMwQVdtcGRabUVCUlpobTJx?=
 =?utf-8?B?VndYOHhCSUxSL2pBLzI4ejNMcEpyRDhudEpDQ3VLLzFoU0IwY2t6Zk8wVytm?=
 =?utf-8?B?R2RabFJselRabHFnSVNCWjcyM3k2enhCYTRvem82YWl1Lzh1Y2IzL01GVi9S?=
 =?utf-8?B?M0xwcUNQcFp2Y1NWcGN0a205TThpR2Q0U2NTcTF0YTVTVHd6ckRYMUY5ek9J?=
 =?utf-8?B?VThHNkxPSGhEdWYyeER0YU14Y29tbkJDaGhqaUNMemtPZy9QUFJjbi9jb1Y1?=
 =?utf-8?B?RHBGakJ0N0V5dUhOaG45TmJaNVMzdGJQYXpaclViMW54N2c1NzBBZGhZUGVy?=
 =?utf-8?Q?ugg4xTaBli5xQt94o++POWeGEAI568lJrbOfU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8694CD7F018F7343B4FFE663E3525482@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b91d192-d506-4b15-490c-08d8c8778c64
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 19:11:45.3621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzyfT6kI4bFCEB0eChqohxJusbi15LDwEtjzO2gCZjhd+rwJix6QIdP8R4G9r4konfCQkDzRpZbJBjdzi2JhbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3958
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.14, xch-rcd-004.cisco.com
X-Outbound-Node: alln-core-11.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gdG9wIG9mIHdoYXQgRGFuaWVsIGp1c3Qgc2FpZDoNCg0KQXMgdGhlcmUgYXJlIG1hbnkgY29t
cG9uZW50cyBiZWluZyB0ZXN0ZWQgaW4gcmVncmVzc2lvbiBydW5zLCBpdCdzDQpleHBlbnNpdmUg
dG8gbG9vayBiYWNrIGFuZCByZXByb2R1Y2UgdGhlIEFWQ3MuIEFuZCB0aGVyZSdzIG5vIHByaW9y
DQprbm93bGVkZ2Ugb2Ygd2hhdCBwcm9jZXNzZXMgbWF5IGdlbmVyYXRlIEFWQ3MuIFRoZSBhbHRl
cm5hdGl2ZSB3b3VsZCBiZQ0KdG8gYXVkaXQgYWxsIGZvcmsvZXhlYywgYnV0IHRoaXMgY291bGQg
ZWFzaWx5IGJsb3cgdXAgdGhlIGF1ZGl0IGxvZy4NCg0KQnV0IHdlJ2QgbGlrZSB0byBoZWFyIGFs
dGVybmF0aXZlcy4NCg0KT24gV2VkLCAyMDIxLTAyLTAzIGF0IDE4OjU3ICswMDAwLCBEYW5pZWwg
V2Fsa2VyIChkYW5pZWx3YSkgd3JvdGU6DQo+IE9uIFR1ZSwgRmViIDAyLCAyMDIxIGF0IDA0OjQ0
OjQ3UE0gLTA1MDAsIFBhdWwgTW9vcmUgd3JvdGU6DQo+ID4gT24gVHVlLCBGZWIgMiwgMjAyMSBh
dCA0OjI5IFBNIERhbmllbCBXYWxrZXIgPA0KPiA+IGRhbmllbHdhQGNpc2NvLmNvbQ0KPiA+ID4g
d3JvdGU6DQo+ID4gPiBGcm9tOiBQaGlsIFpoYW5nIDwNCj4gPiA+IHh1YW55emhhQGNpc2NvLmNv
bQ0KPiA+ID4gPg0KPiA+ID4gDQo+ID4gPiBUbyBlYXNlIHRoZSByb290IGNhdXNlIGFuYWx5c2lz
IG9mIFNFTGludXggQVZDcywgdGhpcyBuZXcgZmVhdHVyZQ0KPiA+ID4gdHJhdmVyc2VzIHRhc2sg
c3RydWN0cyB0byBpdGVyYXRpdmVseSBmaW5kIGFsbCBwYXJlbnQgcHJvY2Vzc2VzDQo+ID4gPiBz
dGFydGluZyB3aXRoIHRoZSBkZW5pZWQgcHJvY2VzcyBhbmQgZW5kaW5nIGF0IHRoZSBrZXJuZWwu
DQo+ID4gPiBNZWFud2hpbGUsDQo+ID4gPiBpdCBwcmludHMgb3V0IHRoZSBjb21tYW5kIGxpbmVz
IGFuZCBzdWJqZWN0IGNvbnRleHRzIG9mIHRob3NlDQo+ID4gPiBwYXJlbnRzLg0KPiA+ID4gDQo+
ID4gPiBUaGlzIHByb3ZpZGVzIGRldmVsb3BlcnMgYSBjbGVhciB2aWV3IG9mIGhvdyBwcm9jZXNz
ZXMgd2VyZQ0KPiA+ID4gc3Bhd25lZA0KPiA+ID4gYW5kIHdoZXJlIHRyYW5zaXRpb25zIGhhcHBl
bmVkLCB3aXRob3V0IHRoZSBuZWVkIHRvIHJlcHJvZHVjZSB0aGUNCj4gPiA+IGlzc3VlIGFuZCBt
YW51YWxseSBhdWRpdCBpbnRlcmVzdGluZyBldmVudHMuDQo+ID4gPiANCj4gPiA+IEV4YW1wbGUg
b24gYmFzaCBvdmVyIHNzaDoNCj4gPiA+ICAgICAkIHJ1bmNvbiAtdSBzeXN0ZW1fdSAtciBzeXN0
ZW1fciAtdCBwb2xhcmlzX2htX3QgbHMNCj4gPiA+ICAgICAuLi4NCj4gPiA+ICAgICB0eXBlPVBB
UkVOVCBtc2c9YXVkaXQoMTYxMDU0ODI0MS4wMzM6MjU1KToNCj4gPiA+IHN1Ymo9cm9vdDp1bmNv
bmZpbmVkX3I6dW5jb25maW5lZF90OnMwLXMwOmMwLmMxMDIzICBjbWRsaW5lPSItDQo+ID4gPiBi
YXNoIg0KPiA+ID4gICAgIHR5cGU9UEFSRU5UIG1zZz1hdWRpdCgxNjEwNTQ4MjQxLjAzMzoyNTUp
Og0KPiA+ID4gc3Viaj1zeXN0ZW1fdTpzeXN0ZW1fcjpzc2hkX3Q6czAtDQo+ID4gPiBzMDpjMC5j
MTAyMyAgICAgICAgY21kbGluZT0ic3NoZDogcm9vdEBwdHMvMCINCj4gPiA+ICAgICB0eXBlPVBB
UkVOVCBtc2c9YXVkaXQoMTYxMDU0ODI0MS4wMzM6MjU1KToNCj4gPiA+IHN1Ymo9c3lzdGVtX3U6
c3lzdGVtX3I6c3NoZF90OnMwLQ0KPiA+ID4gczA6YzAuYzEwMjMgICAgICAgIGNtZGxpbmU9Ii90
bXAvc3cvcnAvMC8wL3JwX3NlY3VyaXR5L21vdW50L3Vzci8NCj4gPiA+IHNiaW4vc3NoZA0KPiA+
ID4gICAgIHR5cGU9UEFSRU5UIG1zZz1hdWRpdCgxNjEwNTQ4MjQxLjAzMzoyNTUpOg0KPiA+ID4g
c3Viaj1zeXN0ZW1fdTpzeXN0ZW1fcjppbml0X3Q6czAgICAgICAgICAgICAgICAgICAgIGNtZGxp
bmU9Ii9pbmkNCj4gPiA+IHQiDQo+ID4gPiAgICAgdHlwZT1QQVJFTlQgbXNnPWF1ZGl0KDE2MTA1
NDgyNDEuMDMzOjI1NSk6DQo+ID4gPiBzdWJqPXN5c3RlbV91OnN5c3RlbV9yOmtlcm5lbF90OnMw
DQo+ID4gPiAgICAgLi4uDQo+ID4gPiANCj4gPiA+IENjOiANCj4gPiA+IHhlLWxpbnV4LWV4dGVy
bmFsQGNpc2NvLmNvbQ0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQaGlsIFpoYW5nIDwN
Cj4gPiA+IHh1YW55emhhQGNpc2NvLmNvbQ0KPiA+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
RGFuaWVsIFdhbGtlciA8DQo+ID4gPiBkYW5pZWx3YUBjaXNjby5jb20NCj4gPiA+ID4NCj4gPiA+
IC0tLQ0KPiA+ID4gIGluY2x1ZGUvdWFwaS9saW51eC9hdWRpdC5oIHwgIDUgKystDQo+ID4gPiAg
aW5pdC9LY29uZmlnICAgICAgICAgICAgICAgfCAgNyArKysrKw0KPiA+ID4gIGtlcm5lbC9hdWRp
dC5jICAgICAgICAgICAgIHwgIDMgKy0NCj4gPiA+ICBrZXJuZWwvYXVkaXRzYy5jICAgICAgICAg
ICB8IDY0DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ID4gIDQgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBUaGlzIGlzIGp1c3QgZm9yIGRldmVsb3BtZW50L3Rlc3Rpbmcgb2YgU0VMaW51eCBw
b2xpY3ksIHJpZ2h0PyAgSXQNCj4gPiBzZWVtcyBsaWtlIHRoaXMgaXMgYmV0dGVyIGRvbmUgaW4g
dXNlcnNwYWNlIHRvIG1lIHRocm91Z2ggYQ0KPiA+IGNvbWJpbmF0aW9uIG9mIHBvbGljeSBhbmFs
eXNpcyBhbmQganVzdCB1bmRlcnN0YW5kaW5nIG9mIGhvdyB5b3VyDQo+ID4gc3lzdGVtIGlzIHB1
dCB0b2dldGhlci4NCj4gDQo+ICANCj4gVGhhdCdzIHdoeSB0aGUgcGF0Y2ggd2FzIGNyZWF0ZSB0
byBiZXR0ZXIgdW5kZXJzdGFuZCB0aGUgc3lzdGVtLg0KPiANCj4gPiBJZiB5b3UgcmVhbGx5IG5l
ZWQgdGhpcyBpbmZvcm1hdGlvbiBpbiB0aGUgYXVkaXQgbG9nIGZvciBzb21lDQo+ID4gcHJvZHVj
dGlvbiB1c2UsIGl0IHNlZW1zIGxpa2UgeW91IGNvdWxkIGF1ZGl0IHRoZSB2YXJpb3VzDQo+ID4g
Zm9yaygpL2V4ZWMoKSBzeXNjYWxscyB0byBnZXQgYW4gdW5kZXJzdGFuZGluZyBvZiB0aGUgdmFy
aW91cw0KPiA+IHByb2Nlc3MNCj4gPiAoc3ViKXRyZWVzIG9uIHRoZSBzeXN0ZW0uICBJdCB3b3Vs
ZCByZXF1aXJlIGEgYml0IG9mIHdvcmsgdG8gc2lmdA0KPiA+IHRocm91Z2ggdGhlIGF1ZGl0IGxv
ZyBhbmQgcmVjb25zdHJ1Y3QgdGhlIGV2ZW50cyB0aGF0IGxlZCB0byBhDQo+ID4gcHJvY2Vzcw0K
PiA+IGJlaW5nIHN0YXJ0ZWQsIGFuZCBnZW5lcmF0aW5nIHRoZSBBVkMgeW91IGFyZSBpbnRlcmVz
dGVkIGluDQo+ID4gZGVidWdnaW5nLA0KPiA+IGJ1dCBmb2xrcyB3aG8gbGl2ZSBUaGUgQXVkaXQg
TGlmZSBzdXBwb3NlZGx5IGRvIHRoaXMgc29ydCBvZiB0aGluZw0KPiA+IGENCj4gPiBsb3QgKHRo
aXMgc29ydCBvZiB0aGluZyBiZWluZyB0cmFjaW5nIGEgcHJvY2Vzcy9zZXNzaW9uKS4NCj4gDQo+
IFdlIGhhdmUgYSB2ZXJ5IGNvbXBsZXggYW5kIGNvbnN0YW50bHkgY2hhbmdpbmcgc3lzdGVtLCBh
bmQgd2UgdXNlDQo+IHNoZWxsIHNjcmlwdHMNCj4gc29tZSBvZiB0aGUgdGltZS4gSWYgYSBzaGVs
bCBzY3JpcHQgdHJpZ2dlcnMgYW4gQVZDIGl0IHdpbGwgdHlwaWNhbGx5DQo+IHNob3cgdGhlDQo+
IHRvb2wgY2FsbGVkIGluc3RlYWQgb2YgdGhlIHNoZWxsIHNjcmlwdCB3aGljaCB0cmlnZ2VyZWQg
Y2FsbGluZyB0aGUNCj4gdG9vbC4NCj4gDQo+IFdlIGRvIGhhdmUgYXVkaXQgZW5hYmxlZCBpbiBw
cm9kdWN0aW9uIHN5c3RlbXMsIGFuZCBJIHRoaW5rIHdlDQo+IGNvbGxlY3QgdGhlc2UNCj4gbG9n
cyBpbiBjYXNlIG9mIGlzc3VlcyBvbiB0aGUgcHJvZHVjdGlvbiBzeXN0ZW0uIFBoaWwgaXMgYmV0
dGVyIHRvDQo+IGFkZHJlc3MgdGhpcy4NCj4gDQo+IFdlJ3JlIHdpbGxpbmcgdG8gdHJ5IGFsdGVy
bmF0aXZlcyBsaWtlIHdoYXQgeW91IHN1Z2dlc3RlZCBhYm92ZS4NCj4gDQo+IERhbmllbA0KPiAN
Cg==
