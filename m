Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F8329FD7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574701AbhCBDtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:49:00 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:51695 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240993AbhCAVcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 16:32:05 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4092622178;
        Mon,  1 Mar 2021 22:31:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1614634282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWINdudDzqzZoFPV0ShG63eP1okbuhfWlZ+qNnyijRc=;
        b=IT8WdaGeBuwrWPy2PNVkWjGoDTOsGzYM1/YrQzPn2UZ2e/n8opxN00vJRIcEG0+7vGV72n
        nMuflnhJJBn1jdXteMP+EP30ASPnPg4HnZZFM7vTTTjQn4A+Fu1bdoXJUAJpb0wL5GKG3M
        qskNpuLH4AJJAPjP5eEeuZWFt61LNkw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Mar 2021 22:31:22 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add OTP support
In-Reply-To: <7d1f770ae750d6ed5fb942b16979cdcb@walle.cc>
References: <20210216162807.13509-1-michael@walle.cc>
 <20210216162807.13509-2-michael@walle.cc>
 <d4f74b1b-fa1b-97ec-858c-d807fe1f9e57@microchip.com>
 <7d1f770ae750d6ed5fb942b16979cdcb@walle.cc>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a6ee55184d91fa1c1802bd82290407bd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-03-01 18:32, schrieb Michael Walle:
> Am 2021-02-28 13:00, schrieb Tudor.Ambarus@microchip.com:
>> On 2/16/21 6:28 PM, Michael Walle wrote:
>> Does the otp memory organization matter for the end user?
>> Can't we lock/read/write past region size, for example 2 or 3 regions 
>> in a row,
>> depending on length?
> 
> Mhh tough one. I guess the question really is: Do we want
> to remap the 0x1000, 0x2000, 0x3000 offsets?
>  - 0x1000 -> 0
>  - 0x2000 -> 1 * region_size
>  - 0x3000 -> 2 * region_size
> 
> This is just an example, some devices may us other offsets.
> 
> I'd see this as a prerequsite for handling multiple regions
> in one write, because otherwise you'll have to handle the
> holes which makes it impossible I guess. For example what
> would happen with (given an otp size of 0x100):
>  (1) lock(0, 0x100)
>  (2) lock(0x100, 0xf00)
>  (3) lock(0, 0x1000)
> 
> (1) will work, (2) should return -EINVAL; but what will (3)
> return. -EINVAL too, I guess. But then, ops spanning multiple
> regions doesn't make sense at all, because they will always
> return -EINVAL.
> 
> Unfortunately, I don't know how userspace might access it.
> 
> This is how it looks like at the moment:
> 
> # flash_otp_info -u /dev/mtd1
> Number of OTP user blocks on /dev/mtd1: 3
> block  0:  offset = 0x1000  size = 256 bytes  [unlocked]
> block  1:  offset = 0x2000  size = 256 bytes  [unlocked]
> block  2:  offset = 0x3000  size = 256 bytes  [unlocked]

Hm, I just found the following in the mtd-utils [1]:
"offset and size must match on OTP region boundaries".

[1] 
http://git.infradead.org/mtd-utils.git/blob/HEAD:/misc-utils/flash_otp_lock.c#l25

-michael
