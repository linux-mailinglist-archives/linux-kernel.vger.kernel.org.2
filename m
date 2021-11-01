Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C901441E17
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhKAQ1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:27:14 -0400
Received: from mail-am6eur05on2087.outbound.protection.outlook.com ([40.107.22.87]:11616
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231362AbhKAQ1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:27:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m70OX4uAb0WLLHZWVHd4FLy9KpFnCDdfxjdSLoZELm4/rSr9glo5sBfz+IZ6MiExv3R3BEuCbtv6WQ26qR+c0sDuxtcZIfam+A/22+zYC4lO/qum70x4pl0EcAvQyNKzi8ecbc1BsRrqhbkc73syoww7e+py5ZvC0Hbp/fze8WiKAOTx50Ksw/7t/giyvDUoXFnLQVuhgOQZ5k4daOnodPBwxQv+HqkSfLd9I1ONWArTAb/+lU0XRA+ju1VykTyvdfcHboI1yU2giyxBjUtjjGJ6vaZER06eDUAN2uj2QOSMy5MP/e5pc+FFPL0QjOkSkgjCgWvHG7LiTDqa0P9KqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpJfXlos3/HSz5HP8NO3X5x7ysL8D8mKWDQfCGixd1Y=;
 b=IzbMvOzxzapYLEo6RLf04YjiShsPWacx6PPQPekvcWUtqkfsQM074yC7QNdwa9bcEWlNaFpZ8lTltbqaaygs2gzyaXcsMVOXMvnrk3rK74XgPj4cK+APVW6fNPFRQ0KKkv4UULvF+zZ8+jSRG8Xj91Vx1IiSv27me2Tr8zIIWdwhLN0eLouFuPho664TovJEruK9vY2cChKAYdNyDnor9eW4C6BJoIZkkMCvM4dlebZwdgv9wAOC6oSnVsozile1o63inAH9a3+ou9F0ahz9sKUFgGZ5dNlAZsa2IZ34fMnuYAFTT9iS1RXbpFcl2aqlnplaKEg3UWsrVYkAbzUXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpJfXlos3/HSz5HP8NO3X5x7ysL8D8mKWDQfCGixd1Y=;
 b=Grf7jFGcbgOgXeQ5Nt8KXryKO0AvcWdprzWo9XV1jI7mJY49PTMkCQ1GaFCLECcdgrK6UN44yflBFm8cGwUjSJfkFhr+B3Ad+tTiq9S5Ffsekij7F3rsMAiOg5OttwN71wU/Ka/eA/BHV5Pts+Hj98Z9+zpG4/8LwbmLGwA8R1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB7097.eurprd03.prod.outlook.com (2603:10a6:10:1f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Mon, 1 Nov
 2021 16:24:37 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 16:24:37 +0000
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add generic GPIO reset binding
To:     Rob Herring <robh@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20211018234923.1769028-1-sean.anderson@seco.com>
 <YXi5CUCEi7YmNxXM@robh.at.kernel.org>
 <47d4c3d3-d6ab-3888-1cde-937551537e3f@seco.com>
 <CAL_JsqL3oZXJJ5_i4BRGpvWu1X8QFB7OGG=D+zLvvWb=UR1mWg@mail.gmail.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <322faa05-240e-0fd4-8ceb-68f77e871cf6@seco.com>
Date:   Mon, 1 Nov 2021 12:24:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAL_JsqL3oZXJJ5_i4BRGpvWu1X8QFB7OGG=D+zLvvWb=UR1mWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:208:91::38) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by BL0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:208:91::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Mon, 1 Nov 2021 16:24:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4cb04f19-7755-4018-8d65-08d99d5418d8
X-MS-TrafficTypeDiagnostic: DBBPR03MB7097:
X-Microsoft-Antispam-PRVS: <DBBPR03MB70977649C226F1523345BB25968A9@DBBPR03MB7097.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H/AxA56o9K2dIi46MHbTuT9QjtBgMflvVBA4iFs20f+nqrHxQHx3Zo9PYNIhuMJqQDgUyCpJdMVtH134+Ajf6OEiZ7o30tsRJoudHs5MIBIegAWHGUmG/woDwf8qTVp8s0ooT03nZd07WxQXgJ6IRTNxZI98VIDyIqaXRpaz2WaUvj30okHAVsRo22RpkhqdUoww1nODh1GsbXC113yKDRc+30MCG47JaHFcDwQXd+9GfaObOYcrKjriYp0tCACfygCEKl1ibBgQqN0HYb8DlLQPMyRlo42ZNbqVWVjVJxsTrDUzNgxMP6YAXjgMUonSMmih6UIoQ/NqXgGadK/0q3BcvB8qu1aphvuBEaoDK3VKQqpiNNt6rhSMtX7euxa2KgmxnJA3J9vIFQ512LX2rCKG0rnWbu31HJLFpj3DNwZccLxiudl9kxoIj9Sup31fmSPwgI8g3aNdo/TFjqweG9lJ7xoTYvpJtzyLzU3LmRl3GgZRQqhKjchLhaezNYneIp0rQO81FO4AFhrScQ2HC7zNvVu/2IYAXNPh56OVMasssT7CoOFOd4VMsk85DntrOFGeKV6KSR03QYuIZFWVonmh7HjvhZPGNfxuNnQ6V5MUITn12gzb4HOb9t0zfpP412E0w6nzqSAuqubrjBaMiprhZlsqJqHG8Lz1zfWx1JW+SK6cmUW4PnwKSwMamKvUQbOJcioycv8LDJz1zvcDRhPYzEAASrZ5Dhe2GwEQkWGsvoJk9n5W7zquLbCWgnj+a7Px2WcU/Bcj69bjn2tmpgPlKmdPgwFeCTjyykRZBlHlb5anvi5llhWXh8R7glHz0g80EZjkdofY0JowZraRc9JhVqpAgaHPwJMYrDLw9gD4G7O7vopmy/zWEfN8+jVr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(6486002)(6916009)(966005)(316002)(53546011)(54906003)(16576012)(508600001)(52116002)(31696002)(6666004)(8676002)(4326008)(36756003)(5660300002)(2616005)(956004)(186003)(31686004)(83380400001)(44832011)(66476007)(26005)(66946007)(8936002)(38350700002)(38100700002)(66556008)(2906002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGozUmRIcWtaK2tOemdYek0xdW02bm1ueTZlQXpmMTVZT0VrMCszWmVrRzBv?=
 =?utf-8?B?K2NhSG5wYStCZmkwVFBuZW4wUi9MTWFqbjNTODlOTWo5QjBzU25SRTNUeTU2?=
 =?utf-8?B?Vjl3N3FHYnlNVWgwczRoeWIxa2FVeG9zTk0vUUc1UjAwSkpvV3Y5aWdZcTFV?=
 =?utf-8?B?aTloVXY0blNEMmlYTk5pbmVZeExyNFJEeU1WbW52SE84U1I2c2YyVlc4RlAx?=
 =?utf-8?B?UnVvK05yUWdqR0I5SUYrR2YyOUdycnk0eUMvbDJPTlJzQnVNMlMwS2cxVW9B?=
 =?utf-8?B?NDhtMDNXWStHcE9OdkFxWEROYWJRQk1NMElTY20xdStERTlyZng0aXVIVmJS?=
 =?utf-8?B?UFVWTUVwU1NFMWs5N0szdjA2eElMZXdDN0xvS2hZZHNiaEhGejk5WERCQnQw?=
 =?utf-8?B?b25nS0llK2JyYWxMZnV1VHUrRWphYjdia0lGQ3UzT0NpR1RPSEpONTlKbGhk?=
 =?utf-8?B?VFJveVRvOEZZbC9QTU42SExNUWZDSWU3RU1ucDEyQXJ1eTJKdnBkOVlqeDNj?=
 =?utf-8?B?RWZGZzFZOFU2K2N5YTQreXJnSVdPWjhGYk5sa0pSMVY2bVFQT05QTEpiaTk4?=
 =?utf-8?B?ZFFJNGphRkhzdEpsNnd5SXpoWDRMTG8zZkZLcG1TUFkyOWM5MWJzTHo1Wmox?=
 =?utf-8?B?b05pT0pBQ0t6bWJWSHdKVldPbnRlSy85WnZaTFRpVXhONzlKWDlVZFVHbGc4?=
 =?utf-8?B?WWxweTNPZDFEWll6MlIrL3FMMTNkZHVOaG5kNStLNmowNGNIWEFHcy94b3A2?=
 =?utf-8?B?UlY0REZQQnJjL3JMN00ybXlDTnlKZ2JwWmhBY3oxbGZKR1JGZng0YW1lM2k2?=
 =?utf-8?B?ZWxwZGhCbWo3bHRaNnZnVFhuaGxJR3UzS2NnMko5S3NhL3lhNXNaZVk0R25z?=
 =?utf-8?B?Uk8xTE1sZmd3WXBwOWtycVlaN2pKZDVwc1QydUNFaHJXc24wY0FMTzc0RXJs?=
 =?utf-8?B?N1J4K1MybGRiaTJuUHdpaisxZHRXSjBVK21CU1dWSzNVT0NpVDJkQTRLMGJr?=
 =?utf-8?B?bytXcXNURWFobXV5TFpFeDlXajd4TlpmL1VHRnZ3c3ovRVZBcGx6UFAxMGQ5?=
 =?utf-8?B?aXkvc0RKSjQ0dkNja0swbEt2TGhMa05CU2ZKNE8zZnlEaWUzaUoxRmhlMWI2?=
 =?utf-8?B?VWV1Q1hkUytHWTlyM1RtMVRYd01hRndYTlhYdmdRdWw4ZS9GMkhqaGNRblRu?=
 =?utf-8?B?OVpyNDFVOGtoOHhHdWptbE5lMVBTNGhwbXBUd2dJTmx3MHEzRmljTmpNUDJM?=
 =?utf-8?B?TG40Sko2MXprR0Qwa2RuVXliejczUGFFZTZPUEh6Mlh2SFJOUGozM1g3NjAw?=
 =?utf-8?B?aVN2NFR5VE1namNYK2lZU2pGQmkrRGdqekVUQ05UY1MzaWFhVnNFblV2NDky?=
 =?utf-8?B?RkJRTVlXTHlnOC9XNytXWGRBa2pUL1RXVk1aTHFDQ3NWdTRzU3VHR2NodkJZ?=
 =?utf-8?B?eFpnNFpCbmgxSTF2aCt6OEZDeXQ4Qit4emcxbEUxeW8yVGpGV05qLyt0UTMz?=
 =?utf-8?B?QldxcXVyQng4dkhEOXZkWFhVdEV0eWpUVnRxaGxDK0lzT2lxeS93S3pVY1NS?=
 =?utf-8?B?VmZtQ1FidlNoWVJSckhrZEpxK0pOckx4VTkyZzhiNmlZNklKMlRxODNoQ0lH?=
 =?utf-8?B?cTBFQjE1N290RWRXMEJDS3BlZUtDRDdyNVZxL3FVRUNnTkVKTjJ5bDQ1emdF?=
 =?utf-8?B?VmJuZ1lxUG8vR00wdGZvU2RPbk1PNG04QmJHTjA4L0ZRUFlCSXZjT1I4QVox?=
 =?utf-8?B?ZXBvVkNJYzB6ckFQSFp2akp4RHNhZk02KzYydVFZcklGV3lJdkpUMUZpakRS?=
 =?utf-8?B?UXJHbjAzRGVINnlPUkxXeGVRcXV6V1hoR0RuYnRNRWdvR0xxNUk1SEdaaW5F?=
 =?utf-8?B?cDhWRDNEQVdhbzB2V2ZuU1U5ZDhGL3lwbys5dGdZWFdCZ3BOYVVmTEI3MVNm?=
 =?utf-8?B?MmR5aEhJdVVKTXJhMzhia2tYWG9GNHRNOFZpUDI0RC9ZdmRJRTdIZ0pCSENp?=
 =?utf-8?B?aUJQV1B2U0o3K3RjaCtVZFlxVGg3YzM3RnA5WWNIdFI2SVV1dk9zZjc1RUlq?=
 =?utf-8?B?VVhpblNmZlVEWmlMUW1YYlNYM0lRa2JIQVVwdXArcUc3QnpJbzNGNjk0aUZU?=
 =?utf-8?B?QmVFYU5md2Yzb2paNllUMFZhOUJERVVHS2c4VzFRTkdwRzZUUjBReHk0dUhV?=
 =?utf-8?Q?Vrlq0wixfxOHcrDrSftj23Q=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb04f19-7755-4018-8d65-08d99d5418d8
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 16:24:37.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAijYy+HRd4AVuMnGqu62NOnQrvA4DhfWyBND4CVUvf3gAoOZKPhmasCTFxwyDbE4sEzGy5rJ3WvHh13Hf+N5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/21 9:35 PM, Rob Herring wrote:
> On Thu, Oct 28, 2021 at 10:19 AM Sean Anderson <sean.anderson@seco.com> wrote:
>>
>> Hi Rob,
>>
>> On 10/26/21 10:27 PM, Rob Herring wrote:
>> > On Mon, Oct 18, 2021 at 07:49:21PM -0400, Sean Anderson wrote:
>> >> This adds a binding for a generic GPIO reset driver. This driver is
>> >> designed to easily add a GPIO-based reset to a driver which expected a
>> >> reset controller. It offers greater flexibility than a reset-gpios
>> >> property, and allows for one code path to be shared for GPIO resets and
>> >> MMIO-based resets.
>> >
>> > I would like to do this last part, but not requiring a binding change.
>> > IOW, be able to register any 'reset-gpios' property as a reset provider
>> > directly without this added level of indirection.
>>
>> That would be nice, but it seems like someone would have to go through
>> every driver with a reset-gpios property and convert them. Since the
>> reset GPIOs are
> 
> All that has to happen is when a driver requests a reset, the reset
> subsystem can check for a 'reset-gpios' when there is not a 'resets'
> property. If it finds one, then it can either instantiate a reset
> provider or add that GPIO to an existing provider. Then you can
> convert drivers one by one, or not.

I will have a stab at this.

>> >>
>> >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> >> ---
>> >>
>> >>  .../devicetree/bindings/reset/gpio-reset.yaml | 93 +++++++++++++++++++
>> >>  1 file changed, 93 insertions(+)
>> >>  create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.yaml
>> >>
>> >> diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.yaml b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
>> >> new file mode 100644
>> >> index 000000000000..de2ab074cea3
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
>> >> @@ -0,0 +1,93 @@
>> >> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>> >
>> > GPL-2.0-only not GPL-2.0+
>>
>> GPL-2.0+ is a strict superset. And bindings are required to be BSD
>> anyway. I don't see the issue.
> 
> Not everyone agrees with GPLv3. What about GPLv4, v5, etc.? You're
> okay with them no matter what they say?

So you would rather have GPL-2.0-only OR GPL-3.0-only OR BSD-2-Clause :)

> The issue is many people pay no attention. Just copy whatever they
> started from, or put whatever they want. The dts files are a mess. The
> binding docs all defaulted to GPL2. So I'm fixing the mess with
> bindings and that means dictating the license.

Ok

>> >> +%YAML 1.2
>> >> +---
>> >> +$id: http://devicetree.org/schemas/reset/gpio-reset.yaml#
>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> >> +
>> >> +title: Generic GPIO reset driver
>> >> +
>> >> +maintainers:
>> >> +  - Sean Anderson <seanga2@gmail.com>
>> >> +
>> >> +description: |
>> >> +  This is a generic GPIO reset driver which can provide a reset-controller
>> >> +  interface for GPIO-based reset lines. This driver always operates with
>> >> +  logical GPIO values; to invert the polarity, specify GPIO_ACTIVE_LOW in the
>> >> +  GPIO's flags.
>> >> +
>> >> +properties:
>> >> +  compatible:
>> >> +    const: gpio-reset
>> >> +
>> >> +  '#reset-cells':
>> >> +    const: 1
>> >> +
>> >> +  reset-gpios:
>> >> +    description: |
>> >> +      GPIOs to assert when asserting a reset. There is a one-to-one mapping
>> >> +      between the reset specifier and the index of the GPIO in this list to
>> >> +      assert.
>> >> +
>> >> +  done-gpios:
>> >> +    description: |
>> >> +      GPIOs which indicate that the device controlled by the GPIO has exited
>> >> +      reset. There must be one done GPIO for each reset GPIO, or no done GPIOs
>> >> +      at all. The driver will wait for up to done-timeout-us for the
>> >> +      corresponding done GPIO to assert before returning.
>> >
>> > This is odd. Do you have some examples of h/w needing this done signal?
>> > It certainly doesn't seem like something we have a generic need for.
>>
>> Yes [1]. This device has a "reset done" signal, but no reset timings
>> specified in the datasheet. I don't know if this is truly needed,
>> because we can read the ID register, but it is nice when bringing up the
>> device. I left it in because I was using it.
> 
> Okay, but done-gpios belongs in the device node that has a done
> signal. Your binding pretty assumes you always have one because you
> need equal numbers of reset and done gpios.

Have two devices, one with done GPIOs, and one without.

> Anyways, I don't think this binding is going anywhere.
> 
>>
>> [1] https://lore.kernel.org/netdev/20211004191527.1610759-16-sean.anderson@seco.com/
>>
>> >> +
>> >> +  pre-assert-us:
>> >> +    default: 0
>> >> +    description: |
>> >> +      Microseconds to delay between when the reset was requested to be
>> >> +      asserted, and asserting the reset GPIO
>> >> +
>> >> +  post-assert-us:
>> >> +    default: 0
>> >> +    description: |
>> >> +      Microseconds to delay after asserting the reset GPIO and before returning
>> >> +      to the caller.
>> >> +
>> >> +  pre-deassert-us:
>> >> +    default: 0
>> >> +    description: |
>> >> +      Microseconds to delay between when the reset was requested to be
>> >> +      deasserted, and asserting the reset GPIO
>> >> +
>> >> +  post-deassert-us:
>> >> +    default: 0
>> >> +    description: |
>> >> +      Microseconds to delay after deasserting the reset GPIO and before
>> >> +      returning to the caller. This delay is always present, even if the done
>> >> +      GPIO goes high earlier.
>> >> +
>> >> +  done-timeout-us:
>> >> +    default: 1000
>> >> +    description:
>> >> +      Microseconds to wait for the done GPIO to assert after deasserting the
>> >> +      reset GPIO. If post-deassert-us is present, this property defaults to 10
>> >> +      times that delay. The timeout starts after waiting for the post deassert
>> >> +      delay.
>> >
>> > There's a reason we don't have all these timing values in DT. The timing
>> > requirements are defined by each device (being reset) and implied by
>> > their compatible strings. If we wanted a macro language for power
>> > sequence timings of regulators, clocks, resets, enables, etc., then we
>> > would have designed such a thing already.
>>
>> Well, there are already things like reset-assert-us and
>> reset-deassert-us in [2, 3, 4] (with different names(!)).
> 
> Yes, things evolve poorly. What's just one more property added at a time.
> 
>> Part of what I
>> want to address with this device is that there are several existing
>> properties which specify various aspects of the above timings. I think
>> it would be good to standardize on these. Maybe this should be a
>> property which applies to the reset consumer? Analogously, we also
>> have assigned-clocks so that not every driver has to know what the
>> correct frequency/parent is (especially when they can vary among
>> different hardware variations).
> 
> Yes, there are some examples, but you won't find many new examples.
> The rule is power sequencing requirements/timing is implied by the
> device's compatible string.
> 
> You are looking at just reset. What about timing WRT regulators and
> clocks for starters?

*shrug*

This just seems like a very common area which needs to customized.

--Sean
