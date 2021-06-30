Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E393B8846
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhF3SYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:24:03 -0400
Received: from atlmailgw2.ami.com ([63.147.10.42]:57444 "EHLO
        atlmailgw2.ami.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbhF3SX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:23:57 -0400
X-AuditID: ac10606f-903ff70000006d35-4f-60dcb627a325
Received: from atlms1.us.megatrends.com (atlms1.us.megatrends.com [172.16.96.144])
        (using TLS with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by atlmailgw2.ami.com (Symantec Messaging Gateway) with SMTP id B9.0C.27957.726BCD06; Wed, 30 Jun 2021 14:21:27 -0400 (EDT)
Received: from ami-us-wk.us.megatrends.com (172.16.98.207) by
 atlms1.us.megatrends.com (172.16.96.144) with Microsoft SMTP Server (TLS) id
 14.3.498.0; Wed, 30 Jun 2021 14:21:27 -0400
From:   Hongwei Zhang <hongweiz@ami.com>
To:     Michael Walle <michael@walle.cc>
CC:     Hongwei Zhang <hongweiz@ami.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] mtd: spi-nor: Add some M45PEx ids
Date:   Wed, 30 Jun 2021 14:20:59 -0400
Message-ID: <20210630182059.29699-1-hongweiz@ami.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210629150846.21547-2-hongweiz@ami.com>
References: <20210629150846.21547-1-hongweiz@ami.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.98.207]
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWyRiBhgq76tjsJBlf3Kltc3jWHzWJ30zJ2
        i7enN7Bb3H3+g93i4xIHB1aPzUvqPe78WMrocfzGdiaPz5vkPA7sbWELYI3isklJzcksSy3S
        t0vgyri5ZDFzwWb+ioaDJ1kbGF9zdzFyckgImEhc6lnB2MXIxSEksItJYubrOyxQDqPEvUlP
        GUGq2ATUJPZunsMEYosIqEg8/nwBrINZYDujRGfDNzaQhLCApcTEjS9ZQWwWAVWJhYcamUFs
        XgFTiSkv17NArJOXWL3hAFicU8BMYm77A7BeIaCaZ2t62CDqBSVOznwCVs8sICFx8MULZoga
        WYlbhx4zQcxRlHjw6zvrBEaBWUhaZiFpWcDItIpRKLEkJzcxMye93EgvMTdTLzk/dxMjJGTz
        dzB+/Gh+iJGJg/EQowQHs5IIb9TO2wlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeVe5H40XEkhP
        LEnNTk0tSC2CyTJxcEo1MBbm+QtzrBf4759X0uwR0TEv56Zv199JR3Zms05dp1l7ddMXhryN
        HrpqPh2CsZEtWqufKs3IV+jTqzXm1Kud+PnhZDcjNuP731Omvp3su+9v/PaYjAd9Wi9vLf1l
        VZ7oz3FUZT3bLP9tfYVxMUsme3i+5eDeUtzKqzxl9mwH3o5KhSXyCptslFiKMxINtZiLihMB
        6S9YMkcCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

>Subject:	[EXTERNAL] Re: [PATCH v1 1/1] mtd: spi-nor: Add some M45PEx ids
>
>Hi Hongwei,
>
>Am 2021-06-29 17:08, schrieb Hongwei Zhang:
>> Add some Micron M45PEx flash memeories into the IDs table.
>
>Did you test all these flashes?
>
No, the patch was added in porting drivers related to AST2600 EVB.

>> Fixes: dd1e9367157f900616f (ARM: dts: everest: Add phase corrections
>> for
>> eMMC)
>
>Bogus Fixes tag. First, I cannot find this commit id, which tree is
>that? Secondly, adding new flash ids don't fix anything, esp not
>something related to eMMC.
>
Sorry for the confusion, I thought Fixes tag could be also used for referencing
the revision base for the patch to aplly on.
I used dev-5.10 branch from https://github.com/openbmc/linux.git , should I
use a different repository?

Thanks,
--Hongwei
>>
>> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>
>> ---
>>  drivers/mtd/spi-nor/micron-st.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/micron-st.c
>> b/drivers/mtd/spi-nor/micron-st.c
>> index ef3695080710..379b14e339ff 100644
>> --- a/drivers/mtd/spi-nor/micron-st.c
>> +++ b/drivers/mtd/spi-nor/micron-st.c
>> @@ -95,8 +95,12 @@ static const struct flash_info st_parts[] = {
>>       { "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64, 0) },
>>
>>       { "m45pe10", INFO(0x204011,  0, 64 * 1024,    2, 0) },
>> +     { "m45pe20", INFO(0x204012,  0, 64 * 1024,    4, 0) },
>> +     { "m45pe40", INFO(0x204013,  0, 64 * 1024,    8, 0) },
>>       { "m45pe80", INFO(0x204014,  0, 64 * 1024,   16, 0) },
>>       { "m45pe16", INFO(0x204015,  0, 64 * 1024,   32, 0) },
>> +     { "m45pe32", INFO(0x204016,  0, 64 * 1024,   64, 0) },
>> +     { "m45pe64", INFO(0x204017,  0, 64 * 1024,  128, 0) },
>>
>>       { "m25pe20", INFO(0x208012,  0, 64 * 1024,  4,       0) },
>>       { "m25pe80", INFO(0x208014,  0, 64 * 1024, 16,       0) },
>
>--
>-michael
>
