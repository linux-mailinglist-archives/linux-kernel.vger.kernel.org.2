Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9C3973BD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhFANEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFANEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:04:08 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF98C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 06:02:27 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D339A22236;
        Tue,  1 Jun 2021 15:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622552545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbfG+7l9lazycX8CAfFKL8/FChgR2UYhI1E57Fm9gNI=;
        b=mwZ9BlhQhiOFFA1uyVKEOxEDCGuYtVlNwmx15I48E0G4/pLXIVlJlhe2xokz2ng+zgA45R
        WRJOrr/ztnRu18YKD6o/GaulztaHvYscwrP0xsz37z+a2VQ+W0tGAUfTnMbvaZ2V5mc8Ea
        t6hQxfqJ5AhbzhaA/URWcDI3Ty7gdzM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Jun 2021 15:02:24 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is
 read-only
In-Reply-To: <bf3a9cf9-fc72-8ea4-de0a-1f0e123cb644@microchip.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-4-michael@walle.cc>
 <bf3a9cf9-fc72-8ea4-de0a-1f0e123cb644@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <e9a697de15dcf4f526a7f2da95b67b73@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-05-31 10:52, schrieb Tudor.Ambarus@microchip.com:
> On 5/21/21 10:40 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> SPI NOR flashes will just ignore program commands if the OTP region is
>> locked. Thus, a user might not notice that the intended write didn't 
>> end
>> up in the flash. Return -EROFS to the user in this case. From what I 
>> can
>> tell, chips/cfi_cmdset_0001.c also return this error code.
>> 
>> One could optimize spi_nor_mtd_otp_range_is_locked() to read the 
>> status
>> register only once and not for every OTP region, but for that we would
>> need some more invasive changes. Given that this is
>> one-time-programmable memory and the normal access mode is reading, we
>> just live with the small overhead.
> 
> :)
> 
> Shouldn't we change
> struct spi_nor_otp_ops {
> 	...
>         int (*lock)(struct spi_nor *nor, unsigned int region);
>         int (*is_locked)(struct spi_nor *nor, unsigned int region);
> };
> 
> to:
> struct spi_nor_otp_ops {
> 	...
>         int (*lock)(struct spi_nor *nor, loff_t addr, size_t len);
> 
>         int (*is_locked)(struct spi_nor *nor, loff_t addr, size_t len);
> };
> 
> instead?

I had that, but then
  (1) it doesn't fit the hardware (the one's I know of) and the function
      itself would need to convert to the given range
  (2) each lock()/is_locked() would need to implement the "if at least
      one region is locked everything is locked", which might lead to
      different implementations.
  (3) in what address space is addr and len? I'd presume the one of the
      device (so is orthogonal to read()/write()). So if you get lets
      say addr=0x1000 len=512, you'd need to convert that into region
      0 and 1. Thus you'd have this mapping cluttered over all functions.
      And additionally, you'd first need to convert the mtd offsets
      addr=0 len=512 to addr=0x1000 and len=512.

-michael
