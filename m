Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE613FE422
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhIAUgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:36:54 -0400
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com ([40.107.93.88]:13857
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230231AbhIAUgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:36:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEdSjWBjIN4qznYLKRYsmNCQnmREpVHCvCO42nKZFsdUTLd68NvqW3+fs9PCLR/xVIvtZT7Izq+Wu+Cxc3BYzkq7MeMyYci9eyG9IkB1taubKIzqGjSoZkK2rXD/yq2a6XxD6wYdOLhGqQOzfup4I4bkKdAQCTp7Zufrx7/6tsMCnsc266kaVL4US1241uknOuNwCM42neAgdsLaabHqsIZKzAA0saNcn4H/inRDuYasqoep5uPkYt+dO2Eao6FLx1lqgUzhHzCYpzQMKWkuPEhrSwCe9YE8GZst569MH+gOwDAO5SekIyFhd07QRbDWcpnUru7UWNQyq9n15WQoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxpWQdO7y9tHn8HMKFqOnL7rx5L/CUds4DnUuxu0eJk=;
 b=JaMQBer0kWrgvDVEyytpe1jO0WqIPouVBbOlbfSDlGbFGoE2+mgS22AIVWahzDocSGuc3HG6/qHdp+osLOxVT0MSz+D8IlZMbT+iCX6C7A/Dka9ALfNT//3vOPYxlPRtI+470xgBw4wAXEDZKZgeB+ltcmo6Edki4me9cYJD93zohA2k8JxviK7DW+1HpGkOgIGLXYlcQc2TecteMVppmICO1jVH47ZzYg4SZkREBgPiuPwP5F0QkM1NE1PGSIqsziHNC1r4XtLmrnMo1or5y0Kqn6wLVAiZkZjquiJd18J3rzHp1dIAIhr3uiSukEKu1wdepqu/G65yJajoNBro4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxpWQdO7y9tHn8HMKFqOnL7rx5L/CUds4DnUuxu0eJk=;
 b=e/y+7sWYRLJ42uVUMiMHBbZXaBQGOepZcdoj0YKP5CyTM5HbBq5bZS1uslN0azkfinnq74W2IIglU3oi+nLiMNvHDF0KzvScpioGbVUJizcpvJAwcrkrtA5XO0SeCXTL/mggaBTcFYT2SGtfK//cPOkHZf/ZW928sA2OBgFWcLs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1757.namprd12.prod.outlook.com (2603:10b6:300:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Wed, 1 Sep
 2021 20:35:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 20:35:52 +0000
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
To:     writetopawan@gmail.com
Cc:     bp@alien8.de, bsd@redhat.com, corbet@lwn.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20210519055001.jtos5a4nu6j6kum2@devbox.home>
 <20210901203058.14598-1-babu.moger@amd.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <3cda7690-1a26-5377-fbe1-41f047a4ff3a@amd.com>
Date:   Wed, 1 Sep 2021 15:35:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210901203058.14598-1-babu.moger@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:806:d3::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.31.0] (165.204.77.1) by SA0PR11CA0014.namprd11.prod.outlook.com (2603:10b6:806:d3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 20:35:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80374153-67a6-49e8-6860-08d96d881724
X-MS-TrafficTypeDiagnostic: MWHPR12MB1757:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1757FE36A718ACFB045AABE495CD9@MWHPR12MB1757.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCfUSZ9FzmU2mBX1UjrQBMiFrW2Atn+xB2Vh15M1gRfzldwkSM6LMjVsuNywjS/147ZsVq2NLJqaEgOQ3ofxvXEn5sB3XwdiCzNyPuT7Ayni5B1ZbgzLaZ9hTeLdQx4Qyn+MGeLBzw8TwISl+JXRlBcum8VaS9XQPgBbxP+OwKIrbAkvrIuK/wE+8a6CBDGd0LlW9fLTIPrwc/K1L+O4swsKsad/3al/CE70GKxdD6j5DzUtEBwtFvpEsix2/X84byE3a8K6tRhYFvjVOA1iOkSy73AmoqugpbGhVBOln2C2ssz691w8OWj7VS8FhIZz5Yg6mnI90zgcQr0G5KtaI9gBxiaT+sPEv+7ywQ3l8VyTYg6AGmDzrWs5PNglI3KRWMlwbpIxxVqPiejb2kmvFvtDk+Icqy21zhOZ3z/eD8EF8hnSZqtI81flZjEoGgveKkvM9XjKZlxIoEyqCeYsRtc+8869QZi+OieNfbI4gyTOMQcqLwSEIxZ1Dop8VJv9o66kXByo1CsZzkJaDV5Nc6qxPo1B+hxxtr+UZNB2AEbdArFE7B2v6WpuU9IIyepile6uZ5dYtNjH/HXjefqSa+mz58hKGNd9OZXlkBPhx4zxl/SbNXy+mkbHh6xeX3zggmjiSAlPV6ximKaYhc6zyUzfRumvTbchprovJ2je3uc3OB88ocqFVYHamzLO3C+PJ3Wwg9+K04tA7qG31syxXPhS+6otVD+iOL1WpG7KMIq4tcl8VjaoXBNtXSdbAmXfZkrcJJch/bR5e11upI0XGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(956004)(52116002)(16576012)(53546011)(5660300002)(8676002)(44832011)(2616005)(4326008)(31696002)(26005)(66556008)(66476007)(478600001)(86362001)(66946007)(8936002)(36756003)(186003)(6916009)(38350700002)(6486002)(2906002)(38100700002)(4744005)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlAxS2ZnWm4rd3JPZzczVVlNY1ZPYmFpK3Jjcm9jVWdUMlNrZWRTV2V1cWFF?=
 =?utf-8?B?NUM4YkdBdjV1VCsxdXd3ekVzWTVCeE83NThSM1JLT0Q3TGJLc2ZZQ1k0ZnB2?=
 =?utf-8?B?cGpRYm1rS0xUd1IrMXIxWGN0SmMwTkV2N3NUUUFrTXpNL0xreEVRbFJDOU5N?=
 =?utf-8?B?R1B5ZFlrVmdQMG5YN3k1aTFhdHZIUUFjRGd3YW5UeVpJN3dNSXFVZjdZR2wz?=
 =?utf-8?B?R2lKalRueEhUMW9xZERPR3BFMEhQVnpiQWxKOXVJYjV1UXhXL09iTmZUaUxr?=
 =?utf-8?B?LzR2V0QwWm51TGZYdERCTGN6OFVpUE5Da096ZTdmMzc0SVR1UXhSMk1oclhR?=
 =?utf-8?B?alAwZjZZQzFHSG9sMmJock4zQmNnSFN2d0ExVVV1RFZTZm83WHhicFNjUGJs?=
 =?utf-8?B?MnUxdjc2K29Sdi8xay9JdVpOME02aXhjdzNGTlNKVjJ1UmpJeHBkOE1xMEE4?=
 =?utf-8?B?eEJVT3lJTG1YSkErS2JJeUcxVnYxMi9SaHY2cC9xbGlPK3ljTFk5blFQZ2Vp?=
 =?utf-8?B?NEZQSDRjMGJreGN5RW9vdzEwZEZxWi9udUZlQ2xHT2J6VkZ4NEdlK2kwamt2?=
 =?utf-8?B?MmhKU1VBM3pGL0EyeUQ1ZzdiUTJRcFpxL1M4eXhlclAzaXBUZFc5aTU3Q3p1?=
 =?utf-8?B?Ry9JSmRBSWJOOVNQM2M1emNWRkp5dUFGbDRIcVIyY1ljQ3JNaTdnQkc5L21j?=
 =?utf-8?B?NXU3WkJpa1lLZ2FTK3B2WDl1SVZIbUJZQlE3ZlB4RHl1MSsyc2JPamZCcmkv?=
 =?utf-8?B?OEZmUHE4NDJmenFLeGVyWnhQQ0M3SEhpakw2SThqaDE3dXVWQjY4V3RKZTZX?=
 =?utf-8?B?UEhPMDRBV0IxbDVHQ29VVFF3TjJWbU1IK1AvbzZXU04ybVRINlU0elFJY3ZE?=
 =?utf-8?B?NlJtR3B6ekZ1NDhKQWZwUlJOS0RGd1RFZmtoWmVydm96OWJYVFNDTTcxV3VS?=
 =?utf-8?B?ZFAzcFd3WnpSSWNxTTA5eHRrbjVDeWJzWVU4N1BCTzBjL0FzQXYzQlNRbDRw?=
 =?utf-8?B?aGhpQnlqQTJheTM2Z0pKMHZxMXJLMG1rRzBsQ1dIc3RyL0VwTHN6WkZYM1F6?=
 =?utf-8?B?TjR3N2xKY0JNRE92QjNLTEhjZ2wwYTZCK1NjYUYwRHpnYW8yUFZvMkpwSzIr?=
 =?utf-8?B?dFhsTCs2WFlnRjYxWGdhSEM5UVZLMlJPcUlZMXUyRWoyNWVrMmpXSW0xb0Er?=
 =?utf-8?B?ZmY0dnhicHg5dUxSZHgwWFBSSVJOa0xoYzhPSXUrL3p5M0NoUFZVUjR6dDZa?=
 =?utf-8?B?VGQ2R3JPUUR5ODUzMFZ6VFptakFRZWdkOGFDazB1WklSSzB1SU5IeFE0SXpm?=
 =?utf-8?B?N1FpOXQ4YU9TTkRpYjgrRlk4V25Wc1pwaFlpR25sbDFpQjRwTmlUWTlpTkVF?=
 =?utf-8?B?cUFiZWJzU0R0QTYvNUpydEhqQWE0bGdCOW9XRUJnMXJOWFo5NUhOdDBjaVhh?=
 =?utf-8?B?RzNKc2RJNlZkK3VyVnBIeU5LNTVGdCtPbW9CdENLT283RGNoekZOdVQ1MmJz?=
 =?utf-8?B?OUdaT0VZSTFRSmttWWtIQlpyZ3dPVVRnOVhueml3emtvVkJIUnFKSlJ5bUM2?=
 =?utf-8?B?UGVWenNGdk9mOG8xYTVnVHRHcm1idWcrUjFKamRpK0hOMDZCYkZsbmlJN2FI?=
 =?utf-8?B?Y3c4QTlraWQxRW15cXZ6akNEeG9iazZFRHlqM1VkQ1RKcHhoeEZMdGZuRW82?=
 =?utf-8?B?b1MwUW5LbzFRakorMzJ6aTIwczBmNnA3OWFnVDgvcmlIV3VJZkhydVlPMmVj?=
 =?utf-8?Q?qH3tRI61vQBjo7oLvHWLRp0v5QTkUQ+eiJaHvFo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80374153-67a6-49e8-6860-08d96d881724
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 20:35:52.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gunsn0I++voEilYVgy3ztpWAoqxbHLkLmUVAK4udKKNpj1IPbr+/lWmFz4jSROd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1757
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/21 3:30 PM, Babu Moger wrote:
> Pawan, That is kind of odd. The ssb_mitigation enums are defined in bug.c. To be consistent it is better to keep it in nospec-branch.h as they are related.

Sorry, I meant all these mitigations related enums are in nospec-branch.h.
So, it better to keep it there for consistency.

> Thanks
> Babu
> 

