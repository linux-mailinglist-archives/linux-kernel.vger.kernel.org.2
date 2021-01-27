Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34E7306818
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhA0Xj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:39:29 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37776 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232863AbhA0Xih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:38:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RNDvjU189754;
        Wed, 27 Jan 2021 23:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KSQ1x8xcetqL6ou6qhyBkBSeoqQVW37w5lb7heqnTfM=;
 b=zKq3k9RY300CaWZs7Xc8fA9D0uzeR3EBizdmOeIXc7X85GvFtG5zIFhDvfYiQZdwf0HE
 EFEGCQhZRS+mE/86TXrInV4GclT+QiyjtmQymIkemZ2GvZHyvvTU9bR5W53ZYr2WoTO5
 BgmiNDoSEb0g9H2iPwYwD2Bc3CJbe1/ohcoMIaId1THYI3nU+sIO31WCem0k7Fwk40Q6
 9JMKbMzJCOqqFLi+rHuCL/0RhmQIyuFSEy2ZNfuv/ZEGsYmX0Ittks71ajka0mLlkSFI
 PnT/zW8drjR2GWuhiF4/R6RpskpQo8L3Z7pqyjENCd/ymJjrUg4bBQvqWu6qvk1Jv63r jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 368b7r1q6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 23:37:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RNEba2177196;
        Wed, 27 Jan 2021 23:37:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 368wq0vgwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 23:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MI0gsDxZ8QGr6rv6dOwaKuUb+wBvxXpjcT8sBSXL5Al+odJ8YJKKh4uYwps6/lt6nW6FORkbWx/yOmUmDkf/tA5AgzpUAJfO+G/7UCPMk0XzxC2nZ7xZ6hXRVORztBvCxHnTdUJwUmRjBOhLNfFLsQAP7atcbf6FJbsl+DjKr3xZkizrr7usYtY1U5Kbx7h8TZz9Gb0z3zJJK8dQe0bWV8J2NwhQqYFfp5amw8dgg3HQZCqYfF0fWUSURvgcZ+UgNMCqSTf8n9VvxyrXEmQRnEUQagiXgBLzHOJRmLyunynsHq/KD1aJ8p/phyti/UHBD1Q4EjYani+HEfzPkKtA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSQ1x8xcetqL6ou6qhyBkBSeoqQVW37w5lb7heqnTfM=;
 b=KPB2xuiZvSZe4Y+9KYjWgNtYZ5t1lpXtwFREiEsUwlCahlZlom3KjkaImjLP0ZhPnBug6B0xHmpens+6JNhlu/vMZAUee7wGRktifg2VheUDxvAunjhc+NHlcYkuOc9kA+QeX9rxDGO799mYiFjVX/Z4mUgcfkYEwCr7Rd4Y+lsmkVBa1S80H2eEeEIlTeNfc2VxT2duvdxpxzvtD6I2vsn+6kty8ZkdZn4Yl1NAmhR5F+vvpbGV2Ya3Rkt7EvxYhofgjZzCWrr21Uorx5aUr5RnrTe7OFI2s6AJ0NLZNffTOBxYMdlYKqEKM+du4L9JbxyxWmFC7wKF+8HZLlZKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSQ1x8xcetqL6ou6qhyBkBSeoqQVW37w5lb7heqnTfM=;
 b=P/RU3fTA/k7mmtfKNA+Y634j2wsKlYlHXsrZNmx1VorbgeEwm0vNLa/mNtZLosiQ+y8HHSWpNvHUzoeiU9WFjX/yJM2D/4cWAPNfiodt+RtH8b5AvuTj+s4K6NJbPObgGASidBbAiU+iD1baWbI8Kna3Pw6UTg4C+pPv5G16xgQ=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 23:37:32 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 23:37:32 +0000
Subject: Re: [PATCH v3 5/5] hugetlb: convert PageHugeFreed to HPageFreed flag
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210122195231.324857-1-mike.kravetz@oracle.com>
 <20210122195231.324857-6-mike.kravetz@oracle.com>
 <20210127104106.GK827@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <eb78acba-651e-774e-2c3f-ff1d39b8f638@oracle.com>
Date:   Wed, 27 Jan 2021 15:37:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210127104106.GK827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:303:b7::20) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:303:b7::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Wed, 27 Jan 2021 23:37:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e502898f-716a-4b3c-c4f9-08d8c31c8453
X-MS-TrafficTypeDiagnostic: CO1PR10MB4609:
X-Microsoft-Antispam-PRVS: <CO1PR10MB46098717109BF382C802A249E2BB9@CO1PR10MB4609.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxCcjQKbrrRU2zi0e53pPfT0Fe6ACN10ZX9stoxBlttCc6KkZ1FxLIFm7h0b6dmghAGLCzGgrDkRx45R9uKKBNbVBeeUAXrw7P4r0ipgt6wxxEq9cxtE6BhpKBFir5jteGWg18emiGJBVI6kVzScd+AKKcajniI4jysOA1BsbQIgF/XiSiF7vVkAqb22T82Ln2C/nWPSao4MmDOOMh3esea0V/ckBE1i5hsTo9QIeR2q7Hsbi7GRA95hApmQ0C2nItOKm0gxcCVDAg2qizhadNJ7xf/UJDBqn7/2HQ5kki3Ch1ACzKxM+5opg4jSI9xI0NlHVyuqgxon8nlobgOYofXtbZXuTRj8LDxGE94A2TbX9/LaWdfOqF9jwe6IjcsWBbabeAH9o04ppuhorUvQjmDDX3C/18ACx7NcrmeGgddy1S1PRGLpn2uKUwuunW4njlFXgN+DqinLujime6+9+Ysp3kMUtqcF3s/xbVFFiXp//T/KRIoJoyMoYKgtkxn6lLbzaIOSdvrUTpbcpBhmc0HYM4hwgpV4bt5RH5xhTn9ZWuPmObM/e5XGpOeis6ulOzvV+BDauK7bnvXZImyrZstcSABTAR2pE7VVMUOPBrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(366004)(346002)(39860400002)(4744005)(7416002)(4326008)(186003)(6916009)(2616005)(8676002)(44832011)(478600001)(16576012)(31686004)(956004)(16526019)(31696002)(6486002)(83380400001)(26005)(316002)(53546011)(86362001)(54906003)(52116002)(5660300002)(66556008)(66476007)(8936002)(36756003)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cGhXTEM2ZzU0aFc1SkorRjdEU1Yxd2dXZGl6cCt0MGlLMGh3emh2R05RK3ND?=
 =?utf-8?B?TkZKY0xBREFoaFo0MUVzK0tLblJ5Qm1BVUFXZy9uSkRJL2lDd016RWF2aDBE?=
 =?utf-8?B?UEF0UFZWc0RIcUJsWDhZakU0S0RtYlRFY0VMVWwrc2NJdS9kNlhVc090QzB5?=
 =?utf-8?B?cmUwV0c4ellYalFuSVB5T0d1bGhSWHByOGxPb3pJZ1kwV2gwZGdVN0w3bjRP?=
 =?utf-8?B?aEluNmkwbGd4VHg5cVpBSStheXlCNGt6ekxrUVMvM2xVR3NSZHhXRDcrNVkx?=
 =?utf-8?B?WFR1RnYwRXVXalArTHpxdGV2VlMvcjR5M1NEZ2MrOU1qTXU0dlM1V1ZmZFV1?=
 =?utf-8?B?SWdyNjZod2N0dEpRQWowcTNITkxiR1dkRmcrbGZoU1B1WkdhYVhJcEJ2ZXRH?=
 =?utf-8?B?cDBtQmRNd3FVK0ZGUUxGZk80SEtuaHlYSmZveGl4WlZUSmxwOVZnYzJTcURP?=
 =?utf-8?B?RkdjWFhYNHZ6ejF6bDBMb2o0N21KOVdwN2QxU3JiU01jMXl4MElnVTZ4Q2lx?=
 =?utf-8?B?VUx3TnptMU5aeHNtbzlaUVp0ampDbVNKSU1Yb25veGVUQWNDOTNsTVFlbTRi?=
 =?utf-8?B?TFUxcU5Qc0dVV3l0a3NiTUl4dWN2c2Mxcm90QjhrQllOMjQxKzRtMmhVSnNq?=
 =?utf-8?B?T1I1RG4wUzFCY1RJRWFRZWZCSGRqSXpHU2R5ZDhCN0Z5cTh4amg0WWFaMElC?=
 =?utf-8?B?SldhNzlrRXlySnJ0Y2VwM1plUm9XclRUYm1YVGpjM3FtZlFYSUlWeVE4OHQ5?=
 =?utf-8?B?Mmo1Yng5Q3BFRGtGU0pPbjArSytVN2xya3FROFM1VE5WZ2lscUwzWFRBaDBN?=
 =?utf-8?B?dFkwWnNlZXZmNHBuS1R4bHY0TkhJYnd0RDV3blViSG9tcVRjbEo3VzJ2NWlv?=
 =?utf-8?B?Ri93SlUwVTdnNExYdDViaC9VU2Y2K21IQis4K3hjZXBvR1RoUFdtOTNsMmR0?=
 =?utf-8?B?MElUWWxXanNITWNrNElEenR4Z0ZNaHlnb3pBd3VYSkNPZ2ROVVI3cVlTZjVm?=
 =?utf-8?B?cFQzZWRJaEdYRnVYQjVCQnhwUVU2NmpSeVJpeitnRTZ6Zkd5dHo3NzUyeVQy?=
 =?utf-8?B?UkVWVSs4SlJ5cURGcXZGZFFUVU1wcnIwTUpvdzJhQXFGZEhJRjRFTmtLbWFC?=
 =?utf-8?B?RHNHbUNwL3pNaUlCbnRsMXhvdW5WWG5pVlRjU1d3VjlhRmZHVjNpWS84WEIz?=
 =?utf-8?B?bFdmZnIza1FERWoyMmgvQWk2bURrc1pXMEVaS1JtZjh4ZEx6L1NmNGFNMFRI?=
 =?utf-8?B?ZUJUb1F2RFBCMVFQKzhEYlQrVGtCWVh4cTZKMGJWM2ZKZjQ3d1RUR1M5YlZw?=
 =?utf-8?B?WTZMd1JBd2dZRFpkK3ZZL0RjdTFvaFdsaHZrNUpGSDcyak1tczBOREJ2NUk3?=
 =?utf-8?B?MSt0aDRReFFnTExPU3Iya1FIcTlhbE9ZeVVlaC9xZnN4ODJBTW94TlJvbWVn?=
 =?utf-8?Q?XX7Zoymm?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e502898f-716a-4b3c-c4f9-08d8c31c8453
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 23:37:32.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNDWPjmYl0AF7nR7Ix4NUU42CxHU65A0ZTYjE/V+NA3UEarKak80CBaamFuFQw9PFTbzBx9OJ259C+B8ygQf7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=965 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9877 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 2:41 AM, Michal Hocko wrote:
> On Fri 22-01-21 11:52:31, Mike Kravetz wrote:
>> Use new hugetlb specific HPageFreed flag to replace the
>> PageHugeFreed interfaces.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Again I would love to see locking that is required to gain a stable
> value.

Will do

-- 
Mike Kravetz
