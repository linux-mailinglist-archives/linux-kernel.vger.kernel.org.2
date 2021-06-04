Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6308939BF9F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFDScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 14:32:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10293 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230149AbhFDScB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 14:32:01 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FxWXP21QWzBCRB;
        Fri,  4 Jun 2021 20:30:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id z-xbGY5bldfx; Fri,  4 Jun 2021 20:30:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FxWXP138vzBCMf;
        Fri,  4 Jun 2021 20:30:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0BD5F8B8AB;
        Fri,  4 Jun 2021 20:30:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OXzkfw8RMEpY; Fri,  4 Jun 2021 20:30:12 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 090148B885;
        Fri,  4 Jun 2021 20:30:11 +0200 (CEST)
Subject: Re: [PATCH 4/4] powerpc/32: Avoid #ifdef nested with FTR_SECTION on
 booke syscall entry
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <5ab3a517bc883a2fc905fb2cb5ee9344f37b2cfa.1622818435.git.christophe.leroy@csgroup.eu>
 <33db61d5f85146262dbe26648f8f87eca3cae393.1622818435.git.christophe.leroy@csgroup.eu>
 <8735tx4l6r.fsf@igel.home>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5025780f-0b42-b3c0-c01d-52d6602ea08e@csgroup.eu>
Date:   Fri, 4 Jun 2021 20:30:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <8735tx4l6r.fsf@igel.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/06/2021 à 19:02, Andreas Schwab a écrit :
> On Jun 04 2021, Christophe Leroy wrote:
> 
>> On booke, SYSCALL_ENTRY macro nests an FTR_SECTION with a
> 
> That sentence lacks an
> 


Argh !

It was ..... FTR_SECTION with a
#ifdef CONFIG_KVM_BOOKE_HV.

And git discarded the line starting with a #


Christophe
