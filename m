Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274153F81D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 06:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbhHZE4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 00:56:40 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:47249 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhHZE4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 00:56:39 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Gw9XR4Bclz9sV0;
        Thu, 26 Aug 2021 06:55:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wXGpXvuB0tMJ; Thu, 26 Aug 2021 06:55:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Gw9XR333yz9sTw;
        Thu, 26 Aug 2021 06:55:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 444C88B875;
        Thu, 26 Aug 2021 06:55:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xTJD91pQL4sF; Thu, 26 Aug 2021 06:55:51 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E11DD8B774;
        Thu, 26 Aug 2021 06:55:50 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Make set_endian() return EINVAL when not
 supporting little endian
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <b29c29d205737a833262df38e01c07139f1c3dec.1629899011.git.christophe.leroy@csgroup.eu>
 <87bl5kc1os.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <df2e9b65-9303-070e-b803-c64e20e2620d@csgroup.eu>
Date:   Thu, 26 Aug 2021 06:55:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87bl5kc1os.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/08/2021 à 05:41, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> There is no point in modifying MSR_LE bit on CPUs not supporting
>> little endian.
> 
> Isn't that an ABI break?

Or an ABI fix ? I don't know.

My first thought was that all other 32 bits architectures were returning -EINVAL, but looking at the 
man page of prctl, it is explicit that this is powerpc only.

> 
> set_endian(PR_ENDIAN_BIG) should work on a big endian CPU, even if it
> does nothing useful.

Fair enough. But shouldn't in that case get_endian() return PR_ENDIAN_BIG instead of returning EINVAL ?

We can do one or the other, but I think it should at least be consistant between them, shouldn't it ?

Christophe
