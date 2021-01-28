Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537FA3080DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhA1V4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:56:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58136 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhA1V4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:56:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SLcx19120998;
        Thu, 28 Jan 2021 21:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LhvVN94yAojpJ8/b6E4aVz+3YWLkhe+8ZtRODtL9XOs=;
 b=rq2J0RPJ3qCKKNPRqPgpE0+bfkMFGT+sBHBdgsXBx1mgKGq9OIdo1oVUfcNPeI/DH7V1
 OFBCW3zPzDRfjjLUxvaLZyAqUNDxqoRuXRz0Jx1wqVQtOJg8EsMs7FaWlxdvyPfy3tUY
 Yww1yp4wluH/P+M1O0XJDxfmY/2lDhbJ84OzbhZNs9qNwsO/RacGLwdGqO+snAYmsnMG
 1L1OBa6YuOcIobLQ5sNiOLkSag644Bh0cHtYbqxT2QCjwPzjSs/uL+0IPCCRLdYGszx0
 u3ASvjZ6TJf5dSVO8BG771c42oTW4lxe/PJ+oF6znq0h7NjN6NJJBrgXVP/Mzot0CUjN +g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 368brkxacq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 21:55:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10SLeerf157275;
        Thu, 28 Jan 2021 21:53:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 368wq28xm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 21:53:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTc8K6cwor4BKvDaOsKo0rX+MoLjvdxvdDJCMcrd2Opa8OZ78epsTeWgZz5cw07SM3K9TUMN3WxR8QHtYyRmDbMNxduSpSxlWfvqqKL5R1Q/1WOe6vWRJMwewMvzNsE+kiwjvDsSeGzINXOyFO2HsrLJgEnA+XbYDzlLRfOnb6ko9P5yoCxVxt6iUEDSNMlfSseUo5gdsECEecCeZBmMpuY+kAR7nI4RCuvLV4JTXQi0cwtdIrQ2TD33/YGLA48xM34FbPtRVNJbCRujI3lcNyaVT9nTYkjFlrXucfFk+QmgXviImv6RSQMYgpIDe5VU5eMk4ei3wIAnoz9tXi3+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhvVN94yAojpJ8/b6E4aVz+3YWLkhe+8ZtRODtL9XOs=;
 b=K380QIOywTw3cF/oJ4pyJuwn2lSz+agP1xOqH1rzLZ2ha9LjcrJlvyCeHV54NG0ozmD1bryAMg7jVuxo++iKdcEAptjYea039dp/zmeUPn7XNIOqnoEkZfP/z8Vn/wxLI6439+h4eS+9pzeEFFUvebnEGFSTfXQoxEaTunTGxLh7vFd28ORMKUo68LmPPhNarNFRmH9w0SipReLdNuiemeh+o1+jCsG1Nqnf11EzPM70ixoBr0Hj7v8Yle7pWsm8ANFE71/opBI6fvidU6p+WQ6Bp5nO1mAgpatjH60qLke+Sr/OoPDwnBwYgcYK4C95DXjiOaJffApDMjQBsExRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhvVN94yAojpJ8/b6E4aVz+3YWLkhe+8ZtRODtL9XOs=;
 b=C1nkzPWJGjqqdcXwNmgErCowDtRbJxB1W2Uj7hRYYGJXwcuHke/XcmouNtol3Vwsm6scZWZGexdP2TxNuWElylc/8vLsDO2hEVnAzSlJKzjS4E/hii/IMmxCvwKBPKYThD9sIZqlqg2S7/xfqgxc4H0Lt/MPBvTqLVDOmtl0uQU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR10MB1502.namprd10.prod.outlook.com (2603:10b6:300:21::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 21:53:17 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3784.019; Thu, 28 Jan 2021
 21:53:17 +0000
Subject: Re: [PATCH v2 2/2] mm/hugetlb: refactor subpage recording
To:     Joao Martins <joao.m.martins@oracle.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210128182632.24562-1-joao.m.martins@oracle.com>
 <20210128182632.24562-3-joao.m.martins@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b550e766-b0fd-2c99-c82f-80e770e8a496@oracle.com>
Date:   Thu, 28 Jan 2021 13:53:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210128182632.24562-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0374.namprd03.prod.outlook.com
 (2603:10b6:303:114::19) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0374.namprd03.prod.outlook.com (2603:10b6:303:114::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend Transport; Thu, 28 Jan 2021 21:53:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9b9d502-749c-4ef0-dab8-08d8c3d71eb1
X-MS-TrafficTypeDiagnostic: MWHPR10MB1502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB15024819707D5CAC02906F1BE2BA9@MWHPR10MB1502.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oSaVy6f6WiHXIX7+KCSSXvbPKl6QF/FGjWcT/HaS1Nz5xTOChf0BqRDzKFAX0bDecSl7xazrS90EO5yJxdnYPz1b9RDzInx8RiQ+Db3SzEESy6H2VjoY6+PKz7bPjU1TR9YbnRM97zIBOmPFYTdXJDxvEHN+0GX9e8lRfTCIkIWzQEOPjH1KxPWhjuC2wz7yVdQuM3zHGoFvsxGFVPwxP+sRVRV6JgA252EZTCabJqluhBhvmYq6XmTGj6oNOI6sHCW4hgPIXAS6A+chTvYxsRqGtt5UCIWLPFoNQeHLJ2KPm1SyfPcoDBGb9MPDEv0wkvTwifDq+YGx2E6u2sAPvanzNVVXDJPU0rg1Uc4hHe7PJYXtApYwd6fwHUcbqWcYIKgu/ChOnQSTHlyjU61gOhewUcUAhm9DeFTh1CAQOtRp8lkZUx6wdxU/9p0lyn2QF2cMOfWSWDJYPs0NKFMqvlL2uypIxKobNct4EQEgnxCX2I5GPZMn/wztlM6Mn+SiA8zXaatiCCcqG66/8Raf1bV/ZBCEF7khRzTpMiBDcOxwk9FsxxbIioRD/bNtUSuVEAfU3C5lJcrqd75kpH6cPbUhNdxhlQnhEoluh2wfeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(136003)(346002)(39860400002)(31696002)(8676002)(83380400001)(4326008)(16576012)(2906002)(6486002)(8936002)(36756003)(52116002)(31686004)(53546011)(86362001)(66476007)(956004)(2616005)(66556008)(26005)(66946007)(316002)(16526019)(186003)(478600001)(5660300002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NmpldWJKaFd6TElKRU84eENHeWxXcU5JVXZzTGk0L2JrQllHdm9kdDRPSUJ1?=
 =?utf-8?B?L0wrOGxsMTZXenVNWHlmeTdPc05MNFEyRGZsNy9hSFU1YnlPMWV2R0JqaE4y?=
 =?utf-8?B?d09FbWZ4ampwUFpqMjREY0RBMVk0L05RZ3VVNGxJcFBuamtXRG0rZytCdGNq?=
 =?utf-8?B?cDhxblU0emQrTnVlSDNneCtjQWZOL2tPL0Z1RXQ1bFdrWXFvQXlXMC96cWRE?=
 =?utf-8?B?dGJqR2lyaC95ZTdQQWcxM1BxV2NIN2tKVkwxcDFPZjRkaVpjT1k2Sm11U2Ew?=
 =?utf-8?B?UWdxcExFUXo5YVVGcklINnNpY0NsbG1iTzRNMmp1TUQ2Z2xJaVg3TFVDSjRl?=
 =?utf-8?B?cExZTUlNU0xMRWVjbFNZM1hDWk93TXFINUtTMFZmU0VjcStXMVYvcVduQ2FG?=
 =?utf-8?B?dDlPTmV0OUYzMGlpb1V5SGl1SGJFMG9oaFU5Z3N1TzVFUW5DbS8rMVV6STVz?=
 =?utf-8?B?aENiUXZidWF4UFhqcWN2NHR2WVBBNkpiUktpRXVjendWMEZrTDIrU2RvRzYr?=
 =?utf-8?B?VUROeDIvQkxxbytidFBoWmk4U0lCWXZXb0xHMmNOd1kzRGNVUWIwSURlUVJn?=
 =?utf-8?B?UnlPQnhZS04zZFBHY0xvRlpPemo5SWlHR0hkTE9QdTRZcjNKOUdDM2tJRU9R?=
 =?utf-8?B?bjZ3dmhaUXVZVnFMWHpLSHNSS2dRWkJzK2dEN1VUcHE4L2J1VjhrOHMyVFZ4?=
 =?utf-8?B?cUhvUzR1ZW5mNXhVTDgxeDdiWFN5b3R2MHdDN3VXSVZQTmJ0a2tGa0x6ais3?=
 =?utf-8?B?WXAvSFI2UERzUUpjWWZnaWNITTgwdFF4VFBNZ3FxQ2NlTWZkSWFiRGoxazY5?=
 =?utf-8?B?V1p6UGJsdXY2a1dudUFyU3dmNnFFbkRTM1BPM1ArR0NEdW1rOVFIV1RXbmJq?=
 =?utf-8?B?R1hQKzZOZ2svWTlzK2xDZEg0eVdxWVBiaUpYelllbGdOdkJNT081bjVzNndV?=
 =?utf-8?B?LysyYno3UHZrQ1dwbEdtMmdoWTU4LzZYc2lzVHpodHpkYktTQk9KUXlIVG9L?=
 =?utf-8?B?TjlPWVlmVGkrdEl3RzlxZllIUVp1WVBidkxOamxoSWNhN1FGUVVKNU82azZJ?=
 =?utf-8?B?eC9NbzhjWXprRkhIRkFZUDJCTEtoZk11VWZpb01sOVZjUTdpNUNUNUpuMVV3?=
 =?utf-8?B?MlhXcHB1dVYrTllYYzRnV0dvc1V6eElTRDF4SEJTUll4SmY5SDA1RzdmWDVt?=
 =?utf-8?B?OHlMdXBMRmw0V09ic0xOd2QwQzVXY2JRdXlzaHBWU2pDdXgrblJwVlVIOUcy?=
 =?utf-8?B?emh0TUxEZkRzdE80MTFpK1dieHlZc1kvNlo2cExZcWJOMnd2ZXU0bVpUU0N6?=
 =?utf-8?B?R3MrTDRHbnFJTEtCR2w5Q3gxdmRzQlJVQkhaVCtLaTZwQ0o2NGo4MjgxK2Rn?=
 =?utf-8?B?bDlxQk9sY2UvZmlyK1lCZTBDVlJUYzBPcHlIR3F5ZjFXNU0wRlJnNU9HVHVH?=
 =?utf-8?Q?XOVM8PvV?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b9d502-749c-4ef0-dab8-08d8c3d71eb1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2021 21:53:17.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il/6ypXv8ozAkEMQlZMPXFWoUrsj/AgDtfKokqZwCXeRK47D7AAR4YTCgElKNQXLrVu8IC3rTQ9FXiLZSs0EmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1502
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 10:26 AM, Joao Martins wrote:
> For a given hugepage backing a VA, there's a rather ineficient
> loop which is solely responsible for storing subpages in GUP
> @pages/@vmas array. For each subpage we check whether it's within
> range or size of @pages and keep increment @pfn_offset and a couple
> other variables per subpage iteration.
> 
> Simplify this logic and minimize the cost of each iteration to just
> store the output page/vma. Instead of incrementing number of @refs
> iteratively, we do it through pre-calculation of @refs and only
> with a tight loop for storing pinned subpages/vmas.
> 
> Additionally, retain existing behaviour with using mem_map_offset()
> when recording the subpages for configurations that don't have a
> contiguous mem_map.
> 
> pinning consequently improves bringing us close to
> {pin,get}_user_pages_fast:
> 
>   - 16G with 1G huge page size
>   gup_test -f /mnt/huge/file -m 16384 -r 30 -L -S -n 512 -w
> 
> PIN_LONGTERM_BENCHMARK: ~12.8k us -> ~5.8k us
> PIN_FAST_BENCHMARK: ~3.7k us
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  mm/hugetlb.c | 49 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)

Thanks for updating this.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

I think there still is an open general question about whether we can always
assume page structs are contiguous for really big pages.  That is outside
the scope of this patch.  Adding the mem_map_offset() keeps this consistent
with other hugetlbfs specific code.

-- 
Mike Kravetz
