Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22663978CA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhFARLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 13:11:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36944 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbhFARLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 13:11:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151H9UGr066178;
        Tue, 1 Jun 2021 17:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rYwema79AkdruRntPWKR+OzrHBjOSBN074ocCjDQmgA=;
 b=sbQuYXfFzSIUaLrw7OK3SYI/pPCwdkk+RrXiO0HHQungIWUF9mVo3KndwUy9RAzlWCZ9
 Of8hCZWmrL1O5yGKsxzejRJR1VAqNiNgN3qKBj7kxAj8/B+VYCbpJG6A+KjVfy4hiAYr
 OuV7RUvLkDs3Gd4ailRhON5yU274yIdW4WWg29BvSqzgtQ7QQmh2V2ud1+UxoD3rGZGR
 QBmqe7EwZ50qQF1E0rmVHrARRLbs75Px8s/G/nLFbIsXs4GLUtOGz9HkqpTu6KiUrCwv
 p9lWuh6ZYxka2hMbWkeSPT6At7wXirT6XC/JDGIIZ6lYS0YEDgqctNXJFTXevJ09Afmv gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38udjmp7n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 17:09:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 151H5s25156853;
        Tue, 1 Jun 2021 17:09:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by userp3030.oracle.com with ESMTP id 38uaqwfxct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Jun 2021 17:09:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FyHF9lldporXzJwbePxhyNLNZ58DuMRe+g4mp/4gEZ0rYz6PJdTJSFYHLQDAvsvolAcFM/hWdL4YdRgPttstJNCDZiNSV4WKbhyIMaT0WaeLg2Vvi2ff+oLlo3B440k0Ichn+ju51vO/b3QTWzAboeF9IejtXMlP4lHBMfTUtCT5kt5YVLd9RcWXqzPZ9cnxYU/hxAJEBTbk77d8pcb7PKdejxejq0O+IaCbioVPpQHMk1sKF8WYql8rWvA+/aPEPhz873NUc2E6QZGx1ZNT66u8HZ6jrEqE1NTx6w4dxdiqGcYjhTTocIPUgxCn8BA3zD5RxxE7bl+kOyaL/4SpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYwema79AkdruRntPWKR+OzrHBjOSBN074ocCjDQmgA=;
 b=NVsKO8n2M0c9OVkwUI4yNg+pbENldGl3CplPa/t21x2VD7EOJFnkDy2obWwO0vf6oB4Kt/pRqhoiXBCi+HmwfwoUsEn6mgASRg8Be4GtTJeBm0JD8XMWGQ731WaaX+kmuFDmf0N0MIIcWAWfw4bD4uE7XKMriDuQ8PTXOEyEzwTpAy7Mza8WGNKCUYfLhM0676ig09jT6JlhBtjcTmMcHGzRRFxhQ+hk9wzISZNUChKTmPRstGeAL4Chm24Y4A0vWjNLh8L5j1YwbjNK4HVk8r1FmwzDTxZsWqDUziW09mX5V20pECNAKf7FEpUfXUtBA535VXDUfKsOg5NETBA6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYwema79AkdruRntPWKR+OzrHBjOSBN074ocCjDQmgA=;
 b=Ybtcn3xDL0jgIlJPhE18ocTskD5gO1caqu9nZsFgu1fv0LknrWr7N2F1og4ynFaVDagOZZDArSSCgUIyyCSsHMx3rVUwUM0PNPIj4QAcZ5xvKQyBhfKdA/bd88tQZ1O68z44n0KZrCY7RmbNSwM6i8WNOWSmuTqvwrAtCDDXKp0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 17:09:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:09:25 +0000
Subject: Re: [PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on
 UFFDIO_COPY
To:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210528005029.88088-1-almasrymina@google.com>
 <20210531162527.caeae9545ea2843c5f62bc9c@linux-foundation.org>
 <CAHS8izMCb4Ws46X3xXGcmrvV6J36qsAPTVCA_gdcH65FU0OeUg@mail.gmail.com>
 <20210531173652.c21404a16a8f8542ce40afa8@linux-foundation.org>
 <CAHS8izO_3QivHuGdmY79Jb_-LqOGc5j-_-1C-tf84hXoKdBDTQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <83617ae4-90a1-24d0-a79c-4e259a928e04@oracle.com>
Date:   Tue, 1 Jun 2021 10:09:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izO_3QivHuGdmY79Jb_-LqOGc5j-_-1C-tf84hXoKdBDTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR01CA0044.prod.exchangelabs.com (2603:10b6:300:101::30)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR01CA0044.prod.exchangelabs.com (2603:10b6:300:101::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Tue, 1 Jun 2021 17:09:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e8c2ba3-7350-4823-f409-08d9252001e8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2552A1E6EAB55F693B9E89FDE23E9@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7WnsOQP5u+hnfCx8HJtxER8nbcX0bk4Htk3DgCvhXWQ3BtYCJl19Udb2CjMFCq8QNgpPnDiLoAxhvm8V2iMeh+iy+ozY7e8nYsCbHhJQgs+vVSTykLZTIQYrDITWEIz1J/1E55FAuCi3dahxzQi6z0PHvfhEjWutQswdwdcx1/td5K1Cax8dv7yafpKx6AjiJS9+o8BEcQ1x9et/iCu+iUuxGvW8dxpBeWwys+eXrB+MHLYoKKmdB2E/HR0vuiHGtRdKzGJElXtPERFtGDFm8pQ0KlrSXMqD5xhNAawIlgwa5c/P85kd78WYxHeOvbJ7OPKmhOwCZZLBwb9HFLo0VrJkbV4bS6ncMLsqyl0Yg8ciBiis7u48x36ro/DIX7A+ggZWOgPSsH4Z7uc+XdkpsFPEGXEkQXiOebA80hT/b4z3N9HYlZcGBiNtTni4JQMUobj7V38Xi+El8d8rBFlcCpN9wne9aQQX1KmgSYoCyH0gP/YiGnpiHYF4ECar59qmqw9pawEnS8xdEgOrRyRZ+meIyNVsBOp3t32OoLwpl+X1HO2zLRzmT10fdk8zT7W79KZW6Irw2JfpvLZQrQR7eDXLGyK/C/Pv1VEdtif2JtbwZWxbASLzJaWkGtfGN2zT0xhgwbligX5SvXqIL7Xn/5M9MHdohWVYOErRkcH9GE4momKc1f+B+xnjAxKPNnobKsGcoBkd5JSORkufnuWNUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(39860400002)(366004)(376002)(83380400001)(86362001)(8936002)(478600001)(316002)(53546011)(6486002)(16576012)(956004)(2616005)(4326008)(36756003)(26005)(8676002)(38100700002)(44832011)(52116002)(5660300002)(2906002)(110136005)(16526019)(186003)(31686004)(31696002)(54906003)(38350700002)(66476007)(66556008)(66946007)(14583001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YXlBekJqT3MwanhlYjE0OHlZcFJvRkNaMXRZM1lCVVBubGlRb0xNeFRFeVJa?=
 =?utf-8?B?Z0lHOEJTMzdNcmtRK2ZuaXMxL0c4MUJ2MUtNN0VyRnE1enhsUHhqcDJRbTlp?=
 =?utf-8?B?YWgwaE5PdHJ6YmcvR3d3MXB4MUE2Zzh0aXlXb2kwamUrVUxWaVlhV0dFcS9n?=
 =?utf-8?B?dGlFYjVRS0c5b3oySGV6TWxJdCt0VXp3UVJ2TUloRjdCd2tBenpVZkRueVln?=
 =?utf-8?B?U0J2Z1o4ZU93bVJUZjBvVUwvNkd6SWs2TTZXZWRqVEhXalB4NE1ENGV0SzAv?=
 =?utf-8?B?U000b25NMkxYd1VvaWFKdm1VOG5sWm1BaXg0NktWWWk0U0Eyb2xYRWZMRVBO?=
 =?utf-8?B?SXdoYnFNd3B3cSt2RmxVUXVMUzhJMDF2YlZxZVZucmt3a1hvaU9YTUsrOHc0?=
 =?utf-8?B?ZmVLZkxLVWgrR1hmK3c0V0RaQVZiaFc3dHVZOTBuckVrV3RUUXhVY0ttNWta?=
 =?utf-8?B?c1E3TCtsNi9PL1ZxMHk4Q3FqZHlvcVp3RDRPaDJNdGNkVmc5eTlXdmQwZGFr?=
 =?utf-8?B?UnBTclhkZGpvQXByczVlWTc4Q29sLzNWNUI5QWVwT1grVnNxVlVOSXJBNXFl?=
 =?utf-8?B?aEFEREh1QzdFV3NCVnFRWU1UNkk3MHFNOVpubHptblNtRXd3VnkrK2lmYms4?=
 =?utf-8?B?YzdwcEFlUkdoRFVCK1B5Wml0bW5YZDdmQUNwcWJ4d3NQSURRdC90RVIvS2Nl?=
 =?utf-8?B?dlhBVnUzYzUzOWJQUUxic09IN2lYYmtFek9XbG15bUNNaTFDR0RMN3lLYkhV?=
 =?utf-8?B?WjJLWU1mSFAvUU11UDVPcjZTSFd0S1ZWSFRaRXdnWHFHejluRTZ3enhBcGpK?=
 =?utf-8?B?NXhCbEJPblkxdmlrMXc4VFhYL0ZnYXZCR2pGZ2xIc0VzV2tLN2t6OWt0UjEz?=
 =?utf-8?B?YnBkaVdpZllzd2YwQjVMZStZajhuS0xrangzcmplaG5kT2w4UGhTT05DMS9y?=
 =?utf-8?B?dU5hdDN1MDYvS1lGNktZR2FjY3EwbW1CYW9FclNpaEFYc3NHZkhNYjc2dUM4?=
 =?utf-8?B?OW13ZDlCMUhza24xOEQ2enMxekE4N0V2NjZBQlhqcDBFcTdzek5EZDFkS2xz?=
 =?utf-8?B?NlEvMXZ0a21nNEd2YXZ4b3laL0NUa3d2YXlzT2szSWpPNklHZVFqdmllSDNG?=
 =?utf-8?B?Ymt6REVueXh6Q2lOd3BsMS8rcUhJaThWM0hpckwzN0p2dWNvc3NocDAzNWpO?=
 =?utf-8?B?elcwUmpsSmhGb3N2dC9BUE1YQnNkNkFhM1g0d0g3U3pVOFRzVTFpQzB5UmpW?=
 =?utf-8?B?V2ZLMGVRZkIvdU9BWjg2Y292NG15MWcrbzlWaCtQM1JnMDRWOWplRnpjSThv?=
 =?utf-8?B?dXBvNEtMdzBzUk81Vi9Wa3VlK1Z2djJac1M3eW9HcXNuaGRZWFlRRjM2L0I2?=
 =?utf-8?B?OW9yamx2WG9Pd1VMUDhtOWlZRkxuanNMZnVDM094ZWxyQ3MvUVBCdU0xc0Ey?=
 =?utf-8?B?T3FkZjR6Ymk3WDBqS3c1RFQ5b0pGaDdJSG1uZUd4TjM3U3FDcjRiRGFML292?=
 =?utf-8?B?dGkyRDBydW9TWjRwb0NoWVF0WGlmNytsMjRzU1ozNVV3eXRxM09nN283d09n?=
 =?utf-8?B?OGNYazhGT254c3dieWoza0VjMkpFU25HMk5DMEtBUWNGMWRtKy8zL3Y1WE1r?=
 =?utf-8?B?bTlsdWMrbWprM0MwZzFmYUY5eHJxb1o0Zld1T2NJN3h0SnZrSEFqbURMSW4w?=
 =?utf-8?B?WWJtV1phdzJZTW1PQU1LSDh3cTJnOUcrSS9iM3k4eE83bi9QR2FhMHp1MW9Y?=
 =?utf-8?Q?vlwKf68HsMISF+Ujn67KLy5K3+CyorOTtH7sxzW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8c2ba3-7350-4823-f409-08d9252001e8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 17:09:25.2653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slE8KyzOAPsYvVH7pF+ebTEg0BqYl9hWQGYA40TbaWHE5IIVRdKMvzduGe6dgUjH5OysbiFKvhbjck5Yf2Vkog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10002 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010116
X-Proofpoint-GUID: I4bjfRm4vCkGnoPOEF_kjNUZjnov3u1_
X-Proofpoint-ORIG-GUID: I4bjfRm4vCkGnoPOEF_kjNUZjnov3u1_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10002 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/21 7:48 PM, Mina Almasry wrote:
> On Mon, May 31, 2021 at 5:36 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>> On Mon, 31 May 2021 17:11:52 -0700 Mina Almasry <almasrymina@google.com> wrote:
>>> On Mon, May 31, 2021 at 4:25 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>>> On Thu, 27 May 2021 17:50:29 -0700 Mina Almasry <almasrymina@google.com> wrote:
>>> I've sent 2 similar patches to the list:
>>>
>>> 1. "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages underflow on UFFDIO_COPY"
>>>
>>> This one is sent to -stable and linux-mm and is a fairly simple fix.
>>>
>>> 2. "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages underflow on UFFDIO_COPY"
>>
>> Ah, OK, the title of the first patch was changed, which threw me off.
>>
>> I'd skipped "[PATCH v4] mm, hugetlb: Fix simple resv_huge_pages
>> underflow on UFFDIO_COPY" because Mike's comments appeared to require a
>> v5.  I applied it and made Mike's changelog suggestions.  Queued for
>> 5.13 and -stable.
>>
>> And I queued "[PATCH v4] mm, hugetlb: fix racy resv_huge_pages
>> underflow on UFFDIO_COPY" for 5.14.
>>
>>
> 
> Awesome, thanks! And sorry for the confusion!
> 

Mina, does this patch depend on changes to restore_reserve_on_error()?

I am still working on those changes.  It may be a few days before I can
have something finalized.

If this does depend on restore_reserve_on_error as I suspect, perhaps we
should send these together.
-- 
Mike Kravetz
