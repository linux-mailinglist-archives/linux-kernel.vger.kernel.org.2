Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5C7386DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344512AbhEQXhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:37:47 -0400
Received: from mail-dm6nam08on2128.outbound.protection.outlook.com ([40.107.102.128]:38336
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344503AbhEQXho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:37:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvW9GRKxV52aaQPkz+tHtSt2lgp28oZ94RvSUE8VnGKC8pLefn7XQfhTKB1RM6vXkNsneSysgIQmJ5B/Buad3S8lVy1VbXKtxzJq2nPvni8MEkJfCXd0kNxAhfK+BjAKTeE+S7QIBR3QbltYUNPvfRS+40edR7v79yN1aHie6B9hcxx2La6NEBehCsuPeKngOG6sQy+yJ3CUw47Vjr+/kEJBPutVRTYogSK7xCJbfF4KmOGhzf5njrUAhDNRFG2kr9tq9SOh7dGWmRVTXTu26U5by6SXQGkCmAbT6tEGZ1bQ2ml9kvLtvh89bvGDK43Cq+xlBWnN6G6YxiyhEupitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEx7PlDSw075IQuT+LLlDE+ehZyKulRIIFgIjTu1jd0=;
 b=K04SiG2ptAiysVTUgTy+eHBL/50U3b7HKCVSQ4Amh5sPMXBVY45dHGb59jgG24Gf0J1eqczEay6j30viOTd5IZ/w6ewILlaj1akO+bd4KjMg6kuRvPnM3f+1SM8rw/TkjdR4VYhuLW4n4UX9He/ABzMtkHdue3kCoY9mG1iHr4Ac/FiBucG5JCn5NJPpy9M3ZTvkO7fHRjFBpGrMyckI48k5xoi+Pk4/UzRZWvKqK7KQvN9EoPvH44S6bYzf17wXV5yddzoLzYZDNeEAU3SvnVkFoxFpiP/dESYJevx7kuFGIgGEcJ0MgtLP1AcSCAQTTPt629R4YVSW1H02r76UEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEx7PlDSw075IQuT+LLlDE+ehZyKulRIIFgIjTu1jd0=;
 b=TT0SoyqN2rmrgXJBVkojIRJqO19k5MtMya5M0H2+tGaHJICDIMuUBQYXMzo6A4A5JEkO5Z2JMBracKXYgjN00Ds//sAilQawmNIorpg53lhmiOqP5o8JdSCoA9mtMYBlzvx1FXXGqr8Pgk2vFVBhTG2vyw6eYJ93xu8NsvA6Ww0=
Authentication-Results: os.amperecomputing.com; dkim=none (message not signed)
 header.d=none;os.amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MW2PR0102MB3482.prod.exchangelabs.com (2603:10b6:302:c::32) by
 MW4PR01MB6338.prod.exchangelabs.com (2603:10b6:303:7b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Mon, 17 May 2021 23:36:24 +0000
Received: from MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::d840:7aa7:58d4:b503]) by MW2PR0102MB3482.prod.exchangelabs.com
 ([fe80::d840:7aa7:58d4:b503%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 23:36:24 +0000
Subject: Re: [PATCH v4 1/4] dt-bindings: mfd: Add bindings for Ampere Altra
 SMPro drivers
From:   Quan Nguyen <quan@os.amperecomputing.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        "Thang Q . Nguyen" <thang@os.amperecomputing.com>
References: <20210422090843.4614-1-quan@os.amperecomputing.com>
 <20210422090843.4614-2-quan@os.amperecomputing.com>
 <20210430201918.GA3806853@robh.at.kernel.org>
 <52550615-ae38-d88e-a597-29dc9c71755a@os.amperecomputing.com>
Message-ID: <ee17c000-6f70-84d9-f7a1-0d30b03dafab@os.amperecomputing.com>
Date:   Tue, 18 May 2021 06:36:13 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
In-Reply-To: <52550615-ae38-d88e-a597-29dc9c71755a@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2402:800:623c:e886:54dd:c702:a053:5817]
X-ClientProxiedBy: HK2PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:202:17::13) To MW2PR0102MB3482.prod.exchangelabs.com
 (2603:10b6:302:c::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2402:800:623c:e886:54dd:c702:a053:5817] (2402:800:623c:e886:54dd:c702:a053:5817) by HK2PR03CA0043.apcprd03.prod.outlook.com (2603:1096:202:17::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 23:36:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: affbca73-d71a-4016-d4ca-08d9198c9526
X-MS-TrafficTypeDiagnostic: MW4PR01MB6338:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW4PR01MB63388F63830DEEB21ED162EEF22D9@MW4PR01MB6338.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6CTX7weLw97dfFJVLKE6s5kShUpoqtIHXeDKPsdDPs2V7W9iMlaK+deuf9eWvyhkpmsZSRLvkzqbMFCJeKq2GUFFN3qvRvXOa2qTj6Q5oExJvsryT9nrZx/gdWQp2wOp9n8hq5xbu3OUdMquXttuGqDU+8bx/qbNNj2BTxJTFdYRRrmU0U5QM5AWw7kf57EE5Hw+wnitDpYH8BNX+aZqd137WaGs6vFjttBuOSzJq9PJgfKVqPgpJ4IWrM9N1BI+FvuAkMSpVk6Rju6PySWKTcIfNrqeRvax5Io/3i56rCiqACzBdoSp6p+kJo7MFSPvYbEeacWegdzWML5DDIkuGQkq1h+b2npifscYnhnOTSAAUyKGNxlUXe+TKoRPYxGNahcJNeRS/x0wBNU9FnP/hiHwA1S6+AdyNMc744EtKeDF+Oy9hXSlwDSUz1SHrvwwAwgFwpAz59PHHv+0ZBkzvabh/q696uRNz/TCBoArcVt9O5e1fGeN3E3IfCweA5TyG6s51TniOiqKgceMuj8lpucfoerAkXW+JqanqYy7VFlerIEsPos+dz282zAR2nX9ybE9x6+sR33gfvV0qibai43YSKSQMrkEnLRM5StcXnFzeYzeNLaz59+v3IsCROWYGZ1RvMVHjcWghto+R1ch7gk5EKid3ZbXIAhbIctuKG1nssv4KHuevSZ7gszHarmf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR0102MB3482.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(396003)(366004)(376002)(136003)(66946007)(66556008)(66476007)(6666004)(4326008)(83380400001)(52116002)(107886003)(86362001)(8676002)(6486002)(31686004)(2616005)(5660300002)(478600001)(54906003)(53546011)(2906002)(186003)(316002)(31696002)(16526019)(38100700002)(7416002)(6916009)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QVRPcFJTMmQyTUNqV0toVTJSeFZIRFd4aExMeFVveTRuVHE3SCtHaW13SWFZ?=
 =?utf-8?B?b0Y0RFBoV3Q2eWgyYis0bTg2TTlrYzBTOW9XSkNqUno2Vnl4cGZhUFRtV2tS?=
 =?utf-8?B?L3B2aEc2SExsK1B6TU9nTGJmdk02Sk56SmE5UFpXWTd3aUxPUUZmOGNqOGhW?=
 =?utf-8?B?THZySk1LVGswYjJMTElNVFRZZUd6L1ZYTk1iM3UyZjI1SjZucTI2aE1IU0Mx?=
 =?utf-8?B?Si9MWmRPU2tYckRDWWNGanNYL0VqSmhzMlJ4U010UmpGWWJTNlRYZDh2UlZ6?=
 =?utf-8?B?NEVybmlkU2xNdFVlYmVXSTJWMEh3RGRrek9nY1lHWWd3aW5sZWdBeG1tWk4y?=
 =?utf-8?B?dGlOUEdYZVR4Ym9WeVpWaFFBS0R4a3RYcDc2Q0xiVjhrSzlTczc4Q0xmUU1Q?=
 =?utf-8?B?QUNxaStWb3NIODdtalpvZVhpdkRMRnA3STRUUStaVGQvTjdHa0k3a1prMklM?=
 =?utf-8?B?SzRkaGlyU2dpUGFYMXZtL3pMZDFGQTFBMWk1NTE4ZnBVeCtoaFpJK0JBaklt?=
 =?utf-8?B?cS82QVZCR1hEbXVTRitqWUxaWUFXajZrMERHa2tDZXNXaXNnNVpXNGVHL0Iy?=
 =?utf-8?B?ejRtNGpaam5hU1NSMXpyeHlpTWh3Vm9ZUE9YY3pqVGV4RHR3TndKemh5N3V6?=
 =?utf-8?B?SnpJaFBSNnRVVEl3b0NrV0dtNm5ISDA3cHFqSWpKd2tqVlhXMjNuVXhKTzBB?=
 =?utf-8?B?d1ZxaUM1aFM0ckd1ZUtLakZ6TGZvaitieUJRODRweFZrN3M0YXRSc0VSZDNs?=
 =?utf-8?B?cHRZV285TkhadTZEYXFBUlFDdGpQemRMTHVrdGhtbTBVTkk0d2JBMkZXU0dr?=
 =?utf-8?B?a3hFWkpWbUJBT2dwdDFxYUVxYkZrVm1kRktOc05ObkpzUHArR0Q3akp1bTFH?=
 =?utf-8?B?Z2JWb0QzWWVUME5BYjFsTFB6N2pJUktkYytnVzBqWXRiWDRLY2xRdWwyYkts?=
 =?utf-8?B?SDdVQi84YmRGa2F0ekp3akNrU0duWmJUN3VlK2s3VFVpazl4K1hQcHByWkVZ?=
 =?utf-8?B?YlNpMkdLS21IdVpUQlQwOVBsMkswcW8wVGFrbzYzTmdLY0tRbDNuY09jeUxO?=
 =?utf-8?B?UkZESEF1c3FudjFXTkVxNFBlL0xzc2ZnSnk3QU9Xa0xqZldlRUx3ZVkvSmNv?=
 =?utf-8?B?bTBxVXhvOVlxRnRZQm5hSGFmdUZiWTdEaWFWVDZLamo4T25EMzI4SmxEc1RZ?=
 =?utf-8?B?UkpVMy8rT0pNS3FtdmlaOTkzV1V0M3ZTR2x1ZWNjYmdvTjJ0bGxUT0tKZ1hB?=
 =?utf-8?B?QjgvRXF4LzhWUDU3ZkMwUmtpLzZUaXVXQk9BZmw4Q0F1YVFBQU5vNHpOU3da?=
 =?utf-8?B?ODI2TE93a1J1eDl3MWMxQk1YdUtORVRGVHl0bEJIVFY0ZXZGNitTS2YzMjhX?=
 =?utf-8?B?djhhNzRIZHV1bnJMSi8yK0N6MFhucm10Nlp6V0c2d3lBLzVnY2ZuVnBmaHRn?=
 =?utf-8?B?NkZUejZodnl1SUhPSGNhWERTMXIvdGJZcEVQQXBQWnF0YTZSb2FIMzQ1dnF6?=
 =?utf-8?B?L0g5Y0ljNGpzYlRkZXY3WEJJb3l5aGxwY2RGZlQ4OHMrb3NyZmM2amlVRWd4?=
 =?utf-8?B?TlB5eVk4U3dQSTVQajNCcUtOSkZDdXZrcVJQYWdQOUIvbmtBV1FDM2hUa0dR?=
 =?utf-8?B?ZUFXZFhTazBOcDcrNFN0SW5SWmhNTTFKMnBZT0d4NEZjMUw3Ulg5RHNmK1kw?=
 =?utf-8?B?cXc0b2RqeFJKeDAvNmgwWXp1Vzg0aWMyL1pUdDhGMjlKQ1V3bVJEOW5UOEV0?=
 =?utf-8?B?djNQTTdJUlJtRTNKbFhneTBhMG85MmRoaHFWYWZNUFFmRVBjSmlqWDNBNFJQ?=
 =?utf-8?B?Y2dBVHpsU3I0L2YvelZxNElSdUNzUFg5VXVmb1kwY0Zad0tXQkFDWkdKV0xs?=
 =?utf-8?Q?1HCGPPoYq1Dp2?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: affbca73-d71a-4016-d4ca-08d9198c9526
X-MS-Exchange-CrossTenant-AuthSource: MW2PR0102MB3482.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 23:36:24.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTwbG/FwfTKv891ZSSXGPIUbnJwsW3+QEde7cdbYzH9y/X1Pdv+BfOXkpR3ZLFRHOJZRaemW5SHE2BKJe+uRlYuGkdouZgfuOr3ez0V17rE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6338
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/2021 15:44, Quan Nguyen wrote:
> On 01/05/2021 03:19, Rob Herring wrote:
>> On Thu, Apr 22, 2021 at 04:08:40PM +0700, Quan Nguyen wrote:
>>> Adds device tree bindings for SMPro driver found on the Mt.Jade hardware
>>> reference platform with Ampere's Altra Processor family.
>>>
>>> The SMpro co-processor on Ampere Altra processor family is to monitor
>>> and report various data included hwmon-related info, RAS errors, and
>>> other miscellaneous information. This parent SMPro MFD driver creates
>>> a single simple register map to be shared by all sub-devices and leave
>>> all the specific to be handled by the child drivers.
>>
>> Again, just because you have multiple functions aka MFD, that doesn't
>> mean you need child nodes for each function. The only thing you have
>> in DT is a register address. Does this vary? If so, how often? How many
>> different versions of a DT do you currently or expect to have?
>>
> Hi Rob,
> 
> Thank you for your review.
> I will try to explain what I think below and expect to receive more 
> comments to improve these patches. And if any misundertood, please help 
> correct me.
> 
> The idea is to keep the SMPro MFD as a simple generic register map and 
> expect not to change or to handle any specific in this parent device 
> driver. This is why we see the simple_mfd_i2c fit in this case.
> 
> And so, all the specific details will be handled in child devices driver 
> and we expect to have child nodes for these child devices. If the child 
> node exist we can then add any specific if necessary later.
> 
> One case is that, each socket (ie: the Ampere Altra processor) has it 
> own SMPro co-processor instance in form of register map and each socket 
> could be either slave or master. Some function may not available in 
> slave socket but exist in master socket and we simply choose not to 
> define the child node if that function not existed.
> 
> The other case is that if there are multi instances of the same function 
> in one SMPro MFD register map, then each instance might need to be 
> differentiated by using is own register address or maybe a DT property. 
> Then we can simply add them to the node of these instance.
> 
> For your specific questions:
> 
> + Does this vary ?
> yes, I think so. The register address in each child nodes may vary if 
> the SMPro co-processor firmware change its register map layout or maybe 
> other instances of a function added. Child device drivers are expected 
> to handle these changes if necessary.
> 
> + About how often ?
> I actually can't say how often but the purpose of this SMPro register 
> map is to provide the info to the BMC. The BMC will need more info from 
> the host so I think changes will be unavoidable.
> 
> Please help with your comments
> Thank you,
> - Quan
> 
Dear Rob,

do you have any suggestion to improve this patch?

- Quan
