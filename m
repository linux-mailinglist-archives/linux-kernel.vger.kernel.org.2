Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD63D1189
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbhGUN6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:58:31 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:50636 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232976AbhGUN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:58:29 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LEXAA3018384;
        Wed, 21 Jul 2021 07:38:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=voI5x8JlYE2iBHnp7GMvgWc3rZOZr37qattPAn2XHYA=;
 b=uOBBBjQrCID9U4dDLFAwXEBuYS+SllQzpuOrQpwaYG3tHPGbl8jW03oQu7civXifBpHB
 XkI/ziqHz2awOFdQvz9AtnkLK3VY4ST+sGL4AM8W1jEtvrdHO9mfMna5a21hqiEj4UUE
 HPY6Ydy5pX1iIcwvKFNtG01Z7gfIorsErUMYerax6mIkuBsvZ+sgjEnO4iW3CXMLxcP2
 +oGjJVyn5eUOuR+/Pq8YNflWKVNEfIHJN3epgPun0DPVcWd87G/lNHcqsXd7U8aEI1Iv
 C3ElzrPMTZzdo6/msvNGmyD9G7yEm5eoTzVifZqX/1Qcd+OulsFIvGetmydUpS/8cbfO 5Q== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by mx0a-002c1b01.pphosted.com with ESMTP id 39x7x5sg4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 07:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnywogEDqOvF1qgMpJgzjLGnoB1TkcPA2FYojZjSnV74I16tpl/gzBoqLQR418wYA8T8goCYZQ8oaa4d9oRV5NF4myeY0H6W0FeESJ+BASoYpk7Y35UihDNoxTmhAq6DFwQhfUAMgvfEtkMkW0OtmzmuHIeHad36dD/tAbtFF8ajXiz3ZOztmucnli4F2u4ovwpaLKTxqzrdd85rDtcBPWZZ0SC6/5ajF692tUAQo+oLvcsaXhlyx+rTNJUN1/byehwK3taHNxcKVvwmEztgQvklsX+WA1/SdnKPTdsCse65rU7Hi2x9/yN2X/2X0vFeb+IFvsU6Jwjx8gcvQv9SCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voI5x8JlYE2iBHnp7GMvgWc3rZOZr37qattPAn2XHYA=;
 b=iRtWHTor6Ygaz2a1EPyIIJn9Axa2GbhqDbsnNAhmo8vqVzQWZeOfkmltAQBoj7pa7VUA2tbwvoXZ+jfx9OgaTHsgLzRePPcqALB4PCmv7DPt9oKvcTN2gTqUpy/gIF7s0qez+8yMCWk/aU8rh6YgVpo+oM0RV8nnB6FN+n7sgSQzH9nW4u+dmw+JuhJuEnKkX6MjkeYzele+Ssb1nUmpy8u417/8v85QVp/tDs7ZaDJ6jC4AJUK/e7mdCd+pC5wVLda6pdL3/D4U7Pxv9KZ72K+Od2ucfMRC0xWiGEW2HSxYmKcyPJGTe9/0zrkkQzLcSJonbI91UuyK8UUfU9Bw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3460.namprd02.prod.outlook.com
 (2603:10b6:910:91::14) by CY4PR02MB3334.namprd02.prod.outlook.com
 (2603:10b6:910:76::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Wed, 21 Jul
 2021 14:38:31 +0000
Received: from CY4PR0201MB3460.namprd02.prod.outlook.com
 ([fe80::31ca:e149:11b7:5f8b]) by CY4PR0201MB3460.namprd02.prod.outlook.com
 ([fe80::31ca:e149:11b7:5f8b%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 14:38:30 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
To:     Peter Xu <peterx@redhat.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "ovzxemul@gmail.com" <ovzxemul@gmail.com>
Subject: RE: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Thread-Topic: [PATCH v5 24/26] mm/pagemap: Recognize uffd-wp bit for
 shmem/hugetlbfs
Thread-Index: AQHXebZmBTPHtO67e0+5F2gnOfKvWatKFHUAgABnSwCAABZVAIAACUGAgAKxz0A=
Date:   Wed, 21 Jul 2021 14:38:30 +0000
Message-ID: <CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com> <YPWiRsNaearMNB2g@t490s>
 <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com> <YPW8xaejtl68AYCk@t490s>
In-Reply-To: <YPW8xaejtl68AYCk@t490s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ca97d1e-a1fc-404d-e5b3-08d94c5535e7
x-ms-traffictypediagnostic: CY4PR02MB3334:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR02MB3334E0E36EFB4CA4675139A7E9E39@CY4PR02MB3334.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RqUir3GzSu/cHkAYBEiphRgXkHqezZR7E8iCQn9XktQgpNeTP7a7TN9J1f8k5D0OOtA40jYMv/iEqCDobrK9M3lp7iIsVYvyR3nQGQcRDBhkiUBNPbnt1hGh+qZyNcEBRPebzB2HxpA+hscC3yKu8pXskhLN3hlpPjRoPZJda5lSrguWwuz9ogCOI4AeFF1qZVh3gKlxHi6vG9XQi4HUs/53i5pax5UEEUczIgCPFzW6nBQdGK0NfORNkLtQdXVTSx7EGLXlwRptS2ufPgMmRetxQ8WGtnl4l9YFSlvGNpGOqbyK/p8BUuUsx5RdN3qVoFww4zQroRIMgt/2wXY5zYo9SbQqZsEKUpliTdLuysWZ6F/AeQYo7imCIAtyXmI5qRw77/S8kg4L8PemvRLtvwS37WZitVfX2x2pAKJ6gqdKBx5DZbva7LKtYhOw9qeQmIsQ96jt5+baMQHTpQ3kAZOBoACOnqkI6pW35bgsvYtuQRmP5WSFaydLY6+RvC2ps9Kw8xDuotyaGLNRrT6LnrPgvdM3zX8DMo9dTbKub3BiWnyeHgzKPRFRljlWTybnG7jdBI/J9hdR+mMkprXwvjULUwIj4M/Hv9UgafhYR0r5KppHwGZJ0vezZpgUrj4JAMoyFVJRQi5BLr0OeWHStMyZC5xdJfN/UNDrvrDmXZsU+LguPSts7ml4HOPMJ3hDi+YdiAQcJA6f1iRJzO/4BQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0201MB3460.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(83380400001)(33656002)(71200400001)(76116006)(2906002)(44832011)(110136005)(5660300002)(26005)(9686003)(4326008)(55016002)(7416002)(8676002)(6636002)(54906003)(53546011)(86362001)(478600001)(66556008)(66476007)(8936002)(66946007)(186003)(122000001)(38100700002)(64756008)(316002)(52536014)(66446008)(6506007)(7696005)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUdGb3R1enlqbmswU0xtQTlXeEFtckphTFQ4SWNkT0MrWmFZWjJIaUlpaTJ4?=
 =?utf-8?B?SVpOVGlMdm1vWE5FS0ZRdytIUWZiQ2tVaWY5aG1adUFpUWdHQk9nTkhPaTNV?=
 =?utf-8?B?NDArS3RKdmN2bGlkb3NzMVZaNUprQS9pQkNJOVQxdFNDcjR3Q3QzYy9rampS?=
 =?utf-8?B?alI2TnRxK0FINFFFckhSbndhZlB0UDVtZGp0WFJtejJKejVwMG02VElxK2tO?=
 =?utf-8?B?Mmg4S2RXb240UlFzcWVHZVJzMVh1b2JkRUtIS2F6dDlLTXdrd001Q2pkOTBB?=
 =?utf-8?B?U0RyQXJsaEIwaWtpQ0k2cndQRXlQT3dSanpSNU4zc2Q5aWRLalV5M2x0Z0lQ?=
 =?utf-8?B?cXo3QWVCWXVOSmFYRXNXQnpoSDh2RWFTN1pzSitrdlhFaWZtYk9UdUZKT1Qw?=
 =?utf-8?B?K3FhNUN6NTNoRWdTQzRVMDZnRTJ6cDBPTEN0R2QxdnZxUHZUTDRnbWhEdlM1?=
 =?utf-8?B?dXBIYVNDKzdlYTF4TlNYRkRKemNNMjZCc05xWWJrbU11WnRaMDhnR1dmS2Yv?=
 =?utf-8?B?T1ZaQWVBdE1qMUhENXFFWVVyOTVrVko3czhIQ3ZYRk9IeXhPSmZWWlVYSzZR?=
 =?utf-8?B?ZVpWQU0rNHZacUkrYzIwUE9VTnB5eldvalNWUUFiME9lUkdaZE55K3dFYnUr?=
 =?utf-8?B?TVY2Q2MvbnpTOGR4Y1BranJQbTA5Wk9LK1FYRlhDUUNIY01RMTNDMkRUU3pL?=
 =?utf-8?B?Yy9Fc3N4Qk9FYkVqSXk3Mm5DRzY5QW53RzZEcFhWYXI3ZHNHdzFBdzIwemxm?=
 =?utf-8?B?SFUxdmtabStUYmJFUHlSN09jOW42RWt4aldWNWJvNFM0UWlyd0pjK1hQenVJ?=
 =?utf-8?B?NG9tKzhRVlFxMDdETjhJeFBiU1VieW1ENlNJZ2wxV3ZRQWovVUU4M3hYMXNa?=
 =?utf-8?B?MEdobmpGMVNaTXJUbVg3UmxoRzJNQlAwa29MaE8xRCtLZ0xXeXVabzVYOUZP?=
 =?utf-8?B?N2JWL1RjN2Y5aGE2THMvUytyWTVTUW96bTBFeDZwZFRqaDJ0REZYTFpKaWk3?=
 =?utf-8?B?Q0N5bHlyZVRkQm5DMjN1VXIrRmJMNWpEYllScEFXc3R2TWh4TWJ3QTRpNmJJ?=
 =?utf-8?B?a1M5ZjVRMHFCQWJmWkhnQzltazZKSWFQNXZMV2hib3pCR3ppbjJFbDRWYzRK?=
 =?utf-8?B?djhNYjNEcm1sbGdUVFlsdkcrWWk5UGxUL0FhcjQ0ajNnTUpnZWV2WmdJSU5V?=
 =?utf-8?B?eUhiZmJ0UTA5M3M3SkZpY1A1dGl3Z3BOL0lRREhBMFMrZ0FINlozdWlKSmhw?=
 =?utf-8?B?dGgyUWczMEwwV0Vjb0FURTZoTitHQldmUG8wYlVNUGRKUlpJT1BRRHg5Zmc2?=
 =?utf-8?B?b0JWb09vdWJRVElIazE3UGVxOUU5bytacG9raFBWQ0JFY0Jscm5uQmpjTUs3?=
 =?utf-8?B?Y1ZmTkNEVW1ERkNNY0oreFFDak54cmsrOEo4MGdSb1c0a2FpRkZTRWljYkp1?=
 =?utf-8?B?Yk9SazBuS0R6TTczMzRYc1RMcndhckZUWlNQZktnTkdvaW54VEtacDBZd2ls?=
 =?utf-8?B?ZUxJUHVneHdZMkdkQ09OeTNqeThDaXFwR1BqazBqamVBOCtPa1lHRS9YN3FF?=
 =?utf-8?B?aVRUM0t0QVB2d3djTFgyaWtjTjVEbmlJTHZmSXpSRE5BZ05QV2hJZmRpaVFp?=
 =?utf-8?B?M0lpL1ZTZ2hsQy8vU04zYXFtMWUvZVdGS0NjOHVIb25RR3g0MGhVRXhMU0xw?=
 =?utf-8?B?dGdDSWIxR3NFTVFKMEhwRFRzK2tlQ2dySHliay9TUHlORGx4cnFWOGdKL1Bq?=
 =?utf-8?Q?jY2jo8TrNqH72NkXvOX4tjpIoZKmgcd6xjMbffO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0201MB3460.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca97d1e-a1fc-404d-e5b3-08d94c5535e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 14:38:30.8427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7juXvbj/xnCiwnPZ03v+8K8UDGc4EJUC0e5OWMJ/+B0guQkYRo/r8kkPwof25xM9xt0YbRj7BNBC71Cu8N80EPi8Zv7+e6B7oyGc/E9zXZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3334
X-Proofpoint-ORIG-GUID: 6Sby9b_vS-T15DyDx0v1JtBhd03qsWWM
X-Proofpoint-GUID: 6Sby9b_vS-T15DyDx0v1JtBhd03qsWWM
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_09:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKdWwgMTksIDIwMjEgNTo1NiBQTSArMDAwMCwgUGV0ZXIgWHUgd3JvdGU6DQo+IEkn
bSBhbHNvIGN1cmlvdXMgd2hhdCB3b3VsZCBiZSB0aGUgcmVhbCB1c2UgdG8gaGF2ZSBhbiBhY2N1
cmF0ZSBQTV9TV0FQDQo+IGFjY291bnRpbmcuICBUbyBtZSBjdXJyZW50IGltcGxlbWVudGF0aW9u
IG1heSBub3QgcHJvdmlkZSBhY2N1cmF0ZSB2YWx1ZSBidXQNCj4gc2hvdWxkIGJlIGdvb2QgZW5v
dWdoIGZvciBtb3N0IGNhc2VzLiAgSG93ZXZlciBub3Qgc3VyZSB3aGV0aGVyIGl0J3MgYWxzbyB0
cnVlDQo+IGZvciB5b3VyIHVzZSBjYXNlLg0KDQpXZSB3YW50IHRoZSBQTV9TV0FQIGJpdCBpbXBs
ZW1lbnRlZCAoZm9yIHNoYXJlZCBtZW1vcnkgaW4gdGhlIHBhZ2VtYXANCmludGVyZmFjZSkgdG8g
ZW5oYW5jZSB0aGUgbGl2ZSBtaWdyYXRpb24gZm9yIHNvbWUgZnJhY3Rpb24gb2YgdGhlIGd1ZXN0
DQpWTXMgdGhhdCBoYXZlIHRoZWlyIHBhZ2VzIHN3YXBwZWQgb3V0IHRvIHRoZSBob3N0IHN3YXAu
IE9uY2UgdGhvc2UgcGFnZXMNCmFyZSBwYWdlZCBpbiBhbmQgdHJhbnNmZXJyZWQgb3ZlciBuZXR3
b3JrLCB3ZSB0aGVuIHdhbnQgdG8gcmVsZWFzZSB0aGVtDQp3aXRoIG1hZHZpc2UoTUFEVl9QQUdF
T1VUKSBhbmQgcHJlc2VydmUgdGhlIHdvcmtpbmcgc2V0IG9mIHRoZSBndWVzdCBWTXMNCnRvIHJl
ZHVjZSB0aGUgdGhyYXNoaW5nIG9mIHRoZSBob3N0IHN3YXAuDQoNCkF0IHRoaXMgcG9pbnQsIHdl
IGRvbid0IHJlYWxseSBuZWVkIHRoZSBQTV9VRkZEX1dQIG9yIFBNX1NPRlRfRElSVFkgYml0cw0K
aW4gdGhlIHBhZ2VtYXAgcmVwb3J0IGFuZCB3ZXJlIGNvbnNpZGVyaW5nIHRoZW0gb25seSBpZiB0
aGV5IHdlcmUgZWFzeSB0bw0KcmV0cmlldmUuIFRoZSBsYXR0ZXIgb25lIHNlZW1zIHRvIHJlcXVp
cmUgc29tZSBwbHVtYmluZyB0aHJvdWdoIHRoZSB2YXJpZXR5DQpvZiB1c2UgY2FzZXMgaW4gdGhl
IGtlcm5lbCwgc28gb3VyIGludGVudGlvbiBhdCB0aGUgbW9tZW50IGlzIHRvIGNhcHR1cmUgaXQN
CmluIHRoZSBwYWdlbWFwIGRvY3MgYXMgdGhlIGtub3duIGlzc3VlLCBwcmVzdW1hYmx5IHRvIGhh
bmRsZSBieSBDUklVIHVzZXJzLg0KDQooQ2MgUGF2ZWwgRW1lbHlhbm92IENSSVUgY2hpZWYgbWFp
bnRhaW5lcikNCg0KVGhhbmtzLA0KSXZhbg0K
