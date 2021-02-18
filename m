Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497CA31F227
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBRWTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:19:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40350 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBRWTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:19:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IMENK8189894;
        Thu, 18 Feb 2021 22:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=abrCi1PDzKlWyfrpyTsx1jR3KywZV3FxScb5W2IBSdA=;
 b=uhxq0myNWBCkHzu03x5v55oaWqJv5+2D0QzGtEBPqX8Ke5z1riheEK0rcX9rK6GFO9CT
 6+LKnhDIJayRdZe3Z/MgjfXK6cF8TFUPPWOTbRTAYBt5utz2KM7HPczAbMM3gQe/Y6bf
 xtLPXSSTmX6Jy8Iwn15XJo7JjlU49iZQ8oYKdFVVCrTHZgY1bbWIjWrRmoIRYrHQjQ8T
 N5kf2cGzrVVwlsqOL7c/kkg185WaWtLw8srCjhOYGQMLlddz3RpnxiQk6Db/6N51ESb5
 mhXZtkGz8sN3rMp5wDtv4c3Ccot9E6J40gA7SPf5IbR4pLzvQlCBW5GftgGxhbQLeQZ0 WA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36p7dnqgda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:18:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11IMBiFK002267;
        Thu, 18 Feb 2021 22:18:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3020.oracle.com with ESMTP id 36prhuue7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Feb 2021 22:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd1u601LkgMn0+uMR6If7fQJJX0fTvBXFuirw9e0Q4Y3Jg6ffrDb1mPvNfqHovTZduFjSbfStUUrEXe7iF6yqrqwg9a8L3yuCQpUf21eg/1znpa8XA9SqKxeTx+ghgIW77DOMYzkcv0IQxeR31pvxDx2akLigbDRInUmETnJpzC96JVEnYIGMuzWngRgin8q3iGHZ7CJctvRm2FnSDvsLKpm4598l81PweRPdPpq2JBdBJpX3sbH2vUdO6k15msv3UrMubpbx9KSQa2EmaO62kULU/mRp7+qTUxa9eH8l6nYXRt4bEuCmghKsZKCo01dCNyu+HLV66HtHLHWT7OdBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abrCi1PDzKlWyfrpyTsx1jR3KywZV3FxScb5W2IBSdA=;
 b=F1rodwCDOrhISCqI1RfBtGPoken/x2aqT0VdAvL4mcuDQHSPP8by52qxKYC0QEEF1RGaoMnqNaU5wG4JOeHLPMamTM2Rd0zEJGmTscmYIHUtaE8bK4fFiITz0OXzOBlb73unkz3PYXgZpW+EjypbDHyVSN6wkuj3XrEW30UgK+Rlhc6rKH5hsdkHVRhjasJNPhFtyUIc6qgnvPGzOKwu61SpGa31SIiQZ/u99Ov2EizHxWnXg1s5ofCdSq2FzF651NTEGyucERHltHXLqFrdN+NjpEMpBmuZ8Xy0Ap8sEBY+fZDgH2Abx5nCPuIzGeidIjq0QNjCPn6DB57ju7svWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abrCi1PDzKlWyfrpyTsx1jR3KywZV3FxScb5W2IBSdA=;
 b=eAWrEQTXmtAjzmEqw2xSIqrDRzo9D4jQi8x52sh6yt6OLZlwvEDtVydYTF/rK3KulatLBwYyuhO+F9Zm2HY+eGQSFNGNVjY564YeMhTNjvEKzmL+eaEXZ260klC44myXdU6/5F2jDbm2Di2OJwNOUrBQKIkFdaixRII93AgVyIk=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3640.namprd10.prod.outlook.com (2603:10b6:a03:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 22:18:46 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::e035:c568:ac66:da00%4]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 22:18:46 +0000
Subject: Re: [PATCH v3 4/4] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
References: <20210218215434.10203-1-peterx@redhat.com>
 <20210218215555.10710-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ff2fa34e-2a9b-a386-fd56-426eeac7d429@oracle.com>
Date:   Thu, 18 Feb 2021 14:18:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210218215555.10710-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0166.namprd04.prod.outlook.com
 (2603:10b6:104:4::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0166.namprd04.prod.outlook.com (2603:10b6:104:4::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.28 via Frontend Transport; Thu, 18 Feb 2021 22:18:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f52e62d2-77a4-43f4-066c-08d8d45b288e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3640:
X-Microsoft-Antispam-PRVS: <BYAPR10MB36400F581F8B938A43E2C4E2E2859@BYAPR10MB3640.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bkHu7zzIStYWnxoKTISDUnrDnMsejcmyvfvLhX+9YFiJuJQ8f9cowsI47kUEJYRrm6RrG0Lv9C9hgrmF1o8H4UdGhhTB4YT/hwEB3l9lKul3N/A7Px/S/43QXFLV6lwjRY4JsO8qRSWZsKdTqYOei+aMlvnlC/hd3WEjC1r7j4TzOrik0Ro//ZvKbw4c8yY9hPD93DKsFa3RoHjmFGq9+9O4gj0xZUa1m7fVYOkB1w/5242FbbC97qRz+3LydDVWgeM5e7rZosS80swTdjWAejK7RxPI5QwJxFPDpPIFIknesxVF0PRXM2cZ4sQxQ9wIg8ZagJWpgh9T1Cx0b9Xq0z4eIZNRpv53256c77ZB+8MAWNZQ5K1SqdtKGY5dSMO7rHw+uCV8jTU/j0NImAwofDdQ8EYLw6DguQo3f7x426Wn7IgpB5Y8U5DH5/3BS0dQqsy3ppQdQrDPV5CLETX7++10tn1MP/1nBDOkwH+bkQoZmJupY1cVWrjwgNdIh2seSSLds4voKu3uB2Vy+0ASJcJ5ReSiFq9j2mEbNvyE8a/9k54WXp13Qtbf2OPfPWz5Nbu71lvaHw8/FiZ7lE+bt8NZ/IMY7Wk9yTGafpoiMbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(376002)(346002)(54906003)(478600001)(66476007)(66556008)(4744005)(8936002)(83380400001)(8676002)(4326008)(52116002)(36756003)(2616005)(2906002)(86362001)(31686004)(53546011)(6486002)(956004)(26005)(186003)(31696002)(16526019)(316002)(16576012)(5660300002)(66946007)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RXRLMldYb1hDMWpLL0ZVVTRoK3FXWDJ0RVNwVUpOVXJXMDRXRlJjWkJhTjNZ?=
 =?utf-8?B?Smcxakx4OHFFdVBLdWFJV1V2M1IwWDNrOENpK2RtREY3bXJLNzBmTWo3a0RR?=
 =?utf-8?B?THh1VnVRMDhKcE1KcDVtcTZ0TTd1YVNwTzU4WHZUWjlSVWtzVGRPOG5PbTRm?=
 =?utf-8?B?QTBkTWJnNFJ5Uzc4ZkxyRi9ZWWdNRkp4TERZT0p1aC94UGhhTUIwOXRFcHBm?=
 =?utf-8?B?S1FVUG8xU0crRGRqSEJGN00zK1hGbmQ3OUl6MjhNb0dFU2NtdWhOM1hEVGk2?=
 =?utf-8?B?by9Db3RrWUVYcGhlSE5RS29kbndndy81cjdiQmZ3d2xwaGltUEZyNmdTZkVR?=
 =?utf-8?B?RXhoNDd3dDhvd3pLRDc4cDRqSnorOFZlRnBING5tRE9NRGoySVJCcHdLUHht?=
 =?utf-8?B?ZDMvdzhWaDRuRDdwNmdHMWh0aXFrRkI2ZEZFRFFxblpGSUJxWHREeDVuYzBN?=
 =?utf-8?B?YzBPWGpUSDJqVTBJZ0Z2QllVTmNJNHRUTGdpUUhTaXF6VVpTNDdLaVlVRkx0?=
 =?utf-8?B?WFFKb3hlRTE1TDdXMFVDaW4xdExTVFpHZlEwVkRtZWNEZTVFd3daWFZZVHpC?=
 =?utf-8?B?MnpmZ3VHVWxDQ0tJQVU4NTlFekJpUnhkZCs0RTdiL1AzRVpFcllCSUhBWlJC?=
 =?utf-8?B?bUhnREk4cnorYjlnY2grUDBUeGFPaTVNaEs5VUwwN2xLU1NraG5lRDFuS1dy?=
 =?utf-8?B?MVNIWGxZTi82blZFZ1NYNk9MRUxIVVhCMFhGa3cxZllhb2JCbk9qbEJQN1Ro?=
 =?utf-8?B?V1AzVFcwd1Y3WCs0K2tTS2JIL0ErNS9kRXhBQjZKNEdIZUUyTDZqZ01LV0NK?=
 =?utf-8?B?d0hDNWc2UkRvUndsaFowWkJ3VUp2UE54QTFGYUJhSGhvMUthRzQ0bjVXQ3JB?=
 =?utf-8?B?cHZSZ0syT1Z6eGd3UzFmdzU4K1dGMnZzUUtoTzBWZGxsMXVSVjJ5Q3JPTXl3?=
 =?utf-8?B?QXRjbGNkdjludGx3SkYxY0E5VVpJUWc1TjJzblZCQ3VsMFpDN3pWSnh3MGs3?=
 =?utf-8?B?NkZHSDdtVlJaMUp4ZlpKcm81R3pPQVdxdkJvQW5FS3lBRGxHZHpIWWtLRGJt?=
 =?utf-8?B?c1ovY2NkaTNEWmRRRzQza2YxWFZaVFUxOHQ5dmZmWld4T1JhbUcxV1VJNGRM?=
 =?utf-8?B?NURkTU5GL1FGcWl5Q1ZHd2xJalRaUnlmL1R5S2tlTTBCaTBIdVBWQ2ZXVGdQ?=
 =?utf-8?B?Mms3czR2S1pyczJMMFp2NXRkaXVrVVQxNHhRTDRZQXZDa1BPREVtQWJwb0pR?=
 =?utf-8?B?OXJaejFTK1o4dG9KaENCTVY2YmRoOUl0WW9YR1FYMjMxV0JMNTFiVWJaeTBP?=
 =?utf-8?B?bEc4Rk9UZzc3YndOL1hCcUVmZFZ2M3I4aHU3U1pQUTcyR3RQVGFVRGdkUVp6?=
 =?utf-8?B?MWFsYW91UEJVUVJEVUx3Qm9QelY5VzZjaStmZ3NhRjUyTHlyN0xtLzYwOTli?=
 =?utf-8?B?RXZIbG5SUk9YVWEvTWFEOGh2bDIxSVh2N2dVaUNUcnJpb1JSR2FEc2xJeGJF?=
 =?utf-8?B?dkZ6cWRrMnJjV3NCSjZtSEFnYjFKcmtMOUtkYzcvazQ5QitqNWJEUHNiM1hm?=
 =?utf-8?B?MmNJWVdIbW1iRnF0ajZZNFdNT293ZnA1cG93UmhjTTdYbmZzZVlXL1lUc2RP?=
 =?utf-8?B?S1FkK2VlNlV4VGl3dGlVaFF5RnhZS1VTR0Znay9ieGVNN0VnRDlpZ0p2WE8w?=
 =?utf-8?B?aGh0S1ZIMDlHQ00wdVdOLzBEdXhBSXVOL2tYb1JTM2tMK3VmUjAxMHU4STRm?=
 =?utf-8?Q?yKxHEXclrVqbSOJDBKY4CzPATc366mi//ab7IOF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f52e62d2-77a4-43f4-066c-08d8d45b288e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 22:18:46.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MVoSlhqLBlcz20LHbAkDZ/tAP4w2Tvez+jOMI698KDpWX8cgi07MV0NNm9tbX4IalMKXlEYJTR1047Rnyx+DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3640
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180184
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9899 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102180184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/21 1:55 PM, Peter Xu wrote:
> Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
> userfaultfd-wp is always based on pgtable entries, so they cannot be shared.
> 
> Walk the hugetlb range and unshare all such mappings if there is, right before
> UFFDIO_REGISTER will succeed and return to userspace.
> 
> This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
> is completely disabled for userfaultfd-wp registered range.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/userfaultfd.c        |  4 ++++
>  include/linux/hugetlb.h |  3 +++
>  mm/hugetlb.c            | 51 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)

Thanks,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
