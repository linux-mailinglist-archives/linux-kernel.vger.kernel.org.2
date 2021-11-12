Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EC444F00A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 00:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhKLXja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 18:39:30 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:65020 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhKLXj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 18:39:28 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACLnJ7j009527;
        Fri, 12 Nov 2021 23:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vJrMSjaQBxnMoVRy3l7Y4Qhr7b87pjsvUjVEHP9sWX4=;
 b=Xzs1ijt+Q3BCOrzYB+0r+5Svcs1slwC3LXcu+/u566KjnCpR5ZwcCCZaQecyB9Lc9R8s
 oevBXRsHmIWsSRD/8cDPtNA9I0oIhOfEWqHN6olJByjID1S8VrQSeOGFxBWbT+74l3mH
 8M1UPtFhloZ3Rl1Lq8G2NLQ8Ks4PugnFt02T0zF7wmZ/mFszrkmfo0j2is5WDwhfF+QD
 bwYAnglly/i+/K3OupuLjrRjUeSahahdPNbj8MKqkCu0usVJvhvF3aHZAJIWy17t0npU
 s4yRTGufHFmrQv5DCibLL8fcsFjBXtEnLkfEJrer85QM8+CwGg0nG3bJ1K6cYEUiJyLV pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c9t70b1sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 23:36:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ACNGo8C087067;
        Fri, 12 Nov 2021 23:36:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by userp3020.oracle.com with ESMTP id 3c63fybbtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Nov 2021 23:36:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/Z/yqI6QMosbya80NWaJPmG+jOtQZPVGIkuZuAA1T8TlSySg8ZpKAa2FWvhDMZhzH9UdchkUcFo/3FbYXy9OAH6x+VKJFIU/U0dJACeMe55yec6btDeszKfa59xACOFbRKGjvG6tfkCmHZxedwt1jWx4HoUFmi3KC2pLNLxcG7D9xewqq6W1Nv1jXa/7S8a+iqx7nsvfdLx0UmHUaqtffmqrraRdNN0CMykTFN1+zbjkUyfHzpZiV7X5aQsCGPNVb0Np9tbELLZhreRX5HYQmRXca6TTVl5Xx9DS9w3XZ7946rSApVpbGQRpCgu4BmScDfvRAh7qQ6/6JGy9/TDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJrMSjaQBxnMoVRy3l7Y4Qhr7b87pjsvUjVEHP9sWX4=;
 b=T44JyI0H/4+O03oU8UoL/y7k5BsHP7hQ0VdEjyz6sYI7yTZabrwvMFQSrkwO7EsH3B49N6bjwL6UG0/t5LrBEPpg0Jy0/ZWxBL4lBC40xKf1aykEsI/Ty+FcieNs36GvmtRFicDrTqhGxo7ErRvL2wWvd0wP8/gfcPm1KEWkcM/dERGrQzNKk3VV3n5pjClcBcSVdVonKjMPmOaCTjx3z8kXVI09DbqRjxdbeYr4xWL9pe8VJZyRAh3HQ2wkxl/PJf9RLik6nkMIVn24zgLFT0vhLpMNZ9GKzvZdxkI/4Q1M0stUpMqs011IzpE8+f/887QZTcXf+/2wTh0PcZwvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJrMSjaQBxnMoVRy3l7Y4Qhr7b87pjsvUjVEHP9sWX4=;
 b=d6aWdmA22251bAK6knFg15PrcB5FelgGcZfEJexC1yc1vJsXWFy3YfLOqchAb+tC8m1dDv3rnhL47Aj+J89ODmNLaLqBj+OI/kUU9rpDhLODGohocesvcsjz3J7UbyYdQSQJ57fkyl056xjzV6PB7UN5EFD42csc8fmoku2++V8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3446.namprd10.prod.outlook.com (2603:10b6:a03:86::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 12 Nov
 2021 23:36:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%8]) with mapi id 15.20.4690.026; Fri, 12 Nov 2021
 23:36:17 +0000
Subject: Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file
To:     Muchun Song <songmuchun@bytedance.com>,
        Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>,
        Yang Yao <ygyao@google.com>, Joanna Li <joannali@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20211111015037.4092956-1-almasrymina@google.com>
 <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cfa5a07d-1a2a-abee-ef8c-63c5480af23d@oracle.com>
Date:   Fri, 12 Nov 2021 15:36:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtWj5LU0ygDpH9B58R48kM8w3tnowQDD53VNMifSs5uvig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:303:b9::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 23:36:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8d043f3-72b8-43aa-9b90-08d9a635384c
X-MS-TrafficTypeDiagnostic: BYAPR10MB3446:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3446E66605479F29140B667FE2959@BYAPR10MB3446.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HT5PryI7mY48pFvrrjUIdFNVJczTOMtS1FXXPOMynX89JEc+TP8Xqzf5tcxpuW5XZLUf0uUBO0FThsAlYnbpWqdRliHoFVAVwO3mgBAElw47O7ieiey8hojyJkRcPQSkj0gxCn3Qb9gncbC+CIxRhi8UvuPF0X3CtZK5SlX642SuHiuv7Rok7L+KpD/gKUU4vCgFzNdxz6Xzg4+PWGvhV4NdeUnF6XOGK9QkZWYddrb/2a6lViKhOsyVYqy7z4EenOzEWi9EUrLgoQk1wojs8+VZtv9Wsxc/t/HsggsJODKO9u5AXhiVRQo2smbJf1fsAk5ABshd0VQZnfpAD23WECxQxo9MoIGzf0DvFilIgooWGtPZlh/Zudd/BBjGwFiv1dsBMQQ66kEqPlqv4tQj+6LP76cGL+lJ2TaUXJlI/82hf0QKiUFtV8Nkdfnqx58SWhzD4Ta+RUW9gY3FlP1hQFykMv91uOpaDPWdnlSMP9x65oaikDaw6XUuAcmJMVV8aAotqPJNdFObRJYD8PS2BMgMDxfdKIjUU+xT17JL1WXjW/1vRc5mOb6UiV/B3+w0QGe6it5TGbX+gW/eBw9np3u4BcfaTlVve0sc5Ltj0fokzi6vRvO5JOxyUWebRdVliMujTHsLH1suuFWsWSx+ONjIQwn1xtFlS6GjBtHgb6jVoPwXPMNf25Z+AjtkDrKWctGmf0AXwELA1F9iHWHj+6bZWAm2+I4W4xC7vfHvzlBskNwcBtzUIpobedkHCST9TNXNbMsQsIbgTtOXRCiNFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(2906002)(36756003)(186003)(83380400001)(16576012)(6486002)(53546011)(66476007)(38350700002)(54906003)(2616005)(86362001)(31696002)(52116002)(316002)(956004)(31686004)(4326008)(66946007)(110136005)(7416002)(8676002)(6666004)(44832011)(508600001)(66556008)(38100700002)(26005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2g5eGZmbytHa1JoaHIrRjNSdlY4SWdvcDIxVVUyWTIzTDF4b2JuSkF3VVd6?=
 =?utf-8?B?eDgzMktJaDBIZDJ6Wk1lWmFvYkNDQURDMFNhazZhWkM1eE1uZUk4di9PRjNP?=
 =?utf-8?B?UXZYU3BnSHhVWU56TUhVWFhvSVBVVWdUNU5pMXdRelZnSFU3K3NNaG1Ib3gr?=
 =?utf-8?B?UVFiTU1hYmloeHppMXV0bTRKaDY2K2J5aU9nd3RxNHFnaEhaSGVCM3Y2cE5E?=
 =?utf-8?B?Vlg0NW5LSldBdXQ1VE41cGhIY1IzTHNDUE5FSUJKMzB3OFpYZXcyL3hQK1ZS?=
 =?utf-8?B?S1JZc3YvVTRNbGVjMG5QTFJYQnRnZGo4U2xtbDBpMEZ6VGhqME1HT082RENm?=
 =?utf-8?B?Y1B2aWo2UkRkV0lzSHRnZ0lvU1d0N3dmRzBBKy9iNVZHUEVCL1Z4RkVqTEFT?=
 =?utf-8?B?R1BLRzlJQ285MXdRZFhkMllRNW1BZ3k3SFFUdWF6b0NJY1ZXR1dkU2pVQjJl?=
 =?utf-8?B?c3laY3FseUpNdkNYNkNDbEFjaEtQRm5RZ3cwRjRKVUVORHFHbmVrSlZjM2Uv?=
 =?utf-8?B?VkRkWDBEYU4rNm5RVFpDcFVtRCs3SXRZbmJ6MlZiVk1DcStJbHhGOU40eHMz?=
 =?utf-8?B?TWs0eHdqMlhsbkhFNHpnOUkzelQxZGIwS01WZGVmbGRXYzNDcGtwNHRCNVBH?=
 =?utf-8?B?Y0lMdHV3TmFYSE40V3I1NXZVNkQ4QkdkdStCbUNyLy92eW9IbDRtSlArVG5T?=
 =?utf-8?B?MG1KeTFBcDhubytKVUNNbjk1TWRQQXcrVDBPdm1DazZaZXV5SnBWQ25ob2ho?=
 =?utf-8?B?bGZnT2x4VHBiSC9UTWpubGlQbTBoV05BcWZ1ZHVBa2tyVVNydVZQdnB5L2Jv?=
 =?utf-8?B?RGhQYW5mdTR4bE9jV3ZvZ0NsL012a0l3M0x6aGdsRnlHNWpBbm50UkdLYVFi?=
 =?utf-8?B?dVdjN2hqaGo0eVd5aVZ5V2xNTW5GRVhJdVdaZFpFd3lGZElyU3BmWmR3dzcr?=
 =?utf-8?B?c3JCUUFMbnVMNHJzajh0MTliams2Vithcis2OXlIZDlWZ2lNRzlDWHY0dzlz?=
 =?utf-8?B?UUYybHlRTmJic2RvZUJGS0VqMnV2TldLSE1PN0dZdzZlV0k5cnA2SExsZkNS?=
 =?utf-8?B?UjVtZVdJcDY5aU1GWGJMTElUUHowT3c2MEhYR3BUUzVQelpxclYrdlFtTkM2?=
 =?utf-8?B?UVkyTnhZY05zOWRPazhveVM3V3MreWNPNjBaeDg5T1JBS1VheXVLTzdsUGQw?=
 =?utf-8?B?eENQRXlId2I0c0hNYkVucElob3VCR0hzY1F2RjNnSE5nWHM5dTliWGpzcXF4?=
 =?utf-8?B?UFNnTXRhNjJ2WEU0bXcxM285aS94azl2REYvL2NDQUlveDZYTkpmRys2cVBu?=
 =?utf-8?B?cFo4SXFSdlB5WXB4eFBDQlZEcktLZDdHQlNNSXd3VXMvOXhwenBzVGNVK05J?=
 =?utf-8?B?SnZ5eTB3UDZ3SlNuaXd1eVZQcldyMDQ3elM0c2VEbFZMa0xUOVg0QTZ1bnZQ?=
 =?utf-8?B?endoUlIyOTd6MnZxcFlKcDRWQStJKzJEODE1NlVnZEZQZzlMMytPOHF5WEdC?=
 =?utf-8?B?U2xPVEJST2dtVVg5NkdPcUV6Z1luYll4NVJJRWVNalpBalZxekkyQWdvV1Iy?=
 =?utf-8?B?ajRVQzN5YlFFVXNmQTZtZWVmbVpWckVqTDRJK084SHIrSXVNSGcrRmJzRHht?=
 =?utf-8?B?a3N5MjQ0MTdtZG9nRHV2dW9mbDN3L0dvMy9kZW13WEMvaFVMSEZPODloVldS?=
 =?utf-8?B?cVhlS2R1cE1aeVdjWmVyWXhrUHJ1Z0tLSGtaWkQ5S2RzcXRNUVgwcDd0MUFP?=
 =?utf-8?B?WExEeS9MNlhJNFZnODFFUHRjZ0VDaDVFaFZuU1RYVDgvMGhnYklwSEtaalhw?=
 =?utf-8?B?cExMQnlzQ1kybGp4bUk5WithN3VOdXp5UXNUV0pTYWNWSm4vM0NPTmRiVG9G?=
 =?utf-8?B?enNlc21leEFZNE5rRWszSEpvL09ZOWl4SHgvNzlkUlU1ZFgwTFVqT1lpdU4w?=
 =?utf-8?B?aGNNUzRtNmRPTU5scjdzNUJQTE1BS3hmVjhra0dPOUxsS2FTdE5ZYWtYTmtu?=
 =?utf-8?B?b2dRRzJPUW1CeWZsOTJqNFk5ODFhbURVU0o2Sm1ZR0VtdXhSdXZ1OVhNcnlY?=
 =?utf-8?B?bGJmZzg2TUFodEkxdE5xVkNzcUN6Y0U4WVRKNlNmVk83b1BHa21SMGRHempT?=
 =?utf-8?B?MmN3aldncTBnNmhFa0pRbUFhOGs3V2ROL1gwWDQ4aThkRXVadVUyK1ZQay9k?=
 =?utf-8?Q?cA1T1d2f0APssyHDNj0rx2Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d043f3-72b8-43aa-9b90-08d9a635384c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 23:36:16.9227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cC4w3HkLxoPJbexCimdw/v0mQyIPiWQZ/ux/kfTwz1Ok5mN3usWJy98lWlnEKMTk+yWttHgaYQPUOdB7SRGeAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3446
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10166 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111120118
X-Proofpoint-GUID: _02NUuKoSA2Gyeh09yrr4b6Gq-ayOG2i
X-Proofpoint-ORIG-GUID: _02NUuKoSA2Gyeh09yrr4b6Gq-ayOG2i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject:   Re: [PATCH v6] hugetlb: Add hugetlb.*.numa_stat file

To:        Muchun Song <songmuchun@bytedance.com>, Mina Almasry <almasrymina@google.com>

Cc:        Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, Shakeel Butt <shakeelb@google.com>, Jue Wang <juew@google.com>, Yang Yao <ygyao@google.com>, Joanna Li <joannali@google.com>, Cannon Matthews <cannonmatthews@google.com>, Linux Memory Management List <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>

Bcc:       

-=-=-=-=-=-=-=-=-=# Don't remove this line #=-=-=-=-=-=-=-=-=-

On 11/10/21 6:36 PM, Muchun Song wrote:

> On Thu, Nov 11, 2021 at 9:50 AM Mina Almasry <almasrymina@google.com> wrote:

>>

>> +struct hugetlb_cgroup_per_node {

>> +       /* hugetlb usage in pages over all hstates. */

>> +       atomic_long_t usage[HUGE_MAX_HSTATE];

> 

> Why do you use atomic? IIUC, 'usage' is always

> increased/decreased under hugetlb_lock except

> hugetlb_cgroup_read_numa_stat() which is always

> reading it. So I think WRITE_ONCE/READ_ONCE

> is enough.



Thanks for continuing to work this, I was traveling and unable to

comment.



Unless I am missing something, I do not see a reason for WRITE_ONCE/READ_ONCE

and would suggest going back to the way this code was in v5.

-- 

Mike Kravetz

