Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0069F3A2F39
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhFJPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:25:35 -0400
Received: from mx2.cyber.ee ([45.144.6.23]:53003 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230329AbhFJPZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:25:33 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 11:25:33 EDT
Subject: Re: linux-parisc compile failure in current git
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <892b6ab7-862c-1c0a-2996-0f8408e5043d@linux.ee>
 <89515325-fc21-31da-d238-6f7a9abbf9a0@gmx.de>
 <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <946c5f64-5cca-2395-5e69-6e573ea6a72b@linux.ee>
Date:   Thu, 10 Jun 2021 18:13:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATuzry1MUj-VruOVUwU_nH2xJd_2SxD_s_Z1QBb3PVnQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



10.06.21 05:03 Masahiro Yamada wrote:
> There are some options
> 
> [option 1]
>    revert the parisc bit of 23243c1ace9fb4eae2f75e0fe0ece8e3219fb4f3
>    This will restore the functionality you may want, but
>    as I said above, Kconfig is doing pointless things.
> 
> [option 2]
>     Stop using cc-cross-prefix, and pass CROSS_COMPILE explicitly.
>     This is what many architectures including arm, arm64 do.
>     You need to explicitly pass CROSS_COMPILE=aarch64-linux-gnu- etc.
>     if you are cross-compiling arm64.
> 
> [option 3]
>     Introduce ARCH=parisc64.
> 
>     When you are building 64-bit kernel, you can pass ARCH=parisc64
> 
>      A patch attached.  (but not tested much)

Tested on my gentoo with separate compilers. Compiles fine, boots and has so far compiled 21 paxkageswith no trouble so seems to work - thank you!

-- 
Meelis Roos <mroos@linux.ee>
