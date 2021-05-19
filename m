Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F17388694
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 07:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbhESFfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 01:35:01 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:20104 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239323AbhESFeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 01:34:18 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J5WYFD019104;
        Wed, 19 May 2021 05:32:34 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0064b401.pphosted.com with ESMTP id 38m8uh8ard-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 May 2021 05:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxm8xoo9Ut7sRtRuzYDogKmmiCUy+IMWuhKO4rwG4r4LSE/Tn9W1Hoil4TKfSjRI/OO7aNWQI+zdmxpouUhfdS9qkg3JBg5l7BUt57vp13cKDplGNGD9+vjTpzhRsB5jAS3DLrRMj6bekx68zQmp+K3xavM2eo/xaZ072BxgKHfUyHCeuPL0LLAkQ+iFYW9CHXGAlMmThU6l2vzCzCU6a1MzFcRgofhv/lcmZmeo0sOF8SprTnRYBP19k234EijUiMs0vfMFd4dWTGo68EpsTFEi2Ic6aaMIUGgNs6FBA45vALk18nSAjjivNyXcrt6lxqho01CMCA8cko1H0SO/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEq8oKpL6jKsISuGIj8C9ekNpPMsJ4a+BLo0BkDvqFY=;
 b=NW4EIey8EW73zviBEmOJsncLZemckVAVv3ukgEyvVlpiLptwVczrxQ1vkyWk5Ffv89wM2VA1vU5O2E6DHVLvCP3sXQ8u6b4nZ3hZco4RKE34zjE0RV1zdfG6D/o695jNJ1SWaL7ot/UuvV5TbRHEY6OApkhL2taJo63WZqZkIOaRCHNEOdMbCd2zK5ORL+LIO/UGl43oF29A0zQqQNB64ImsMYZ/lWBGqBKGSVMI3i5CDSjhwZaO5z0pB6uheBhW1jekEBTMXFNB7gtXZMlIfOAoFVeHH20/qX1sqCD9XW5YAOWnkDCoIK6YNKh0aRBLAv6PjCf5dv+ITDsjsK5CBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEq8oKpL6jKsISuGIj8C9ekNpPMsJ4a+BLo0BkDvqFY=;
 b=ZIxLVBcY2pHyN3AwLOyozvl64nTbAd/8h6230gcgU0pDVNVvUZ+ybQaFaKv6Jg4UPro0QviWZ5cT6w++RnovBXfqGx/1MMe252WtBkJnUlOkJuLhO9emp+uOZpyXHTRrUwuKDigYenVzLnP8jmfrls71cIgVvl028NQmi5CNRh8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 05:32:31 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 05:32:31 +0000
Subject: Re: [PATCH] arm: make the size of vmalloc in cmdline and meminfo
 uniform
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518111254.3820480-1-yanfei.xu@windriver.com>
 <20210518112932.GV12395@shell.armlinux.org.uk>
 <20210518120633.GW12395@shell.armlinux.org.uk>
 <63618f13-07cf-6867-bcb1-7a725e6f3ef4@windriver.com>
Message-ID: <b115f727-570d-d3c1-2a5b-01ed89c450dd@windriver.com>
Date:   Wed, 19 May 2021 13:32:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <63618f13-07cf-6867-bcb1-7a725e6f3ef4@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0133.apcprd02.prod.outlook.com
 (2603:1096:202:16::17) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR02CA0133.apcprd02.prod.outlook.com (2603:1096:202:16::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend Transport; Wed, 19 May 2021 05:32:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcebe10b-7656-431a-5f08-08d91a877fbc
X-MS-TrafficTypeDiagnostic: BY5PR11MB4226:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4226548D2009FF764FA02781E42B9@BY5PR11MB4226.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tszvU5wTReQRfbDZdy4xm37tjPuoNYY1opNtc/A6COD+5kwcgjwImJegV4teM/0GwJx6Rhbd/0t7Ty2q/JAKRe0cbe+M7t508aWPAXbKNMMBI6HHPzbrsxhosZ40kMTwT7jWF7OG0KJYBukPNq92sT8Lz5W1z+Pf+338vi/6AncWws3RDckQu6DJN+4YdiK/UtU0YKoU6U/1ArsXa/8muM7SQvRXdkmQ/PYRFgPdFPLWyBvn0xZj7vHfTF2Drj3b6xSlcSjZ9LlYGqkOkP1Lnbktk+M0hI056+y0rCWhJNtdTl7eJilh+EPF2TvIh6NAElg+57glJvSCtqrtsoDHfyChVGCBttH/C3lFw3ZRujdhTKgHvo1C1yYLuNfbbAZ/KUh/XYdTc2aBzdlX19+doDsQjkuzeakPIxovLf8zKjeBBrJoVGj3fCv0ouEPPNxuyWakLkKUXTL5f0RBbkq6TqgoNUxKy6opJe/50kLHTufBCx0xvmvV4IRMCY4mXTCdFb0FyLCdaESs6Xy9B4jNV7JW9cyCio9PuyiMAukFjkaU9ILMFA36hnQ2XSdB4k1+KzyBUqmGSVHAsyuT33Rv6PQ8FdMkAISo/R8+L+A36X8KAqQk5LbB23RKW3EQdmeZlLC0jY+23zgBY3FTrYDhY4bNcjEfVQQ3GX2bzuX1X1+dETJmzUTdU3LP9E58Y5Z3QjFr+kWeGJBifF7TFxWu9n7XeD3ey1H7ujDoDmXa+ZvUytYidrnTzeplAuv6dQgD/SV6PKIwfA2KOu3rXVVUjRcjVp6Y0nUGWmmaz2IaaWs9Je2DLCXbdrzZS8APtdAX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39850400004)(346002)(136003)(66946007)(966005)(66556008)(186003)(16526019)(31696002)(16576012)(53546011)(2616005)(52116002)(38100700002)(956004)(66476007)(316002)(5660300002)(8936002)(2906002)(83380400001)(8676002)(26005)(36756003)(6666004)(38350700002)(4326008)(31686004)(6916009)(478600001)(6486002)(6706004)(86362001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QTdvTmQrMDFrY0FlZWY5SUZUVGVyWW8zSzBUTmJPVDAzRmlNcVYrT0MxMTdU?=
 =?utf-8?B?ZUFqbzY3SnMxeWhYaHY1K0xxVml0WDRqdFJCcDNJdHAxaFNQR2w0c0UwcWhk?=
 =?utf-8?B?Y3d4Rm5HangzdS9XU2NzVzhDNzB2Q3lxNVhpemJSWXJVdXRXYnN4QWEwUVJF?=
 =?utf-8?B?a0lnMFdjK3NVNkJXVGVQNHBYYVRJY0JOZjVaSkxxL3BEeXdrZzJ0UldURGI4?=
 =?utf-8?B?cHZUVmpwWnpFUDc1ZlJpam9Za25KSmZ3ZndGQ00wUHhVOTd1K1NSYXozK2xK?=
 =?utf-8?B?blBRc0FBL1BjQ1FDMEJnaUNUTXVVWks5OWJPcDZFaWFVWU1SWXlJZzhNLysy?=
 =?utf-8?B?NytaQzlIZnJtM1k0bHEvZGMxWXBFWDk5RVA4STNuMDN5MVBYaEJkb2hodzVL?=
 =?utf-8?B?eWhyY2YvallId2lLUFlMUkMxT2o3Ly9YZElzbVRxV3ZNNzdXUXlmZjdXR25m?=
 =?utf-8?B?OXljMkxJTVpYZENiYVUrdTNVNjA4M05OOGUwOVgzYU4wbnNFdzE2dnBtTFE2?=
 =?utf-8?B?andLUVJOQldITnFjcGdhYTNzbUVQTWp4YlNDa2I5SlJZbS9WUGVVbDh1M0pM?=
 =?utf-8?B?RGtKVHZkZC84dnVpTTRGR25ZSUZYRW5RZ3c0WVlITEdVb0s2SU42VGs2VnVW?=
 =?utf-8?B?aGZybWFybkRmUzYyZmpTZGlvZU4vTXZvVWxycGJEMXVJS1JXeXZROWRFTjZC?=
 =?utf-8?B?QWliUkM4SVdJWVhEZU1OVDdNUzhxcElPd1ZlTGZaNTVua0U1b2FscDR1cFJi?=
 =?utf-8?B?c0xKVnUyRHNFaklZQy9aOGpKenVKeDk3aEhvTHZ0WlltUGVDMXlwVm5wVm9K?=
 =?utf-8?B?ZVJ2b2gxMUhqUnlObzR1bERGWFRFQUlUUWJ3V2VWOFNtZVNRV2ovZjMvWlI4?=
 =?utf-8?B?V3ljK2wvS2t5ZklXOXduQzh1YTYyTVBGeFp0R1VLSmEzQ1huN0ZrWGE0eGt6?=
 =?utf-8?B?UnBjODlzbDBDaXNCdThXTW1tWUtpTXpDYktaNGxhcGV2bTRJQkdQN0NDR2Rk?=
 =?utf-8?B?aGFMTklrc1pyVGhmblpOLzNGTEh3ZkJBenhjVGRML2NNWDhySGVhUUF4QTlV?=
 =?utf-8?B?U3BVdDJPMkxuTHV2S3dPM0xvWk1wczhxQ3FvNW1DTmtmVjJmNSt0U2xDdmU4?=
 =?utf-8?B?c3MvMm5SMzBlU2o3RGR4UWhRdURXVEJ4R3N3WHBiYUMyV0k3aUgyWDgzZjJU?=
 =?utf-8?B?MmhzVDRGMUdqVFVSaGhmTzNnbUFrY28vR3BJbXh6N1VqUEM0Z2RSMWpUeWR5?=
 =?utf-8?B?aTZ5MUdjQWdaSW1jQ2NVZXNPWk9Vek9vdXhDTmJBc0FTZktPOEV5bEloV0di?=
 =?utf-8?B?WGdoYmZIOHlQMVBlVkY2dXpFb3FiM0JERnAzMkMxZ1p6QUJKZnRPSFBWYWwz?=
 =?utf-8?B?NHNYUVZFb0NIUjF6SGdZbGNvUDRoWHdVWjl1VmtKRXFwMG9wQkd1WE5ueXoy?=
 =?utf-8?B?WExoTmlsZ3NvV2ZFamt5UU1ndktUeTdEKzMzQW5VTHpQWGhJZEZybFBjdUx5?=
 =?utf-8?B?ZDZHZSt4ckowd1ZDMEszdFU2MFVkSlZDNGZxRnFxUjEyOFhpQlUwSThVbWo5?=
 =?utf-8?B?c2lyTi9vNTJXQnQ2cm4zNlpDeUtjVkZEcWpscm1aU3JKeU96REdpVWFPS005?=
 =?utf-8?B?WTUwNVdPM0JwaE5hamFnaC95ZlpXZ3JIWmx0WnZHRlBrR2xveVJPWSsyUUk2?=
 =?utf-8?B?Nm5IeHRoRWdxbHJZVUU5OWJiYndBMnFNUVJtNkhleHNRem93Znk1M0FSaFZF?=
 =?utf-8?Q?eHF4g3lcd+GI4Vy79v+WBbUSqSoK4wZlWZApuiF?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcebe10b-7656-431a-5f08-08d91a877fbc
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:32:31.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1m786X7WNJ1RQED+guEdokdnmjqyHex/T3Z51UDl1JdDSR6AJWfuLNc7XiGVlMJ8pAsmwsmKFvSr2cAlEEx+Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
X-Proofpoint-GUID: jNJsrWFZXuOch9RcU-YRPjGZvLsl_zFF
X-Proofpoint-ORIG-GUID: jNJsrWFZXuOch9RcU-YRPjGZvLsl_zFF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_02:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/21 12:39 PM, Xu, Yanfei wrote:
> 
> 
> On 5/18/21 8:06 PM, Russell King (Oracle) wrote:
>> [Please note: This e-mail is from an EXTERNAL e-mail address]
>>
>> On Tue, May 18, 2021 at 12:29:32PM +0100, Russell King (Oracle) wrote:
>>> On Tue, May 18, 2021 at 07:12:54PM +0800, Yanfei Xu wrote:
>>>> The value of "vmalloc=" set in cmdline is always 8M more than the value
>>>> of "VmallocTotal" in meminfo. When use the "vmalloc=" parameter, user
>>>> expect to get the size what they input, and no need to consider the 8M
>>>> "hole" hided in codes. This commit make real vmalloc size equal to 
>>>> value
>>>> of "vmalloc=" in cmdline.
>>>>
>>>> Also, the commit will reduce the size of vmalloc printed in boot 
>>>> message
>>>> by 8M when the size set in cmdline is irrational.
>>>
>>> Hi,
>>>
>>> I think I'd like to do several cleanups with this:
>>>
>>> 1. change vmalloc_min to be an unsigned long.
>>> 2. exclude VMALLOC_OFFSET from vmalloc_min, moving it into
>>>     adjust_lowmem_bounds where vmalloc_min is used.
>>> 3. rename vmalloc_min to be vmalloc_start
>>> 4. enforce vmalloc_start to be a multiple of 2MiB
>>> 5. in early_vmalloc(), calculate vmalloc_max as:
>>>        VMALLOC_END - (PAGE_OFFSET + SZ_32M + VMALLOC_OFFSET)
>>>     and use that to set the upper bound of vmalloc_reserve (which is
>>>     something your patch doesn't do, which I think is a bug.
>>>
>>> Thoughts?
>>
>> I've slightly modified the above idea, and will shortly follow up with
>> some patches to show the idea a bit better...
>>
> 
> Thanks for making it better!
> 
Hi Russell,

I am not much familar with community contribution. In this case, what
kind of tags should I reply? signed-off-by? Reviewed-by? or any other
tags?

Regards,
Yanfei

> Regards,
> Yanfei
>> -- 
>> RMK's Patch system: 
>> https://urldefense.com/v3/__https://www.armlinux.org.uk/developer/patches/__;!!AjveYdw8EvQ!Mz6E44Glfsb6CPijsZ50Ofca9g8UAgL2MRQpaxa18ZTAIrVQpH0IcyqGDwHSWphEoo8$ 
>> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
>>
