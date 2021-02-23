Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC488322AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbhBWMhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:37:22 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:58401 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232535AbhBWMhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:37:15 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lEWvZ-00418i-0I; Tue, 23 Feb 2021 13:36:33 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lEWvY-001NIV-Qx; Tue, 23 Feb 2021 13:36:32 +0100
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
Message-ID: <9441757f-d4bc-a5b5-5fb0-967c9aaca693@physik.fu-berlin.de>
Date:   Tue, 23 Feb 2021 13:36:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <51cbf584-07ef-1e62-7a3b-81494a04faa6@physik.fu-berlin.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/21 10:13 AM, John Paul Adrian Glaubitz wrote:
> On 2/23/21 9:35 AM, Sergei Trofimovich wrote:> On Tue, 23 Feb 2021 00:55:50 +0100
>> John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:
>>
>>> For me, Debian also stopped booting on ia64 with systemd and I bisected it to this
>>> change. Glad to see I'm not the only one.
>>>
>>> The changes Jens suggested back then unfortunately didn't help :(.
>>
>> I wonder if systemd is less tolerant to kernel that throws signal 0 at it.
>>
>> Looks like https://marc.info/?l=linux-ia64&m=161404320617004&w=2
>> fixed all the issues for me.
> 
> Just gave it a try and it still doesn't work.

Maybe your other two patches to fix the strace issues are required as well?

Or do you happen to have more patches in the Gentoo kernel?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

