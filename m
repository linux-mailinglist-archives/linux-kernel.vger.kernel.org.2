Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025B631DF30
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 19:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbhBQSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 13:42:59 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39702 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbhBQSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 13:42:51 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11HITg26019436;
        Wed, 17 Feb 2021 18:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZYYhpipuCXyXP5WOR2qcgQekf/ZD7O/jUrzM7MUGkNg=;
 b=GEnumeZq4YIf4PrQ/5sx9gYyMAT4BSe0dRHi+e/mwMAl1zJx3X08WGvUUEIJk+2DNxjz
 e3zihYdEl6eraUlA4Hs0Axu0AdGmAJj9ciE7VV6MWLdIrN1DS4uV367uzTCyu3ekJ5Sz
 Dff3/EJ+5DfdbOsbyjQZClvCWFc99/Uo7Qs6YXlYZxU8cidTNHChPVQg7wmZ6CPyW1DK
 kO6FrWoriWtUxk2pVSv8JGFHKraQeXTRrtenb8Lybfl3LDm10a1GDN2jST/Dxi0e1bQh
 HKoECO4/SF+BRevON0FKytIEPgyQCvc7eZwIpaXUEcex9NgP5OvJQEkd7kjHUP08GFJf 6g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36pd9aaxfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 18:41:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11HIU8fI178909;
        Wed, 17 Feb 2021 18:41:04 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by userp3030.oracle.com with ESMTP id 36prpyfv4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Feb 2021 18:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOQmyRm8pt2aIqYw5fkCjUfPljBoJerWvqu/mFSRreWzRn8GqwGyLHAf8EWxboJ490kKSoOECuTO5gAHxfaU3h4TbtSz7WqIFOil9+/UkXrMYh4t+Wf0R0ZDFdQ5rNpCSvjCbY4b0j88PpP/OWQ1WU5HwLigIEYrElhT6PDF9J4OFbVYgTmeD4MopdBBXtrC11wtsu8PZwxmQEVgblyca8hqoZ4R5WTOh8lQWx0BkRdZ/vSF0BpRkm0xnA2JpJciLJy0gD00EH5o+ooHETayVu3K6OaVCK1W6Y2UIP9xBdJO9VHT1//NnojOonzIUYHtnSfr+Hg4q9MGrjN78VZAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYYhpipuCXyXP5WOR2qcgQekf/ZD7O/jUrzM7MUGkNg=;
 b=XffUvMTuGKqr+oF/IpK0cjJqE+I7bbPqg0/1+8HOu9uFNYGZSRUbiJ5rH2d3Azwpx6xhAW8ylPZDL8udxQ2V8XTgEFcUQYec8yq2SoE6MCc+h+ec+Oo4V9Gu22lA2y4B+ispk+iC6/haVBvEY2sa6+Fg9DRFbYmSapD1TRvBqe/o4KyGtMJ12yNVk/DgfjqwIQxuO/oaknZeE6zQoljwZXXTWWu0JQYFvFFJmJ94zXr7Am7PM9MPlVf6OX+s3q7AIQTa5z5+St6kuIA2ZQnscFzsRt/qcyASZgc5bTY6SJfay5iBWXJKYMEq7o1UMNLivs7PvbHDGtXWU+nj88T2AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYYhpipuCXyXP5WOR2qcgQekf/ZD7O/jUrzM7MUGkNg=;
 b=n+Rwsv7r3CXBIXV+K79TtRimOWowGYAVjE4mjJf3gR9U0VSUx3sL5rmIgR1ZgWrJwzZz1/p8FyWvb+02LQRwt405T0edGsnOw22Z/nuZWBM72yqrnbWdzwFnbC/5SJ25k+4vyZpf7olsdNt5UWyotcGVp/q+b1khNPy9dh726to=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR1001MB2062.namprd10.prod.outlook.com (2603:10b6:301:2f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 17 Feb
 2021 18:41:00 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::50a1:9424:e4df:af22]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::50a1:9424:e4df:af22%4]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 18:41:00 +0000
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for vmcore
 creation
To:     Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
From:   john.p.donnelly@oracle.com
Message-ID: <77fcb8e8-c3ec-6161-14a8-c142e02a9061@oracle.com>
Date:   Wed, 17 Feb 2021 12:40:43 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [47.220.66.60]
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-175-47-46.vpn.oracle.com (47.220.66.60) by AM0P190CA0022.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 18:40:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c8b38db-5e46-42d0-b9c4-08d8d3739235
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20628A06B2D12FF08AA79EA3C7869@MWHPR1001MB2062.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n15JLS5rsTo99gCEth8coWL85OnHRY3q3IG06QPNIadXIqNvxbyoCkFOF/rle8cLfaxS/EFYZB3eEWvpLK6xQSPAylaV41xeJRkbf1QMvWWWG0V5MabuJTEuvYREiQ4VJ8lnxXn3B+YT2UnRsVjfCN7C8/XQBoLCsobm2QCJO3fCWlDmBjAAzxcnPWPz+pI0ZF6P5jV9ASc0nG6icopD+1pdAACRzZz0PlqxKCV8hSYUPWhlnUJ2N5G5wzQ3prquJDp3e2U0iEEPz5Zigcggsv8/h3Z5dgDfO+sEK52/+0HwcopMQebpjADTgSSyeA2xpKs4x3quVFcEEY3TVh6h+eKJMQcqzWqduD2p11vl1TFD0I0I5onktBvZAVj6LR+0JB+t2F5Aqzs/bFqpZGjbynOEwrE8xFj5o+ijXSPkWAIRPKo6Y962KDW6Bg998bIhbbvoeOcGOZV2lzQNv1hYcE9YD5yKKGun/WIKMaLyjGwpeL9sjA9gOkVId48utFmbyHoTkpG6EFU9mzZNt8CkUeuUhGWt/eQ9kJaaQa8fgXQS0xk45fCbPSDpfLIvQJ21++TI3wqWuk5cPcFrJqIvJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(136003)(376002)(39860400002)(54906003)(66946007)(86362001)(478600001)(316002)(9686003)(7696005)(4326008)(66476007)(8676002)(186003)(2616005)(66556008)(16526019)(83380400001)(31696002)(6862004)(7416002)(26005)(956004)(6486002)(37006003)(2906002)(6666004)(5660300002)(36756003)(8936002)(31686004)(53546011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?U0lSZWdUSVU3d2E2UlJ0NTZMZDBHSjljQm9oT0ozRnZLdkRTa3RwVndUalN6?=
 =?utf-8?B?M3FnUUlwVFdwUklBaGowWlhyWWhvZWNQdE92UXJ1TmhseURTb2RUaUtyQ00w?=
 =?utf-8?B?QmpVTUcxbkxSeEtET09JWDNsVWc4Vjcwa090Z21ldEh6VkRUVXFnR21Wam1D?=
 =?utf-8?B?aTdHT2hlaDNWSzB1TTlPcjZkR3phaTJmdTRuTUROektzRS8rTkFZaktwWll1?=
 =?utf-8?B?OU5KTnRoQ1NkeitWSGFzY3Ira0NaZFAxK3I1T0VHOGs3emEvY0x3M3BvVlpQ?=
 =?utf-8?B?WFdxMU5HdWxEd1VoS2lOQVhqV3hINFp4dXhZMGNIOUNIWTdGckhBT2UvbzFT?=
 =?utf-8?B?eFVxQ2Y3NzNyWWJzOWEwSCt2NW9YemhvRG44SUNDQklTZENsUldvQThMcGtB?=
 =?utf-8?B?OVdwR2FFRkg1S0dxRHJCWHJKT2lBc2puc24zOHJJUzdlRVdXUFBUbHNXbmRl?=
 =?utf-8?B?MjExUUhCYW15OUR5U24rbXkzcmFZMXRJVjhDRDhGa1ZJVGVTTFJZVmZUZVRp?=
 =?utf-8?B?VUVBU29uNnI0QnYyT2F4SXhTMnB6RHJKRk90VFM3Rk5DRkQwTWY5QlRVZ3Q3?=
 =?utf-8?B?YWgzeTNGZXV2Q3NrcnVKQmtHT1ZrYVRYTDlYTXdGRmNLZjkxZUtxa0NVU3pk?=
 =?utf-8?B?emppdXNvTTdXQnNtMUtWWWFNYTZDNS9oTlFtbHlHd2NBVThwcGhPUTVZV1Iz?=
 =?utf-8?B?ZlljR3BidytWQzh4ODdxYmdoeFFWSk9xSHNGczMvd0pxRXRpRTBIM2tESE1p?=
 =?utf-8?B?ZUlrRjIveDRWVjJlM1ZxMlFHVU5pUUtIUlFjUU01NTA5enlRclRKbUJpeFpq?=
 =?utf-8?B?K2lqYXY3dTc4NmZsSS9NTFJmYmxSSWppTVhJU0p4K1llekY5MytEZjdlZUhM?=
 =?utf-8?B?TGtwMmcwaVpjdU9NU1pJZ2NsbC9qNXFJblJ2L0JqNHZJdWNjcjB5VElGSmN6?=
 =?utf-8?B?WGE5ckdiR3pXamdINE9YKy9BMlQyUGMwR3VZaFNNK1U3VzZ6azdxMWpzc2FE?=
 =?utf-8?B?eWI2dmswM05IYlpGS2lpbVBkSlRUenlHMjY4NWoxdDRvZWs5Zy81dTRIM0Yv?=
 =?utf-8?B?SC9PRW1hWnA4OHBQZUxYeDc5cXd5QUFHaFhseUJwK0VPcjh0NnlEc1ZScnAx?=
 =?utf-8?B?Q0NPWVlhU0ZqRWRyUXZ6aExTU2FBNjVBa01NM3RPcE1QK2xKRGNQWjE5TllF?=
 =?utf-8?B?aDVrMTdmOTFwd3R6SW40QTFURnpaM1NQL2x0SGx4d3dpWFRiYzl2TjdOUmp1?=
 =?utf-8?B?dXU2RDY5YkpvRnR2UC9QdFIvZ09NNGVaTnc2Vk5kTjMxQk92ZjNjNUZ6cndH?=
 =?utf-8?B?UWpmTnY1Q1BxSWtyOW9hOFJNVTk0bUZUY29uUGZTSVJPQm9scmdUeW5EL3NN?=
 =?utf-8?B?TmVpME5oRkZyN0gvOG9QWWJOanJpL3Ywc0lHNDNMSXdtT2NCdnhrWGwyaFds?=
 =?utf-8?B?djR5R1V5ODM3VXJqZ1g3YlZqcis5OTZaSTltTnJnN01wVFZSYVNHK2s2Wmhu?=
 =?utf-8?B?b2pmaldnNGdGRmVpWTJkem81d0R2ZGlUWURZM1hyUXVuYklaUjdUckcvZmM5?=
 =?utf-8?B?dE9CaVpUeTBobzh5bEJaMGJkNDd3NEpza2E5em5EamM2SkJCbHh3dUFjaU9Q?=
 =?utf-8?B?TzkveW1NeEx1L0VPWld5OXR5ZmFUUk5sdVZOMFBzS1czVGZZK3Jpenp4czhG?=
 =?utf-8?B?aGZQZi9HK21IeHhIN1FUVk5iK21FNnA4UUhyY1hDT1YrNVl0aEJKd2c4L0hG?=
 =?utf-8?Q?90Z0oQUwPdjuoseE6FScG9WYkF11AAINEOHgEwJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8b38db-5e46-42d0-b9c4-08d8d3739235
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 18:41:00.3227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ac895lECDl+WuDRCg20VKDRONTTocKJTbDdnpq/DrejkxQBkSW+nkAQ9ys7mvcSA8q36zuyZeEl1P4cI2LO5ROqKEYLZA7QCj4K/B2iNjt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2062
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170134
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9898 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102170134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/21 12:08 PM, Saeed Mirzamohammadi wrote:
> This adds crashkernel=auto feature to configure reserved memory for
> vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
> different kernel distributions and different archs based on their
> needs.
> 
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
> ---
>   Documentation/admin-guide/kdump/kdump.rst     |  3 ++-
>   .../admin-guide/kernel-parameters.txt         |  6 +++++
>   arch/Kconfig                                  | 24 +++++++++++++++++++
>   kernel/crash_core.c                           |  7 ++++++
>   4 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 2da65fef2a1c..e55cdc404c6b 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -285,7 +285,8 @@ This would mean:
>       2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>       3) if the RAM size is larger than 2G, then reserve 128M
>   
> -
> +Or you can use crashkernel=auto to choose the crash kernel memory size
> +based on the recommended configuration set for each arch.
>   
>   Boot into System Kernel
>   =======================
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7d4e523646c3..aa2099465458 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -736,6 +736,12 @@
>   			a memory unit (amount[KMG]). See also
>   			Documentation/admin-guide/kdump/kdump.rst for an example.
>   
> +	crashkernel=auto
> +			[KNL] This parameter will set the reserved memory for
> +			the crash kernel based on the value of the CRASH_AUTO_STR
> +			that is the best effort estimation for each arch. See also
> +			arch/Kconfig for further details.
> +
>   	crashkernel=size[KMG],high
>   			[KNL, X86-64] range could be above 4G. Allow kernel
>   			to allocate physical memory region from top, so could
> diff --git a/arch/Kconfig b/arch/Kconfig
> index af14a567b493..f87c88ffa2f8 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -14,6 +14,30 @@ menu "General architecture-dependent options"
>   config CRASH_CORE
>   	bool
>   
> +if CRASH_CORE
> +
> +config CRASH_AUTO_STR
> +	string "Memory reserved for crash kernel"
> +	depends on CRASH_CORE
> +	default "1G-64G:128M,64G-1T:256M,1T-:512M"
> +	help
> +	  This configures the reserved memory dependent
> +	  on the value of System RAM. The syntax is:
> +	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> +	              range=start-[end]
> +
> +	  For example:
> +	      crashkernel=512M-2G:64M,2G-:128M
> +
> +	  This would mean:
> +
> +	      1) if the RAM is smaller than 512M, then don't reserve anything
> +	         (this is the "rescue" case)
> +	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
> +	      3) if the RAM size is larger than 2G, then reserve 128M
> +
> +endif # CRASH_CORE
> +
>   config KEXEC_CORE
>   	select CRASH_CORE
>   	bool
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 106e4500fd53..ab0a2b4b1ffa 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -7,6 +7,7 @@
>   #include <linux/crash_core.h>
>   #include <linux/utsname.h>
>   #include <linux/vmalloc.h>
> +#include <linux/kexec.h>
>   
>   #include <asm/page.h>
>   #include <asm/sections.h>
> @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
>   	if (suffix)
>   		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>   				suffix);
> +#ifdef CONFIG_CRASH_AUTO_STR
> +	if (strncmp(ck_cmdline, "auto", 4) == 0) {
> +		ck_cmdline = CONFIG_CRASH_AUTO_STR;
> +		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> +	}
> +#endif
>   	/*
>   	 * if the commandline contains a ':', then that's the extended
>   	 * syntax -- if not, it must be the classic syntax
> 


Hello.

Ping.

Can we get this reviewed and staged ?

Thank you.

John.


