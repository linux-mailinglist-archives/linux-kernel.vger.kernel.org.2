Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E622459D97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 09:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhKWIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 03:17:30 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:57331 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhKWIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 03:17:28 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 57CDB22236;
        Tue, 23 Nov 2021 09:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1637655259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8YlTsZ1TQpMTDF60AMdfQkK5116GkhxBH8+vfDb1M1s=;
        b=jdpRgLNMRWk4/kA5tgF9617poSyVMSIQieedRlkYAfssWL8h2rnzghWcjlfBhfzeufi4wW
        xP0HUCx/ZEcxaMFUMaYr9ofvGy2+19S51NItOPpfSKwM1WtLdOQcmGHM2tnVlilh7AnfcD
        kv4ri3lsa60HzH5lJILc9i3pP4d411Y=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Nov 2021 09:14:18 +0100
From:   Michael Walle <michael@walle.cc>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
In-Reply-To: <2bf37a35-1ccf-f4fa-c999-42b9154a2914@nokia.com>
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
 <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
 <e9589af968d7b9dafbce17325dbf8472@walle.cc>
 <2bf37a35-1ccf-f4fa-c999-42b9154a2914@nokia.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <88db136a146edf53801d86509b52d40f@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-11-23 08:45, schrieb Alexander Sverdlin:
> On 22/11/2021 16:05, Michael Walle wrote:
>>>>> Ignore 6th ID byte, secure version of mt25qu256a has 0x73 as 6th 
>>>>> byte.

>> You don't have the non-security part by chance?
> 
> Unfortunately no. And this is exactly the trigger for this patch:
> one can get "secure" parts from Micron even though these "features" are 
> not
> required.
> 
>> Mh, I'm undecided whether we should just duplicate the entry or if we
>> should ignore the last byte ("Device configuration information", where 
>> 00h
>> is standard). The commit which introduced the flash was 7f412111e276b.
>> Vingesh?
> 
> Some people ask themselves why this table keeps growing if there is 
> SFDP...
> I see the point in fixups, but maybe at some point we will be able to 
> support
> some devices just out of the box?

Are these features detectable by SFDP? Without knowing anything, as you 
ignored
my former question, I'd say no. So there will be two flashes, one with 
these
features and one without, both presumably have the same SFDP. Thus we'd 
need
these two entries anyway if we ever support these features. I get that 
this
might be under NDA, but then talk to Micron; I for myself can't get a 
complete
picture here.

>> Can you elaborate on the 0x73? Is that a bitmask? If it was an 
>> enumeration,
>> I'd assumed it would be 01h (or some smaller value).
> 
> This "security addendum" where one need NDA just says "73h = Secure".
> There is no explanation for it and no other variants.

Ok.

> I'd really suggest to try to autodetect whatever features are going to 
> be
> supported from this chip and only duplicate the entry if this 
> auto-detection
> fails.

There is a bigger patch series [1] from Tudor which you can try. You'd 
need to
respin your patch against that anyway.

-michael

[1] 
https://lore.kernel.org/linux-mtd/20211122095020.393346-1-tudor.ambarus@microchip.com/
