Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984573145BB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBIBkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:40:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42662 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhBIBhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:37:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1191K5cq056180;
        Tue, 9 Feb 2021 01:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hYBSai4PKTRMqvRe0NEqshRXKI4aJmwzfUfhReuKyWY=;
 b=JGo8qiNo6ZbbClk0itleGiEe/V8DGWJ87KPvEpcYM5sJN83UR8Fk8tziurwfdEQKkddv
 xHxt99BAgyicaklT3uMGvQAkLEEIyT5BCiHnObhSZJWeeoBTYrcQXe//vbpTUBTqG0hi
 H451yVAmKtpve/DVWEV4NN1e03YnNVr4i4EmeYMpdywIPzGi3EiKCdxjy76//u/NckZy
 QpxhBUzRYvcyYsV3LeUHTjI8PpjL6ua88VfPrC+R+sbJiurgIfQTuArq/fcIDQBbjr9Z
 mQBP0mE3sX+dCXmpG4kMSn8VIhJwTu3ERRM68w9EkkFUrjnQk7DXtIrIJPQONQUGXwSf gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 36hgmae2c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 01:36:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1191K9CS155545;
        Tue, 9 Feb 2021 01:36:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 36j4pn1smr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 01:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIZrOfOxrL+eHfsJqZn5FF6b0K2TiNF6DS9JA6kVo3DZhD4cGEiCjxeSNXycXf8h54mbdlXuRUoyOPykc+mWMAjjBBkkjopsPFeJ3h0iefkasa00InvnqBi75tiKL/7L8ZwH5TKDIPDtQ0q4SSjfVG7XOVFeK3F+SGXfKT4dopDaAqLCUWjTqN/mkmwJTxUWY6fJYHLr8UarN3ZQwzxdEp53bAO2pTxxua4xu7otX/IMlWOM0oPrM2z0qaEEl8UapO8ma8VthCe9gakIPmrxCowWLTY/Pkys9LJ66tuRxfQLzR+7koNeZ6CtbfNJjMg16mprVvdzeZ62W4xsZzeNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYBSai4PKTRMqvRe0NEqshRXKI4aJmwzfUfhReuKyWY=;
 b=MDJ0npTH2pSqkBDLaAmlFztDXBZ7tFYLbf2NN1MeV6SsgPoQi1gfTME97oSDAzU1OpiehI1+9jO8fGf5CSh/Q+Bc4U12a4u28OIxOe4YGJ96uCh+wlniUwfpLTKYAPEBxD2WgDdanp+ngtVG8ud4Vre8GNCWAi07nosdeSoVunEmSWSoIAZS1AJD0QyU6c7M8oX9oAUMG8dUcbK09U4gEqHtpwKIHZdfi9zeNfr97/E6UXUrNy7ZfGI5OgT7UBtrH015yplibs2yUTA3/NL56bjs/Y+oot8GXnViO4Do3KIFREGgb+miiLgJx5uQixwWKhJO+IkKUVfcGOVN+EGqGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYBSai4PKTRMqvRe0NEqshRXKI4aJmwzfUfhReuKyWY=;
 b=H6SZJFLuUGp78J9tcn1ku8mIxLVm+dKBAtuP8ZOqjMsRkWLqxVDT/NCTW8zE6mexuOaB6tsoiTx3OR3qOT9gW8v4Bgo38J+F9H51pgZhz4Rfqw/LufxDmCvxIoszAAbYWigw/vZ5x4Vsvqod1m8yCsBoVN9HGfybucl+uqkay3Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
 by CO1PR10MB4418.namprd10.prod.outlook.com (2603:10b6:303:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 9 Feb
 2021 01:36:42 +0000
Received: from MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074]) by MWHPR10MB1389.namprd10.prod.outlook.com
 ([fe80::897d:a360:92db:3074%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 01:36:42 +0000
Subject: Re: [PATCH] mm/hugetlb: use helper huge_page_size() to get hugepage
 size
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210208082450.15716-1-linmiaohe@huawei.com>
 <3752cc85-06d1-5af7-8baf-2810c98524d3@oracle.com>
 <f7aee85c-d320-5127-35b3-77a53db6a00f@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4fac6900-3685-abd6-964f-8fa436f97c43@oracle.com>
Date:   Mon, 8 Feb 2021 17:36:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <f7aee85c-d320-5127-35b3-77a53db6a00f@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30)
 To MWHPR10MB1389.namprd10.prod.outlook.com (2603:10b6:300:21::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Tue, 9 Feb 2021 01:36:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35a4a5b0-0805-4846-3aa8-08d8cc9b26d0
X-MS-TrafficTypeDiagnostic: CO1PR10MB4418:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4418F17CD6628A3C44619C52E28E9@CO1PR10MB4418.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bSEW9StY99qosu4o6LOFIveZAvpYOG42+iFpOJ/ma/x0t7tYrV+DpyxL1a6a0/Z6e+uw++JcAfE0YepC/bNckAtjpbdcjNmzhRf5okn0AQJpPDu3vekopjFtfg2WIwp73wFN86lBd96EMSpujlKDoV5IPRq5kAmYs7uAuP+iTCRNWnsAFp3T1a+rFmBkr1DOEyoU9+ZLZTODS6NfvrcKWDZQ4Y7+UqRyI4rmbQOj8ejKyfm1kybXyFLcPWEgFdB9QFawf64BzkSOIYFfua7IYJEPLUvcz8HzKon7+A7mzr8W7Jm3gGbWyXN16/AUncAJYG8JV9WfSJt/ZWJLOeAtyfUwsjOEJNWa9LE7ZCwY5mjIMo5V31mz7olFeZHZCfjw6FinI0DsprIQxS5tAXRmQ5u4Pe94ELXIQRIapaQ1h77rXELvEDylxPYA320RZIk9zioQrmcfgTL/Z33zNyGw8FGf+klYYDBJkQDAFbCMfRYhu0I8Ql7oYZAOt7XAtbAfYMJu5pCJkKMQ6b62Xz9treJer7HVCga9Eld248YTSRmbQiyIgAgE4/7tEBx+PrVKZtRuIOYzIdeQpY9nvXNs71YLw9bPXz+oVgTiqZt8hWyfUYX9PSU46d+Ac9yMQx/D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1389.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(2906002)(66476007)(44832011)(2616005)(36756003)(956004)(66946007)(5660300002)(8936002)(53546011)(83380400001)(186003)(66556008)(8676002)(6486002)(16526019)(316002)(52116002)(86362001)(478600001)(31696002)(31686004)(16576012)(4326008)(26005)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QWhBZmJMOC84MFdoa2pyemVQalAxQTQ5OVlEZ3ZvWXFXdHFlaE5WcFFLR0N5?=
 =?utf-8?B?ZFJIdkVnVlRjcDlDY3NhL21zVDg5emgyTWtVdmJtb0RoQ0lYNzBjOGlUL0VU?=
 =?utf-8?B?bE9xbldweXBsTDlqSThFSGV3TjB1ZmlOVVhzOXBjK2RXQi9PQUV6ZmhzK2w5?=
 =?utf-8?B?cXBYTmZMQ2NOTXFWcmUzeW1JOXNydWFid1hQVUVXeTRyTlNwQ3c3SGorM0JT?=
 =?utf-8?B?emk3c1RtU0VvblNwVkxFR0grZUJDb2hqcno0ay92em56MmxVcStNbElKVTFz?=
 =?utf-8?B?cEJkR1RYRlYzR09mLzdtQXBUUStXN2tmU000YnY0MFNNMDJHRyt5OGljclJp?=
 =?utf-8?B?MzlzRGVKTnpzZDNLUlJ3RnVGRklKdVJHM0JaN0Q2ZWlpNWt6Ukd0T2J0cnIy?=
 =?utf-8?B?LzM0WlNKTExpSDZEWGQvYkNNWWh3cjJBU2QwVHE5ZWJrSUxjTFVmQVRJL3JD?=
 =?utf-8?B?Wm9salpXOGgvMTlaRmtnakNKMVlrN3RIMm1RN2EvWmdGMThhUUIvNGt5Sk8r?=
 =?utf-8?B?NFhORmFHNURIMVowUWpId21KWDhBMk5OejdUMmZia1pHSFA5WHVPL2szb1lk?=
 =?utf-8?B?c09zWWV4VThvczFVYTA1dDcxbllHQU93VTRkYURyY0hSaDdld0NpMmhQSjlx?=
 =?utf-8?B?SExROGtWQjJldy9PODFwd3BLdHh4MVY0UGxhUmhBaTNydGgyNFhLU2tKQ1Yw?=
 =?utf-8?B?Q2lFZ3FGbE9QNXRGK21TUklWL3hMNC9uRlFrY1g2STRCYmlpRnFGaXpQa0VK?=
 =?utf-8?B?MThrVktIeFFsbUkrVG9IRU5jRkphakpWcUdiMjhuQnl5WE53REJGVjk1NWEz?=
 =?utf-8?B?WWlyV1IwWW1oVFhKWDJkNEhlU3RoZU1OU2hMWW1lY3E3QW9BYW5OeWZ3djhS?=
 =?utf-8?B?L1c4N2NvbisrOHRTdzZocmp4L3RtWURoQWxIend1VEM1MW5JQlBoM1N0V3FB?=
 =?utf-8?B?b2Q3S1ZjcnQ5dDkxbjhDTTdQbldNWldYYys5WDlmOTAzZUs3WDB1NW5pMzUx?=
 =?utf-8?B?RFB4WXB1MzFwS0QycVRYL2NjaE1DSjRIdUxYOEZ6UGMrSDgySzdFRGZBeFRJ?=
 =?utf-8?B?ZC92N2FvL1gzSTdjQ1FaZEdWYThraVBVUnkxanNWZEFUWWl5b2NKUUVPTXd3?=
 =?utf-8?B?SjNBWE4ycmxyT3U0SU5zYk0zTmpXcU1USFVJaFNOVnlJSnRha1JGZk5NbzNr?=
 =?utf-8?B?QVBYRVlvRE5RZkFUdGhaMGkycXhQbHBrUWpBNWs3bVpQMXY0bU5EWStKZk52?=
 =?utf-8?B?b3o3ZW93SWxDZjJCTDF5TE9RTGFJUXVzUzE4WEU1SjBXVmFka1doQ2c3RnZS?=
 =?utf-8?B?VlpITUNDR25MNXlWMmszcGxBbmNqSDVwWUtrRzljUjRYMnZsdi9ZN0ZNYWxT?=
 =?utf-8?B?RkNBdGhDWUhRM3RUVmJiNXc1R2Q3SXBhTDZtSUFYR3o2N1RMblYwbVAxMWdy?=
 =?utf-8?B?eTR4a29XMnNuNWErcHZhamx3a2NkUStpbVk2VitEeVo5QU5WTUJ3TnU0MmdC?=
 =?utf-8?B?aW5PV0tUV3h3UWFvZ1B5M1l1Zm5ydE85elVsdktuT3pZaEVlcHVxSVNrazcx?=
 =?utf-8?B?YlJNUEh2OXoyRGJjRGRLckw3UmFNREVGOE9NeXFBQ3pjQ3V2VCtEWlppUXYr?=
 =?utf-8?B?d0pVZ096QW5OaGt3WFRFYWJqWG8wQUo4ZXN3c0x3ay9zY3pxRVNCOCtSWkRV?=
 =?utf-8?B?Q2ZmMkhYL3lheEt5YjNqcUpjMEQweS94UklLU3NDSlZVTmZ5eHYxYkUxcWRJ?=
 =?utf-8?Q?4Qc63MS70M1OYFsUyMiaGiNOyywR1BM/SVYVoUJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a4a5b0-0805-4846-3aa8-08d8cc9b26d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1389.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 01:36:41.8671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HT4HbbQuJPWolTzFvZc1jZvm8RPqvAKI0URBejHceHMN6y+JCGgHnWZqzj7AyXSJA3j4aGkLxpwYau7lILA9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4418
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102090002
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9889 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090002
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/21 5:24 PM, Miaohe Lin wrote:
> Hi：
> On 2021/2/9 8:45, Mike Kravetz wrote:
>> On 2/8/21 12:24 AM, Miaohe Lin wrote:
>>> We can use helper huge_page_size() to get the hugepage size directly to
>>> simplify the code slightly.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/hugetlb.c | 14 ++++++--------
>>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 18628f8dbfb0..6cdb59d8f663 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -3199,7 +3199,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>>>  	BUG_ON(order == 0);
>>>  	h = &hstates[hugetlb_max_hstate++];
>>>  	h->order = order;
>>> -	h->mask = ~((1ULL << (order + PAGE_SHIFT)) - 1);
>>> +	h->mask = ~(huge_page_size(h) - 1);
>>>  	for (i = 0; i < MAX_NUMNODES; ++i)
>>>  		INIT_LIST_HEAD(&h->hugepage_freelists[i]);
>>>  	INIT_LIST_HEAD(&h->hugepage_activelist);
>>> @@ -3474,7 +3474,7 @@ void hugetlb_report_meminfo(struct seq_file *m)
>>>  	for_each_hstate(h) {
>>>  		unsigned long count = h->nr_huge_pages;
>>>  
>>> -		total += (PAGE_SIZE << huge_page_order(h)) * count;
>>> +		total += huge_page_size(h) * count;
>>>  
>>>  		if (h == &default_hstate)
>>>  			seq_printf(m,
>>> @@ -3487,10 +3487,10 @@ void hugetlb_report_meminfo(struct seq_file *m)
>>>  				   h->free_huge_pages,
>>>  				   h->resv_huge_pages,
>>>  				   h->surplus_huge_pages,
>>> -				   (PAGE_SIZE << huge_page_order(h)) / 1024);
>>> +				   huge_page_size(h) / SZ_1K);
>>>  	}
>>>  
>>> -	seq_printf(m, "Hugetlb:        %8lu kB\n", total / 1024);
>>> +	seq_printf(m, "Hugetlb:        %8lu kB\n", total / SZ_1K);
>>>  }
>>>  
>>>  int hugetlb_report_node_meminfo(char *buf, int len, int nid)
>>> @@ -3524,7 +3524,7 @@ void hugetlb_show_meminfo(void)
>>>  				h->nr_huge_pages_node[nid],
>>>  				h->free_huge_pages_node[nid],
>>>  				h->surplus_huge_pages_node[nid],
>>> -				1UL << (huge_page_order(h) + PAGE_SHIFT - 10));
>>> +				huge_page_size(h) >> 10);
>>
>> Should we change this to
>>
>> 				huge_page_size(h) / SZ_1K);
>>> as in hugetlb_report_meminfo above?  Or, is that one where it takes an
>> additional instruction to do the divide as opposed to the shift?  I would> rather add the instruction and keep everything consistent.
>>
> 
> Yes, it takes an additional instruction to do the divide as opposed to the shift. So I did not
> change this. But it seems keeping everything consistent in a function is more important. So should
> I send a V2 to change this or Andrew would kindly handle this ?

I would go ahead and put together a v2 and let Andrew decide how he wants
to handle it.  You can include,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks
-- 
Mike Kravetz
