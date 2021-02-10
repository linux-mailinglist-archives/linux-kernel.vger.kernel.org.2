Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0A93172B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhBJVwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:52:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:41384 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbhBJVwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:52:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ALiK6M149758;
        Wed, 10 Feb 2021 21:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=9GzjZwWezG8RobdygynVVQrfBsQ8qBzRixIVWK4T20E=;
 b=yhBaDhMaUV+vH8TWXGCmDPS/hrz7wGzy9rtk8niWDdybrB6P6ZQddm1z/58vWYany9jr
 CBEUoZcRK3B92DJYYFTgUJHLph6xviTbvAyFEWuO8f+nnuCZPIMU62l7fnJhRsXwqthU
 uD1tFaP5ypAvViXZeac55s8EtH2EckOuUQ+MvSPrijUKDejqVzSJ47f1rcSo5OAIqtue
 CP9elcyZ7uwWhpm5RffC9CaZG5+P8rmtoiUSnkGGDEKA3uaMBk5v1J5uV43g1MPweCF+
 GcJfC5HTywjQA+IdgzSp3XL0gS+jdBVEllIi4vAiyL5vtXamuRnXNS7O9I49Ny9JFeYP tQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36hgmanc7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 21:51:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11ALjUcZ001485;
        Wed, 10 Feb 2021 21:51:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by aserp3020.oracle.com with ESMTP id 36j51375v6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Feb 2021 21:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmuvofPMd9OjOJN/JruXHt8IPDB9k+VwPhBW8mIAFtMV4yX5hJnfVLwE0OmHjVCflyy59G8N5j9Eh6pjpYN1j4OMzYi7vM7JWah7rtP349P5gpV4Dk4orb+DsdHrWazWZ+vvLQCrw9pTdRKjWdz2BoPY9P9loxoTeCXZa5OzCdNZjkRAHry/wLZYCHGc06dkInWi3Z1cCfcXh1iUMRH7cjWYck63I4CZZ6I3DuT3aC8q+tQypxCJ0UTEWEUeuWmtOauDhdDEs37Zb1ittlatsxRgVCItWUZLnpl1hcThWOXuo2g/fG3FmnyGKtN8ZeE50K1Hghje62bFl4jsNmRxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GzjZwWezG8RobdygynVVQrfBsQ8qBzRixIVWK4T20E=;
 b=MId9RK3g0qSSLMUvjHTTfPJrNdhlXKsoUW+t2CzZ2Enk6w3b/tcll7IZ672q/7W0mIJ/vgYZcJEwTS/lKXKxo5ZQ/u6yscUphYIWd5Wec9MA1nQr6+z8ih41k2BtHrvrvmy8EdmlfOAda6S9rCOCaF+0L1ZOVMZA4MHGE5HXRjj7m8XLMzH2p1sqE/PQlQ32qiMdhbZ94JMPXe/FQbTXd3+JmEVAT1sKnuTXAUsOZfc7a4YL35nD1+SztAUrjvaVYtfnoBG50BjEEKUpaucXbXfGLv53fY9N5K96sUSY1zF4oIk7dsr+JW+ozmGkBdry0oo9lYLjLI/ZJLqD4kmLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GzjZwWezG8RobdygynVVQrfBsQ8qBzRixIVWK4T20E=;
 b=vBc7lzUQMmFmAE5UZnKZpod6AKm9rup4F9xV3zzzfdrR/ZtQ2Lyu/t0bS2+WpKFwCvxzALuvdO+vE49qkwNyE1Xl3+MT8hGqyNa/LYj9WtWkZyJEs7ZCIvZfORR1BllT71qxyogAw6/65bEZd7xHNZLt2b0cQ9Qa+3vpB/1lAw4=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DM5PR10MB1372.namprd10.prod.outlook.com (2603:10b6:3:10::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27; Wed, 10 Feb 2021 21:51:11 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::5c53:869:7452:46da%3]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 21:51:11 +0000
Subject: Re: [PATCH 1/1] iscsi_ibft: KASAN false positive failure occurs in
 ibft_init()
To:     Dmitry Vyukov <dvyukov@google.com>,
        Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>, pjones@redhat.com,
        konrad@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>
References: <1611684201-16262-1-git-send-email-george.kennedy@oracle.com>
 <YBG0glwiK1wyJTeN@Konrads-MacBook-Pro.local>
 <CACT4Y+a48smtXc6qJy9Wthwuqjk2gh6o7BK1tfWW46g7D_r-Lg@mail.gmail.com>
 <cc712c9c-7786-bb26-7082-04e564df98aa@oracle.com>
 <CACT4Y+bPDvmwk38DrKfGV8cbtS_abAMDCqr9OigcPfep0uk5AQ@mail.gmail.com>
 <20210203192856.GA324708@fedora>
 <CACT4Y+bscZGpMK-UXXzeFDeJtGYt-royR_=iTzTmBrwe3wOmTw@mail.gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
Message-ID: <14124734-326e-87b3-a04a-b7190f1e1282@oracle.com>
Date:   Wed, 10 Feb 2021 16:51:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
In-Reply-To: <CACT4Y+bscZGpMK-UXXzeFDeJtGYt-royR_=iTzTmBrwe3wOmTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [108.20.187.119]
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.246] (108.20.187.119) by BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Wed, 10 Feb 2021 21:51:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50f02c84-5816-42dd-3ba6-08d8ce0dfaa6
X-MS-TrafficTypeDiagnostic: DM5PR10MB1372:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR10MB137218C8EBCE17BE1908E60CE68D9@DM5PR10MB1372.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+F7crlt91G/QtekVkqfA79nodMZUFeO3MuhBJJAHXVfKvNVwSvKT+jF8CgFXzTTd7qe95i7NVPlL9jiZhunBvl282noxC+OyfaCBeSm+VwiZrLxpPF7EPptirL1jDnRmNMVxB1YNrjjrkU8oLdX4CmGu7ji041OART9f8KNGLRv5bx3XqUvxmS4xnmm2I6NbJOUCbO824/joXDLRHimwd2YinRppAF0lobu3DozIQjsxFRrq1Ty1U3Jbf83AD3xG/v40fw3hptkoQfjzshHnMzx0I9YnHOgy4kDWSgu+Pp1jl+e+xPLrTCGGMtwW7gMt14Bst9ufcUX2UjaFoQk3JDGWl+IrqvP5fenhilkOHhwDZdDNIgrXq51xEo5ll/WQJiS9xvK9xVV3Plu8+BzyDzDCinnGZIsWNqVuZxxXu4sOrYeQxNFdfz4BguPG+mGPMZP/IsxCBCZUeeYXwOX43UCjme6m+hweSi5qLyZIFnVUy+yzqn4g1WpWI58d/mpYuXi9gd+hPb8D2alZn0rimXADMbNbnjrglhj8s8wUWnFybouctylYZQpuFkuZ+Eg7DjqBBUc1g4/3p8oqM7tSEldBINfluPBjje+a5Pi3dlF6oI9fef//5YLQCl45W8YYnNTZ5EPFSi/+XAezYrzFB7l19vu/0cXLg7ymH387kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(39860400002)(136003)(31686004)(83380400001)(86362001)(31696002)(66556008)(66946007)(66476007)(107886003)(30864003)(8676002)(5660300002)(478600001)(6666004)(4326008)(966005)(16526019)(186003)(26005)(8936002)(53546011)(44832011)(36916002)(6486002)(36756003)(2616005)(956004)(2906002)(54906003)(110136005)(16576012)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b0dUNkd0N05vZkN1N3BCWEdrVEpKRkd0Z3JPdzRyWEVtMFJNMTBXcW0rdEta?=
 =?utf-8?B?YVF4b0ZqNGN0eDlVWWQzS25ndWFRc0V5WmxWMzA0RXpXdXNqanhCNEJ0Wlpv?=
 =?utf-8?B?ZXpRTHdjcXNLZG1YZXMvdzkyeHl0S2NDcXVlNlZqRDd5M2JMSy91VHNqRXBm?=
 =?utf-8?B?NlA1TU5KM2NoNGdSNkI2RER5V1V6STB6MzQ1VzIvK1RBTURGeUQ2OVlEMU5h?=
 =?utf-8?B?ZlJZUXRXNFJXVWE5MXo2blpFa1ZabU9LSzBCdkRndUhLeFZMVGpzcTh6TWJL?=
 =?utf-8?B?NHZLMXI2aXhNSU1aYkxOUWxPYzFMckVMNkpJWUxXdkxxV01CNG5rZks3bzNq?=
 =?utf-8?B?SzlSQXZpKzM1R3RZeVFYaDFKN1hKZDAwazFqVTFqZ3VFWDhRbzZmSDlyU2N6?=
 =?utf-8?B?dHA3RU83ZzE2eEUyZGljMHp4TmU1ZFZ1c1dCaC9wK3VCak9pbTkydEpKVXI3?=
 =?utf-8?B?aVBWRENaTDJid0VJWVgxUkUwVDdlYkRDOHZQQmdEVkIxR3kvV1g5TU5kUStt?=
 =?utf-8?B?dXFTZVRXdlFjZGpJTDQ5ZjJ4VHZ5a2ZtcUJVM2dZZ1UzZmxZMTlXUklwcndj?=
 =?utf-8?B?eDdKZ1hxWDJnOG96T1J0ajRkTWhnMm41djhYZlYxOWh4MENMdjJ5SGVITXJ0?=
 =?utf-8?B?SUhFRnkvTWdyMUoxdFBUNUxpM09SZ0JTZkxTb2Y0SGQwT1U1QVU0dmJGaXgz?=
 =?utf-8?B?L3piTHF0NXlYMDhHanNoaE84NDdoaVlzRVpmNlpPMmdXYk04cDAyQ3VkOGMx?=
 =?utf-8?B?QS9uOXQxQUtRSU55UWxhd28xdzNOUkRleU9iRVdPamd5NEFOVjBzZ1NOa1oy?=
 =?utf-8?B?aHNESVNwaldjS3A4Y3MxYUNiTVR5aGhiVmc3YVVuaG9HcEZObVdLVkVvWWd3?=
 =?utf-8?B?THdQQWpidjRvdHB6bmg2SFVkQ1YxT3pyaW1jV0xHWWVpdWdpSXR1M3NoRE8x?=
 =?utf-8?B?aStqWFRSS0wybFo4akFKK0x6ZWdnSjNtUHFNdTFBV25MaUpwKy9PNE05cFMr?=
 =?utf-8?B?djkyZWNpOUIvWjdoTXZ6TWxzUDFueWllWnFBWHBsTDFWanRab3RNQVlDeVZ5?=
 =?utf-8?B?dU9FY1Y0bnJ1c2hLbXNneStPeGJldEg1R281ZHdtUjVMa2NCREh2TytyLzMz?=
 =?utf-8?B?VlZ1VCtORThabWtJYW5uOWEyVE1QblZWMmR2QTVaNnBkY2xyN2QwSENObWNV?=
 =?utf-8?B?ZitTTUtMamxnbnp1cXNjS1B6TTIrUzZ3K1h4K0U1bWlqcVdjTVpXOGR6NVh2?=
 =?utf-8?B?OGNDeGdIU3Z4WUErYWZEQUY4QTZNSGt1YkhPWW9RSGNwcmVrV21rNkJGSVQ1?=
 =?utf-8?B?ZklyaStLTnFkQmRxb0tHTmZvbFY0WHNJVmpULzJJcmNVb2hob1ZGTVhEWm5u?=
 =?utf-8?B?YWNJVEhQMkgwcTRTZVdudC9ZNFhTZjFEZVM4Yjk3a1ZjUC9qQ2FlQVNyNENp?=
 =?utf-8?B?U2NmeDJOSWJIRWVJSG9MclB2L3ZSQzNhMElacFh0VGc3UEdMTHdobXJnYUdk?=
 =?utf-8?B?ei9FZkdHY2NMK2hyYXQ5alcybGVJVXhudU1qdzFUb1BGdkxDWWl4VVZ6Wmp5?=
 =?utf-8?B?R2ZCdmJjd051K05pczdvYUV5dk5Wbk5jTldrK2dTWi9IR2dPckZ1L0hUR1Bz?=
 =?utf-8?B?T0t6SDR3SjhzZDZpSjBJWElQaCtKOU1yM1U5cFAvTXFJcHpQd2NxQXVVWGNr?=
 =?utf-8?B?UTV5cGJlT3VXUHhveCtCcFFkbitmaDR2U1BuTnd0Tm5IWVZTRGYraHJHT3Bp?=
 =?utf-8?Q?Xw6ucEWAMYH97YoJlIhFWvkIELG0M/ShMutf484?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f02c84-5816-42dd-3ba6-08d8ce0dfaa6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 21:51:11.1847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaJdmvlZCXqqWUD3ZxXOF7lHadEXYUeZjct+Cm6+80RjRex9uJ43WB2IzYf6KXGh3fYeF9yfbE8zk/YUi6oENxvMpjLC+iRy9MSMe8MpCVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1372
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100189
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102100189
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2021 2:35 PM, Dmitry Vyukov wrote:
> On Wed, Feb 3, 2021 at 8:29 PM Konrad Rzeszutek Wilk <konrad@darnok.org> wrote:
>> Hey Dmitry, Rafael, George, please see below..
>>
>> On Wed, Jan 27, 2021 at 10:10:07PM +0100, Dmitry Vyukov wrote:
>>> On Wed, Jan 27, 2021 at 9:01 PM George Kennedy
>>> <george.kennedy@oracle.com> wrote:
>>>> Hi Dmitry,
>>>>
>>>> On 1/27/2021 1:48 PM, Dmitry Vyukov wrote:
>>>>
>>>> On Wed, Jan 27, 2021 at 7:44 PM Konrad Rzeszutek Wilk
>>>> <konrad.wilk@oracle.com> wrote:
>>>>
>>>> On Tue, Jan 26, 2021 at 01:03:21PM -0500, George Kennedy wrote:
>>>>
>>>> During boot of kernel with CONFIG_KASAN the following KASAN false
>>>> positive failure will occur when ibft_init() reads the
>>>> ACPI iBFT table: BUG: KASAN: use-after-free in ibft_init
>>>>
>>>> The ACPI iBFT table is not allocated, and the iscsi driver uses
>>>> a pointer to it to calculate checksum, etc. KASAN complains
>>>> about this pointer with use-after-free, which this is not.
>>>>
>>>> Andrey, Alexander, Dmitry,
>>>>
>>>> I think this is the right way for this, but was wondering if you have
>>>> other suggestions?
>>>>
>>>> Thanks!
>>>>
>>>> Hi George, Konrad,
>>>>
>>>> Please provide a sample KASAN report and kernel version to match line numbers.
>>>>
>>>> 5.4.17-2102.200.0.0.20210106_0000
>>>>
>>>> [   24.413536] iBFT detected.
>>>> [   24.414074]
>>>> ==================================================================
>>>> [   24.407342] BUG: KASAN: use-after-free in ibft_init+0x134/0xb8b
>>>> [   24.407342] Read of size 4 at addr ffff8880be452004 by task swapper/0/1
>>>> [   24.407342]
>>>> [   24.407342] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.4.17-2102.200.0.0.20210106_0000.syzk #1
>>>> [   24.407342] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>>>> [   24.407342] Call Trace:
>>>> [   24.407342]  dump_stack+0xd4/0x119
>>>> [   24.407342]  ? ibft_init+0x134/0xb8b
>>>> [   24.407342]  print_address_description.constprop.6+0x20/0x220
>>>> [   24.407342]  ? ibft_init+0x134/0xb8b
>>>> [   24.407342]  ? ibft_init+0x134/0xb8b
>>>> [   24.407342]  __kasan_report.cold.9+0x37/0x77
>>>> [   24.407342]  ? ibft_init+0x134/0xb8b
>>>> [   24.407342]  kasan_report+0x14/0x1b
>>>> [   24.407342]  __asan_report_load_n_noabort+0xf/0x11
>>>> [   24.407342]  ibft_init+0x134/0xb8b
>>>> [   24.407342]  ? dmi_sysfs_init+0x1a5/0x1a5
>>>> [   24.407342]  ? dmi_walk+0x72/0x89
>>>> [   24.407342]  ? ibft_check_initiator_for+0x159/0x159
>>>> [   24.407342]  ? rvt_init_port+0x110/0x101
>>>> [   24.407342]  ? ibft_check_initiator_for+0x159/0x159
>>>> [   24.407342]  do_one_initcall+0xc3/0x44d
>>>> [   24.407342]  ? perf_trace_initcall_level+0x410/0x405
>>>> [   24.407342]  kernel_init_freeable+0x551/0x673
>>>> [   24.407342]  ? start_kernel+0x94b/0x94b
>>>> [   24.407342]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
>>>> [   24.407342]  ? __kasan_check_write+0x14/0x16
>>>> [   24.407342]  ? rest_init+0xe6/0xe6
>>>> [   24.407342]  kernel_init+0x16/0x1bd
>>>> [   24.407342]  ? rest_init+0xe6/0xe6
>>>> [   24.407342]  ret_from_fork+0x2b/0x36
>>>> [   24.407342]
>>>> [   24.407342] The buggy address belongs to the page:
>>>> [   24.407342] page:ffffea0002f91480 refcount:0 mapcount:0 mapping:0000000000000000 index:0x1
>>>> [   24.407342] flags: 0xfffffc0000000()
>>>> [   24.407342] raw: 000fffffc0000000 ffffea0002fca588 ffffea0002fb1a88 0000000000000000
>>>> [   24.407342] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
>>>> [   24.407342] page dumped because: kasan: bad access detected
>>>> [   24.407342]
>>>> [   24.407342] Memory state around the buggy address:
>>>> [   24.407342]  ffff8880be451f00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>> [   24.407342]  ffff8880be451f80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>> [   24.407342] >ffff8880be452000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>> [   24.407342]                    ^
>>>> [   24.407342]  ffff8880be452080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>> [   24.407342]  ffff8880be452100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>>>> [   24.407342]
>>>> ==================================================================
>>>> [   24.407342] Disabling lock debugging due to kernel taint
>>>> [   24.451021] Kernel panic - not syncing: panic_on_warn set ...
>>>> [   24.452002] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G    B 5.4.17-2102.200.0.0.20210106_0000.syzk #1
>>>> [   24.452002] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
>>>> [   24.452002] Call Trace:
>>>> [   24.452002]  dump_stack+0xd4/0x119
>>>> [   24.452002]  ? ibft_init+0x102/0xb8b
>>>> [   24.452002]  panic+0x28f/0x6e0
>>>> [   24.452002]  ? __warn_printk+0xe0/0xe0
>>>> [   24.452002]  ? ibft_init+0x134/0xb8b
>>>> [   24.452002]  ? add_taint+0x68/0xb3
>>>> [   24.452002]  ? add_taint+0x68/0xb3
>>>> [   24.452002]  ? ibft_init+0x134/0xb8b
>>>> [   24.452002]  ? ibft_init+0x134/0xb8b
>>>> [   24.452002]  end_report+0x4c/0x54
>>>> [   24.452002]  __kasan_report.cold.9+0x55/0x77
>>>> [   24.452002]  ? ibft_init+0x134/0xb8b
>>>> [   24.452002]  kasan_report+0x14/0x1b
>>>> [   24.452002]  __asan_report_load_n_noabort+0xf/0x11
>>>> [   24.452002]  ibft_init+0x134/0xb8b
>>>> [   24.452002]  ? dmi_sysfs_init+0x1a5/0x1a5
>>>> [   24.452002]  ? dmi_walk+0x72/0x89
>>>> [   24.452002]  ? ibft_check_initiator_for+0x159/0x159
>>>> [   24.452002]  ? rvt_init_port+0x110/0x101
>>>> [   24.452002]  ? ibft_check_initiator_for+0x159/0x159
>>>> [   24.452002]  do_one_initcall+0xc3/0x44d
>>>> [   24.452002]  ? perf_trace_initcall_level+0x410/0x405
>>>> [   24.452002]  kernel_init_freeable+0x551/0x673
>>>> [   24.452002]  ? start_kernel+0x94b/0x94b
>>>> [   24.452002]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x1c
>>>> [   24.452002]  ? __kasan_check_write+0x14/0x16
>>>> [   24.452002]  ? rest_init+0xe6/0xe6
>>>> [   24.452002]  kernel_init+0x16/0x1bd
>>>> [   24.452002]  ? rest_init+0xe6/0xe6
>>>> [   24.452002]  ret_from_fork+0x2b/0x36
>>>> [   24.452002] Dumping ftrace buffer:
>>>> [   24.452002] ---------------------------------
>>>> [   24.452002] swapper/-1         1.... 24564337us : rdmaip_init: 2924: rdmaip_init: Active Bonding is DISABLED
>>>> [   24.452002] ---------------------------------
>>>> [   24.452002] Kernel Offset: disabled
>>>> [   24.452002] Rebooting in 1 seconds..
>>>>
>>>> Why does KASAN think the address is freed? For that to happen that
>>>> memory should have been freed. I don't remember any similar false
>>>> positives from KASAN, so this looks a bit suspicious.
>>>>
>>>> I'm not sure why KASAN thinks the address is freed. There are other modules where KASAN/KCOV is disabled on boot.
>>>> Could this be for a similar reason?
>>> Most of these files are disabled because they cause recursion in
>>> instrumentation, or execute too early in bootstrap process (before
>>> kasan_init).
>>>
>>> Somehow the table pointer in ibft_init points to a freed page. I
>>> tracked it down to here:
>>> https://elixir.bootlin.com/linux/v5.4.17/source/drivers/acpi/acpica/tbutils.c#L399
>>> but I can't find where this table_desc->pointer comes from. Perhaps it
>> It is what the BIOS generated. It usually points to some memory
>> location in right under 4GB and the BIOS stashes the DSDT, iBFT, and
>> other tables in there.
>>
>>> uses some allocation method that's not supported by KASAN? However,
>>> it's the only such case that I've seen, so it's a bit weird. Could it
>>> use something like memblock_alloc? Or maybe that page was in fact
>>> freed?... Too bad KASAN does not print free stack for pages, maybe
>>> it's not too hard to do if CONFIG_PAGE_OWNER is enabled...
>> Hm, there is a comment in the acpi_get_table speaking about the
>> requirement of having a acpi_put_table and:
>>
>>
>>   * DESCRIPTION: Finds and verifies an ACPI table. Table must be in the
>>   *              RSDT/XSDT.
>>   *              Note that an early stage acpi_get_table() call must be paired
>>   *              with an early stage acpi_put_table() call. otherwise the table
>>   *              pointer mapped by the early stage mapping implementation may be
>>   *              erroneously unmapped by the late stage unmapping implementation
>>   *              in an acpi_put_table() invoked during the late stage.
>>   *
>>
>> Which would imply that I should use acpi_put_table in the error path
>> (see below a patch), but also copy the structure instead of depending
>> on ACPI keeping it mapped for me. I think.
> Hi Konrad,
>
> Thanks for looking into this.
> If ACPI unmaps this page, that would perfectly explain the KASAN report.
>
> George, does this patch eliminate the KASAN report for you?

Hi Dmitry,

No luck with the patch. Tried high level bisect instead. Here are the 
results:

BUG: KASAN: use-after-free in ibft_init+0x134/0xc49

Bisect status:
v5.11-rc6 Sun Jan 31 13:50:09 2021 -0800     Failed
v5.11-rc1 Sun Dec 27 15:30:22 2020 -0800    Failed
v5.10 Sun Dec 13 14:41:30 2020 -0800           Failed
v5.10-rc6 Sun Nov 29 15:50:50 2020 -0800    Failed
v5.10-rc5 Sun Nov 22 15:36:08 2020 -0800    Failed
v5.10-rc4 Sun Nov 15 16:44:31 2020 -0800    Failed
v5.10-rc3 Sun Nov 8 16:10:16 2020 -0800      Failed
v5.10-rc2 Sun Nov 1 14:43:52 2020 -0800      Failed
v5.10-rc1 Sun Oct 25 15:14:11 2020 -0700     Failed
v5.9 Sun Oct 11 14:15:50 2020 -0700              OK - 10 reboots so far 
w/o kasan failure

So, will look at what changed between v5.9 and v5.10-rc1

Failure is intermittent, so takes a lot of retries.

Thank you,
George

>
>
>> CC-ing Rafeal.
>>
>>
>>  From c37da50fdfc62cd4f7b23562b55661478c90a17d Mon Sep 17 00:00:00 2001
>> From: Konrad Rzeszutek Wilk <konrad@darnok.org>
>> Date: Tue, 2 Feb 2021 17:28:28 +0000
>> Subject: [PATCH] ibft: Put ibft_addr back
>>
>> Signed-off-by: Konrad Rzeszutek Wilk <konrad@darnok.org>
>> ---
>>   drivers/firmware/iscsi_ibft.c | 19 +++++++++++++------
>>   1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/firmware/iscsi_ibft.c b/drivers/firmware/iscsi_ibft.c
>> index 7127a04..2a1a033 100644
>> --- a/drivers/firmware/iscsi_ibft.c
>> +++ b/drivers/firmware/iscsi_ibft.c
>> @@ -811,6 +811,10 @@ static void ibft_cleanup(void)
>>                  ibft_unregister();
>>                  iscsi_boot_destroy_kset(boot_kset);
>>          }
>> +       if (ibft_addr) {
>> +               acpi_put_table((struct acpi_table_header *)ibft_addr);
>> +               ibft_addr = NULL;
>> +       }
>>   }
>>
>>   static void __exit ibft_exit(void)
>> @@ -835,13 +839,15 @@ static void __init acpi_find_ibft_region(void)
>>   {
>>          int i;
>>          struct acpi_table_header *table = NULL;
>> +       acpi_status status;
>>
>>          if (acpi_disabled)
>>                  return;
>>
>>          for (i = 0; i < ARRAY_SIZE(ibft_signs) && !ibft_addr; i++) {
>> -               acpi_get_table(ibft_signs[i].sign, 0, &table);
>> -               ibft_addr = (struct acpi_table_ibft *)table;
>> +               status = acpi_get_table(ibft_signs[i].sign, 0, &table);
>> +               if (ACPI_SUCCESS(status))
>> +                       ibft_addr = (struct acpi_table_ibft *)table;
>>          }
>>   }
>>   #else
>> @@ -870,12 +876,13 @@ static int __init ibft_init(void)
>>
>>                  rc = ibft_check_device();
>>                  if (rc)
>> -                       return rc;
>> +                       goto out_free;
>>
>>                  boot_kset = iscsi_boot_create_kset("ibft");
>> -               if (!boot_kset)
>> -                       return -ENOMEM;
>> -
>> +               if (!boot_kset) {
>> +                       rc = -ENOMEM;
>> +                       goto out_free;
>> +               }
>>                  /* Scan the IBFT for data and register the kobjects. */
>>                  rc = ibft_register_kobjects(ibft_addr);
>>                  if (rc)
>> --
>> 1.8.3.1
>>

