Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5D34741C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbhCXJE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:04:58 -0400
Received: from mail-eopbgr80133.outbound.protection.outlook.com ([40.107.8.133]:37541
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234223AbhCXJEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:04:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8+e6fB8esugyOdNbtVmYIADubuyNZ/8pDrp3Z2S1VBR7OdT0UyCZv/FdakVPVqeekPkmf/7lkO5Nmw7xmCDcyS+PdIW4om0CAYsOqY6RiYoIeSOJNatzT1ZZX7w11FOQzU2rsjdc/+LluNgQmZNe+g68f8srofc4GMKPmBGTFPy8oz8NEuecjJc4Knfd3/CqHHk1TTG2wAbV/m50qfstmzqoLA9m+h9iFXIM0bBrv8Zbvox8lOFOpuJ/qRzbt7nI++pFvxR+TczIMt21lB9FZHrVZoIqaHB1QMXvRuez9lv9hyq2ridRqKbiY7SbNEYcuwXpXLjmSWMkDyTNp6hkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I2kraGF1cHJrDzaE34S0NBjKlCDeo+UwtLJbeRTpmc=;
 b=EO4tICptvD4xnUtijOD6fixH6lbk96r+P5YkKgw8OAB9ivw7b9vulAf9PCdmeb8l6hQ/WugVmBMoQ0FkiFP/L/EZD6QNM/uQC58G14alSar4XVLaxTWB/DP4kHcWdSdIXUdRy9BRoXHfUb++nLlH7Crlg9I+/UtREde0AZ2y62YJZjfVWu/0CoNEaxKNQ4NWnhbicWO8YbiQC3/ALI2KRlWJCvRFC9WLD2zgXyVDrwS9rcSWvv1Grc9UIO9M3KuyNY++nRvUIKsPViuTclmAX6/BzQ81VaiJkttodEGeg/A6cL1gE0sa4KnxCaSLWT/X5kYBMK58QEjQxooQzcEmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9I2kraGF1cHJrDzaE34S0NBjKlCDeo+UwtLJbeRTpmc=;
 b=DI2vUAakKDbfACpC0EkDt5wZXeUeH8Jc0Cs/QDSub/rp+ZN3w02slHDvIaJUv+liGT7PCHQY3jI+PpmWNHC+SqaC7i2gyYH+nW4sAprakCU1CDGGf7TtbO9rIdQjho47Py1wUwtDs1hiVlFU+jHInmFBHlUAkxlCeAoLyvWDZIE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB4468.eurprd07.prod.outlook.com (2603:10a6:208:7a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9; Wed, 24 Mar
 2021 09:04:51 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::7c49:66bd:9795:1a3f%3]) with mapi id 15.20.3977.024; Wed, 24 Mar 2021
 09:04:51 +0000
Subject: Re: [PATCH v7 2/2] ARM: ftrace: Add MODULE_PLTS support
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <3eecf51d-b189-9e8b-f19d-a49d0764aae5@nokia.com>
 <05608bc8-f44d-5f91-15ab-af00c59b53e6@gmail.com>
 <e726be33-bc03-0515-f430-c5a34ebc3619@nokia.com>
 <20210312172401.36awjh4hmj4cs6ot@e107158-lin.cambridge.arm.com>
 <134e1a2c-daac-7b00-c170-bcca434d08df@gmail.com>
 <20210314220217.4mexdide7sqjfved@e107158-lin>
 <20210321190611.d6a3hbqabts3qq5v@e107158-lin>
 <20210322110106.2bed3d50@gandalf.local.home>
 <20210322163248.id7qplbk6och6kuw@e107158-lin>
 <504d72ec-70a6-7e50-dbbb-16d693ce6150@nokia.com>
 <20210323222230.2d63hdcxq6strbug@e107158-lin>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <25056e99-dfd1-645b-39fc-14f47085a7fe@nokia.com>
Date:   Wed, 24 Mar 2021 10:04:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210323222230.2d63hdcxq6strbug@e107158-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.166]
X-ClientProxiedBy: CH0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:76::26) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.166) by CH0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:76::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 09:04:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ebabdb0-b756-4f84-0aa7-08d8eea3e201
X-MS-TrafficTypeDiagnostic: AM0PR07MB4468:
X-Microsoft-Antispam-PRVS: <AM0PR07MB446868D477A949EA4525D1DE88639@AM0PR07MB4468.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rvv+aYUC3pVQlaUpXlnNVmKZjNHA9l+smA0hpqx+neZNamA5QFTHQa7tFTrTmNlzCHQNQQpyBM1wXIwCapdPFRsJPay6fqYIrxOA/rqn9Y6XX1Cl+a1sYPsm0bpVW8sPLhCgw0g+58h8wi5ES4oZTXHgYxJJL9+LnDUCqu19LX9TKlE9YaKBTS3Tx7VIHma74CSYXiyUYVzxX3JNZbcucXqW5W2UfQGh6mLlETYyGMvj4nE7eZ2guoleMm1hM7zH5uWK5G1ykQ8ktwn87ARY29tDM9nW5Mwk8M7eh6AWVmTXg6Psd3vuwJREZqqdVJja7NW9wBOUFgqWClZ6xuL+0P0XzzLU/BSTehRnscrtr9h0DxSo+wnzN7auvE/15Oiol1OhVfje8IOAfLvnnacmsz8+a/KTo1uvOD4XtIA0qnQRgREUa0MPrS9RLl7AXzSoAwdx8VAtXgkv4IwaK6i3Dk81myZbt8UeGmqJKrKpfb5h6xj3SSGKhPmfzwSanOWl7t37dXWt/O+coOs13/n0ijP/f8KvHUY3ZKlRGgxGq3royPVHPzqQUCQ6NNcFauh5SXBWJ4wZoBl0UpuxOcm3+A9T+Gnl5mTYey9yayaxbVAPBTqsGGu4zvUdpfDtxrzR7EvBKZoIJpmiFiYSJlXdZwIIYYfPwTHeFvvZqJycGoY+hlh65teuE8L1D9aKD/fl3VjvJbBqsNv7Fcj5YhvMkjjk1FrDlJTfJ6vrQ4+Uy7U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(31696002)(66946007)(2906002)(6486002)(186003)(478600001)(316002)(31686004)(6666004)(66556008)(956004)(16526019)(2616005)(66476007)(54906003)(83380400001)(86362001)(38100700001)(8936002)(26005)(6916009)(4326008)(5660300002)(8676002)(52116002)(44832011)(6506007)(53546011)(36756003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R2RGSHJ1b05haUVQQUNWTmE2S0hpWjdYdDFTNUhmUlZOblBaVFR3czNMc2pO?=
 =?utf-8?B?bFV6d2hzcnFSd21tTzZaQnY0RStMRmRmd2xVL1BhZElmaG8rSmRXbFJRUXIx?=
 =?utf-8?B?S25JSEJHN0tJNmMvbWRCdjJRZ0ZLMkxEV0JKNzkvYjlTNWNzdEg1MjQwNHdX?=
 =?utf-8?B?dkVKa1RJNnJLOUxwd1I5SCtKakN6N3BUQ2xUK0VYZmU0bTJFZ1Fqd3BUNmd2?=
 =?utf-8?B?SWxwVitHMzZxQzdxWlRodFhTSVpyUzZJN0tjdWYzNFhkVm5CRTFxZTU0Lzk0?=
 =?utf-8?B?RGZGeU1iTmhpcTFUNFhJRE5oUHdnVkNvV1B1OEFMWEwyU1drK3pMK1ZVU0F6?=
 =?utf-8?B?ZEdqY2IrbzdTNUlzK2xYOXVVeVNYWElBczZGdFM0U3pOWjE3ZUtJbTRYQWkw?=
 =?utf-8?B?OUNYVlgyeDVHU3NEd3NkMFlEZmlzWWZubkljRURkWERETzNmcnM1RmxIUTlm?=
 =?utf-8?B?U1FtNVBSaEorQ0RmVUR4cEtUeTAvWjE3N2pQb0dtQWx0U0Z0NE15cFpXb1Nu?=
 =?utf-8?B?eGhIRjA2d1YzSGxPeTd6akdNNWJ0Mk9HTi93dVdvTnVORk5oZjVmbklKL09D?=
 =?utf-8?B?QW5kWExQMFlXcTRiRXMwNnRiUmJaOE52cHN3T1gwMzZyUndrWWFjVjlYVlZJ?=
 =?utf-8?B?UGlZQm5uMFdDd0I3TFNHR3A0SUhsRXRPQk40NUM4cGxlaFg5dFZiZGkvV3c1?=
 =?utf-8?B?N2k1Yy8rajF6dDJDY3VJaTZFeWFoU0FxV1E0SmNqV1pCMGExUkN3NXB2VVJr?=
 =?utf-8?B?YjZZdkZqeCt3WFJJWm1xYWlnaFBuMU90bm54RjI3OXFRbkxBck9QWHJmbnRm?=
 =?utf-8?B?U0g4dDZXRk10YWdxS054Y3BYclFaaG5qYUVzK3RsUDFRcVZEQVk3RVJhMFpC?=
 =?utf-8?B?RTdKd3NBYlBpZnBpK0tZRVJoSzVNMkFELzEyVUJiMUxncTN4K3FDVEdtN2Jj?=
 =?utf-8?B?NmRCM2xjK1liUlFLZGZ3dy8wTFJCbGJ4YzEvRStwN1RSQ3VNbTM2ZmZnaUZM?=
 =?utf-8?B?d1RXOWJaSWVadUNjb0JUaG9TNU94UDcyT1pEejlMdTVVZitUUEdCd245dXdu?=
 =?utf-8?B?VTk0OWFWZHZLamdCbFVaRWh0Lzh1RUtaKzgrYUhtTW84bTlQbVd0VmlxOWtC?=
 =?utf-8?B?RWxTNDM5WnI0N2V6MWxvZFpHWWVkNHh3SldFRmx0cnlUUjR1dDNaYzBsRHVH?=
 =?utf-8?B?dHhqR1lhS1pya0VXaEp1S0tBUStmc2JUcHg1cTJJUlVxSFNJaVVpWDhDQjA4?=
 =?utf-8?B?ZzZ1VXB1YklnaXI2NmJYK09QakFxclpxVXVOdStMMlM5Y2p0K1N1RnZrcEE0?=
 =?utf-8?B?QmRDbU1QMkZHS1JUbnhnM1pQVnRlRkRoY3g5S1pTbU9zNGdoMWpUcHBzOFhH?=
 =?utf-8?B?djBpNXE3YTBja3FQQmRpdW1wQURJelV3QUg3R1R4S010M3BrVm5seHVZRlVv?=
 =?utf-8?B?enRoOHp1K0hESGlaT3VjeWpCNk9mMzl2cmhHdjNDTHRHVTV6SzR0bXNLdUV5?=
 =?utf-8?B?bC8yLzhha0Q4eGZ4bk81V1lFaVk5VEFlNEVGdkRiZDJuUWdPMDR2TzFwczJ5?=
 =?utf-8?B?MGRlbmt5QTN4Q1lkN0tvRVhHQ3RVVUMxRGZMVkQySkJlQ20vSFcyNVNXR1JW?=
 =?utf-8?B?ckphWGM2WXVzV1FIZ3hiZXVZNXN3NnhFMVkyeVVmbGR3UGthS3VNVSsycElJ?=
 =?utf-8?B?bHhydjk3cm5PYVM4dlJ5cXNRZkxkRmJqc1FLTWQrRXZGTDNnSERBSjVtM3hF?=
 =?utf-8?Q?pg9YvOAWGDlfAQuX2/m3ILLLiqeApJtFvoC7gbW?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebabdb0-b756-4f84-0aa7-08d8eea3e201
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 09:04:51.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IwUkNfX0YX4ue9Mx+io0ssem+QFZsVVLlYjFYFOdtUMYWp3P95mdi8jlkNjgESioez7hL0aFkgkZ9qG9P/hzhkRkN8LNBbEXe9XEehTz2Bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On 23/03/2021 23:22, Qais Yousef wrote:
>>> Yes you're right. I was a bit optimistic on CONFIG_DYNAMIC_FTRACE will imply
>>> CONFIG_ARM_MODULE_PLTS is enabled too.
>>>
>>> It only has an impact on reducing ifdefery when calling
>>>
>>> 	ftrace_call_replace_mod(rec->arch.mod, ...)
>>>
>>> Should be easy to wrap rec->arch.mod with its own accessor that will return
>>> NULL if !CONFIG_ARM_MODULE_PLTS or just ifdef the functions.
>>>
>>> Up to Alexander to pick what he prefers :-)
>> well, I of course prefer v7 as-is, because this review is running longer than two
>> years and I actually hope these patches to be finally merged at some point.
>> But you are welcome to optimize them with follow up patches :)
> I appreciate that and thanks a lot for your effort. My attempt to review and
> test here is to help in getting this merged.
> 
> FWIW my main concern is about duplicating the range check in
> ftrace_call_replace() and using magic values that already exist in
> __arm_gen_branch_{arm, thumb2}() and better remain encapsulated there.

could you please check the negative limits? I have an opinion, my limits are
correct. I could add extra parameter to arm_gen_branch_link(), but for this
I first need to fix its negative limits, which, I believe, well... Approximate :)

-- 
Best regards,
Alexander Sverdlin.
