Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0EE43E4EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhJ1PWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:22:08 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:39488
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229946AbhJ1PWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOhikeKHon9lTz4RW/ioiUdJAtfyTfXa5JTRgGxNgqyya6ruqCBEWXYqca0G2hbsrTnRgqv+vKPZc0od/ryGDkCX7fGmZOuXn+q7llo+aqZmt9L4YP+G38Uh81wpnQjS6NNTE6QXnvdZ8uaI8wJaddd1m2T3o3NXxkhprMpM5mRedqvnqQGF6KuJKPj0ACzoXY8kcf5yxlpXUYFabaqLbCGtcD3ZzG6pZikq+TgZ2GO57EFVJKB0OQW/SG2mVtWEtbLt43DDAAFxa4F0XyyTTQxiwjuuyvD9JDgU6f1kl4YJul3UdhqrnPntlSO95UyXgKAuEyxwBRhjCyhWHfNhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k22uO7OCtONMaJ0CnNpAZrcQaGYxCKpmzsCWLvRa8tU=;
 b=N/ockKxc5bTZx9YaDy4MTlS0KPuu0t1g7ptEW+kxfjboZ3O5YSwjuBhC8KVErP/jH61P1vD4tXtdVQ5nEUQJwIusZYNpMxaMmQWiJaeoiaGsYaLig3/nfTC32tt7jrs6C0TNSgnb2kJ851E3pnrFoxYPrhyobaA/RVQgXIy60nN3Z4XY0fNE4eL5L0UzYIJp4uLf7IekNSBZNQbu7OsdR/E+3eeAVVHzQrePlrVK1VKSGy2CVjiSXCFFq3hJGkJ/gXfRkZq/bpMRqZSwuT3WAunfisnRHv0LmfuqdCh8PhSmmsZWYxWzNW6B1ukP44bO0rLEFQrhGn+8BsxiF+/5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k22uO7OCtONMaJ0CnNpAZrcQaGYxCKpmzsCWLvRa8tU=;
 b=ptJzirZmezN8qPoJL6Ts067HFZqdNB3LKKWSK9LmFwXKSMeLsoUz0sOT5hD6iMl1646aDixAqz5ufrDj9zmN3Xlcv+34W/pQjV9cFVeUnshiEbjKachCnGgPiYNkRLwn3WmmtP7DxTxmyBNmwHzuMlFcpCr/pXo8XE7P+aU/Tqc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB4986.eurprd03.prod.outlook.com (2603:10a6:10:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 15:19:38 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 15:19:38 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add generic GPIO reset binding
To:     Rob Herring <robh@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20211018234923.1769028-1-sean.anderson@seco.com>
 <YXi5CUCEi7YmNxXM@robh.at.kernel.org>
Message-ID: <47d4c3d3-d6ab-3888-1cde-937551537e3f@seco.com>
Date:   Thu, 28 Oct 2021 11:19:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YXi5CUCEi7YmNxXM@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:208:d4::42) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by MN2PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:d4::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Thu, 28 Oct 2021 15:19:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dc6e45f-06b6-4e9a-6362-08d99a265b93
X-MS-TrafficTypeDiagnostic: DB7PR03MB4986:
X-Microsoft-Antispam-PRVS: <DB7PR03MB4986CA15B8053CE86D2FC18896869@DB7PR03MB4986.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +BsvAdYuhKE5ZIYuPhZa4xwSV6MWJbaaXuyyoHCSaZaLgZJxF5/RcQyDFT0DbfVS570dNAvMO4A6IMfPIZHmRD1wB4Ou/3xXE6GXfsIAUs9t5qJyl6drnybUCLT0Jy9uEBs908IGn2OxkmlNNF2QJfhD86G4CN/SMiRdnOlT0ids+11CXlxMfGSxXoxpTiF7zneQb1L8N/ikv9oXScsKjkEw0G5NGH7349rFcG/bRi9/4TkM4dbGt5dYTkzOzxkZwECuNz1pGmOJdQHFcLnqBmjcyBVV8pk7vT17EHsY99lyTw88PGv99dAcHLTVYyMTPIVMK9szUWODiSlcwsNgAovGTNdOPE7O1mvwaGUc15JAXiNPnpSLfvVRqHIzGh1E4zb9qluaE1CR0DRAcANoXP8bAN+5KmGRVUZy7QZiaC8Iaqohl07YaAigEVG5DDpB+/TIEIjUgaBtB1UXok7em8XwnWjkypJb5Q0R75KfLwoNGXdwjw0JYDkuvvwJ5GbSrR7fjbIK27lAmbEwIjmGilt2en+ON2Pqmbfh2Scg2XiS+OGPCiHpbjGpMluTZxcl5/VvBU2Hn708vuHpemwghoW91ipcsjiZqW3F6UXha5utvO1rF9PLJNR6ADebuWuMYFhaJZPAWHTONblY/NYNMNttprcNye93QQkHvubtUBa0pYJLCC/baG5WVRwCOKPtH8xmL2xy+brNXTxkf344tfLb7qbMMDmj+faAHBfELeLghXEbcpUbQoue3ogv7r1qGFRvIJFhkHkXqHs2H6iJNaTFjvagiwPyk8dJjg7Lh2R0zbruRfwLnta2w1PwVjVx3JxO+Wol+PVDirbMywjKcn70V/Gux5Ily3oA1hpfLZcz+JTUGrFCflUvzBgPi/U4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(36756003)(38100700002)(52116002)(186003)(4326008)(16576012)(86362001)(66946007)(31696002)(6486002)(5660300002)(956004)(508600001)(31686004)(6666004)(53546011)(6916009)(44832011)(83380400001)(8936002)(26005)(316002)(66556008)(38350700002)(66476007)(2906002)(966005)(2616005)(8676002)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TC9UQmhQWE9FYkFLcHp4cHVlcUhkOWVBTnhJbGY0MjZzVThiWDMwU1FlRU5V?=
 =?utf-8?B?WS9ESTRTQjBXYlkvLzlaQi93MEtOaGFOMUNXVTQ1aGVUajJSMjQvQ1h1R3A0?=
 =?utf-8?B?cUhSbWlrSGNrKzl4cTFHaUJob05HaXAyS1loM1hmNTF0WmNkRXdmUnhSMjVy?=
 =?utf-8?B?Qkh1eVNyWmVSdkprSkZlR2xKQTdkRmRuRktCNGtOeTlnb3NlL0tTcmMwbEF2?=
 =?utf-8?B?blRoT0Q3YlNBbEtlUGNCVjZDY2l2S1ExTWdKNXdNYzZmYmlBdGgzUzcvcUZZ?=
 =?utf-8?B?Mk1EZm13eWZoTnZrVnFscEhUQ2xpNUcyVFhjQ1VkbkE1czVNNUhhM3ljeVJn?=
 =?utf-8?B?M0tLbW4vcnNoSUVxQWNJdTk1ZVZ5aXJoY1pDMzd0b2dhWW9tanRPdDNubitr?=
 =?utf-8?B?LzNmYS9pYXBhU2xiWk1ic1Q2M3M0YWUvNGJzY2ROODhySDNhelNUbEUrdllJ?=
 =?utf-8?B?Tk5pb01zQjYyeS9aU0lHZnFmVFdiUVpvR3RRTmhLT0tTU0hvMUdlS3hLQmwx?=
 =?utf-8?B?TUtROGtSYk5XS0Nwa3Y3dWprWGhWRVRXQ2pKMHhYYkZ3NFpFUkUzanA1WGVF?=
 =?utf-8?B?UlRyNW9BRndwdFpTQTlsUXdjc0ZSWkJkUGV0RXdUQUFlaXJ2OE1IM3laM2Iz?=
 =?utf-8?B?dGUwL3RKM25uVStmdGJ2NTd0dG1UQzdlbGhiZlFudERBV0hkaUw4VkhyUGY0?=
 =?utf-8?B?STlVS0hiVzZZUG1yQllFNFJXVWZvZFlUN1pMMXYzbFlRT1RkMVh5RTZvUU1S?=
 =?utf-8?B?YWNySEFUcGNEdTJMNkVsTllFVTRIT2VRcDUwRk5hMm5GQ2E1clc4N3BJdDR2?=
 =?utf-8?B?M3MwR3piWk9ZTkxnWm9SdWNreDJzUWVnbE0xdTNpV2FSdWxTQVlqd09KSTlz?=
 =?utf-8?B?cXZQT3B5Nmk5SnJSTzM0K1JITGxJSWMxd1ZaRWpGb0VRS2tGWGM2S0xtdUtu?=
 =?utf-8?B?OTRVeEg3ZWpocTFPMXFrbjdwZHFFanp1dGpoMW4xQWdiREhIOU1HYlpCWlk4?=
 =?utf-8?B?WnRTcFo5NFlzcnJOaGpVVURKblVCbmVpMVlvNS9CbEVVcy8yZ3VBY21TR2Jx?=
 =?utf-8?B?eGR5UHBkTVlPK1N0bWdaOUc2Mkx1VW82d25HdzVMaGt5UXhiaEZoaTRPSkNZ?=
 =?utf-8?B?R0dhY0dQNVNyWEx1NFMyclJVakJjS1FUaCtqc3FtVytJRkVFSUZPNlFRMEVj?=
 =?utf-8?B?dmJZZzd0TTkvODN4UlNUemhBTWFWNG5YQi9RMGxVR2lsZnNqRlo0ZVVXa3or?=
 =?utf-8?B?Znlxc0h1YVkycFlnWElrQVVHUkpPTHF6bzZqOGxMR3EwL21aRlMvZXZmYSth?=
 =?utf-8?B?MHRneU44SHFieFR2a3pUczFkem5VUWVqWURTOU5HOHFCL0cwb1AvT0k2R3dx?=
 =?utf-8?B?STJNN2Z3SGY5eDRINFlkM2pFT2V0U2x2UitCcjNKcXdRdnR6emZtK2ZkcW4x?=
 =?utf-8?B?emtOanpHbjBmazd6VE53VjZNODdjZ3NPeHR1Sk1XaTNYdzFMaHRXZStVSXFt?=
 =?utf-8?B?ZW5GNUVJRHFwSVlKZnVMOUQyR1d5NmVmMUUyVEtpR0hCRy9JdjRmRzAzQ09K?=
 =?utf-8?B?NktYNXo3aXphM0RFeTA3N01EbmZ4M1lTN3BlKzFIU3Mvbithb2tKSVFRTlBm?=
 =?utf-8?B?U3N4cGRhNDVsZkVjSHFsVG02bWViTWVORUlFZHl3N0ZNLzJlNkE1eHR3ZEd3?=
 =?utf-8?B?NzN2NWNRZDlEbHVWbTR0RGlSVGI0R3lzaE41MzJBUnJRZU5vaWFZSVVzQXQ3?=
 =?utf-8?B?SEIwbGRWU3dob0VEZDdkazdOMFpZYTR4RHZCLzNoVU5iaU4vQ0QxOEVEVldI?=
 =?utf-8?B?NVVPME9RMTRaajVoeEFETkJrVnFtK2dKNnNiL3hjazJnZitsazlyWkNlRExo?=
 =?utf-8?B?K0orQVAzMVlKZ0NDcklwRUZkZnNvaXV4Mk9sdDErMDRyTllEL1daVitGdXBQ?=
 =?utf-8?B?V0pFSlVzSUpKQ2NSN0tiMk10VVFWbUI0UktJRWZPbmhJclpBYjRURXZVSGw3?=
 =?utf-8?B?QjVvMWw0QkVEYWZWSWNrbTVKQVJ2ZHpJcUtveU1xckd2SjN4T1ZzbDRuZW1B?=
 =?utf-8?B?bnNKRS9MbnllZjJhanN5SFdBV0h0Rk41U21CR0hpci9DUUlWQm01TjE0VGtL?=
 =?utf-8?B?akJmNE9LZXVxT1ZUWXBBYzBUSndUVWpsdHd2NWJxK0ppVzRNNTV0bWRjcFdv?=
 =?utf-8?Q?XrYbnJHKlb2WQperKf2esGI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc6e45f-06b6-4e9a-6362-08d99a265b93
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 15:19:38.6835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tyq+B+s848faEGeiwP5jkDlZbtNZdzprJoqqu6jAw5G3z7+HtLa8YFuo1TCRAbK+SHBFdoyp6p12Jm37hng+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB4986
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 10/26/21 10:27 PM, Rob Herring wrote:
> On Mon, Oct 18, 2021 at 07:49:21PM -0400, Sean Anderson wrote:
>> This adds a binding for a generic GPIO reset driver. This driver is
>> designed to easily add a GPIO-based reset to a driver which expected a
>> reset controller. It offers greater flexibility than a reset-gpios
>> property, and allows for one code path to be shared for GPIO resets and
>> MMIO-based resets.
>
> I would like to do this last part, but not requiring a binding change.
> IOW, be able to register any 'reset-gpios' property as a reset provider
> directly without this added level of indirection.

That would be nice, but it seems like someone would have to go through
every driver with a reset-gpios property and convert them. Since the
reset GPIOs are

>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>>
>>  .../devicetree/bindings/reset/gpio-reset.yaml | 93 +++++++++++++++++++
>>  1 file changed, 93 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/gpio-reset.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/gpio-reset.yaml b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
>> new file mode 100644
>> index 000000000000..de2ab074cea3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/gpio-reset.yaml
>> @@ -0,0 +1,93 @@
>> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>
> GPL-2.0-only not GPL-2.0+

GPL-2.0+ is a strict superset. And bindings are required to be BSD
anyway. I don't see the issue.

>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/gpio-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Generic GPIO reset driver
>> +
>> +maintainers:
>> +  - Sean Anderson <seanga2@gmail.com>
>> +
>> +description: |
>> +  This is a generic GPIO reset driver which can provide a reset-controller
>> +  interface for GPIO-based reset lines. This driver always operates with
>> +  logical GPIO values; to invert the polarity, specify GPIO_ACTIVE_LOW in the
>> +  GPIO's flags.
>> +
>> +properties:
>> +  compatible:
>> +    const: gpio-reset
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  reset-gpios:
>> +    description: |
>> +      GPIOs to assert when asserting a reset. There is a one-to-one mapping
>> +      between the reset specifier and the index of the GPIO in this list to
>> +      assert.
>> +
>> +  done-gpios:
>> +    description: |
>> +      GPIOs which indicate that the device controlled by the GPIO has exited
>> +      reset. There must be one done GPIO for each reset GPIO, or no done GPIOs
>> +      at all. The driver will wait for up to done-timeout-us for the
>> +      corresponding done GPIO to assert before returning.
>
> This is odd. Do you have some examples of h/w needing this done signal?
> It certainly doesn't seem like something we have a generic need for.

Yes [1]. This device has a "reset done" signal, but no reset timings
specified in the datasheet. I don't know if this is truly needed,
because we can read the ID register, but it is nice when bringing up the
device. I left it in because I was using it.

[1] https://lore.kernel.org/netdev/20211004191527.1610759-16-sean.anderson@seco.com/

>> +
>> +  pre-assert-us:
>> +    default: 0
>> +    description: |
>> +      Microseconds to delay between when the reset was requested to be
>> +      asserted, and asserting the reset GPIO
>> +
>> +  post-assert-us:
>> +    default: 0
>> +    description: |
>> +      Microseconds to delay after asserting the reset GPIO and before returning
>> +      to the caller.
>> +
>> +  pre-deassert-us:
>> +    default: 0
>> +    description: |
>> +      Microseconds to delay between when the reset was requested to be
>> +      deasserted, and asserting the reset GPIO
>> +
>> +  post-deassert-us:
>> +    default: 0
>> +    description: |
>> +      Microseconds to delay after deasserting the reset GPIO and before
>> +      returning to the caller. This delay is always present, even if the done
>> +      GPIO goes high earlier.
>> +
>> +  done-timeout-us:
>> +    default: 1000
>> +    description:
>> +      Microseconds to wait for the done GPIO to assert after deasserting the
>> +      reset GPIO. If post-deassert-us is present, this property defaults to 10
>> +      times that delay. The timeout starts after waiting for the post deassert
>> +      delay.
>
> There's a reason we don't have all these timing values in DT. The timing
> requirements are defined by each device (being reset) and implied by
> their compatible strings. If we wanted a macro language for power
> sequence timings of regulators, clocks, resets, enables, etc., then we
> would have designed such a thing already.

Well, there are already things like reset-assert-us and
reset-deassert-us in [2, 3, 4] (with different names(!)). Part of what I
want to address with this device is that there are several existing
properties which specify various aspects of the above timings. I think
it would be good to standardize on these. Maybe this should be a
property which applies to the reset consumer? Analogously, we also
have assigned-clocks so that not every driver has to know what the
correct frequency/parent is (especially when they can vary among
different hardware variations).

--Sean

[2] Documentation/devicetree/bindings/net/ethernet-phy.yaml
[3] Documentation/devicetree/bindings/net/mdio.yaml
[4] Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml

>> +
>> +required:
>> +  - '#reset-cells'
>> +  - compatible
>> +  - reset-gpios
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    pcs_reset: reset-pcs {
>> +        #reset-cells = <1>;
>> +        compatible = "gpio-reset";
>> +        reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>,
>> +                      <&gpio 1 GPIO_ACTIVE_LOW>,
>> +                      <&gpio 2 GPIO_ACTIVE_LOW>,
>> +                      <&gpio 3 GPIO_ACTIVE_LOW>;
>> +        done-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>,
>> +                     <&gpio 5 GPIO_ACTIVE_HIGH>,
>> +                     <&gpio 6 GPIO_ACTIVE_HIGH>,
>> +                     <&gpio 7 GPIO_ACTIVE_HIGH>;
>> +        post-deassert-us = <100>;
>> +    };
>> --
>> 2.25.1
>>
>>
>
