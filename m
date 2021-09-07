Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1178940316C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 01:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347599AbhIGXRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 19:17:07 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:1344
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234094AbhIGXRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 19:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0S4qp6shQw2pOAyUiNW3tLTUsDzvvUKJl1mQ/DUJrE9a8yoL1mQuHx4hswLfhjgBDb/SudflYWr1KsbQiC22Sm1kaRjiq4PYtDKY9WZPiTx92gFPijfHigTLr5VhHVl6UTBYj2KpdORtxXNwxuA4pf+ljox9jbiTKAxJjKzGz/Vet+e7w+0vD3ZSCUZfN6FPIMLLXhy60/akzaqG9pZpFDyop+V4bK2uaPR9T5fgjCLi+/a77M7t9vomGzIH34hCBHZyLfm3r1fpg18HF+KKkOzE0fGB16SsFTV0AgzJe+RaSBvqrhyBifIF49DoYvSdgY78UfQL56GNk08kOcgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hQVAig46rsWjy+PklS0170w+3rczsBqbEB39Z7TPu3k=;
 b=HXE1bztsx5cD69LtOP6Yna35lu2DP+rHytqLcGT2M7m5OQPoNnACf3YvZAtB1rjv+1lNjV/AjfAKy01JOvrdJSDFmIAfaBnUMxlKooA0YS0rb6+SH2nvIwhK/8MqktC5hv+hzdDwKOq3HmVX38Yc3kPgYUKBHKr2HorHscL/nCL0EfweA8QL1L3yQLc064V6B+H7QYyG73+ANy+T/n/XgW8c5gtpPS15RC0Y7Vayizl6l7WiXk+rxkIvodWKQhdYOzPqD7Rf+qgdRsFGt7Owd0rdprNkKSOr7xiGfLw2ecdTbhjC9Pd6m1m84SB657+0JZv+Fu0+G2rfuO7si2i97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQVAig46rsWjy+PklS0170w+3rczsBqbEB39Z7TPu3k=;
 b=V6lEh/zRv0KG2oRgIUMCBIEPYijJapJz++k8Xp6qmzxwhzYYacFkWvS3K7IQrJeau5SAhkyClrc+5PFM6i0t6ELpGcwV8Sb8jDVCdzZlcwVCLNONx7aGRQtcvYiT4S8SogKdhvqL+gGfe7BMDAWcPIMf9lCD0HQKc7eYS/gmHog=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1502.namprd12.prod.outlook.com (2603:10b6:301:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Tue, 7 Sep
 2021 23:15:56 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%6]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 23:15:56 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Moger, Babu" <bmoger@amd.com>
Cc:     bp@alien8.de, bsd@redhat.com, corbet@lwn.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20210812234440.tcssf2iqs435bgdo@treble>
 <20210902181637.244879-1-babu.moger@amd.com>
 <20210903000706.fb43tzhjanyg64cx@treble>
 <dca004cf-bacc-1a1f-56d6-c06e8bec167a@amd.com>
 <20210904172334.lfjyqi4qfzvbxef7@treble>
Message-ID: <35a32225-25d3-88eb-f427-14c93c38c97b@amd.com>
Date:   Tue, 7 Sep 2021 18:15:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210904172334.lfjyqi4qfzvbxef7@treble>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0075.namprd12.prod.outlook.com
 (2603:10b6:802:20::46) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.31.0] (165.204.77.1) by SN1PR12CA0075.namprd12.prod.outlook.com (2603:10b6:802:20::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 23:15:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce92fd60-70b9-403c-4366-08d9725571d6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1502B376173CA6153AD40F2695D39@MWHPR12MB1502.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZ+kyZzxMYuC9duGNsmJYir6dZttRLQP2hQx55e6QsINo446uuwaDNj1mKsr/gou8CdiPyySPOth33Rni+6Z+4dZARsitivk18+I/UPWTEzK1VCjzx1FeoHvJ8eUe5mcfA+r4l84b6m6XDU8JKr5a0520rJNF3YdK84okpdhXkFLoZMFYJpnvIv/a+3+Yd/YD/+Jq8JvkixqsYkJCatxHfHlvsj5QmNPeTaKzD/U6V4ijToMido83clygXXi5dMJYfedwllNd0mq3nWPNgp3EjwGIPOQn8OfawNYLb/688MAtzGohi1uSgEphRFfe9rnhCX3mDMJRt5BUkHpG8SVtidZJ7WPXHWSgO1yBbDQwwR2Ge8jQULj5yJehw2NyM8+eJ46kyw5imMa6vkwrrtfDELW0xwWCydiBLpCgE64cj4ZiZEFzm9+Vcnbb3pWoNzefKXytSU6gs6JCs9nGBXnwR7+uo7gWrCpHGDtMZ4gYJSQ2Iimj/IrsQ7BD1qwA4KV+yUBKigrSKpj7ekaAtvE65EgySPYw3oFTDaPLSj905aO2NVWcgmJH+RaeMHC+TTu2jOqhARPstziwErjJO0Go864d5IYNAlfukXDU33kz0HghPG99aEeRYBj+sjNz4100JoLZu93G49qgs8QnC0astJzdbIj8kiACEhGlnPTzK4hva9EJs01i2dV0/1Lb80dY+QUrPYW227adLld/BWZdh7JsqSzuOfj6srUR7a6PlPxTL5q+cF9xn3fjsh/JVk+n1esoB47/L3ITTwSeCZ6o0Pz+AKfCm2coeghN9kjrrZlgYoXcfVAq9Lg4d/oC8/KFhY7SttDzivRlzBMjcGabu9dOxeJ/+FBH3nYWqD4jSXB3jTbxSBWRZQKacl/0ps5kgoA0ojfMDv7ZrFenPpAzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(316002)(8936002)(110136005)(44832011)(186003)(16576012)(45080400002)(31696002)(2906002)(966005)(956004)(31686004)(5660300002)(2616005)(478600001)(4326008)(38350700002)(6486002)(8676002)(38100700002)(86362001)(53546011)(83380400001)(26005)(66946007)(66476007)(66556008)(6636002)(36756003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEJmaGpUUjN2YkJrT0RKSHJxNkI1eXhLVnNhQ1YvM2FZMFEyU21TWXc4NTR6?=
 =?utf-8?B?Q01rbE96Y3lDRk1wQzZiUTRwWlRVUzJyQ0xNQmJkaERTN0k0Ykl4QWplR1Bv?=
 =?utf-8?B?SVNmVnFhV29VazI4S2I0WlpjV2ZwaEVKMmxPVVkzNjF4STVMVXRNZUh0R2wy?=
 =?utf-8?B?QWNzYi9iTUxYWW92TWJYYW01UW8wWmZnTnZ5RkFHRy8zZFN3bWF4OTJwUFIv?=
 =?utf-8?B?S0R3Wk1ZNkJ2RjhPenV3anJzWjZMK2FMV0tXVjdZUlozdHZ2MDdwRWJCMEpj?=
 =?utf-8?B?NnMyeFZSdEk4Um1QeE96ZEZ6MVYwTGM4RWw1NmpmUGJ5L1ZWK1R2OHJkTmxq?=
 =?utf-8?B?VGloK1lMZzQ3RC8wT3NBa0ZtL3NXZUxNWG41RDhpY2JheXNyVG1rb0JOa2dF?=
 =?utf-8?B?aTNvT2ZScnB3YnFXRTZOY2FuakdMcnVnR2ZPemwvakRidUVlaGZjTG9iVXg5?=
 =?utf-8?B?US9qMUg1RGlsbGdYd0QzNjlHRUxySTViMzd0b01zeUc5U3FUT1VROEdpcHF0?=
 =?utf-8?B?OGtkanBJalhZSDlrUW55b3ErVm02K2ZEWDBoR2dhOWx0NlpyU01ObVBsRC9L?=
 =?utf-8?B?SjhuOUVrMmNXdTlkTUhPenh3V25wNDhmNzRvN1B2NnpCR1RiRStWN1hXRnUx?=
 =?utf-8?B?dThRcHhLRFBRWmRXYm9jdU5sN1NUK1RXMHpyd0pCS3E4TjUxdE1TVHY0U2Z2?=
 =?utf-8?B?bURLdXBsN0dveHlxWmY1K3JUOHNoc2l5aWgveERya3p6cGZtRVdPb1JFdE5i?=
 =?utf-8?B?dFFPdW5zWlY0MWpIUUZqbEJtclBFVlZ4MlpRbEpDSGlvWk90Z1hKdy9EOGE1?=
 =?utf-8?B?d3Z1VlYvdWN1Q1lQUFNGOHlXL0JNQVBSdjlnSzV4ZWxBQlI1TmgwdHY4OWxm?=
 =?utf-8?B?ZkF5ZlVKUVZKQXlSejV1MnVvZzdwK2dJQ1Y1NzlCR3VsTjk0bFc4aFl5TnBn?=
 =?utf-8?B?ZjdvOHBOR1hadGY0RmpWTTFFanUraXNJYjkzS01MQWw0QjR4ZEdyMTI1RUxS?=
 =?utf-8?B?dDUwbTU4dEhpTW1SbWYyM0s3OG4rNnMyYzBzZkl5UGVtMzdXYXZKZjQ2SFJG?=
 =?utf-8?B?MnJ6T0hERjhwa3gyZTVNQ005OUsvVDIwTjZncitLelhzYXB0cEJIRXRRaGQ5?=
 =?utf-8?B?QUFQK3RVOVU0QzlDSy9vaUlmTldQVG10OXR3Y3VXNzRFSnV3ZDU0N2YvaEYw?=
 =?utf-8?B?SURnblVGNjNMSnduWHJNOExIa01hdzJ1UlBuMzg3eHI2UndVbzRURXI4cytL?=
 =?utf-8?B?QTlZbHlDNVBaVjNNSFc4RjQzTWhydnk0UzNHRzNJa2RSUm05cUNZd1VQbVpD?=
 =?utf-8?B?ZUVIR2tVNXdtV2c2bWt3SDBrUTkyTXZpVXMzMktrZkx0SHNzdVVFUUxjSGFz?=
 =?utf-8?B?NXlWQTQxUCt1REQ2eHg3NFpSbnFlR3dQdm5mWi9BYlZEMDJPVmlwVFBWQ045?=
 =?utf-8?B?RW4vSThGTVJWTHFCVkEwalAydmY3N21FOVAvSDk2cS9qVTR4dEpuckRYUk9m?=
 =?utf-8?B?QXpISDR0Tll2cmFpTHpCK0pVUWFacVB0Vjkwc3hScHhvL0xwMFhWSG5UQmRv?=
 =?utf-8?B?eVQrS1JVUDZxbVg4bTVNckxERHc4WkRSTXl1TUtqT1p1VHFiSjdwdi9GZnVS?=
 =?utf-8?B?eXZuazJUU05HSjB3ZllpMmpXVVdGMlZpTFV2bzBMNmZjTTZ3U0ducHpjbnNw?=
 =?utf-8?B?SFpaMlA4Z2FjTXpjNXdzNS9Ld3RUUXB4MVVydWMyVm1GQkxGU0xjdVkzL2Jw?=
 =?utf-8?Q?Q7hG9XkciMVofeqWl4UiuKY6NYwMUdv4RSuziBJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce92fd60-70b9-403c-4366-08d9725571d6
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 23:15:55.9191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RdENOC/Ht2pv3migk/cig7U6dZTUpHCg+AEffcfMO9MsLFxzW6FOMMC6cRNqd2MO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1502
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/21 12:23 PM, Josh Poimboeuf wrote:
> On Fri, Sep 03, 2021 at 07:52:43PM -0500, Moger, Babu wrote:
>>> BTW, is the list of PSF-affected CPUs the same as the list of
>>> SSB-affected CPUs?  If there might be PSF CPUs which don't have SSB,
>>> then more logic will need to be added to ensure a sensible default.
>> I can't think of a scenario where it is not same on a system.
> 
> To clarify, I'm asking about CPU capabilities.  Are there any AMD CPUs
> with the PSF feature, which don't have SSB?

No. That combination is not there. It is always SSB + PSF.

> 
>>> On a related note, is there a realistic, non-hypothetical need to have
>>> separate policies and cmdline options for both SSB and PSF?  i.e. is
>>> there a real-world scenario where a user needs to disable PSF while
>>> leaving SSB enabled?
>>
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2Fdocuments%2Fsecurity-analysis-predictive-store-forwarding.pdf&amp;data=04%7C01%7CBabu.Moger%40amd.com%7Cfcbc2781e8b54ed6ca6b08d96fc8bdf2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637663730522361553%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eI8DisfM4gpj%2B4AOfOUFGOFRZP6zqhSsTJIwINHK5GY%3D&amp;reserved=0 <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.amd.com%2Fsystem%2Ffiles%2Fdocuments%2Fsecurity-analysis-predictive-store-forwarding.pdf&amp;data=04%7C01%7CBabu.Moger%40amd.com%7Cfcbc2781e8b54ed6ca6b08d96fc8bdf2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637663730522361553%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=eI8DisfM4gpj%2B4AOfOUFGOFRZP6zqhSsTJIwINHK5GY%3D&amp;reserved=0>
>> There are some examples in the document. Probably it is too soon to tell if
>> those are real real-world scenarios as this feature is very new.
> 
> I didn't see any actual examples.  Are you referring to this sentence?

Agree. It is not an actual example. There is also this text about where it
can be useful.

"AMD believes that for most applications, the security risk of PSF is
likely low and where isolation is required, techniques such as address
space isolation are preferred over software sandboxing."

> 
>   "PSFD may be desirable for software which is concerned with the
>    speculative behavior of PSF but desires a smaller performance impact
>    than setting SSBD."
> 
>>> Because trying to give them separate interfaces, when PSF disable is
>>> intertwined with SSB disable in hardware, is awkward and confusing.  And
>>> the idea of adding another double-negative interface (disable=off!),
>>> just because a vulnerability is considered to be a CPU "feature", isn't
>>> very appetizing.
>>>
>>> So instead of adding a new double-negative interface, which only *half*
>>> works due to the ssb_disable dependency, and which is guaranteed to
>>> further confuse users, and which not even be used in the real world
>>> except possibly by confused users...
>>>
>>> I'm wondering if we can just start out with the simplest possible
>>> approach: don't change any code and instead just document the fact that
>>> "spec_store_bypass_disable=" also affects PSF.
>>>
>>> Then, later on, if a real-world need is demonstrated, actual code could
>>> be added to support disabling PSF independently (but of course it would
>>> never be fully independent since PSF disable is forced by SSB disable).
>>
>> Do you mean for now keep only 'on' and  'auto' and remove "off"?
> 
> No, since PSF can already be mitigated with SSBD today, I'm suggesting
> that all code be removed from the patch and instead just update the
> documentation.
> 

Hmm Interesting..
Just updating the documentation and without giving interface to enable or
disable will not be a much of a value add. In the earlier
discussion, the direction was to go with simple "on" and "off".
https://lore.kernel.org/lkml/202105101508.BC6CC99FAD@keescook/
But, I am not sure right now.
thanks
Babu
