Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E601E409A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242502AbhIMRUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:20:46 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:34781 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhIMRUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:20:45 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H7YB812knz9sTs;
        Mon, 13 Sep 2021 19:19:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8hjOcyIZKiIB; Mon, 13 Sep 2021 19:19:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H7YB802nHz9sTr;
        Mon, 13 Sep 2021 19:19:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D9CE68B76E;
        Mon, 13 Sep 2021 19:19:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R5fl37EbeqzS; Mon, 13 Sep 2021 19:19:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.172])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E8738B763;
        Mon, 13 Sep 2021 19:19:27 +0200 (CEST)
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
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <96d06ad9-5a9b-b8c3-3c1d-ed8837091a60@csgroup.eu>
Date:   Mon, 13 Sep 2021 19:19:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87y280o38q.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/09/2021 à 18:21, Eric W. Biederman a écrit :
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>
>>> Use unsafe_copy_siginfo_to_user() in order to do the copy
>>> within the user access block.
>>>
>>> On an mpc 8321 (book3s/32) the improvment is about 5% on a process
>>> sending a signal to itself.
> 
> If you can't make function calls from an unsafe macro there is another
> way to handle this that doesn't require everything to be inline.
> 
>  From a safety perspective it is probably even a better approach.

Yes but that's exactly what I wanted to avoid for the native ppc32 case: 
this double hop means useless pressure on the cache. The siginfo_t 
structure is 128 bytes large, that means 8 lines of cache on powerpc 8xx.

But maybe it is acceptable to do that only for the compat case. Let me 
think about it, it might be quite easy.

Christophe
