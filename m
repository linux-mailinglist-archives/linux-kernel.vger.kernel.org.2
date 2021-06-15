Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F463A8890
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFOS37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:29:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31070 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhFOS36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:29:58 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FIMSup013418;
        Tue, 15 Jun 2021 18:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QoHWPI66FWYWkK/5q3gau/qEKy/QAADkFCQT7r0QTjM=;
 b=ON4g2QJiCMqBXeIgslc61w21aZuRagqaTVg/8QVh+uMUwRTsA6mDe9GlsoMO554kGGhc
 8F6GtYSYvYt5xjV7GYrE2sEjpM/XtxVLNHpfHYuiDZEdW5ohOt6iHSAA8hPPKveHwEmE
 wrkZ+y7kGPKpEySdJfqQ93eK4zgvScp5HBJwEfYOoyPtF5e8EzNrjN+n6ixLDIOh8pMK
 TrmYbVT9+LwoRs2JzoRNGaYZzWPJS+sIOac3Sdqk0MC3muGpveQFDaJjqoqy4qnoiTeA
 ZQ0bah4Epc/aqooelZrQyPm6viZwfI0srCNsKS3pqgx/hDSBuw2vMGU8Ubh3kzI1GTXy LA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 395y1ks694-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 18:27:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15FIFQP6055812;
        Tue, 15 Jun 2021 18:27:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by userp3020.oracle.com with ESMTP id 396wava5fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 18:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEuDAtExscYl5hR80NVjE5TZr2EOInLsmJkyyCKYEL8kElIGIMcGeWYxVtwltiJe6WbpMV3UL31PfIoMrKABvDNZFNXQpzTWVKDlHEMq9PpwNOmCroxL1PiGhz7CmsdTt4d3A+w8yKaFI/wxJFWrHr9fsWaaoh5hBlN8gYjgMXMe4Wm4Pi+o0yAsmG66wsiPkG+UHADt8yjK6nDd06kX3EK/R88+2AnPEf0PRQOTWcTGwsXMhtFFIlQHeTDtAy/8e+wl/r6y59l8WkAJqcxMwCWI/yBIcRbJTh5jp9xLsLIP1B80jgawY3uRmKHtvHGpBEZHMELF0f29oxLwAjOUuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoHWPI66FWYWkK/5q3gau/qEKy/QAADkFCQT7r0QTjM=;
 b=LbQlcjKHQG7pCag7ibg49kwkOnINOifRxL6WqpthZEbaYtivOTyOtr7vHNnnsdmvk8Yny1OqBseV7fw9oYRaoOivxZVyhUq5XI9m+ezBCOhlH9p70PxlrhRgEZNAqiT67UZHGPVrwcigdsPQkwdhufnyAREfl2EDDs/MkUnGMI258XG9L9ZYO/5yX5U2Wg7LJ7beDVuRvXMeDB/gUcVJnU9FqC4cUgORiLA/bnXvLpgwDVAMGhEnxryIFtWdAhZ69e523elwO7/CyUsz0O8ga+4sWJftZBU5Nf7EfSwE8bzPmMNE0rosRTA8uqYcchgI14yyiw49I+oSb9KLTTsq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoHWPI66FWYWkK/5q3gau/qEKy/QAADkFCQT7r0QTjM=;
 b=OpUoh37CyTIA+6gRBvqJ/sDLIWQ9T0fI92iIgag2d2gYVT9STpWkd9PCVTdqRsc4vHFYsHXPtzIqXQhBwKVm9oNhD21iakxAhESXFFne6IdpwGoezYC9WtyZQgQaa/t8LpAXJ7/OjuSu1qly/K1Fq0ZdFSoKLt2WkbRlyQ2YYvM=
Authentication-Results: shutemov.name; dkim=none (message not signed)
 header.d=none;shutemov.name; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3761.namprd10.prod.outlook.com (2603:10b6:a03:1ff::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 15 Jun
 2021 18:27:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 18:27:17 +0000
Subject: Re: page refcount race between prep_compound_gigantic_page() and
 __page_cache_add_speculative()?
To:     Matthew Wilcox <willy@infradead.org>, Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
References: <CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com>
 <YMifvD723USsnWRH@casper.infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <41f698d6-a099-105d-e922-170fbb3e1798@oracle.com>
Date:   Tue, 15 Jun 2021 11:27:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YMifvD723USsnWRH@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR20CA0017.namprd20.prod.outlook.com
 (2603:10b6:300:13d::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR20CA0017.namprd20.prod.outlook.com (2603:10b6:300:13d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 15 Jun 2021 18:27:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fb75eea-05fb-47c8-b152-08d9302b3433
X-MS-TrafficTypeDiagnostic: BY5PR10MB3761:
X-Microsoft-Antispam-PRVS: <BY5PR10MB376172BD818CDB0314C236CDE2309@BY5PR10MB3761.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tGj/RbdxE83oDKBx8lYQy2gkKYBE9vngvU71T6ICCakx4ie7OwEWxAhFs2pC7VSl97pJRJDSsZTShzIKasvqdOTx1Ca7OlNpyRaVtqW1bB5af5f9R9TnLNc5BZyh6HfzZcOvcpSs8DgaOOdN3l06bODSjx2VIT2Pz64vaStHmEP0dLOB/JvEJkZWO7syQ78Cg7ODGMYKVyoAkzvtPNvpW4KvIPbava6vWXkDvl8JCc8g4i/+xvWOcMNywSEhvwIksJDeFF2pn58ZhubXDWycKbgUNFMLcT5uDSJUtYU7dpuPnRu0WD+P3njCZiY/CQeQvRaSEXGwCptst1lGQrTUV8pZB4vqWZQXQtPSZWkpOxWWe2f9eHXR/th/0YBi9QiEbrU1CsR1xEg/L11Si77tThd+gN/LqeuN/W8jmK0e5+ILc74nz7Mg0Ifdp2yJaGcJ+f4R/8sdSO6nb3eigF+74TsZLkq43Ji6mL9tGiuinMYfuch/qt7rACm5RKlpl6L8Sf4eQXi8XvXN0T10+UCmkqdyx85OeNWtNMQthViJdxNmahEd93c4innUCOhKNcTsIpALF/6tjHTjVut7T3uDZ/2uok84+AS1vhM77jffptry5N9aZAfFtRqeTsEWw+kVY1hkWvZX4f6PlnVktPFI3dFe8Jp3UtY/QVGs3bQZ/jtepsl5vNDwXxfe8fLPlZcb3lRWGQOlPIq89nVFzJ5f6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(39860400002)(396003)(6486002)(956004)(44832011)(2616005)(110136005)(16576012)(8936002)(4326008)(66946007)(5660300002)(16526019)(186003)(53546011)(26005)(31686004)(316002)(54906003)(2906002)(66556008)(8676002)(52116002)(66476007)(83380400001)(31696002)(86362001)(478600001)(36756003)(38350700002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzdEU3lHTmdHenZKMVdaSE5JODNjZzdybk1tbEoxVGJIRU02Ym1POGJTdmZ5?=
 =?utf-8?B?ZVlhU3FCMis5SEF1OE5XK2RqWDNmbTBPa3lNZ1lnTDZJa05XdkVQUjZoMkdm?=
 =?utf-8?B?ZTZhazUyZUpGUU9hQUdpOEdJWldJLzkrbkwyQ3QrWkRsSHBmdGpqcGR2R1o5?=
 =?utf-8?B?blgzYld0VFM3MFhITk5lRnVVaHd2NG9GZUJZRG0vMG9yOUpValAxMjJ4MDFy?=
 =?utf-8?B?OGRBYUNlVjF5Wmd4Q0x0V0szbk9iUzh2ZjdnU1BEMndIWFNlUEQvbXdMb2NN?=
 =?utf-8?B?eGZpM1NIKzJpclZFSWJ4VVdmNFZCTmQ4TmFiRlZkT2VmWDJoSGE2eEFaWlJU?=
 =?utf-8?B?c1JWRkZzejBGa0tJaXo1NmpZMTRxaHpWcHZxa00xU2dRcXQxNStRcnRsMHhW?=
 =?utf-8?B?aHZjU1ZnMlNYVUo1UlpBbHNZek45bXdpR05nSTdKa3dlQnNJQmlmdWVwRVdB?=
 =?utf-8?B?bktkbys2TzVNdXB5RTA3NnRLdXNQU2haV3F1dGluRDF6bGZNVkRiVmswYlBF?=
 =?utf-8?B?OFdFUWNSYk1XbUlvcTBkZHJWM04xd0dkZmZrYjBETllkdTZFLzJZVkY0WXJH?=
 =?utf-8?B?QlFJb2Z0K2krNllacjBhbmd1TTRId21UcDFrMWpmcHZ4eWkwQzRCSW9wSlVo?=
 =?utf-8?B?SjBkQlEvWFlvK253TzJ3QkdnalRrTURiK1M2SysrRFY1bnJ3RGhlT1VHUGo2?=
 =?utf-8?B?TW9YRDd5MUFncitid3dnaFVGNHFIZFZyL1I2L21Dd3RHM1NiOHBYOHgrZTBa?=
 =?utf-8?B?UEhiaHJuSzFQcDAyZGZLRTRabXlSYTNqNFdIbzZLM2M4eHNLMDFCV0N5WVEx?=
 =?utf-8?B?blROVVE1QUNLdG81Y0hiTUZTcGVra3Y1blFlQ29MS1ZkYUdZUlhSUFM1amVk?=
 =?utf-8?B?T28zQy9yTkNYdkRvYnFmSGVOR1RTaGdhMjRhVFlmemk2L1Z2RVR3cjcvTHNC?=
 =?utf-8?B?Z1BZRjFFM2F0RjZXSDRzbTZHWUlEcXdIRkVTeXVLVEVZM0c4ckZPTlh5MVhx?=
 =?utf-8?B?NFI5VWNBRTFVWVFpSGVmMzFrMzRwUmo5aG5PcURhTmcxY3B6cWVkME1JS3Rz?=
 =?utf-8?B?OVloMHdIc0xjckIxWUdUY3FEMUhUM1lHWmlCWExWdU0zOWZTc2FqcUdYRlZ6?=
 =?utf-8?B?L0s4RXptWW15RCtYckJ3blNCbUE4MjBqZ2xKK29JMmdhVFVFeGxJOTgydXV4?=
 =?utf-8?B?bzZVQ3I5cjhmLzhSbVdVY25BemErK2RBZXgrRVNNaHVmN3pUYzVRaXpvS1ZM?=
 =?utf-8?B?YjR0Q3RXWHZvNVF4bFlsVlNxYldXQnFPK1N3T3JZZHlYS3VIOUVXcU1ScjE4?=
 =?utf-8?B?dGJtZWxvdTNjazdtY3VidUM0RmtFZFFhUFl1R0NSamVkZElzdDRkVEM4a25C?=
 =?utf-8?B?YWpkV1Y2dzJnOThMMGdCR1RmRTBsUEJtK0JSM09YU3k1bTVaRkZEYlZkRUVa?=
 =?utf-8?B?c05VWElYLzRkTHdVYUVCa2NoblRaSTJGOU5OWWRnLzhvQUhLSFFZY3Mwa1cw?=
 =?utf-8?B?ZklJM05XSG5DajZwL1ByV3gwMVlzVEh2ZGtQeWZ4VGl2WW9jTGgzOGJUY29T?=
 =?utf-8?B?bE5OYjNJVk9iSWtpdCtuSVZhamZqdGRSQXJXTk5vR2hsZ1pFOUVnSS9XMUlI?=
 =?utf-8?B?amg1ZlhLUlRSWE9lc0J5ZHN6YlFjL3k2dk42V1o5RFVJZVBmZGJKdHRkNldD?=
 =?utf-8?B?Q1BNbXJOQTQ1T21VZ2d2T2ZvVHpHWTc5ZVl1RzREYzFhNWZOeDZmVVppdFFy?=
 =?utf-8?Q?CrLDCMU7klUkQ9r+MLIN+AQbvLGKuGaq8ONNez7?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb75eea-05fb-47c8-b152-08d9302b3433
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 18:27:16.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3T+EQJPw70SlwpJ2EDWYMc2hvCQcjAqFHvr6nGolOrkxNzIjdof4JiXfOpy/SgizdaUJgSTqFNFmfZmswz72rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3761
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10016 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150114
X-Proofpoint-ORIG-GUID: kYz3TKMdVqd6COhkvbW2G8kJnSFV1-kp
X-Proofpoint-GUID: kYz3TKMdVqd6COhkvbW2G8kJnSFV1-kp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/21 5:40 AM, Matthew Wilcox wrote:
> On Tue, Jun 15, 2021 at 01:03:53PM +0200, Jann Horn wrote:
>> The messier path, as the original commit describes, is "gigantic" page
>> allocation. In that case, we'll go through the following path (if we
>> ignore CMA):
>>
>>   alloc_fresh_huge_page():
>>     alloc_gigantic_page()
>>       alloc_contig_pages()
>>         __alloc_contig_pages()
>>           alloc_contig_range()
>>             isolate_freepages_range()
>>               split_map_pages()
>>                 post_alloc_hook() [FOR EVERY PAGE]
>>                   set_page_refcounted()
>>                     set_page_count(page, 1)
>>     prep_compound_gigantic_page()
>>       set_page_count(p, 0) [FOR EVERY TAIL PAGE]
>>
>> so all the tail pages are initially allocated with refcount 1 by the
>> page allocator, and then we overwrite those refcounts with zeroes.
>>
>>
>> Luckily, the only non-__init codepath that can get here is
>> __nr_hugepages_store_common(), which is only invoked from privileged
>> writes to sysfs/sysctls.

Thanks for spotting this Jann!

> Argh.  What if we passed __GFP_COMP into alloc_contig_pages()?
> The current callers of alloc_contig_range() do not pass __GFP_COMP,
> so it's no behaviour change for them, and __GFP_COMP implies this
> kind of behaviour.  I think that would imply _not_ calling
> split_map_pages(), which implies not calling post_alloc_hook(),
> which means we probably need to do a lot of the parts of
> post_alloc_hook() in alloc_gigantic_page().  Yuck.

That might work.  We would need to do something 'like' split_map_pages
to split the compound free pages in the allocated range.  Then, stitch
them together into one big compound page.  We 'should' be able to call
post_alloc_hook on the resulting big compound page.  Of course, that is
all theory without digging into the details.

Note that in the general case alloc_contig_range/alloc_contig_pages can
be called to request a non-power of two number of pages.  In such cases
__GFP_COMP would make little sense.
-- 
Mike Kravetz
