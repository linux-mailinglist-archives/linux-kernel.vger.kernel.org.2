Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8583A7923
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFOIjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:39:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39453 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhFOIjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:39:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G41s909ymzB8nl;
        Tue, 15 Jun 2021 10:37:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id loeldhMZJ7mB; Tue, 15 Jun 2021 10:37:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G41s86Mh8zB8nf;
        Tue, 15 Jun 2021 10:37:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE8E98B7AE;
        Tue, 15 Jun 2021 10:37:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id u-FejpB8r5DM; Tue, 15 Jun 2021 10:37:16 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 70BB28B7A5;
        Tue, 15 Jun 2021 10:37:16 +0200 (CEST)
Subject: Re: [PATCH v2 2/4] powerpc/interrupt: Refactor
 prep_irq_for_user_exit()
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <809d316bf5f1a81acdd69e220c13e716dac24f53.1622818556.git.christophe.leroy@csgroup.eu>
 <3fbef68e1cffc0ebbbad1893e4fb9426b0915039.1622818556.git.christophe.leroy@csgroup.eu>
 <1623378421.ayihg84s3a.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4f21c7c2-d04b-dcb6-09ad-562a2c3cf88f@csgroup.eu>
Date:   Tue, 15 Jun 2021 10:37:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623378421.ayihg84s3a.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/06/2021 à 04:30, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of June 5, 2021 12:56 am:
>> prep_irq_for_user_exit() is a superset of
>> prep_irq_for_kernel_enabled_exit().
>>
>> Refactor it.
> 
> I like the refactoring, but now prep_irq_for_user_exit() is calling
> prep_irq_for_kernel_enabled_exit(), which seems like the wrong naming.
> 
> You could re-name prep_irq_for_kernel_enabled_exit() to
> prep_irq_for_enabled_exit() maybe? Or it could be
> __prep_irq_for_enabled_exit() then prep_irq_for_kernel_enabled_exit()
> and prep_irq_for_user_exit() would both call it.

I renamed it prep_irq_for_enabled_exit().

And I realised that after patch 4, prep_irq_for_enabled_exit() has become a trivial function used 
only once.

So I swapped patches 1/2 with patches 3/4 and added a 5th one to squash prep_irq_for_enabled_exit() 
into its caller.

You didn't have any comment on patch 4 (that is now patch 2) ?

Thanks for the review
Christophe
