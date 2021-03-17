Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D83833F790
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhCQRxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:53:36 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:40109 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231458AbhCQRxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:53:07 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lMaLx-002sEs-H7; Wed, 17 Mar 2021 18:53:05 +0100
Received: from p5b13a966.dip0.t-ipconnect.de ([91.19.169.102] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lMaLx-003ykL-Ac; Wed, 17 Mar 2021 18:53:05 +0100
Subject: Re: 5.11 regression: "ia64: add support for TIF_NOTIFY_SIGNAL" breaks
 ia64 boot
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210222230519.73f3e239@sf>
 <cc658b61-530e-90bf-3858-36cc60468a24@kernel.dk>
 <8decdd2e-a380-9951-3ebb-2bc3e48aa1c3@physik.fu-berlin.de>
 <20210223083507.43b5a6dd@sf>
 <51cbf584-07ef-1e62-7a3b-81494a04faa6@physik.fu-berlin.de>
 <9441757f-d4bc-a5b5-5fb0-967c9aaca693@physik.fu-berlin.de>
 <20210223192743.0198d4a9@sf>
 <8d54dd1d-a035-8dff-64dc-7175aba6033f@physik.fu-berlin.de>
Message-ID: <c2098299-68c6-78da-da43-c848ee4eb7b0@physik.fu-berlin.de>
Date:   Wed, 17 Mar 2021 18:53:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8d54dd1d-a035-8dff-64dc-7175aba6033f@physik.fu-berlin.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.169.102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 3/17/21 6:42 PM, John Paul Adrian Glaubitz wrote:
>> Here are dmesg and config from my machine with successfull boot:
>>     https://dev.gentoo.org/~slyfox/configs/guppy-dmesg-5.11
>>     https://dev.gentoo.org/~slyfox/configs/guppy-config-5.11
> 
> Just gave it a try using this kernel configuration. It's never loading the hpsa
> module for me which I find really strange. The module isn't even showing up in
> the kernel message buffer.

Never mind. I just forgot to create an initrd this time, user error :-).

Works again.

>>> [    0.036000] ERROR: Invalid distance value range                                                            
>>> [    0.036000]                                                                                                
>>> [    0.036000]   00 00 00 00 00 00
>>
>> I don't see this string in the 5.11 kernel source. But
>>    https://lore.kernel.org/lkml/161356785681.20312.13022545187499987936.tip-bot2@tip-bot2/T/
>> hints it's might be something very new and you are in the
>> middle of 5.12-rc1?
> 
> I'm seeing this using your exact kernel configuration.

This issue is still there, however. Do you see this as well?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

