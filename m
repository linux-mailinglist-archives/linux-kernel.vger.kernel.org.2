Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1995832CBCB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 06:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbhCDFTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 00:19:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:43126 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234076AbhCDFTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 00:19:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 094B5AC54;
        Thu,  4 Mar 2021 05:18:26 +0000 (UTC)
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
From:   Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] x86/vdso: Use proper modifier for len's printf in extract
Message-ID: <1804463d-bb45-ea75-b4b0-1238c35638a0@suse.cz>
Date:   Thu, 4 Mar 2021 06:18:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210303183650.GG22305@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03. 03. 21, 19:36, Borislav Petkov wrote:
> On Wed, Mar 03, 2021 at 07:43:57AM +0100, Jiri Slaby wrote:
>> Commit 8382c668ce4f ("x86/vdso: Add support for exception fixup in vDSO
>> functions") added a printf of len which is size_t. Compilers now
>> complain on 32b:
>> In file included from arch/x86/entry/vdso/vdso2c.c:162:
>> arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
>> arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'}
>>
> 
> I know it is obvious but how do you trigger this?
> 
> A 32-bit allmodconfig with both debian's gcc-10 and leap15's gcc-7 don't
> trigger that warning. Which might answer your question why I haven't
> caught it yet. :-)

It was caught by suse's build bot while merging the stable branch. But 
it can be also seen in OBS in Kernel:stable:

https://build.opensuse.org/public/build/Kernel:stable/standard/i586/kernel-pae/_log
https://build.opensuse.org/public/build/Kernel:stable/standard/i586/kernel-vanilla/_log

It's built with gcc 10 from tumbleweed and it's a standard config from 
kerncvs:
https://github.com/openSUSE/kernel-source/blob/stable/config/i386/pae

thanks,
-- 
js
suse labs
