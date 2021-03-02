Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD832B72F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 12:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356660AbhCCKr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 05:47:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33714 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2361004AbhCBXJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 18:09:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122N4MWF178354;
        Tue, 2 Mar 2021 23:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QMW/bCx+ONn4EysZhsoz7sB1ft493wdWNk5HcDZwF0U=;
 b=cc9DrWeeFeUA2r8CBVfwzDbI8NkneG85Xllhrpm6MabTDzs9sQEuu4Xn7Rtt6JgYI6LL
 HZurwEt3iLWgXunmwMwA5hR3CANTALAbqLv8uuk0KnivZ6NvTvZmusOFyz6FKKlilDSG
 zdt1tJs0xHCGl/CDsSn2SEMdCDoekSx+2hvG4wY25xy3KePuwGtvXNAnVwMmoq07QJ3U
 ES/L+5rhVT3tWeDH7YZwaJXbKvRPdrT+hcDMECth0LLvNpQCXyJyPZb+0b6QgAK12Rkd
 eBUGtEmiymXCHw9usaiY7M9IO7vbNgQqxAa0KbbOPV/Fk0O+YZV6QRoWrJdATnCFK4dw gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36ye1m9fe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 23:05:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 122N4wcg124606;
        Tue, 2 Mar 2021 23:05:56 GMT
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by userp3030.oracle.com with ESMTP id 37000xnu2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Mar 2021 23:05:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9NnFHeEbdW3w6g10VpnlhenLy87REUVkvUgw000tLVnUmid6Ogk3KwXCinqdF6NsTxhuLXhMFzSQp4dDtNLKgtj+InTGTBp3pmmIFpunQ2Bpa4WPyvgvYMig++JjdCNE8X7oCtZyre3N3hXttOGvLDLItWDwoNQTlCsQUf5RFNivBk6BV6zM6DJ2LUafewc7L7L/9JLyZHokb8A5JjF3iUJc8TDm0uTB97kTsBd4RIzsRPdewbpM9X15RSbhU840HJkCtjY1Uu7zc1r0CCPXFSLGMIIlAbdh7kAoIc0iB8wq/twGaQR/9I2P13XC8KqN6BFDJPo85dOOLQ/D5cXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMW/bCx+ONn4EysZhsoz7sB1ft493wdWNk5HcDZwF0U=;
 b=QznStAtEa4Qcp4Sa25jsR6gyyZECR55Fe1ubpQ+eQFkTgEuYai0oOLuc+cdJf/7gDfKEQtL4x0qCpikBXeLVh8DhYJfhf5H8d7yDqgevHQvVGMANFfBRDW7qfMT1Ov9IUYR18rXCLam8Nr4W7pK9bC/Iq3aml++GoPCOEBeN7+x3MeAJUS+tyg/MJsQMXkODZ7yvmXWBdUGgF/8VdBzX8tTpgCHsPNbsW0jftBc6OMSbu0oKs0OKq/8DNFK/vP46Wv2biDMepeZtw5mw8CCur9YyUvXY20fedM/Pv7s8QMYD+RwdwKruAChYf64EbyXX8jit9Ls5z4XV3VZbiG87lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMW/bCx+ONn4EysZhsoz7sB1ft493wdWNk5HcDZwF0U=;
 b=LFVlRKtRQaE1bVdahfwUh5TIJRsIoK9mrxCUkzpzkEzGyf/TeXmST96EOkBkBCQFjPhjFTrW6A9oYJXAxOsOeAZOyttyuffZV/dsQtwvxnPNm4Z7kpwYAGub2u2c+ZIIGiuEzZdtFdDHnP3uuGF83m4gcx0C9TewjJEMwBDtrFQ=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1280.namprd10.prod.outlook.com (2603:10b6:301:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 23:05:52 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::50a1:9424:e4df:af22]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::50a1:9424:e4df:af22%4]) with mapi id 15.20.3912.017; Tue, 2 Mar 2021
 23:05:52 +0000
Subject: Re: [PATCH v4 1/1] kernel/crash_core: Add crashkernel=auto for vmcore
 creation
To:     Dave Young <dyoung@redhat.com>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
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
        YiFei Zhu <yifeifz2@illinois.edu>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20210223174153.72802-1-saeed.mirzamohammadi@oracle.com>
 <20210226003822.GA2953@dhcp-128-65.nay.redhat.com>
From:   john.p.donnelly@oracle.com
Message-ID: <7718c1c5-63c7-6180-1a88-e28ce6f16ebc@oracle.com>
Date:   Tue, 2 Mar 2021 17:05:34 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210226003822.GA2953@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [47.220.66.60]
X-ClientProxiedBy: LO2P265CA0332.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::32) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-175-39-154.vpn.oracle.com (47.220.66.60) by LO2P265CA0332.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Tue, 2 Mar 2021 23:05:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 602d842b-99ee-4c7a-ac8e-08d8ddcfb977
X-MS-TrafficTypeDiagnostic: MWHPR10MB1280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB12800F6C52A6C694B7ABFD6FC7999@MWHPR10MB1280.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r/aMbDVJ0of16FWITpXdFKC3sza1q4nTzWcgk+7+vWiNjlmbSKYstFo54+aZPr9QQEqOQAH6d96b729tl/JTHfq8cLjBlM30U5FG2VQu6/5V0BR3JtOl/0L3mj++fDRifwJF99jOqWnhwIP92NEe6T3tDlhwfk34WI+Luj6ivD+NtV+wWxlfk/Ya9XXrOjfU/3eyoYOtPNwqwGMYeKGTwggMjooj3Bx72vLznudG98fFGrco5AgT0YQ/h8kKjDauq22mLbhCDv2vWO8iqZYGaypbIQxljyEaeLgnFBZc7Vp45sLKBrbqpLOkVxfGz9aZC5uftfpqcQWeZM4FnNIhaiwoN1uBlZ67UenmXRscWR3FpOiuAke6NaSVVuGcmiUO+EvNnAkDo0y6YN32+JWRXD+03FtwVaBWnb6P9y4p8Ppiyge0FNtaotooLk8Z6hvlngtAxNTQ6tgMgekWg5gbIhWw12plkR3QxB6s0AdnS802heKp2cFHOFrYE8cAthU6+R3tQR7ck3qeZilPI2OeVUjTz2QqTzIQ1HBjRc1x6sCE5A7MsW9F0bUcLsDJC99cmV5CWyrQ/9UwHQaYdWJT7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(26005)(4326008)(31696002)(16526019)(36756003)(2616005)(478600001)(186003)(956004)(9686003)(107886003)(66946007)(5660300002)(66556008)(66476007)(7416002)(8676002)(31686004)(7696005)(86362001)(8936002)(83380400001)(6666004)(316002)(6486002)(53546011)(54906003)(110136005)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TkQ4VlZ4SjZPZTBRQkJFbXVkN2dPL2lSVUlyMEpHcXVOaUIrd1NpZTZmbFR6?=
 =?utf-8?B?WEJ0TmtTbEdQWGFXbE9iRHZEcmh6RVh3WHIzblYvdEpGeEJLZEp4b2ZLQTVZ?=
 =?utf-8?B?eFYvaWZIanh5TG8rNDAxTUFzVTNpWUxjQzRMY3pjS0FyZWFHakhhbXNCZ1JY?=
 =?utf-8?B?TEppYnczS2kvVGlpQU5tM24yVmpFV0hQYmp4czA5bnZldEppMVFONElpcCtZ?=
 =?utf-8?B?bEFNTm5iWE9YS0NWSm83K05XekdnZFFKTjMyOTg1MHUxandkdHlHenhjMWtB?=
 =?utf-8?B?azIxZUQvbTFjaHpvdFIzV2kwa2g5NE9MdWRWOTRVWTlPM3lVdzM2UC9QTm5P?=
 =?utf-8?B?S293WFcxZ2xQbzEvZTNVR2NBNG9Dcjh2WEZpNklqQlFZZmxVR1pNKzcxN3dO?=
 =?utf-8?B?NkxockUwWE5jZEVhTVdNbDZua3pXWlVRMFpNbFBSWGJBM0ZkamhnMkJCemp0?=
 =?utf-8?B?NU1WOE15TWhselhiQ0g0MEQrdWRhWThhM0taV2ZYeUhQVDRZeVNBMzdHY0NR?=
 =?utf-8?B?MjRPN0Q4SmZnOU4zTUE0VStRblVJSVJEYVFVWUJka2g4QUxzeHI2Z3NKcXBh?=
 =?utf-8?B?WGZ1LzVhMHR2TklMMEltZmFVRlFGSUdMUll5UUVzb0VmUGdBVHNDT09mbU1I?=
 =?utf-8?B?d1JMUWxDUzAzc1Y2VjBVMmU5TnVuN2VaZTRnZVpFWEUyVUZZTjZ0RlpQS2gv?=
 =?utf-8?B?a1czbm9pRStjZ2w5Uk1rR0RHMm9peG8yWnhpOUovTi9UTTFyN0NWenRRK1NC?=
 =?utf-8?B?UVFmWDl6NDBlSlZVT2NXQUdMTGt6b1ppbXc2TFBEZzJQMHpaVER3aG91QXlx?=
 =?utf-8?B?YUpzVUxXdG1OYWlnUHJ2M0IwcUlya01kaXF3eWhKQ21wSERGV0p1ZEZjN2x0?=
 =?utf-8?B?ejFkNU5PVm9GZ0JFSUk0SHRXc1RlNHhDUE4rbXE4ZnY3eDkwd0NqRWRPSWp0?=
 =?utf-8?B?ZFdVSXQweEhIdjhGWU9FOUxmMFdjMjMzcTJwbndYTlhuMGQxN0RzeHZXRmNT?=
 =?utf-8?B?eVNsTTJySlFCa3hmak1QbTNzc2gzT3Z4VjZraXVqdDJibWFkM2pMaHZCS2R6?=
 =?utf-8?B?MllaVjNBaXpjZisrdjBLc3Rkc2o2V3VIazVkdGVZRkZ3bzJXVTFXSTdmYkFY?=
 =?utf-8?B?dU5FbU1mTWVYaEVaWXhQbUl0T0EyZGZuLzdpaDBlRG9KbGVSRkFyNFdsWmpM?=
 =?utf-8?B?QmtWYUl0MDlGVzlIWSsxWW1EenZOWFZXa2ZLd3hGMGhjQlFLYXp2S2lhRTk5?=
 =?utf-8?B?S1JDalVyZW1qOEc3UzhKVk9JekdNZ0J3bzFCMVIyb0swbWNsWTJLeVkwYUhi?=
 =?utf-8?B?UDRYVWV0TXdBdUUvUkliMkdtdE1ncXlqNGxLeHdtMWR6VHN0UjdXczR6WWdz?=
 =?utf-8?B?cDNuaWJmU3RSMUFxNnN5aERkV293elhrMis2N1JKSjcrUzk3VWZwME0wNDhS?=
 =?utf-8?B?VDB1bXpEc010a09zY2g4UUtOaTU0bmEzV3d6bDBSdEs3WUxnZUVNQmVKU3FJ?=
 =?utf-8?B?ZGJITmxOek0xcHhCRit1cDIwZ2lDd1NuQlJvNVIxbVBuQmh4WE5EMUp3UThj?=
 =?utf-8?B?aTQ5eTZoejZCeDRYWW9DT0pSUWUraWM5UkJLVEFsbG5XaWJ2SEc0WFNLaTRR?=
 =?utf-8?B?RWhqVEllWGs1K2tVUzRwR0N4MHEwb3ZBRElheFlRb2VqYmY1UGtaenU1Si8w?=
 =?utf-8?B?UjlDb2diU2lZRlRZcXJ5MGtGQlloVS8wUlVjeG1vZUt3eVFRanp3TlppWEhn?=
 =?utf-8?Q?wRIHqmOQn5hTNiScDGvhnAO/vtG2bDaTe6YlO8h?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 602d842b-99ee-4c7a-ac8e-08d8ddcfb977
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 23:05:51.9501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsyq1sVLCAYqSRck3xDD8UPxYYijeqO47vQGg9UKHip83DuoFo5mmHIF8d/VPYvlRTep2G6djHSpRWsO1IQFM7N5skiZWyRDrk3dTvseIcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1280
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020170
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9911 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103020170
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/21 6:38 PM, Dave Young wrote:
> On 02/23/21 at 09:41am, Saeed Mirzamohammadi wrote:
>> This adds crashkernel=auto feature to configure reserved memory for
>> vmcore creation. CONFIG_CRASH_AUTO_STR is defined to be set for
>> different kernel distributions and different archs based on their
>> needs.
>>
>> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
>> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
>> Tested-by: John Donnelly <john.p.donnelly@oracle.com>
>> ---
>>   Documentation/admin-guide/kdump/kdump.rst     |  3 ++-
>>   .../admin-guide/kernel-parameters.txt         |  6 ++++++
>>   arch/Kconfig                                  | 20 +++++++++++++++++++
>>   kernel/crash_core.c                           |  7 +++++++
>>   4 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 75a9dd98e76e..ae030111e22a 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
>> @@ -285,7 +285,8 @@ This would mean:
>>       2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>>       3) if the RAM size is larger than 2G, then reserve 128M
>>   
>> -
>> +Or you can use crashkernel=auto to choose the crash kernel memory size
>> +based on the recommended configuration set for each arch.
>>   
>>   Boot into System Kernel
>>   =======================
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 9e3cdb271d06..a5deda5c85fe 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -747,6 +747,12 @@
>>   			a memory unit (amount[KMG]). See also
>>   			Documentation/admin-guide/kdump/kdump.rst for an example.
>>   
>> +	crashkernel=auto
>> +			[KNL] This parameter will set the reserved memory for
>> +			the crash kernel based on the value of the CRASH_AUTO_STR
>> +			that is the best effort estimation for each arch. See also
>> +			arch/Kconfig for further details.
>> +
>>   	crashkernel=size[KMG],high
>>   			[KNL, X86-64] range could be above 4G. Allow kernel
>>   			to allocate physical memory region from top, so could
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 24862d15f3a3..23d047548772 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -14,6 +14,26 @@ menu "General architecture-dependent options"
>>   config CRASH_CORE
>>   	bool
>>   
>> +config CRASH_AUTO_STR
>> +	string "Memory reserved for crash kernel"
>> +	depends on CRASH_CORE
>> +	default "1G-64G:128M,64G-1T:256M,1T-:512M"
>> +	help
>> +	  This configures the reserved memory dependent
>> +	  on the value of System RAM. The syntax is:
>> +	  crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
>> +	              range=start-[end]
>> +
>> +	  For example:
>> +	      crashkernel=512M-2G:64M,2G-:128M
>> +
>> +	  This would mean:
>> +
>> +	      1) if the RAM is smaller than 512M, then don't reserve anything
>> +	         (this is the "rescue" case)
>> +	      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>> +	      3) if the RAM size is larger than 2G, then reserve 128M
>> +
>>   config KEXEC_CORE
>>   	select CRASH_CORE
>>   	bool
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 825284baaf46..90f9e4bb6704 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/crash_core.h>
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/kexec.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -250,6 +251,12 @@ static int __init __parse_crashkernel(char *cmdline,
>>   	if (suffix)
>>   		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>>   				suffix);
>> +#ifdef CONFIG_CRASH_AUTO_STR
>> +	if (strncmp(ck_cmdline, "auto", 4) == 0) {
>> +		ck_cmdline = CONFIG_CRASH_AUTO_STR;
>> +		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
>> +	}
>> +#endif
>>   	/*
>>   	 * if the commandline contains a ':', then that's the extended
>>   	 * syntax -- if not, it must be the classic syntax
>> -- 
>> 2.27.0
>>
> 
> 
> Acked-by: Dave Young <dyoung@redhat.com>
> 
> Thanks
> Dave
> 
Hi,

   Thank you.

   When can  we expect this to be applied in a future build ?




