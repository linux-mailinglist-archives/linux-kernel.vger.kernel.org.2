Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECA2364536
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242193AbhDSNmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:42:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28307 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241320AbhDSNid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:38:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FP7DQ0MNQz9txvF;
        Mon, 19 Apr 2021 15:37:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id tq4_mdvpTVt5; Mon, 19 Apr 2021 15:37:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FP7DP5hbsz9txvC;
        Mon, 19 Apr 2021 15:37:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD5338B7BD;
        Mon, 19 Apr 2021 15:38:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BdXw8b78KlDs; Mon, 19 Apr 2021 15:38:02 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48A138B7B4;
        Mon, 19 Apr 2021 15:38:02 +0200 (CEST)
Subject: Re: [PATCH 2/2] powerpc: add ALTIVEC support to lib/ when PPC_FPU not
 set
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
References: <20210418201726.32130-1-rdunlap@infradead.org>
 <20210418201726.32130-2-rdunlap@infradead.org>
 <20210419133209.GR26583@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4f5aea37-f638-3fde-0680-ec456ad91141@csgroup.eu>
Date:   Mon, 19 Apr 2021 15:38:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419133209.GR26583@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/04/2021 à 15:32, Segher Boessenkool a écrit :
> Hi!
> 
> On Sun, Apr 18, 2021 at 01:17:26PM -0700, Randy Dunlap wrote:
>> Add ldstfp.o to the Makefile for CONFIG_ALTIVEC and add
>> externs for get_vr() and put_vr() in lib/sstep.c to fix the
>> build errors.
> 
>>   obj-$(CONFIG_PPC_FPU)	+= ldstfp.o
>> +obj-$(CONFIG_ALTIVEC)	+= ldstfp.o
> 
> It is probably a good idea to split ldstfp.S into two, one for each of
> the two configuration options?
> 

Or we can build it all the time and #ifdef the FPU part.

Because it contains FPU, ALTIVEC and VSX stuff.

Christophe
