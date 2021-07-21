Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEE3D176F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbhGUTOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:14:30 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:9748 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238151AbhGUTO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:14:28 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LJra81001721;
        Wed, 21 Jul 2021 12:54:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=EUjLI88FfpyyGdDUxLgxIlIG3rAxHeerrao8hXiWIxY=;
 b=GcRu28p0n83zt+i4grTQaaCG/JoMjCPqePEM+tiWAbZXi6f93oBh6yS8TP0QnkI+Kiq6
 acek2Z2N3xg+Ff/PqX4tdLtWDEgrSstaQLabLbbZkq5mCZvabVo3jzm0G9WIbstcXJBB
 4rFF8uj+mj+cKI80hcU2qbaiGrbdSQd9f655y03C9UvO3+ZLjzirpp3/Eb+V90iNi2Ol
 RC/Vjgyj+8McU6ke0mNP1WrmpU9YE3UDFRGGXP1eOXGlQKeM+bVh+zUiDc0RCpZche8I
 91nZ0TkVQ4TvFNrCJ9ZcS6KjDW8Gn+HocVIbV7oRz3mL5mU03E537WYwiuWhEUrNj70K fA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0b-002c1b01.pphosted.com with ESMTP id 39x887a7gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 12:54:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1itGy3q9rhO3MrfSpCePWAC3Ty26LKG1r0EjDNMqHYOEll2ANPTNgzZvd6YQLVDbSR0e92GK7ADoTk/jHif5gRQOPWlewvHyFh8jl6aTZd2rQZj83ENEhoZt4fx0Ys8TG7b9uFbm/7fjiL+EERWg7B/2EavWMzhFZiQQ9LI7t6xAWKxl0C0bMI4LDFNy3VyZETfS/mI9fmIkSlTpjg1axh6f/RwiOkbF0F8JBXK4/mDP4C4uLflqEeY2rvpLjV2WZ95Ta2CFt9AeTpGXKsvwSwsyzxTTW69dc1XyGSVBjwoeSjwMvY9N9nqgNwbR63dI9xn7UdjaUkvT+IpakvoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUjLI88FfpyyGdDUxLgxIlIG3rAxHeerrao8hXiWIxY=;
 b=EzdUmbMneO0jxLsHKFWohdyoNJwB3+Bz/sBLBIiaJiWQE8O2pi6Ry4ntoRCf1Jn6PUUOuwRL7KhUN4JPZW8yzu3gPbkYQNj0+owFCK3dbJhDTfeAKiVsXJOffTeVKBtp/J50SFL1j/Zw2kzIUHiqGLrcB48GQEtJOSuAZFG42AIll/qlYTUjTc6dm923jgiFG2Oqf7OsUJ4PNiihnLHuTjIY0EcKcTqt9WqxNtoAliJIAmmHT2qIAHp6s4dsD+nGoPwxbWrtTS2aKvOKRVXXWSacuUW3Jwc5A7ZiuY+sHeTuaZSg9Y5a15wP/qKSTuzJtyf3Wiy43cdb+4O59hLSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from CY4PR0201MB3460.namprd02.prod.outlook.com
 (2603:10b6:910:91::14) by CY4PR02MB2311.namprd02.prod.outlook.com
 (2603:10b6:903:10::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.29; Wed, 21 Jul
 2021 19:54:44 +0000
Received: from CY4PR0201MB3460.namprd02.prod.outlook.com
 ([fe80::31ca:e149:11b7:5f8b]) by CY4PR0201MB3460.namprd02.prod.outlook.com
 ([fe80::31ca:e149:11b7:5f8b%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 19:54:44 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
To:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
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
Thread-Index: AQHXebZmBTPHtO67e0+5F2gnOfKvWatKFHUAgABnSwCAABZVAIAACUGAgAKxz0CAAFfaAIAAO3Ww
Date:   Wed, 21 Jul 2021 19:54:44 +0000
Message-ID: <CY4PR0201MB3460AAED19F46CD184B2AB30E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
References: <20210715201422.211004-1-peterx@redhat.com>
 <20210715201651.212134-1-peterx@redhat.com>
 <A83FCF8F-193E-4584-9442-C95B2635FD03@nutanix.com> <YPWiRsNaearMNB2g@t490s>
 <D2FD5D85-BA6D-492E-801F-E5003452DA70@nutanix.com> <YPW8xaejtl68AYCk@t490s>
 <CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com>
 <5c3c84ee-02f6-a2af-13b8-5dcf70676641@redhat.com>
In-Reply-To: <5c3c84ee-02f6-a2af-13b8-5dcf70676641@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fe9667e-d1a6-4229-8c4a-08d94c8162eb
x-ms-traffictypediagnostic: CY4PR02MB2311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR02MB231173121C208D0BEFBEE213E9E39@CY4PR02MB2311.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T7EvFzvfhHYUAjI01ErTjzIT+X07lGcMCBVpCJeZxJafZJ70lmLMmM+CESDxdgyAzCCSJRQkRVapozHZrLu+ZGAQ5TQtajJuQIH08bXtA7BG6AacaQrlRqypi3W1OI0wl5VEVXyByrgTD3HwHdZY/AsTSfJofxZXm1EHMzJbvA304lF+6UfzCfuNXRd+OZySoiQ2XY2FhagFdstnGJZ2r9CQMd1kbeOFuo6WcAoqKxjpGRCul8Tm9BefNI9JV4bXZ8g5qr5dDHCnS6AhO1RQL07jgQgPNk5y48oS0WJgMlvNKqZWklUp3IUUNZ8Tushf6RspVZyTJ5Nfgd1Og37N0UYLzD4kurnQyfXbQjowuI431guGWXLgdThbeQGEaHs+CrIGCMdc2uUMcoN9sk6C47eJFtkRBxRQCJsWiva8sC7LUnQ212/kWvpr5DRpP9K0269mGms0k+MCf12+GtbxVPFXeKm5QjFOmRccJWMalx9DPo7+Tr2Y9IiD8rudkTM39aIAj8p/6fY+9VQFOtGvqUUL5MkDWQRGZv4q8MBeIribj2DVbYCV+NqJTXA7MQ9N1F+S+6T1HUREvq4cwQy6zcc7lEumdTHfPxNlf5FlYA0QAVZeW5qrDRRMMI1vQvbLmuX6HEfs+rzbvq3ZHbXUQSn68hBvEEBkKzwCtLCTFC/RxXp99Qv68Qka4X5MK/uNzfETCZu8VcJZ+zq2OMA/IaXjGh2TZ7p+7mtNUAVtQ5hh24pzKyJyGlT03vfd9lk4h5Nx1QeXLytGom4bme/uvTFxGfc78O6ZnSuKHKItOZM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0201MB3460.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(39860400002)(366004)(38100700002)(122000001)(53546011)(54906003)(86362001)(55016002)(7416002)(966005)(110136005)(316002)(6506007)(44832011)(9686003)(6636002)(64756008)(7696005)(478600001)(5660300002)(52536014)(186003)(2906002)(26005)(83380400001)(8936002)(8676002)(71200400001)(4326008)(33656002)(66446008)(76116006)(66946007)(66476007)(66556008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkc0M3IwbWE4L2hmcGIzNG1SSytUd2xVNkhEc0hHVWNPZ1BQa2E4WHFwS0pW?=
 =?utf-8?B?SklIK0tFR3NFWEdGTVF3eXYyQ001MmF2TGZyRFJHbjNtRXBJYzZRS1NUWktG?=
 =?utf-8?B?Z3B6T3I5UXNDLy9TNnB5aSt3enUyR2d5WDR0ekJxYzZNL3Y1b0lEZXh5WFgx?=
 =?utf-8?B?alhCZ2x2S28ybzJUN0g1Mm5OZTBQb2RWdU4vOG1CbVZZTEczeVpUaWd2WmVK?=
 =?utf-8?B?YVNaOW1sbTNDUEYxMlhITDBRanNWQTQ4MmFlM0E3UHYxaVZoSWd2VG5tYWhp?=
 =?utf-8?B?R2pzTkx2QjlXNi9BS3I1WWxPVHhMRzVtdDJWdWF4Qk41R1cwS2xVbnZDQWFP?=
 =?utf-8?B?MW81Q0hCa2NYOHYyd1VUY3VKOVFzM2xXdVlnc2dqYjRuNVlLRG1SaWpCd2M1?=
 =?utf-8?B?MExpSmlNOXJmZHZleUo0V0JUTlEvWFhlQUErQThXRkRvNklrbVFyUURkK2lV?=
 =?utf-8?B?ZEtvd25uSnN3eDBnUDRHdWdXMENGWmRmRklVY1dRV1AyRi9CNHA4blVXeE41?=
 =?utf-8?B?VDRYT2JXSkNBajZHUE5BZHNaS2ZWOXV1cGNMenpvaldQck16Z1NwMzlNSXhP?=
 =?utf-8?B?dllNZTVQRmlMaUg0M1gyd0sxeXNtQ29sRGRadWN1MUFaOVpZanVzVTJkeExo?=
 =?utf-8?B?SXl0NjNRQ3lPSEdWamEzUlpXK0dGbS9TbnIyTnR1L2dvWFdTZkxDdi9TdGtD?=
 =?utf-8?B?QTl4ZUZLQXFsOE5qbUNtaWtsejdFeWlqNzhSUy9yVWdqR2o1a2g2aVUrSUhi?=
 =?utf-8?B?VUx2bVhZWHB2aEdiVkYxM1FORFdLd2ozdXV4QzF2L0dheWdFeU9JY2RIK09t?=
 =?utf-8?B?TndiZDV1UlpSM1RQTE1kMitDNEZrNmk0cDRzMkZwQi9LKzhMcUJuM0lBZkJl?=
 =?utf-8?B?MkNaUjJKeXZHWEwxOTVFb05xcEsyRWFTdzVnT1E2eHdtMFp3MzJQMWFlSHpZ?=
 =?utf-8?B?YzB2OTRIYSthYU05UTFTaXBRSjAxZ3ZyNnhGYXlDSEd3QmNOZDZxZDBFV2lI?=
 =?utf-8?B?clh4eWo2Wkt6WUcxaG9MbDdEYUR5bGNBY1pYcmJtVjNaQ2UzZTN0aTE3cWdR?=
 =?utf-8?B?Mnd6OUs1NGNKeXZtQldaNFpLdXhRamRYSm9TYy9USkJMazd4WjNoSjd4cDMr?=
 =?utf-8?B?UExabFVUSXpqZzk2RFRtUis1RktGem5ETHhKcWQ1cURIYXBzUS8zQVBaOGhR?=
 =?utf-8?B?anVETExRUGd2cUhwMW85MjcwTGNJUjBOcmpXbXp3dVdwNjZhM0UxcGpxQzdK?=
 =?utf-8?B?ZHU1aFRObWtpQUMrTVJHU2ZBSTVDNjFuUUsydWYvbmlIT0hvaFJmRllxZlJm?=
 =?utf-8?B?KzBCRFFLVHNJMitNWG41MFJhZ1NxTXhhTWpyQnZWTHl3RU5veW81N0xzV3BG?=
 =?utf-8?B?bWlBc2dGZEJnYXRHdVdwM2crSUVXYnNMNmxuQmgxY0JLWWVjSmtlVnVNeWEr?=
 =?utf-8?B?WkI5N1VjVTZDbnpzbGViNXZrdk43WWliWTF5SkZ5aWhHRVI5a3dUNGZEVVgx?=
 =?utf-8?B?TFB6N0NZQ0c0TXk4SzE1dXhpRkgxUWRXdWJ6M0VsUVBKb0M5dkZremNRa3Vs?=
 =?utf-8?B?UVRtNjV5RFYwMjVzTldyYzE0UWlyYU8vQUR3ak5kUnZEcTdQNE92dDFQRGdQ?=
 =?utf-8?B?NktUVmVXUlRsQnNrNXVYUVhPZy9oUlZCMjkxd2VkcE5TR2J6NlgwalVQZTQ2?=
 =?utf-8?B?eGozdmVaUU9abEc1NzlrYVNTWnllem4vVzgzWC9tQXUweTQ1T2dOTXFpcFNU?=
 =?utf-8?Q?hun3ml2gp3lHbf218s51qHel65gCKpn8saYJ3Oo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0201MB3460.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe9667e-d1a6-4229-8c4a-08d94c8162eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2021 19:54:44.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SaI7KRBdoq76nCl3/9IfCe+gzOFXKuO8lArCIKA9DpDYlEf4ydxxgMmeacb/5AG5nQCBcENj709OPUlFKSiGOAPr8wkrFt5WWL//R51KjFk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2311
X-Proofpoint-GUID: 3qgmZGggtX52HqRuJM5SGC5ebl-OUFF6
X-Proofpoint-ORIG-GUID: 3qgmZGggtX52HqRuJM5SGC5ebl-OUFF6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_10:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMjEsIDIwMjEgNDoyMCBQTSArMDAwMCwgRGF2aWQgSGlsZGVuYnJhbmQgd3Jv
dGU6DQo+IE9uIDIxLjA3LjIxIDE2OjM4LCBJdmFuIFRldGVyZXZrb3Ygd3JvdGU6DQo+ID4gT24g
TW9uLCBKdWwgMTksIDIwMjEgNTo1NiBQTSArMDAwMCwgUGV0ZXIgWHUgd3JvdGU6DQo+ID4+IEkn
bSBhbHNvIGN1cmlvdXMgd2hhdCB3b3VsZCBiZSB0aGUgcmVhbCB1c2UgdG8gaGF2ZSBhbiBhY2N1
cmF0ZQ0KPiA+PiBQTV9TV0FQIGFjY291bnRpbmcuICBUbyBtZSBjdXJyZW50IGltcGxlbWVudGF0
aW9uIG1heSBub3QgcHJvdmlkZQ0KPiA+PiBhY2N1cmF0ZSB2YWx1ZSBidXQgc2hvdWxkIGJlIGdv
b2QgZW5vdWdoIGZvciBtb3N0IGNhc2VzLiAgSG93ZXZlciBub3QNCj4gPj4gc3VyZSB3aGV0aGVy
IGl0J3MgYWxzbyB0cnVlIGZvciB5b3VyIHVzZSBjYXNlLg0KPiA+DQo+ID4gV2Ugd2FudCB0aGUg
UE1fU1dBUCBiaXQgaW1wbGVtZW50ZWQgKGZvciBzaGFyZWQgbWVtb3J5IGluIHRoZSBwYWdlbWFw
DQo+ID4gaW50ZXJmYWNlKSB0byBlbmhhbmNlIHRoZSBsaXZlIG1pZ3JhdGlvbiBmb3Igc29tZSBm
cmFjdGlvbiBvZiB0aGUNCj4gPiBndWVzdCBWTXMgdGhhdCBoYXZlIHRoZWlyIHBhZ2VzIHN3YXBw
ZWQgb3V0IHRvIHRoZSBob3N0IHN3YXAuIE9uY2UNCj4gPiB0aG9zZSBwYWdlcyBhcmUgcGFnZWQg
aW4gYW5kIHRyYW5zZmVycmVkIG92ZXIgbmV0d29yaywgd2UgdGhlbiB3YW50IHRvDQo+ID4gcmVs
ZWFzZSB0aGVtIHdpdGggbWFkdmlzZShNQURWX1BBR0VPVVQpIGFuZCBwcmVzZXJ2ZSB0aGUgd29y
a2luZyBzZXQNCj4gPiBvZiB0aGUgZ3Vlc3QgVk1zIHRvIHJlZHVjZSB0aGUgdGhyYXNoaW5nIG9m
IHRoZSBob3N0IHN3YXAuDQo+IA0KPiBUaGVyZSBhcmUgMyBwb3NzaWJpbGl0aWVzIEkgdGhpbmsg
KHN3YXAgaXMganVzdCBhbm90aGVyIHZhcmlhbnQgb2YgdGhlIHBhZ2UgY2FjaGUpOg0KPiANCj4g
MSkgVGhlIHBhZ2UgaXMgbm90IGluIHRoZSBwYWdlIGNhY2hlLCBlLmcuLCBpdCByZXNpZGVzIG9u
IGRpc2sgb3IgaW4gYSBzd2FwIGZpbGUuDQo+IHB0ZV9ub25lKCkuDQo+IDIpIFRoZSBwYWdlIGlz
IGluIHRoZSBwYWdlIGNhY2hlIGFuZCBpcyBub3QgbWFwcGVkIGludG8gdGhlIHBhZ2UgdGFibGUu
DQo+IHB0ZV9ub25lKCkuDQo+IDMpIFRoZSBwYWdlIGlzIGluIHRoZSBwYWdlIGNhY2hlIGFuZCBt
YXBwZWQgaW50byB0aGUgcGFnZSB0YWJsZS4NCj4gIXB0ZV9ub25lKCkuDQo+IA0KPiBEbyBJIHVu
ZGVyc3RhbmQgY29ycmVjdGx5IHRoYXQgeW91IHdhbnQgdG8gaWRlbnRpZnkgMSkgYW5kIGluZGlj
YXRlIGl0IHZpYQ0KPiBQTV9TV0FQPw0KDQpZZXMsIGFuZCBJIGFsc28gd2FudCB0byBvdXRsaW5l
IHRoZSBjb250ZXh0IHNvIHdlJ3JlIG9uIHRoZSBzYW1lIHBhZ2UuDQoNClRoaXMgc2VyaWVzIGlu
dHJvZHVjZXMgdGhlIHN1cHBvcnQgZm9yIHVzZXJmYXVsdGZkLXdwIGZvciBzaGFyZWQgbWVtb3J5
DQpiZWNhdXNlIG9uY2UgYSBzaGFyZWQgcGFnZSBpcyBzd2FwcGVkLCBpdHMgUFRFIGlzIGNsZWFy
ZWQuIFVwb24gcmV0cmlldmFsDQpmcm9tIGEgc3dhcCBmaWxlLCB0aGVyZSdzIG5vIHdheSB0byAi
cmVjb3ZlciIgdGhlIF9QQUdFX1NXUF9VRkZEX1dQIGZsYWcNCmJlY2F1c2UgdW5saWtlIHByaXZh
dGUgbWVtb3J5IGl0J3Mgbm90IGtlcHQgaW4gUFRFIG9yIGVsc2V3aGVyZS4NCg0KV2UgY2FtZSBh
Y3Jvc3MgdGhlIHNhbWUgaXNzdWUgd2l0aCBQTV9TV0FQIGluIHRoZSBwYWdlbWFwIGludGVyZmFj
ZSwgYnV0DQpmb3J0dW5hdGVseSwgdGhlcmUncyB0aGUgcGxhY2UgdGhhdCB3ZSBjb3VsZCBxdWVy
eTogdGhlIGlfcGFnZXMgZmllbGQgb2YNCnRoZSBzdHJ1Y3QgYWRkcmVzc19zcGFjZSAoWEFycmF5
KS4gSW4gaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjEvNy8xNC81OTUNCndlIGRvIGl0IHNpbWls
YXJseSB0byB3aGF0IHNobWVtX2ZhdWx0KCkgZG9lcyB3aGVuIGl0IGhhbmRsZXMgI1BGLg0KDQpO
b3csIGluIHRoZSBjb250ZXh0IG9mIHRoaXMgc2VyaWVzLCB3ZSB3ZXJlIGV4cGxvcmluZyB3aGV0
aGVyIGl0IG1ha2VzDQphbnkgcHJhY3RpY2FsIHNlbnNlIHRvIGludHJvZHVjZSBtb3JlIGJyYW5k
IG5ldyBmbGFncyB0byB0aGUgc3BlY2lhbA0KUFRFIHRvIHBvcHVsYXRlIHRoZSBwYWdlbWFwIGZs
YWdzICJvbiB0aGUgc3BvdCIgZnJvbSB0aGUgZ2l2ZW4gUFRFLg0KDQpIb3dldmVyLCBJIGNhbid0
IHNlZSBob3cgKGFuZCB3aHkpIHRvIGFjaGlldmUgdGhhdCBzcGVjaWZpY2FsbHkgZm9yDQpQTV9T
V0FQIGV2ZW4gd2l0aCBhbiBleHRyYSBiaXQ6IHRoZSBYQXJyYXkgaXMgcHJlY2lzZWx5IHdoYXQg
d2UgbmVlZCBmb3INCnRoZSBsaXZlIG1pZ3JhdGlvbiB1c2UgY2FzZS4gQW5vdGhlciBmbGFnIFBN
X1NPRlRfRElSVFkgc3VmZmVycyB0aGUgc2FtZQ0KcHJvYmxlbSBhcyBVRkZEX1dQX1NXUF9QVEVf
U1BFQ0lBTCBiZWZvcmUgdGhpcyBwYXRjaCBzZXJpZXMsIGJ1dCB3ZSBkb24ndA0KbmVlZCBpdCBh
dCB0aGUgbW9tZW50Lg0KDQpIb3BlIHRoYXQgY2xhcmlmaWNhdGlvbiBtYWtlcyBzZW5zZT8NCg0K
VGhlIG9ubHkgb3V0c3RhbmRpbmcgbm90ZSBJIGhhdmUgaXMgYWJvdXQgdGhlIGNvbXBhdGliaWxp
dHkgb2Ygb3VyDQpwYXRjaGVzIGFyb3VuZCBwdGVfdG9fcGFnZW1hcF9lbnRyeSgpLiBJIHRoaW5r
IHRoZSByZXN1bHRpbmcgY29kZQ0Kc2hvdWxkIGxvb2sgbGlrZSB0aGlzOg0KDQoJc3RhdGljIHBh
Z2VtYXBfZW50cnlfdCBwdGVfdG9fcGFnZW1hcF9lbnRyeSguLi4pDQoJew0KCQlpZiAocHRlX3By
ZXNlbnQocHRlKSkgew0KCQkJLi4uDQoJCX0gZWxzZSBpZiAoaXNfc3dhcF9wdGUocHRlKSB8fCBz
aG1lbV9maWxlKHZtYS0+dm1fZmlsZSkpIHsNCgkJCS4uLg0KCQkJaWYgKHB0ZV9zd3BfdWZmZF93
cF9zcGVjaWFsKHB0ZSkpIHsNCgkJCQlmbGFncyB8PSBQTV9VRkZEX1dQOw0KCQkJfQ0KCQl9DQoJ
fQ0KDQpUaGUgaXNfc3dhcF9wdGUoKSBicmFuY2ggd2lsbCBiZSB0YWtlbiBmb3IgdGhlIHN3YXBw
ZWQgb3V0IHNoYXJlZCBwYWdlcywNCnRoYW5rcyB0byBzaG1lbV9maWxlKCksIHNvIHRoZSBwdGVf
c3dwX3VmZmRfd3Bfc3BlY2lhbCgpIGNhbiBiZSBjaGVja2VkDQppbnNpZGUuDQoNCkFsdGVybmF0
aXZlbHksIHdlIGNvdWxkIGp1c3QgcmVtb3ZlICJlbHNlIiBzdGF0ZW1lbnQ6DQoNCglzdGF0aWMg
cGFnZW1hcF9lbnRyeV90IHB0ZV90b19wYWdlbWFwX2VudHJ5KC4uLikNCgl7DQoJCWlmIChwdGVf
cHJlc2VudChwdGUpKSB7DQoJCQkuLi4NCgkJfSBlbHNlIGlmIChpc19zd2FwX3B0ZShwdGUpIHx8
IHNobWVtX2ZpbGUodm1hLT52bV9maWxlKSkgew0KCQkJLi4uDQoJCX0NCg0KCQlpZiAocHRlX3N3
cF91ZmZkX3dwX3NwZWNpYWwocHRlKSkgew0KCQkJZmxhZ3MgfD0gUE1fVUZGRF9XUDsNCgkJfQ0K
CX0NCg0KV2hhdCBkbyB5b3UgcmVja29uPw0KDQpUaGFua3MsDQpJdmFuDQo=
