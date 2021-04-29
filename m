Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E636F259
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbhD2VzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhD2Vy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:54:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4AFC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 14:54:11 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0095422239;
        Thu, 29 Apr 2021 23:54:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619733249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oXpSnLEeC6oBxENRxivNH8jCYJ0/yDWPA3cKpHsHYfg=;
        b=EmJMl/fsFTxs///d3O5Gi3qqqp/AHduNDC7pyIXWbA58TDTERUMHTnkAZm0/Yjx0Uxxsx/
        UMJTjhYdIqhTEfADtYye0AI7fvEXeZnqJwGWzWcsApaR0KfjUv+m9UiIt389RbPPeHfyXg
        DQ04jGPd9dMfewO7FgWvLPuenoz3RTY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Apr 2021 23:54:08 +0200
From:   Michael Walle <michael@walle.cc>
To:     Alexander Williams <awill@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: add initial sysfs support
In-Reply-To: <CACqsJN9283nSmgdDTz+LhfiQwfi4ZmrSJEP+0JJ24-KZ7isMEA@mail.gmail.com>
References: <20210429155713.28808-1-michael@walle.cc>
 <20210429155713.28808-3-michael@walle.cc>
 <CACqsJN9283nSmgdDTz+LhfiQwfi4ZmrSJEP+0JJ24-KZ7isMEA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ceae5479c5146e09a945a89da7d99b10@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-04-29 23:34, schrieb Alexander Williams:
> On Thu, Apr 29, 2021 at 8:57 AM Michael Walle <michael@walle.cc> wrote:
>> 
>> Add support to show the manufacturer, the partname and JEDEC 
>> identifier
>> as well as to dump the SFDP table. Not all flashes list their SFDP 
>> table
>> contents in their datasheet. So having that is useful. It might also 
>> be
>> helpful in bug reports from users.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>> Pratyush, Heiko, I've dropped your Acked and Tested-by because there
>> were some changes.
>> 
>>  .../ABI/testing/sysfs-bus-spi-devices-spi-nor | 31 +++++++
>>  drivers/mtd/spi-nor/Makefile                  |  2 +-
>>  drivers/mtd/spi-nor/core.c                    |  1 +
>>  drivers/mtd/spi-nor/core.h                    |  2 +
>>  drivers/mtd/spi-nor/sysfs.c                   | 92 
>> +++++++++++++++++++
>>  5 files changed, 127 insertions(+), 1 deletion(-)
>>  create mode 100644 
>> Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
>>  create mode 100644 drivers/mtd/spi-nor/sysfs.c
>> 
>> diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor 
>> b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
>> new file mode 100644
>> index 000000000000..4c88307759e2
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
>> @@ -0,0 +1,31 @@
>> +What:          /sys/bus/spi/devices/.../jedec_id
> 
> Since mtd/spi-nor doesn't own this device (belongs to the spi 
> subsystem), should
> we put its attributes under a named subdirectory? Perhaps something 
> like
> /sys/bus/spi/devices/.../spi_nor/jedec_id ?
> 
> I'm just thinking about avoiding any potential for namespace clashes.

Good idea! Will change that in the next version.

-michael
