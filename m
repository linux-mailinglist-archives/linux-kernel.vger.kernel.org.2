Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBF32AE5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838219AbhCBXGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 18:06:30 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47199 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350401AbhCBWcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:32:43 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lHDYD-002Dns-Bl; Tue, 02 Mar 2021 23:31:33 +0100
Received: from dynamic-089-012-163-039.89.12.pool.telefonica.de ([89.12.163.39] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lHDYD-001ewM-4w; Tue, 02 Mar 2021 23:31:33 +0100
Subject: Re: 5.11 regression: "ia64: add support for TIF_NOTIFY_SIGNAL" breaks
 ia64 boot
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210222230519.73f3e239@sf>
 <cc658b61-530e-90bf-3858-36cc60468a24@kernel.dk>
 <8decdd2e-a380-9951-3ebb-2bc3e48aa1c3@physik.fu-berlin.de>
 <20210223083507.43b5a6dd@sf>
 <51cbf584-07ef-1e62-7a3b-81494a04faa6@physik.fu-berlin.de>
 <9441757f-d4bc-a5b5-5fb0-967c9aaca693@physik.fu-berlin.de>
 <20210223192743.0198d4a9@sf> <20210302222630.5056f243@sf>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <25dfced0-88b2-b5b3-f1b6-8b8a9931bf90@physik.fu-berlin.de>
Date:   Tue, 2 Mar 2021 23:31:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210302222630.5056f243@sf>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.12.163.39
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei!

On 3/2/21 11:26 PM, Sergei Trofimovich wrote:
> Gave v5.12-rc1 a try today and got a similar boot failure around
> hpsa queue initialization, but my failure is later:
>     https://dev.gentoo.org/~slyfox/configs/guppy-dmesg-5.12-rc1
> Maybe I get different error because I flipped on most debugging
> kernel options :)
> 
> Looks like 'ERROR: Invalid distance value range' while being
> very scary are harmless. It's just a new spammy way for kernel
> to report lack of NUMA config on the machine (no SRAT and SLIT
> ACPI tables).
> 
> At least I get hpsa detected on PCI bus. But I guess it's discovered
> configuration is very wrong as I get unaligned accesses:
>     [   19.811570] kernel unaligned access to 0xe000000105dd8295, ip=0xa000000100b874d1
> 
> Bisecting now.

Sounds good. I guess we should get Jens' fix for the signal regression
merged as well as your two fixes for strace.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

