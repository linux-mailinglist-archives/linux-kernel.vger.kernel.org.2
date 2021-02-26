Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E56326569
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhBZQSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:18:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35974 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBZQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:17:41 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QGASm5058543;
        Fri, 26 Feb 2021 16:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ytf7G45iE6sxoo7dwT+4e9DlgHaCOdX1M6yCeo1GVEo=;
 b=zdRF4AwQbmyjAle+vB5VTW4tI0eyvhQJJatsMkYHfTomYDT9oABPdzmCor/n1fiCdryn
 J/U8yc6b87o84nkBW7xOAgkdCVFJuRWyG8NkfS5oiIffijOANLonLFXUMyn46yDpO5v9
 3rOHkDv9pvNrtAG5ZXWOZttJKEcI5sJqccC8Fov6GbaUDqGw8I6mPBTETAYaZXLKePIN
 o8jn/Uduz5blAE141LJD8D6AkNu3HGXQT5ec3r2c44g4QHaixxQJ9bHFO7m1QhIEPO8z
 rPatJ3DlFZxPcuX+u/lrEbXlB6PCPXi7xnpIn04f1bRSFxipsU+9a4/LuImODwT6XAB5 Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36xqkfa1s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 16:16:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11QGAkCc129740;
        Fri, 26 Feb 2021 16:16:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by aserp3020.oracle.com with ESMTP id 36ucb3kggd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Feb 2021 16:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgABS4BnLQxr8gTonILQuSPBg3E90F0fG7ywbVG89QuI7LHMN4MTJl0/cvC/ZzfnX6cPIdzOE+aUFfGYtRp+A3RnFekPtZdIX7cmQPgL3u63HrS+A4Mj0UVLspiEZCP46w0uQ/sAy9MH2szqxPG4e4B537EkbI29QUTSz8iq+ws+Sz9o0CO2NKyQAX+SHynx4eEKt484eAyXZgtYPu9PTbRT5xzyVCUP/Mo0YZPzjdyWez2K9IUo/taXJ+hszvvqXGvCtOmGTIfEl473qpD68PFjpuHmqLsOebQ+LKFOkvtJ4A7GHASfPfMO5KXx07fodllNIqom0vkBTJjYTG5yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ytf7G45iE6sxoo7dwT+4e9DlgHaCOdX1M6yCeo1GVEo=;
 b=alXobR5KwBgyz+UlEAq+oPfh7R1T+L/cnM+qcJyQ1svB7LRqDBNjW3jBMhIoaqfF3BjUVvdiqYvNhgoaqPwHPn1I3VxjQdj2i1qUwa14rakJqYC8OYAvxrPwE67YyH5eMPaToER/gs9lP1SKmL44D0wm1LZAJ1Cuy+lsHbgsj6kfWPxXrJGX2J+vWjrZztUkiIh6TCATJ0hDlyBAehnMTObugjwb2LJc0VpfR3uElQHa+ju0kUT6KBrP6ieuzS5LeNcaTUMd5wsEy4GPfWB74IaeyvVzw8cBm68okQDjoRNsclu/8d23R4vNAG+siAWDCTvsi4gPhRnWNJD/dT/rZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ytf7G45iE6sxoo7dwT+4e9DlgHaCOdX1M6yCeo1GVEo=;
 b=uoy5zmjFa/zIxisx+pmFawkibFWMBcLU4pQrZrJYA3grwX4r86NS48oZi32nD75TS0q5kXElA/zygAHlzhYsS9jgyKEw693X4DeYwW/pbeSvA1HiSomTbYoajL9wfa7H1U4g/8jJv49mNO5MzH4GpLr0krvachP0UZp8IFrQ7Xg=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 16:16:12 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3890.023; Fri, 26 Feb 2021
 16:16:12 +0000
Subject: Re: [PATCH] mm, kasan: don't poison boot memory
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
References: <450a9895-a2b4-d11b-97ca-1bd33d5308d4@oracle.com>
 <20210224103754.GA1854360@linux.ibm.com>
 <9b7251d1-7b90-db4f-fa5e-80165e1cbb4b@oracle.com>
 <20210225085300.GB1854360@linux.ibm.com>
 <9973d0e2-e28b-3f8a-5f5d-9d142080d141@oracle.com>
 <20210225145700.GC1854360@linux.ibm.com>
 <bb444ddb-d60d-114f-c2fe-64e5fb34102d@oracle.com>
 <20210225160706.GD1854360@linux.ibm.com>
 <6000e7fd-bf8b-b9b0-066d-23661da8a51d@oracle.com>
 <dc5e007c-9223-b03b-1c58-28d2712ec352@oracle.com>
 <20210226111730.GL1854360@linux.ibm.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <e9e2f1a3-80f2-1b3e-6ffd-8004fe41c485@oracle.com>
Date:   Fri, 26 Feb 2021 11:16:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210226111730.GL1854360@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: BYAPR07CA0010.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::23) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.222] (108.20.187.119) by BYAPR07CA0010.namprd07.prod.outlook.com (2603:10b6:a02:bc::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 16:16:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ad95ca-dd20-47b0-23a7-08d8da71d57f
X-MS-TrafficTypeDiagnostic: DS7PR10MB5087:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DS7PR10MB5087821B223FADE776AFEFEBE69D9@DS7PR10MB5087.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAbwhjO0HPMCqOsv/9NL07qjE82pjwWC/cLxc3K+bx5/bJE3vZM/wipzV3albqOzK/Q/l3/Ekzq5aMp7gh4nSc/IyTZdrHl/kJyO/pg6Jr5ULGDv7H7/syqVGKuXLKMLREoeHbdAdnDLse7fHrwZJP2lPtqH6M59LCPcl/kBVt8Tmxvnnj6C7Go0ujE6zwyUhLMqSjVm3rLtApAF22PHYgXoBSq+nnC6gXN9EGAov6vr+P7tblmkDrD4Z5FCVQxYWnfjUsgZDCQMxFM9M++zEITCKLcMMcWUWFkqzCp+4blrdzsdqZC9CLqgfBboU2w+nSc3Tf3G0wERsQWjsqRL0WvWXUTIwgYlDzEFA6AX28VgsP7U99EnnK/huoe4TRjlBJ1LnYegCrM+ka7qd/DA3/XsTtwo+hj6gV62/VPxYxjgr/cwgUWJ2aiA2JLZ0VszEZqzWokQjJY3nfX9+VvQaow/CKyzyGP7qwMMw66mHCb9SGilgQVYRnNdrGR3NQt4Xa84MwYBpbum0/5fLjjCZtAE4cW6qCqL1Na5mR2pGHHN1Zw6pj0DYIDIgb5dhJxa5fsJv0T+TZoJOxNi2V58J4P81Wp81+lkNVJcjGlb7xEAMHk0weEW+xmr7YqUS1E+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(8676002)(54906003)(6916009)(44832011)(66476007)(26005)(316002)(478600001)(36756003)(107886003)(7416002)(6486002)(66946007)(53546011)(66556008)(186003)(2616005)(16526019)(86362001)(2906002)(36916002)(8936002)(4326008)(16576012)(31686004)(83380400001)(5660300002)(31696002)(956004)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L0wvTm9TaWFvTFJQRFRxNm5rKzBwd1BIUWNWdzFGYmVRbW0vTzdXU2JsYkJv?=
 =?utf-8?B?YUZXSHdKblVUYnVLWmhaMENNWmIwOEdVMDlMR1RLaG9QeHNHaUh1dEp0STNy?=
 =?utf-8?B?U3g3UTNUd0VXZkZRNzlMMzdJS0JxV1IzbEVMbndvS3Rmam9Ib2IvNlg5d0Iy?=
 =?utf-8?B?bGVob0VBZVlNcVpDSEh0K2lZQjhLUlZqd1ZIdTBLdVBxdzJxbTBMSnlxdlZP?=
 =?utf-8?B?dWZ5SUtyZEZVRHJRZVBUSFIzVjNleTZWNXZtR3hUOG5MU1cxM0lPUHIzL3ZZ?=
 =?utf-8?B?WW9MRGJ5amR5Y2VYU1AwNGl5V1NiQnNwRHlOZFVESmRHekJVdmJmSTM5bWVC?=
 =?utf-8?B?bkJ4US9LQnIzNDF3Vk43QUd6Y1pCbytnT3h4NnRaS296WnZEQVdCRmhzMjZG?=
 =?utf-8?B?NlNlVW1KYXY1Nm10dnBtUVJCSnM3TnUzcE0wRnNvZUVjUG5oaVpmaVE3MXFK?=
 =?utf-8?B?YnJHdEpTZFNLcjY5aUxRMWE3MVJrdUJDR05zRWoyL3RWRHQ3UkYxVE5IZmFM?=
 =?utf-8?B?c1lXQUIrRjdFbDhNb20rdUhHb2UyQ25CWWFNUE1NOElwZmNTbklCZHlibGV5?=
 =?utf-8?B?OU1zTnlUVTNhejE3eG5BR1NZbnlLM21sRVRUYUZHMTVsR3hOeXJ2SDJOZU8z?=
 =?utf-8?B?NUxmbzl2VU1Ta1BFbnR0MHM0bGN3b3dHSzBKOUJSQ2hWb3Y2dlJOa3R2MjNx?=
 =?utf-8?B?Y25xcnBZSU1xMElsaEVWUzFaTWMvaE40TkFvd1liWTc3U0ZQNmdvdTQ2bjZJ?=
 =?utf-8?B?UCt0RTF5L0o3WWg2dnNHVUNVQ05nMkh4ODcxcmI1Ly8zSXdKYWU3WVIweERL?=
 =?utf-8?B?U2dmS1ljd0FrNjBuMTBGbDdNd3FaOGtIb0E1MkwxaWI2Sy9oTUM1ZGhTejhW?=
 =?utf-8?B?T2JJaC9FK3ZDZjc5dnhoamdEMXF2YzdwQmY4WUtpTE5qOEdCZERtNGx3S2hJ?=
 =?utf-8?B?MzlqRkhFZ1BVdVd5eUJ1dTlNQTFKMTI4Tm9uRDlISUQ2eFlEWUk2VWRsVyt0?=
 =?utf-8?B?QVl3VUp0bVJyN3lmOHZPN0VVc0NrdWtJaEtYY2ppRVZ0aTV5dUMvY1JINmpC?=
 =?utf-8?B?N3YwZ1hIVG1QYTZBN05vUUpJekZ0QVhlTzMvZFNCNUNOSXhIYmd6N283VHBK?=
 =?utf-8?B?Vmt3MkR0QWVwZVBWeDRHUjhSNlpkbVF0eVdtR2JzeHh0Rm53b29Ta3hUNjJK?=
 =?utf-8?B?RTF2VDdjU3l6THIvdWFrTElCUWRxNEdJdGFTMnVzZmM4ajJNS3NLclhkNDVp?=
 =?utf-8?B?ZUovQVg5dHkrT2ZDdDZYRG5uR2R2MHBiYXVBUWhZWFpDd2xDSm9DSmZCUEN6?=
 =?utf-8?B?VG5NMFR2V3BtdDNEWVFCUXovNVZsMmlsVUhzZXhmOHpVcTNaS3d0c2czUFVT?=
 =?utf-8?B?VHE5aHdNRHBoOUdTeEJ3WW9HQlgxYXJJRU1Sb096MGFrU1pMQXpTeHk5Tzgy?=
 =?utf-8?B?aWVvaFRNQ0hCTGJMZWpRWXd6akN5VENzQ3Eyb3hDZ3hGVHhFNlVpK3B1TmZu?=
 =?utf-8?B?WlNoTW8yQkMrTnJVQjZPenF3ZGdYRkVseWd6dE9iYVR5MklyWm0vRHBhQ0tp?=
 =?utf-8?B?bFZ2RG1zWkszUkd6VDFlQkNLTkR6QnlxbUphNEpBcDZTenp6VDNjRVNNRU9W?=
 =?utf-8?B?VnRlSm5seGh5RDRUOElBSHl2ZFRFM3djUWdaVUF0SldTcmpBVlNhc3NKeVBS?=
 =?utf-8?B?eG9Lb09PN2R1T3hIY1UyQUdmYTVqalU0bC9qNmc3NTIrdzlPWjJzWnZrb0xH?=
 =?utf-8?Q?oGVDi7w/QSoW1feaUhoMjnOj1zhe/rxVJmBrNxI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ad95ca-dd20-47b0-23a7-08d8da71d57f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 16:16:12.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vjb0xyEnwgv4JGvzVuCXxdIDMR7odNFnr011BzuqNiL3rzC/GN+qQUWU/DXI+SVCFE2zUth/zTwfBxFv8CmWp4Sc2ycR7gIp+nS0V6VKlR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260122
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9907 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2/26/2021 6:17 AM, Mike Rapoport wrote:
> Hi George,
>
> On Thu, Feb 25, 2021 at 08:19:18PM -0500, George Kennedy wrote:
>> Mike,
>>
>> To get rid of the 0x00000000BE453000 hardcoding, I added the following patch
>> to your above patch to get the iBFT table "address" to use with
>> memblock_reserve():
>>
>> diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
>> index 56d81e4..4bc7bf3 100644
>> --- a/drivers/acpi/acpica/tbfind.c
>> +++ b/drivers/acpi/acpica/tbfind.c
>> @@ -120,3 +120,34 @@
>>       (void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
>>       return_ACPI_STATUS(status);
>>   }
>> +
>> +acpi_physical_address
>> +acpi_tb_find_table_address(char *signature)
>> +{
>> +    acpi_physical_address address = 0;
>> +    struct acpi_table_desc *table_desc;
>> +    int i;
>> +
>> +    ACPI_FUNCTION_TRACE(tb_find_table_address);
>> +
>> +printk(KERN_ERR "XXX acpi_tb_find_table_address: signature=%s\n",
>> signature);
>> +
>> +    (void)acpi_ut_acquire_mutex(ACPI_MTX_TABLES);
>> +    for (i = 0; i < acpi_gbl_root_table_list.current_table_count; ++i) {
>> +        if (memcmp(&(acpi_gbl_root_table_list.tables[i].signature),
>> +               signature, ACPI_NAMESEG_SIZE)) {
>> +
>> +            /* Not the requested table */
>> +
>> +            continue;
>> +        }
>> +
>> +        /* Table with matching signature has been found */
>> +        table_desc = &acpi_gbl_root_table_list.tables[i];
>> +        address = table_desc->address;
>> +    }
>> +
>> +    (void)acpi_ut_release_mutex(ACPI_MTX_TABLES);
>> +printk(KERN_ERR "XXX acpi_tb_find_table_address(EXIT): address=%llx\n",
>> address);
>> +    return address;
>> +}
>> diff --git a/drivers/firmware/iscsi_ibft_find.c
>> b/drivers/firmware/iscsi_ibft_find.c
>> index 95fc1a6..0de70b4 100644
>> --- a/drivers/firmware/iscsi_ibft_find.c
>> +++ b/drivers/firmware/iscsi_ibft_find.c
>> @@ -28,6 +28,8 @@
>>
>>   #include <asm/mmzone.h>
>>
>> +extern acpi_physical_address acpi_tb_find_table_address(char *signature);
>> +
>>   /*
>>    * Physical location of iSCSI Boot Format Table.
>>    */
>> @@ -116,24 +118,32 @@ void __init reserve_ibft_region(void)
>>   {
>>       struct acpi_table_ibft *table;
>>       unsigned long size;
>> +    acpi_physical_address address;
>>
>>       table = find_ibft();
>>       if (!table)
>>           return;
>>
>>       size = PAGE_ALIGN(table->header.length);
>> +    address = acpi_tb_find_table_address(table->header.signature);
>>   #if 0
>>   printk(KERN_ERR "XXX reserve_ibft_region: table=%llx,
>> virt_to_phys(table)=%llx, size=%lx\n",
>>       (u64)table, virt_to_phys(table), size);
>>       memblock_reserve(virt_to_phys(table), size);
>>   #else
>> -printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, 0x00000000BE453000,
>> size=%lx\n",
>> -    (u64)table, size);
>> -    memblock_reserve(0x00000000BE453000, size);
>> +printk(KERN_ERR "XXX reserve_ibft_region: table=%llx, address=%llx,
>> size=%lx\n",
>> +    (u64)table, address, size);
>> +    if (address)
>> +        memblock_reserve(address, size);
>> +    else
>> +        printk(KERN_ERR "%s: Can't find table address\n", __func__);
>>   #endif
>>
>> -    if (efi_enabled(EFI_BOOT))
>> +    if (efi_enabled(EFI_BOOT)) {
>> +printk(KERN_ERR "XXX reserve_ibft_region: calling acpi_put_table(%llx)\n",
>> (u64)&table->header);
>>           acpi_put_table(&table->header);
>> -    else
>> +    } else {
>>           ibft_addr = table;
>> +printk(KERN_ERR "XXX reserve_ibft_region: ibft_addr=%llx\n",
>> (u64)ibft_addr);
>> +    }
>>   }
>>
>> Debug from the above:
>> [    0.050646] ACPI: Early table checksum verification disabled
>> [    0.051778] ACPI: RSDP 0x00000000BFBFA014 000024 (v02 BOCHS )
>> [    0.052922] ACPI: XSDT 0x00000000BFBF90E8 00004C (v01 BOCHS BXPCFACP
>> 00000001      01000013)
>> [    0.054623] ACPI: FACP 0x00000000BFBF5000 000074 (v01 BOCHS BXPCFACP
>> 00000001 BXPC 00000001)
>> [    0.056326] ACPI: DSDT 0x00000000BFBF6000 00238D (v01 BOCHS BXPCDSDT
>> 00000001 BXPC 00000001)
>> [    0.058016] ACPI: FACS 0x00000000BFBFD000 000040
>> [    0.058940] ACPI: APIC 0x00000000BFBF4000 000090 (v01 BOCHS BXPCAPIC
>> 00000001 BXPC 00000001)
>> [    0.060627] ACPI: HPET 0x00000000BFBF3000 000038 (v01 BOCHS BXPCHPET
>> 00000001 BXPC 00000001)
>> [    0.062304] ACPI: BGRT 0x00000000BE49B000 000038 (v01 INTEL EDK2
>> 00000002      01000013)
>> [    0.063987] ACPI: iBFT 0x00000000BE453000 000800 (v01 BOCHS BXPCFACP
>> 00000000      00000000)
>> [    0.065683] XXX acpi_tb_find_table_address: signature=iBFT
>> [    0.066754] XXX acpi_tb_find_table_address(EXIT): address=be453000
>> [    0.067959] XXX reserve_ibft_region: table=ffffffffff240000,
>> address=be453000, size=1000
>> [    0.069534] XXX reserve_ibft_region: calling
>> acpi_put_table(ffffffffff240000)
>>
>> Not sure if it's the right thing to do, but added
>> "acpi_tb_find_table_address()" to return the physical address of a table to
>> use with memblock_reserve().
>>
>> virt_to_phys(table) does not seem to return the physical address for the
>> iBFT table (it would be nice if struct acpi_table_header also had a
>> "address" element for the physical address of the table).
> virt_to_phys() does not work that early because then it is mapped with
> early_memremap()  which uses different virtual to physical scheme.
>
> I'd say that acpi_tb_find_table_address() makes sense if we'd like to
> reserve ACPI tables outside of drivers/acpi.
>
> But probably we should simply reserve all the tables during
> acpi_table_init() so that any table that firmware put in the normal memory
> will be surely reserved.
>   
>> Ran 10 successful boots with the above without failure.
> That's good news indeed :)

Wondering if we could do something like this instead (trying to keep 
changes minimal). Just do the memblock_reserve() for all the standard 
tables.

diff --git a/drivers/acpi/acpica/tbinstal.c b/drivers/acpi/acpica/tbinstal.c
index 0bb15ad..830f82c 100644
--- a/drivers/acpi/acpica/tbinstal.c
+++ b/drivers/acpi/acpica/tbinstal.c
@@ -7,6 +7,7 @@
   *
*****************************************************************************/

+#include <linux/memblock.h>
  #include <acpi/acpi.h>
  #include "accommon.h"
  #include "actables.h"
@@ -14,6 +15,23 @@
  #define _COMPONENT          ACPI_TABLES
  ACPI_MODULE_NAME("tbinstal")

+void
+acpi_tb_reserve_standard_table(acpi_physical_address address,
+               struct acpi_table_header *header)
+{
+    struct acpi_table_header local_header;
+
+    if ((ACPI_COMPARE_NAMESEG(header->signature, ACPI_SIG_FACS)) ||
+        (ACPI_VALIDATE_RSDP_SIG(header->signature))) {
+        return;
+    }
+    /* Standard ACPI table with full common header */
+
+    memcpy(&local_header, header, sizeof(struct acpi_table_header));
+
+    memblock_reserve(address, PAGE_ALIGN(local_header.length));
+}
+
  /*******************************************************************************
   *
   * FUNCTION:    acpi_tb_install_table_with_override
@@ -58,6 +76,9 @@
                        new_table_desc->flags,
                        new_table_desc->pointer);

+    acpi_tb_reserve_standard_table(new_table_desc->address,
+                   new_table_desc->pointer);
+
      acpi_tb_print_table_header(new_table_desc->address,
                     new_table_desc->pointer);

There should be no harm in doing the memblock_reserve() for all the 
standard tables, right?

Ran 10 boots with the above without failure.

George
>> George
>>>

