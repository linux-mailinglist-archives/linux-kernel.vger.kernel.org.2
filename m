Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D237409A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241318AbhIMRCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:02:38 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:40023 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239262AbhIMRCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:02:37 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H7XnC6dT6z9sTs;
        Mon, 13 Sep 2021 19:01:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hAPUdYAfKEbK; Mon, 13 Sep 2021 19:01:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H7XnC5qdqz9sTr;
        Mon, 13 Sep 2021 19:01:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B4FB38B76E;
        Mon, 13 Sep 2021 19:01:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id J5CWsERj56uu; Mon, 13 Sep 2021 19:01:19 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.172])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24FAC8B763;
        Mon, 13 Sep 2021 19:01:19 +0200 (CEST)
Subject: Re: [PATCH RESEND v3 4/6] signal: Add unsafe_copy_siginfo_to_user32()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
 <e1b94e52688cd99ed4a3ab86170cd9ec48849291.1631537060.git.christophe.leroy@csgroup.eu>
 <87r1dspj2c.fsf@disp2133>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <cf6e3669-1644-9611-6acc-781f46dd4f9e@csgroup.eu>
Date:   Mon, 13 Sep 2021 19:01:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87r1dspj2c.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/09/2021 à 17:54, Eric W. Biederman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> In the same spirit as commit fb05121fd6a2 ("signal: Add
>> unsafe_get_compat_sigset()"), implement an 'unsafe' version of
>> copy_siginfo_to_user32() in order to use it within user access blocks.
>>
>> To do so, we need inline version of copy_siginfo_to_external32() as we
>> don't want any function call inside user access blocks.
> 
> I don't understand.  What is wrong with?
> 
> #define unsafe_copy_siginfo_to_user32(to, from, label)	do {		\
> 	struct compat_siginfo __user *__ucs_to = to;			\
> 	const struct kernel_siginfo *__ucs_from = from;			\
> 	struct compat_siginfo __ucs_new;				\
> 									\
> 	copy_siginfo_to_external32(&__ucs_new, __ucs_from);		\
> 	unsafe_copy_to_user(__ucs_to, &__ucs_new,			\
> 			    sizeof(struct compat_siginfo), label);	\
> } while (0)

As far as I understood, it is forbidden to call functions within user 
access blocks.

On powerpc it doesn't matter (yet), but as far as I understand x86 as a 
tool called "objtool" to enforce that.


> 
> Your replacement of "memset(to, 0, sizeof(*to))" with
> "struct compat_siginfo __ucs_new = {0}".  is actively unsafe as the
> compiler is free not to initialize any holes in the structure to 0 in
> the later case.

Ah ? I didn't know that.
Maybe we can make as exception for memset(). Or we can hard-code a 
zeroizing loop.

> 
> Is there something about the unsafe macros that I am not aware of that
> makes it improper to actually call C functions?  Is that a requirement
> for the instructions that change the user space access behavior?

See see 
https://lore.kernel.org/lkml/20190318155142.025214872@infradead.org/T/ ?

> 
>  From the looks of this change all that you are doing is making it so
> that all of copy_siginfo_to_external32 is being inlined.  If that is not
> a hard requirement of the instructions it seems like the wrong thing to
> do here. copy_siginfo_to_external32 has not failures so it does not need
> to be inlined so you can jump to the label.

Yes that's what I did, make sure everything is inlined. Or maybe I 
misunderstood something ?

Christophe
