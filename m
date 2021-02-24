Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78F832355D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 02:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhBXBfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 20:35:07 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33502 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhBXBct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 20:32:49 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O1Obr2114691;
        Wed, 24 Feb 2021 01:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oQVyN/zIrnq00RCKGOHcfbxMX9Zv4k+/DopKMC9a0Lo=;
 b=VXbf2EThAtzpavpzt+umi7+xVlXy4CVEFTsOWwDoCnZKlNTCw0PocQY98xUrA9D1wZw1
 ZJFMNrTxnpiyJ+2OQyCFCSIShBFz4vmrhFCNZtIEX1BlkpILxTDnfA+y8KwMISlpdrVV
 DfM077o8jqODVvwTRlsRH+t7cQ5Xdqh2jbjVSDvQxCpVX2G9OM8Qa6ZucON0VNTs4xuX
 qHP3seXWYfwDEwmDUdf4/S8S021rsiPQ5kQL7pYe8Uj1uuRpOKPmhxtQKFb/w7zse1OZ
 ZAE811VojqEYt3DnRscgE3AAEmfrkKZcrq7fJGV9h5lg39jPQU1ggMgrFmd3yp4vrvFp IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 36ugq3g79v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 01:29:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O1Q7XL144846;
        Wed, 24 Feb 2021 01:29:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by userp3020.oracle.com with ESMTP id 36uc6sg7du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 01:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrbaP/GzZAzbtN+zw58qCOu0WgCxJbZOrW1ZKVCx0Xzq7Zme3U9UGHVTpHX0wZI5N8wgaXDssAU2f3FqRUOFx+29OqncIa98vAXl2U39xW18RymdAipsXxsbs3dzeAjf67rmcY/NkDjJ6m1ab98K8HybitxvX0jb/7++jx/IqodyLGGucjv11X1XDGAUlePVJ4FlTl0+XoWWY9DPNnMKkVaBjKuADUBKpRaBbiYi4m54VntOEyQp12d0ItoYP3a+suWJ7LvsjySwFWfKFhVC/IUVG1OaVITSWVHUvLXLjTJ63+CZQq/TolizQtoh3gB9kPsvSpiaaoIi/Dmf1eKb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQVyN/zIrnq00RCKGOHcfbxMX9Zv4k+/DopKMC9a0Lo=;
 b=ei5jKpGsDCwk70h5sVDC5inCt2DUGsZEzfOFt/Lf5djTHx064iN+zDcuHQBF2bkRYnvuAwC7ilGPDlTxxPOQ+4SIrXKQqeec1KONz8PJ/z1XEtqUXEo0kWTl2vPRUwNI/UukmHV009d19/dkkM/sfVsHV3YRe5kL9BUS26fiDQJM/5f6NGGvSVF7PkCH7idueoG60lFuVsXVGRvErdmdYUB/oYm4xN/ZNpZqQG1aOV1lXidY7maWS7YN7bGygx5gzImT4wIWuqb23VaTQFvWvwTW+Yf103e/pthCmEhccAr4bgBcL8qKsGgRcg/k8/N7/I2e4QAWXDZrb5svw8MFsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQVyN/zIrnq00RCKGOHcfbxMX9Zv4k+/DopKMC9a0Lo=;
 b=gCHKNSmaE941CbOFknpMdVxTUir8sMsYi845oJWx6d9bHVO4sjAoTcvQp/KEfJcoNqgLYul221H1tEwhL4wx8j23Ax2yJuljsA26cPArZ0oCWByCr7WT7dUm3rQMPUu22cYFjGypr9BzV6vh1iUff6zWelboURsZqemBtTWlhJw=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3811.namprd10.prod.outlook.com (2603:10b6:a03:1fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Wed, 24 Feb
 2021 01:29:50 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%5]) with mapi id 15.20.3868.032; Wed, 24 Feb 2021
 01:29:50 +0000
Subject: Re: [RFC] linux-next panic in hugepage_subpool_put_pages()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20210223155740.553df3ee@thinkpad>
 <3c536d3c-a180-301b-5cb7-c737a178a9d7@oracle.com>
 <20210223155806.8e2284682df5d08ce9b3da68@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <44d50df7-9940-6a37-179f-ee2aa6cf34b9@oracle.com>
Date:   Tue, 23 Feb 2021 17:29:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210223155806.8e2284682df5d08ce9b3da68@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR14CA0035.namprd14.prod.outlook.com
 (2603:10b6:300:12b::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR14CA0035.namprd14.prod.outlook.com (2603:10b6:300:12b::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 24 Feb 2021 01:29:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e69c6fdc-7961-4031-42c6-08d8d863ad8f
X-MS-TrafficTypeDiagnostic: BY5PR10MB3811:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3811D57F04F083403A7FBADDE29F9@BY5PR10MB3811.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0UhKvhbJ8fnAZT858QHktntamRrYs4ZBMWAb37rnEZ77b1Q9Zp20IBxNcuCacVJwyWW3RYUqURi07lJMjRpZqP15Dd2McQioZnD2SNTKG1SgXVaKlD0yF/mumaw/4oLESnZiIDSFTK7IDSAbJC5ximnbbUJC0UD1+k02DUybyYdqGbHDH1oWw/PT5l5kGbSsNT2GowQTaD64o+VOidZI9UXtTrZboo1yF1DOZ9A6JoWG+RUM/5RZD4AwvrsX1pqhHhEDeB8VbSjDVe87mpoTrib2IDT4wZUaBecesVybTh/a+SMI5iWRpXWnl1IcHD+ehUwIwwVrk3H/AZo+qCd+nP9hwZv5lTOYB2HINfN3VHz3uFXS6t8huN/gUCkXvuy+y27r6bq8jMRPQUq3JTQyP0S3a7KRrHvwHxhjdjxb3/vazy/NUDpCPE0pM6Qd7D5DIhnXGniRMkp7yqkhNocKMK3SxQbALElRLEAUrNCC6TS8vrTo17qZpDt7O+obajrh/UMSoRxvlM7FLvxTKa4X+I7rU6UE9SIbpoqUlEMgb5rgSCphseeaWiZUDLKCrVu5M4jnpytBmQyn7lscL1ubr85JjZa/cj53ITWF87/ResMLPi1y2AjjKn3JGF98tgTlMBGzFhldTkVkkji5uEdwY94SipuwYHUxeUjjkPOf74xwjHr5/lMqMQIBmzVlV2w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(136003)(376002)(39860400002)(83380400001)(316002)(66946007)(8676002)(36756003)(66556008)(44832011)(966005)(186003)(66476007)(26005)(31696002)(53546011)(2906002)(5660300002)(86362001)(4326008)(956004)(16526019)(16576012)(52116002)(8936002)(6916009)(2616005)(54906003)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cy9yVG01QjRWYmRIaHlUYUJUMXlQVEpENEs3U3RzU3FUKzBMUDJZU2JMdm96?=
 =?utf-8?B?S1IxUFZMMU80NzNXRWJJc25yTWxWYkN3RmVwVHRJWUhVbENpOTZmVGFRTVRl?=
 =?utf-8?B?QkZ2V2FtT0xWblFOZ1ZxTy9zeEo1SDVzTnBQRXpheFcxcDZKMzVyZ0YvVG5u?=
 =?utf-8?B?dmdjcncvNUIvMHIvUnlaOFRNWXlFVVNJQ2EzSVpEamlxRVJ3dlpjbExCY1B6?=
 =?utf-8?B?SzlPaWlrekxVcHBwdzZDTnZ4am80bEQ5U3FCdXhtMUtnOE1wWStURG1VSmVs?=
 =?utf-8?B?NHR0TVU0akVpelNtRG9hS2labmFxbzJDUTRRYlF2S0l3M3Rka1RvWmhGejFw?=
 =?utf-8?B?d2swOVpKRDlwNTZZR1BaTm1ObnBGTkZyQVh6bmZYZHFsY3VsN1NNQXZXNmVt?=
 =?utf-8?B?a0Q3ZlJkcmp0NXNHN3luVWp3ZXVRYllsblJsMzRtMlQzRGdVWFlVTkZzT2tI?=
 =?utf-8?B?MGtQZEM4ZTdFWEtSMURibDZVYVJNdDUzNWJzaElPcE50NDdQb1VCckVpS1RE?=
 =?utf-8?B?ZWFGd0lzckN4Zm1MbVBtVWt5dTRrN1ljNlJtWFh6eG91akRnZVN3SzZycCtL?=
 =?utf-8?B?WElsdHhUV0NBNUZzVjhZdENySU9uanZoMlNNV1I1NFJGd1Z1eEY1RXY5TGdt?=
 =?utf-8?B?Qi9hTTY3c0wzVnZISjRmRXdpblhNK00zR2dPcUpKL3FoclpMUEl1L2NnclZK?=
 =?utf-8?B?QUNMV1ZDTlpSNys0SkZlK3N3aXlrSnM0R2ZyQ1JmdldySGpaMW9vNWM2eWFv?=
 =?utf-8?B?VGhYOVdmNkoyb0prYjZ5MFhqZzVUcUl4RUx1WVhLU3UwU3dkWFlQeVJDNlR4?=
 =?utf-8?B?U0RwcDU5akptdXk3dE1uNVNrSFNFaE1pNDc0UC9ZVXdYdHQrNzFXQXFtaFR6?=
 =?utf-8?B?WFF3M3RmSU1MZS8wRGhTL2c2eVV6ODJDYzR2T04zaENkYWwwSGk1Q01SSnlz?=
 =?utf-8?B?WjRWMTlFcWlZNjhTOGlmNUVucEhnc3NvTklyQkpyaG54ODFyRjIzektCZ016?=
 =?utf-8?B?b0pseDBTNEFoc3FzN2RmdnRwcFl1N2ZWd3kxSWxXaXo2YlE2MCs0SGxzUCtV?=
 =?utf-8?B?Y3FhRlE4TDh0WXQ3ZkhQc3VPYlBBVUs2eFI5eTZ1QUZwNHlEYU1LMkNXMFI5?=
 =?utf-8?B?TC9GZHk1VHVTUWRmTVBVdDBjTTgzeG4rMGdKTkdsOC93SkNXZEE3SnBkM2VX?=
 =?utf-8?B?NDJaNWljS2hTMVVvelFSWVZBL1FBQWNpY0VCcERqS2RlK09XRmF2WUQwSmZC?=
 =?utf-8?B?T1dEK3BGMVBYWG1LMkVhWUxvK1RmV1ZTQ3oxNU9DZWh6UjBHRkJpWHlRS255?=
 =?utf-8?B?Y3RsVGo2a2d3TEo2Nkh2Yk45TFZsVm9vbHBhOEZSWFBSajhBSzM5WU5hNkQy?=
 =?utf-8?B?emY5ZGJLZ3BLOVNhS08wSU1GdXBNNmpyelJYZndtbFNVMVFoM1h3d0hiOVRm?=
 =?utf-8?B?TmpZNXlOUktNUDllZ3hxd0Jta0hYQVhSZVhxOU9WUGt4TmRTeDF5RFUwVStn?=
 =?utf-8?B?Sm5ncnhtY25xUyt5RkoyYlZFVXF2MTVkck52SE11czVqWENWcTJBdGhTMWhv?=
 =?utf-8?B?Ris3bU9GZFVGZHgrN0N2clFPelFndTNKbUJSaVZ6T3FoRzV6cEE2MkkyNkJz?=
 =?utf-8?B?dFI1Y3RzMkFKQ3ZjSEhmbmVESjF1M05taXdMRXdqQlhRbkpFNWVOelJqZlZS?=
 =?utf-8?B?bjUyU0lJQzY1TmVvUExCT2pDWU9PRElDdFVzcTJYZVphbTQ2VnRnY1ZIempT?=
 =?utf-8?Q?yWy7ibRgWFdfciZXCfawt0X5vbfKHJL9Br5YD4D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e69c6fdc-7961-4031-42c6-08d8d863ad8f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 01:29:50.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MY0W8n0XuZKlHID5TE0JLYimE8T/TFHPgNMRGfvirjFzwY8BdISaDqtOx1YfaU3+Yak0oe6MFK4B9Qf+MLAdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3811
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240008
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/21 3:58 PM, Andrew Morton wrote:
> On Tue, 23 Feb 2021 10:06:12 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> On 2/23/21 6:57 AM, Gerald Schaefer wrote:
>>> Hi,
>>>
>>> LTP triggered a panic on s390 in hugepage_subpool_put_pages() with
>>> linux-next 5.12.0-20210222, see below.
>>>
>>> It crashes on the spin_lock(&spool->lock) at the beginning, because the
>>> passed-in *spool points to 0000004e00000000, which is not addressable
>>> memory. It rather looks like some flags and not a proper address. I suspect
>>> some relation to the recent rework in that area, e.g. commit f1280272ae4d
>>> ("hugetlb: use page.private for hugetlb specific page flags").
>>>
>>> __free_huge_page() calls hugepage_subpool_put_pages() and takes *spool from
>>> hugetlb_page_subpool(page), which was changed by that commit to use
>>> page[1]->private now.
>>>
>>
>> Thanks Gerald,
>>
>> Yes, I believe f1280272ae4d is the root cause of this issue.  In that
>> commit, the subpool pointer was moved from page->private of the head
>> page to page->private of the first subpage.  The page allocator will
>> initialize (zero) the private field of the head page, but not that of
>> subpages.  So, that bad subpool pointer is likely an old page->private
>> value for the page.
>>
>> That strange call path from set_max_huge_pages to __free_huge_page is
>> actually how the code puts newly allocated pages on it's interfal free
>> list.  
>>
>> I will do a bit more verification and put together a patch (it should
>> be simple).
> 
> There's also Michel's documentation request:
> https://lkml.kernel.org/r/20210127102645.GH827@dhcp22.suse.cz
> 

Thanks Andrew, I forgot about that.

It looks like the patch which added synchronization documentation requested
by Michal may not have be picked up.
https://lore.kernel.org/linux-mm/9183032f-3d77-d9e3-9cc8-fbaf3e892022@oracle.com/

If you still need to add that patch, I could redo and add the page[1]->private
documentation request mentioned here.  Just let me know what is the easiest for
you.
-- 
Mike Kravetz
