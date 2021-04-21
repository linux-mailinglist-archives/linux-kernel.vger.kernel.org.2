Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F243672EE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245313AbhDUSzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:55:44 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com ([40.107.94.84]:25184
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235329AbhDUSzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:55:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6EEoWRFhPLf7xHf100FCs0GEeRgzmfcr/pGkhQ0Nwzf1Y7kIt+DBNkWcO8ckIsnZnhyjEckXFmbgTzRxWRjuJaRFQdvwdbCoqWwsNH5ryq/dLaGqrUJGTKmWF+S7ge30KbiYJlsbsxY9ZvaZJ4VDA8BADVBopSB1vayOkBxiHhJDY459vxzsI9Cgg3zqDYneYZpTrcLplbEirbZMyzhJiG5pLURD8zJKcHU32SwvnzEDPyQoq0L/OAcMAdoWOILf+hKb3Ki4km57RjgyiEZ3bDVtS1B29hk8/njqrfqD0gbngfNvz03jVQGiCeqP/nZ48qwHZQOljnvc0cksVl0lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiCRVelN/stm7B5TJwYSYp2t2m77Xt7eTGrBoly1PdQ=;
 b=LMkmv95WmmWnRwua9K3eoC8LudqEycs0G06Ovhnj6O47j/wudp1SzvvnO8puAaS82EE6/TU5ZRlStbJkHTDXN8Q60Fb3VXp205KWZoqqTAryhP9nmpDrOrv43cLyUvKE92wUYi0kSdimQkORMYkLQihV1lzypbZ+WEbZ0FvVx33HfdYcw4lqqtbdhf5rnATlliC6dWE49V2EoumJrT8H8EDjwmwbWOdRKf2bEOxHj5zgv+zRgKUz5m4gCvZjxO0Wa2WdFV6XBrH1Gk3/V6bpnzlJe1uSjOcDOG3zELYHs4ovVkhtHcIO16bf7likTrSLbIf2R4y62jy7km5Z8THr1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiCRVelN/stm7B5TJwYSYp2t2m77Xt7eTGrBoly1PdQ=;
 b=SdM8P8E09SxKmdQmXOPEJErRwzsS5CZCFq8kR7caeTfxEh7Lkp5oU+HOWHXeMFzLiaJ9ZfZFP0BcSUS5rkvArFwowYoBsjYNlPLTkLTFHCOmbVaOELdXwhSoebX35j/4Py89fe6hTKPFVfHWlRAfjnaLur612n9MercG2t+aTeU=
Authentication-Results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM5PR12MB1818.namprd12.prod.outlook.com (2603:10b6:3:114::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Wed, 21 Apr 2021 18:55:06 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 18:55:06 +0000
Subject: Re: [PATCH 4/4] x86/speculation: Add PSF mitigation kernel parameters
To:     Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        Jonathan Corbet <corbet@lwn.net>
References: <20210421090117.22315-1-rsaripal@amd.com>
 <20210421090117.22315-5-rsaripal@amd.com>
 <4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org>
 <jpg4kfzfpzm.fsf@linux.bootlegged.copy> <20210421184826.GA3120@zn.tnic>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <863ece71-463f-fc50-db13-7fd280902d6b@amd.com>
Date:   Wed, 21 Apr 2021 13:55:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <20210421184826.GA3120@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SA9PR13CA0095.namprd13.prod.outlook.com
 (2603:10b6:806:24::10) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SA9PR13CA0095.namprd13.prod.outlook.com (2603:10b6:806:24::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.15 via Frontend Transport; Wed, 21 Apr 2021 18:55:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14bfbd02-270b-444f-e3a2-08d904f6fa62
X-MS-TrafficTypeDiagnostic: DM5PR12MB1818:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18189B05919CBDB06F2AE62D9B479@DM5PR12MB1818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lennd4dT9YKq4dv9RvJSCHeOxwyVissuH8KyJ0PEKjpN2ifyj3ypj8J+hRB8juscC5vfuqewDPLTo0NaGfmam9HdwiYip5YKX6N4yvT9/HjOAspqkXiz+LYrdUONR1eaeJvVwYsXGg5THOUwx52tvdnLA9kkBA0CYGMbOzQeUqF73L+qRq6rOYyObL1k0YKnlBsW45GdlvSGKxg3C+SxDLBDElf8Xv/AJoT8lp+1FWCt3fXHjwLnaZx4EzjRDNJRXPUEbTILG1qht3KZ/l/1WJd/eNzj/efc4Sp+W1sxTFvJo8JaqMieY3/jyAGZb2zLrxJANaC4Nc+bOwKuae7F1zGbmbS/gWYlG8iHU25oMDisYm9cEhx0N0PhmOCy9B/qJP9Qu3fXfVApuUmraV00TcLNLlRlaW/06SuUrZHVs2ueBX0iMPXlBBQBhKyG6csG8wXr+mQoCQHZbJ+tdZ8GM4YC9wDDbIrZj0ks5sMEEzujN3QKhvbN74HX4mv3EKp4V7gv40lO+TA2jDIMZhTG2649QwJvSvL3zSYNo3pmY31dnTwP7X9xm1YlMp5vbEABeYrU3iNuc/JjKiH5XKKzhrbEgc2e4dn0nK3XK6A2Efjjihk+xexiOe0p4jBoCrNAAO4rZaxwlus2Hy9LndH1LQygb9MFL6T5twwWzJLZCXo1HHA7UF9+6E90TdHOIvc3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39850400004)(66946007)(53546011)(8676002)(110136005)(478600001)(4744005)(16526019)(16576012)(31686004)(5660300002)(54906003)(6486002)(31696002)(4326008)(2906002)(36756003)(38100700002)(956004)(2616005)(316002)(66476007)(66556008)(186003)(26005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bXl2U2krTDFhT21ZNW14SGtZWHcvSXRhVE5mcXIxdmtxZDlLc0E1L3RhYi90?=
 =?utf-8?B?TDRYNVRHcHdOMDJpMGJ5bTFaOW1UK2E2MldpTkZrb2hYaml5Q1NBdE5DT3Jm?=
 =?utf-8?B?R002UVZzcUpYdjUweGtNcTRpYWhCRzRHdnVWTnZLN1BkcDJ4U3k3cCtUVVN3?=
 =?utf-8?B?TXUwQjI4Nmxidkg5TFNNQk1lUWNEMkhVcXpjL3lMZGNQS1piTm9uaDVMcDRD?=
 =?utf-8?B?NGtXZHFHaThsOFdsVEN0WVhnVWU5ME5sTWpPSXU3Vml6WUtiNVRTOFRTcWhm?=
 =?utf-8?B?MGZ4cWhJK0pia21YMVFHZGlEQURib2pURmRXei9VWDU2eW9NUk9mSmZDOTUz?=
 =?utf-8?B?VzFMMm9Sdlk2M0tnTG9XRFFraWFRUDFVTllxRS9vTTVLL2owNGhuUG5ubjZS?=
 =?utf-8?B?Y1NaSS9iOHlYV1lDc0JRZmRSYVZVWTN4L3JrSlMxajJUTzVoMlpkc0k5WUQ1?=
 =?utf-8?B?dm9ESzloeVNyV2FKVFZ6enh4Um55RkFjYXlQSHIzQTUwb08rQXMrNThlRkxR?=
 =?utf-8?B?TmFveEhreUlaTlkvemI3Qi9CU2pzU0E4cjNmNXVROFFQMXpvTDdQZ09pT0tG?=
 =?utf-8?B?VlRkeFhBSXAxU29kc05DZ043aDFhZmt6UitjOXNuTGgybTlkNjBQQkRtS0lu?=
 =?utf-8?B?R0lNekVmazZyQTIwSDJCdTJUSEQ5NkJsalZmZ0d5S0xVd0t6TmorcjZGTlMw?=
 =?utf-8?B?SEJLZDdGbVpVWmE2djdna0tLZFprT0hacHBBenpsdXROS00vSnZTbzBYaGV2?=
 =?utf-8?B?MHJtSURnSnFYaUFiOEZDY0wzQ1MrVEl0U1U0V05vR2ZhOHFZMzdLbU5kOXoz?=
 =?utf-8?B?ODVCYVRRSFJJeHZ5RU05ZDBYcWZaSDVwSTc0VGtLcit6UmJhUUxGcUM1eTEw?=
 =?utf-8?B?Z1MySHROWXhZYzBiVkloY1QyYzM0clhOQ1pJUndUM2JjeDVQS0hoZzNTUTBU?=
 =?utf-8?B?RkpzcjY0NVdyOWw4dXFPOTJuRDJ1c1oweFUwbzYzTm9XQ20xdDZJbDlaUUl5?=
 =?utf-8?B?cTR2MUlkNmpnQks2QVdXNFlndjFnR0o3S1lWcVZQSlNnbnNIdU5FV21NenAr?=
 =?utf-8?B?cjdvZGxOYXBPYzNJeXFRdHU5NVhQV1k4YytKUmRKOUlJaTF5RkxWOXFoelk0?=
 =?utf-8?B?MTlTNXhsWkZ1Qmh2Y1J0aStFZS9yNm1Ocy9MNFovTkFXRFZPVTE1UmpSRktX?=
 =?utf-8?B?YjNKZFAwTWRITitieE4vWUc2aDdwVzl1ZjdXL2lvZ0FWN0JDeG0vVytvK3RH?=
 =?utf-8?B?MnlHK0VLa1VJeE1jdGhYTzg4WFdRRUMzMHQwWnRNM2ordU0wUVd1UUNXSzdN?=
 =?utf-8?B?QnozQlUxYmZ5VS9Xa1ZiN3dxdGVOdzdJaklwSEVGNXUwTHdpK2czQUdHaEVO?=
 =?utf-8?B?cnFhNjhqa1QyT2pKWStpOVI1ZG9waVBWd09iUm5wUm1tb0VISDdvZmgxUHM3?=
 =?utf-8?B?aXcrbmh0U2thcmxoR1dUbmxFbzNtVzkvYVpQSU5oV2hoZmVUYTRnODAralhO?=
 =?utf-8?B?ak9kQzFVRTRYUHBQS2JJVUtTdno5WnNVK0dqMFlzd1NpWnZ3YnE4Y3VETXFL?=
 =?utf-8?B?ZDVFRHBtRWNNVWRvdFU5QWJKMW1XVkRLRFVQTHZISFp0RlpuOUhYdmJQMW5C?=
 =?utf-8?B?dXpqdFVEVDhqdjJtR2VJU0NsK1dRVHZyWWkwdm5TWnU2ZE1ITmNrSFZJUmNM?=
 =?utf-8?B?NzIrUm1pN1dzTXh1SzJ0M3lSU1hVUGJZdWwrUEkrakl3cGk3RG10SlFPdXVK?=
 =?utf-8?Q?5xRHFOisXO6BYSDuL+xG5wwCSaiYp+BiP6TM1Gy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bfbd02-270b-444f-e3a2-08d904f6fa62
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 18:55:06.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnIrWn6PIwVGkoYE2Gd9sqRo72qnTw8I8FhbDeKdhNd87N/Zi5kfkw7rEy2Fa1Jqy2eEe3dhpsm4UwwPzm4qSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1818
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2021 1:48 PM, Borislav Petkov wrote:
> On Wed, Apr 21, 2021 at 02:32:13PM -0400, Bandan Das wrote:
>> Maybe, rename the parameter to something like psfd_disable, then off
>> -> disables mitigation and on -> enables it. Or just rewriting this to
>> off -> turns off predictive store forwarding is probably ok too.
> 
> Yes:
> 
> 	off - Turns off predictive store forwarding.
> 	on  - Turns on...
> 
> Ramakrishna, you don't have to call this a mitigation - this is a flag
> which controls the feature.

Agreed. I will fix it.
> 
> Also, those 4 patches can be merged into a single one which simply adds
> the feature along with the boot-time controls.

I separated them into separate patches because the KVM patch depends on one of the patch.
The corresponding QEMU patch depends on another patch.

By separating them into 4 separate patches, my thinking was I could keep them logically separate.
Yes, I can combine all 4 patches into one patch but would like to get feedback before I do so.
> 
> Thx.
> 
