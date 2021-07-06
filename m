Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EFB3BC751
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 09:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhGFHiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 03:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhGFHiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 03:38:11 -0400
X-Greylist: delayed 2173 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Jul 2021 00:35:33 PDT
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF17C061574;
        Tue,  6 Jul 2021 00:35:32 -0700 (PDT)
Received: from ip4d14bdef.dynamic.kabel-deutschland.de ([77.20.189.239] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1m0f36-0003rt-0K; Tue, 06 Jul 2021 08:59:16 +0200
To:     Jonathan Corbet <corbet@lwn.net>, Nishanth Menon <nm@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Rahul T R <r-ravikumar@ti.com>
References: <20210703012931.30604-1-nm@ti.com> <875yxokdd0.fsf@meer.lwn.net>
From:   Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH] LICENSES/dual/CC-BY-4.0: Lets switch to utf-8
Message-ID: <0a2d0601-3668-2e1a-b86d-f8336a502d9d@leemhuis.info>
Date:   Tue, 6 Jul 2021 08:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <875yxokdd0.fsf@meer.lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-BS
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1625556933;c72e8bf1;
X-HE-SMSGID: 1m0f36-0003rt-0K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.21 17:08, Jonathan Corbet wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
>> Lets drop the unicode characters that peeped in and replace with
>> equivalent utf-8 characters. This makes the CC-BY-4.0 file inline with
>> rest of license files.
>>
>> This messes up code such as scripts/spdxcheck.py which assumed utf-8
>> LICENSE files.
>>
>> Fixes: bc41a7f36469 ("LICENSES: Add the CC-BY-4.0 license")
> 
> So...this file *is* in UTF-8; I'm finding your changelog a bit
> confusing. 

Ahh, I'm not the only one here.

>> Cc: Thorsten Leemhuis <linux@leemhuis.info>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CC: Christoph Hellwig <hch@lst.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>>
>> Reported-by: Rahul T R <r-ravikumar@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>> also see: https://lore.kernel.org/linux-spdx/20210703012128.27946-1-nm@ti.com/T/#u
>>
>>  LICENSES/dual/CC-BY-4.0 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/LICENSES/dual/CC-BY-4.0 b/LICENSES/dual/CC-BY-4.0
>> index 45a81b8e4669..869cad3d1643 100644
>> --- a/LICENSES/dual/CC-BY-4.0
>> +++ b/LICENSES/dual/CC-BY-4.0
>> @@ -392,7 +392,7 @@ Section 8 -- Interpretation.
>>  Creative Commons is not a party to its public
>>  licenses. Notwithstanding, Creative Commons may elect to apply one of
>>  its public licenses to material it publishes and in those instances
>> -will be considered the “Licensor.” The text of the Creative Commons
>> +will be considered the "Licensor." The text of the Creative Commons

FWIW, I kinda like that the text (apart from the intro) up to now is
identical to the official license text (where I copied it from iirc when
I added it), but well, the type of quotes really shouldn't matter, so:

Acked-by: Thorsten Leemhuis <linux@leemhuis.info>

> It seems that what you're really doing is replacing "smart quotes" with
> the basic ASCII variety?  That seems like a fine thing to do, but that's
> not really what the changelog says.

Thx for handling this, Jon.

> [...]

Ciao, Thorsten
