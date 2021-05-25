Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C0138F712
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 02:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhEYArI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 20:47:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48992 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEYArH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 20:47:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14P0TYrd055599;
        Tue, 25 May 2021 00:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lnAFSHBTxW5UMXKLXydGk+vxlTrqq7/vyiRHilOxe5o=;
 b=Z9uzd40UqhhE8TSA43tHVRmQELoznMZEAM8J1P7QWPSTBxvGgHBkojlm6+goglTEzpuc
 5hvu2Weq2KYH2btgoO8FP69wBJC8xACSeMDKurwZrWlwa2v1MNVSBGj1hreOqtkWGPR3
 qrTphk0pUFlW4PAvnaPQb+wUoS+3wasyqzZa3r5+kfvbbmKATYZjdvWV8xbL1lWCTdnw
 KzC4x7C7jyZG+VjV9Wfx7HJekJ6UYXUOrofxpi+09Mwuk4UzV/GtJylKeiLw/tR/vvvH
 3CiY1qcusS1O2VX3F5R/noTAMygoyZLxSOZ5pp4uY4PTHMVDcJN9PGBBY8+vBL5jvCtX Tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38q3q8v03j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 00:45:32 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14P0UA9x080133;
        Tue, 25 May 2021 00:45:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by userp3020.oracle.com with ESMTP id 38qbqrpq2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 May 2021 00:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQzvJRCOQZ5pSuWFw2To/PCkpjlneCPAO1hQEqbRVcFVrdoIvdOCKfmRz80QxKJw7Dixf75Bl9I6OufcWvkM1g5ZHqGTyhcPIgk+0S9e8M5g81u6S6KV4Wc5/+x2Q7DQSPIyQQc0r988cnAmMk0JRL/Kmm/zyp2C/Gh2zBTa0XnF/nsxHggPJXFviBCrhiFPbMOrk16zejCRUX0V4a3ioXXQh9zhuxvIZoMlC343VlvSqxuF+JnIhRkgKNM1YlFynb1/a/8Qdsd9wfWPkVMbuN05clA5+m/Y36IGlZSuHwnVwy1nRu5G7yIfw9Ja/VkAPtfgKcDBXF5wLihfwT7t1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnAFSHBTxW5UMXKLXydGk+vxlTrqq7/vyiRHilOxe5o=;
 b=GHRojnGjyr1T3UvX+eO+nBYf+iVRcYqPxXHRdvlB9IVignl//5l1GljgoYIdQwzQFssVffFA8lY0S83Vhryzzd3CnNBGVDpHA2CvvaTNwkd+ZteHcd5ZGYImAMJ1aQO8tkUKvE2DKSD8j51NAYpL/viUpHxFjq35bFThm5Hz5zHJ8ciVDRy3LhNkIRbhTuTblwvC/VsqKMJSG2IlzN6FNQR2Jm9TAt+m92YJoZooONg+e6AHTJmGvPe4uRNx2ZyXf09gxbMA3BvwIjrUxuEBQSFi4iDF/1D7r2VnW4rIdBpjCZrg+2C+f5dnNJDYhK+o9FS/h7m56hD4Om0AaPP+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnAFSHBTxW5UMXKLXydGk+vxlTrqq7/vyiRHilOxe5o=;
 b=z60GBUObL5emSSEZg09AxED5X5xKtWRvJELXXBIvxpzF+xXJhBF22Pw/KOG620aaoRHc/E9jz5vSXa7qH2/tf7eVePlcOqp9yOZS5+2wW9cx+otDE4pzILiROq0CJG55d6YceFXMI1NDMYhl4AHxnwjJL7adC+hIeMyXH8tWhBc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4702.namprd10.prod.outlook.com (2603:10b6:a03:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Tue, 25 May
 2021 00:45:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 00:45:29 +0000
Subject: Re: [PATCH v3] mm, hugetlb: fix resv_huge_pages underflow on
 UFFDIO_COPY
To:     Mina Almasry <almasrymina@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210521074433.931380-1-almasrymina@google.com>
 <2a983662-ab90-0cdb-850c-eb50b0845b49@oracle.com>
 <CAHS8izOB6OUsTwv2kvkW13+knrpXTmyA+igT3+jY+7SVwzt4PQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
Date:   Mon, 24 May 2021 17:45:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAHS8izOB6OUsTwv2kvkW13+knrpXTmyA+igT3+jY+7SVwzt4PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR18CA0066.namprd18.prod.outlook.com
 (2603:10b6:300:39::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR18CA0066.namprd18.prod.outlook.com (2603:10b6:300:39::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Tue, 25 May 2021 00:45:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ec12f40-56ce-4ba5-7d79-08d91f16652d
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4702:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB470290B1F7CAF812D3F29348E2259@SJ0PR10MB4702.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cAScRYuR2Hca5YkQaGfCU1RGpUQJyzi+EZ8JhXF/lXrst9EsjSs+GfSywhc1sh7sYRJJ5K4iVoTRY28G2+7zXwYXfxl/bEMN+azdkjS6oH1+98BpkVxciNzj4f9yRyp3x6BAvziPo3TCFl5K2gAR4bBVQ9/ZjhBZlwJsb+oPXJ2HYxq5TbGXT8kkaeXehhiNU6F3sSduwFc7NTo6sZjYYmXimZk2j3YF6zxP8F6SJ9E04lwrPukQpfzvNXIu1882hbLPDztWAdBezZm6B/JTYJHrGy+LVfs+0sM358xNX1YD7P5H2IQQclVj9QO0QqZAJp9kSUaw75Lu8sZa7QEtjziKQauN4WBPL2urUoCw4pzVXg+tjOLs627LfNQZY9dObfUQcxl42ckKJkOf2WDFy8CBauccZnsxtpyZ45VOCa3m/SVR4PNDZt3Mh3Ic5JN1313ZQBmUkZJAHRqHPPuqLAfgBMjmvbA/nk1n3adda6wzfA45tFWQd9AE8tTvfJvxqJCW8qJkSizF8daztMIHAJMK8qU8chk/XsvI1U2Mx6pXvLkRM95QnUGzZjzgqls5xm6NL0tjWRQWxcYSDKtyWy5qZ09z8M2FwNtBmr7LNjxBBaqwG5HCZhiy100oyS9ve/+dkjk6goVKoP6hckRFjTEgFr34wI7N//ic1emV1ISVhUYc3zpiObaf6LyjG4IpSfO2GUlWDsfeg0nxMqzsFGhEEWf4HettgL6oYXOIb6XVMkUPmDKP3Bodhdqn+H8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(54906003)(4326008)(44832011)(38100700002)(53546011)(186003)(16526019)(52116002)(36756003)(8936002)(38350700002)(26005)(2906002)(86362001)(66946007)(478600001)(19627235002)(66476007)(83380400001)(31696002)(316002)(31686004)(5660300002)(66556008)(956004)(16576012)(2616005)(6486002)(8676002)(6916009)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eXBHMncrMENmNHU0N2ZjVFZxU2gyd0IvM01VY3FPR1dxMFNFRXVZMllTTzh6?=
 =?utf-8?B?MHJBaGlLTC9QY0k5WW9YTmxUcEFVWWhoMTRMSUN2Tk1zUUwzak5EZkd0Qnc5?=
 =?utf-8?B?c3JCeFZnYVpMVmxrem1PakNjUDkzMk1UOUpDMmtEQnhqekZvVnZ3ZFhQOFZI?=
 =?utf-8?B?ZFRFOUJEV2pBUExmRUVqT04wZ1NKaWNjUmlXQnBndGVWSnZ5dWlNMU4rU0U5?=
 =?utf-8?B?MzZENnFBcGZJei80Z1JjbTNDQWVXZWJVejFacDRrQW5SVGQ2bHBQZ1kyWElx?=
 =?utf-8?B?NDNsUkZoQVQ2VGpCRjZIT0d1N1RHblhGdTNkek5NenF0ODhrUU9PSit0dStW?=
 =?utf-8?B?d05IZ3BFNkZVNitGbm5HRms1VmZFdmtaZ0hEUFY4NzcyakdhM3dSNUtwV3NB?=
 =?utf-8?B?TzR3Tlh3V2hZNUxEZm0vcVZ6Z1B2M1pLb0h3UjFraTBoanZ6SzU5MkxvTE5Y?=
 =?utf-8?B?WjVIWUdQWVRIYUZHdEZLTjRUVGRPQk1Eb05aaDdUY3ZvcEZSN3pKKzJtZXda?=
 =?utf-8?B?QjJCZUhWc05MazluZmF2d0RQcW80VFNLR3RyWktGaDlZZnkzYitYWC84dmpk?=
 =?utf-8?B?aVZ0Z0ppWENmMG81Y1VyeXRJL0JYMVgrRjExaFNJNHRoOE9qSzVvMHBYaENa?=
 =?utf-8?B?TitYVGlaeVVpeFFwUFFTSXhodWVIU1o5ZEdWNHJHaTkrbUluR3A1NTZkSXJS?=
 =?utf-8?B?Skt4Qi9LVzl1eTFtUVJwN2hPZ3hMeEswUHBFcE9GRGxzSHQ3MlJWWHplbGZH?=
 =?utf-8?B?ZnJGNk96WFYvZkNaYlJncEhyZDFEa0w0NXAvTFNLeTVoSlFIMVBhUGM3dmlB?=
 =?utf-8?B?ZzZDTXRZUEdYcjJYcmRiOFhleVFLb3NyRGMrWHNtVk1XRXZYMW9OVmNMVW1s?=
 =?utf-8?B?d3dsTTY4VFAyL0NNbzlJMjVnbGJFYTVmTEM3SkJsZW9ZUEFCcHVvVGlMWS8r?=
 =?utf-8?B?Y2IzQzg3Vk1XLzk0eEFlUXFqSjltTTBibmtPeTZCQ2w1WFVmYTcrcERQK25E?=
 =?utf-8?B?MjdCWWJWalVvR1hZSVErbi9HWXF0OFI2NzZUbVU5RWw0ZCtuR1JoKzlxMGlp?=
 =?utf-8?B?enlUZzcwaVNLaW12b282NklBNktPNDNoam9EcDFYUmhnS2VITytZYlRUa0Zq?=
 =?utf-8?B?ZWJPR0N4Ryt4Rm5TaUhiZi9HZUJKQ1c2b2t6Vm5LUGZ0MEU4WFJrbTNFc082?=
 =?utf-8?B?eHRXeFl2MXlMY2NJd29Wck1rbWZtY0dtK2Z1VTU3NkFwZmo5aWoyekxyeGc5?=
 =?utf-8?B?a28xRXMwZkk0VW10UlIxVzFnVDlHZE9yL25wbisyOWVvZnZiVnA1aVdKSmJm?=
 =?utf-8?B?SDhKbjFhaDgwbCtMOVJCQks3WHNESERmcGlEeHZ2RjNralZDeHkyZURhL3Jm?=
 =?utf-8?B?SjFtbmgvQytYQ0dMQ2pvL0p5Z1Fwa0RjQ2ZQSitna1Q1SlhzMVdJamhVc2Uy?=
 =?utf-8?B?RWpxU2RvaDNac2dqVyttMk5hWjNOQ1BGY2lOa2NWWEdYSjlBdzg4ZXFKT0Zq?=
 =?utf-8?B?bUR6SU9ESTN5dUY2UHdNNkI3b3dvY1dTN0hkOHBpdlBQdDd1anpKYlY3N1dR?=
 =?utf-8?B?SHFiQ3pLeWhiNnpFb3hJOHhhc29tNVlYbkYrNDZVUFB0QzVkMzVYRU1wYmZL?=
 =?utf-8?B?TVVRUXZuSHloN2ZwNDRvc2thRXI4bjFBa05sbjdTVi81anczaHE0bytISG8z?=
 =?utf-8?B?U0ViTE5tOFRJWDdHcEk2YTQ2QUNtemtIbWRhdGNWZDQxL0N1T2gwVFE3K3V3?=
 =?utf-8?Q?EK+0s9NO1TePoH6/A02JomzqcO3cDAc0StO3W+1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec12f40-56ce-4ba5-7d79-08d91f16652d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 00:45:29.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9WiIgNXDzDt9AtlrKcULTXj5FnRW/YNn+iM5k/eNtFk1kz3sKDIJ+UqqgMnkfkaI7mrCpt7KYiaiViDN1d+rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4702
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9994 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250001
X-Proofpoint-GUID: I-uLb5qP2tOJzKEB89XaEjfMo8_cjnDb
X-Proofpoint-ORIG-GUID: I-uLb5qP2tOJzKEB89XaEjfMo8_cjnDb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9994 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105250001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/21 5:11 PM, Mina Almasry wrote:
>>> +                     if (!HPageRestoreReserve(page)) {
>>> +                             if (unlikely(hugetlb_unreserve_pages(
>>> +                                         mapping->host, idx, idx + 1, 1)))
>>> +                                     hugetlb_fix_reserve_counts(
>>> +                                             mapping->host);
>>> +                     }
>>
>> I do not understand the need to call hugetlb_unreserve_pages().  The
>> call to restore_reserve_on_error 'should' fix up the reserve map to
>> align with restoring the reserve count in put_page/free_huge_page.
>> Can you explain why that is there?
>>
> 
> AFAICT here is what happens for a given index *without* the call to
> hugetlb_unreserve_pages():
> 
> 1. hugetlb_no_page() allocates a page consuming the reservation,
> resv_huge_pages decrements.

Ok

> 2. remove_inode_hugepages() does remove_huge_page() and
> hugetlb_unreserve_pages(). This removes the entry from the resv_map,
> but does NOT increment back the resv_huge_pages. Because we removed
> the entry, it looks like we have no reservation for this index.
> free_huge_page() gets called on this page, and resv_huge_pages is not
> incremented, I'm not sure why. This page should have come from the
> reserves.

This corresponds to a 'hole punch' operation.  When hugetlbfs hole punch
was added, a design decision was made to not try to restore reservations.
IIRC, this is because the hole punch is associated with the file and
reservations are associated with mappings.  Trying to 'go back' to
associated mappings and determine if a reservation should be restored
would be a difficult exercise.

> 3. hugetlb_mcopy_pte_atomic() gets called for this index. Because of
> the prior call to hugetlb_unreserve_page(), there is no entry in the
> resv_map for this index, which means it looks like we don't have a
> reservation for this index. We allocate a page outside the reserves
> (deferred_reservation=1, HPageRestoreReserve=0), add an entry into
> resv_map, and don't modify resv_huge_pages.

Ok

> 4. The copy fails and we deallocate the page, since
> HPageRestoreReserve==0 for this page, restore_reserve_on_error() does
> nothing.

Yes.  And this may be something we want to fix in the more general case.
i.e. I believe this can happen in code paths other than
hugetlb_mcopy_pte_atomic.  Rather than add special code here, I'll look
into updating restore_reserve_on_error to handle this.  Currently
restore_reserve_on_error only handles the case where HPageRestoreReserve
flags is set.

Thanks for explaining this!  I forgot about this 'special case' where
there is not an entry in the reserve map for a shared mapping.

-- 
Mike Kravetz

> 5. hugetlb_mcopy_pte_atomic() gets recalled with the temporary page,
> and we allocate another page. Now, since we added an entry in the
> resv_map in the previous allocation, it looks like we have a
> reservation for this allocation. We allocate a page with
> deferred_reserve=0 && HPageRestoreReserve=1, we decrement
> resv_huge_pages. Boom, we decremented resv_huge_pages twice for this
> index, never incremented it.
> 
> To fix this, in step 4, when I deallocate a page, I check
> HPageRestoreReserve(page). If HPageRestoreReserve=0, then this
> reservation was consumed and deallocated before, and so I need to
> remove the entry from the resv_map.
