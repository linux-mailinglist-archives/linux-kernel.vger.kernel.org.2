Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FD5322409
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 03:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhBWCFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 21:05:50 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34902 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhBWCFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 21:05:38 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11N2098D043260;
        Tue, 23 Feb 2021 02:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=NN8RbRB2jv2ytPx9Xq0vOQkN+I2SFlfEfc4oV+fRNx8=;
 b=XpAp2PYhABZWsmiO6h4MRZK3NzjhdkAlVV0zDtNqW7eo2Eaf7zZxL5FJOAKIaWMyULC/
 9Nc2+io2R/IwWxAnc/PV6bAD7lw9seIwfada2o1Y2Ukc4VZG3ibZjqubjNQttB5iskzx
 Eyru9xIUUi49BinodZMcBDOg8Ct5lwF3k1jY1aYgKY8B9O3mU2+q5R+0IDCvzvLgt9P/
 SCEgB6E20kfeQhObudhpQcNXzr94rYpTpD4vKCvX8+A0N5KrMmfua2OUaRFxOJlSnx3Y
 NAnN0C0PixAi2jiylH+oLRbAVyyCE872MK/Ambjqr1e+KJGdJMnZV0ngAsbp9vPsdfRP sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36vr62011a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 02:03:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11N205sw020128;
        Tue, 23 Feb 2021 02:03:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by userp3020.oracle.com with ESMTP id 36uc6r3ska-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 02:03:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBi8mW43UlXI6KfTpqxXJFemiB+r8gkeDEewFFaco5adSewDyifaRwTLr5xsT8iR4uBh/tcztL6DCBc/NsCA6AZx4utVAs4Bs4OZyICDEeGQR2th5lttzGJa+7KWHF8UjYV7czzisDdGYfOUXgu69X8RjP9Zlq2UjWIVspPz2/eBxsNM9sqOUGGvlhYGIEuGRULRRAHS1rPuSbUX3c2+wDd5zR3L9JfScbE6sQoJ4Osl/Y+m4cfSeR/pWpkBjebFwxsFUvZUujs2XJzhxp4BH9Pp1Vi2CYZIL8vUu9xT4380L0qFQ3JWlS/teWPV/LBC+yCRhrQi0x0KsHopl9/Fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN8RbRB2jv2ytPx9Xq0vOQkN+I2SFlfEfc4oV+fRNx8=;
 b=MZLzrDjrkIKjKregoMV3uxdd2ecxMw9VRxf+gEV6VsH5BEDdq+VF+RFp9xb61wzu6xub/dh3gfDjo8GfAO9MomOVFI44oKHDK+cZatQ8UXgM3bnbAhtJ6pW4WtiU1I/SA60bHT+yQZWebPumzBQtslCSpa38UxpenvvRB+td7obkykAkE7zfSV3CVRk2htKLd9p/NXfznzOVCsiKAQv4GbQNSKhs9m3eIZbG8x6yh8NLepDKKOcO/0ZlBgEnMQrmDLbAnE2oa0KU6fq54exDSoBhzrsoqkWdVzxM8ijo9yYCg1Q9dvg6GmbLspFtNgxptGtKu/ehwh5dAPZwkRlihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN8RbRB2jv2ytPx9Xq0vOQkN+I2SFlfEfc4oV+fRNx8=;
 b=NXKN1rakWRyAZcqPS/AvYsQ/D6W+SnTc6cgHd435fTCD5eARoVwPNh3flqTFxhtc0NLdrTjam9B8dv4cCOUAyhMKe6CekUuBaoON9/t3dMtGKXe8k8R6Fg/HL7Bh5fOG4dT49C9Zq3P1wa7cfPqtbxtUjZFvGExfNLBTcRqRpuM=
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Tue, 23 Feb
 2021 02:03:30 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::50a1:9424:e4df:af22]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::50a1:9424:e4df:af22%4]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 02:03:30 +0000
Subject: Re: [PATCH v3 1/1] kernel/crash_core: Add crashkernel=auto for vmcore
 creation
To:     Baoquan He <bhe@redhat.com>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
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
        linux-kernel@vger.kernel.org,
        John Donnelly <john.p.donnelly@oracle.com>
References: <20210211180814.69708-1-saeed.mirzamohammadi@oracle.com>
 <20210218020203.GC2871@MiWiFi-R3L-srv>
From:   john.p.donnelly@oracle.com
Message-ID: <fcb8e523-e639-1a71-d59d-53b98260ae88@oracle.com>
Date:   Mon, 22 Feb 2021 20:03:13 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210218020203.GC2871@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [47.220.66.60]
X-ClientProxiedBy: LO4P123CA0377.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::22) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-175-0-180.vpn.oracle.com (47.220.66.60) by LO4P123CA0377.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18e::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29 via Frontend Transport; Tue, 23 Feb 2021 02:03:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be85162-72c6-432a-a21e-08d8d79f373b
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45310474A3B61DF495FA0966C7809@CO1PR10MB4531.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uy5PNOMznq9gGtVqKq0zEqUxLsrZyCZliIDVa7UyuyJ/d4Rpcvf6P3ZoBOgjBmv1MCJXs1aGZf+EFpOwMrqHlBwwLbKXgiQQJ6ByvWhCcx4nsD9Xap6kAVtIaKKtyiiY4IqgXbrbkTazTYkQReb+1Ro+PQRqpb1hoTz4T0I0AzSyTB6Qg6h7THa1jUkQfowoAZW15OQQMlyWnZH/BYBvIRAVR+mh88rn+e0NwMJXHkrjSfk28adBUUPZg1ruNzwANQz1FMy+TgLqj7Oaz1QiR1Y54QkJ0bqEF5PKHadWULxf8GpWG2hLaNpX8YbCoewZ89tMso40bzcSTCTPj8jCnL4YC/Ol/sCIit9ZaLsmHxtdWRkNB1F5NWyhxBhvpXVA/nA9yrvudNnEMKS6NRONeMbr+PBx/2Fa0GEe/zFySpWqu4DGf95Iz9e5PR/NpUMBQCtk2ncWP//BPqDDGTwma0CVzioLABUEiyv+io1PF58gW8TzzUdwiljsXmHaz++65cxsgSn0qZbOf713gcTntVbx+nCkVo4xyjqKtmBrKlEAmn9Wz6zbzPxwQ5UMrKfqCgLEDzE8on9aBgZR2iRNWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(376002)(136003)(16526019)(9686003)(53546011)(8936002)(86362001)(26005)(8676002)(186003)(66556008)(5660300002)(7696005)(66476007)(36756003)(31696002)(110136005)(956004)(316002)(2906002)(31686004)(2616005)(83380400001)(6486002)(107886003)(7416002)(4326008)(66946007)(6666004)(478600001)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWc5NktvVWZEYlpha0RwS2p1Z1RqemgrdGxEMUF4UU5VRFllbnRCTUxOMTJr?=
 =?utf-8?B?SGh3MnV1NkVqSXp1bmQrb3JrbUpBTzhoMGFveXdVOXdSYjJ6K3lmLzdoMFZr?=
 =?utf-8?B?TFlmK0Y0RlhERHlOdEY5enZDakV5clZrVnZsQTh2TENDUUo4ODNKRTJyak1H?=
 =?utf-8?B?YTM2eDEza1BhRm9CdjdhTGpMUDFybGw2NDU0YnI2WS9KTjNEYUtDSWNPV0Q3?=
 =?utf-8?B?Y3BFaUEvZFB0a1lWTFJDNmFWR0dTSDd6dFVMVUUvejRaZ0VzcHlhcWc5OXMx?=
 =?utf-8?B?UlNJNWErZXZ0dWxzR1doN1JzWjRxM0I4algyUGhRK0JOejdHU2U4TjdmOFov?=
 =?utf-8?B?dlhqVlpqNkptM1VWb2dMdWtPVk5iQ3JMdDc5VTAzNkkxN1RydmM2bzB2eWFF?=
 =?utf-8?B?bWNzT0l5MURKSFQrMllNcEo2UVJHdEtYanpMSTVkc3Ryd3NMSG5QSEtrZ0xy?=
 =?utf-8?B?WlJ0TzFUdWF5R25wRTV0emdNMXRrOHh4WFp1RWllTTg0MXNYc0NOR09xK2E0?=
 =?utf-8?B?RHhGV0YwdE4xNzVaNTFtUUR6OWxnRW5TLzdDS215Rm1SczViNjVKSk5LNExX?=
 =?utf-8?B?cjJ4WEppcWN5eVFMWVFNd3cxODRGU1JJZ2Y3UlJQczZLU1h5MmNXc0VHajBJ?=
 =?utf-8?B?aTQwNGh0TlUwQ2MrTS9DbkVYczRvYzFyK3BZWUhoTlViV2xTZTk1dG1DaXZy?=
 =?utf-8?B?YThrTzJscTIwZkNaVG14cUdmR1Mva0JKK2YyYm5aUEtKZ0kxNCsxVS9VNWdr?=
 =?utf-8?B?UDNibFgzSFRFcDdLL3hKa3kyVkFjUVU4TGlNdXBEeFV4b3RlYVEwWGNLaXZR?=
 =?utf-8?B?YUZJeHpYSEpSbXhvei95NU5vM2plUlMySzgxRU5JZnNqVUxYTVpLdkhmaW9I?=
 =?utf-8?B?RHkwaDVSamhzdXd3ME9QVnhTdldYTm1uaEtOR1RvRGFvVnpNaEhqaks1L09I?=
 =?utf-8?B?T2UyMjd1aEl0Q1FvaHdWb09hOWhvNU90VWJvL1B1bUJFYWxRd0tRd0RlTXcz?=
 =?utf-8?B?dTZsY0FCRjg5TDV6eWM1cVAyYlpTR3JiUVRrMUZKeVdLUEpqZUIydWg4Wlhj?=
 =?utf-8?B?TEpxZFkxUDV5Qm0ranBTQ05GSXRGcjZ1ZUFtOHpuUDJkNCtlcUJPdGthdmJi?=
 =?utf-8?B?OE0wZkhjaENvd0hLSXdpNkpWckZhV29kVWpJRytKeC9HVnZVaWl3VXJtK3dx?=
 =?utf-8?B?QlYwM254UHhmTytFTnpndW9UdDVYWWtIZDhYbndBVHRDbHlqTy9tSCtoTU1r?=
 =?utf-8?B?UXhoN2hnQlRNQVg4eUdDL0dnc2xob2NTdnpodjc1TmJDZ2VRSDBtS0tWZ3Q3?=
 =?utf-8?B?cDYzdkYwUm1HbjFxbVdMWkRid1QreEthQ2pOS2tOWVViN3pReHRYUkhhWjZu?=
 =?utf-8?B?Sng5Rk44eHkxK2k5akhsV251STVuY3h5YUttSXByLzdPTFpBRzNUMW1Wd3NK?=
 =?utf-8?B?aGVoWDBGMkFJTTQwUVJvQkpVK2hxenpDSmNiSTFpSW42YXFicndTbHI5REk3?=
 =?utf-8?B?VHhZYk1Ybis2WGdHdHQvemp3WWZGUEx3NTFKU3pzYjhyNjNpVGN5b2JYeWFn?=
 =?utf-8?B?RDk2UVJobWJhd2NGUGNBSlhneFdVazA3aVI0SjZkUElFZ2pRTFlOUzduZmYw?=
 =?utf-8?B?VnBhSy8zaDR2d3Z5Vjg3SDJoTTk2d3BaZjZHUUh0V2IwaUNVMGYreXcwOE4z?=
 =?utf-8?B?NmRxUHl5N1JXU0lMeTNRM1JYamZ5TFhrZmFpblNLSmtJWUFvRGphMVpUdStr?=
 =?utf-8?Q?8xCNOT+YQYuq2z+j8Lxn4oP567fRw+8GBggx73B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be85162-72c6-432a-a21e-08d8d79f373b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 02:03:30.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOBxE48IfuIs51aFtUg9IfZMqepBHWGCtGzkFALHQ8+KimXbDkDQdERk48fJHTiPWuZ+dnm/ZJhmsqjg3GuewAcWreYsEoZ7enPW9Sb/gXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102230013
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9903 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/21 8:02 PM, Baoquan He wrote:
> On 02/11/21 at 10:08am, Saeed Mirzamohammadi wrote:
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
>>   .../admin-guide/kernel-parameters.txt         |  6 +++++
>>   arch/Kconfig                                  | 24 +++++++++++++++++++
>>   kernel/crash_core.c                           |  7 ++++++
>>   4 files changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 2da65fef2a1c..e55cdc404c6b 100644
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
>> index 7d4e523646c3..aa2099465458 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -736,6 +736,12 @@
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
>> index af14a567b493..f87c88ffa2f8 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -14,6 +14,30 @@ menu "General architecture-dependent options"
>>   config CRASH_CORE
>>   	bool
>>   
>> +if CRASH_CORE
>> +
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
>> +endif # CRASH_CORE
> 
> Wondering if this CRASH_CORE ifdeffery is a little redundent here
> since CRASH_CORE dependency has been added. Except of this, I like this
> patch. As we discussed in private threads, we can try to push it into
> mainline and continue improving later.

Hi,

Are we good to move forward with this and apply it now?

Dave Young acked it.

Thank you,

John.

(Note - I am currently not on any vger.kernel.org dlist at the moment so 
please cc me ).



> 
> 
>> +
>>   config KEXEC_CORE
>>   	select CRASH_CORE
>>   	bool
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 106e4500fd53..ab0a2b4b1ffa 100644
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

