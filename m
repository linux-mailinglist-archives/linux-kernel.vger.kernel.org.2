Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB843325B39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 02:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhBZBWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 20:22:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53076 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhBZBUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 20:20:52 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q1JR4t133938;
        Fri, 26 Feb 2021 01:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Mz6hGcrX5xJivaMDtBIIyfPQPRBG6AMkc8dbN5v9mtk=;
 b=QkZpA3su/zXD52aHL8eNa5H84Jjtp8dnVHh4Pi84ths3+bq085c60v1ge7anrcfsyK1P
 sY2bH4go14fDrRI1rEIIK0CT8Lk8bfE2sDXOJZe1rCc4AbkdhDFQ7lcM0SkfRFITr9E3
 P+4wUn3nNxux0PwggBtVoNxOMtgV48HmseZ6r+j/6RB9YmlqqOpcvqYkwyMTLU11c8XH
 Xvbs/akP5nVey+2T2l7nAOJXeKEJ2j8hmw2LeMnxmX4sLzWwGA9Kjsr2a5yBupYOzRI/
 VMhF3mMzFOhpkdnBnUta1J14OBBoWpVKKoK9GMsrT8a7ObNmsBsHRd9dDgtf+GEyUzd7 JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 36tsur8f41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 01:19:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11Q1EjAX011242;
        Fri, 26 Feb 2021 01:19:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by aserp3020.oracle.com with ESMTP id 36ucb2sq0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 01:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUDmSOch1IGoMwKFEcid9pLetfaDk9vdrqNS59B7o4IfodsvGHVBpXvS2G9YgjprHX4Zcjt4sFPSElo+BRHayyQCWDn/1FDkmdTj5BJr86R8cxot4Po2FvZ1vI9x2Wb8rZstzca2i1oqskI5V4VWxglcWgiN5msjE77qSuQ2lx0sVafNWM08pkaMpPyZg6JyDFezi4IsXlIFTFrjlPIrdJ8r8R/jBgmC/8HXHp3/AkvrlDY/IJQG9VxdjJ1SQnGNz3fHGk618J2XJlXfIpeWX7wrHJ0AqDjeQ0ygOOS6DRMjzEkKj9aajuNCYmTkX48OVYM7Va05OpllG2LZvAa8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz6hGcrX5xJivaMDtBIIyfPQPRBG6AMkc8dbN5v9mtk=;
 b=D8rGshVdWJrKMH1Bgb2qbzUcUpaji+nC498UTaGr62G8d6FyZUThQeiHG3A/z44MOMEhHQsl3a6et0LptUkuycEy0C0iDIMuPFmkKrcoHSTvLQm13lL3dpZf+r4Iy7M5Vi0Ga/lKYKDy8I2h5RIE5+33zZB+22N1+IAvHWoQZ0O3tF1NCXnRu7YcXEZZRMwZxKaGPr9grV1niJl+WmmY0XmLDuZx5kMCSoJohl87EOmtPVCFRkSFFdgLLErqMSrj8eIm5K5r0VX2IUo/3m8REyKYtTfM1bI/r2OlYhHZMeNQ8K1UTbipZZ40S7va33tiyVBuCRhuFWM822uR8zJ3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mz6hGcrX5xJivaMDtBIIyfPQPRBG6AMkc8dbN5v9mtk=;
 b=zqZTggRcXMNc/Vgmw3ORHMP2Ow0JLtPZxKIGKhPTsl/ffWYNl4HNHN//3plNliq06bcDlMOmb2HGNjTpeNhU6jK//Q0br4XKowgAYz+TE/P+S/WvIYoRZpVWnTyaf9fpWO6tYegKEx9f5k/udUfe/41E0DnNh2BWYjDMtc4bHQc=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM6PR10MB3116.namprd10.prod.outlook.com (2603:10b6:5:1ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 26 Feb
 2021 01:19:23 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3868.034; Fri, 26 Feb 2021
 01:19:23 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
From:   George Kennedy <george.kennedy@oracle.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <20210223200914.GH1741768@linux.ibm.com>
 <af06267d-00cd-d4e0-1985-b06ce7c993a3@oracle.com>
 <20210223213237.GI1741768@linux.ibm.com>
 <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <6000e7fd-bf8b-b9b0-066d-23661da8a51d@oracle.com>
Organization: Oracle Corporation
Message-ID: <dc5e007c-9223-b03b-1c58-28d2712ec352@oracle.com>
Date:   Thu, 25 Feb 2021 20:19:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <6000e7fd-bf8b-b9b0-066d-23661da8a51d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: BY5PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:a03:180::35) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.20.187.119) by BY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:180::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Fri, 26 Feb 2021 01:19:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 678ef2f2-8871-47f8-00a0-08d8d9f48cea
X-MS-TrafficTypeDiagnostic: DM6PR10MB3116:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3116AE3CFC6A4562A4ACB578E69D9@DM6PR10MB3116.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0ZL6EM5Q7RxspN5TF6QKFcMWM3XrzDGemAqAcdcCGQ848BGqMhjda8m7ogK9zFrbfRknP3J+2zpbI74ERWKeEcnjt3H4lwbVI3lTYyk2lBxHy1iGE4UfN3BsNT8tooL0xwc1X6ppsbqjpoQ2ro5rzFY0wbhuxJTfHM19rQvMGuuDqNkKEX8DvPzOKmOpsCAe1qxOdB/KRXR/IBvgXapmqrVaP1ZmXv87D2RVYh9Pm8bNy3wVdG/HQcse+zQPRSWDmZSwE1JN2SC6XSykkZw5bEryzfgz9O0MuJvizNiaDyCh9ACTxUWwsqTa4mLYdxwCQtqDka0cTzC/fB+/X/MtNiRopXoqY9iMhKUG8Iho0ffPWvn4B7CdXM9LNHmUeewRpIWdhldPHltiSEL9AUXji+2tYFWn9XDNkuQla6orptbthpTQwA5TzIXnJOmf3NSB3GLP9j+ZKgFVOKYGX499PPsN2FVZRIJT8TMvG+04Fu5LvDhjBeoQ90NRpkMlDh9jVbFwtzqsPAVZDGHk9yhVnbIsmhyk5u/niOviyG1IigCwBIGwIt2MY7CJgkpxafrfGM1cSlr/xz+/Z2iNZYGqZQ9q+hqHogkXAUN3JJtLyBuaY4jry2Lns03IHrFUk2C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(376002)(39860400002)(30864003)(6486002)(83380400001)(478600001)(31686004)(54906003)(316002)(44832011)(31696002)(36756003)(7416002)(6916009)(86362001)(53546011)(16576012)(66556008)(5660300002)(956004)(2906002)(16526019)(2616005)(107886003)(26005)(36916002)(8676002)(66476007)(8936002)(186003)(66946007)(4326008)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Wm1nTU9FT0g0WE9sVFozTUdDaERMZk1UZEpZSHNQQkgvTlpVWWhJeE44cVVY?=
 =?utf-8?B?bmIzakxidDBYcFB0dkV6OWp2K0prMmtJVVNFS3RFeElnYUFkSXpSdnZMVnpq?=
 =?utf-8?B?Rzg5Z1FUSXdRVFhISmRzZDBGYW54L21SQTY1UUhDdXp6OFcwc0xIaERWT2lw?=
 =?utf-8?B?V09qcEY4V3Bzci9BVDBPcXBBOERZb3haTE5PWGJ5UVE5TkFFb2s3VXhWQ3Nl?=
 =?utf-8?B?cE1YcEoyWVBvZU1xVWt5RFJpZ0Q5OWtUR3Y3Ynpyc2tBeGNmRklObTh2TGhv?=
 =?utf-8?B?T3UyWkV1eThYbHhPUm4zWUZUaThYUlFWaU5YYUh4N1FJVFZwNm9OZGZTM05M?=
 =?utf-8?B?Rzd5amFoT2x1QW8xaG1KVGIrVGp5aVVrN1liMVpNb0lFZVNOSVh3c1pUaEJU?=
 =?utf-8?B?bUJFU25qQld2dFdMSlFJOGk0Y1lHc1lxdkptVmJqOHB6OE96R25YdE5wUXBM?=
 =?utf-8?B?dnoyREQzcStwWWRsWVRjdXl4NXpFanVzSUFmMFJFeWFCckdGNnB2UlNySVRP?=
 =?utf-8?B?aGJ1UTZCL1dwRGtvRHY3Vk9tNE1CcnV6RngyQzR6b1VZamdCVWxPZ3FsUVF0?=
 =?utf-8?B?MXJSalczVnYraGJ1bXl0QWVKakwvT0pEcnJOSDBjMmxtbHFDYlVxRndIVU01?=
 =?utf-8?B?dmRJZWg1ek43NUtpVUQ1a09wd0pTdUpQZ0l5ZkNpMVJENVJIVUgvejJLV3lo?=
 =?utf-8?B?QXRCUFZUNGRJSHY5M0lyL0pzY1ZiWHVPSEhDbG51OTZRbTZhQWNrRVVVMVlq?=
 =?utf-8?B?eDRVanl6c3A1ZTFpMFE0UTJrdmcrMVAyVDN1MTlQRUtzYklBb2xlR3dLaXhY?=
 =?utf-8?B?N1RHSS9BVmZYUmJIV0ltay9oYmR0Wi9oQWNmVS91Z0JSNDI3NDRLc1Y5TEs4?=
 =?utf-8?B?bU5FQ0FZQW0wMFJLMkdaK3F0NklraWtvWGlhcDR4WkdwZ0JZUkFkTE5kdHFP?=
 =?utf-8?B?bHgxaTZGUk1nUU04R0l4dkRrSVh0N0d6TWUraFdVS0FaKzV3Wjh6K3FuWlJt?=
 =?utf-8?B?Q21tNFA1cGVLdld6UjZNazVwNy9SaEtCUEtXSEpNeGlMdisyUDhMcmNWMUpJ?=
 =?utf-8?B?VFhzWkFZeFVjakZ4Y05LcWx3SnZxb2JhVnZTeFZCYkhXOHI1dWJsZDFvSk8w?=
 =?utf-8?B?cWNEOGFjRVFFV2JJbXFJL3YwUStZY2tDYTBlVGVrRktHQXRQdHRwQ1lyc0d3?=
 =?utf-8?B?NDBoL1dEcnJ0Vjg2VDd5NHJrUGhrTjdMekQ5bVc0MmFEVjVvdE8rK1FWMkhN?=
 =?utf-8?B?Tlh3NGxvVzB6NjczNnlSbmVjeDBDcHBPSlJzQWRySlpMK05jU2NXZjJibEhS?=
 =?utf-8?B?TnJhamlaTTBiUnY0cGFlWjdJZnYvYkcvK2pPYVE2cDQxLzJ0TmN3ZGx3c3Z3?=
 =?utf-8?B?dGxDVjZBV1NrNkU3azBwOW1wTFQveCt3d3ZmTS9odjZKSWdLY1pQVUhNTTRr?=
 =?utf-8?B?OUdtWVRxblQrc2JnOEpacytDMStNZ1lxb1dSNnJPTGtqR1dtQnIvMmRVTFla?=
 =?utf-8?B?S2xaWElFQXZBMWIvMnlnL1FaTUZiR0l6elVMNFNUdWpYeEZCcnZ5NEVMVk1v?=
 =?utf-8?B?OHRPVk8xNUEvVHRoSW9PUTZjZGxjcGh2OWc5TlVWTGU3ZGFuU2NsdjN0bk1i?=
 =?utf-8?B?Umw0K01NNDhWWXFsTDdNN1ZxNkY3SnAwZzYzQTMxVUkwUXk4RmpnMDdTTGZr?=
 =?utf-8?B?cGFZNUt3c0NuZGVaSFVvVTE1SUF1SzNKeFVSSHRPVFV3Y2NMWjNNdmxBUnFo?=
 =?utf-8?Q?+lUgeHWEGwg5leZ4FnfubjMumYiGgiR56pRul+y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678ef2f2-8871-47f8-00a0-08d8d9f48cea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 01:19:23.6236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jXckyj3gMOhq3di/2bzsIH2M8AP5+C6FJahZ35YVYP7Se3tYXJrC6+hgq3+2Ebt5cbAVmK/BCRk+jGfnjyTdwHlK6KrFK5fAvJCucWGgUt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3116
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260006
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9906 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/2021 12:33 PM, George Kennedy wrote:
>
>
> On 2/25/2021 11:07 AM, Mike Rapoport wrote:
>> On Thu, Feb 25, 2021 at 10:22:44AM -0500, George Kennedy wrote:
>>>>>>> On 2/24/2021 5:37 AM, Mike Rapoport wrote:
>>> Applied just your latest patch, but same failure.
>>>
>>> I thought there was an earlier comment (which I can't find now) that 
>>> stated
>>> that memblock_reserve() wouldn't reserve the page, which is what's 
>>> needed
>>> here.
>> Actually, I think that memblock_reserve() should be just fine, but it 
>> seems
>> I'm missing something in address calculation each time.
>>
>> What would happen if you stuck
>>
>>     memblock_reserve(0xbe453000, PAGE_SIZE);
>>
>> say, at the beginning of find_ibft_region()?
>
> Good news Mike!
>
> The above hack in yesterday's last patch works - 10 successful 
> reboots. See: "BE453" below for the hack.
>
> I'll modify the patch to use "table_desc->address" instead, which is 
> the physical address of the table.
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 7bdc023..c118dd5 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1551,6 +1551,7 @@ void __init acpi_boot_table_init(void)
>      if (acpi_disabled)
>          return;
>
> +#if 0
>      /*
>       * Initialize the ACPI boot-time table parser.
>       */
> @@ -1558,6 +1559,7 @@ void __init acpi_boot_table_init(void)
>          disable_acpi();
>          return;
>      }
> +#endif
>
>      acpi_table_parse(ACPI_SIG_BOOT, acpi_parse_sbf);
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 740f3bdb..b045ab2 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -571,16 +571,6 @@ void __init reserve_standard_io_resources(void)
>
>  }
>
> -static __init void reserve_ibft_region(void)
> -{
> -    unsigned long addr, size = 0;
> -
> -    addr = find_ibft_region(&size);
> -
> -    if (size)
> -        memblock_reserve(addr, size);
> -}
> -
>  static bool __init snb_gfx_workaround_needed(void)
>  {
>  #ifdef CONFIG_PCI
> @@ -1033,6 +1023,12 @@ void __init setup_arch(char **cmdline_p)
>       */
>      find_smp_config();
>
> +    /*
> +     * Initialize the ACPI boot-time table parser.
> +     */
> +    if (acpi_table_init())
> +        disable_acpi();
> +
>      reserve_ibft_region();
>
>      early_alloc_pgt_buf();
> diff --git a/drivers/firmware/iscsi_ibft_find.c 
> b/drivers/firmware/iscsi_ibft_find.c
> index 64bb945..95fc1a6 100644
> --- a/drivers/firmware/iscsi_ibft_find.c
> +++ b/drivers/firmware/iscsi_ibft_find.c
> @@ -47,7 +47,25 @@
>  #define VGA_MEM 0xA0000 /* VGA buffer */
>  #define VGA_SIZE 0x20000 /* 128kB */
>
> -static int __init find_ibft_in_mem(void)
> +static void __init *acpi_find_ibft_region(void)
> +{
> +    int i;
> +    struct acpi_table_header *table = NULL;
> +    acpi_status status;
> +
> +    if (acpi_disabled)
> +        return NULL;
> +
> +    for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
> +        status = acpi_get_table(ibft_signs[i].sign, 0, &table);
> +        if (ACPI_SUCCESS(status))
> +            return table;
> +    }
> +
> +    return NULL;
> +}
> +
> +static void __init *find_ibft_in_mem(void)
>  {
>      unsigned long pos;
>      unsigned int len = 0;
> @@ -70,35 +88,52 @@ static int __init find_ibft_in_mem(void)
>                  /* if the length of the table extends past 1M,
>                   * the table cannot be valid. */
>                  if (pos + len <= (IBFT_END-1)) {
> -                    ibft_addr = (struct acpi_table_ibft *)virt;
>                      pr_info("iBFT found at 0x%lx.\n", pos);
> -                    goto done;
> +                    return virt;
>                  }
>              }
>          }
>      }
> -done:
> -    return len;
> +
> +    return NULL;
>  }
> +
> +static void __init *find_ibft(void)
> +{
> +    /* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
> +     * only use ACPI for this */
> +    if (!efi_enabled(EFI_BOOT))
> +        return find_ibft_in_mem();
> +    else
> +        return acpi_find_ibft_region();
> +}
> +
>  /*
>   * Routine used to find the iSCSI Boot Format Table. The logical
>   * kernel address is set in the ibft_addr global variable.
>   */
> -unsigned long __init find_ibft_region(unsigned long *sizep)
> +void __init reserve_ibft_region(void)
>  {
> -    ibft_addr = NULL;
> +    struct acpi_table_ibft *table;
> +    unsigned long size;
>
> -    /* iBFT 1.03 section 1.4.3.1 mandates that UEFI machines will
> -     * only use ACPI for this */
> +    table = find_ibft();
> +    if (!table)
> +        return;
>
> -    if (!efi_enabled(EFI_BOOT))
> -        find_ibft_in_mem();
> -
> -    if (ibft_addr) {
> -        *sizep = PAGE_ALIGN(ibft_addr->header.length);
> -        return (u64)virt_to_phys(ibft_addr);
> -    }
> +    size = PAGE_ALIGN(table->header.length);
> +#if 0
> +printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, 
> virt_to_phys(table)=%llx, size=%lx\n",
> +    (u64)table, virt_to_phys(table), size);
> +    memblock_reserve(virt_to_phys(table), size);
> +#else
> +printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, 
> 0x00000000BE453000, size=%lx\n",
> +    (u64)table, size);
> +    memblock_reserve(0x00000000BE453000, size);
> +#endif
>
> -    *sizep = 0;
> -    return 0;
> +    if (efi_enabled(EFI_BOOT))
> +        acpi_put_table(&table->header);
> +    else
> +        ibft_addr = table;
>  }
> diff --git a/include/linux/iscsi_ibft.h b/include/linux/iscsi_ibft.h
> index b7b45ca..da813c8 100644
> --- a/include/linux/iscsi_ibft.h
> +++ b/include/linux/iscsi_ibft.h
> @@ -26,13 +26,9 @@
>   * mapped address is set in the ibft_addr variable.
>   */
>  #ifdef CONFIG_ISCSI_IBFT_FIND
> -unsigned long find_ibft_region(unsigned long *sizep);
> +void reserve_ibft_region(void);
>  #else
> -static inline unsigned long find_ibft_region(unsigned long *sizep)
> -{
> -    *sizep = 0;
> -    return 0;
> -}
> +static inline void reserve_ibft_region(void) {}
>  #endif
>
>  #endif /* ISCSI_IBFT_H */

Mike,

To get rid of the 0x00000000BE453000 hardcoding, I added the following 
patch to your above patch to get the iBFT table "address" to use with 
memblock_reserve():

diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
index 56d81e4..4bc7bf3 100644
--- a/drivers/acpi/acpica/tbfind.c
+++ b/drivers/acpi/acpica/tbfind.c
@@ -120,3 +120,34 @@
      (void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
      return_ACPI_STATUS(status);
  }
+
+acpi_physical_address
+acpi_tb_find_table_address(char *signature)
+{
+    acpi_physical_address address = 0;
+    struct acpi_table_desc *table_desc;
+    int i;
+
+    ACPI_FUNCTION_TRACE(tb_find_table_address);
+
+printk(KERN_ERR "XXX acpi_tb_find_table_address: signature=%s\n", 
signature);
+
+    (void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
+    for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
+        if (memcmp(&(acpi_gbl_root_table_list.tables[i].signature),
+               signature, ACPI_NAMESEG_SIZE)) {
+
+            /* Not the requested table */
+
+            continue;
+        }
+
+        /* Table with matching signature has been found */
+        table_desc = &acpi_gbl_root_table_list.tables[i];
+        address = table_desc->address;
+    }
+
+    (void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
+printk(KERN_ERR "XXX acpi_tb_find_table_address(EXIT): address=%llx\n", 
address);
+    return address;
+}
diff --git a/drivers/firmware/iscsi_ibft_find.c 
b/drivers/firmware/iscsi_ibft_find.c
index 95fc1a6..0de70b4 100644
--- a/drivers/firmware/iscsi_ibft_find.c
+++ b/drivers/firmware/iscsi_ibft_find.c
@@ -28,6 +28,8 @@

  #include <asm/mmzone.h>

+extern acpi_physical_address acpi_tb_find_table_address(char *signature);
+
  /*
   * Physical location of iSCSI Boot Format Table.
   */
@@ -116,24 +118,32 @@ void __init reserve_ibft_region(void)
  {
      struct acpi_table_ibft *table;
      unsigned long size;
+    acpi_physical_address address;

      table = find_ibft();
      if (!table)
          return;

      size = PAGE_ALIGN(table->header.length);
+    address = acpi_tb_find_table_address(table->header.signature);
  #if 0
  printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, 
virt_to_phys(table)=%llx, size=%lx\n",
      (u64)table, virt_to_phys(table), size);
      memblock_reserve(virt_to_phys(table), size);
  #else
-printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, 
0x00000000BE453000, size=%lx\n",
-    (u64)table, size);
-    memblock_reserve(0x00000000BE453000, size);
+printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, address=%llx, 
size=%lx\n",
+    (u64)table, address, size);
+    if (address)
+        memblock_reserve(address, size);
+    else
+        printk(KERN_ERR "%s: Can't find table address\n", __func__);
  #endif

-    if (efi_enabled(EFI_BOOT))
+    if (efi_enabled(EFI_BOOT)) {
+printk(KERN_ERR "XXX reserve_ibft_region: calling 
acpi_put_table(%llx)\n", (u64)&table->header);
          acpi_put_table(&table->header);
-    else
+    } else {
          ibft_addr = table;
+printk(KERN_ERR "XXX reserve_ibft_region: ibft_addr=%llx\n", 
(u64)ibft_addr);
+    }
  }

Debug from the above:
[    0.050646] ACPI: Early table checksum verification disabled
[    0.051778] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
[    0.052922] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP 
00000001      01000013)
[    0.054623] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP 
00000001 BXPC 00000001)
[    0.056326] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT 
00000001 BXPC 00000001)
[    0.058016] ACPI: FACS 0x00000000BFBFD000 000040
[    0.058940] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC 
00000001 BXPC 00000001)
[    0.060627] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET 
00000001 BXPC 00000001)
[    0.062304] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2     
00000002      01000013)
[    0.063987] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP 
00000000      00000000)
[    0.065683] XXX acpi_tb_find_table_address: signature=iBFT
[    0.066754] XXX acpi_tb_find_table_address(EXIT): address=be453000
[    0.067959] XXX reserve_ibft_region: table=ffffffffff240000, 
address=be453000, size=1000
[    0.069534] XXX reserve_ibft_region: calling 
acpi_put_table(ffffffffff240000)

Not sure if it's the right thing to do, but added 
"acpi_tb_find_table_address()" to return the physical address of a table 
to use with memblock_reserve().

virt_to_phys(table) does not seem to return the physical address for the 
iBFT table (it would be nice if struct acpi_table_header also had a 
"address" element for the physical address of the table).

Ran 10 successful boots with the above without failure.

George
>
>
> Debug from the above:
>
> [    0.020293] last_pfn = 0xbfedc max_arch_pfn = 0x400000000
> [    0.050778] ACPI: Early table checksum verification disabled
> [    0.056475] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
> [    0.057628] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS 
> BXPCFACP 00000001      01000013)
> [    0.059341] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS 
> BXPCFACP 00000001 BXPC 00000001)
> [    0.061043] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS 
> BXPCDSDT 00000001 BXPC 00000001)
> [    0.062740] ACPI: FACS 0x00000000BFBFD000 000040
> [    0.063673] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS 
> BXPCAPIC 00000001 BXPC 00000001)
> [    0.065369] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS 
> BXPCHPET 00000001 BXPC 00000001)
> [    0.067061] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL 
> EDK2     00000002      01000013)
> [    0.068761] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS 
> BXPCFACP 00000000      00000000)
> [    0.070461] XXX reserve_ibft_region: table=ffffffffff240000, 
> 0x00000000BE453000, size=1000
> [    0.072231] check: Scanning 1 areas for low memory corruption
>
> George
>>> [   30.308229] iBFT detected..
>>> [   30.308796]
>>> ==================================================================
>>> [   30.308890] BUG: KASAN: use-after-free in ibft_init+0x134/0xc33
>>> [   30.308890] Read of size 4 at addr ffff8880be453004 by task 
>>> swapper/0/1
>>> [   30.308890]
>>> [   30.308890] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 
>>> 5.11.0-f9593a0 #12
>>> [   30.308890] Hardware name: QEMU Standard PC (i440FX + PIIX, 
>>> 1996), BIOS
>>> 0.0.0 02/06/2015
>>> [   30.308890] Call Trace:
>>> [   30.308890]  dump_stack+0xdb/0x120
>>> [   30.308890]  ? ibft_init+0x134/0xc33
>>> [   30.308890] print_address_description.constprop.7+0x41/0x60
>>> [   30.308890]  ? ibft_init+0x134/0xc33
>>> [   30.308890]  ? ibft_init+0x134/0xc33
>>> [   30.308890]  kasan_report.cold.10+0x78/0xd1
>>> [   30.308890]  ? ibft_init+0x134/0xc33
>>> [   30.308890]  __asan_report_load_n_noabort+0xf/0x20
>>> [   30.308890]  ibft_init+0x134/0xc33
>>> [   30.308890]  ? write_comp_data+0x2f/0x90
>>> [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
>>> [   30.308890]  ? write_comp_data+0x2f/0x90
>>> [   30.308890]  ? ibft_check_initiator_for+0x159/0x159
>>> [   30.308890]  do_one_initcall+0xc4/0x3e0
>>> [   30.308890]  ? perf_trace_initcall_level+0x3e0/0x3e0
>>> [   30.308890]  ? unpoison_range+0x14/0x40
>>> [   30.308890]  ? ____kasan_kmalloc.constprop.5+0x8f/0xc0
>>> [   30.308890]  ? kernel_init_freeable+0x420/0x652
>>> [   30.308890]  ? __kasan_kmalloc+0x9/0x10
>>> [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
>>> [   30.308890]  kernel_init_freeable+0x596/0x652
>>> [   30.308890]  ? console_on_rootfs+0x7d/0x7d
>>> [   30.308890]  ? __sanitizer_cov_trace_pc+0x21/0x50
>>> [   30.308890]  ? rest_init+0xf0/0xf0
>>> [   30.308890]  kernel_init+0x16/0x1d0
>>> [   30.308890]  ? rest_init+0xf0/0xf0
>>> [   30.308890]  ret_from_fork+0x22/0x30
>>> [   30.308890]
>>> [   30.308890] The buggy address belongs to the page:
>>> [   30.308890] page:0000000001b7b17c refcount:0 mapcount:0
>>> mapping:0000000000000000 index:0x1 pfn:0xbe453
>>> [   30.308890] flags: 0xfffffc0000000()
>>> [   30.308890] raw: 000fffffc0000000 ffffea0002ef9788 ffffea0002f91488
>>> 0000000000000000
>>> [   30.308890] raw: 0000000000000001 0000000000000000 00000000ffffffff
>>> 0000000000000000
>>> [   30.308890] page dumped because: kasan: bad access detected
>>> [   30.308890] page_owner tracks the page as freed
>>> [   30.308890] page last allocated via order 0, migratetype Movable,
>>> gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 204, ts 
>>> 28121288605
>>> [   30.308890]  prep_new_page+0xfb/0x140
>>> [   30.308890]  get_page_from_freelist+0x3503/0x5730
>>> [   30.308890]  __alloc_pages_nodemask+0x2d8/0x650
>>> [   30.308890]  alloc_pages_vma+0xe2/0x560
>>> [   30.308890]  __handle_mm_fault+0x930/0x26c0
>>> [   30.308890]  handle_mm_fault+0x1f9/0x810
>>> [   30.308890]  do_user_addr_fault+0x6f7/0xca0
>>> [   30.308890]  exc_page_fault+0xaf/0x1a0
>>> [   30.308890]  asm_exc_page_fault+0x1e/0x30
>>> [   30.308890] page last free stack trace:
>>> [   30.308890]  free_pcp_prepare+0x122/0x290
>>> [   30.308890]  free_unref_page_list+0xe6/0x490
>>> [   30.308890]  release_pages+0x2ed/0x1270
>>> [   30.308890]  free_pages_and_swap_cache+0x245/0x2e0
>>> [   30.308890]  tlb_flush_mmu+0x11e/0x680
>>> [   30.308890]  tlb_finish_mmu+0xa6/0x3e0
>>> [   30.308890]  exit_mmap+0x2b3/0x540
>>> [   30.308890]  mmput+0x11d/0x450
>>> [   30.308890]  do_exit+0xaa6/0x2d40
>>> [   30.308890]  do_group_exit+0x128/0x340
>>> [   30.308890]  __x64_sys_exit_group+0x43/0x50
>>> [   30.308890]  do_syscall_64+0x37/0x50
>>> [   30.308890]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [   30.308890]
>>> [   30.308890] Memory state around the buggy address:
>>> [   30.308890]  ffff8880be452f00: ff ff ff ff ff ff ff ff ff ff ff 
>>> ff ff ff
>>> ff ff
>>> [   30.308890]  ffff8880be452f80: ff ff ff ff ff ff ff ff ff ff ff 
>>> ff ff ff
>>> ff ff
>>> [   30.308890] >ffff8880be453000: ff ff ff ff ff ff ff ff ff ff ff 
>>> ff ff ff
>>> ff ff
>>> [   30.308890]                    ^
>>> [   30.308890]  ffff8880be453080: ff ff ff ff ff ff ff ff ff ff ff 
>>> ff ff ff
>>> ff ff
>>> [   30.308890]  ffff8880be453100: ff ff ff ff ff ff ff ff ff ff ff 
>>> ff ff ff
>>> ff ff
>>> [   30.308890]
>>> ==================================================================
>>>
>>> George
>>>
>

