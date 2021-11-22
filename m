Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350C24589A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhKVHKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:10:19 -0500
Received: from mail-vi1eur05on2106.outbound.protection.outlook.com ([40.107.21.106]:52512
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229806AbhKVHKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:10:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScekTNleOnJcESw+vyL0mCC7cDxk9sZ7MNXVHWmTXkRD/KIWN4dcyfYufpVeFjoZsCYyH8bJwKXBMiI3imEFZu4Jqn8hWnbGCKyP1w297A0EX+fU/GUiFrRXtr1UOUO/DwSBBsX0BELvaYe4CWUidu7GuRC52qYmBilfjB9PyIzg/r0u11+mN8gM0qbALSz1tm6iA1gQlg08eHM5UfJnUse65p+3+olfh1ZoepiZJ4iiKD/yW/QfDp6e/vTpUSr7mMP4zGEmnrazlCn+e+BwoU59axb9O86qWnxkU8gIarPsto0McLnAsEt9SnqNG/NvLmkipEz2I8YvlqWELtoiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXBHtlWd3iMMVVoyidzwf3rTgMpSJukEFZHADZmP72g=;
 b=TK1/+c+DvD+B2KYF7ANxViUpy/iKPkE4hkFmCQwp01NSYFlq6kr3/NzXdmqzEJGE/V3XR/LXNEv8KXHe2MzS/wLZD2e3O4YYLiYZYJ474NK85PiLoOr7G7zR2Pw80navi2IiYowtafI6YfTyeZfe/+JEtYx+vzrT27JuLT/BP+dNK7r0okIV3maWqjESCpPofbLVfZW/PMEMuyhI2FL6JKyfax/Sfhy0wQXOmMqYIcpeP6oa4LYX1vu6BY72wOMc6Uneq+ilyAbr3VmwlKyRexBLtUVTN6wBa0mBDURi+NFrBvC3CvbIPcs3Ui0a+bXiteAGPO/OMIwL+Ni4NkDuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXBHtlWd3iMMVVoyidzwf3rTgMpSJukEFZHADZmP72g=;
 b=AD32lbjdfZHk7Yn3DEL+/G836foBMxAMAcb6kvn69EDpUYvNnclNUmaDfsUKhcgdP8xpRzs3UGKOZmdOC6iCwEWUovDiNrlU5gIC6TlR5W+MVIhE4PsTZ/LXsBt2rYUQ+nHEowj52pYetejlkO3RDkyMdm7vu18DcWQ72rgPntY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM4PR07MB3092.eurprd07.prod.outlook.com (2603:10a6:205:7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.14; Mon, 22 Nov
 2021 07:07:09 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::555c:9e12:7c:f52f%7]) with mapi id 15.20.4734.017; Mon, 22 Nov 2021
 07:07:09 +0000
Message-ID: <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
Date:   Mon, 22 Nov 2021 08:06:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
In-Reply-To: <9a158e2ef6635212c1e353590e3b773b@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR0101CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::28) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
Received: from [0.0.0.0] (131.228.32.166) by MAXPR0101CA0042.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:d::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend Transport; Mon, 22 Nov 2021 07:07:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 629a0ef2-2d8b-4c36-721e-08d9ad86b31e
X-MS-TrafficTypeDiagnostic: AM4PR07MB3092:
X-Microsoft-Antispam-PRVS: <AM4PR07MB30927F36CAF0D17387AFF81F889F9@AM4PR07MB3092.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1wD31QxT4PzOD/bWStBYRBdYoNAVUhrDXYOxmKxpOUOHX71BfujmE5Ro/KdsRaqccgqeMS7+UKqSwNVyTA5cyGl9VY4rX5rSx7IIcRXzAS8VHo8ZlO9SnK8UwI8q+yA7A4JDveFVLDdeBKlczi6MR8dYht0RxmdIDnrRH2lFQaKZSeTJcmutJR/VKRAkX1DoujWhL5023pEh6MUul6C/iEg2zDoQE3HHqRK49tpNGBDc7NMDoGQlLNW1zyToTeBSYf8fJ4v5cm7m1xInvobr+2K2ol+lc5xSP1Iw754Mts1//LbYZKeJFNKzjiWp85WDWfhoZqdYJYKyT5B43YGbo1Mz7be8Sb9D8/t9VIrVzZBYWpi4dHptcob7oepsRvKhHYYsZFOd//S17WHJ0fJcxFtt1SClzLfmfDzKT7VdxD6aHt3l0/IVsRb78kzgXzguFqgDInxzTShoGOtPXcCbyqwdd3ERrM2W8+A2bI8Zb2n3VsEscUlF8fhP6PdJDwtASQ5SGNAt76sFCHFOcUvpxEvvaIJ1hXV4hvYQ+HrJgZIOO8sgJhV4iPskvmg2fqqg5UFiN2VpGM69q+yaJTs7bYVoIFpD8vPvCmCbzcYTlTQjOoXr33yUP4UhbsA9oFHB6ggko5N8ayqpFzGNcn7u+9I1gjBYze+mGFIRPsJO+5a7jB4sGl3wvMs/EZL1FrOqMVnD3/y5g6ITibF/dK9a2dKQjKClzv6/sLxemtZFXCfAeOw/4jbmu/5081QplYrfrDcruvZ0jr0Kk00qBbApCJvb5axSR6Ofp/sVAAT625172PPHP4Kf0krMRwpJ9UtIlrbY/NNajuauS8zBf7Yf/e5btsHBnIeWdbOKmqq+fqXC9w9zfxGXh1Q6LPJEwX1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(36756003)(38100700002)(316002)(8936002)(53546011)(966005)(38350700002)(508600001)(16576012)(31696002)(956004)(26005)(6666004)(52116002)(6916009)(83380400001)(2906002)(6706004)(66556008)(5660300002)(44832011)(2616005)(66476007)(66946007)(82960400001)(86362001)(186003)(4326008)(31686004)(54906003)(6486002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0lqVjNYYm14SnR4bFlTOTNwRytsNFN2dDNLYTFRdTNqRlZsNGFuMTRPMXVq?=
 =?utf-8?B?OXpLMkVCMjQ4WktRMkZpWmtCcDJaZXd2OWZ4OEhOUTZydCtXMGo0dk9tcVBE?=
 =?utf-8?B?Z21Sb1hnVHhGVWduUUVMQjhqZEZlbWczUTZCYUtJWVY0RDI4ZHBXTytsQlR1?=
 =?utf-8?B?NklONDVIbVlUeUhpNDBna3RuR0F1SEF0UUVBeFNTSEppYTlBUHJZUE81QnNY?=
 =?utf-8?B?NUkrOE5XeXlaeWFwSldsSStnV2twSnFGQ2RTU095dUt4eE4zN214TXFqRmhy?=
 =?utf-8?B?RmFZTGhIMkQ5dzRFNVBweEpQNFNCYzV6b0xXd3hHMTFuVFJnRzhieWpleGwy?=
 =?utf-8?B?bkNwSEZpdWpzaXZYSjVkaVF1S2VIN0FUZnlGS3lLRHVvNXVwUWR6bThzcCty?=
 =?utf-8?B?U3VqWDh5UnlwNHlqclpqdzZwcVlJTENUb0FOT2ExZmI1LzA3cnNUYWZHZXVN?=
 =?utf-8?B?emJVTEdKcnkxeVFxdkhDQkhYS09EcXl4WDBqbDQ0bHlFZzlFejdjdjlWNnA3?=
 =?utf-8?B?OU5QVENET0pySE1hd2JlMTh3bUxERzZCbThpT3Q5QWJ4Z2cxU3UybDlIbkcr?=
 =?utf-8?B?NEtxZjRzT0hlMldVMWlYd081SU1GVDNFQ1lmR3VkalYvVHVOakZDUng5bVk5?=
 =?utf-8?B?azdkQVJ0aHBYL3dpNzBiaXExblBucGF3S0VKOWh3LzJlWExjTTc5T0pwOWta?=
 =?utf-8?B?VXJ3L2ROdnNKTEQxUG1xaFBIbkF2aFhZckYyNkxoNHlTQnVMZHV1dG5YMXJi?=
 =?utf-8?B?b0h0RDAwUXl5TGVEZ0hqenp3a3Y2dUZyUlp3RlVoOC9YVml5TUZZYVV3RzZX?=
 =?utf-8?B?MThxR0I3Q3FCOTZGQmgxRzNNcFVLb0RYRkdYWDBCOXJ4YWNudjc5WldhejFL?=
 =?utf-8?B?ckZYUHhMK3Y5VlRxbk0zOW13cVRTWFFZZGtsL0JPdGF0eDVMZitVcWp2RHp4?=
 =?utf-8?B?bjVFdzNDcmxBTWtZVnFrNjZaTlR4dWdqcms4dDNnMW9hNE9OS0VvOHRkYmVJ?=
 =?utf-8?B?L0I2RTJLcjYveVZOVThrTS9XN0dmOXNRcThrQ0pQSFFwek5LL2xGK3JETlNt?=
 =?utf-8?B?NWVLZExrWEN3ZFBFY1FRMGNOcHJJWUovMmVlK0FQM09BeE1uL0p6RlVVajJL?=
 =?utf-8?B?anhrTzZNSjZSb3pYWXZwc1RtWTVDUjYvNmRGblNpUzlUdE5nZ3ZYNXFSazhZ?=
 =?utf-8?B?MkJJaTN0cVpKZGFiclFKcVhreFNjeFJxRTlJNkw4VGVmakIwcU5nZUVjeFlZ?=
 =?utf-8?B?VDBrQnNpdjZ3aDg2M0ozRjIrbEgySW42ZjRtTG1zOEY4Zy9FRWJ0dkdNd3hE?=
 =?utf-8?B?bzFFVWh4aU5hQUZaOGhTWjlheHBDdGxOZEkrc0IxSTI4dkRFaTdYKzFtSnNQ?=
 =?utf-8?B?RVdrWHBmenlIWjNmOUthM1FmUmh2cEdETENtVmgxMlNqR1hFenV4MDhVdWhN?=
 =?utf-8?B?WUZ6VjdGV1czZ1ZmcTRNU1g2YmpFOVpXS2U4b0w2YUtmbUx5dnR2UmU3eE1S?=
 =?utf-8?B?cU1rY2IxRG93QStGNVlXeHN6VkxTVkdpM2c1UmpUY3dpM3Vtb1pMcFR5ZURW?=
 =?utf-8?B?Q3M1WUJjV3BKY3dSbW1XWU41UnhjU2lqdmNxSTEra2djSk5NOWFqMk1UblJ5?=
 =?utf-8?B?cU43ajNqQmF0RmJ5MHc0b3JqQ1VJTTJWd1pjNHpUNDBWMjZMMi9ncU5rbzlu?=
 =?utf-8?B?ZzF6OWdYY1dvUGU0WTd5WnNJWjljeTBQalFDOXNnV09acFF1dmM0bTdtTURR?=
 =?utf-8?B?YU55WWN6ZWlwTnNhd2NNUGhpeXJ4ZVRpWExZYURSMkRVeU45WnRreW0yUHJS?=
 =?utf-8?B?TWRYSlZqMkNiakRlRUkwS25PVCtxYlpNb0JpU08yTTNTcUtVemEyVDhnMDl0?=
 =?utf-8?B?QVMyQzFSMzJWNUxBaHBQY2FxT2lvd1NNVTlPV0F3OWEzb0wxWCtpMTZSQ3dK?=
 =?utf-8?B?SkhwUjZ3cUVrV3phdkZ4Yzlad29HWVVLS0d4TG1pcHRaUE5yOHBoV0JRVkl6?=
 =?utf-8?B?ZDk4VFVIdkFpdTRkTmdaTFNmM1VLK1c4Y1NOT1d0b1J3SCtCc3RLakhOaWt2?=
 =?utf-8?B?NVRpbis3Q0tJU29iOXRiaDVtalhZRmk4bitSNmVXK3ZGZXorZEd2cEVWaFNm?=
 =?utf-8?B?Z1pkaFBsWVNXaU5zTzlrMmZva01yN1htRVF2ZGlhdFpYQytoU0xEWkYzTDNo?=
 =?utf-8?B?c29SMVBHenc4eDZqSm03Q2FPTTlKR0t0U09nTkZGMGw1bW9GRGxEbFQrWnRX?=
 =?utf-8?Q?7cKogPpvA4O4T8vO27XD7OovLw8oAZeUnZdKKnHhd0=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629a0ef2-2d8b-4c36-721e-08d9ad86b31e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 07:07:09.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vq4ZeznAeXMXYfPyE6gZuTDvHftAIUi7UtdmWu0Dnc8Y0c4W7UthVG/CteSn9B5GbZump2WqrVc0v4fbXRT7UdVkVy06SMEIipOKtR/PIzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB3092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 19/11/2021 22:19, Michael Walle wrote:
>> Ignore 6th ID byte, secure version of mt25qu256a has 0x73 as 6th byte.
> 
> What is the secure version? What is the difference? Do you have some
> links to datasheets for both?

For instance:
https://www.micron.com/products/nor-flash/serial-nor-flash/part-catalog/mt25qu256aba1ew7-0sit
https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf?rev=594079234c1b496496b062c21ce162d6

https://www.micron.com/products/nor-flash/serial-nor-flash/part-catalog/mt25qu256aba8e12-1sit
https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25q/die-rev-a/mt25q_qljs_u_256_aba_0.pdf?rev=594079234c1b496496b062c21ce162d6

But the differences are in "MT25Q Security Addendum":
"The additional protection features available on the secure MT25Q device include a
lock status register bit, top/bottom block address protection lock, volatile
configuration lock register at power up, protection management register lock,
and a nonvolatile configuration lock register."
This is only available under NDA from Micron.

However as long as one doesn't use these security features, it appears compatible with
non-secure version. That's why just ignoring the non-standard configuration allows
to support it.
 
> Also please provide the SFDP data for this flash, see [1].

sfdp:
53464450060101ff00060110300000ff84000102800000ffffffffffffff
ffffffffffffffffffffffffffffffffffffe520fbffffffff0f29eb276b
273b27bbffffffffffff27bbffff29eb0c2010d80f520000244a99008b8e
03d4ac0127387a757a75fbbdd55c4a0f82ff81bd3d36ffffffffffffffff
ffffffffffffffffffe7ffff21dcffff

md5sum:
5ea738216f68c9f98987bb3725699a32

jedec_id:
20bb191044

partname:
mt25qu256a

manufacturer:
st

(But last 3 do not make sense to me, as they come from the table I modify,
not from the chip itself). Further, I don't have 512Mbit chip to provide
SFDP for it.

> [1] https://lore.kernel.org/linux-mtd/7038f037de3e224016d269324517400d@walle.cc/
> 
>>
>> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>> ---
>>  drivers/mtd/spi-nor/micron-st.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
>> index f3d19b7..509a732 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
>> @@ -155,9 +155,9 @@ static const struct flash_info st_parts[] = {
>>      { "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
>>                    USE_FSR | SPI_NOR_DUAL_READ |
>>                    SPI_NOR_QUAD_READ) },
>> -    { "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
>> -                   SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>> -                   SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> +    { "mt25qu256a",  INFO(0x20bb19, 0x1044, 64 * 1024,  512,
>> +                  SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>> +                  SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>      { "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512,
>>                    SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
>>      { "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024,
>> @@ -167,9 +167,9 @@ static const struct flash_info st_parts[] = {
>>                    SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>>                    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
>>                    SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
>> -    { "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024,
>> -                   SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>> -                   SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>> +    { "mt25qu512a",  INFO(0x20bb20, 0x1044, 64 * 1024, 1024,
>> +                  SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
>> +                  SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>>      { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024,
>>                    SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>>                    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |

-- 
Best regards,
Alexander Sverdlin.
