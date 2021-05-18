Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0964B387AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349898AbhEROS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:18:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54582 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243610AbhEROS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:18:56 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14IEEWQo028652;
        Tue, 18 May 2021 07:17:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=y6+ynWa4U2a2AjvlNOW1//6BS028nBfhuhrbA3O133A=;
 b=DAyS38X7Uj2oKjX2D3vqDJebHyIiBoPakjB8NNFsIrB7I7ElVe6BrKoRw20HEavxZ/DF
 fplLWbIIWbKnIYlwAn758gIsf+fCKqwTytJUD6wAo2forw1hbhtl+Xdcsbr0KNWkHHaG
 KOStm8zLagBLoNLNjHTDaf0pFTo9TCiPzvs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38m7bg25v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 18 May 2021 07:17:27 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 07:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaXc1ymijI8BHeP/5i1RI2qCYNk1Ioz+e1oe6cU/A3OUWNStTvjnw/meo08cq3XpkgCmwB0F1PutAIJ6KzNdKAD12Mw5fRjciD3GtTrZMQ9R1q33prh3Jf7Jqx4PFI5VTyG21T3bOtuJSWsr8ZKRAJHIbmGfSdqFbrwNd8iHsWJ7lo2WU2TfZKdpk+FYgwmzJTL7RZQpqCfhmzhHVp7yOwyvLVti/+nti1kUa98KC36FXfK/JqnTRL2I1DZeNLVduCStEUFxl12p2g8WXOhqlDEDvpDX9Oq9iCNs4CeGSk9Adg/zRM39qiSMtbrv+taQnCtlYyKquLf7QPbwx4yz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y6+ynWa4U2a2AjvlNOW1//6BS028nBfhuhrbA3O133A=;
 b=PyTMM0rp6bcKwHvQxPvOIUDoFJG8y/ewB/Z5hFIbE07BSKBy63uyqKVqDyj+eoPE+CMt6uT4ASqbbpGxu0mLT+QC06EDBXaPD7wYxgo2BAotsVtDgV9hQz0BSojstwLqr8K1UATUDJywZ8rzHSP60qalF9axwaCwp+xadJ1H/Pi7aZuhKhT6xNL2HvV8D0w6Cg9hPcONRt8qn5gicniJ3k97/7KTp8164bkzkUaSBRaKs+Iil3MweiY7T0mgd03jAuJEfpw/8crFbR7h2iwByNZU1vuPDBAt5Es6dar43NjePMzsTQm5zzGRZWPO+Z/NYBM5JxPZiXqokMN7zGc/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3349.namprd15.prod.outlook.com (2603:10b6:a03:110::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 14:17:04 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 14:17:03 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        "fam.zheng@bytedance.com" <fam.zheng@bytedance.com>,
        "Singh, Balbir" <bsingharora@gmail.com>,
        Yang Shi <shy828301@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH v3 00/12] Use obj_cgroup APIs to charge the LRU pages
Thread-Topic: [RFC PATCH v3 00/12] Use obj_cgroup APIs to charge the LRU pages
Thread-Index: AQHXNnwiKj3WsH/F6EebFtU+W1JqjarpbEGAgAAHuWk=
Date:   Tue, 18 May 2021 14:17:03 +0000
Message-ID: <34366052-8A39-4E8E-A076-8B64AB4D015D@fb.com>
References: <20210421070059.69361-1-songmuchun@bytedance.com>,<CAMZfGtUiKcM8WmP88J3K5edwLhJhsUkAUQo6rnkqx4BBOEY2SA@mail.gmail.com>
In-Reply-To: <CAMZfGtUiKcM8WmP88J3K5edwLhJhsUkAUQo6rnkqx4BBOEY2SA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [69.75.117.243]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74733caa-c1ed-4442-cdf4-08d91a079c4b
x-ms-traffictypediagnostic: BYAPR15MB3349:
x-microsoft-antispam-prvs: <BYAPR15MB33492BAC8DF5AE963BEABE63BE2C9@BYAPR15MB3349.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1js0YJcBIHGOUt8oP02NL1tOJdkXGW9i61WAylUcIXRCN8y61we5v52z4gRhj1H7YQcjnhqgdu2txd4lfkYsk5T1h/rtGAdA6RnirWjIuo4mh+YifM+Gp71r8bF4DX0GQFmXwx81wnKn3PdZ+e9TTA4IfPHLbyoZ1/3Usjajcd7LyZ4aISg7oMrVykeYJuySEu6IHRc+sNy7L1VLLceF6U1upGTqPnkw6zcmpHOV+2GOHoRoTefJQ1xA0NGMFTH3mCpWuGVxt5eu5/jknK8dPKJfyDpYxzYHeYS66efa6fvQFwFUj0gnxCyExSfevM9eJ7N6P3o4NQbZPceOdRUDLMQCIODhbuairPFVtGNI2WGRPsG5Mj0Kd7aHHY83t7DtndxWaoq5xwFynCNikO866wsRClUYn1MGutXiML3PQa7jv98pfzg21jQfbqnof0GSBjiNJq+vz8Z7lpJXmXCXVjB1fyQEv/TDHxbBFFehTpWlXWFMAD7weptF0X8cQhRji9XcEcvNOKebrMB+16IFA3HcOti1TYeti41NF6ThbqPhoN5gTYzy5ycJ9hpx1XN6+VTkkjpbViXH7b9Arjs85QOXgDAnwEOMoVLID60FFXYhEsU1qqnl8/ojHUX5dZGDJsYw0gxvQsuqeRXhTXGBocOObO1VU/yqG7uVk2x84Apg28vqYrNIIz2Nj429ocrSjwTi9yjxIorXZldIdDEHSry35WFtNS2FdPYOFIY7dgMKB9MVDzoVxWZMxEkDSGG+KCyNahjNICoPGIue8mcd5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(8676002)(6486002)(966005)(64756008)(66476007)(26005)(66946007)(5660300002)(76116006)(66446008)(4326008)(66556008)(478600001)(86362001)(33656002)(36756003)(316002)(71200400001)(54906003)(122000001)(7416002)(186003)(53546011)(2616005)(83380400001)(6512007)(6506007)(8936002)(6916009)(2906002)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a2ppVTRaM2JkRDNkUkhUVmJ6NUd1ME84c2RidjVYTllkeVJqWWNkTUlsZFM2?=
 =?utf-8?B?NDdZbFZlM0c3S0RvbHpzdEpxK1ZiNUVucnRoWW9aSk5SUE9Cc3hBNkdTQjd4?=
 =?utf-8?B?QTNhZFBKK3IrV0dnRkNZMlFYVTBzNGpWQnpoM2tlbWt5TEpINDR6LzI4aG9h?=
 =?utf-8?B?cFAyMm5YOE01WGRZeGpYVFhGVlRpYkI4Um16TVlYU1NiN09zNy9hZWZIWGl6?=
 =?utf-8?B?cU5sWWZ5aFFoajBwZVczOHphV0RXNDZJTnEzaGdlK1dseUxseUZlRU9wT282?=
 =?utf-8?B?ZHE5NnlxQTBtYnRPRCtYQWptL21XTTd3UXhyRkl3ZjBaZWZiYUcyOHhmVkFD?=
 =?utf-8?B?c2labTVaV09EZTdqbk13QjB0eEtaZ055Q1ZxQ000bzMrQ0xaZy9TU2tZY0RU?=
 =?utf-8?B?NkJwK0hZMG5CdzUzemk5SktSSG1CbFVva0hQV1NZV2pGd0Ruanl0R0thMitu?=
 =?utf-8?B?RXBickMweUcvS0dTb2ZYSFJ5eGROSlZZajEzS0xVUVZOdlRGdjU4a2tjNmxH?=
 =?utf-8?B?WXYyMHd0cVpLd0t2SjJ1eXg1RDBQVVpiam50UVlrM09FY3NJQmR4M0JuTmNm?=
 =?utf-8?B?Uyt5ZW9oUjgwUURIcTgxaWJvcUF6ZHhUNncrLzRMdkgyL3V2ZzVERmxHOVMy?=
 =?utf-8?B?UDdibkNZdTBiS2JGVmhiSThCRW85clUweVpMNHRudEtpZ1dvMm5aOW10MHN1?=
 =?utf-8?B?aVcxZWxZd21ybFZzYWNjazZvVWJDbGcrb1pHb1A0dXNINEZiSE52QzV5dUJ2?=
 =?utf-8?B?VnZ3cmthMHBwY0RnYThjUEtNblNrd29vemNaMlZhSDhpb0dMSlNZU0NyV2lk?=
 =?utf-8?B?SnVjeXd1SEU2U3JJQjd1YThQUjMzM0xGT1RBa1pETEJiSDg0dThVNWd0alBk?=
 =?utf-8?B?em85OUxtVkQwNHczMzd1eno0V0RFYUhoeTVheTlyM0FXYnlYRHYxYkhwRjFJ?=
 =?utf-8?B?TWFPUThUS2lYT3MzdHIvZlZPOHdMd0xVYjNJelFwWVhYSEdQVCtQU3VmZmls?=
 =?utf-8?B?STZkVFE4VlUwVjl3NlhTalg2TzZJL2RXL0ZsZ3ZaanJBVkRSVmpkOHgwSUZX?=
 =?utf-8?B?WXhYY3p5YzVPdzNHdW9OcGdQcks2WjJPdWl2b1pwOW1WUU5JWWU4aUNPcFZK?=
 =?utf-8?B?bjBZeUp1ak5aalVlUVdjNDJiZHd0ZFhPdGl3V2ovMkJsSC9sN3ZpdzJuMWo2?=
 =?utf-8?B?SlZJZlFxQXlYL240cVR6eUM1MkEweWJSN2dQZW1PN1VvL3o5R0RSYVg2dUFC?=
 =?utf-8?B?TnZIekVvUDhuTzB3SnJ4aTdBK0l1SlRSczFpcmxWUHp1VzBuTlRWN09iWmdQ?=
 =?utf-8?B?QjRQVkdoV1FlekZtTEZOUi9oWmJITVY4bytlQWpwblNUaldIWUpUUE9XUUlp?=
 =?utf-8?B?ZWFjL21CbWNocFdnTHVsa01yZVQxS2FJSE1ObGRnTTJGMlZ2MXEwcS93N0l6?=
 =?utf-8?B?UUxYS3NKdDZWYnFxWFZWMFBZKzVQcEJCTlk3YVRDV0hDM0VzN05vTW91RFFm?=
 =?utf-8?B?L3lVcnc1U3hUaGlnZWY2U3JGSysrby9XcnJ5S1RaMUJwNWxITDNiNDNNcHhj?=
 =?utf-8?B?dVZzcUJEcGo2dFY2SmhxV0cwaFdzZWFhM1VvY05rTUZjek5BaHlTYUFXaHBB?=
 =?utf-8?B?bER3bmprSTFMR09mZ0FMaXMycWFlQVkybVdpNEkwMEttRWwrelFGVXBmZ080?=
 =?utf-8?B?eE1zd2l1ZzNFVWdHVjRXb2dWWjQrNGJXVlFCd0RXemVkN09KYmkxN2tKN1pZ?=
 =?utf-8?Q?hEW9GqtE1KHT1QnB6945XpKFqxPod/PJNGedhZr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74733caa-c1ed-4442-cdf4-08d91a079c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2021 14:17:03.6863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVyPL0pjR3V7yihLUzUwHvNxMHk+ADjLtmkDOYQIeu4ZMhohOCpkm3EHLCFfxiJ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3349
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: PaXhnnyp11h7mhctiE9f5UPISNr7CEDl
X-Proofpoint-ORIG-GUID: PaXhnnyp11h7mhctiE9f5UPISNr7CEDl
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-18_07:2021-05-18,2021-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105180102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTXVjaHVuIQ0KDQpJdCBsb29rcyBsaWtlIHRoZSB3cml0ZWJhY2sgcHJvYmxlbSB3aWxsIGJl
IHNvbHZlZCBpbiBhIGRpZmZlcmVudCB3YXksIHdoaWNoIHdpbGwgbm90IHJlcXVpcmUgZ2VuZXJh
bGl6YXRpb24gb2YgdGhlIG9ial9jZ3JvdXAgYXBpIHRvIHRoZSBjZ3JvdXAgbGV2ZWwuIEl04oCZ
cyBub3QgZnVsbHkgY29uZmlybWVkIHlldCB0aG91Z2guIFdlIHN0aWxsIG1pZ2h0IHdhbm5hIGRv
IHRoaXMgZ2VuZXJhbGl6YXRpb24gbGluZ24tdGVybSwgYnV0IGFzIG5vdyBJIGhhdmUgbm8gb2Jq
ZWN0aW9ucyBmb3IgY29udGludWluZyB0aGUgd29yayBvbiB5b3VyIHBhdGNoc2V0LiBJ4oCZbSBv
biBwdG8gdGhpcyB3ZWVrLCBidXQgd2lsbCB0YWtlIGEgZGVlcGVyIGxvb2sgYXQgeW91ciBwYXRj
aGVzIGVhcmx5IG5leHQgd2Vlay4gU29ycnkgZm9yIHRoZSBkZWxheS4NCg0KVGhhbmtzIQ0KDQpT
ZW50IGZyb20gbXkgaVBob25lDQoNCj4gT24gTWF5IDE4LCAyMDIxLCBhdCAwNjo1MCwgTXVjaHVu
IFNvbmcgPHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79QaW5nLi4u
DQo+IA0KPiBIaSBKb2hhbm5lcyBhbmQgUm9tYW4sDQo+IA0KPiBBbnkgc3VnZ2VzdGlvbnMgb24g
dGhpcyBwYXRjaCBzZXQ/DQo+IA0KPiBUaGFua3MuDQo+IA0KPj4gT24gV2VkLCBBcHIgMjEsIDIw
MjEgYXQgMzowMSBQTSBNdWNodW4gU29uZyA8c29uZ211Y2h1bkBieXRlZGFuY2UuY29tPiB3cm90
ZToNCj4+IA0KPj4gVGhpcyBpcyB2MyBiYXNlZCBvbiB0aGUgdG9wIG9mIHRoZSBzZXJpZXNbMV0g
KG1lbWNvbnRyb2wgY29kZSBjbGVhbnVwIGFuZA0KPj4gc2ltcGxpZmljYXRpb24pLiBSb21hbiBp
cyB3b3JraW5nIG9uIHRoZSBnZW5lcmFsaXphdGlvbiBvZiBvYmpfY2dyb3VwIEFQSS4NCj4+IEJ1
dCBiZWZvcmUgdGhhdCwgaG9wZSBzb21lb25lIGNhbiByZXZpZXcgdGhpcyBwYXRjaGVzIGZvciBj
b3JyZWN0bmVzcy4NCj4+IA0KPj4gU2luY2UgdGhlIGZvbGxvd2luZyBwYXRjaHNldHMgYXBwbGll
ZC4gQWxsIHRoZSBrZXJuZWwgbWVtb3J5IGFyZSBjaGFyZ2VkDQo+PiB3aXRoIHRoZSBuZXcgQVBJ
cyBvZiBvYmpfY2dyb3VwLg0KPj4gDQo+PiAgICAgICAgW3YxNywwMC8xOV0gVGhlIG5ldyBjZ3Jv
dXAgc2xhYiBtZW1vcnkgY29udHJvbGxlclsyXQ0KPj4gICAgICAgIFt2NSwwLzddIFVzZSBvYmpf
Y2dyb3VwIEFQSXMgdG8gY2hhcmdlIGttZW0gcGFnZXNbM10NCj4+IA0KPj4gQnV0IHVzZXIgbWVt
b3J5IGFsbG9jYXRpb25zIChMUlUgcGFnZXMpIHBpbm5pbmcgbWVtY2dzIGZvciBhIGxvbmcgdGlt
ZSAtDQo+PiBpdCBleGlzdHMgYXQgYSBsYXJnZXIgc2NhbGUgYW5kIGlzIGNhdXNpbmcgcmVjdXJy
aW5nIHByb2JsZW1zIGluIHRoZSByZWFsDQo+PiB3b3JsZDogcGFnZSBjYWNoZSBkb2Vzbid0IGdl
dCByZWNsYWltZWQgZm9yIGEgbG9uZyB0aW1lLCBvciBpcyB1c2VkIGJ5IHRoZQ0KPj4gc2Vjb25k
LCB0aGlyZCwgZm91cnRoLCAuLi4gaW5zdGFuY2Ugb2YgdGhlIHNhbWUgam9iIHRoYXQgd2FzIHJl
c3RhcnRlZCBpbnRvDQo+PiBhIG5ldyBjZ3JvdXAgZXZlcnkgdGltZS4gVW5yZWNsYWltYWJsZSBk
eWluZyBjZ3JvdXBzIHBpbGUgdXAsIHdhc3RlIG1lbW9yeSwNCj4+IGFuZCBtYWtlIHBhZ2UgcmVj
bGFpbSB2ZXJ5IGluZWZmaWNpZW50Lg0KPj4gDQo+PiBXZSBjYW4gY29udmVydCBMUlUgcGFnZXMg
YW5kIG1vc3Qgb3RoZXIgcmF3IG1lbWNnIHBpbnMgdG8gdGhlIG9iamNnIGRpcmVjdGlvbg0KPj4g
dG8gZml4IHRoaXMgcHJvYmxlbSwgYW5kIHRoZW4gdGhlIExSVSBwYWdlcyB3aWxsIG5vdCBwaW4g
dGhlIG1lbWNncy4NCj4+IA0KPj4gVGhpcyBwYXRjaHNldCBhaW1zIHRvIG1ha2UgdGhlIExSVSBw
YWdlcyB0byBkcm9wIHRoZSByZWZlcmVuY2UgdG8gbWVtb3J5DQo+PiBjZ3JvdXAgYnkgdXNpbmcg
dGhlIEFQSXMgb2Ygb2JqX2Nncm91cC4gRmluYWxseSwgd2UgY2FuIHNlZSB0aGF0IHRoZSBudW1i
ZXINCj4+IG9mIHRoZSBkeWluZyBjZ3JvdXBzIHdpbGwgbm90IGluY3JlYXNlIGlmIHdlIHJ1biB0
aGUgZm9sbG93aW5nIHRlc3Qgc2NyaXB0Lg0KPj4gDQo+PiBgYGBiYXNoDQo+PiAjIS9iaW4vYmFz
aA0KPj4gDQo+PiBjYXQgL3Byb2MvY2dyb3VwcyB8IGdyZXAgbWVtb3J5DQo+PiANCj4+IGNkIC9z
eXMvZnMvY2dyb3VwL21lbW9yeQ0KPj4gDQo+PiBmb3IgaSBpbiByYW5nZXsxLi41MDB9DQo+PiBk
bw0KPj4gICAgICAgIG1rZGlyIHRlc3QNCj4+ICAgICAgICBlY2hvICQkID4gdGVzdC9jZ3JvdXAu
cHJvY3MNCj4+ICAgICAgICBzbGVlcCA2MCAmDQo+PiAgICAgICAgZWNobyAkJCA+IGNncm91cC5w
cm9jcw0KPj4gICAgICAgIGVjaG8gYGNhdCB0ZXN0L2Nncm91cC5wcm9jc2AgPiBjZ3JvdXAucHJv
Y3MNCj4+ICAgICAgICBybWRpciB0ZXN0DQo+PiBkb25lDQo+PiANCj4+IGNhdCAvcHJvYy9jZ3Jv
dXBzIHwgZ3JlcCBtZW1vcnkNCj4+IGBgYA0KPj4gDQo+PiBUaGFua3MuDQo+PiANCj4+IFsxXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIxMDQxNzA0MzUzOC45NzkzLTEtc29u
Z211Y2h1bkBieXRlZGFuY2UuY29tLw0KPj4gWzJdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LW1tLzIwMjAwNjIzMDE1ODQ2LjExNDE5NzUtMS1ndXJvQGZiLmNvbS8NCj4+IFszXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDIxMDMxOTE2MzgyMS4yMDcwNC0xLXNvbmdt
dWNodW5AYnl0ZWRhbmNlLmNvbS8NCj4+IA0KPj4gQ2hhbmdsb2dzIGluIFJGQyB2MzoNCj4+ICAx
LiBEcm9wIHRoZSBjb2RlIGNsZWFudXAgYW5kIHNpbXBsaWZpY2F0aW9uIHBhdGNoZXMuIEdhdGhl
ciB0aG9zZSBwYXRjaGVzDQo+PiAgICAgaW50byBhIHNlcGFyYXRlIHNlcmllc1sxXS4NCj4+ICAy
LiBSZXdvcmsgcGF0Y2ggIzEgc3VnZ2VzdGVkIGJ5IEpvaGFubmVzLg0KPj4gDQo+PiBDaGFuZ2xv
Z3MgaW4gUkZDIHYyOg0KPj4gIDEuIENvbGxlY3QgQWNrZWQtYnkgdGFncyBieSBKb2hhbm5lcy4g
VGhhbmtzLg0KPj4gIDIuIFJld29yayBscnV2ZWNfaG9sZHNfcGFnZV9scnVfbG9jaygpIHN1Z2dl
c3RlZCBieSBKb2hhbm5lcy4gVGhhbmtzLg0KPj4gIDMuIEZpeCBtb3ZlX3BhZ2VzX3RvX2xydSgp
Lg0KPj4gDQo+PiBNdWNodW4gU29uZyAoMTIpOg0KPj4gIG1tOiBtZW1jb250cm9sOiBtb3ZlIHRo
ZSBvYmpjZyBpbmZyYXN0cnVjdHVyZSBvdXQgb2YgQ09ORklHX01FTUNHX0tNRU0NCj4+ICBtbTog
bWVtY29udHJvbDogaW50cm9kdWNlIGNvbXBhY3RfbG9ja19wYWdlX2xydXZlY19pcnFzYXZlDQo+
PiAgbW06IG1lbWNvbnRyb2w6IG1ha2UgbHJ1dmVjIGxvY2sgc2FmZSB3aGVuIHRoZSBMUlUgcGFn
ZXMgcmVwYXJlbnRlZA0KPj4gIG1tOiB2bXNjYW46IHJld29yayBtb3ZlX3BhZ2VzX3RvX2xydSgp
DQo+PiAgbW06IHRocDogaW50cm9kdWNlIGxvY2svdW5sb2NrX3NwbGl0X3F1ZXVle19pcnFzYXZl
fSgpDQo+PiAgbW06IHRocDogbWFrZSBkZWZlcnJlZCBzcGxpdCBxdWV1ZSBsb2NrIHNhZmUgd2hl
biB0aGUgTFJVIHBhZ2VzDQo+PiAgICByZXBhcmVudGVkDQo+PiAgbW06IG1lbWNvbnRyb2w6IG1h
a2UgYWxsIHRoZSBjYWxsZXJzIG9mIHBhZ2VfbWVtY2coKSBzYWZlDQo+PiAgbW06IG1lbWNvbnRy
b2w6IGludHJvZHVjZSBtZW1jZ19yZXBhcmVudF9vcHMNCj4+ICBtbTogbWVtY29udHJvbDogdXNl
IG9ial9jZ3JvdXAgQVBJcyB0byBjaGFyZ2UgdGhlIExSVSBwYWdlcw0KPj4gIG1tOiBtZW1jb250
cm9sOiByZW5hbWUge3VufWxvY2tfcGFnZV9tZW1jZygpIHRvIHt1bn1sb2NrX3BhZ2Vfb2JqY2co
KQ0KPj4gIG1tOiBscnU6IGFkZCBWTV9CVUdfT05fUEFHRSB0byBscnUgbWFpbnRlbmFuY2UgZnVu
Y3Rpb24NCj4+ICBtbTogbHJ1OiB1c2UgbHJ1dmVjIGxvY2sgdG8gc2VyaWFsaXplIG1lbWNnIGNo
YW5nZXMNCj4+IA0KPj4gRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9jZ3JvdXAtdjEvbWVtb3J5
LnJzdCB8ICAgMiArLQ0KPj4gZnMvYnVmZmVyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAxMyArLQ0KPj4gZnMvZnMtd3JpdGViYWNrLmMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAyMyArLQ0KPj4gZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgNCArLQ0KPj4gaW5jbHVkZS9saW51eC9tZW1jb250cm9sLmggICAg
ICAgICAgICAgICAgICAgICB8IDE4MiArKysrLS0tLQ0KPj4gaW5jbHVkZS9saW51eC9tbV9pbmxp
bmUuaCAgICAgICAgICAgICAgICAgICAgICB8ICAgNiArDQo+PiBtbS9jb21wYWN0aW9uLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDM2ICstDQo+PiBtbS9maWxlbWFwLmMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+PiBtbS9odWdlX21lbW9y
eS5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMTcxICsrKysrKy0tDQo+PiBtbS9t
ZW1jb250cm9sLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgNTYyICsrKysrKysr
KysrKysrKysrKy0tLS0tLS0NCj4+IG1tL21pZ3JhdGUuYyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDQgKw0KPj4gbW0vcGFnZS13cml0ZWJhY2suYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAyNCArLQ0KPj4gbW0vcGFnZV9pby5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNSArLQ0KPj4gbW0vcm1hcC5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAxNCArLQ0KPj4gbW0vc3dhcC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICA0NiArLQ0KPj4gbW0vdm1zY2FuLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA1NiArKy0NCj4+IDE2IGZpbGVzIGNoYW5nZWQs
IDc5NSBpbnNlcnRpb25zKCspLCAzNTUgZGVsZXRpb25zKC0pDQo+PiANCj4+IC0tDQo+PiAyLjEx
LjANCj4+IA0K
