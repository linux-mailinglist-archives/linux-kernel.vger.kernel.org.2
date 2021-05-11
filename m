Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA32379ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 06:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhEKEzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 00:55:22 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:49725 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhEKEzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 00:55:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FfQYx566Pz9sdc;
        Tue, 11 May 2021 06:54:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nHqyZRKRWhrq; Tue, 11 May 2021 06:54:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FfQYx48Qgz9sdb;
        Tue, 11 May 2021 06:54:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C0208B79E;
        Tue, 11 May 2021 06:54:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rTdXQYM9Q2Zd; Tue, 11 May 2021 06:54:13 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E958C8B766;
        Tue, 11 May 2021 06:54:12 +0200 (CEST)
Subject: Re: [PATCH] powerpc/legacy_serial: Fix UBSAN:
 array-index-out-of-bounds
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, pmenzel@molgen.mpg.de,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <d5e3c8e66bad3725d7d48d0e45c4b7eb7c02631d.1620455671.git.christophe.leroy@csgroup.eu>
 <20210510211444.GE10366@gate.crashing.org>
 <87sg2uxe7h.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c3d6c5c5-0eb8-bad5-91f9-fea01eaeef37@csgroup.eu>
Date:   Tue, 11 May 2021 06:54:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <87sg2uxe7h.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/05/2021 à 03:16, Michael Ellerman a écrit :
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> 
>> On Sat, May 08, 2021 at 06:36:21AM +0000, Christophe Leroy wrote:
>>> UBSAN complains when a pointer is calculated with invalid
>>> 'legacy_serial_console' index, allthough the index is verified
>>> before dereferencing the pointer.
>>
>> Addressing like this is UB already.
>>
>> You could just move this:
>>
>>> -	if (legacy_serial_console < 0)
>>> -		return 0;
>>
>> to before
>>
>>> -	struct legacy_serial_info *info = &legacy_serial_infos[legacy_serial_console];
>>> -	struct plat_serial8250_port *port = &legacy_serial_ports[legacy_serial_console];
>>
>> and no other change is necessary.
> 
> Yeah I sent a v2 doing that, thanks.
> 

I wanted something looking similar to setup_legacy_serial_console(), but of course this also works.

Christophe
