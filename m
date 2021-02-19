Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB92731FFA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 21:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhBSUCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 15:02:52 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59852 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBSUCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 15:02:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JJx4OG137599;
        Fri, 19 Feb 2021 20:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9EG9dsW7YDXOvpPwSpF0HHItE+7aQt/L8/7zOcNevHo=;
 b=ragRQmgBPBIlaaztXMubuCC8eqqBH7RZ/Ikw6ebhNZiwUoW+qu5w2MqTMirJmfPcWlGr
 CYeOmbzEZdu08iPFjh+NKTtgqWERrleG5Pv6mK+B/vLrCYDZx4Ley/koJXgldSsNhq6p
 QmIpXsLdhETK8MxK/VFpruiRr0AVg4YAEDlruM0x44//12CrlMjP+UWhO9hVMGEzYvzC
 d/MLc5profmOGVjV8wsE2duMeoagp3Ig/164Dz0hBMFjItxv7Wt+bp+YGBiyhUYnEEWm
 p4D/f7iReROLaUxY88fZfZVaqoAJK0Qerl48ae+Id2Aom0QC/zBRZtB4RgNf609dAdxB zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36p66rap5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 20:00:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11JK0N8S099928;
        Fri, 19 Feb 2021 20:00:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3020.oracle.com with ESMTP id 36prp3a17f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 20:00:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbrfzqt8X4I+mTqpIgnMw5G1Hh+YZvlvUPs30FMB4OXWA6Hv+afZyZiiKrE7+hvStcimTN0yfRCvJaCYS2zjXNGrnLsQqyrXEHXRWFKxjIalgdyTeeDODkeCfqy5mZew8W1drOd+RMdgqkw8EXv3cK15PA1hm+9tot+WTN2SAH99oghiL8grXjnIkk20RMF6r/PFAoFsYR5RKIZJrmf0Ug7i4w7PS12Mu2q5NFoU1HLkIg++DmJU13YlB6T1laRnWD+GvbtjZGwr6hvsA75lH1g5Qx+gqJyWZZLUf8z6UeQlV+ax/bc1WTKH7z+4z8DFqlRiXGtTBHRrN1ASDoGcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EG9dsW7YDXOvpPwSpF0HHItE+7aQt/L8/7zOcNevHo=;
 b=nHYynE2Pg1YgUsZyYE8VeOPgFlNfjIsJzUn+gs545cfBa/PVDheAxfvYQx8Lqs5kfEPadOp/73AO+DJY6Lu/PYZR4Jy9QQzl5cID1nJTo4yOeBoaoSb8mEJzBhK3p8lnC5HkrkwqlBVYZqTD/ZIXsJ7/+P9hYVn1m5VonVWHexsqemC8Bzr+jl/ljMho9v70lVkcyjKyKXqkqShdzbG+ZyVtUbhomBSmfTISxd64NHqvsKEOS3863h7BLfuZFgCWYsIDzFC3JI7eSW6ANpa8X7nvVgiXwgmGXw0Inj2M/1+FUP8/Y2hZjvAzJtS/UWYmbIlqKKC4u4Birhq/Ew2/KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EG9dsW7YDXOvpPwSpF0HHItE+7aQt/L8/7zOcNevHo=;
 b=YijDVCXC7ztsUL7Xd3fUeETPF6IvGFjKk1xyuk63CYAucypN6ku283MUbVcBbuPn6yDH6YBYI9JK/qZtpywqHQlm39TRXL1SCVfLgcAkMcfuVvXRzLBrMZULMvb059wvEra7jSEB7xzsKsOg/96a9Fl24H9FlTortXEJXGz4NxA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 20:00:40 +0000
Received: from DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::ad89:6caa:4481:b733]) by DM6PR10MB4201.namprd10.prod.outlook.com
 ([fe80::ad89:6caa:4481:b733%3]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 20:00:40 +0000
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
To:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de> <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
 <YC5yzNB9xT76fkod@dhcp22.suse.cz> <20210219090548.GA17266@linux>
 <YC+LWksScdiuPw7X@dhcp22.suse.cz> <20210219101427.GA19588@linux>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b72cf63d-b559-25fb-056a-b0403cf41911@oracle.com>
Date:   Fri, 19 Feb 2021 12:00:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210219101427.GA19588@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:303:b9::11) To DM6PR10MB4201.namprd10.prod.outlook.com
 (2603:10b6:5:216::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0216.namprd03.prod.outlook.com (2603:10b6:303:b9::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 20:00:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d291be2-de69-45bd-10ca-08d8d511084a
X-MS-TrafficTypeDiagnostic: DS7PR10MB5214:
X-Microsoft-Antispam-PRVS: <DS7PR10MB5214056339A2C085130E354DE2849@DS7PR10MB5214.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tiWatY73YjKZOSg6Bdg99iT+XQZPIX2t4z8HiMnId/EhlAolIXIt/bhsXQn5qKUStBwOTqYhCVak5D0pOCMIlJmaHn8S6uynW8xmtrfOc8cchBzINFl1TgdY2VAFRGY6lgi2njjuEsNl8ZZCiFii/IRUSaOnRy5iVQbLjgCX142nhMP6ffYCpKyYShcjfz84jMn36WExcR3W389/o49FPZ/0a+y+uVPziQ4gFbM++VKeoo72Aa6rvpnHfWYL0gUeh2Hslk8pN+erOF9t3ppYCNii6B+F7m8eDdX4hAmGfF2/CBdRmprZhaaSxTRrwY2nXmMgTmVT0iki8GF12X/8+JTOMWZmujgu7al0Wa3GtfHmJqFeK28ZuxZKRxWjgWmaiXMzPdKfxAPAeYmNpzaQ7IkUuIVXwdGfRVFh2wBjUlj1xEKsb7gD4I/hYEJNwEJ9b3VyFzrJ7dQoIjhnpepZpXsXl12i8+Nr8u7QbhYVrtNuFMVszEHIObe78SD/AXsYyO8G7sWJ1k+PqzWGD/zm8JvvIxgBVXDCenEaLbaXsSbBXVGvEM/pFoc6R+SXDQYplhUPD7AqbR9/LbS9Sw0dxYVJKm8J7cFxovVFEt5QJrQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4201.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(396003)(39860400002)(8676002)(110136005)(8936002)(66556008)(53546011)(2906002)(83380400001)(66476007)(6486002)(4326008)(16576012)(31696002)(54906003)(316002)(5660300002)(31686004)(44832011)(478600001)(16526019)(26005)(186003)(36756003)(956004)(66946007)(86362001)(2616005)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c0xDRXRJSkswYlZoY3ppbzB5U1htMFhiMkQzY3lCMG50QWlhM3F5UnFNaWFo?=
 =?utf-8?B?R1hTZUh0bStnRXhmUkJpK3gxVEYvb1RtellPM3lIcGdXMVF1RzRXdHJTVWRD?=
 =?utf-8?B?RCtmMFUvVVk3NFk0N3dSZmlPeWNUdUt4QkJsTXZ2blUzTHptWVY0SVBLLzg0?=
 =?utf-8?B?NWJFbFMyWGYySGRzZTgrZnVkTGtWclJYNmJwd3hUSXBoQVlMSE9CRnBwazA5?=
 =?utf-8?B?YnBwOFUreUZJNXhXZlJwb2VOK28xaVJtOHNJRHAyV0s2Yk1kZWFrZzk5ajA0?=
 =?utf-8?B?RVdxNTZnaVpCbURUZ1VLaEszSjFaSWp6dTI0djA5dWpudmlJU1FBWjlWalRO?=
 =?utf-8?B?UnBPU3lqNW1LbGRsTmxZV1lNNlNOUkZlREFFdGxNSWdGdndyRGp6bEFzR0I0?=
 =?utf-8?B?bVFwWEF2aEY5MHZ5cFRuV0dBd0JSZ21UcFgvQ0tramRLbzd1TEw5VzAzZkc4?=
 =?utf-8?B?alh5L1k5MTFsWFZZK003aVNNdEpPSGlNZkd3QTFEYk8zWjFhcXhwUkVKdmli?=
 =?utf-8?B?M3Zwekg1V2NCOHlVTmFrZloxODVNWnN4S3NzK0JnNnNMd1U5L1kxUWFOVGo0?=
 =?utf-8?B?T0pBSjRIRlJraFJNMXNKMkIxZEJtMWZnZkdkQXdzRWd3N0M5L3hSQ29kNEx1?=
 =?utf-8?B?RXVrM1h2ekVucWNDNnBKbUJ0aWw4L0tTNXpKZ1p1Mk9GZ1NxdmRnVERUN1l0?=
 =?utf-8?B?ZHlJUE1OYXdjdDRiK2lxbThud25zTVVrUHlFVS9IcEhWb1ZuVHRYYzgxNFBa?=
 =?utf-8?B?Mk5KVVduWWtOM1hxTU9XbHhkd3FlSTNRYnZZcEt5aTNUZVEwcmxRWlYzTWsx?=
 =?utf-8?B?YkwzVGluU0ZHOTRPRVdmaW42cnFJcHBHU2JGOUE2bytTTkJTVnBJMWpGL1lh?=
 =?utf-8?B?WEpVYTI5SXRpQlZKWTh6L0VNcXMzcHBvNzRwOHlZczI4Q1pmS3MxaXp4cGwr?=
 =?utf-8?B?OTZwdTVydzJmbHl3YkFzMy8wNTZhdmpWRHpEMHA3c2NabUNRVUJHdHFLR0xS?=
 =?utf-8?B?MUZLMjRqNnJLT2Z0V0o0UEgvR085bFdyLzVDUWhwKzZnZDFMUmZzQmRRLzlX?=
 =?utf-8?B?SElxaE1mUkM0VjM5WStySDJHVG9lbVUyMUVHTWdNMGNxMDhXRjdaakFKbXZY?=
 =?utf-8?B?azVIVGFxd0FxU0Q4cjJKVWYrVjZ2SVA1OHpYVkNQVWxRcytJcHBYeHpoYXlR?=
 =?utf-8?B?M3l3YldxalBtOHl1MlVXcjlYWVdVM1ZINHczZ3hPTUNEbVQ4VFI0SFdLN2VM?=
 =?utf-8?B?bzNWdjlxSC8xb2l0bnNGUitqM2h1d2c0K1FqdHc3MlYvMTRDT0I2cnZ3Q01j?=
 =?utf-8?B?MGorVHV4QTlYUy9wc0pDZnZCUjFkVVpEZ2YvZzdINXpWR3YzNCtPWXk5ZjFT?=
 =?utf-8?B?ckF5c3NsQlB0bmFUU1d4TXJDV2N4ZC9uelJNSy9sV2Rnd3ZhYWhnWW02YmNK?=
 =?utf-8?B?RXhoZG41OXkxTXM5S2FmSEVGakRjcmVUVjgzN2NhZGtQV0tNSXlEaHdFSHQ5?=
 =?utf-8?B?VkFTN05xSm53cVc2MkNwSDN6OUIyS01zb3oyRXdzYTQ5OEFsVWZEd3p0ekZ2?=
 =?utf-8?B?ZTZsbU0rUk5BRWk0WFk0M3JSNFptMHNING1oNjVRZVg4SEVMalQ4ZTFNRGpT?=
 =?utf-8?B?SjNOQjFpUmJabnJ6UlZxZFFpa1VSTU1kZEEwRzlOOEtFNGgySjhNT0lYODdV?=
 =?utf-8?B?UkpGSi9YWG5nQ3RhREV3VGNLK0NYU09HOWJYNXZwaTlTbHZhQ3dNM292S3RU?=
 =?utf-8?Q?Rvgnp0kPwIsX5Ix01/BZdFY8pevuc6XSVh+RYfB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d291be2-de69-45bd-10ca-08d8d511084a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4201.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 20:00:40.4650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CViBSoznvrN98df4npWrH49vbE78Cl3vteokXRhuyVg8rsTJ6lHTnKR5FV9ygJv0slOd43oKznlaLE8oRW8QbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190159
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9900 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102190159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/21 2:14 AM, Oscar Salvador wrote:
> On Fri, Feb 19, 2021 at 10:56:42AM +0100, Michal Hocko wrote:
>> OK, this should work but I am really wondering whether it wouldn't be
>> just simpler to replace the old page by a new one in the free list
>> directly. Or is there any reason we have to go through the generic
>> helpers path? I mean something like this
>>
>> 	new_page = alloc_fresh_huge_page();
>> 	if (!new_page)
>> 		goto fail;
>> 	spin_lock(hugetlb_lock);
>> 	if (!PageHuge(old_page)) {

Yes, something like this should work.  I'll let Oscar work out the details.
One thing to note is that you also need to check for old_page not on the
free list here.  It could have been allocated and in use.  In addition,
make sure to check the new flag HPageFreed to ensure page is on free list
before doing any type of update_and_free_page call.
-- 
Mike Kravetz

>> 		/* freed from under us, nothing to do */ 
>> 		__update_and_free_page(new_page);
>> 		goto unlock;
>> 	}
>> 	list_del(&old_page->lru);
>> 	__update_and_free_page(old_page);
>> 	__enqueue_huge_page(new_page);
>> unlock:
>> 	spin_unlock(hugetlb_lock);
>>
>> This will require to split update_and_free_page and enqueue_huge_page to
>> counters independent parts but that shouldn't be a big deal. But it will
>> also protect from any races. Not an act of beauty but seems less hackish
>> to me.
> 
> Yes, I think this would to the trick, and it is race-free.
> Let me play with it a bit and see what I can come up with.
> 
> Thanks for the valuable insight.
> 
