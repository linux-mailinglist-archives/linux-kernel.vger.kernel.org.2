Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB932BB8B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhCCMg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:36:59 -0500
Received: from mail-eopbgr750051.outbound.protection.outlook.com ([40.107.75.51]:3982
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1581829AbhCCHeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 02:34:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z3r/oS0pbZY0uWeQT8En4knLkyNmxGF8N7ejT0FtBLLtC8EuqySG0I1YNmvQUJlwr9eUns1+3Y6S8rZ35qMyS/P4rIDAjpgsniZdSHJpZyuq/AY0l32ZjrYSWmFmDCRlfMFpxixbDcPHV93AXzoH4+/lcYSSlBHunmdPrxRDPuNb1VxSSboGYt15JCBborAuyQcyHZ+4v33dWitm1N1YUXpIfwlvmYjyqwgY1ySUgfUvB863mOOsPffcaGbhdOKcx07Z+cPuGJ1EySJLUSKif1KBPbuEEJmv5Y/oUCsLU7B2nRctLbqiYn3cluhOCB26yYkJtNKEHBqluFfPbeaBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9csIhTLDwmv3EpMUezclMc1nBpKYlqfU3NuOveXrw4=;
 b=ZBxzm+RVbHt66R2AAHiAyr5+NTmRd5qMCgSB3fac20XMW2x5YTMFmVZuNTujvmh61RnM/ZapSyupQOXdQitkLlPM0qNFLNLDEF8m9WZ6403atMrIe9n+4GR77roQFQuCCMD1Y7Sjbzp6BOdE5lKYQ06AMQ7a46oxGKVjh2oDcEQqi93KKRA3X01Cm4hHZWhXwkQVmrvljR1RRl1Z8Sh5TfqdWuLGGEwYYe3CAZ83O1Iz9OPEmYKRlU8Td1CA5pxQ1zp81daCo+JUEJ0Mf9RT7C12kE27dSgYBWCw+L69tAEn+WlyJ20/rYpUMKNKdskdQNP89JPrrlZEaCmS4k6Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9csIhTLDwmv3EpMUezclMc1nBpKYlqfU3NuOveXrw4=;
 b=cPcefip5lUdGTIqsEvos4MOIWWsUNBdHrfwHxoVVDpHFQ6G7yyrGYTINsgj+uvEX6A3U1uTwMDCtTHcp5bThtDl5Ex23y57kzwujjxUpz5WmC/jLu6z5uzL/g/F9IlJ7OEEYBex3MEDHM4UTgaucA6IT4UFMuUQfTDBBVAK6hPI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BN8PR11MB3586.namprd11.prod.outlook.com (2603:10b6:408:84::30)
 by BN6PR11MB4161.namprd11.prod.outlook.com (2603:10b6:405:81::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 07:33:32 +0000
Received: from BN8PR11MB3586.namprd11.prod.outlook.com
 ([fe80::382b:3030:cdf0:f4da]) by BN8PR11MB3586.namprd11.prod.outlook.com
 ([fe80::382b:3030:cdf0:f4da%7]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 07:33:31 +0000
Subject: Re: [PATCH] vt: keyboard, fix uninitialized variables warning
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
References: <1614747572-3295-1-git-send-email-li.wang@windriver.com>
 <YD83RFqtKVB2pA9H@kroah.com>
From:   "Wang, Li" <li.wang@windriver.com>
Message-ID: <5f05c3c2-6c72-140f-fd56-cd9ec1c7c4a1@windriver.com>
Date:   Wed, 3 Mar 2021 15:33:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <YD83RFqtKVB2pA9H@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0060.apcprd04.prod.outlook.com
 (2603:1096:202:14::28) To BN8PR11MB3586.namprd11.prod.outlook.com
 (2603:10b6:408:84::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.155.135] (60.247.85.82) by HK2PR04CA0060.apcprd04.prod.outlook.com (2603:1096:202:14::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 07:33:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a25b44e3-2aad-4504-6359-08d8de16a51f
X-MS-TrafficTypeDiagnostic: BN6PR11MB4161:
X-Microsoft-Antispam-PRVS: <BN6PR11MB4161289EC6012E465DF2100AEF989@BN6PR11MB4161.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAIB8AT3sVs/ncdo87ARQO3acrHAAuDtMMo1Doz750WTPrPjb87GSK0Ov19xcfBZ/CTSFbxQExAASowTLbT34qv/z+Xe0kbygKJ5NL0PaRzjh1jRB9eA8Th1BKkL64gBc3NIt86dkMPtecLhgCYwmO6iDv0fTaf9Og7t4k/YgQdMtM9UnQncPG/MyK4Z47oCpJRt7cQfQIoblwiIRYHJ2qSWzvTDQl+ebRX9g2xPTxv/fHXa0ikWjMIcaUPqivUYZOXAzZ6TLhlqOeKG70p/og6OZK9X+PLw0S7STppobztxXF3WqchHs351NW2Lc4wn8FcUkhO3lrysElTHE9kxLXuHkaQQHgGNp8T/vNKFoJs5btKUXI2jP02WUN4WRXgL2V2MtB7QpprImxf7GrL+WOCrlTaEPLuTQeLt1hUVgOU7WPg4m0xESk2/gxtRK5RZZWoyrozKyu5JRHbW0VIquBUZ8H8A8TU0FTlHQ8tdjlobr2G6EtQv8ul/i0nNISg9ZL2h5HEZy8seH12lzX/BiCvPykgc9XL+YpVSHEANE5h4itra+sZc60Q9zkkPuNokNDAWu+AvBzeyrB8bBIigbWHUboHHD7Czc+Iio8oS6v8W/OdA0k4uNReX5bVlkqLb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3586.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39850400004)(346002)(2906002)(316002)(53546011)(8676002)(8936002)(6916009)(4326008)(6706004)(2616005)(6486002)(956004)(66476007)(66946007)(66556008)(26005)(16576012)(16526019)(186003)(52116002)(5660300002)(478600001)(83380400001)(86362001)(31696002)(36756003)(6666004)(31686004)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SmJlamFobGs0UkVXVTFrMmVHS1M5OWZqOVlVck1WWmhwL1M4bUJqdnNNSVVF?=
 =?utf-8?B?OVg2WUV3TnhYNFVQcXV0Wk5RazFUZCtUdTRBT2I5VHlvZ2hMd3ZiTXJ1MmV5?=
 =?utf-8?B?N1FtZTk0SkJ5NTRJRWtHeUNFb1BTQ3dzL05ObkdBMkdsWjFKMXZ1bVBFK0Fp?=
 =?utf-8?B?WkNsRHQrL21SQkJTbjJGL1VxZ1laKzV4L3FKNUJiQUpjS0NCNWg3UnRaN0pt?=
 =?utf-8?B?dDQ4T09MNWREb0VUMWxMQjJCeEQyNU11ZEdHRUFEMHQySEVsMHBJeGxueE5v?=
 =?utf-8?B?U2g2eUV0dlIyNUNiaERLUU5kQU5FNUdiNFg5ZW5mMFNDZ0xTTms4V0pjR2Rj?=
 =?utf-8?B?Y3lObXhpdzRDUExZTVQ1TlBXc29aZW0yOGltQk94cEZpVFhVK25yODdNL0xI?=
 =?utf-8?B?VnVOVVpKRm1kbytEQ0RXV2Y5RUk0NzR1MVVZZnNmL1VjeE94cFBBaGZNeVBV?=
 =?utf-8?B?MWo4alU3V0hjdE5nRCtVcFkzSDZkeExWVFdoUE1qVklUZ09lTjd1UUp0Umh0?=
 =?utf-8?B?WXRpa3NMUXV0V0pkQmh5ZmdESXZtM1pGMUpvRzBpZElBYzZhY3IyU2lkaWZZ?=
 =?utf-8?B?aFIzQVpNUXBacUEzM0RzeGo2ZGZUaFF3UE52SXZVdng3c1o4V0RaZHpob3ll?=
 =?utf-8?B?NlQ4dlZkSUFqOWJiSlM5VGJsVVJTd093T0YvdGg1emZUZXhJZWR3dlJvRkFE?=
 =?utf-8?B?eGJ5MndSbmVxMzBia2VRR016ZGlISldUZjN5Sy9WeVh3Z2VuZ2xJMk1LOHFq?=
 =?utf-8?B?T090VzhjeTB5OEdYS1o0alU3NzlWQlU1czhTaDBYUHFpeXNTNlpBLytCR3Rs?=
 =?utf-8?B?SERHNFgrVFZUeXg1bHhHM1R6TmYvd2NlV1N6K1plb2RET2xSa05qVHJuMm0w?=
 =?utf-8?B?WE56SnU3eFZ1SzBBT2t2bkZuSjVpUWp5VVBCQXdLcFNpbVR1bHRPZFIzNWZJ?=
 =?utf-8?B?Smp3cUxyRVFKdS9TZ0NtUVZTSTNzU3ZvdThBZlNmSnBNcTNYbnFwZktHaWdC?=
 =?utf-8?B?ak15dGNyK2xTWFN5bCtNZ0t4cGJOZjFsckZuQU9SMTdmOGhGcFlNSndRcGhS?=
 =?utf-8?B?ZkkwRXB4NHBlNktETStyMUNvYzNKZWd6aFFJd2J6bFlWY3JVRFkvNDJaamNS?=
 =?utf-8?B?RXpseGFEZWZNMGdJTmVrR2FyOEtmakcyY1dXKzAyYWpsNUxGc0p3VXo0akk0?=
 =?utf-8?B?VU9raHJzWFdwVFUybnJqS1MwTEJsVy9nUlZCYVF5cTN1K3pCWWVqemNnbHJ6?=
 =?utf-8?B?T1ExbWovUklyUWNxenhxdWVCaFhnVEQ4V3EyV1gyUG8zbElxd2YvT2pBeEY5?=
 =?utf-8?B?Yk1WMjN0MFBDWVhiQ2dOcVBRWVpyM1FqNjZtY0oyR2lhUDlYUDhELzRyeVRv?=
 =?utf-8?B?KzJ0Q2lXUlVIbW9IU1QyVHJhZk1WTFZYVWNodldPRHNheFFad0ZaWlRDUDl1?=
 =?utf-8?B?L2pFMzJsMFUxVHkzNUtnNTF0R2VadkUzdy9nZ0hhNkxHVnp0Yjc1dUZaVnhN?=
 =?utf-8?B?Tk5IS0RhbC81R2l4dVpOSW1wUUppbUYydks5eDBMbU11eEFLRlpIR0dGendj?=
 =?utf-8?B?cTNWZTRWMFo4UVQ4UHJBaEw0NnNiWHlkcW9DY3N3aVhxMVNCT2NhRDFzYWZ3?=
 =?utf-8?B?bjN1ZFZJNGpnNy9jT25YdGNkV1V3QnNOcUJrNlpkMGM1Q1pLT2xXMC9oZG9I?=
 =?utf-8?B?bEJ3TU10UnBOb1poSmIyVGc0MFZTblVHS2dXOW5GTHE5dlYwbmdNZkZkQXdx?=
 =?utf-8?Q?ztq5qQgGylMZZrnSR+79WV8Q8SGAlEhFjwgao8U?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25b44e3-2aad-4504-6359-08d8de16a51f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3586.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 07:33:31.5438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YvaRhR0W4/QEVdSqulbpUBYynnfdBd98PicaOk24AnbsvdUXYCm1hCvLxj17U2yBhuuQEThbwVEUwne0RW/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/3/2021 3:14 PM, Greg KH wrote:
> On Wed, Mar 03, 2021 at 12:59:32PM +0800, Li Wang wrote:
>> drivers/tty/vt/keyboard.c: In function 'vt_do_kdgkb_ioctl':
>> drivers/tty/vt/keyboard.c: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>    return ret;
>>           ^~~
>> kernel-source/drivers/tty/vt/keyboard.c: warning: 'kbs' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>    kfree(kbs);
>>    ^~~~~~~~~~
>>
>> Signed-off-by: Li Wang <li.wang@windriver.com>
>> ---
>>   drivers/tty/vt/keyboard.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
>> index 7763862..3e73d55 100644
>> --- a/drivers/tty/vt/keyboard.c
>> +++ b/drivers/tty/vt/keyboard.c
>> @@ -2049,8 +2049,8 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
>>   {
>>   	unsigned char kb_func;
>>   	unsigned long flags;
>> -	char *kbs;
>> -	int ret;
>> +	char *kbs = NULL;
>> +	int ret = -EINVAL;
>>   
>>   	if (get_user(kb_func, &user_kdgkb->kb_func))
>>   		return -EFAULT;
> What compiler is providing these "warnings"?
>
> Turns out it is impossible to hit, so this isn't actually fixing
> anything...

I tested it with gcc 8.2 for arm

for runtime codes view, indeed it is impossible to hit.

but for compiler view, gcc should give 'used uninitialized' warning, too.

thank for your reply,
LiWang.

>
> thanks,
>
> greg k-h
