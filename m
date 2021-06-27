Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F103B5548
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 23:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhF0Vuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 17:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhF0Vuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 17:50:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465D8C061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=MLYOvRltrGYGM4EErUig26MFb1BxTBtmWA+8vA4b6fk=; b=ObdtBRd5dreinSr7m66Tj19DHG
        vCxFWplGDpFhxejcNX6VmRzpDWrFaTO6ru4/lIBzAA1gro2L1Smdd43Gs51TiRlkvaLMnV5MShHad
        Bxk8r+mkFUKL732p6wtPrI/ejMgmjKnGIHIYVO0WKt22tAnpu9T9LQ3k1OwKB2+OZ38I8S+11krDe
        NE21B7UD4Ws6ey2Hgz8N3U7s+AjqyoUkd85vDMQSoJqSrnf0kub4N3FHQCZMLLi17ohNhnZxUKIG7
        eGlMKNGMA4317XKMsmul7mJ4UKTW7TjUsloRo/r1hPfkGDyY6OvfcNEdKE2lDeZVrv/abUu6PbNhI
        JgbyexMA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxccT-006AJv-My; Sun, 27 Jun 2021 21:47:13 +0000
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org, aou@eecs.berkeley.edu,
        arnd@arndb.de, bcain@codeaurora.org, benh@kernel.crashing.org,
        chris@zankel.net, dalias@libc.org, davem@davemloft.net,
        deanbo422@gmail.com, deller@gmx.de, geert@linux-m68k.org,
        gerg@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, palmerdabbelt@google.com,
        paulus@samba.org, paul.walmsley@sifive.com, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
References: <20210525140232.53872-1-mark.rutland@arm.com>
 <a15122e9-700d-c909-4794-d569ed1f6c61@infradead.org>
 <20210618084847.GA93984@C02TD0UTHF1T.local>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8a056e32-26bf-3038-984e-fcf8cac988d0@infradead.org>
Date:   Sun, 27 Jun 2021 14:47:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618084847.GA93984@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 1:48 AM, Mark Rutland wrote:
> On Fri, Jun 04, 2021 at 10:56:16PM -0700, Randy Dunlap wrote:
>> On 5/25/21 7:01 AM, Mark Rutland wrote:
>>> This series (based on v5.13-rc2) converts all architectures to
>>> ARCH_ATOMIC. This will allow the use of instrumented atomics on all
>>> architectures (e.g. for KASAN and similar), and simplifies the core
>>> atomic code (which should allow for easier rework of the fallbacks and
>>> other bits in future).
> 
> [...]
> 
>> Hi Mark,
>> Sorry for the late reply. 
> 
> Hi Randy,
> 
> Likewise, apologies in the delay in getting to this!
> 
>> I was just trying to update a patch
>> to arch/sh/include/asm/cmpxchg.h, in its xchg() macro:
>>
>> https://lore.kernel.org/lkml/20210602231443.4670-2-rdunlap@infradead.org/
>>
>> The patch simply converts xchg() to a GCC statement expression to
>> eliminate a build warning.

Hm, with your locking/atomic patch series applied (in linux-next), I can
no longer make arch/sh/ get this build warning:

../fs/ocfs2/file.c: In function 'ocfs2_file_write_iter':
../arch/sh/include/asm/cmpxchg.h:49:3: warning: value computed is not used [-Wunused-value]
   49 |  ((__typeof__(*(ptr)))__xchg((ptr),(unsigned long)(x), sizeof(*(ptr))))


so I will go ahead with the rest of my arch/sh/ patches and then contemplate
what to do about this one.


>> Arnd has done this for m68k and I have done it for sparc in the past.
>>
>> Is there any (good) reason that all versions of arch_xchg() are not
>> statement expressions?  In this patch series, they seem to be quite
>> mixed (as they were before this patch series). I count 11 arches
>> that use a statement expression and 4 that do not (including arch/sh/).
> 
> Largely I tried to make the minimal change from what was there before,
> and I didn't have any specific reason to either use or avoid statement
> expressions.
> 
> This series has been queued in the tip tree's locking/core branch for a
> while now, but we could spin a patch atop. Do you want to spin a patch
> to convert the remaining 4 architectures in one go?

I'll look at the 4 remaining arches later..

thanks.
-- 
~Randy

