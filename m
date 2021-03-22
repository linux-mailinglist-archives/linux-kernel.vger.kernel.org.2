Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0FB3452FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 00:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCVX33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 19:29:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35450 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhCVX3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 19:29:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MNOrmn089337;
        Mon, 22 Mar 2021 23:28:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nzTUOOt79kpmaw8JaIWP4PzIv0IMJen+2+QeGb1aXZk=;
 b=j7qKlAImBzJ1nRIg3Nw8Stvy+oZLfESf8V2E01qkI5EmEQEcwtxWSTQxF8wC5W3mysee
 GEz1TZvpV2jdPekdqf+rYS+lQK8j8q/Hfha0kVc4Ft5/8z9ZmccAD3Dr5ZVhCCZnhK+w
 /zEndBJI/6nr+7hV9B/Df8EP+pjNZge5vz910pCVpvOWvlcnAE2MZOr3wt8Cqg+VSoHD
 rwpnx1jmDWA3G/zrcZCrrI9jYiVXSYqoADSurBi1z8A5UvHwcVde6daJNYfZ/pArgu1S
 hvbG0xGR0dtFAQFbmgtPddAZcoghqT3fXn9i9FfWVYIu/zIQ0M3X9NPRl2lfskT3vT49 Xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 37d8fr554s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 23:28:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12MNP5C2074356;
        Mon, 22 Mar 2021 23:28:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3030.oracle.com with ESMTP id 37dtmnt1m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Mar 2021 23:28:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqCdm5OdFLDThqZp225Iws2YGuEKIPzDBS9hYgO0OcJVW3lYn++dMgb/MsFfcQlTwCx3oV1CFyXyky2xhmNNmhEjlLiKAZPNOp2Rp4MIeGYWg3DmBzmMS9jRtxw+0q3T6BP3s86Dl65aMcnKdoHP0TK85ouS2zHMyefxDIQgoLa+bRWU18wtz1DIz86rC+4MWjbmjr78VcQStYuIKpu2XQTZd4AMCafCW4rNIzvdteahZEJ73KNj2Pf35UNGAaGHnYtbBiLwWPEEdI8SXNbyzm8qcFotvQe9OxsmtaJrV3TN3ZkMSr4rH6zbtOdSOZIvAKz8yDM4xwipQlFh0V5w6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzTUOOt79kpmaw8JaIWP4PzIv0IMJen+2+QeGb1aXZk=;
 b=ElwxelYniTHGby8fPzQGCIe+D5xn+Bt8J8vcsv6U8OFzNbgUwgO+hSK616NLltSsuWKIDQUhAJLpapdYie2e2oDdZgS8t+sh6M8FD3NjqOIa2mAo3nirRwb7bySXkcRlleGhISAhqtUKZEw6CX+mOAKkZmya+tLWF6TfF13usgHB0NSKuczz3GdoiMdChARnCIkcJRKAEotGrpc+5DUCYfFqzm2oRxuTFA4uxOz6Ci+NljGsOC2Cnhy0YdInspsiSglkM/tO8relRcVE0/AVgisuxe0OwyMJ73PfJaKRceEZGwO8hf0yMOv8ThYWDwJawPRd1qVF9VLyiuEbUSBFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzTUOOt79kpmaw8JaIWP4PzIv0IMJen+2+QeGb1aXZk=;
 b=JIwp2JjSIHdvjZzDhh78wEG2f9ccwz+yaa+Kka4qkvkN5YjRrSF/6F9xrVZ/GWetNYZD5xKkEI0tpex+e2ZpkIhlUPIeyQNKbEAWGyaPAh3xQZDMBuLA/GAksWsYY9GUi4+bIBmmJ3HKfRGBeH8oZzzbIGxdDYTC92Z9p5GBxys=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4355.namprd10.prod.outlook.com (2603:10b6:a03:20a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.27; Mon, 22 Mar
 2021 23:28:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 23:28:10 +0000
Subject: Re: [RFC PATCH 5/8] hugetlb: change free_pool_huge_page to
 remove_pool_huge_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Waiman Long <longman@redhat.com>, Peter Xu <peterx@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210319224209.150047-6-mike.kravetz@oracle.com>
 <YFiqJSGjMMG3diWp@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fd723ea8-da7c-bd59-8d8a-e506be1b3af5@oracle.com>
Date:   Mon, 22 Mar 2021 16:28:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YFiqJSGjMMG3diWp@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:303:6a::13) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0038.namprd04.prod.outlook.com (2603:10b6:303:6a::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Mon, 22 Mar 2021 23:28:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5193b9c-6e23-4036-630b-08d8ed8a27c4
X-MS-TrafficTypeDiagnostic: BY5PR10MB4355:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4355F0658F5921EA2953E9FEE2659@BY5PR10MB4355.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJrFwdvGZglVnSJKno3O/wCorL5iy4rXqW2UJVG4MVTMxf/nJ+pbMc9pn82Sd1cmTtmUJ6Y77vSQZg4H1eRgz0Gxjf+b+KhcW3zDBFLiSxbevLc+QVOawR6HpcIq+hWRQPa4R9Z0XVax6b8xD/rhk8F3Uq0p8+EDUauPuVf2IkT65Ksiyubt48qbOcSOw2ti0FjLdF9uoucB7OzQyBtm4KNSD94rGobSYmSj2Y1P/KbikB7Vf5ZIPjHtU53PtYd035gGefjBnUYMuSSONwUI96AeQvfBu4r0NoWqekYy+hIInfFiiwR/dD7NMqEKL3gTb16bdBPnulMOmTaP9w/9nbBllkchtmUdKbUljHHrDImygN+1GRRat9jEqR8o4dxYevNblUCQ9ckdg6BirZ2feb/2RW7fc6uEmC11KkTPMj1tD2Mv8vHKV9pV8lr1qjYVTaOq+0szw0OgcS2xpi/MbY0EaKqcsxVUZ3h+G5xQ8u3AGk2nje4RumWjfs0+uvfRId6VBKqsKA7pg/zmubDsGivyok9NZFFkuSrGmP63otP60+173uffV0Wuunqfp/kukV/6fhMs9/oiMfYK2TLAujquX4kqaHZPTWrF4gl1RKm6Li46jmRaBFe3lpewC/TOF8UPdJs6UYM0bFCrOkvgViNDZpdbu6KYFafUsLHd7F7xSCR155fiERrE9gvolS2jgSi1HfVsKOK7BaLtcNsYhAXpOaZs9wb5cv8JNrItOuc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(39860400002)(366004)(396003)(53546011)(31696002)(16576012)(316002)(83380400001)(2906002)(52116002)(8676002)(8936002)(66556008)(5660300002)(86362001)(54906003)(66946007)(66476007)(2616005)(38100700001)(478600001)(6916009)(36756003)(4326008)(7416002)(186003)(16526019)(31686004)(956004)(6486002)(44832011)(26005)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bFRlQmo4WDY1OGFIelVMNEMwTFc2c01VZ0lvamVGaHh4cWpxOVdmbkFqNC9s?=
 =?utf-8?B?bzlINTg5TVVybVIwUlR4K2pWMVliV2FrbFRLOHlXb3ZqbjFsZGxuVEpIWkxM?=
 =?utf-8?B?UGxKVENzZlZmV3BBODRxTjFiRjZXU3BCRkNzby8xNWtlUWVacjhlVjBZSWh2?=
 =?utf-8?B?dGhKTEpwS3ZmZVJBV2tnT3RsRWpPa1Z5bkRpUlY4aWdtMU5MSVNjMCtzdEUv?=
 =?utf-8?B?WllPTy9jOFdXMHZ0SGhDQ1BWNDZ6Y2ZPS3ZzanVleWoyenlmQzc0amdiWkxU?=
 =?utf-8?B?SzNzZjNrSUNDQVc2MS9oZG92THdNanpqMGxtRWhJNWpFeXN4Z2l3Z0R6d09O?=
 =?utf-8?B?RndkbVpVR1pwOHk3QWtNcXIvd3ZtRTduZmlTVHJ0QzlqR0FydDJIb0Y4YXdG?=
 =?utf-8?B?ajg1bTh2Q2RkVitESEpLdk9hek45U2VWQzdvTmk3TWdVdzgxbVYyUStwTlNL?=
 =?utf-8?B?SDB0VmpLREJGS0ZIbnExTG16QTh1ZDVUaWoxZUgvc3hLQjgzSkdpbkRWcW1r?=
 =?utf-8?B?YWowRkw0aFRxVUNiVzNSckRWaHFleDVTajllcDYwT0lvdWtNSE95aTU5ZEZl?=
 =?utf-8?B?SnBWejB4SUpuNnVVRkJEcWFwdWlkTFJhMVAzRVl5c01heFVLTDBXSGxyalRN?=
 =?utf-8?B?bXNoak1lRmtmRnVBYWpRNEFzMzVjMUM4emdvbkV2TmpOTElCNG5RNFl6NjZh?=
 =?utf-8?B?cGNRK2l3bEJya0pya1o0dzBia0d6c1FHdCtWQURNQWxOcUs2ZUxabEFacnB5?=
 =?utf-8?B?ZzBPTlh0N0EwQmVRdHVKKzc0bzZCZEhJa3VldDhKT2o0Z1ZqTVNLaGphK01W?=
 =?utf-8?B?RjhxZ0ZDN3dTMzI0TTVlRlluSjMrbFExbXIzMTE2TzNkMUdRckNvdjZEQkNq?=
 =?utf-8?B?V0ozYTIzdVFnMjlmL1dRR00yWnBYUTRzcm1CbXBLVjNFOGFMdWRZTGZnTjBN?=
 =?utf-8?B?ZlNvSjJrTEp4TG9MTmxRLzVtdlRhRGRKNFhMV3EyR2dmVjV5MGwxNXU5djho?=
 =?utf-8?B?U2NNY09EQUNGODVNcldnUXdGT0FzektoZFg1VUF0RUtXT2YrM0c1KzV1a2k3?=
 =?utf-8?B?K3RqYjNMclVMOWJDaURoSGxPVTE4MTFWODR5REptZXkwNDU2bXRoOEphMlIz?=
 =?utf-8?B?L0Uyb0dtVUZCV2dBWmdJSEdheVBXT3ByMjd6enVCcGsxWlZOckJKWTQ0MTRq?=
 =?utf-8?B?SHpQRkMvWG52TGViK0hRbkNHekhGeEVjTWxITDBGUGd5TGFLRVhtaW4rRDRw?=
 =?utf-8?B?cnB3cVpZQ0hWMVhGN1huMytZa04wS0l0clVnUmtJZU9SOXAzTFl5dVVFaUhv?=
 =?utf-8?B?aXVraVpGT2grRCtTZVR1am93MDJLdm9oeFpOdGJJUWZDeVdLaXlHeWhVQUtK?=
 =?utf-8?B?UytiWUNReVVURzVQaXNyMTB2cGdCWXB2SVpXK3J2V3pwRHcvOWFEM2pKaVZS?=
 =?utf-8?B?a2prdUVEWC9KTmdCeVFHQTk2YzZxU3FnaVZvUHZsY0tON2N6L1ptNDNtTjYw?=
 =?utf-8?B?Vkd4WGovY0JSWnhURjFJbnBVWUZIR3ZONUd3WDByRDY0OVJsSDZEa0JYT2dL?=
 =?utf-8?B?dm41dm9xWlZ5ZTVpOGVJTjQzc0tOTEw0TjdxU1NicDhYOFhnd0xVa0haSm9y?=
 =?utf-8?B?UEp5V1haYnRnWExuWGZmSUp1cFFzZjRjUTQyRG5Xemo3SXp5Y293ODU2L252?=
 =?utf-8?B?YkoySG54Q0F6eS9OWURjbUsxSitDTTMzVUcyekFjdDZQNk0rYVAwbUZzZGFK?=
 =?utf-8?Q?UIfyBI09k25yUa2KvCCWUdbs06qfx1m/EMH6oN5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5193b9c-6e23-4036-630b-08d8ed8a27c4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2021 23:28:10.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwqWIB2e5Fu765OV2+qIk2utaCRMDT8hjBbccvqatShkEE+qOLp07JNZsBZMw5YeZCtbqM78Pv7Ss+Gq+lhG0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4355
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220174
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9931 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103220174
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 7:31 AM, Michal Hocko wrote:
> On Fri 19-03-21 15:42:06, Mike Kravetz wrote:
> [...]
>> @@ -2090,9 +2084,15 @@ static void return_unused_surplus_pages(struct hstate *h,
>>  	while (nr_pages--) {
>>  		h->resv_huge_pages--;
>>  		unused_resv_pages--;
>> -		if (!free_pool_huge_page(h, &node_states[N_MEMORY], 1))
>> +		page = remove_pool_huge_page(h, &node_states[N_MEMORY], 1);
>> +		if (!page)
>>  			goto out;
>> -		cond_resched_lock(&hugetlb_lock);
>> +
>> +		/* Drop lock and free page to buddy as it could sleep */
>> +		spin_unlock(&hugetlb_lock);
>> +		update_and_free_page(h, page);
>> +		cond_resched();
>> +		spin_lock(&hugetlb_lock);
>>  	}
>>  
>>  out:
> 
> This is likely a matter of taste but the repeated pattern of unlock,
> update_and_free_page, cond_resched and lock seems rather clumsy.
> Would it be slightly better/nicer to remove_pool_huge_page into a
> list_head under a single lock invocation and then free up the whole lot
> after the lock is dropped?

Yes, we can certainly do that.
One downside I see is that the list can contain a bunch of pages not
accounted for in hugetlb and not free in buddy (or cma).  Ideally, we
would want to keep those in sync if possible.  Also, the commit that
added the cond_resched talked about freeing up 12 TB worth of huge pages
and it holding the lock for 150 seconds.  The new code is not holding
the lock while calling free to buddy, but I wonder how long it would
take to remove 12 TB worth of huge pages and add them to a separate list?

I do not know how realistic the 12 TB number is.  But, I certainly am
aware of pools that are a few TB in size.
-- 
Mike Kravetz
