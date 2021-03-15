Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EA033ADD4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbhCOIob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:44:31 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:37549 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCOIoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:44:01 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2C26D2223A;
        Mon, 15 Mar 2021 09:43:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1615797839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VlBMa73oUNhgqahkkJ/v5GrlplUITEafwXYLlGTsDi8=;
        b=OV9/C/NVygge90wUmoSeYTCQkkDhqkG4EL0mSeoHU4tEF2ulHRZ50O94CBVJH98/7vY9Z7
        rZHtxpWfJhVMX25lgikgmknxNoH+t4MDqS8rHsTW6lbHvF4FYQhsg1S2tGswzuEJCXY6ZU
        7zE9vRHo9P1YEtMFQGMusfIJlF+jkVs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 15 Mar 2021 09:43:58 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     vigneshr@ti.com, p.yadav@ti.com, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mtd: spi-nor: Move Software Write Protection logic
 out of the core
In-Reply-To: <65691b2a-134d-b1f2-617e-5ef09df9a742@microchip.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-5-tudor.ambarus@microchip.com>
 <7fb8af561eda06444ee0e0c592147af7@walle.cc>
 <65691b2a-134d-b1f2-617e-5ef09df9a742@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <b3c6bf8a225711f678eeee2d72ac603f@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-15 07:09, schrieb Tudor.Ambarus@microchip.com:
> On 3/6/21 1:19 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> Am 2021-03-06 10:50, schrieb Tudor Ambarus:
>>> It makes the core file a bit smaller and provides better separation
>>> between the Software Write Protection features and the core logic.
>>> All the next generic software write protection features (e.g.
>>> Individual
>>> Block Protection) will reside in swp.c.
>>> 
>>> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>> ---
>> 
>> [..]
>> 
>>> @@ -3554,6 +3152,9 @@ int spi_nor_scan(struct spi_nor *nor, const 
>>> char
>>> *name,
>>>       if (ret)
>>>               return ret;
>>> 
>>> +     if (nor->params->locking_ops)
>> 
>> Should this be in spi_nor_register_locking_ops(), too? I.e.
>> 
>> void spi_nor_register_locking_ops() {
>>     if (!nor->params->locking_ops)
>>         return;
>> ..
>> }
> 
> Yes, the checking should be done inside spi_nor_register_locking_ops,
> will move it.
> 
> Btw, what do you find a better name, spi_nor_register_locking_ops or
> spi_nor_init_locking_ops? Applies to OTP as well.

probably register_locking_ops(), as long as the function just does
that.

For OTP, I want to provide nvmem support, too. Thus it will not
only register the mtd ops and thus spi_nor_otp_init() will be
better for my case.

-michael
