Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F7140B018
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhINOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:02:19 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:43871 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232682AbhINOCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:02:16 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H84kf3qLwz9sSh;
        Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LUdiTfEngcWB; Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H84kf2vLqz9sSS;
        Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 51B8F8B773;
        Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Sfnj682Q6TWA; Tue, 14 Sep 2021 16:00:58 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.207])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A23B8B763;
        Tue, 14 Sep 2021 16:00:57 +0200 (CEST)
Subject: Re: [PATCH RESEND v3 6/6] powerpc/signal: Use
 unsafe_copy_siginfo_to_user()
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, hch@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1718f38859d5366f82d5bef531f255cedf537b5d.1631537060.git.christophe.leroy@csgroup.eu>
 <2b179deba4fd4ec0868cdc48a0230dfa3aa5a22f.1631537060.git.christophe.leroy@csgroup.eu>
 <87h7eopixa.fsf@disp2133> <87y280o38q.fsf@disp2133>
 <96d06ad9-5a9b-b8c3-3c1d-ed8837091a60@csgroup.eu> <87ilz4mgts.fsf@disp2133>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <00226633-0a5a-bcca-0a2a-9bfd754e61a5@csgroup.eu>
Date:   Tue, 14 Sep 2021 16:00:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87ilz4mgts.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/09/2021 à 21:11, Eric W. Biederman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> Le 13/09/2021 à 18:21, Eric W. Biederman a écrit :
>>> ebiederm@xmission.com (Eric W. Biederman) writes:
>>>
>>>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>>>
>>>>> Use unsafe_copy_siginfo_to_user() in order to do the copy
>>>>> within the user access block.
>>>>>
>>>>> On an mpc 8321 (book3s/32) the improvment is about 5% on a process
>>>>> sending a signal to itself.
>>>
>>> If you can't make function calls from an unsafe macro there is another
>>> way to handle this that doesn't require everything to be inline.
>>>
>>>   From a safety perspective it is probably even a better approach.
>>
>> Yes but that's exactly what I wanted to avoid for the native ppc32 case: this
>> double hop means useless pressure on the cache. The siginfo_t structure is 128
>> bytes large, that means 8 lines of cache on powerpc 8xx.
>>
>> But maybe it is acceptable to do that only for the compat case. Let me think
>> about it, it might be quite easy.
> 
> The places get_signal is called tend to be well known.  So I think we
> are safe from a capacity standpoint.
> 
> I am not certain it makes a difference in capacity as there is a high
> probability that the stack was deeper recently than it is now which
> suggests the cache blocks might already be in the cache.
> 
> My sense it is worth benchmarking before optimizing out the extra copy
> like that.
> 
> On the extreme side there is simply building the entire sigframe on the
> stack and then just calling it copy_to_user.  As the stack cache lines
> are likely to be hot, and copy_to_user is quite well optimized
> there is a real possibility that it is faster to build everything
> on the kernel stack, and then copy it to the user space stack.
> 
> It is also possible that I am wrong and we may want to figure out how
> far up we can push the conversion to the 32bit siginfo format.
> 
> If could move the work into collect_signal we could guarantee there
> would be no extra work.  That would require adjusting the sigframe
> generation code on all of the architectures.
> 
> There is a lot we can do but we need benchmarking to tell if it is
> worth it.
> 


Sure, I'm benchmarking all the work I have been doing on signal code 
with the following simple app that I run with 'perf stat':

#include <stdlib.h>
#include <signal.h>

void sigusr1(int sig) { }

int main(int argc, char **argv)
{
	int i = 100000;

	signal(SIGUSR1, sigusr1);
	for (;i--;)
	raise(SIGUSR1);
	exit(0);
}


On an mpc8321 a 32 bits powerpc with KUAP enabled (KUAP is equivalent of 
x86 SMAP)

Before changing copy_siginfo_to_user() to unsafe_copy_siginfo_to_user(), 
'perf stat' reports 1983 msec (task-clock)

After my change I get 1900 msec.

With your approach I get 1930 msec, so we are loosing 36% of the benefit 
of converting to the 'unsafe_' alternative.

So I think it is worth it.

Christophe
