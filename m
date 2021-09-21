Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D23412ED7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhIUGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:54:23 -0400
Received: from mail-db8eur05on2130.outbound.protection.outlook.com ([40.107.20.130]:50273
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229755AbhIUGxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:53:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GM7TH5yEjYuxw2/7yFmI5NYtIczzfdYKpDha6Moi4aw6h6f6pn7ATMMRQpyFnYnoWIshPsgDKGqbjmWHtCTT4vw49xH7Ee4utL0LwImFCJZD4bevMD5NP5i5smAE1kpc4eE5jWt6aynLzk3efyaNwgazX6rLSQ9Kq+duc0Ul2EZedhxVfTBqngPwiHVjhUJZHS8AjCPrU7mVPONKpczofQ5lzGk2hlNhcld1eDRpVJ/BgtOYZu3oe0DseZdTDcJZGKpCvj0wQCGKZxSItm9ztLXClrJpvhTqCqI+mCBbefNy7UjpbXAgkl8XqK11dLowYd/OC3gRyyWo7w0wsyArdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=AXTbUE59RHa3qDahE1753Tp5Cy657XGfd6aH/riPjTs=;
 b=PJwYicR3AVPUASr8+uRVxjIy8f5PM68tl+a3RxFTM3O1GhMCAnNRazvVD6XmV24sUt3rfZX+sFiAkQnbh23vUckyEa+yqpBTWC2ei0OVEx2smey45pOVdqBbqlJXlpQyj3adbdRa7wwosh8JuwqTIe8brMcSFqbblAX+dSlEkqSxZ5Z2s75RWNM5IGYeVnf04HWizm17d0+5wdvLEiZbTvcHuSAVYwgYKNcqW3n1n6tbSL12oppx1pxj6TFXKEnnKXUhLLQRnmOkD7mJfs+A1zUtWMsCXzLhN1r3sQhXUS6lciZ5hLwsipCOiS11IszHVSr4jSmAwzU+HrqpEXYBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXTbUE59RHa3qDahE1753Tp5Cy657XGfd6aH/riPjTs=;
 b=gvoi3TXWHd8bASZY9wkriYdpBLRCiKXMBSnwukd13iDFoLiGdpzajigyIvb2h6Swj+s+DfbX1CyI6agCTvoE2LFM51RTqIPTYXUntusaIj8w6rE/L482bDcrzxZmJMfWM4Fi2Zow9a3dO4NCtclVCyseaOT7APWVqXq+DXp96pE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6890.eurprd02.prod.outlook.com (2603:10a6:10:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 06:52:25 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 06:52:25 +0000
Subject: Re: [PATCH] ASoC: pcm512x: Mend accesses to the I2S_1 and I2S_2
 registers
To:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kirill Marinushkin <kmarinushkin@birdec.com>,
        Mark Brown <broonie@kernel.org>
References: <2d221984-7a2e-7006-0f8a-ffb5f64ee885@axentia.se>
 <ae4b25f1-2b2c-d937-e23d-0f7d23bdf0c4@gmail.com>
 <815cbba4-60d6-8d97-c483-146c2f7c3912@axentia.se>
 <7537b141-0ef1-fb44-7e02-27b4dd1e772b@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d9850534-df41-a6b3-48e2-34823f5866e9@axentia.se>
Date:   Tue, 21 Sep 2021 08:52:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <7537b141-0ef1-fb44-7e02-27b4dd1e772b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR04CA0055.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::32) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (185.178.140.238) by AM6PR04CA0055.eurprd04.prod.outlook.com (2603:10a6:20b:f0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend Transport; Tue, 21 Sep 2021 06:52:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca4e3a96-b855-4f07-7437-08d97ccc5e76
X-MS-TrafficTypeDiagnostic: DB9PR02MB6890:
X-Microsoft-Antispam-PRVS: <DB9PR02MB6890C5057777F72AEEC44A59BCA19@DB9PR02MB6890.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bmb/5XtWt9iX7J3JUeNSuWgCobI/6yY85BjB/2jLrQ29Hl8OVhuPVdQZNHyWN/Uw1N7ybzWDZ1wl/RNkJxbdwc++t97HPZYLgDzgONcxYXLp6w0U1YGZaKLNItTkxqfPMkrXi2+VAwNmSbMvm4X7dfKQX7ruGG1BMtkidCqt74kKATKyQ6xqQNCq3/ebc9r62LY93gyM1L0SZXjiQHzpEPHCWKlaRIgpMNfSGHGooksw2ZBy7zlvtPVtPyWGuC+zkms6Gu4vig4y4/PO8a0IVIANXNz7neymVjzIBYmS34scWqEsnFhrfl2SI8/Ttab7wquzOWs5tuqUTpVk6W6byO2MKNEe9OkwPhrRKU9ijtGrjdpgrtppPbBlpaafNaPZV2FBIaHbwam3795HoJLptOoL84dUaDYKY8bWimCE5LUMsceSRxtZtdihtXS1YHGtfarQB4umSaam4nAs0+NXoo+HHjMcC/upJlbTVgRauV+PlQzFGitLBnas1xV1oIzPr1wQobEzHtCpdBBrRKXV+qc5kTNtloRKRLrNuEP4AxJ6PuYF7AOcGJJM/tbZzOVxapREDT+hXwLOTAKoRVwWRz+LCvGHhlM1VkuvxP2Uk1TFdHlJm1aKA9CVmt1Tr2fsyDgMpB4cAh0bhMcfNjVhCQ8+XMK9ngdnC7qxMv+vgCOyrCBsYJ5qOKjMd/UdK64iifvSbl2nGkMbLwRlHq880YKv8VQQSjFN3VIJ4N4M3nM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39830400003)(346002)(136003)(86362001)(66946007)(66556008)(66476007)(36916002)(110136005)(8676002)(6486002)(4326008)(83380400001)(31696002)(186003)(26005)(38100700002)(66574015)(53546011)(54906003)(36756003)(2616005)(956004)(2906002)(31686004)(8936002)(5660300002)(508600001)(16576012)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3IyZGIyZXJIZGNiSDBzY1ZkQVVrSjdDY0pyMnJ0VnlRTFBFZXBYbURFbExx?=
 =?utf-8?B?RVVHSncxWVdSeG9hVlRka0dMcmI0U3NjdHZ0ZGJvYkxxb20yaDY2dWtGUk9p?=
 =?utf-8?B?cmpvYm1HSzhzQ3RLYkxWb1hOM0EwdEloUXFVcEpSdk0ycDh0OFlQczVKV1oz?=
 =?utf-8?B?Vk9xbHlJM1BpQXJxeVNtaWdHWXFEdEpNaHJrZC95a1NKY1RLSTBuVHRpRXNo?=
 =?utf-8?B?MUYvMXova0ZjK0h4Z1JmaENNR2d2a05nWmNhS0JNTGdoZE00WGVpa0I2UEt6?=
 =?utf-8?B?M2JUZnNHa0s2Z0o4OHB1K1ZqR3Y1Vlp2Rk9LTnhiQzc1NkJhdjdVei9EeTdW?=
 =?utf-8?B?YnQ0SmFEVTVwNjdWbU81elBuQWNxa0lWNW5iVVU5U09FWkhsZ1I4R3B1b0Rq?=
 =?utf-8?B?ODFpandROVFON05VUzRHb0kxSDZqUE9TdmJyL0NRUWhIbysxWDE3a3VZU1I0?=
 =?utf-8?B?anZNalVjWUcrU0tQTWRsU2tIQ3Mzb3BhcVdkTEpyWUhmWTdMMFpQQWtFd2FZ?=
 =?utf-8?B?VkVlRkZ5WExteUFxS21ITHBrRU9lZEZOSVZiT2NxRFFYSEhMZHdpV1UyUEdV?=
 =?utf-8?B?NmdyUEtDbFZRTy8wbEx1Y0tmdWdBRGtiZEdrcVNJV25CSVAyL0lrVmpPV25K?=
 =?utf-8?B?TjZRaFVTZHpQY0JHNDlWUVNoUGRQb3A0TmJGUHZjK1BMYlk4UEJVYzh5UFZl?=
 =?utf-8?B?ZU5reDdSZkhpVFUzVnQ3NW53UzAxSktJc2l3WElwSFN4Y3MzbXorS1FVZFRn?=
 =?utf-8?B?VDVYMlk3R1hCUWRWVVJFY1F4d1htQ2Z4YldYOFluQjBxK1NYTFp0VDFGQTgv?=
 =?utf-8?B?bVVGc0lYbDI1Vkp2SnhIRmJaaGhQdUtrL0pHSjVBdk1xMWM1NGREUytySGJZ?=
 =?utf-8?B?VVY5RGlKQTQ5cHBHN3NHTHhad1BDY0d5OGIwT3RyNlhpUmZBZFJwV25aTFNk?=
 =?utf-8?B?dUVCNDRSNDVxSGM4alZPck1WWmh5NlZna0lqRFFHaEt0ZHJJZWdBemlid0hM?=
 =?utf-8?B?c2plVWFWd2MxSUl6SFBsSldhMEpEOXpUMitvTy9pYnczajhKZDVDQnJXanNn?=
 =?utf-8?B?QjhRVGlnOEhhQWF4RGJjL0p2NU95Si9RS0VWNVhYb2dNNWZYSXFkTEdhWnRB?=
 =?utf-8?B?L1pHby9pVmdjMTZXRVdvRG84UjFJUUNJRllsK05LM2R5NHRWMU1GMFRlUmpC?=
 =?utf-8?B?TnRwckpZdW10bGkrbHVKWDVoV2phWVBsVHBvR2pTckpUa3BvTWRqaHBON1lU?=
 =?utf-8?B?NEdwQXV3MzN4dTdvRWZ4Q2o0WmJXYnVGLzNTcVV2ZFFrNzZOYXNJUjJzQ3dr?=
 =?utf-8?B?d2Nwc3JtWDhHcVg1U3N0bmF6dzFJYnp2ck9zQmpER1VuQ1JCcEhjVi9VMm1i?=
 =?utf-8?B?Qk1JQUE4T01DWXNoTW9nc0M3L0p4eWJhL3dmOW5zN2dwRS9WVDI0SUdlTXdS?=
 =?utf-8?B?bFVpRFA1K3VIeXY2MEJmbkgzdWRmUVNJQ3dHOHVjQjBXVndkempUZzdrb0sv?=
 =?utf-8?B?THM5YVk0YnpvS0xybmEydCtxS2hyV2Y1RW5Yc2pmdzV3M3dWVnJqbTlmMnVp?=
 =?utf-8?B?b05hUStKaFRzYkJCVmJBc0N6K2RWMlkreFV4UWd2M3YvbDNMK1R5bkMwNDNC?=
 =?utf-8?B?MVZRMVRJbnR4QlFRc2JVZjZYNVJOVEs3L3h4MXRHVnUwUGI1cWJZbXBBWThn?=
 =?utf-8?B?SDRQMkNZOWlaVE0rQ1VqRGtqT1orR3YvNEJNbU4wMXNjWXJZN0MwcFBaNGUy?=
 =?utf-8?Q?SVk7wWDftubs4+t41LwQHt73u/fHnYyXbgzwAG7?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4e3a96-b855-4f07-7437-08d97ccc5e76
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 06:52:25.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZNu4tFMI1u+Hj2pcWlNMO3U9m2KAzWz9M+cKhyClPQuj4U7ycVVp4NBy0tdwcsz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6890
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-21 06:20, Péter Ujfalusi wrote:
> Hi Peter.
> 
> On 20/09/2021 22:37, Peter Rosin wrote:
> 
>> Nope, MODE1/2 are wired for I2C -> FMT is just the last I2C address
>> bit. So, nothing to do with I2S. And I can't see how that would explain
>> the same problem with the I2S_2 register?
> 
> true, but worth the question ;)

Right :-)

>>>> This fix is not 100% correct. The datasheet of at least the pcm5142
>>>> states that four bits (0xcc) in the I2S_1 register are "RSV"
>>>> ("Reserved. Do not access.") and no hint is given as to what theHi
>>>> initial values are supposed to be. So, specifying defaults for
>>>> these bits is wrong. But perhaps better than a broken driver?
>>>
>>> The default of 0x02 (AFMT = 00b - I2S, ALEN = 10b - 24bits) is correct
>>> for I2S_1 and the 0 is the default of I2S_2.
>>>
>>> The failure happens when updating the AFMT (bit4-5) and when regmap is
>>> doing a i2c read since the default is not specified.
>>>
>>> It would be interesting to see what it is reading... Out of interest:
>>> can you mar the I2S_1 and I2S_2 as volatile and read / print the value
>>> just before the afmt and alen update?
>>
>> My first attempt was to mark the register volatile, and then read and
>> compare if the update was needed at all. But marking volatile wasn't
>> enough.
> 
> If the value is not provided in the defaults then the first read is reading out to the chip anyways.

Yeah, but why is accessing I2S_1/2 returning -EBUSY when accessing e.g.
the PCM512x_MASTER_MODE register is not?

>> I also tried to set both a default and mark as volatile,
> 
> Volatile always skips the cache, default would be ignored.
> 
>> but it seems every read fails with -16 (EBUSY). I don't get why, to me
>> it almost feels like a regmap issue of some sort (probably the regmap
>> config is bad in some way), but I'm not fluent in regmap...
> 
> Or most likely the chip is not powered at pcm512x_set_fmt() time?

The chip is always powered, at least externally. Are you hinting that
relevant parts of the chip may be powered down internally when
pcm512x_set_fmt() executes and that this is the -EBUSY cause? Why does
that only happen to me in that case?

>> So, since I can't read, I can't get to the initial values of the four
>> reserved bits. So, I winged them as zero.
> 
> The value of the reserved bits are don't care.
> 
> Can you try the attached patch w/o without the defaults for i2s_1/2?
> Not even compile tested...

[added a couple of underscores]

I get this early during boot/probe
[    1.506291] pcm512x 0-004c: pcm512x_set_fmt: failed to read I2S_1: -16
[    1.512905] pcm512x 0-004c: pcm512x_set_fmt: failed to read PLL_EN: -16
[    1.519517] pcm512x 0-004c: Failed to set data format: -16
[    1.525045] pcm512x 0-004c: Failed to set data offset: -16

and then this later, triggered from userspace when an app opens
the device
[   14.620344] pcm512x 0-004c: pcm512x_hw_params: I2S_1: 0x2

So, reading *can* work.

Cheers,
Peter
