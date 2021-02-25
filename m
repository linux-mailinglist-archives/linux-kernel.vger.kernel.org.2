Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC11324F36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhBYL3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:29:22 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51607 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235275AbhBYL3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:29:00 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lFEoa-0028Gb-MH; Thu, 25 Feb 2021 12:28:16 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lFEoa-002Ido-Gd; Thu, 25 Feb 2021 12:28:16 +0100
Subject: Re: [PATCH] [RFT] m68k: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <20210225111505.1936566-1-arnd@kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <f648b6fa-61c7-7d60-ba21-c1c759faf929@physik.fu-berlin.de>
Date:   Thu, 25 Feb 2021 12:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225111505.1936566-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On 2/25/21 12:14 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While experimenting with CONFIG_TRIM_UNUSED_KSYMS across architectures,
> I noticed that this unsurprisingly works best when combined with the
> --gc-sections linker flag, which is not currently allowed on m68k.
> 
> Enabling it with this patch shows significant improvements
> for kernel size, looking at m68k defconfig with gcc-10, I get
> 
> 4005135 1374302 167108 5546545 54a231 vmlinux-normal
> 3916254 1378078 167108 5461440 5355c0 vmlinux+trim
> 4012933 1362514 164280 5539727 54878f vmlinux+gcsection
> 3797884 1334194 164640 5296718 50d24e vmlinux+gcsection+trim
> 
> There are probably bugs somewhere, but if someone is able to test this
> patch and fix any issues that come up, would be a useful improvement
> for memory-limited machines.

Thanks, that sounds like a very helpful improvement. I'll test the patch next
week when I'm on vacation and report back if it works - unless someone beats
me to it ;-).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

