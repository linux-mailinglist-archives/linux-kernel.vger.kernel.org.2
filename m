Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2090E3686E0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236886AbhDVTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:01:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24196 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236058AbhDVTBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:01:55 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13MJ16Ug010368;
        Thu, 22 Apr 2021 19:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ivdm0RN9Fa8fv9OA9pAxtRZ4BTNl3aGRfKCwmlB+3kk=;
 b=XoCvbAJCJ0MKpA1MeG9kwhed3EfKhZcF5HvJS0IHCyTGSLAkW/QkXPb7sxJSFTNIKRrz
 n7Yx6mqi+tBtYFH9pT7X5n1E6STYNGPJCWsS68syYln/crQ3DrjlQLastVXT2LhEYBjP
 6oZjCqdOtF535ORqOkcxOdhkJGNE3GCMCaLyG/QreeumwnRb595iYhz2D7/aVn7wz2Zy
 evHrJ8Hcy7OvviYwk1s8M6yTtDyHBE2A/YpoU+oAVVHJ67WjKmv4Jx1OCK94D19B3TUQ
 7zPpBZbw0/Tb+eXssTNfi0Ed9GcrEY3eocZM+LYnZwYSk2X1nW3ydZCtxEbXKa65qyVC 7A== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 382y2q8bv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 19:01:06 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13MJ14Db168463;
        Thu, 22 Apr 2021 19:01:05 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3030.oracle.com with ESMTP id 383cdrycq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Apr 2021 19:01:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D722jiW+WAuO5w5s/nAvmiSUZk3J2B+yVZ5fGgzIuPCUp2miGYX77BF+07OJGi9qRXXi0mlQ6Lfklbxnh5hm9P5WLHtYBtIKo4O3umUhUmdoIi/VjuMVvDtQ6UwSSQ48+chHpZx9PeKIls0rhGjUsXgr+IQedboL9Vi3FaDJeLf+mIkWk4Md0b/3y495nT6Q+uyMfmY/J3l57u6mO+1h8CGm1mKiA27EpRl6aMA26M7uZcQluXt6b/7/mZn91zsTiqeY9mlZzJxLesFG829U+8V5k74G14hCERHsjRD4SktHOpD9R7QX/3G5YtAlD5w2kTlz+6DcuIMnD9rxQJFu3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivdm0RN9Fa8fv9OA9pAxtRZ4BTNl3aGRfKCwmlB+3kk=;
 b=Hvp6PVhAM6CYoaaodAanUNQ9vfKaDNyUwJJQOXESqNH1ps+uQHORrgTIO/pm4qPXSj5gIKOEYrA8XXtw9VIm6hwE6hvx6HiM4LISzeKNkB4X9TojFo0Lfbk/i9c02AfdKcl0xohIiuBtyXSkMXrEZOwhGPGB8dA9SngdafbLRjO8TmOGGjEO1fZWqYyjSRSFF7rxPOLLkbzat+v8ADRC2cq7Rl2++kszpjbHutYUWvNzmkX/4qAy5OYNcDYDuJfqCR9yXI0DYtybj6PIAw4gucwOpueaHdJDuOKYXYuumnqtauIor4s/8j6DYSE1je9/tF0ApT7GdMOH1cROefbgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ivdm0RN9Fa8fv9OA9pAxtRZ4BTNl3aGRfKCwmlB+3kk=;
 b=HuZrbC3B0nkm8lPDVUhmXvR9Un16b7WhBjp7yusPS3lPyLrCZ6M4X2LA/UMoHmOA//L8+XL2DoyR1bo/ejAi5fhppH+A8u1vdd2jZQv5/QGmzHEriWsMZeHLvEfcAZZFu5a8pnYR4HvgeFHROgP1dXzG9mfUmcSmsQPV5tTGROk=
Authentication-Results: linux.vnet.ibm.com; dkim=none (message not signed)
 header.d=none;linux.vnet.ibm.com; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 19:01:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 19:01:02 +0000
Subject: Re: [PATCH 18/23] mm/hugetlb: Introduce huge version of special swap
 pte helpers
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Hugh Dickins <hughd@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323004912.35132-19-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c7cce8a9-6095-d8a9-7980-9a369a0526e8@oracle.com>
Date:   Thu, 22 Apr 2021 12:00:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210323004912.35132-19-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:301:14::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR1701CA0015.namprd17.prod.outlook.com (2603:10b6:301:14::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 19:01:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 406b727c-ccdc-4541-ddaa-08d905c0f901
X-MS-TrafficTypeDiagnostic: BYAPR10MB2999:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2999122E24E04D12424CD9FFE2469@BYAPR10MB2999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMboNKCLrV6Q1lPrlUkLdaWUm2BwpLjlba3vVUf7fcLOR1+dREWvaMr0Zm4ZVEPj/E2zrqEtluGj3MY6T5xqdFhlHYqS/Jsn0r37AK0yOObntt98dtqps2O7WuJxT4tDOFWQMVyttmq7zgxbIMR0KIAIKkWfkIjWCnagjHhIcSB+AUPad5nccnAVjmk6UUMZOFRTWhtMtoV7bJS9ulzcrT5p4Hzdu92ZKZrRLkqxK926IBRQGDKpSKNnJvEtvbYKemmpVTmL1XCi9PUA6v41iw33kW9PqXkCz/1ztdwOMJc0cMZ3sfTsBjyfanyyMuVbHwaRC1JqtuxcZ3HcvNFmi1ZAi7+dY0ymWVVWTNsxXnJgYy5lObkuXapPQ5iargyNSzMFrm3RYgHhojRxMi4PNiiFuh9hSWHVqtGL06tSFVmKECODAEaIyDPLDXziakc1K6geuJ1D9F0pimhm/pp5+BXGMAmEOPwe7jPRIBjwDRPHKPtdrPvu4HcLrd4NoCXOOLfNW+Wfh95IWiH2/uD2ijNoR+u+hOWb9PeKZ03X9uvU+7gLH98eomScuBowRM+Ld6g4DdO91YJ4MbZ//IpaYC8uBq8f561//aEydP52DT9eGNAL8CnH40VtCnx8J/ufTePxAMRqIzGN63mvDWop6fOz8dsNHsKEhaH/2yBS4wOdStU/3eL7XYTLQG1M2WGfYFH/DQPvqkjJQfJv1mjphr+tHPWVXMNA5a0ASunPnGYXtBKyPVpO/Xy7wJoaY1e9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39860400002)(376002)(366004)(346002)(5660300002)(66946007)(38100700002)(26005)(86362001)(44832011)(6486002)(36756003)(52116002)(31696002)(4326008)(38350700002)(66476007)(66556008)(7416002)(8936002)(53546011)(8676002)(316002)(478600001)(16526019)(54906003)(31686004)(4744005)(2616005)(2906002)(16576012)(956004)(83380400001)(186003)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TlBDdXozdTB3K0RoSnJoNWJjTnhlS2tHWFZCdnJvZlFTczBkUkYwOGRWTkpB?=
 =?utf-8?B?bjBKS0JYOE9ibk03VDZJOFl2ektJNWVoTUNUVXhlV3d4WXBQUHVLc0xvdm5L?=
 =?utf-8?B?S1JlWXFneUxGem1LT3VEU1BuaUg4VFgyejcxSnhRUDU5eCtoMld2SG4yNFRT?=
 =?utf-8?B?VFp5NDM2VlZ0clRva0U3VW9ka2N3OGtLS1UwRm1zTjBiTnp2cUM5ei9wdjZx?=
 =?utf-8?B?VEJLR0djTkc3a1RTS3A0Yk9kc2J5RFRrRDdmRGFjUnR1UFNTTFRqUXpKbGlC?=
 =?utf-8?B?RnF0cmowd3pWUXZZVXpEOS9ROFloanBsb2ZhU1N6WThlelROS1JQWFFEaE5F?=
 =?utf-8?B?Wkt1WXNKdWN4YjVPM0NGaDBUcEFSYS9vcmdaenk0ZDU3ZmQ3UmJTeXJDTTlZ?=
 =?utf-8?B?REtNY3czSjlKT0ZSM2c5bVlHTXExaHpHRG5HM01Ka2h6dlJQZWNGUkVYQ2wv?=
 =?utf-8?B?T1hBRFRvZ0Z5NEkyYjZOei9JeWZNdWticXRUSkljQ3dpWDcrUGtlL1o1dHQr?=
 =?utf-8?B?ek5KRXJwS3JLK1I2WkVxbEdiNjczeXJvK1had0ZKRGN6elZydFFaeUhMeHFO?=
 =?utf-8?B?WC9WRkdpS1hBOUp4dFduRTRscHRLbGIyU3NZck5mK2pYNHdGYU1TdElCL1pR?=
 =?utf-8?B?dFUvRThLQ1lBMTVwclNEdzhrUjRjZVFQMFk1dG5Yc1B4WENBMEFMSWdiR0sr?=
 =?utf-8?B?VFdzZDV2bHN1aWtOZHhFeE1MNVRrZVQwZlByY2NxZ1ZOVXdGVngyOXZyVnRM?=
 =?utf-8?B?aTRtUmkzRDV4MU5WTzl2QmpIRmhsUVRvQWZob0cvUEVGeCtyWVNJM1NoTGxx?=
 =?utf-8?B?QzAvTEo0VGFYdHVlc2ZJam1xMWRPTDhrQ2RXSlBmTnhFOUdzQlo1SXF6anRs?=
 =?utf-8?B?aHF3bGpRRTduODdEaEdYNjRXekFHNTlXZUQxTkFYbHFTemNaRFI5TkRkLzhj?=
 =?utf-8?B?R2E4QVFuT1NuQkg3Y01vcWZEY1UrQUR3NnRlOUg2d09lN3lZdkRvRjVucTNS?=
 =?utf-8?B?QnRHSjdTdkNWRWYvSXFDWkVXQTI4QjNEU2VKUDRuNE1hek50VU9mQ1Bwb2RY?=
 =?utf-8?B?Q2dwODFack9vZWs3SVYxS3ZlUEpybkJrY013ZlhGTmpPMVlzRzdPL0xwWDF0?=
 =?utf-8?B?VlVVOTN1K0luK093ZUtLNUJDclNrYnZvQU5HKzFUQy8rdURmUWw2RGdmeGFM?=
 =?utf-8?B?WXVWRVRkdUczaU91b3BTZ29Fajl6bW8wS1JvUW1NTEQrMFpPL25QYk5YaWxi?=
 =?utf-8?B?NWN1VCs0TXBnWnZTOXR6WmhsYm9ycWx2M2luRzNvbzFVVm55MXp4V05BZEF6?=
 =?utf-8?B?UzNKdzFlUWZ3c1p2T1FGcGdhKytUY2F0YldBL0xuSHVZYjZQdTNkYmlCajkw?=
 =?utf-8?B?Z0tVUXNCcGpjSW5zMlJJV25rY3ZoYTBOOEt3VjRzNnFsK2lLd2hNR0tCbytN?=
 =?utf-8?B?d2tjbTFNSUppajFJYmo1cTRodDlVVlFudjhWRm1GN1Z5SkNrRWM5emJCaDZC?=
 =?utf-8?B?SDlWbTduOWRzN0Vvc2x1OVdiV3pSODNmWFVpN3NyTVNCYXdCSU1YUWlxa0hH?=
 =?utf-8?B?akx1Mm5wYXpRVHl1bExTM0JieTlwTVgwdDlIWkJwTmc4RDZYbTAyWkJlWlBh?=
 =?utf-8?B?dmlEd2d4S3djbTVaZFFGQWdLanRiU1ZQUUthV2JXWldmSlFENVlFSXc1UFJp?=
 =?utf-8?B?TXpXZE91Q0NEbE9kYkZWMWVldk5nbkFuOUhMWGVseENKaVFlR0NQcUZMRSs0?=
 =?utf-8?Q?cvcJBuHFzP1mWIbpKuNRXRLaYQ0VcNPD+nNHP8y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406b727c-ccdc-4541-ddaa-08d905c0f901
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 19:01:02.3505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDlV032J0YgfMtJF6Y2WeGSPAkIGWrJUIaMK/Qy1nvuTkdl01VdY2phmFQYPa2+5lg+o+mEYXRd9wtJTqL2NSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2999
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220140
X-Proofpoint-GUID: rjoryS82ZH_dfs7Jba0-8tqkp9ljd_Ds
X-Proofpoint-ORIG-GUID: rjoryS82ZH_dfs7Jba0-8tqkp9ljd_Ds
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:49 PM, Peter Xu wrote:
> This is to let hugetlbfs be prepared to also recognize swap special ptes just
> like uffd-wp special swap ptes.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)

The multiple uses of swap entries can be confusing.  Thanks for the
additional comments in the original userfaultfd wp code.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
