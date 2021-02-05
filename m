Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B23310460
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 06:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhBEFMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 00:12:42 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55900 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhBEFMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:12:40 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1155525Z052881;
        Fri, 5 Feb 2021 05:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ii5hU+8I7qRBiA9tCdpnPAUF+M6miNTJ03o129lC1MY=;
 b=KOCI2crfB5XnXMl70oR6wAeiTTt+hKpaM7jUKhJ9W7f7ND7gHmdBcpMwV2gnxeHZgZr5
 7h0X7dELImay8OfJCwk3ygtjSGn6NyXh/EJDODwL/G1YOD3YCSza39qTd213q4Uu25p+
 JZtBRk4wlll/irfZEkumYIyKzAtS8K5CAF9VL/y9xRvxzIk/OYbdshDMSD6nEnyZUCkD
 AxG5BL0F4BxNqcMhCM8MeodjVuYHrZaRjtT3iPQ54Ov6hz2CninG4l0FAWAfoqvH/RW+
 qeTyOY7ky5COxOKYnkPRfiY3SbCRyd2lDS/HhtPUsyekS6QA0dWdYfjryr/+hXHeDEuw +w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36cydm89d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 05:11:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 115558Yg113103;
        Fri, 5 Feb 2021 05:11:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by aserp3020.oracle.com with ESMTP id 36dhc3nrye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Feb 2021 05:11:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/Pu1r1jcMoW6xp1QUmtgJ6nE396XPW+z3QqIWe6tjGaobnjHt+KPTZwRvZzKB/F3IkoO1iBOKd3Z0vlS4Jbzs06EFnGU1LP/OUheW8MPHUWtpaZV33L6LGVa0kFbOdhqTvnC1KwG8TBTT5V6N9kzQWRhJFeLAW9aVkf40UBhLgpp67R+ija8YnDUFjXwzRhdVD6MumWmnoM1nVNDoQWOMALoG0nSwUCuIrIAW6PLcnms5VFWlSXSC7ksFkMu9MYqyTw4dpZWjhxFbuMH7qRXn0OU9g3rfoG2e0hmCF2tH1pZ7q5UIgeJhmir6oi8ZhZQPPUkjZmwh6Go+YMpshQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii5hU+8I7qRBiA9tCdpnPAUF+M6miNTJ03o129lC1MY=;
 b=lnzEajgNubTVzla31ViC43C5ydHMNjxnFeeryIDhO0nC/JsUK55C12tmP/JF7W7a7brWsAa9+Aqiq7vYTFDc9JyPvvJBw8mEtintDvc9aDa13cDOmMt/azjv0rMKd9LxXaWsjd5fxKMv0Dk9OGsRdJO9OqGJLuDmV8CqHLkQhZv+k4ux4ZqHJ1SyZWiZiSqCru89m81s2CPaRbhZNbav6lyF/jQuBa4J/qiYu7rShA4L2BXxxf0EA5DkZevVAN7uu0bCOlqu0Uoowe/w4/JAyONs/WLX90ZjxzT8urWZiBpNqAa5NLBYTrZvSZrNbNBPBGg+j5Wz/4UHDi/qYN8kGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii5hU+8I7qRBiA9tCdpnPAUF+M6miNTJ03o129lC1MY=;
 b=pM6lVjbPKVAHIcs9zc3t4eF9A4nhlnFoLrT7mnl6suS59V9N4RLVOu0OTYlDKL/wdw29Ux/MtafK5tq45HFPUBGWlTUNjT+nNrsbrhSJ+FSQ44ucLfbXR29jxtfDj+J/rVrF1QbDYOeg3H3wH7jcQpkHSqK8BOkH9BiFN/onXXw=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by MWHPR1001MB2173.namprd10.prod.outlook.com (2603:10b6:301:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 5 Feb
 2021 05:11:25 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.020; Fri, 5 Feb 2021
 05:11:25 +0000
Subject: Re: [PATCH v2 4/4] hugetlb: Do early cow when page pinned on src mm
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
References: <20210204145033.136755-1-peterx@redhat.com>
 <20210204145033.136755-5-peterx@redhat.com>
 <d45d4ce3-f386-708b-0f7a-4950df6721d9@oracle.com>
 <20210205014328.GW6468@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4344397d-cf08-b502-d5ff-76f19e778dfe@oracle.com>
Date:   Thu, 4 Feb 2021 21:11:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210205014328.GW6468@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:300:93::27) To MWHPR10MB1389.namprd10.prod.outlook.com
 (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0065.namprd17.prod.outlook.com (2603:10b6:300:93::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Fri, 5 Feb 2021 05:11:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39212ec2-2097-4cc9-12f5-08d8c9947c6a
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2173:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2173B5301462CC820CF957DFE2B29@MWHPR1001MB2173.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qsdZwLTCQzypIMjH3D+k2ENwS5HVy9yuMthaBk52Tjg5yUmyzCHebJOrW1O0BHVbUK5k/ouwAFpXCuRgpmND1Z+pf8ScaKTOYGfc7+sUWN+zt8cOCbP/ofjpLS6OrE6tqPwSfV1AEXeNxEnMMQI/G4Tp8kz3vhnFmwVM3YhYB5zKBB2s6+b4WK1mvejXL+rgb5lfcUVKjXB2Ce/Lefl4ZUpuT1bQZzDM7fjxvBe3rHEdBGmZf1AS+5/DJVXLydHuwHtC5Yz119XsD7criwbWB13x3N8K4j8VZ87D3Uf6WtxymhYlzLBOs985EjA7qF9PYdWLkQG21tdO7kXdEOogP1c/tdY9LgPBjNL5jyBsD9pitmIeuB7QyAicBJNsf6jt3VEJD3PcdPKx/tn78zh8CGXDp6tSFeGgp+d2tEbUZPz32zOTsr3jmDhSXuYV6t4kwK7zewrhoBiRbtvJ8ecL7FPB60m/gmuL2p+np1cEprGtYACVg/ru9mGrnD3/y6P14jW0NDaLxyzfLI386h6ND/YlvmxFaU/xGlMt61sNUKnNuShxWeGxgJRsb0jkPdtdPa6GXmMxySFrwFOouWF5GNMBmy0dXjGSMJBGgpEPzXs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(366004)(39860400002)(376002)(44832011)(54906003)(8676002)(86362001)(2906002)(5660300002)(53546011)(16576012)(31686004)(16526019)(8936002)(26005)(36756003)(186003)(478600001)(7416002)(6486002)(6916009)(316002)(66476007)(66556008)(52116002)(83380400001)(66946007)(4326008)(956004)(31696002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UndHMU0zUnpzUTZzbnZ4TS8wbEswTkNEQzlxT3FaRGxtU2IxeW1rUDhiUVBn?=
 =?utf-8?B?ck5FZzIvKzgvLzlaZkxqMXk3WHpZY1dXbUM2aWw5aWdSQktzWEFhcTlPeFF6?=
 =?utf-8?B?MWJ1aVlPcjRXTVNGSjNuOXI5bTVaMzZ1dFo1NUtvVnlYbUhGRjhMdnRTbkpx?=
 =?utf-8?B?RWJ1ZmlCaGhsNUJYZzNYcGxSeW8zdEVrRXhUZmZZcWNPcXcyaTB6Mi9rODVC?=
 =?utf-8?B?SWVBeWFwMFlEbzcxTkF3dzR2ZTFKcFVOM2dHUHJXcnRpc3VhT0xjM0hzMDlJ?=
 =?utf-8?B?bHRnejlNNTQxQWtVZjlER2JoaDFqbnRQbURka3VJQlZTK0F4LytHUWtYZVAx?=
 =?utf-8?B?cmhZeUlvTExVYk5qVTFlRnZ6OFBCS0Z0Y25yelQ1ZzV2djRwQURvV2NXcFQz?=
 =?utf-8?B?MEgrREtGeC9LYWJxUGI0c0h3eWtEdXJ0QmRYQ2tlVjRYeVJEc1lUMGcwakpV?=
 =?utf-8?B?K2NXaVhVQ1ZZL1ZicEZZTzhjQjRJc1FtMTkzTjR2SXhjdU55T3FvcjQwU2kw?=
 =?utf-8?B?Skg2MTNzc2lGa2ZCMW1BaSt4dU9aRUc4SlhjcTY0R0IzV0RGaE9sVU0wR2JI?=
 =?utf-8?B?cGRIbHlsTnFqTDZ3NHJHRExmM25pTGsyM0lKVEQxODE1dmFNZnZXWEw4SFVV?=
 =?utf-8?B?T25VMGdmVTlCV0hDcFZ3Tk9VWWlzMjdpOEgybWpqRWg3ajc4NU92K3RJYm41?=
 =?utf-8?B?OE9IZGxna0lpakRuRnc2Z0dqODJiT0Vra2RYTmRuSGpKaGx3MXVNVVlycnhv?=
 =?utf-8?B?RzN6cDVDVEJWMTRrNHo0aGxFZk43c29PamU2K2huaGZoYUQxbVBybU9qNTJF?=
 =?utf-8?B?MGtaN3kxQ2hnZjNud2szd1M3U05mdzhjTUxIaE4vK3lZaC9yeVhzaTN6cStL?=
 =?utf-8?B?VE50STVlSy9OQ21menQ2MDh3Z21qd1ArR2FiQStOMytzWUFpRkJ4SHk0cGgw?=
 =?utf-8?B?NlNiRHpjMmtFVkxzVlo5TkZZYkhqa0hJU1gxUnRRc1pSRUxjT2dwSEFhM0ZI?=
 =?utf-8?B?WnJaUTJna0NpRDdKdExreTVMMHkwWDRQS0p2bE1TV1ppRjlXVU5RM0xVZTZF?=
 =?utf-8?B?RHNYRWU1NzlKQWIzQ3RORDM2VHE2U3piSXVGNFlWWm85MDBncnZPN3V3ck9Z?=
 =?utf-8?B?Qm1kbWNUbTh0dFpRS2pBV3FxTGhaU1RBRFI2QlB1bTlHc0pMUlhxMXk0b0Y4?=
 =?utf-8?B?QlpsMWVmN2JVUmNZN1ZrYmRKVEFiVHhpMm9NWmVLbHZpNFFKRUdrUVBsZVNr?=
 =?utf-8?B?c2dJcG1JR2ZXSThUUTZNOW40K3BWV1hCSG5sSU1ISGhuRXRQRGxKTGRyaE1p?=
 =?utf-8?B?QVBoamZPS3VrKytmUm4vZXRKT0NDZ0grMXdoZmhrYnh1aHFwQkxYWStBL3A5?=
 =?utf-8?B?V2Q4d25peUYrbjErR01JeFdTanVIejV2blQvWWo2bmtZRXR1NFZHcUcrY2Nw?=
 =?utf-8?B?eHd0bHlFRFFvNFVZcm9QM1BudkU0YzY4ZmFXOUcvcnljY1FPWU9xWXQrN1l1?=
 =?utf-8?B?N1NrVkVwMEd1UFBqN2VnWXpUb01RVmtTYUFLa05BdVltTTJ4dmVGR1pZeHdQ?=
 =?utf-8?B?aWxZWWRiL3RQcjgrN0VjbnMzbXhkNk9rYnlvMnNMdHBleStYQy9laitKQ2dr?=
 =?utf-8?B?cXMwL2FUSkhFb2VlTjNHZmRlZ0s1RGpHZXJkdU00ZDZjd3VCN0gzanlXL2Fj?=
 =?utf-8?B?Z1JFMjlVaHhmMGZnS1Bjd2dVcElKUzdFUG5WeUhmRXV4Wml5NitVOFFxei9s?=
 =?utf-8?Q?f2Dz1y/C+n9ooRbSDmILzNkWpmlrMTVTgdvZtsR?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39212ec2-2097-4cc9-12f5-08d8c9947c6a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2021 05:11:25.6842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Atj1WClbtMa3CfX9YLWWAN1SOrFfUHnyrYOFyZPOdma/IUjTOMqY+JU2k/FCBmyYHOIkA8puYktvYPtXcEv9Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2173
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102050034
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9885 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102050034
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/21 5:43 PM, Peter Xu wrote:
> On Thu, Feb 04, 2021 at 03:25:37PM -0800, Mike Kravetz wrote:
>> On 2/4/21 6:50 AM, Peter Xu wrote:
>>> This is the last missing piece of the COW-during-fork effort when there're
>>> pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
>>> pinned pages during fork() for ptes", 2020-09-27) for more information, since
>>> we do similar things here rather than pte this time, but just for hugetlb.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  mm/hugetlb.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++-----
>>>  1 file changed, 56 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 9e6ea96bf33b..5793936e00ef 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> +	__SetPageUptodate(new_page);
>>> +	ClearPagePrivate(new_page);
>>> +	set_page_huge_active(new_page);
>>
>> Code to replace the above ClearPagePrivate and set_page_huge_active is
>> in Andrew's tree.  With changes in Andrew's tree, this would be:
>>
>> 	ClearHPageRestoreReserve(new_page);
>> 	SetHPageMigratable(new_page);
> 
> Indeed these names are much better than using the default ones.  At the
> meantime I'll rebase to linux-next/akpm.  Sorry it's always not easy for me to
> find the right branch...

No worries.  I only know because I recently changed these.

...
>>> @@ -3787,7 +3803,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>>>  		dst_entry = huge_ptep_get(dst_pte);
>>>  		if ((dst_pte == src_pte) || !huge_pte_none(dst_entry))
>>>  			continue;
>>> -
>>> +again:
>>>  		dst_ptl = huge_pte_lock(h, dst, dst_pte);
>>>  		src_ptl = huge_pte_lockptr(h, src, src_pte);
>>>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> 
> Side question: Mike, do you know why we need this lock_nested()?  Could the src
> lock be taken due to any reason already?  It confused me when I read the chunk.

I see that it was added with commit 4647875819aa.  That was when huge pages
used the single per-mm ptl.  Lockdep seemed to complain about taking
&mm->page_table_lock twice.   Certainly, source and destination mm can not
be the same.  Right?  I do not have the full history, but it 'looks' like
lockdep might have been confused and this was added to keep it quiet.

BTW - Copy page range for 'normal' pages has the same spin_lock_nested().
-- 
Mike Kravetz
