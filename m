Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368C136CA51
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 19:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbhD0R1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 13:27:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46396 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230219AbhD0R1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 13:27:07 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FV7wF0dZ0z9sdJ;
        Tue, 27 Apr 2021 19:26:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RF203awGUF1B; Tue, 27 Apr 2021 19:26:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FV7wC2Fy3z9sdH;
        Tue, 27 Apr 2021 19:26:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A4778B827;
        Tue, 27 Apr 2021 19:26:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mcoIQKn9ZpfE; Tue, 27 Apr 2021 19:26:19 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9F5B28B80B;
        Tue, 27 Apr 2021 19:26:18 +0200 (CEST)
Subject: Re: PPC476 hangs during tlb flush after calling /init in crash kernel
 with linux 5.4+
To:     Eddie James <eajames@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com,
        miltonm@us.ibm.com
References: <b973fa4768140021719e7cc3123ee873d8b2a3f1.camel@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a24e9e0d-1d4f-506b-9303-4b995815d3c4@csgroup.eu>
Date:   Tue, 27 Apr 2021 19:26:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <b973fa4768140021719e7cc3123ee873d8b2a3f1.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddies,

Le 27/04/2021 à 19:03, Eddie James a écrit :
> Hi all,
> 
> I'm having a problem in simulation and hardware where my PPC476
> processor stops executing instructions after callling /init. In my case
> this is a bash script. The code descends to flush the TLB, and
> somewhere in the loop in _tlbil_pid, the PC goes to
> InstructionTLBError47x but does not go any further. This only occurs in
> the crash kernel environment, which is using the same kernel,
> initramfs, and init script as the main kernel, which executed fine. I
> do not see this problem with linux 4.19 or 3.10. I do see it with 5.4
> and 5.10. I see a fair amount of refactoring in the PPC memory
> management area between 4.19 and 5.4. Can anyone point me in a
> direction to debug this further? My stack trace is below as I can run
> gdb in simulation.

Can you bisect to pin point the culprit commit ?

Assuming the problem is in arch/powerpc/ , you should get the result in approx 10 steps:

[root@po15610vm linux-powerpc]# git bisect start -- arch/powerpc/
[root@po15610vm linux-powerpc]# git bisect bad v5.4
[root@po15610vm linux-powerpc]# git bisect good v4.19
Bisecting: 964 revisions left to test after this (roughly 10 steps)


Christophe
