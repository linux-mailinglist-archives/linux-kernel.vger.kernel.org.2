Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED630BBF9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhBBKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 05:20:29 -0500
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:39009
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229483AbhBBKUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 05:20:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MT1lA/E7ea2pwsPQ4xTMtCErmjxFTgLcMPlWmjmaxHpuUStwxGdUpr+eLwMNh9foenbSOnF4Vu1JhWOE3t3FYTaiI3yrTmYU8CNScmiJ4gaxgAhWA7PKpXq4j4Yw4Pdb2e3jsMlD7RhVDp0oB6FiLsvIm0iMv9G0M5MNn2cGKHZ8MWFEmANF3wGcdgKtyb7LVQr3dq4NM4ZCAq82t3JQgZUHyn7P77Q02nOIb29adN2jb4VwlshvxjiGhGtMhTlmBwE7he+pu4couQRbX69IQZUfSfVuireOUsicB2rTCpRbHsI2jy8/anMQh7DqeEfndYmX/J15dcM900FZI1kDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCvMleNImUDJWXJIc4u7VW0j456qoa/LJq5r0ZDoRXU=;
 b=OsImyvLwcXYdHTp0CXZ0SbsqbRz9+T3bc5lUwQWbZRVmYQyND+NNxhoLHuVCBfXlMCbB4l5mH+5JNuBiVd4z04bmXcd/ofXkfyQMHkMJESaMWEb1zsz9vVU/lgaPwYwUR43F4tLAPwmLeHvR864u6HpZxmPfTOJ9eqeWnjEuJcsOe6AWc3CnLgO77qXBcPPnWPYYCzuFewW8vZI+bqZIh1kf2zQ24XjF3y/Mnw/Dl0ZdTfJp7eBUkIOGCyKrdKkN9cRyGz3kg8w3ptnGewhRzEjm1tmX04YXtdncDxRr0YAqIzC1+/z2DIQE35LjifMsRA1XdViA75NYShax3mt2Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCvMleNImUDJWXJIc4u7VW0j456qoa/LJq5r0ZDoRXU=;
 b=Vn14DjBFDta4SRUYwIxMPS/RzB1qhwboWpX3eawHvKZXwuP2a/1GSr1kAD5JKgZnSxTSUuh7cEQpe67vyHqL0V+EWMF4Thg5i9X75pl6U215jD/A95gy40AmpqsSGk1S3QOzrFWNxw4k1QuFw7FI+8D3Oiw4Uv1dNAMaMubOugY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3350.namprd11.prod.outlook.com (2603:10b6:a03:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Tue, 2 Feb
 2021 10:19:29 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4%6]) with mapi id 15.20.3805.028; Tue, 2 Feb 2021
 10:19:29 +0000
Subject: Re: [PATCH] mm/hugetlb: remove a meaningless if statement in gigantic
 page initialization
To:     David Hildenbrand <david@redhat.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210202101209.72795-1-yanfei.xu@windriver.com>
 <18d3db7b-da3c-db14-ab99-b2c966c70024@redhat.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <0837b5cc-2eb0-4316-8595-34f92a43035c@windriver.com>
Date:   Tue, 2 Feb 2021 18:19:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <18d3db7b-da3c-db14-ab99-b2c966c70024@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0401CA0010.apcprd04.prod.outlook.com
 (2603:1096:202:2::20) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR0401CA0010.apcprd04.prod.outlook.com (2603:1096:202:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 10:19:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef356047-2e74-49eb-a1bf-08d8c764066c
X-MS-TrafficTypeDiagnostic: BYAPR11MB3350:
X-Microsoft-Antispam-PRVS: <BYAPR11MB33501A747284BB4F1C408A2CE4B59@BYAPR11MB3350.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:293;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nm4KX25ri7A1O6NOTVd78zsTIM0sSa3Vx/Wa3xEdh+uFC19BgPSHYMj3GCr0j1D24SqUMn+AgQojx8+AZG80ubXmmtd2qIdvkhT+pgCwUgfEMF9RHwtH1Tb29KQ5tJ5Oemur2t66KN3Y+PO/BZcS1nKeAK1eA4yCU7EMGQoPRf1ZFVlVVa0G+0GyAosL8B/VA6I92MBxfUfbHGhElZ/nwIEPSxGfHXARQr0sbNk2OiPPOnWU2MNlqxsHdOTzmxBSZAPozBjgT9HndNGT3TjuE8KrbDfymko7OUIWe+t0dFxSQUuWiesHZCO4vDX2o+NmgcPC95ONc4a0PkFC9atP1p6/L43lpDl0WE2+YmKY2jqfTo0troU6vQPiBrI6lrdR3qJB9ZGy5v8uNDq7u2hEcvC4USeWmCS8WrdBSwktJSCkpP5qWYWczmy5JpeZz41ZNy4xYNHYL3zDQPPgu7JBxfzeHEcGFfubKf8dbCnX2YwqkvBt+lR/m1Jaryl69o1MjXEioAmeSka2zE3ZKZc2JBDnSpIFBy786aT8uGXM6dkUXxjhR6qq+O09LSICKsVCl+kBbvhBOIAjy6JCLv0ZN1xQUp6EMNyIAZz7k0D8vNpR3n4m6oyjcWkYcNANCYl2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(6706004)(36756003)(66556008)(31696002)(186003)(16526019)(26005)(83380400001)(6666004)(86362001)(8676002)(52116002)(956004)(5660300002)(2616005)(478600001)(66946007)(2906002)(316002)(16576012)(53546011)(31686004)(4326008)(66476007)(8936002)(6486002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1h1bnNuUTd4Y0orZUpVaUVRWGQxZEpHWlhhYkZPUlpKYWdnSHZ0NWRPeEdi?=
 =?utf-8?B?UmVCbE5rS09zM0pxU29GVTlkY0VLRkpHL0xUbEtUQkE1eXlTQ2J5UGc2Tmdh?=
 =?utf-8?B?bXNJejBZRmlOMnQ5eEJVbzFDbERWaW5yQy9DT201RXhsdXpJTFRmY0ZrOGRq?=
 =?utf-8?B?c0FMZEtmaGRZaEpBQ1QxcnVIVmdWbWlzaExhYlpqbytNMTcxbXlUc0ZtT0tu?=
 =?utf-8?B?SnVpSHArbG5PTCtNNDlhRFBiTnNDV0p6dmRzMnFxWEErLzNYZHlHUWhLUWNi?=
 =?utf-8?B?L21LbWd2OUNWcHIwZjExM3hYeFR2NlJGQ1dDZDJTcGl3a1E5ZGh6MkViZnNu?=
 =?utf-8?B?VkozVHE5dnNzc1FaOUZnSjBENU81bFYxNmgzb0VnTXVwSWRhSCtaT2JIQUV0?=
 =?utf-8?B?WXJpSjdYQlRJV3UxUHpaVlJVSktpZmpGZFY0MUpETUYwQTdLNDlOWWVhNnhU?=
 =?utf-8?B?dzRSN29aMVhPWTB6RzhGQ05ycnJEQm9Pc2xiSHB3b2JZZXgrZ2w4RmIrc2ow?=
 =?utf-8?B?VnFtNi9uYkVxMEZ3enFQbSt2eUJqaVZ0WmtyR214dlpuVThPbURmMk9zRHZv?=
 =?utf-8?B?UW1GZkVpSHpWbWxlcmI0akRuN2UycEZnZjVMcjVxZlZRRDduVGNKcnZyelQ0?=
 =?utf-8?B?M1g5NG5XSG1RTG5JQ1FYRFpvYTNCd1ZHNGZHclZ5M3U2ckRNd01QVUNEd1d4?=
 =?utf-8?B?bGNKTW5hbDlIbStDbDNleEV2RlpCZHNUQ3FDdTlxbjc5V2FwWUlvbjZ1eFFh?=
 =?utf-8?B?NFB0SmpvcHlUbzVOQVZqOGFOekNSV3NQMG53VXo3RXcvaitkS3JhVXBEb0RE?=
 =?utf-8?B?Zm8vT2kzYUVyQmlCYTVUVFRsemk4RXpMSFFpdDYzMlE0VHNrTzZuMURMRHZz?=
 =?utf-8?B?WGZ4RGRiVzUyNUhHMWNibGRTZWdmdWNkMms4N3labTJwVDZXVGxhc2VwM3RI?=
 =?utf-8?B?ZG1CcjFRZzFBNEZpRnA2N1I2U05ERFRXZVNjd29YT1U2eHVhcFNvekIyR0lw?=
 =?utf-8?B?NWZjUjRPN0l1YlA3NFlmcmxhR0NjOHpNb1N2cGVSL0ZYa2JzSUZ4RS9Ddm4w?=
 =?utf-8?B?VjdtblN6ZCthVzZUMzBSVFl5MjVvRi8yUXgrMEpVaHlCWVQ5bm5kRTFIV3Nw?=
 =?utf-8?B?a2xzTldGSzdIekhuUTdkYisyeW9qTHRrR3FZdzE2TFIrTThyVjdnQkhzeVNp?=
 =?utf-8?B?QlROUCt0SmtZdzR6NUtxWEJUNUprQ3hSUlF0NXBleUk5dXlVTDViOVJSQ05I?=
 =?utf-8?B?TDAzL3lQT04wR2QzSm81amhXZU1jZDBySy9RVUtmN0NEZm1vYzg2VFUvUERZ?=
 =?utf-8?B?aFlLaHc5YnJuOFcrUnUxZXJoTXV6c2JCVFk0TlVVVTZSeDIvMEdlVHJObG9u?=
 =?utf-8?B?U3ZRL1R2Y3VqUFBVelJmdnBMZVE4SHFncTNxS0VQUHpRVzAxeDcydGNnZWlR?=
 =?utf-8?Q?mU9wmeyt?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef356047-2e74-49eb-a1bf-08d8c764066c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 10:19:29.2574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccwzjRI2yhBQF8IXOXTwrxM6TJ+5iUzE9k5aMThYmFIhJ7Wz9hGkxuXm9ww72guzXjEXulBUZVltjwsECMlyKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3350
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/21 6:06 PM, David Hildenbrand wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On 02.02.21 11:12, yanfei.xu@windriver.com wrote:
>> From: Yanfei Xu <yanfei.xu@windriver.com>
>>
>> Gigantic page is a compound page and its order is more than 1.
>> Thus it must be available for hpage_pincount. Let's remove this
>> meaningless if statement.
>>
>> Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
>> ---
>>   mm/hugetlb.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index a3e4fa2c5e94..73d602f8c7e2 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -1501,9 +1501,7 @@ static void prep_compound_gigantic_page(struct 
>> page *page, unsigned int order)
>>               set_compound_head(p, page);
>>       }
>>       atomic_set(compound_mapcount_ptr(page), -1);
>> -
>> -     if (hpage_pincount_available(page))
>> -             atomic_set(compound_pincount_ptr(page), 0);
>> +     atomic_set(compound_pincount_ptr(page), 0);
>>   }
>>
>>   /*
>>
> 
> I can spot similar handling in destroy_compound_gigantic_page(). If this
> is correct (which I think it is), we should tackle both occurrences at 
> once.
> 
Agree. Will do it in v2.

Thanks,
Yanfei
> -- 
> Thanks,
> 
> David / dhildenb
> 
