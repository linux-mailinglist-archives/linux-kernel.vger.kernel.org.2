Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7663B33F53B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 17:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhCQQPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 12:15:02 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56182 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhCQQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 12:14:54 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12HGEWKE125773;
        Wed, 17 Mar 2021 11:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615997672;
        bh=meEMMQGzpHgES9UZrjykVhesIW4rSxb1evBkwPhp5OI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O89t/LkZDmcjen+fsJTNlb/V0ocvKnhqkHcLBtMrP4t+kuuV7lvHkV1wiA4XFb4D1
         YDz82AYGJ6TyrU4k2OcD/i+CdNVIiE169hgH2ueVgGTbik6D1gwq1kISFm+fm0M5qF
         3ZmKlC1zeexjDS6ySdpl0Y+acMJMd/UruYr2nqbk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12HGEWPG004242
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 17 Mar 2021 11:14:32 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 17
 Mar 2021 11:14:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 17 Mar 2021 11:14:31 -0500
Received: from [10.250.234.120] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12HGERHp013957;
        Wed, 17 Mar 2021 11:14:29 -0500
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
To:     Pratyush Yadav <p.yadav@ti.com>, <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <963232a4-9100-ebca-927c-7f5a1e947fbe@ti.com>
 <9889bae0-8eba-7cbc-d9bb-04e038bd28c8@microchip.com>
 <6016b725-a779-1d2c-9884-099c58f53557@ti.com>
 <45d00a12-cb79-774e-f8e8-d65602629a90@microchip.com>
 <20210317090504.ra3vm76xexhaqg2l@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9fd4957d-778c-966e-2756-13418d199bf6@ti.com>
Date:   Wed, 17 Mar 2021 21:44:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210317090504.ra3vm76xexhaqg2l@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/21 2:35 PM, Pratyush Yadav wrote:
> On 17/03/21 06:09AM, Tudor.Ambarus@microchip.com wrote:
>> On 3/15/21 8:23 AM, Vignesh Raghavendra wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> On 3/9/21 12:58 PM, Tudor.Ambarus@microchip.com wrote:
>>>> On 3/8/21 7:28 PM, Vignesh Raghavendra wrote:
>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>>>
>>>>> On 3/6/21 3:20 PM, Tudor Ambarus wrote:
>>>>>> It makes the core file a bit smaller and provides better separation
>>>>>> between the Software Write Protection features and the core logic.
>>>>>> All the next generic software write protection features (e.g. Individual
>>>>>> Block Protection) will reside in swp.c.
>>>>>>
>>>>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>>>>> ---
>>>>>>  drivers/mtd/spi-nor/Makefile |   2 +-
>>>>>>  drivers/mtd/spi-nor/core.c   | 407 +---------------------------------
>>>>>>  drivers/mtd/spi-nor/core.h   |   4 +
>>>>>>  drivers/mtd/spi-nor/swp.c    | 419 +++++++++++++++++++++++++++++++++++
>>>>>
>>>>> Hmmm, name swp.c does not seem intuitive to me. How about expanding it a
>>>>> bit:
>>>>>
>>>>> soft-wr-protect.c or software-write-protect.c ?
>>
>> Having in mind that we have the SWP configs, I think I prefer swp.c.
>> But let's see what majority thinks, we'll do as majority prefers.
>> Michael, Pratyush?
> 
> I don't have much of an opinion on this tbh. But I usually prefer short 
> names so I'd go with swp.c here. Maybe also add a comment at the top of 
> the file mentioning the full name "Software Write Protection logic" or 
> something similar for clarification.
> 

I don't have hard objection to swp.c. As Pratyush suggested, a comment
at top of the file indicating the purpose would be good to have.
