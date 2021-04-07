Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA0B357773
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhDGWOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:14:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56040 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDGWOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:14:45 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137MAtM3095904;
        Wed, 7 Apr 2021 22:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=y1SWritsxACnXpGpFSjli8jnwC7O5oFow52X5CCgmII=;
 b=auMDEI2ReqE+xVIi7ZwJWU+oocM7U99O0fiPPfNjA4IT+KmEIYUzBRR/4pQQGnnypJ8H
 IoisHX7AEnNlGT8EJq6fj81Je4EV9dYiksngH1gVCIG6w8/1Afr4p6SY5Xsuv5BnaxfN
 XgK+MEdDHFmkRcsNp70w9WTbCGGYqTD0zvHzk1Qh/GVnWm3St60JNZVq4XLeHRVJYkwg
 AD7CFMoV4YmQFoeLdeqv/Yte7QccFx70cxID1YizW2dJ0QzInCPfw4iPRe14dYUSEFHo
 IB/iRVu5+K3M7F1+GT4/C30q2+MqbsgcCJ9lSANFzgeKVXMrGAjrtsPJCRBj5JpWkKUW xw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 37rvaw43u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 22:13:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 137M60lq129374;
        Wed, 7 Apr 2021 22:13:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2041.outbound.protection.outlook.com [104.47.73.41])
        by userp3030.oracle.com with ESMTP id 37rvbewy6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Apr 2021 22:13:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frd0khsb6ybLuZ1tPlYWV4bj1Tj8e6JY82HDmapa0LIPprFYtAKNoqzMgH4KZ5O1lFJIti5t8wPj5qAc8e+GxPZFYeXjtBqdjNPv56WeVR1kHs15aHrBiKPjE7sMHz9kiqP9mbcWTRkKa/ycowhm9zEfFWMypoRXMQMjt+fQKtblIzyFii+tFtq4hgUMaRMqekI2UZml89dmZfdwjNjPGr7/qBm/yz2jLHJyZpDIJNV9L12F+Y6zNPK7sJ0oD/vuN+bpyV7MEIBDB/WhHoQ0JLMVIlGNmUiHG/PtMzzrGA152g+vugv7IMyYCZhvP1NrZMNqAN7jnIra7RZ0naILyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1SWritsxACnXpGpFSjli8jnwC7O5oFow52X5CCgmII=;
 b=haHbl5jU7q4XdHzU01AvbbQSxCqIVzY+FKqdRohI5J2n0eXOA1SqMyxrCtkM2wwMYwi05Ogt8spTwHk4S5StathhO63k8rnmPjtcltN79uR3SuvUBDvvI3nV0CxUnU1NoKEyq+6XPE+i7gvMR0u6PGeZalKtYHcQ+yXQPZIyYAz9Hg4fc0hcv9rltVIH6LqxOHP2fvH6uxNJcKjwvR6xWdMCx3p/QrR+h3W6pxPWv05RGfR95nIliJ3YvbCojpO2HaL/jSfoOqD3dqK5d9W17doNA4JqvrOPGTNvR8EZ563QList+6/YLZ+KJkPIIWJCvw61MSo5nDKddUGs6eiC9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1SWritsxACnXpGpFSjli8jnwC7O5oFow52X5CCgmII=;
 b=d3cUyvzvx7xx512eb0DWsnO1stinUCpFUC9pCGtaVCDjiqcCUw8swnqDwv7jSEyaU85p0sTzPdsZlJQxEv7fhYKRVOH0Y2mPRzNiusYtjuwIDMgTYcqO+d5StwcSB9NkVlR8dyQh+NK4BQaEeDxXgahf9irieWdQmvmZvcjF8vw=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BY5PR10MB3907.namprd10.prod.outlook.com (2603:10b6:a03:1fc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Wed, 7 Apr
 2021 22:13:52 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::44f7:1d8f:cc50:48ad]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::44f7:1d8f:cc50:48ad%6]) with mapi id 15.20.4020.016; Wed, 7 Apr 2021
 22:13:52 +0000
Subject: Re: [PATCH RFC 1/1] kernel/cpu: to track which CPUHP callback is
 failed
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, mpe@ellerman.id.au,
        aneesh.kumar@linux.ibm.com, ethp@qq.com, npiggin@gmail.com,
        joe.jin@oracle.com
References: <20210310070837.17674-1-dongli.zhang@oracle.com>
 <40a7be6b-0603-a2ab-afaa-339e88a03210@oracle.com>
 <20210406161032.iwmlfszrfcpjss5e@e107158-lin>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <bdc42bbc-846e-7695-9912-be9941004830@oracle.com>
Date:   Wed, 7 Apr 2021 15:13:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
In-Reply-To: <20210406161032.iwmlfszrfcpjss5e@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2601:646:c303:6700::d22a]
X-ClientProxiedBy: BYAPR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:a03:80::45) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2601:646:c303:6700::d22a] (2601:646:c303:6700::d22a) by BYAPR11CA0068.namprd11.prod.outlook.com (2603:10b6:a03:80::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 22:13:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0675a9c4-ef72-49b4-f09c-08d8fa126d55
X-MS-TrafficTypeDiagnostic: BY5PR10MB3907:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB39073BF94A52C3FAC1A90CECF0759@BY5PR10MB3907.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9efl1Yd4jDaks03tdwLx6l4WjjBY4gxwLyQs/JTn+PH5U3Yr9WG/fCEFbAY+lBna5Gj0Ti5UwTqO8Ax0CaTaDlowFYfGaZND64EyAK7QIaoHDRHu45zwwnSXpRlLzhVmr9IkQusBVVX/lmcVmSVcFraBYag9wpauOTlx6yGOqSWCnLkdGkJK09hwsU/PSgRp6jgnHSmN3N7wyKYgQShJR8O17LTmXRHwoU96MUWBbRt//rvZqVNWq0vGBVdbn37Xf8bq+Q1W2YTZ4llXTQ925+69YP8pxwlpjpU+IF0XGRg7huTaufSVPWTjUXkOOaJYT6TDSKzxee+J/PHe4FZGPQKBN44dKQDrvNPN+uY5kSbsa0JyFDpNu8QK5TqnUkdbAdYU3M8oIxdJspr5msCNiizkwVdJWytoqCPfwJbhKueIv1tNC35LwX9Gu2nuN5cR94PV655OHRLj8oxNUE9PlwSJrx3zbCjZJ4vo9ELQC7PP0yKYNU8xbjEqJdL4sirboIul9iwba32Y8NPhgBxoRdm9L0B++a8gtTVIh9D1SHQGGgky4oIezuz3ZuQNBDhsr6EVrDWmZjHkmLJRGKfGCGhvifzgMnyYGyiNHqECwnPMHMPQW007sy48E8w7JVJ7HHWSVwRm8j/gSeEgeg4s2jh9iQA66tA4sKoXHSzoJ2KvdnLEsoYrYIzTSXrr7O9z2K9F7VM20WIcbCVe5KKmHQm5tQSu3u1YEYp44ypD/eJ31Hn/uK/Y5ZA4us+mL52yMxurq0DnnAtpHN8R4m8c4ayeCROh3Xy7d1nyE09cKb8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(136003)(396003)(31696002)(66946007)(38100700001)(36756003)(186003)(5660300002)(2906002)(86362001)(53546011)(6486002)(8676002)(4326008)(66556008)(966005)(107886003)(6916009)(316002)(478600001)(66476007)(31686004)(16526019)(83380400001)(8936002)(2616005)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b1RDK1B5WmlBTlVlQkpmZzNHemhmNWd4VnYxK090alZqak9TZUIzN0c2aURK?=
 =?utf-8?B?VmNTSlRZZllwUVVLbUZhMCtidXdKZjd4N25pMkg3Rlo4SDQzaThjM2Fndk5w?=
 =?utf-8?B?aG9nTGZZOXhiL1IrSlUxMGpFeU1VWXRxUlU3UDFuS0VqOCtEOFhvRFR4SWxP?=
 =?utf-8?B?TFRtcG9IVjNJY01HczdiRWZtUWhHZ2J1cUZGbHdnVVdLQzF0c0xZREJHb2Fh?=
 =?utf-8?B?c1Nzc1hlV0pJdjBmbzlCMjZDK0tWMFlqSFpnUURnSWhuSjhtMkVUZUdKTG85?=
 =?utf-8?B?aUdpZkdQQnFiUlhRS1RFN0tOWks2c2dNclRqaFVmczdUWFEzYzY1NmhCeXNv?=
 =?utf-8?B?bDhmSlpneDIxNExXLzZ4YmFzTnQ1aGF4STRoWldLRWlTRnUwcUphZ3lJMTJJ?=
 =?utf-8?B?TDE0OVdlUEhhblpvTWFLb2srN0pQN0I5OWd0MG5SWXJxOVpxczhhS0pENUVJ?=
 =?utf-8?B?MTdVTm5PTURBMHZlSDNIUG0wUVduZG5hdnRHVVh2V3dLUHlOSHIrWmlmaEtv?=
 =?utf-8?B?SkhPWUtvTDhTWkdYWFlVeWowMGhZQ1hLdXZoOW04citJZUt2MGI3UDRveTZy?=
 =?utf-8?B?M2lwSEk3YmpmVU84OFFEYTlFZ09JdmViaDBoNkpxVlNBRE5MaWsvRkxTWWdY?=
 =?utf-8?B?cnljbWhCMWcyeHJTSW5IbFZwS2ZWdjBqZ0hkdVRzc1NGU1hGWUM1TFFDUmg5?=
 =?utf-8?B?RjMxYVN0aW1PM3pUK0kwSnJ2S1o5QmFodms0MkxmM0U4aXh2dklDNW5aL3Fp?=
 =?utf-8?B?NkJvb0lxZFlUcDhWenVoVjV1Ykg1bkRWdG9WSUdkM1VnZUtHdnRSbnlWNUhU?=
 =?utf-8?B?T0Q1clpGTUNydnpMeFZhT1N2K3h1SGQ3NFFSc2J1ZXg2WlJ5dlFjbzRZRFdi?=
 =?utf-8?B?V3Z4RVk5MnozQm05Tjc5N1czcFg1OVczcEFXbGw4Rkl0bTQvYTNaN1c3bS9Y?=
 =?utf-8?B?OVc1Nlc0TUJ4RGE3aUNOdVJRZ3ZBYzU1RjZiQUdDZ1RWUnJFUXEyQUNOdTZh?=
 =?utf-8?B?SXc2YWU0L0ZKQW5XUzBPbUp3SFI5WFg1a2dzMG9jVzFRU2RmZkpFa2JNeVBY?=
 =?utf-8?B?dmdHd0VyVjJnTWxVbTFxUk1qYzB5a3dXWlhEMVY5aC92MnZ1cjZOVjd6WDc0?=
 =?utf-8?B?UG9Say9ST3JTdE9mUTVNSFZUVnc2VFRGYmVYS2NjMjNiTFJCcHlFUjR4UFFI?=
 =?utf-8?B?VUR3ajZJTGxmYUVrQWlwVzhvc05qNDVFejgzNnd5QXZ6OGJDV0pUQ2VwRUl4?=
 =?utf-8?B?RWZKbyt3Y3QrSXZTbHNvVzVOdkdzMjlsSTVxMDFqM1ZOVWJYbTZrU2thNDh5?=
 =?utf-8?B?T2ZKeTVQQUNvNFVybEF2UXFHdkJOQ2tIblgzNzBBakd1K0lORzh4SGh2SnFJ?=
 =?utf-8?B?eWxGdjJuc1dBZis2VE9hY1ZmeWVlU09FcW9sbHNrMnBYUXVHbHh2RHdJQURF?=
 =?utf-8?B?cktSdmFpMFNuQnVOSElhYzdPUzZEQzdVV25aU1UvMWNiZzdESUxSLzJrUWNh?=
 =?utf-8?B?RWovY1Q4RUNJREZIbEVSdGVxSC9JaCs1Sm42ZjVOT21pWUdELzNtTS9WQ1FL?=
 =?utf-8?B?QW9ISWpYTGNaeExkWHdHM1BBcXVsaFpOajBkc040VHJNMStiWFppS2w3eHVW?=
 =?utf-8?B?bkFxZEVlOVg5eHNXZnRiT0x4TTI3aW1VNzJOcGVzeEpuQ2Y4anJNL1FkSDdE?=
 =?utf-8?B?VW1hOEZnZkpHR1VUNUJIZlNSWDBLdWJxVm9CRzBrRU84Q1EvVmFlUkp1NXNm?=
 =?utf-8?B?MDBLVHExQUlGcHo5b0QzVi91ejRrc1BlVUNabHVjc0I1c2pEVDVwZTFvVWY1?=
 =?utf-8?B?Y25Idno5N2w0d2U4ZnB3Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0675a9c4-ef72-49b4-f09c-08d8fa126d55
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 22:13:52.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMnKpV6rrM8/OvQoBNLJAh8b6yEPXtBQdsKmF7FIHRLLARz0KKN6rXpHVveJyGP4Kt6LGBZwlDyjrEJaOFJV7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3907
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070155
X-Proofpoint-ORIG-GUID: qcA4XFlJXc18onvLc_G6JEifnZudMD5S
X-Proofpoint-GUID: qcA4XFlJXc18onvLc_G6JEifnZudMD5S
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9947 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104070155
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/6/21 9:10 AM, Qais Yousef wrote:
> On 04/05/21 14:22, Dongli Zhang wrote:
>> May I have if there is any feedback on this? To pr_err_once() here helps narrow
>> down what is the root cause of cpu online failure.
>>
>>
>> The issue fixed by d7eb79c6290c ("KVM: kvmclock: Fix vCPUs > 64 can't be
>> online/hotpluged") is able to demonstrate how this pr_err_once() helps.
>>
>> Due to VM kernel issue, at most 64 VCPUs can online if host clocksource is
>> switched to hpet.
>>
>> # echo hpet > /sys/devices/system/clocksource/clocksource0/current_clocksource
>>
>>
>> By default, we have no idea why only 64 out of 100 VCPUs are online in VM. We
>> need to customize kernel to debug why some CPUs are not able to online.
>>
>>
>> We will have below and know the root cause is with kvmclock, if we add the
>> pr_err_once().
> 
> Isn't pr_debug() more appropriate here? Don't you want one on the
> cpuhp_down_callbacks() too?

I will add one to cpuhp_down_callbacks() as well. Thank you very much for the
suggestion.

> 
> I *think* it's common now to have CONFIG_DYNAMIC_DEBUG enabled so one can
> enable that line when they need to
> 
> 	https://www.kernel.org/doc/html/latest/admin-guide/dynamic-debug-howto.html
> 
> I can see the appeal of pr_err_once() but I think this can fail for legitimate
> reasons and is not necessarily strictly always an error?

The reason I used pr_err_once() is to remind the sysadmin something bad (maybe
not necessarily strictly as error) used to happen. It is quite helpful for
developer/sysadmin that is not familiar with cpu/smp/bootup/online.

Otherwise, someone will need to manually configure kernel command line with
"loglevel=8 dyndbg="file kernel/cpu.c +p".

The good thing with pr_err_once is it is not based on the assumption that
someone already know the root cause is related to kernel/cpu.c.

The good thing with pr_debug is we will not need to print for at most once.

I will send v2 with pr_debug() and let all maintainers to decide if it is
fine/required to print something here. Some places use WARN_ON_ONCE() for the
return value of cpuhp_invoke_callback(). I prefer to use pr_debug/pr_err to
print extra debug information for cpu online/hotplug case.

Thank you very much!

Dongli Zhang

> 
> Thanks
> 
> --
> Qais Yousef
> 
