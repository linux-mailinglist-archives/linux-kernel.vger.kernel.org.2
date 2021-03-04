Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B632D13D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 11:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhCDK4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 05:56:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:51410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229436AbhCDK4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:56:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28D77AD21;
        Thu,  4 Mar 2021 10:55:19 +0000 (UTC)
Subject: Re: [PATCH] x86/vdso: Use proper modifier for len's printf in extract
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20210303064357.17056-1-jslaby@suse.cz>
 <20210303183650.GG22305@zn.tnic>
 <1804463d-bb45-ea75-b4b0-1238c35638a0@suse.cz>
 <20210304104853.GA15496@zn.tnic>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <f397fa13-5cec-ca09-7c5e-9e99c223bb24@suse.cz>
Date:   Thu, 4 Mar 2021 11:55:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210304104853.GA15496@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04. 03. 21, 11:48, Borislav Petkov wrote:
> On Thu, Mar 04, 2021 at 06:18:25AM +0100, Jiri Slaby wrote:
>> It's built with gcc 10 from tumbleweed and it's a standard config from
>> kerncvs:
>> https://github.com/openSUSE/kernel-source/blob/stable/config/i386/pae
> 
> Nope, can't trigger with that one either. :-\

Beware:
HOSTCC  arch/x86/entry/vdso/vdso2c
^^^^^^
You would need to _be_ on i586. Or try with -m32:

> gcc -m32 -Wp,-MMD,arch/x86/entry/vdso/.vdso2c.d -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89     -I/dev/shm/jslaby/linux/tools/include -I/dev/shm/jslaby/linux/include/uapi -I/dev/shm/jslaby/linux/arch/i386/include/uapi  -I ./arch/x86/entry/vdso   -o /dev/null /dev/shm/jslaby/linux/arch/x86/entry/vdso/vdso2c.c
> In file included from /dev/shm/jslaby/linux/arch/x86/entry/vdso/vdso2c.c:162:0:
> /dev/shm/jslaby/linux/arch/x86/entry/vdso/vdso2c.h: In function ‘extract64’:
> /dev/shm/jslaby/linux/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Wformat=]
>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>                                                   ~~^
>                                                   %u
> In file included from /dev/shm/jslaby/linux/arch/x86/entry/vdso/vdso2c.c:166:0:
> /dev/shm/jslaby/linux/arch/x86/entry/vdso/vdso2c.h: In function ‘extract32’:
> /dev/shm/jslaby/linux/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format ‘%lu’ expects argument of type ‘long unsigned int’, but argument 4 has type ‘size_t {aka unsigned int}’ [-Wformat=]
>   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
>                                                   ~~^
>                                                   %u

regards,
-- 
js
suse labs
