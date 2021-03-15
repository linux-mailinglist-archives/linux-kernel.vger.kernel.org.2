Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA8D33AEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 10:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhCOJ1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 05:27:05 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:59921 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhCOJ0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:26:33 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BCAEE2223A;
        Mon, 15 Mar 2021 10:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615800391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHc3wCOGau6Us9gagovvjPm5hO+ZMD2/vqjQHEsoURA=;
        b=lzOMpGLMpCU96GyBAVFfW+dbM+m1N/2YjH1i2xL57Qs6BWwEwNP2Ec74f6MO+hq4sfUHpV
        okDkgRQZGkVgs1ueyTnb/IpwlyL5mNHq8U4hhm3iYWpvL7D9hISizsW0WhVFKwd2f+RVyI
        GpiEtGhSXT5uDwtq4pkt4iMF7LdeuXs=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 10:26:31 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: winbond: add OTP support to
 w25q32fw/jw
In-Reply-To: <8e7147bb-a9ba-2b4b-abea-69e72ddd82f4@microchip.com>
References: <20210306000535.9890-1-michael@walle.cc>
 <20210306000535.9890-4-michael@walle.cc>
 <8e7147bb-a9ba-2b4b-abea-69e72ddd82f4@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <2442f8a2e9ed1333fb45e90176200c11@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-15 09:26, schrieb Tudor.Ambarus@microchip.com:
> On 3/6/21 2:05 AM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> With all the helper functions in place, add OTP support for the 
>> Winbond
>> W25Q32JW and W25Q32FW.
>> 
>> Both were tested on a LS1028A SoC with a NXP FSPI controller.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/winbond.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/winbond.c 
>> b/drivers/mtd/spi-nor/winbond.c
>> index e5dfa786f190..9a3f8ff007fd 100644
>> --- a/drivers/mtd/spi-nor/winbond.c
>> +++ b/drivers/mtd/spi-nor/winbond.c
>> @@ -55,14 +55,18 @@ static const struct flash_info winbond_parts[] = {
>>         { "w25q32", INFO(0xef4016, 0, 64 * 1024,  64, SECT_4K) },
>>         { "w25q32dw", INFO(0xef6016, 0, 64 * 1024,  64,
>>                            SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ |
>> -                          SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>> +                          SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>> +                          OTP_INFO(256, 3, 0x1000, 0x1000)
>> +       },
>> +
>>         { "w25q32jv", INFO(0xef7016, 0, 64 * 1024,  64,
>>                            SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ |
>>                            SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>>         },
>>         { "w25q32jwm", INFO(0xef8016, 0, 64 * 1024,  64,
>>                             SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ |
>> -                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>> +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>> +                           OTP_INFO(256, 3, 0x1000, 0x1000) },
>>         { "w25q64jwm", INFO(0xef8017, 0, 64 * 1024, 128,
>>                             SECT_4K | SPI_NOR_DUAL_READ | 
>> SPI_NOR_QUAD_READ |
>>                             SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>> @@ -131,9 +135,18 @@ static int winbond_set_4byte_addr_mode(struct 
>> spi_nor *nor, bool enable)
>>         return spi_nor_write_disable(nor);
>>  }
>> 
>> +static const struct spi_nor_otp_ops winbond_otp_ops = {
>> +       .read = spi_nor_otp_read_secr,
>> +       .write = spi_nor_otp_write_secr,
>> +       .lock = spi_nor_otp_lock_sr2,
>> +       .is_locked = spi_nor_otp_is_locked_sr2,
>> +};
> 
> Should we have this in otp.c? It can be shared with gigadevice as well
> as far as I understood.

It should work in principle for both vendors, but I couldn't test it. So
for now, I've kept it private to winbond.c. If there will be OTP support
for other flashes with the same ops, it should be moved.

-michael
